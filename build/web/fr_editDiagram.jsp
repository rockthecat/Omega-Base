<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
      <%@page import="java.sql.*,java.util.*,utils.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">    
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title></title>
	
	
	
	
    </head>
    <body style="; font-family: Arial; font-size: 13px; color: #000000; font-weight: normal; font-style: normal; text-decoration: none; background-color: #FFFFFF">
    
    <%@include file="WEB-INF/jsp/config.jsp" %>

<%
	TypeObjectDAO todao = new TypeObjectDAO();
	TypeObject[] tobjs = todao.getAll();
%>

    
  <script type="text/javascript">
    function canvas1_onclick(event) {
		  icons.onclickIcons(document.getElementById("canvas1"), event.clientX, event.clientY);
icons.drawIcons(document.getElementById("canvas1"), 180, <%=request.getParameter("h")%>);


		}
		
    </script>
    
    <script  type="text/javascript" src="images/powerdraw.js" >
     
     </script>
   <div style="position: absolute; left: 0px; top: 0%; width: 93%; height: 480px; overflow: inherit; text-decoration: inherit"  id="div_main" >
     <div style="position: absolute; left: 5px; top: 0px; width: 170px; height: 100%; overflow: visible; text-decoration: inherit"  id="div" >
     <canvas style="position: absolute; left: 0px; top: 0px; width: 180px; height: 97%; overflow: inherit; text-decoration: inherit"  id="canvas1" onclick="return canvas1_onclick(event);" ></canvas>
<select name="category"  name="category"style="position: absolute; left: 0px; bottom: 0px; width: 175px; height: 25px; overflow: inherit; text-decoration: inherit"  id="select" ></select>
        
     </div> 
   <canvas style="position: absolute; left: 195px; top: 0px; width: 795px; height: 100%; overflow: inherit; text-decoration: inherit"  id="canvas" ></canvas>

     </div> 
   <script  type="text/javascript" >
     document.getElementById("div_main").style.height=<%=request.getParameter("h")%>+"px";

var icons = new PowerCanvas(300, 400, "#fff");
<%
	for(TypeObject obj: tobjs) {
		out.println("var icon_"+obj.getId()+" = new PowerIcon(\""+obj.getIcon().replace("\\", "\\\\")+"\", "+obj.getId()+", \""+obj.getName().replace("\\", "\\\\")+"\");");
		out.println("icon_"+obj.getId()+".drawObj = function(canvas) {");
		out.println(obj.getBody());
		out.println("}");
		out.println("icons.addIcon(icon_"+obj.getId()+");");
	}
%>

document.getElementById("canvas1").width = 180;
document.getElementById("canvas1").height = <%=request.getParameter("h")%>;
icons.arrangeIcons(180, <%=request.getParameter("h")%>);
icons.drawIcons(document.getElementById("canvas1"), 180, <%=request.getParameter("h")%>);


     </script>
   

    
    
    
    </body>
</html>

      
	
      