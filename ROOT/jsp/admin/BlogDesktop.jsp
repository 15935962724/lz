<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.member.Profile profile=tea.entity.member.Profile.find(teasession._rv._strR);
tea.entity.node.Blog blog=tea.entity.node.Blog.find(node.getCommunity(),teasession._rv._strR);
node=tea.entity.node.Node.find(blog.getHome());

String cssName=null;
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
  dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node="+node._nNode);
  if(dbadapter.next())
  {
    int cssjs=dbadapter.getInt(1);
    tea.entity.node.CssJs cj_obj=tea.entity.node.CssJs.find(cssjs);
    cssName=cj_obj.getName(teasession._nLanguage);
  }else
  {
    dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node=" + node.getFather() + " AND style=2");
    if (dbadapter.next())
    {
      int  cssjs = dbadapter.getInt(1);
      tea.entity.node.CssJs cj_obj=tea.entity.node.CssJs.find(cssjs);
      cssName=cj_obj.getName(teasession._nLanguage);
    }else
    {
      cssName="";
    }
  }
}catch(Exception e)
{
}finally
{
  dbadapter.close();
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link id="style_sheet" href="stylesheet/blue/commonstyle.css" type="text/css" rel="stylesheet">
<style type="text/css">
  <!--
    body,td,th {
    font-size: 9pt;
    }
  -->
</style>
</head>
<body text="#000000" link="#000000">
<div align="center">
  <br>
  <div align="center">  </div>
  <table width="550" border="0" cellspacing="1" cellpadding="0" align="center">
    <tr align="center">
      <td height="30">博 客 基 本 信 息</td>
    </tr>
  </table>
</div>
<table width="550" border="0" align="center" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#b6b6b6" bgcolor="#999999">
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">用 户 名：　</td>
    <td height="25">
      <font color="#000000"><%=profile.getMember()%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">注册日期：　</td>
    <td height="25">
      <font color="#000000"><%=profile.getTimeToString()%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">发表文章数：　</td>
    <td height="25">
      <font color="#000000"><%=blog.getReportCount()%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">回复数：　</td>
    <td height="25">
      <font color="#000000"><%=tea.entity.node.TalkbackReply.countByMember(teasession._rv._strR)%></font><%////tea.entity.node.Talkback.countIngNodes(teasession._rv.toString())+ %>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">评论数：　</td>
    <td height="25">
      <font color="#000000"><%=tea.entity.node.Talkback.countEdNodes(teasession._rv)+tea.entity.node.TalkbackReply.countByMember(teasession._rv._strR)%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">网页模版：　</td>
    <td height="25">
      <font color="#000000"><%=tea.entity.site.Template2.find(node.getCommunity(),node.getFather()).getName()%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">网页样式：　</td>
    <td height="25">
      <font color="#000000"><%=cssName%></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">已有朋友：　</td>
    <td height="25">
      <font color="#000000">
      <%=
      tea.entity.member.FriendList.countByMember(teasession._rv._strR)
      %></font>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF">
    <td width="130" height="25" align="right">域名网址：　</td>
    <td height="25">
      <font color="#000000">
        <%
          String url="http://"+request.getServerName().toString().replaceAll("blog",new String(teasession._rv._strR.getBytes("ISO-8859-1")));
  if(request.getServerPort()!=80)
  {
    url+=":"+request.getServerPort();
  }
  out.print(url);  %>
        &nbsp;&nbsp;&nbsp;
        <a href='<%=url%>' target=_blank>[预览我的网站]</a>
      </font>
    </td>
  </tr>
</table>
<table width="550" border="0" cellspacing="1" cellpadding="0" align="center">
  <tr>
    <td height="10">    </td>
  </tr>
</table>
</body>
</html>



