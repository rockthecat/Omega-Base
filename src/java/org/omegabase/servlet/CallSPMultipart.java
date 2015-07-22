package org.omegabase.servlet;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.CharArrayWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.omegabase.bean.AppBean;
import org.omegabase.bean.ConnBean;
import org.omegabase.bean.SessionBean;
import org.omegabase.indexer.OmegaIndexer;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet(name = "CallSPMultipart", urlPatterns = {"/callspmultipart"})
@MultipartConfig
public class CallSPMultipart extends HttpServlet {

    public boolean check(Part p, AppBean b) {
        if (p.getSize()>1024*1024*Long.parseLong(b.getConfiguration().get("max_att_size"))) {
            return false;
        }
        return true;
    } 
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/xml;charset=UTF-8");
        String func = request.getParameter("func");
        
        if (func==null||!func.startsWith("ws_")||!ServletUtils2.isSpCompliant(func)) {
            response.sendError(500);
            return;
        }
        
        
        try  {
            PrintWriter out = response.getWriter();
            
            SessionBean ses = (SessionBean)request.getSession().getAttribute("ses");
            AppBean app = (AppBean)request.getServletContext().getAttribute("app");
            
            
            if(ses==null) {
                ses = new SessionBean();
                request.getSession().setAttribute("ses", ses);
            }
        
            int i = 0;
            
            ConnBean conn = new ConnBean();
            conn.setHostAddr(request.getRemoteHost());
            
            String l = "en";
            Cookie []cs = request.getCookies();
        
            if (cs!=null)
            for(Cookie c: cs) {
                if (c.getName().equals("L_omega_lang")) {
                    l = c.getValue();
                    break;
                }
            }
            conn.setLang(l);
            conn.setSession(ses);
            
            if (app==null) {
                app = new AppBean();
                app.setConn(conn);
                request.getServletContext().setAttribute("app", app);
            }
            
            String p = null;
            Part pa = null;
            
            do {
                p = null;
                
               if ((p = request.getParameter("s"+i))!=null) {
                    conn.push(p);
                } else if ((p = request.getParameter("i"+i))!=null) {
                    conn.pushi(Integer.parseInt(p));
                } else if ((p = request.getParameter("b"+i))!=null) {
                    conn.pushb(!p.equals(""));
                } else if ((p = request.getParameter("t"+i))!=null) {
                    conn.pusht(p);
                } else if ((p = request.getParameter("d"+i))!=null) {
                    conn.pushd(p);
                } else if ((p = request.getParameter("tt"+i))!=null) {
                    conn.pushtt(p);
                } else if ((pa = request.getPart("bl"+i))!=null) {
                    
                    if (!check(pa, app)) {
                        response.sendError(500);

                        return ;
                    }
                    String name = ServletUtils2.getFileName(pa);
                    byte []tmp = ServletUtils2.saveBlob2(pa.getInputStream());
                    
                    conn.push(name);
                    conn.pushin(tmp);
                    conn.push(OmegaIndexer.extractFile(new ByteArrayInputStream(tmp), name));
                    p = "bl";
                }
               
                
                i++;
            } while(p!=null);
            
            try { 
                conn.select(func);
            
            } catch (SQLException ex) {
                response.sendError(500);
                return;
            }
            
            
            
            } catch(Exception ex) {
                response.sendError(500);
                return;
            }
            
            
            response.sendRedirect(request.getHeader("referer"));
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to call Stored Procedures";
    }// </editor-fold>

}
