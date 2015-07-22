/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.omegabase.bean;

/**
 *
 * @author raphael
 */
public class SessionBean {
    private int idUser;
    private int idGroup;
    private String username, captcha;
    private boolean mobile = false;
    private boolean superUser = false;
    private boolean admUsers = false;
    
    public String getTomcatHome() {
        return System.getProperty("catalina.home");
    }

    private static final String alpha = 
            "abcdefghijklmnopqrstuvxyzw"+
            "ABCDEFGHIJKLMNOPQRSTUVXYZW"+
            "0123456789";
    
    public void setRandCaptcha() {
        StringBuilder buf = new StringBuilder();
        
        for(int i=0;i<7;i++) {
            double ch = Math.random()*alpha.length();
            int c = (int)Math.round(ch);
        
            buf.append(alpha.charAt(c < alpha.length()?c:alpha.length()-1));
        }
        
        captcha = buf.toString();
    }
    
    
    /**
     * @return the idUser
     */
    public int getIdUser() {
        return idUser;
    }

    /**
     * @param idUser the idUser to set
     */
    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    
    /**
     * @return the username
     */
    public String getUsername() {
            return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the captcha
     */
    public String getCaptcha() {
        return captcha;
    }

    /**
     * @param captcha the captcha to set
     */
    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    /**
     * @return the idGroup
     */
    public int getIdGroup() {
        return idGroup;
    }

    /**
     * @param idGroup the idGroup to set
     */
    public void setIdGroup(int idGroup) {
        this.idGroup = idGroup;
    }

    /**
     * @return the mobile
     */
    public boolean isMobile() {
        return mobile;
    }

    /**
     * @param mobile the mobile to set
     */
    public void setMobile(boolean mobile) {
        this.mobile = mobile;
    }

    /**
     * @return the superUser
     */
    public boolean isSuperUser() {
        return superUser;
    }

    /**
     * @param superUser the superUser to set
     */
    public void setSuperUser(boolean superUser) {
        this.superUser = superUser;
    }

    /**
     * @return the admUsers
     */
    public boolean isAdmUsers() {
        return admUsers;
    }

    /**
     * @param admUsers the admUsers to set
     */
    public void setAdmUsers(boolean admUsers) {
        this.admUsers = admUsers;
    }

    
    
    
    
}
