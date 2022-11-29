<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%
request.setCharacterEncoding("UTF-8");

if("POST".equals(request.getMethod()))
{
  String act=request.getParameter("act");
  if("db".equals(act))
  {
    String[] arr=
    {
      "DELETE FROM ListingLayer WHERE listing NOT IN(SELECT listing FROM Listing)",
      "DELETE FROM ListingDetail WHERE listing NOT IN(SELECT listing FROM Listing)",
      "DELETE FROM SectionLayer WHERE section NOT IN(SELECT section FROM Section)",
      //"DELETE FROM CssJsLayer   WHERE cssjs   NOT IN(SELECT cssjs   FROM CssJs)",
    };
    String[] sites={"CommunityLayer","Node","BBSLevel","Communitybbs","Dept","Forum","IntegralRecord","Keywords","Logs"};
    String[] nodes={"Listing","Section","CssJs","NodeLayer","Report","ReportLayer","Album","AmityLink","BBS","Category","Event","Insure"};
    int j=0;
    DbAdapter db=new DbAdapter();
    try
    {
      for(int i=0;i<sites.length;i++)
      {
        out.println(sites[i]);
        out.flush();
        j+=db.executeUpdate("DELETE FROM "+sites[i]+" WHERE community NOT IN(SELECT community FROM Community)");
      }
      for(int i=0;i>0;j+=i)
      {
        i=db.executeUpdate("DELETE FROM Node WHERE father NOT IN(SELECT node FROM Node) AND father!=0");
      }
      for(int i=0;i<nodes.length;i++)
      {
        out.println(nodes[i]);
        out.flush();
        j+=db.executeUpdate("DELETE FROM "+nodes[i]+" WHERE node NOT IN(SELECT node FROM Node)");
      }
      for(int i=0;i<arr.length;i++)
      {
        out.println(arr[i]);
        out.flush();
        j+=db.executeUpdate(arr[i]);
      }
    }finally
    {
      db.close();
    }
    out.print("共删除："+j);
  }else if("cache".equals(act))
  {
    int j=0;
    Cache[] c={
      Entity._cache
      ,Node._cache,Listing._cache,Section._cache,CssJs._cache
      //,tea.entity.admin.Role.c
      ,tea.entity.member.Profile._cache
      ,tea.entity.site.Community._cache
      ,AdminUsrRole._cache,AdminUnit._cache
  };
    for(int i=0;i<c.length;i++)
    {
      j+=c[i].size();
      c[i].clear();
    }
    out.print("共删除："+j);
  }
  return;
}
//java.lang.reflect.Field fie=Flowview.class.getDeclaredField("_cache");
//fie.setAccessible(true);
//Cache c=(Cache)fie.get(null);
//c.clear();

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>无标题文档</title>
</head>

<body>
<form name="form1" action="?" method="post">
<input type="hidden" name="act"/>
<table border="0">
  <tr>
    <td>网址：</td>
    <td><input name="url" type="text" size="100" /></td>
    </tr>
  <tr>
    <td>保存到：</td>
    <td><input name="path" value="<%=application.getRealPath("/")%>" size="100" /></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit"  value="提交" /></td>
    </tr>
</table>

<input type="button" value="清库" onclick="f('db')"/>
<input type="button" value="清缓存" onclick="f('cache')"/>
</form>

<script>
function f(a)
{
  form1.act.value=a;
  form1.submit();
}
</script>
</body>
</html>
