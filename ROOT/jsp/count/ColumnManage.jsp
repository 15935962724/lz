<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.MT"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.access.NodeAccessColumn"%>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=teasession.getParameter("id");

Resource r=new Resource("/tea/resource/columnlist");

String nexturl=teasession.getParameter("nexturl");

SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer par=new StringBuffer();
StringBuffer sql = new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
sql.append(" AND community=").append("'"+teasession._strCommunity+"'");
par.append("&id=").append(menuid);
String name = request.getParameter("name");
if(name!=null&&name.length()>0){
  par.append("&name=").append(name);
  sql.append(" AND name like '%"+name+"%'");
}
int nodeid = Integer.parseInt(request.getParameter("nodeid")!=null&&!request.getParameter("nodeid").equals("")?request.getParameter("nodeid"):"0");
Node nod = null;
if(nodeid!=0){
	  nod = Node.find(nodeid);
	  par.append("&nodeid=").append(nodeid);
	  sql.append(" AND node="+nodeid);
}
String source = request.getParameter("source");
if(source!=null&&source.length()>0){
  par.append("&source=").append(name);
  sql.append(" AND source like '%"+source+"%'");
}
par.append("&pos=");

int sum=NodeAccessColumn.count(sql.toString());
%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "ColumnManage")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT language="JavaScript" type="">
function f_edit(obj,id)
{
  form2.action="/jsp/count/EditColumnManage.jsp";
  form2.method="get";
  form2.columnid.value=id;
  form2.nexturl.value=location;
  obj.disabled=true;
  obj.value="Load...";
  form2.submit();
}
function f_delete(obj,id)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form2.columnid.value=id;
    form2.act.value='deletecolumnManage';
    form2.nexturl.value=location;
    obj.disabled=true;
    obj.value="Load...";
    form2.submit();
  }
}
function f_move(id,bool)
{
  form2.act.value='movecolumnid';
  form2.columnid.value=id;
  form2.nexturl.value=location;
  form2.sequence.value=bool;
  form2.submit();
}

function f_submit()
{
  return( submitInteger(form2.pid,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Code")%>')
		&&submitText(form2.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'))
}
function f_load()
{
  if(form2.nexturl.value.length<5)
  {
    form2.nexturl.value=location;
  }
}

function f_selNode()
{
	var rs=window.showModalDialog('/jsp/general/SelColumnNode.jsp?type=query&info='+encodeURIComponent('项目节点'),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
    //alert(rs);
    if(!rs)return;

    var arr=rs.split(",");
    form1.nodeid.value=arr[0];
    form1.nodeName.value=arr[1];
}
</SCRIPT>
</head>
<BODY onLoad="f_load();" id="bodynone">
<div id="wai">
<h1><%=r.getString(teasession._nLanguage, "ColumnManage")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?">
<input type=hidden name="id" value="<%=menuid%>"/>

<h2>查询</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<tr>
  <td colspan="2" align="left"><%=r.getString(teasession._nLanguage, "Name")%><input id="name" name="name" value="<%if(name!=null)out.print(name);%>"/>
  <td colspan="2" align="left">
  	<%=r.getString(teasession._nLanguage, "Node")%>
  	<input type="hidden" name="nodeid" value="<%out.print(MT.f(nodeid));%>" size="40" >
  	<input name="nodeName" readonly="readonly" value="<%out.print(nod!=null?MT.f(nod.getSubject(teasession._nLanguage)):"");%>" size="40" >
  	<input type='button' value='选择' onclick=f_selNode(); >
  	
  <td colspan="2" align="left"><%=r.getString(teasession._nLanguage, "Source")%><input id="source" name="source" value="<%if(source!=null)out.print(source);%>"/>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" action="/servlet/EditColumnManage" method="post" enctype="multipart/form-data">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="columnid" value="0">
<input type=hidden name="act" value="editcolumnid"/>
<input type=hidden name="id" value="<%=menuid%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="sequence" />
<h2>列表 <%=sum%></h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Node")%></td>
    <td><%=r.getString(teasession._nLanguage, "Source")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
if(sum>0)
{
	Iterator it=NodeAccessColumn.find(sql.toString()+" order by nac.time desc",pos,15).iterator();
	for(int i=1+pos;it.hasNext();i++)
	{
		NodeAccessColumn nac=(NodeAccessColumn)it.next();
		Node n=Node.find(nac.node < 1 ? 0 : nac.node);
    out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td>"+nac.name);
    out.write("<td align=center>&nbsp;"+n.getSubject(teasession._nLanguage));
    out.write("<td align=center>&nbsp;"+nac.source);
    out.write("<td align=center>&nbsp;"+(nac.time!=null?formatter.format(nac.time):""));
    out.write("<td align=center><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" onclick=f_edit(this,"+nac.columnid+")> ");
    out.write("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onclick=f_delete(this,"+nac.columnid+")>\r\n");
  }
  if(sum>15)out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,15)+"</td></tr>");
}else
{
  out.print("<tr><td colspan='5' align='center'>暂无栏目节点");
}

%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" onclick="f_edit(this,0)">
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
</body>
</html>
