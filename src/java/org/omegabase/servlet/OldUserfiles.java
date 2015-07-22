/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.omegabase.bean.Lang;

/**
 *
 * @author raphael
 */
@WebServlet(name = "OldUserfiles", urlPatterns = {"/userfiles/*"})
public class OldUserfiles extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");
        String str = request.getPathInfo();
        
        
        StringTokenizer token = new StringTokenizer(str, "/");
        
        if (token.countTokens()<2) {
            response.sendError(500);
            return;
            
        }
        
//        token.nextToken();
        String iddoc = token.nextToken();
        String folder = token.nextToken();
        String name = token.nextToken();
        
        if (iddoc.startsWith("o")) {
            getServletContext().getRequestDispatcher("/callspblob/"+name+"?func=wsb_get_old_attach&i0="+iddoc.substring(1)+"&s1="+folder+"&s2="+name+"&i3=1").forward(request, response);
        
        } else {
            getServletContext().getRequestDispatcher("/callspblob/"+name+"?func=wsb_get_attach&i0="+iddoc+"&s1="+folder+"&s2="+name).forward(request, response);
        }
    
        //response. (getServletContext().getContextPath()+"/callspblob/"+name+"?func=wsb_get_attach&i0="+iddoc+"&s1="+folder+"&s2="+name);
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
