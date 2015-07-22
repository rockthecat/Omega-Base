/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.omegabase.utils;

import java.util.Map;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author raphael
 */
public class Mail {
    private static Logger log = Logger.getLogger(Mail.class);
    
    public static boolean mail(Map<String, String> conf, String to, String title, String msg) {
	Properties properties = System.getProperties();
	final String user = conf.get("smtp_user");
	final String pass = conf.get("smtp_pass");

      // Setup mail server
	if (!"0".equals(conf.get("smtp_port"))) {
		properties.put("mail.smtp.port", conf.get("smtp_port"));
	}
	
      properties.setProperty("mail.smtp.host", conf.get("smtp_server"));
      

	if ("tls".equals(conf.get("smtp_crypto"))) {
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		if (!"0".equals(conf.get("smtp_port"))) 
                    properties.put("mail.smtp.port", conf.get("smtp_port"));
 
	} else if ("ssl".equals(conf.get("smtp_crypto"))) {
		if (!"0".equals(conf.get("smtp_crypto")))
		properties.put("mail.smtp.socketFactory.port", conf.get("smtp_port"));
		properties.put("mail.smtp.socketFactory.class",
		"javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "true");		
		if (!"0".equals(conf.get("smtp_port")))
		properties.put("mail.smtp.port", conf.get("smtp_port"));
	}

      // Get the default Session object.
      Session session = null;
      
	if (conf.get("smtp_user")!=null&&!conf.get("smtp_user").equals("")) {
		session = Session.getInstance(properties,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, pass);
			}
		  });	
	} else {
                session = Session.getDefaultInstance(properties);
	}

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress("OmegaBase@noreply"));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress(to));

         // Set Subject: header field
         message.setSubject(title);

         // Now set the actual message
         message.setContent(msg, "text/html");

         // Send message
         Transport.send(message);
         return true;
      }catch (MessagingException mex) {
         log.error(mex);
      }
	return false;      
}

}
