<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.util.Sitemap" %><% request.setCharacterEncoding("UTF-8");
/*
String ua=request.getHeader("user-agent");
String referer=request.getHeader("referer");
if(referer!=null||ua.equals("Baiduspider+(+http://www.baidu.com/search/spider.htm)")||ua.equals("Mozilla/5.0 (compatible; Yahoo! Slurp China; http://misc.yahoo.com.cn/help.html)")||ua.equals("Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)")||ua.equals("Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)")||ua.equals("msnbot/0.9 (+http://search.msn.com/msnbot.htm)"))
{
  response.sendError(404);
  return;
}
*/
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode("/","UTF-8"));
  return;
}

String path="/res/map_"+request.getServerName()+".html";
java.io.File file=new java.io.File(application.getRealPath(path));

String info=request.getParameter("info");
//info="<?xml version=\"1.0\" encoding=\"UTF-8\"?><ROOT>  <IP>192.168.0.37-ROOT</IP>  <COMMUNITY>    <NAME>EDN</NAME>    <URL>http://%</URL>  </COMMUNITY>  <COMMUNITY>    <NAME>ffffffffff</NAME>    <URL></URL>  </COMMUNITY></ROOT>";
if(info!=null)
{
//  System.out.println(request.getMethod()+":"+info);
  javax.xml.parsers.DocumentBuilderFactory dbf=javax.xml.parsers.DocumentBuilderFactory.newInstance();
  javax.xml.parsers.DocumentBuilder db=dbf.newDocumentBuilder();
  java.io.ByteArrayInputStream bais=new java.io.ByteArrayInputStream(info.getBytes("UTF-8"));
//  java.io.StringBufferInputStream sbis=new java.io.StringBufferInputStream(info);
  org.w3c.dom.Document d=db.parse(bais);
  org.w3c.dom.NodeList nl=d.getElementsByTagName("IP");
  String ip="";
  if(nl!=null)
  {
    for(int i=0;i<nl.getLength();i++)
    {
      org.w3c.dom.Node n=nl.item(i);
      if(n.getNodeType()==n.ELEMENT_NODE)
      {
        ip=n.getFirstChild().getNodeValue();
//        System.out.println(ip);
      }
    }
    Sitemap.deleteByIp(ip);
    nl=d.getElementsByTagName("COMMUNITY");
    for(int i=0;i<nl.getLength();i++)
    {
      String name="",url="";
      int mcount=0,online=0,ncount=0;
      org.w3c.dom.Node n=nl.item(i);
      for(org.w3c.dom.Node nc=n.getFirstChild();nc!=null;nc=nc.getNextSibling())
      {
        if(nc.getNodeType()==nc.ELEMENT_NODE)
        {
          if(nc.getNodeName().equals("NAME"))
          {
            org.w3c.dom.Node fc=nc.getFirstChild();
            if(fc!=null)
            name=fc.getNodeValue();
          }else if(nc.getNodeName().equals("URL"))
          {
            org.w3c.dom.Node fc=nc.getFirstChild();
            if(fc!=null)
            url=fc.getNodeValue();
          }else if(nc.getNodeName().equals("MCOUNT"))
          {
            org.w3c.dom.Node fc=nc.getFirstChild();
            if(fc!=null)
            mcount=Integer.parseInt(fc.getNodeValue());
          }else if(nc.getNodeName().equals("ONLINE"))
          {
            org.w3c.dom.Node fc=nc.getFirstChild();
            if(fc!=null)
            online=Integer.parseInt(fc.getNodeValue());
          }else if(nc.getNodeName().equals("NCOUNT"))
          {
            org.w3c.dom.Node fc=nc.getFirstChild();
            if(fc!=null)
            ncount=Integer.parseInt(fc.getNodeValue());
          }
        }
      }
      //      System.out.println(name+":"+url);
      Sitemap.create(ip,name,url,mcount,online,ncount);
    }
    file.delete();
    new java.io.File(application.getRealPath("/res/map2_"+request.getServerName()+".html")).delete();
  }
  return;
}else
if(request.getMethod().equals("POST"))
{
  Sitemap.deleteByIp(request.getParameter("ip"));
  file.delete();
  response.sendRedirect(request.getRequestURI());
  return;
}else
if(request.getParameter("allip")!=null)
{

}
%>
<form name="form1" action="" method="POST" >
<input type="hidden" name="ip" value="">
<%

if(file.exists())//teasession._rv==null&&
{
%>
<jsp:include flush="true" page="<%=path%>">
<jsp:param name="a" value="b"/>
</jsp:include>
<%
}else
{
  StringBuffer html=new StringBuffer();
  int sum_ccount=0,sum_mcount=0,sum_online=0,sum_ncount=0;
  java.util.Enumeration enumer=Sitemap.findIp();
  while(enumer.hasMoreElements())
  {
    String ip=(String)enumer.nextElement();
    html.append("<H3>").append(ip).append("</H3>");
//    if(teasession._rv!=null)
//    html.append("<INPUT type=button value=删除 onclick=if(confirm('你真想删除这个吗?')){form1.ip.value='").append(ip).append("';form1.submit();} >");//disabled
    html.append("<table><tr><td>社区名</td><td>会员数</td><td>在线人数</td><td>信息数</td></tr>");
    java.util.Enumeration enumesun=Sitemap.findByIp(ip);
    while(enumesun.hasMoreElements())
    {
      int id=((Integer)enumesun.nextElement()).intValue();
      Sitemap obj=Sitemap.find(id);
      html.append("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ><td><A ");
      if(obj.getUrl()!=null&&obj.getUrl().length()>0)
      html.append("HREF=\"").append(obj.getUrl()).append("\" ");
      html.append("TARGET=\"_blank\">");
      html.append(obj.getName()).append("</A>");
      html.append("<td>").append(obj.getMcount());
      html.append("<td>").append(obj.getOnline());
      html.append("<td>").append(obj.getNcount());
      html.append("</tr>");
      sum_ccount+=1;
      sum_mcount+=obj.getMcount();
      sum_online+=obj.getOnline();
      sum_ncount+=obj.getNcount();
    }
    html.append("</table>\r\n");
  }/*
  html.append("<table><tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
  html.append("<td>").append(sum_ccount);
  html.append("<td>").append(sum_mcount);
  html.append("<td>").append(sum_online);
  html.append("<td>").append(sum_ncount);
  html.append("</tr></table>");*/
  out.print(html.toString());
  if(teasession._rv==null)
  {
    java.io.FileWriter fw=new java.io.FileWriter(file);
    fw.write(html.toString());
    fw.close();
  }
}
%>
</form>
<br>
<%--
<input type=button value=管理 onclick="window.open('/servlet/StartLogin?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>', '_self');" >
--%>

