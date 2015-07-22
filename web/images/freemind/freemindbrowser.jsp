<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<!-- Launcher tested with Mozilla 1.6 under Linux -->
<!-- Launcher tested with Konqueror 3.1.1 under Linux -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="generator" content=
"HTML Tidy for Linux/x86 (vers 1st March 2004), see www.w3.org">
<title>FreeMind Mind Map</title>
<!--   ^ Put the name of your mind map here -->
<style type="text/css">
body { margin-left:0px; margin-right:0px; margin-top:0px; margin-bottom:0px }
</style>
</head>
<body>
<%@page import="java.net.*, java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	/*
	String url = URLDecoder.decode(request.getParameter("url"), "UTF-8");
	int idx = url.lastIndexOf("/");
	
	
	String urlf = url.substring(0, idx);
	url = urlf+"/"+URLEncoder.encode(url.substring(idx+1));
	
	URI uri = URI.create(url);
	
	uri = uri.normalize();
	*/
	String url = request.getParameter("url");
	
%>
<applet code="freemind.main.FreeMindApplet.class" style="border: none"
	archive="freemindbrowser.jar" width="100%" height="100%">
	<param name="type" value="application/x-java-applet;version=1.4">
	<param name="scriptable" value="false">
	<param name="modes" value="freemind.modes.browsemode.BrowseMode">
	<param name="browsemode_initial_map"
		value="<%=url%>">
	<!--          ^ Put the path to your map here, if it starts with a dot, 	
	the file is searched in the filesystem from the path, the html resides in. .  -->
	<param name="initial_mode" value="Browse">
	<param name="selection_method" value="selection_method_direct">
	This page requires Java Plugin
</applet>

</body>
</html>
