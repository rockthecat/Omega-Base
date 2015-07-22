/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.bean;

import java.sql.SQLException;
import java.util.Map;
import org.apache.log4j.Logger;

/**
 *
 * @author raphael
 */
public class AppBean {
        Map<String, String> configuration;
    
        public Map<String, String> getConfiguration() {
            return configuration;
        }

        public void setConn(ConnBean conn) {
            try {
                configuration = conn.selectOne("get_configuration");
            } catch (SQLException ex) {
                Logger.getLogger(AppBean.class).error(ex);
            }
        }
}
