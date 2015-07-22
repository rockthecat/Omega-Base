<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">    
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prisma - error</title>
	<link id="link" href="style.css" media="screen" rel="stylesheet" />
        <script src="omega.js" type="text/javascript"></script>
    </head>
    <body>

        <div class="title">
           &nbsp;
        </div>
        <br>
<div class="boxdialog" >
    ${param.error=='404' ? 'Sorry, page not found' : 'An error ocurred' }
</div>
<br>
<div class="title">&nbsp;</div>
    </body>
</html>