/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.log4j.Logger;
import org.omegabase.bean.AppBean;
import org.omegabase.bean.ConnBean;
import org.omegabase.bean.SessionBean;

/**
 *
 * @author Raphael
 */
@WebServlet(name = "SyncroZipWs", urlPatterns = {"/syncrozip"})
@MultipartConfig
public class SyncroZipWs extends HttpServlet {
    
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
        response.setContentType("text/csv;charset=UTF-8");
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
            Part p = request.getPart("att");
            String category = (request.getParameter("category"));
            String status = request.getParameter("status");

            if (status!=null&&status.length()>0&&category!=null&&ses.getIdUser()!=0) {
                    conn.doSyncroZip(
                            p.getInputStream(),
                            Integer.parseInt(category),
                            status.charAt(0),
                            out,
                            app);
                
                
            }
            
        } catch(SQLException ex) {
            Logger.getLogger(SyncroZipWs.class).error(ex);
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
        return "Short description";
    }// </editor-fold>

}
