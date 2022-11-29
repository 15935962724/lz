<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.resource.Resource"  %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String menuid=request.getParameter("id");
param.append("&id=").append(menuid);

String q=(request.getParameter("q"));
if(q!=null)
{
	param.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
	String q_ = DbAdapter.cite("%" + q.replace(' ', '%') + "%");
	sql.append(" AND help IN ( SELECT help FROM HelpLayer WHERE language=").append(teasession._nLanguage).append(" AND subject LIKE ").append(q_).append(" OR content LIKE ").append(q_).append(")");
}

int type=-1;
String _strType=(request.getParameter("type"));
if(_strType!=null&&_strType.length()>0)
{
	type=Integer.parseInt(_strType);
	param.append("&type=").append(type);
	sql.append(" AND type=").append(type);
}

int pos=0;
String _strPos=(request.getParameter("pos"));
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");
int count=Help.countByCommunity(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<h1>系统帮助管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="id" value="<%=menuid%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>关键字
       <input name="q" value="<%if(q!=null)out.print(q);%>"></td>
<%--       <td>类别
       <select name="type">
<option value="">----------------
<%
for(int index=0;index<Help.HELP_TYPE.length;index++)
{
            out.print("<option value="+index);
            if(type==index)
            out.println(" SELECTED ");
            out.println(" >"+Help.HELP_TYPE[index]);
}
%></select></td>--%>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>

<form name="form2" action="/servlet/EditHelp" enctype="multipart/form-data" method="POST" target="_ajax" onSubmit="">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="nexturl">
<input type=hidden name="help" value="0">
<input type=hidden name="act">

<h2>列表 (<%=count%>)</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
     <td nowrap>主题</TD>
<%--     <TD nowrap>分类</TD>--%>
     <TD nowrap>点击率</TD>
     <TD nowrap></TD>
   </tr>
<%
java.util.Enumeration enumer=Help.findByCommunity(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int help=((Integer)enumer.nextElement()).intValue();
  Help obj=Help.find(help);

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><input type="checkbox" name="helps" value="<%=help%>"/></td>
<td nowrap><%=MT.f(obj.getSubject(teasession._nLanguage))%></td>
<%--<td nowrap><%=Help.HELP_TYPE[obj.getType()]%></td>--%>
<td nowrap><%=obj.getHits()%></td>
<td nowrap><input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onclick="mt.act('edit',<%=help%>);" >
<input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onclick="mt.act('del',<%=help%>);" >
</td>
</tr>
<%
}
%>
<tr><td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
</table>
<input type="checkbox" onclick="mt.select(form2.helps,checked)" id="_sel"/><label for="_sel">全选</label>
<input type="button" value="批量删除" name="multi" onclick="mt.act('del',0)"/>
<input type="button" value="批量导出" onclick="mt.act('exp',0)"/>
<input type="button" value="批量导入"/><input type="file" name="file" size='1' style='width:76px;margin-left:-76px;filter:alpha(opacity=0);opacity:0' />
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="mt.act('edit',0);">
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.disabled(form2.helps);
mt.act=function(a,id)
{
  form2.act.value=a;
  form2.help.value=id;
  if(a=='del')
  {
    mt.show("确认删除？",2,"form2.submit()");
    return;
  }else if(a=='edit')
  {
    form2.action='/jsp/site/EditHelp.jsp';
    form2.target="_self";
    form2.method="get";
  }
  form2.submit();
};
form2.file.onchange=function()
{
  form2.act.value='imp';
  form2.submit();
  mt.show('文件上传中。。。',0);
};
</script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
