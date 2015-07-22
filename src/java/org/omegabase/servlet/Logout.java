/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.omegabase.bean.ConnBean;
import org.omegabase.bean.Lang;
import org.omegabase.bean.SessionBean;

/**
 *
 * @author raphael
 */
@WebServlet(name = "Logout", urlPatterns = {"/logout"})
public class Logout extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        
        SessionBean ses = (SessionBean)session.getAttribute("ses");
        
        if (ses!=null) {
            
        ConnBean conn = new ConnBean();
        conn.setHostAddr(request.getRemoteAddr());
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
            try {
                conn.selectOne("make_logout");
            } catch (SQLException ex) {
                Logger.getLogger(Logout.class.getName()).log(Level.SEVERE, null, ex);
            }
        String cap = ses.getCaptcha();
        
        session.setAttribute("ses", null);
        
        ses = new SessionBean();
        ses.setCaptcha(cap);
        session.setAttribute("ses", ses);
        }
        response.sendRedirect("index.jsp");
       
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
        return "Short description";
    }// </editor-fold>

}
