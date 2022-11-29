<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.ui.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();


%>
<html>
<head>
<title>社区XML设置列表</title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script>
   function f_edit(igd)
   {
     form1.xmlid.value=igd;
     form1.action="/jsp/community/EditCommunityXml.jsp";
     form1.submit();
   }
   function f_delete(igd)
   {
     if(confirm('您确认要删除！'))
     {
       form1.xmlid.value=igd;
       form1.act.value='DELETE';
       form1.action="/servlet/EditCommunityXml";
       form1.submit();
     }
   }
</script>
<h1>社区XML设置列表</h1>
<div id="head6"><img height="6" alt=""></div>
   <br>
   <FORM name=form1 METHOD=POST action="?" >
   <input type="hidden" name="xmlid">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
        <input type="hidden" name="nexturl" value="<%=nexturl%>">
               <input type="hidden" name="act" >
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>XML名称</td>
         <td>XML路径</td>
          <td>操作</td>
       </tr>
       <%
          java.util.Enumeration e = CommunityXml.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          if(!e.hasMoreElements())
          {
            out.print("<tr><td  colspan=5 align=center>暂无记录</td></tr>");
          }
          while(e.hasMoreElements())
          {
            int xmlid = ((Integer)e.nextElement()).intValue();
            CommunityXml cxobj = CommunityXml.find(xmlid);
            String xmlpath = "/res/"+teasession._strCommunity+"/xml/"+cxobj.getSubject()+".xml";
       %>
       <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
         <td><%=cxobj.getSubject() %></td>
         <td><input type="text" value="<%=xmlpath%>" size="50" readonly="readonly"/></td>
         <td><a href="#" onclick="f_edit('<%=xmlid%>');">编辑</a>&nbsp<a href="#" onclick="f_delete('<%=xmlid%>');">删除</a> </td>
       </tr>
       <%}%>
     </table>
     <br>
     <input type="button" value="添加XML文件"  onclick="window.open('/jsp/community/EditCommunityXml.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
</FORM>


</body>
</html>
