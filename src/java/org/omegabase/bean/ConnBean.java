package org.omegabase.bean;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;
import org.apache.log4j.Logger;
import org.omegabase.indexer.OmegaIndexer;
import org.omegabase.servlet.ServletUtils2;

public class ConnBean {
    //private Connection conn=null;
    private static final SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final SimpleDateFormat fmd = new SimpleDateFormat("yyyy-MM-dd");
    private static final SimpleDateFormat fmtt = new SimpleDateFormat("HH:mm:ss");
    private List<Object> list = new ArrayList<Object>();
    private String hostAddr;
    private SessionBean session;
    private String errorMsg;
    private String lang;
    private String blobName;
    
    
    
    protected Connection getConnection() {
            
            try {
                Connection conn = Conn.connect();
                conn.setAutoCommit(false);
                Statement st = conn.createStatement();
                st.executeQuery("select set_user_info("+session.getIdUser()+",'"+hostAddr+"','"+lang+"')");
                st.close();
                return conn;
            } catch (SQLException ex) {
                Logger.getLogger(ConnBean.class).error( ex);
                //java.util.logging.Logger.getLogger(ConnBean.class.getName()).log(Level.SEVERE, null, ex);
            }
        
        
        return null;
    }
    
    
    protected String getString(ResultSet rs, ResultSetMetaData meta, int col) throws SQLException {
        switch(meta.getColumnType(col)) {
            //case Types.TIMESTAMP_WITH_TIMEZONE:
            case Types.TIMESTAMP:
                return fmt.format(rs.getTimestamp(col));
            case Types.DATE:
                return fmd.format(rs.getDate(col));
            case Types.TIME:
            //case Types.TIME_WITH_TIMEZONE:
                return fmtt.format(rs.getTime(col));
            default:
                return rs.getString(col);
        }
    }
    
