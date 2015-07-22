package org.omegabase.bean;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import org.apache.log4j.*;

public class Conn {
	private static Logger log = Logger.getLogger(Conn.class.getName());
        private static int resType = -1;
        
        private static void detectResType() {
	    Context initContext;
            try {
                initContext = new InitialContext();
                Context envContext  = (Context)initContext.lookup("java:/comp/env");
                resType = 0;
            } catch (NamingException ex) {
                resType = 1;
            }
            
            
                
        }

	public static Connection connect() {
	try {
            
            if (resType==-1) {
                detectResType();
            }
            
            switch(resType) {
                case 0:
                {
	    Context initContext = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/Prisma");
            Connection conn = ds.getConnection();
            return conn;
                }
                case 1:
                {
	    Context initContext = new InitialContext();
            DataSource ds = (DataSource)initContext.lookup("jdbc/Prisma");
            Connection conn = ds.getConnection();
            return conn;        
                    
                }       
                default:
                    return null;
            }
	} catch(Exception ex) {
	        //TODO: log it
                log.error(ex);
	
	}

        return null;

        }


	
	
        
        public boolean isConfigured() {
            try {
            Context initContext = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/Prisma");
            
            //Connection conn = ds.getConnection();
            
            //conn.close();
            } catch(NamingException ex) {
                return false;
            }
            
            return true;
        }
        
        public static Connection connectDirect(String host, String db, String user, String pass, int port) {
            try {
                Class.forName("org.postgresql.Driver");
                return DriverManager.getConnection("jdbc:postgresql://"+host+":"+port+("".equals(db) ? "" : "/"+db), user, pass);
            } catch (SQLException ex) {
                java.util.logging.Logger.getLogger(Conn.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                java.util.logging.Logger.getLogger(Conn.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
            } 
            return null;
        }
        
            public static int detectDbVersion(String host, String db, String user, String pass, int port) {
        int ret = -1;
        Connection conn = connectDirect(host, db, user, pass, port);
        
        if (conn==null) {
            return ret;
        }
        
        try {
        try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select id from \"configuration\" ");
        
        rs.next();
        ret = 0;
        rs.close();
        
        
        rs = st.executeQuery("select db_version from \"configuration\" ");
        
        rs.next();
        ret = rs.getInt(1);
        rs.close();
        
        } finally {
            conn.close();
        }
        } catch(SQLException ex) {
        }
        
        return ret;
    }
            

}
