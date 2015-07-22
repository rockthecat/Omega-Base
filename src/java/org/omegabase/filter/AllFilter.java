/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URLEncoder;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.omegabase.bean.AppBean;
import org.omegabase.bean.SessionBean;

/**
 *
 * @author raphael
 */
@WebFilter(filterName = "AllFilter", urlPatterns = {"/*"})
public class AllFilter implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public AllFilter() {
    }    
    

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = ((HttpServletRequest)request);
        HttpServletResponse res = ((HttpServletResponse)response);
        
        
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        String url = (req).getRequestURI();
        String context = (req).getServletContext().getContextPath();
        
        url = url.substring(context.length());
        
        if (url.startsWith("/WEB-INF/jsp/")||!url.endsWith(".jsp")) {
            chain.doFilter(request, response);
            return;
        }
        
        request.getServletContext().getRequestDispatcher("/WEB-INF/jsp/config.jsp").include(request, response);
        ((HttpServletResponse)response).resetBuffer();
        
        AppBean app = (AppBean)request.getServletContext().getAttribute("app");
        SessionBean ses = (SessionBean)((HttpServletRequest)request).getSession().getAttribute("ses");
               
        
        boolean canUse = ses.getIdUser()!=0||"t".equals(app.getConfiguration().get("anonymous_can_use"));
        String query = req.getQueryString()!=null ? "?"+req.getQueryString() : "";
        
        if (url.equals("/newUser.jsp")&&!("t".equals(app.getConfiguration().get("anonymous_can_inscribe")))) {
                ((HttpServletResponse)response).sendRedirect(context+"/login.jsp?url="+URLEncoder.encode(context+url+query, "UTF-8"));
                return;
        } else if (!canUse&&
                url.endsWith(".jsp")&&
                (!url.equals("/index.jsp"))&&
                (!url.equals("/newUser.jsp"))&&
                (!url.equals("/login.jsp"))
                ){
                ((HttpServletResponse)response).sendRedirect(context+"/login.jsp?url="+URLEncoder.encode(context+url+query, "UTF-8"));
                return;        
        }


        chain.doFilter(request, response);
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                log("NewUserFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("NewUserFilter()");
        }
        StringBuffer sb = new StringBuffer("NewUserFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);        
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);                
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");                
                pw.print(stackTrace);                
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);        
    }
    
}
