<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.resource.Resource"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

String referer=request.getHeader("referer");
if(referer==null||referer.indexOf(request.getServerName())==-1)
{
	response.sendError(403);
	return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}




String nexturl=request.getParameter("nexturl");

int help=Integer.parseInt(request.getParameter("help"));


Resource r=new Resource();

String subject=null,keywords=null,content=null;
int type=0,id=0;
if(help!=0)
{
  Help obj=Help.find(help);
  subject=obj.getSubject(teasession._nLanguage).replaceAll("\"","&quot;");
  keywords=obj.getKeywords(teasession._nLanguage);
  content=obj.getContent(teasession._nLanguage).replaceAll("&","&amp;").replaceAll("</","&lt;/");
  type=obj.getType();
  id=obj.getId();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.id.value="<%=id%>";
  form1.subject.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>帮助创建/编辑</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditHelp" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type=hidden name="help" value="<%=help%>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="edithelp"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>主题</td>
       <td nowrap><input name="subject" type="text" value="<%if(subject!=null)out.print(subject);%>" alt="主题" size="40"></td>
     </tr>
     <tr>
       <td>关键词</td>
       <td nowrap><input name="keywords" type="text" value="<%if(keywords!=null)out.print(keywords);%>" size="40"></td>
     </tr>
     <tr>
       <td>内容</td>
       <td nowrap>
       <input type="button" value="上传图片" onclick="window.open('/jsp/site/StructureUpload.jsp?community=<%=teasession._strCommunity%>&repository=../../helpimg','','width=500,height=250');"/><br/>
       <textarea name="content" cols="80" rows="12" alt="内容" ><%if(content!=null)out.print(content);%></textarea></td>
     </tr>
     <tr>
       <td>菜单</td>
       <td nowrap><select name="menuid" alt="菜单">
       <option value="0">------------</option>
       <%
       int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);
       Enumeration e=AdminFunction.findByFather(root);
       while(e.hasMoreElements())
       {
         int af_id=((Integer)e.nextElement()).intValue();
         AdminFunction af_obj=AdminFunction.find(af_id);
         if(af_obj.getType()!=0)continue;
         out.print("<OPTGROUP label='"+af_obj.getName(teasession._nLanguage)+"'>");
         Enumeration e2=AdminFunction.findByFather(af_id);
         while(e2.hasMoreElements())
         {
           af_id=((Integer)e2.nextElement()).intValue();
           af_obj=AdminFunction.find(af_id);
           out.print("<option value='"+af_id+"'>"+af_obj.getName(teasession._nLanguage));
           if(af_obj.getType()!=0)continue;
           Enumeration e3=AdminFunction.findByFather(af_id);
           while(e3.hasMoreElements())
           {
             af_id=((Integer)e3.nextElement()).intValue();
             af_obj=AdminFunction.find(af_id);
             out.print("<option value='"+af_id+"'>　├"+af_obj.getName(teasession._nLanguage));
           }
         }
       }
       %></select>
       </td>
     </tr>
     <tr>
       <td>&nbsp;</td>
       <td nowrap>
         <input type="submit" value="提交">
         <input type="reset" value="重置" onClick="defaultfocus();">
         <input type="button" value="返回" onClick="history.back();">
       </td>
     </tr>
</table>
</form>

<script>
form1.menuid.value="<%=id%>";
</script>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

