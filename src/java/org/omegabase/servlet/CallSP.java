package org.omegabase.servlet;

import java.io.CharArrayWriter;
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
import org.omegabase.bean.AppBean;
import org.omegabase.bean.ConnBean;
import org.omegabase.bean.SessionBean;
import org.omegabase.utils.Conv;
import org.omegabase.utils.Mail;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet(name = "CallSP", urlPatterns = {"/callsp"})
public class CallSP extends HttpServlet {

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
                
                if (i==2&&func.equals("ws_login")) {
                    p = ses.getCaptcha();
                    conn.push(p);
                    if (p==null) {
                        p = "";
                    }
                } else if ((p = request.getParameter("s"+i))!=null) {
                    conn.push(p);
                } else if ((p = request.getParameter("i"+i))!=null) {
                    try {
                    conn.pushi(Integer.parseInt(p));
                    } catch(Exception ex)
                    {
                        conn.pushi(0);
                    }
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
            
            List<Map<String, String>> lmap = new ArrayList<Map<String, String>>();
            try {
                lmap = conn.select(func);
            } catch (SQLException ex) {
                
            }
            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
 
            Document doc = docBuilder.newDocument();
            Element rootElement = doc.createElement(func);
	    doc.appendChild(rootElement);
 
            if (conn.getErrorMsg()!=null) {
                Element row = doc.createElement("error");
                int ierror = conn.getErrorMsg().indexOf("\n");
                
                if (ierror==-1) {
                    row.setTextContent(conn.getErrorMsg());
                } else {
                    row.setTextContent(conn.getErrorMsg().substring(0, ierror));
                }
                rootElement.appendChild(row);
               
            } else {            
            for(Map<String, String> map: lmap) {
                Element row = doc.createElement("row");
                rootElement.appendChild(row);
                
                for(Map.Entry<String, String> entry: map.entrySet()) {
                    Element el = doc.createElement(entry.getKey());
                    String v = entry.getValue();
                    
                    if (v!=null) {
                        el.setTextContent(v);
                        row.appendChild(el);
                    }
                }
            }
            }
            
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
	    DOMSource source = new DOMSource(doc);
            
	    StreamResult result = new StreamResult(out);
 
       	transformer.transform(source, result);
        
        if ((func.equals("ws_login")||func.equals("ws_auto_new_user"))&&doc.getElementsByTagName("error").getLength()==0) {
            ses.setIdUser(Integer.parseInt(doc.getElementsByTagName("id").item(0).getTextContent()));
            ses.setUsername(doc.getElementsByTagName("name").item(0).getTextContent());
            ses.setIdGroup(Integer.parseInt(doc.getElementsByTagName("id_group").item(0).getTextContent()));
            ses.setSuperUser(doc.getElementsByTagName("superusr").item(0).getTextContent().equals("t"));
            ses.setAdmUsers(doc.getElementsByTagName("admusers").item(0).getTextContent().equals("t"));
            ses.setCaptcha(null);
        } else if (func.equals("ws_login")) {
            ses.setRandCaptcha();
        } else if (func.equals("ws_save_configuration")&&doc.getElementsByTagName("error").getLength()==0) {
            AppBean app = (AppBean)request.getServletContext().getAttribute("app");
            
            if (app==null) {
                app = new AppBean();
            }
            
            app.setConn(conn);
            request.getServletContext().setAttribute("app", app);
        } else if (func.equals("ws_add_comment")&&doc.getElementsByTagName("error").getLength()==0&&doc.getElementsByTagName("catname").getLength()!=0) {
            AppBean app = (AppBean)request.getServletContext().getAttribute("app");
            
            if (app==null) {
                app = new AppBean();
                app.setConn(conn);
            }
            
            int docid = Integer.parseInt(request.getParameter("i0"));
            String msg = request.getParameter("s1");
            String catname = doc.getElementsByTagName("catname").item(0).getTextContent();
            String docname = doc.getElementsByTagName("docname").item(0).getTextContent();
            String email = doc.getElementsByTagName("email").item(0).getTextContent();
                        
            if (email!=null&&!email.trim().equals("")) {
                Mail.mail(app.getConfiguration(), email, "Omega Base - Document ("+docid+") received a comment.", msg+"<br><br><a href='http://"+ request.getLocalName()+":"+request.getLocalPort()+"/omegabase/view.jsp?id="+docid+"'>"+Conv.toXml(docname)+"</a>");
            }
        }
            
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(CallSP.class.getName()).log(Level.SEVERE, null, ex);
        } catch (TransformerConfigurationException ex) {
            Logger.getLogger(CallSP.class.getName()).log(Level.SEVERE, null, ex);
        } catch (TransformerException ex) {
            Logger.getLogger(CallSP.class.getName()).log(Level.SEVERE, null, ex);
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
