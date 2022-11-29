<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.ig.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();



String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>主页内容目录管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><input type="submit" value="查询"/></td>
     </tr>
</table>
</form>

<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
         <td >名称</td>
         <td >缩略图</td>
         <td >分类</td>
         <td >&nbsp;</td>
       </tr>
     <%

java.util.Enumeration enumer=Igdirectory.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int igd=((Integer)enumer.nextElement()).intValue();
  Igdirectory obj=Igdirectory.find(igd);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><img onerror="this.style.display='none';" src="<%=obj.getPicture()%>" ></td>
           <td nowrap><%=Igdirectory.SORT_TYPE[obj.getSort()]%></td>
        <td nowrap>
        <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="window.open('/jsp/admin/ig/EditIgdirectory.jsp?community=<%=teasession._strCommunity%>&igdirectory=<%=igd%>','_self');">
       <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="if(confirm('确认删除')){window.open('/servlet/EditIg?community=<%=teasession._strCommunity%>&igdirectory=<%=igd%>&act=deleteigdirectory','_self');}">
      </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.open('/jsp/admin/ig/EditIgdirectory.jsp?community=<%=teasession._strCommunity%>&igdirectory=0','_self');">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



