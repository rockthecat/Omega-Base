package org.omegabase.bean;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LanguageBean {
    private Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
    
    public void setConn(ConnBean conn) throws SQLException {
        List<Map<String, String>> mp = conn.select("get_languages");
        
        for(Map<String, String> m: mp) {
            String l = m.get("lang");
            String n = m.get("name");
            String v = m.get("value");
            
            
            Map<String, String> m2 = map.get(l);
            
            if (m2==null) {
                m2 = new HashMap<String, String>();
                map.put(l, m2);
            }
            
            m2.put(n, v);
        }
    }
    
    public String get(String l, String n) {
        Map<String, String> m2 = map.get(l);
        
        if (m2!=null) {
            return m2.get(n);
        } else {
            return null;
        }
    }
    
    public List<String> getLanguages() {
        List<String> r = new ArrayList<String>();
        
        for(String s: map.keySet()) {
            Map<String, String> m = map.get(s);
            String l = m.get("lang");
            
            if (l!=null) {
                r.add(s+"@"+l);
            }
            
        }
        return r;
        
    }
}
