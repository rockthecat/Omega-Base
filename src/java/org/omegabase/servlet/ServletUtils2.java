/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.servlet;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;
import javax.servlet.http.Part;
import org.apache.log4j.Logger;

/**
 *
 * @author raphael
 */
public class ServletUtils2 {
    
    public static String html(String s) {
        if (s==null) {
            return "";
        }
        
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&squot;");
    }
    
    public static boolean isSpCompliant(String func) {
        for (char c: func.toCharArray()) {
            if (!Character.isLetterOrDigit(c)&&c!='_') {
                return false;
            }
        }
        
        return true;
    }
    
    
    public static String getFileName(Part part) {
        String partHeader = part.getHeader("content-disposition");
        for (String cd : partHeader.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String str = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                int i = str.lastIndexOf('\\');
                
                if (i!=-1) {
                    str = str.substring(i+1);
                }
                
                return str;
            }
        }
        return null;
    }
    
    public static void copyBlobs(InputStream in, OutputStream out) throws IOException {
        int read;
        byte []buf = new byte[8192];
        
        while((read = in.read(buf))!=-1) {
            out.write(buf, 0, read);
        }
    }
    
    public static byte[] saveBlob2(InputStream blob) {
        try {
            ByteArrayOutputStream fout = new ByteArrayOutputStream();
            
            try {
                copyBlobs(blob, fout);
            } finally {
                blob.close();
            }
            
            return fout.toByteArray();
            
        } catch (IOException ex) {
            Logger.getLogger(ServletUtils2.class).error(ex);
            return null;
        }
    }
    
    
    public static File saveBlob(InputStream blob) {
        try {
            File tmp = File.createTempFile("blob", ".tmp");
            OutputStream fout = new BufferedOutputStream(new FileOutputStream(tmp));
            
            try {
            copyBlobs(blob, fout);
            } finally {
                blob.close();
                fout.close();
            }
            
            
            return tmp;
            
        } catch (IOException ex) {
            Logger.getLogger(ServletUtils2.class).error(ex);
            return null;
        }
    }
    
    
    public static class HandlerInputStream extends FileInputStream {
        private File t;
        
        public HandlerInputStream(File t) throws FileNotFoundException {            
            super(t);
            this.t = t;

        }
        
        @Override
        public void close() throws IOException {
            try {
                super.close();
            } finally {
                t.delete();
            }
        }
    }
}