    protected void close(Connection conn) {
            
            try {
                conn.commit();
            } catch (SQLException ex) {
                Logger.getLogger(ConnBean.class).error( ex);
                
                try {
                    conn.rollback();
                } catch (SQLException ex1) {
                    Logger.getLogger(ConnBean.class).error( ex);
                }
            }
            
            
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConnBean.class).error( ex);
            }
    }

    public void pushi(Integer i) {
        list.add(i);
    }
    
    public void push(String s) {
        list.add(s);
    }
    
    public void pushb(Boolean b) {
        list.add(b);
    }
    
    public void pusht(String t) {
        try {
            list.add(new Timestamp(fmt.parse(t).getTime()));
        } catch (ParseException ex) {
            list.add(null);
        }
    }
    
    public void pushd(String t){
        try {
            list.add(new java.sql.Date(fmd.parse(t).getTime()));
        } catch (ParseException ex) {
           list.add(null);
        }
    }
    
    public void pushtt(String t) {
        try {
            list.add(new java.sql.Time(fmtt.parse(t).getTime()));
        } catch (ParseException ex) {
            list.add(null);
        }
    }
    
    public void pushin(byte[] in) {
        list.add(in);
    }
    
    public List<Map<String, String>> select(String func) throws SQLException {
        StringBuilder sql = new StringBuilder("select * from public.");
        List<Map<String, String>> ret = new ArrayList<Map<String, String>>();
        boolean first = true;
        
        sql.append(func);
        sql.append('(');
        
        for(Object o: list) {
            if (first) {
                sql.append("?");
                first = false;
            } else {
                sql.append(", ?");
            }    
        }
        
        sql.append(')');
        
        try { 
            Connection conn = getConnection();
            try {
            PreparedStatement ps = conn.prepareCall(sql.toString(),
                    ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
            int i = 1;
            
            for(Object o: list) {
                ps.setObject(i++, o);
            }
            
            list.clear();
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData meta = rs.getMetaData();
            
            while(rs.next()) {
                Map<String, String> map = new HashMap<String, String>();
                for(i=1;i<=meta.getColumnCount();i++) {
                    map.put(meta.getColumnName(i), getString(rs, meta, i));
                }
                ret.add(map);
            }
            
        } finally {
            close(conn);
        }
            errorMsg = null;
            return ret;
        } catch (SQLException ex) {
            Logger.getLogger(ConnBean.class).error(ex);
            errorMsg = ex.getMessage();
            throw ex;
        }
        
        
    }
    
    public Map<String, String> selectOne(String func) throws SQLException {
        Map<String, String> map = new HashMap<String, String>();
        StringBuilder sql = new StringBuilder("select * from public.");
        boolean first = true;
        
        sql.append(func);
        sql.append('(');
        
        for(Object o: list) {
            if (first) {
                sql.append("?");
                first = false;
            } else {
                sql.append(", ?");
            }    
        }
        
        sql.append(")");
        
        try {
            Connection conn = getConnection();
            try {
            PreparedStatement ps = conn.prepareStatement(sql.toString(),
                    ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
            int i = 1;
            
            for(Object o: list) {
                ps.setObject(i++, o);
            }
            
            list.clear();
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData meta = rs.getMetaData();
            
            if(rs.next()) {
                for(i=1;i<=meta.getColumnCount();i++) {
                    map.put(meta.getColumnName(i), getString(rs, meta, i));
                }
            }
            
        } finally { 
                close(conn);
        }
            errorMsg = null;
            return map;
        } catch (SQLException ex) {
            Logger.getLogger(ConnBean.class).error(ex);
            errorMsg = ex.getMessage();
            throw ex;
        }
        
        
    }
    
    public void doSyncroZip(InputStream in, int category, char status, PrintWriter out, AppBean app) throws IOException, SQLException  {
        ZipFile zip = null;
        Connection conn = getConnection();
        ZipEntry entry;
        Enumeration en;
        File tmp = null;
        
        try {
        try {
           tmp = ServletUtils2.saveBlob(in);
           zip = new ZipFile(tmp);
            
            ResultSet rs = conn.createStatement().executeQuery("select * from check_can_use()");
            rs.getStatement().close();
            PreparedStatement pscheck = conn.prepareStatement("select * from syncro_check_file(?,?,?,?)");
            PreparedStatement psfile = conn.prepareStatement("select * from syncro_save_file(?,?,?,?,?,?,?,?,?,?)");
            String vstatus = ""+status;
            long max_att_size = Long.parseLong(app.getConfiguration().get("max_att_size"))*1024*1024;
            en = zip.entries();
            
        while (en.hasMoreElements()) {
            entry = (ZipEntry)en.nextElement();
            
            String name = entry.getName();
            
            if (name.endsWith("/"))
                continue;
            
            int i = name.lastIndexOf('/');
            String rel = name.substring(i+1);
            
            pscheck.setInt(1, category);
            pscheck.setString(2, vstatus);
            pscheck.setString(3, "zip://"+name);
            pscheck.setTimestamp(4, new Timestamp(entry.getTime()));
            
            ResultSet rscheck = pscheck.executeQuery();
            rscheck.next();
            
            int iddoc = rscheck.getInt(1);
            int idfile = rscheck.getInt(2);
            boolean needCheck = rscheck.getBoolean(3);
            
            rscheck.close();
            
            if (needCheck&&entry.getSize()<=max_att_size) {
                int j = rel.lastIndexOf('.');
                String dname = j!=-1 ? rel.substring(0, j):rel;
                byte []buf = ServletUtils2.saveBlob2(zip.getInputStream(entry));
                
                
                psfile.setInt(1, iddoc);
                psfile.setInt(2, idfile);
                psfile.setString(3, vstatus);
                psfile.setString(4, dname);
                psfile.setString(5, "zip://"+name);
                psfile.setString(6, rel);
                psfile.setBytes(7, buf);
                psfile.setString(8, OmegaIndexer.extractFile(new ByteArrayInputStream(buf), rel));
                psfile.setTimestamp(9, new Timestamp(entry.getTime()));
                psfile.setInt(10, category);
                ResultSet rsfile = psfile.executeQuery();
                
                rsfile.next();
                out.println(rsfile.getString(1));
                rsfile.close();
                
            } else if (!needCheck) {
                out.println(name+"|KEPT");
                
            } else {
                    out.println(name+"|TOOBIG");
            }
            
               try {
                   Thread.sleep(10);
               } catch (InterruptedException ex) {
                  
               }
        }
        
        conn.commit();
        } finally {
            if (conn!=null) {
                
                conn.close();
            }
            
            if (zip!=null)
                zip.close();
            
            if (tmp!=null)
                tmp.delete();
        }
        } catch(SQLException ex) {
            errorMsg = ex.getMessage();
            Logger.getLogger(ConnBean.class).error( ex);
        }
    }
    
    
    public InputStream selectBlob(String func) throws SQLException {
        StringBuilder sql = new StringBuilder("select * from public.");
        InputStream in = null;
        boolean first = true;
        
        sql.append(func);
        sql.append('(');
        
        for(Object o: list) {
            if (first) {
                sql.append("?");
                first = false;
            } else {
                sql.append(", ?");
            }    
        }
        
        sql.append(")");
        
        try {
            Connection conn = getConnection();
            try {
            PreparedStatement ps = conn.prepareStatement(sql.toString(),
                    ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
            int i = 1;
            
            for(Object o: list) {
                ps.setObject(i++, o);
            }
            
            list.clear();
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                blobName = rs.getString(1);
                in = new ByteArrayInputStream(rs.getBytes(2));
            }
            ps.close();
            
        } finally { 
                close(conn);
        }
            errorMsg = null;
        } catch (SQLException ex) {
            Logger.getLogger(ConnBean.class).error(ex);
            errorMsg = ex.getMessage();
            throw ex;
        }
        
        return in;
    }

    /**
     * @return the hostAddr
     */
    public String getHostAddr() {
        return hostAddr;
    }

    /**
     * @param hostAddr the hostAddr to set
     */
    public void setHostAddr(String hostAddr) {
        this.hostAddr = hostAddr;
    }

    /**
     * @return the session
     */
    public SessionBean getSession() {
        return session;
    }

    /**
     * @param session the session to set
     */
    public void setSession(SessionBean session) {
        this.session = session;
        
        
    }

    /**
     * @return the errorMsg
     */
    public String getErrorMsg() {
        if (errorMsg!=null&&errorMsg.indexOf('|')!=-1) {
            int j = errorMsg.indexOf('|');
            int i = errorMsg.lastIndexOf(' ', j);
            return errorMsg.substring(i+1);
        }
        return errorMsg;
    }

    /**
     * @return the lang
     */
    public String getLang() {
        return lang;
    }

    /**
     * @param lang the lang to set
     */
    public void setLang(String lang) {
        if (lang==null||"".equals(lang)) {
            this.lang = "en";
        } else {
            this.lang = lang;
        }
    }

    /**
     * @return the blobName
     */
    public String getBlobName() {
        return blobName;
    }
}
