package org.omegabase.bean;
import org.apache.log4j.*;
import java.util.*;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import javax.servlet.http.*;
import javax.servlet.*;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
//import org.apache.catalina.util.URLEncoder;


public class Lang {
    private String lang;
    private LanguageBean bean;
    private AppBean app;

    public String get(String n) {
        return bean.get(lang, n);
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
        this.lang = lang!=null&&!lang.equals("") ? lang : "en";
    }

    /**
     * @return the bean
     */
    public LanguageBean getBean() {
        return bean;
    }

    /**
     * @param bean the bean to set
     */
    public void setBean(LanguageBean bean) {
        this.bean = bean;
    }

    /**
     * @return the app
     */
    public AppBean getApp() {
        return app;
    }

    /**
     * @param app the app to set
     */
    public void setApp(AppBean app) {
        this.app = app;
    }
    
    public String printDate(long dt) {
        return (new SimpleDateFormat("yyyy-MM-dd")).format(dt);
    }
    
    public long getCurrentTime() {
        return System.currentTimeMillis();
    }
}
