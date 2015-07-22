package org.omegabase.servlet;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.log4j.Logger;
import org.omegabase.bean.ConnBean;
import org.omegabase.bean.SessionBean;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet(name = "CallSPBLob", urlPatterns = {"/callspblob/*"})
public class CallSPBlob extends HttpServlet {

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
        
        String func = request.getParameter("func");
        
        if (func==null||!func.startsWith("wsb_")||!ServletUtils2.isSpCompliant(func)) {
            response.sendError(500);
            return;
        }
        
        
           
            SessionBean ses = (SessionBean)request.getSession().getAttribute("ses");
            
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
            
            
            String p = null;
            
            try {
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
                }
               
                
                i++;
            } while(p!=null);
            } catch(Exception ex) {
                response.sendError(500);
                return;
            }
            
            InputStream blob = null;
            try {
                blob = conn.selectBlob(func);
                response.setContentType(getServletContext().getMimeType(conn.getBlobName()));
                //response.setHeader("Content-Disposition", "attachment; filename=\""+conn.getBlobName()+"\"");
            } catch (SQLException ex) {
                Logger.getLogger(CallSPBlob.class).error(ex);
            }
            
            if (blob!=null) {
                ServletUtils2.copyBlobs(blob, response.getOutputStream());
                blob.close();
            }
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
