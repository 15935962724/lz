<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.awt.image.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.io.*" %>
<%
TeaSession teasession = new TeaSession(request);
String picid = "0";
if(request.getParameter("pic")!=null && request.getParameter("pic").length()>0)
{
  picid = request.getParameter("pic");
}
Picture p = Picture.find(Integer.parseInt(picid));

int width = p.getWidth(1);
int height = p.getHeight(1);
//Baudit ba = Baudit.find(Integer.parseInt(picid));
//String picture = "";
//if(ba.getProperty()==1)
//    {
//      picture = "/res/"+teasession._strCommunity+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/extralarge/"+picid+".jpg";
//    }else
//    {
//      picture = "/res/"+teasession._strCommunity+"/salepic/"+ba.getMember()+"/"+ba.getTimes()+"/"+p.get_nName();
//    }

String picture = "/res/"+teasession._strCommunity+"/picture/"+picid+".jpg";

out.print("<img width="+width/15+" height="+height/15+" border=0 src="+picture+">");

%>
