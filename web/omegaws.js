
function createLinkDoc(view, edit, comments, historic, evt) {
                        var a = getTarget(evt);
                        var html = "<div class='total'>"+
                                "<div id='tabid' class='rotulobig'></div>"+
                               // "<div class='rotuloclear'>&nbsp;</div>"+
                                "<div id='clientid' ></div>"+
                        "</div>";
                        var tabs = new Array();
                        var urls = new Array();
                        
                        tabs.push(view);
                        urls.push('view.jsp?id='+a.edid);
                        
                        if (parseInt(a.edlevel)>=2) {
                            tabs.push(edit);
                            urls.push('editDocument.jsp?id='+a.edid);
                            
                            if (parseInt(a.edlevel)>=3) {
                                tabs.push(historic);
                                urls.push('viewHistoric.jsp?id='+a.edid);                            
                            }
                        }
                        
                        if (a.canComment==true) {
                            tabs.push(comments);
                            urls.push('fr_comments.jsp?id='+a.edid);
                        }
                        
                       xwindow2.open(a.edname, html);
                        var tabs = new TabsH('clientid', 'tabid',
                        tabs,
                        urls,
                        getHeight()-90);

     
}