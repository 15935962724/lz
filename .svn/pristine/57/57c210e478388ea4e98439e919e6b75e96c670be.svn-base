<%@page import="ChartDirector.*" %><%  
try   
{     
      
    out.clear();  
    GetSessionImage.getImage(request, response);  
    response.setHeader("Content-Type","image/png");  
    if (Math.max(1, 2) == 2) return;  
}  
catch (IllegalStateException e)   
{   
    response.sendRedirect(response.encodeRedirectURL(  
        "getchart.chart?" + request.getQueryString()));  
    return;  
}  
%>