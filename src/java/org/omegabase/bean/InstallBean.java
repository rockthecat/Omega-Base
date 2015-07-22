package org.omegabase.bean;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.omegabase.servlet.ServletUtils2;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class InstallBean {
    private String catalinaHome = System.getProperty("catalina.home");
    private String catalineEngineFolder = "conf/Catalina/localhost";
    private String context;
    
    private String dbSuperuser = "postgres", dbSuperuserPass;
    private String dbHost = "localhost", dbUser, dbPass, dbDb;
    private int dbPort = 5432;
    
    
    private boolean tryCreateDb() {
        Connection c = Conn.connectDirect(this.dbHost,this.dbSuperuser,this.dbSuperuser,this.dbSuperuserPass,this.dbPort);
        
        if (c==null) {
            return false;
        }
        
        try {
            try {
                c.setAutoCommit(true);
                PreparedStatement ps = c.prepareStatement("create user "+this.dbUser+" with password ?");
                ps.setString(1, this.dbPass);
                ps.executeUpdate();
                
            } catch(SQLException ex) {
            }
            
             try {
                Statement st = c.createStatement();
                st.executeUpdate("create database "+this.dbDb+" with owner = "+this.dbUser);
            } catch(SQLException ex) {
            }
             c.close();
             
             return true;
        } catch(SQLException ex) {
            return false;
        }
    }
    
public void updateDatabase() throws FileNotFoundException, IOException, SQLException {
    StringBuilder buf = new StringBuilder();
    
    buf.append(
"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<Context antiJARLocking=\"true\" >\n" +
"<Resource auth=\"Container\" defaultAutoCommit=\"false\" driverClassName=\"org.postgresql.Driver\" logAbandoned=\"true\" maxActive=\"20\" maxWait=\"10000\" minIdle=\"10\" name=\"jdbc/Prisma\" password=\""+
        ServletUtils2.html(this.getDbPass())+
        "\" removeAbandoned=\"true\" removeAbandonedTimeout=\"60\" type=\"javax.sql.DataSource\" url=\"jdbc:postgresql://"+
        ServletUtils2.html(this.getDbHost())+
        ":"+this.getDbPort()+
        "/"+ServletUtils2.html(this.getDbDb())+
        "\" username=\""+
        ServletUtils2.html(this.getDbUser())+
        "\" validationQuery=\"SELECT 1\" />\n" +
"</Context>\n" +
"");
    
    /*
    BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(
            this.getCatalinaHome()+File.separator+
            this.getCatalineEngineFolder()+File.separator+
            this.context.substring(1)+".xml"));
    
    try {
        byte []buf_utf8 = buf.toString().getBytes("UTF-8");
        
        out.write(buf_utf8);
    } finally {
        out.close();
    }*/
    
    int dbversion = Conn.detectDbVersion(this.dbHost,this.dbDb,this.dbSuperuser,this.dbSuperuserPass,this.dbPort);
    
    if (dbversion!=-1||tryCreateDb()) {
        Connection c = Conn.connectDirect(this.dbHost,this.dbDb,this.dbSuperuser,this.dbSuperuserPass,this.dbPort);
        try {
        
        c.close();
        c = Conn.connectDirect(this.dbHost,this.dbDb,this.dbUser,this.dbPass,this.dbPort);
        c.setAutoCommit(false);
        Statement st = c.createStatement();
        
        for(List<String> sqls = loadFile(dbversion); sqls!=null; dbversion++) {
            for(String sql: sqls) {
                st.executeUpdate(sql);
            }
        }
        
        c.commit();
        
        } finally {
            if (c!=null) {
                c.close();
            }
        }
    }
}
    
    private List<String> loadFile(int dbversion) throws IOException {
        URL url = InstallBean.class.getResource("/org/omegabase/sql/omegabase-"+dbversion+".sql");
        List<String> ret = new ArrayList<String>();
        
        if (url!=null) {
        StringBuilder buf = new StringBuilder();
        int read;
        char []b = new char[8192];
        BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
        
        while((read = in.read(b))!=-1) {
            buf.append(b,0,read);
        }
        
        in.close();
        StringTokenizer token = new StringTokenizer(buf.toString(), ";");
        
        while(token.hasMoreTokens()) {
            ret.add(token.nextToken().trim());
        }
        
        return ret;
        
        } else {
            
            try {
                url = InstallBean.class.getResource("/org/omegabase/sql/omegabase-"+dbversion+".xml");
                
                if (url==null) {
                    return null;
                }
                
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                InputStream in = url.openStream();
                Document doc = dBuilder.parse(in);
                
                in.close();
                
                NodeList lst = doc.getElementsByTagName("command");
                
                for(int i=0;i<lst.getLength();i++) {
                    Element el = (Element)lst.item(i);
                    
                    ret.add(el.getTextContent());
                }
                

            } catch (ParserConfigurationException ex) {
                Logger.getLogger(InstallBean.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SAXException ex) {
                Logger.getLogger(InstallBean.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
       
        return ret;
    }
    
    
    
    /**
     * @return the catalinaHome
     */
    public String getCatalinaHome() {
        return catalinaHome;
    }

    /**
     * @param catalinaHome the catalinaHome to set
     */
    public void setCatalinaHome(String catalinaHome) {
        this.catalinaHome = catalinaHome;
    }

    /**
     * @return the dbHost
     */
    public String getDbHost() {
        return dbHost;
    }

    /**
     * @param dbHost the dbHost to set
     */
    public void setDbHost(String dbHost) {
        this.dbHost = dbHost;
    }

    /**
     * @return the dbUser
     */
    public String getDbUser() {
        return dbUser;
    }

    /**
     * @param dbUser the dbUser to set
     */
    public void setDbUser(String dbUser) {
        this.dbUser = dbUser;
    }

    /**
     * @return the dbPass
     */
    public String getDbPass() {
        return dbPass;
    }

    /**
     * @param dbPass the dbPass to set
     */
    public void setDbPass(String dbPass) {
        this.dbPass = dbPass;
    }

    /**
     * @return the dbDb
     */
    public String getDbDb() {
        return dbDb;
    }

    /**
     * @param dbDb the dbDb to set
     */
    public void setDbDb(String dbDb) {
        this.dbDb = dbDb;
    }

    /**
     * @return the dbPort
     */
    public int getDbPort() {
        return dbPort;
    }

    /**
     * @param dbPort the dbPort to set
     */
    public void setDbPort(int dbPort) {
        this.dbPort = dbPort;
    }

    /**
     * @return the dbSuperuser
     */
    public String getDbSuperuser() {
        return dbSuperuser;
    }

    /**
     * @param dbSuperuser the dbSuperuser to set
     */
    public void setDbSuperuser(String dbSuperuser) {
        this.dbSuperuser = dbSuperuser;
    }

    /**
     * @return the dbSuperuserPass
     */
    public String getDbSuperuserPass() {
        return dbSuperuserPass;
    }

    /**
     * @param dbSuperuserPass the dbSuperuserPass to set
     */
    public void setDbSuperuserPass(String dbSuperuserPass) {
        this.dbSuperuserPass = dbSuperuserPass;
    }

    /**
     * @return the catalineEngineFolder
     */
    public String getCatalineEngineFolder() {
        return catalineEngineFolder;
    }

    /**
     * @param catalineEngineFolder the catalineEngineFolder to set
     */
    public void setCatalineEngineFolder(String catalineEngineFolder) {
        this.catalineEngineFolder = catalineEngineFolder;
    }

    /**
     * @return the context
     */
    public String getContext() {
        return context;
    }

    /**
     * @param context the context to set
     */
    public void setContext(String context) {
        this.context = context;
    }
    
    
    
}
