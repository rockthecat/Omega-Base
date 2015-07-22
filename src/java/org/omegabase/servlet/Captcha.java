
package org.omegabase.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.omegabase.bean.SessionBean;

@WebServlet(name = "Captcha", urlPatterns = {"/captcha.jpg"})
public class Captcha extends HttpServlet {

        
    
    private int getRand255() {
        double r = Math.random()*255;
        return(int)Math.round(r);
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
        response.setContentType("image/jpeg");
        SessionBean ses = (SessionBean)request.getSession().getAttribute("ses");
        
        if (ses==null||ses.getCaptcha()==null) {
            return;
        }
        
        BufferedImage img = new BufferedImage(180, 48, BufferedImage.TYPE_INT_RGB);
        int cx = 180 / 8;
        Graphics2D gr = (Graphics2D)img.getGraphics();
        Font fnt = new Font("Courier", 0, 32);
        
        gr.setColor(Color.black);
        gr.fillRect(0, 0, 180, 48);
        
        gr.setColor(Color.white);
        gr.translate(cx, 24);
        for(char c: ses.getCaptcha().toCharArray()) {
            AffineTransform at = new AffineTransform();
            //AffineTransform orig = gr.getTransform();
            
            //at.setToTranslation(i*cx, 34);
            at.setToIdentity();
            at.setToRotation(Math.toRadians(Math.random()*90));
            //gr.setTransform(at);
            gr.setColor(new Color(getRand255(), getRand255(), getRand255()));            
            gr.setFont(fnt.deriveFont(at));
            gr.drawString(String.valueOf(c), 0, 0);
            gr.translate(cx, 0);
            //gr.setTransform(orig);
        }
        
        
//        gr.setTransform(new AffineTransform());
//        gr.setColor(Color.white);
        
//        gr.drawLine(0, 24, 180, 24);
//        gr.drawLine(0, 10, 180, 38);
//       gr.drawLine(0, 38, 180, 10);
        
        
        ImageIO.write(img, "JPEG", response.getOutputStream());
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
