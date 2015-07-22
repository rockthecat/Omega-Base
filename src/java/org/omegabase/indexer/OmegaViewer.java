package org.omegabase.indexer;
import java.io.*;
import org.apache.log4j.*;
//import com.itextpdf.text.pdf.*;
//import com.itextpdf.text.pdf.parser.*;
import javax.xml.parsers.*;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.*;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.util.zip.*;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.util.*;


 

public class OmegaViewer {

	public static String viewFile(String url, String context) {
                int idx = url.lastIndexOf(".");

                if (idx==-1) {
                	return null;
                }
                String ext = url.substring(idx+1);

                if (ext.equalsIgnoreCase("mm")) {
                        return context+"/images/freemind/freemindbrowser.jsp";
                } 

        	return null;

        }


	public static String viewIcon(String url, String context) {
                int idx = url.lastIndexOf(".");

                if (idx==-1) {
                	return context+"/images/files/default.png";
                }
                String ext = url.substring(idx+1);

                if (ext.equalsIgnoreCase("mm")) {
                        return context+"/images/files/freemind.png";
                } 
		
		if (ext.equalsIgnoreCase("pdf")) {
                        return context+"/images/files/pdf.png";
                } 

		if (ext.equalsIgnoreCase("docx")) {
                        return context+"/images/files/word.png";
                } 
		
		if (ext.equalsIgnoreCase("xlsx")) {
                      return context+"/images/files/excel.png";
                } 
		
		if (ext.equalsIgnoreCase("pptx")) {
                       return context+"/images/files/powerpoint.png";
                } 

                if (ext.equalsIgnoreCase("dia")) {
                       return context+"/images/files/dia.png";
                } 
                

                if (ext.equalsIgnoreCase("odt")) {
                       return context+"/images/files/writer.png";
                } 
		
		
                if (ext.equalsIgnoreCase("ods")) {
                       return context+"/images/files/calc.png";
                } 
		
		
                if (ext.equalsIgnoreCase("odg")) {
                       return context+"/images/files/draw.png";
                } 
		
		
                if (ext.equalsIgnoreCase("odp")) {
                       return context+"/images/files/impress.png";
                } 





        	return context+"/images/files/default.png";

        }
        

}
