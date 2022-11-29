<%@page contentType="text/html;charset=UTF-8"%>

<%!
public String htmlToText(String value,int language)throws java.io.UnsupportedEncodingException
{
 if(value==null)
  return "";
  else
  return  tea.html.HtmlElement.htmlToText(new String(value.getBytes("ISO-8859-1")));//tea.html.HtmlElement.htmlToText(new String(value.getBytes("ISO-8859-1"),tea.ui.TeaServlet.CHARSET[language]));
}
%>
<%
    //    response.setCharacterEncoding("gbk");
tea.resource.Resource r = new tea.resource.Resource();
String TYPE[]={"_en","_zh_CN","_ja_JP","_ko_KR","_fr","_de","_es","_pt","_it"};//"_zh_TW",
int len[]=new int[TYPE.length];
%>
<html>
<head>
<link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<form action="/servlet/EditResource" method="POST">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td></td>
    <td>关键字</td>
    <%
    for(int index=0;index<    tea.resource.Common.LANGUAGE.length;index++)
    {
      if(index!=2)//2=big5
      out.print("<td>"+r.getString(1,tea.resource.Common.LANGUAGE[index])+"</td>");
    }
    %>
  </tr>
  <%
  String path=request.getParameter("path");
  out.print(new tea.html.HiddenField("path_path_path",path));
//  "/WEB-INF/classes/tea/resource/NightShop";
  java.util.Properties prop=new java.util.Properties();
  java.util.Properties langu[]=new java.util.Properties[TYPE.length];
  for(int index=0;index<langu.length;index++)
  {
    langu[index]=new java.util.Properties();
    java.io.File file=new java.io.File(path+TYPE[index]+".properties");
    if(file.exists())
    {
      java.io.FileInputStream fis=new java.io.FileInputStream(file);
      prop.load(fis);
      fis.close();
      fis=new java.io.FileInputStream(file);
      langu[index].load(fis);
      fis.close();
    }
  }
  /*
  file_zh_cn=new java.io.File(application.getRealPath(path+"_en.properties"));
  if(file_zh_cn.exists())
  {
    java.io.FileInputStream fis=new java.io.FileInputStream(file_zh_cn);
    prop.load(new java.io.FileInputStream(file_zh_cn));
    fis.close();
  }*/
  java.util.Enumeration enumer=prop.keys();
  int count=0;
  while(enumer.hasMoreElements())
  {
  String key=(String)enumer.nextElement();
  %>
  <tr>
    <td><%=++count%></td>
    <td><input name="keys_keys_keys" readonly="readonly" value="<%=tea.html.HtmlElement.htmlToText(key)%>"/></td>
    <%
    for(int index=0;index<langu.length;index++)
    {
      //System.out.println(index);
      String value=langu[index].getProperty(key);
      if(value==null)
      value="";
      else
      {
        len[index]+=value.length();
//       if( index==3)
        value=tea.html.HtmlElement.htmlToText(new String(value.getBytes("ISO-8859-1"),"UTF-8"));
//        else
//        value=tea.html.HtmlElement.htmlToText(new String(value.getBytes("ISO-8859-1")));
      }
    %>
    <td><input name="<%=TYPE[index]%>"  value="<%=value%>"></td>
      <%}
      %>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
  </tr>
<%}%> <tr><td>&nbsp;</td>
    <td>&nbsp;</td>
  <%for(int index=0;index<len.length;index++)
{
  out.print("<td>"+len[index]+"</td>");
}%>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<input type="button" onclick="window.location='Resources.jsp'" value="返回目录"/>
<input type="reset" value="重置"/>
<input type="submit" value="提交"/>
  </form>
</body>
</html>


