<!DOCTYPE>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test Page</title>
        <meta name="viewport" content="width=device-width,height=device-height,user-scalable=no,minimum-scale=1.0,maximum-scale=1.0"> 

<link rel="stylesheet" href="images/themes/default/default.css" />
</head>
<body>

    <script  type="text/javascript" src="omega.js" ></script>
    <script  type="text/javascript" src="omegadraw.js" ></script>
    <script  type="text/javascript" src="omegaflowchart.js" ></script>


<canvas id="canvas" style=" border: 1px solid #000"  >
    Precisa de HTML5
</canvas>
    <div id="debug"></div>

    <script type="text/javascript" >
        var panel = new ZRootPanel('canvas');
        var pnl = new ZProcess(panel);
        var pnl2 = new ZProcess(panel);
        
        panel.setWidth(window.innerWidth-20);
        panel.setHeight(window.innerHeight-40);
        panel.setBackground("#FFF");
        
        pnl.setWidth(200);
        pnl.setHeight(80);
        pnl.setBackground("#EEE");
        pnl.setVirtualWidth(201);
        pnl.setVirtualHeight(160);
        
        pnl2.setWidth(200);
        pnl2.setHeight(80);
        pnl2.setBackground("#EEE");
        pnl2.setVirtualWidth(250);
        pnl2.setVirtualHeight(160);
        pnl2.setX(300);
        
        panel.repaint();
        
        </script>
    
</body>
</html>
