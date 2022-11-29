<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="tea.entity.site.*" %>
<%

TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

String filename = request.getParameter("filename");
String mv = request.getParameter("mv");

StringBuffer strs = new StringBuffer("");
int key=0,key2 =0,key3 =0;
  String aa ="";
  if(mv!=null)
  {
    aa = mv;
  }
if(teasession.getParameter("key")!=null && teasession.getParameter("key").length()>0)
{
  key=Integer.parseInt(teasession.getParameter("key"));

   String str3 = "";
  if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
  {
    str3= teasession.getParameter("str");
  }

    aa=str3;

}
if(teasession.getParameter("key2")!=null && teasession.getParameter("key2").length()>0)
{
  key2=Integer.parseInt(teasession.getParameter("key2"));
     String str3 = "";
   if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
  {
    str3= teasession.getParameter("str");
  }

     aa=str3;
}

if(teasession.getParameter("key3")!=null && teasession.getParameter("key3").length()>0)
{

  key3=Integer.parseInt(teasession.getParameter("key3"));
  BkeyWord bw3 = BkeyWord.find(key3);
  String newstr = bw3.getWordname();

  String str3 = "";
  if(teasession.getParameter("str")!=null && teasession.getParameter("str").length()>0)
  {
    str3= teasession.getParameter("str");
  }
  String sp[] = str3.split(",");
  boolean cf = false;
  StringBuffer sb = new StringBuffer();
  for(int i=0; i < sp.length; i++){
    if(sp[i].toString().equals(newstr)){
      cf = true;

    }else{
    sb.append(sp[i]).append(",");
    }
  }

  if(!cf)
  {
    aa=strs.append(str3).append(newstr).append(",").toString();
  }else{
    aa = sb.toString();
  }

}
%>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/res/<%=teasession._strCommunity%>/cssjs/3js.js" type="" ></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>  关键字  </title>
  <script type="">window.name="self";</script>
</head>
<body bgcolor="#ffffff">
<h1> 关键字 </h1>
<form name="form1" action="?">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Enumeration ee = BkeyWord.findBykeyWord(" and levelid=1 ",0,100);
if(!ee.hasMoreElements())
{
  out.print("<tr><td>没有数值</td></tr>");
}
for(int i=0;ee.hasMoreElements();i++)
{
  int id = Integer.parseInt(String.valueOf(ee.nextElement()));
  BkeyWord bw = BkeyWord.find(id);

  if(i%6==0&&(i!=0))
  {
    out.print("</tr><tr>");
  }else if(i%6==0&&(i==0))
  {
    out.print("<tr>");
  }
  out.print("<td><a target=self href=\"/jsp/bpicture/saler/BkeyWord.jsp?key="+id+"&filename="+filename+"&str="+java.net.URLEncoder.encode(aa,"utf-8")+"\">"+bw.getWordname()+"</a></td>");
}
%>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Enumeration eefb = BkeyWord.findBykeyWord(" and levelid=2 and fatherid="+key,0,100);
if(!eefb.hasMoreElements())
{
  out.print("<tr><td>没有数值</td></tr>");
}
for(int i=0;eefb.hasMoreElements();i++)
{
  int id = Integer.parseInt(String.valueOf(eefb.nextElement()));
  BkeyWord bw = BkeyWord.find(id);

  if(i%6==0&&(i!=0))
  {
    out.print("</tr><tr>");
  }else if(i%6==0&&(i==0))
  {
    out.print("<tr>");
  }
  out.print("<td><a target=self href=\"/jsp/bpicture/saler/BkeyWord.jsp?key="+key+"&filename="+filename+"&key2="+id+"&str="+java.net.URLEncoder.encode(aa,"utf-8")+"\">"+bw.getWordname()+"</a></td>");
}


%>

</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Enumeration ee3 = BkeyWord.findBykeyWord(" and levelid=3 and fatherid="+key2,0,500);
if(!ee3.hasMoreElements())
{
  out.print("<tr><td>没有数值</td></tr>");
}
for(int i=0;ee3.hasMoreElements();i++)
{
  int id = Integer.parseInt(String.valueOf(ee3.nextElement()));
  BkeyWord bw = BkeyWord.find(id);

  if(i%6==0&&(i!=0))
  {
    out.print("</tr><tr>");
  }else if(i%6==0&&(i==0))
  {
    out.print("<tr>");
  }
  out.print("<td><a target=self href=\"/jsp/bpicture/saler/BkeyWord.jsp?key="+key+"&filename="+filename+"&key2="+key2+"&key3="+id+"&str="+java.net.URLEncoder.encode(aa,"utf-8")+" \">"+bw.getWordname()+"</a></td>");
}


%>
</table>
<textarea name="bkw" cols="38" rows="5"><%=aa%></textarea>

</form>
<center>
<a href="#" onclick="window.returnValue=document.form1.bkw.value;window.close();">确定</a>
<a href="/jsp/bpicture/saler/BkeyWord.jsp"  target="self">清空</a>
</center>
</body>
</html>
