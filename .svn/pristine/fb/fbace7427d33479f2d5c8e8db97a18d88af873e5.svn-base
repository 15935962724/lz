<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.util.Sitemap" %><% request.setCharacterEncoding("UTF-8");

String path="/res/map2_"+request.getServerName()+".html";
java.io.File file=new java.io.File(application.getRealPath(path));
if(file.exists())
{
%>
<jsp:include flush="true" page="<%=path%>">
<jsp:param name="a" value="b"/>
</jsp:include>
<%
}else
{
  StringBuffer html=new StringBuffer();
  StringBuffer html2=new StringBuffer();
  int sum_server=0,sum_community=0,sum_member=0,sum_online=0,sum_node=0;
  java.util.Enumeration enumer=Sitemap.findIp();
  while(enumer.hasMoreElements())
  {
    sum_server++;
    String ip=(String)enumer.nextElement();
    html.append("<H3>").append(ip).append("</H3>");
    html2.append(ip).append("<br/>");
    html.append("<table><tr><td>社区名</td><td>会员数</td><td>在线人数</td><td>信息数目</td></tr>");
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
      sum_community++;
      sum_member+=obj.getMcount();
      sum_online+=obj.getOnline();
      sum_node+=obj.getNcount();
    }
    html.append("</table>\r\n");
  }
  html2.insert(0,"<LI><A href=\"javascript:void(0);\" onclick=\"javascript:var obj=document.getElementById('serverdetail');obj.style.display=(obj.style.display==''?'none':'');\">服务器:"+sum_server+"</A></LI><DIV ID=serverdetail style=\"display:none\" >");
  html2.append("</DIV>");

  html.insert(0,"<LI><A href=\"javascript:void(0);\" onclick=\"javascript:var obj=document.getElementById('communitydetail');obj.style.display=(obj.style.display==''?'none':'');\">共社区:"+sum_community+"</A></LI><DIV ID=communitydetail style=\"display:none\" >");
  html.append("</DIV>");
  html.append("<LI>共会员:"+sum_member+"</LI>");
  html.append("<LI>在线人员:"+sum_online+"</LI>");
  html.append("<LI>信息数目:"+sum_node+"</LI>");

  out.print(html2.toString());
  out.print(html.toString());

  java.io.FileWriter fw=new java.io.FileWriter(file);
  fw.write(html2.toString());
  fw.write(html.toString());
  fw.close();

}
%>

