<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r = new Resource();
String nexturl = request.getRequestURI()+"?community="+teasession._strCommunity+request.getContextPath();


  StringBuffer sql = new StringBuffer(" and member ="+DbAdapter.cite(teasession._rv.toString()));
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

 int pos = 0, pageSize = 10, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Supply.count(teasession._strCommunity,sql.toString());

  sql.append(" order by times desc ");

  int id = 0;
  if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     id = Integer.parseInt(teasession.getParameter("id"));

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<script type="">
function f_edit(igd)
{
   form1.nodes.value = igd;
   form1.action ='/jsp/type/supply/EditSupply.jsp';
   form1.submit();
}
function f_delete(igd)
{
  if(confirm('您确认要删除！'))
    {
      form1.nodes.value=igd;
      form1.act.value="SupplyList";
      form1.action ='/servlet/EditSupplys';
      form1.submit();
    }
}

function f_qbdelete()
{


  var m=0;
  flag=false;
  var f=form1.checkbox_1;
  if(f.length)
  {
    for(i=0;i<f.length;i++)
    {
      if(f[i].checked)
      {
        flag=true;
        m++;
      }
    }
    if(!flag)
    {
      alert("你没有选中任何数据");
      return false;
    }

  }else
  {
    if(!f.checked)
    {
      alert("你没有选中任何数据");
      return false;
    }
  }




  if(confirm('您确认要删除！'))
  {
    form1.act.value='qbdelete';
    form1.action ='/servlet/EditSupplys';
    form1.submit();
  }
}

</script>
<h1>供求信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=form1 METHOD=POST action="/jsp/type/supply/EditSupply.jsp"  >
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="sid">
<input type="hidden" name="act" >
<input type="hidden" name="nodes"/>

<input type="hidden" name="id" value="<%=id%>"/>
  <%-- <input type="button" value="全选" checked="true" onclick="selectAll(form1.checkbox_1,checked);checked=!checked;"/>--%>


<table border="0" cellpadding="0" cellspacing="0" id="anniu1">
<tr><td width="65%" valign="middle">
  <input type="button" value="全选"  onclick="selectAll(form1.checkbox_1,true);"/>
  <input type="button" value="取消"  onclick="selectAll(form1.checkbox_1,false);"/>
  <input type="button" value="删除" onClick="f_qbdelete();"/></td>
<td width="35%" align="right" valign="middle"><input name="button" type="button" onClick="window.open('/jsp/type/supply/EditSupply.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');" value="发布供应信息" /></td>
</tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="jcfw">
<tr>
	<tr id="mptuob">

       <td>主题</td>
       <td>发布日期</td>
       <td>编辑</td>
       <td>删除</td>
    </tr>
	<tr><td colspan="3" height="10px"></td></tr>
    <%
       java.util.Enumeration e = Supply.find(teasession._strCommunity,sql.toString(),pos,pageSize);
         if(!e.hasMoreElements())
       {
         out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
       }
       while (e.hasMoreElements())
       {
         int nodeid = ((Integer)e.nextElement()).intValue();
         Supply sobj = Supply.find(nodeid);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td id="wu">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="checkbox_1" value="<%=nodeid%>"/>
        &nbsp;<a href="/jsp/type/supply/SupplyShow.jsp?community=<%=teasession._strCommunity%>&nodeid=<%=nodeid%>"> <%=sobj.getSubject()%></a></td>
      <td align="center"><%=sobj.getTimesToString()%></td>

      <td align="center"><input type="button" value="" onClick="f_edit('<%=nodeid%>');" id="xiugai"/> </td>
      <td align="center"><input type="button" value="" onClick="f_delete('<%=nodeid%>');" id="shanchu"/></td>
    <%} %>
<tr>
  <%if (count > pageSize) {  %>
    <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td>
  <%}  %>
  </tr>
  </table>

</FORM>





<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
