<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %><%@page import="tea.entity.*" %>
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

Resource r=new Resource("/tea/resource/columnlist");

String nexturl=teasession.getParameter("nexturl");

int columnid=0;
String tmp=teasession.getParameter("columnid");
if(tmp!=null&&tmp.length()>0)
{
  columnid=Integer.parseInt(tmp);
}

NodeAccessColumn nac = NodeAccessColumn.find(columnid);
Node n=nac.node>0?Node.find(nac.node):null;

%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "ColumnManage")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/layer.js" type="text/javascript" ></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript">
function f_submit()
{
  return( submitText(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')
		  &&submitText(form1.node,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Node")%>'));
}
function f_load()
{
  form1.name.focus();
}
function f_show(u)
{
  window.showModalDialog("/jsp/admin/popedom/"+u+"?community=<%=teasession._strCommunity%>",self,'dialogwidth:500px;dialogheight:500px');
}
function f_selNode()
{
	var rs=window.showModalDialog('/jsp/general/SelColumnNode.jsp?info='+encodeURIComponent('项目节点'),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
    //alert(rs);
    if(!rs)return;
    var arr=rs.split(",");
    form1.node.value=arr[0];
    form1.nodeName.value=arr[1];
    var showmsg = document.getElementById("showmsg");
    mt.send("/servlet/EditColumnManage?act=check_node&columnid="+form1.columnid.value+"&node="+form1.node.value,function(d)
    {
        if(d=='false')
        {
        	showmsg.innerHTML='该节点已被使用。';
        	form1.cbsubmit.disabled=true;
        	//showmsg.className='err';
        }else{
        	showmsg.innerHTML='';
        	form1.cbsubmit.disabled=false;
        }
    });
}
function f_checksource()
{
	var showmsg2 = document.getElementById("showmsg2");
	form1.source.value=form1.source.value.replace(/\s/g, '');
	if(form1.source.value!="")
	{
		mt.send("/servlet/EditColumnManage?act=check_source&columnid="+form1.columnid.value+"&source="+form1.source.value,function(d)
				{
					        if(d=='false')
					        {
					        	showmsg2.innerHTML='该来源已被使用。';
					        	form1.cbsubmit.disabled=true;
					        	//showmsg.className='err';
					        }else{
					        	showmsg2.innerHTML='';
					        	form1.cbsubmit.disabled=false;
					        }
					    });
	}else{
		showmsg2.innerHTML='';
    	form1.cbsubmit.disabled=false;
	}
	
}

</SCRIPT>
</head>
<BODY onLoad="f_load();" id="bodynone">
<div id="wai">
<h1><%=r.getString(teasession._nLanguage, "AddColumnManage")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="/servlet/EditColumnManage" method="post" enctype="multipart/form-data">
<input type=hidden name="columnid" value="<%=columnid%>">
<input type=hidden name="act" value="editcolumnManage"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="sequence" />

<table cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
<tr>
  <td><%=r.getString(teasession._nLanguage, "Name")%>：</td>
  <td><input name="name" value="<%out.print(MT.f(nac.name));%>" size="40" >&nbsp;*</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Node")%>：</td>
  <td>
  	<input type="hidden" name="node" value="<%out.print(MT.f(nac.node));%>" size="40" >
  	<input name="nodeName" readonly="readonly" value="<%out.print(n!=null?MT.f(n.getSubject(teasession._nLanguage)):"");%>" size="40" >
  	<input type='button' value='选择' onclick=f_selNode(); >&nbsp;*
  	<span id="showmsg" style="color:red;"></span>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Source")%>：</td>
  <td>
  	<input name="source" value="<%out.print(MT.f(nac.source));%>" size="40" onchange="f_checksource();" >
  	<span id="showmsg2" style="color:red;"></span>
  	<br/><span>注：用于推广使用，例如来源写成news,则http://www.域名.com/news.htm或者http://www.域名.com/news.html则是设置的节点页面。</span>	
  </td>
</tr>

<TR align="center">
  <td  colSpan="2" class="TableControl">
    <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" name="cbsubmit" onClick="return f_submit();" >
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back();"/>
</td>
</tr>
</table>
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
</body>
</html>
