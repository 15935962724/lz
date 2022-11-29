<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*"%>
<%
TeaSession teasession = new TeaSession(request);

AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);
if(am.getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Http h=new Http(request,response);


int status=Integer.parseInt(request.getParameter("status"));

Resource r=new Resource();
String title=r.getString(teasession._nLanguage,"CBCSS/JS");


Node node = Node.find(teasession._nNode);

%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_edit(v)
{
	window.open('EditCssJs.jsp?node=<%=teasession._nNode%>&status=<%=status%>&cssjs='+v, '_self');
}
function f_action(act,id,seq)
{
  if(act=="delete")
  {
    if(!confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
    {
      return false;
    }
  }
  form1.act.value=act;
  form1.cssjs.value=id;
  form1.sequence.value=seq;
  form1.nexturl.value=location;
  form1.submit();
}

function f_hidden(){
	var content="隐藏方式:<table><tr><td><input name='hiden' id='radio' type='radio' value='0'/>在本树隐藏</td>"+
	"<td><input name='hiden' id='radio' type='radio' value='1'/>在子节点隐藏</td></tr><tr><td><input name='hiden' id='radio' type='radio' value='2'/>在该节点隐藏</td><td><input name='hiden' id='radio' type='radio' CHECKED='checked' value='3'/>不隐藏</td></tr></table>";
	mt.show(content,2,'请选择隐藏方式');
	mt.ok=function(){
		var sect=document.getElementsByName("cssjsid");
		var sects="|";
		for(var i=0;i<sect.length;i++){
			if(sect[i].checked){
				sects=sects+sect[i].value+"|";
			}
		}
		form1.cssjsids.value=sects;
		form1.thiden.value=mt.value($name('hiden'));
		form1.nexturl.value=window.location;
		form1.act.value="hiden";
		form1.submit();
	}
}
</script>
</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCssJs" method="post" >
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="status" value="<%=status%>"/>
<input type="hidden" name="sequence" />
<input type="hidden" name="nexturl" />
<input type="hidden" name="cssjs" />
<input type="hidden" name="act" />

<input type="hidden" name="cssjsids" value=""/>
<input type="hidden" name="thiden" value=""/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
  	<td><input type="checkbox" onclick="mt.select(form1.cssjsid,checked)"/></td>
    <td>Css\Js</td>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "HidenStyle")%></td>
    <td><%=r.getString(teasession._nLanguage, "Sequence")%></td>
    <td>&nbsp;</td>
  </tr>
<%
boolean flag=false;
ArrayList al=CssJs.find(node,status,false);
for(int i=0;i<al.size();i++)
{
   CssJs cj=(CssJs)al.get(i);
   Cssjshide ch=Cssjshide.find(cj.cssjs,teasession._nNode);
   int realnode=cj.getNode();
   int k = cj.getStyle();
   int st=cj.getStyleType();
   out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
   out.print("<td><input type=\"checkbox\" name=\"cssjsid\" value=\""+cj.cssjs+"\"/></td>");
   out.print("<td>"+cj.cssjs+":"+cj.getName(teasession._nLanguage));
   out.println("<td>"+r.getString(teasession._nLanguage, Section.APPLY_STYLE[k]));
   if(k!=0)
   {
     if(st==255)
     {
       out.print(r.getString(teasession._nLanguage, "AllTypes"));
     }else if(st<1024)
     {
       out.print(r.getString(teasession._nLanguage, Node.NODE_TYPE[st]));
     }else if(st<65535)
     {
       out.print(Dynamic.find(st).getName(teasession._nLanguage));
     }else
     {
       out.print(TypeAlias.find(st).getName(teasession._nLanguage));
     }
   }
   out.print("<td>"+r.getString(teasession._nLanguage,Section.SECTION_HideStyle[ch.getHiden()]));
   out.print("<td>&nbsp;");
   if(realnode==teasession._nNode)
   {
     if(flag)
     out.print("<a href=javascript:f_action('move','"+cj.cssjs+"',true)><img src='/tea/image/public/arrow_up.gif'></a>");
     else
     out.write("　&nbsp;");
     if(i+1<al.size())
     out.print("<a href=javascript:f_action('move','"+cj.cssjs+"',false)><img src='/tea/image/public/arrow_down.gif'></a>");
     flag=true;
   }
   if(AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs().indexOf("/1/")!=-1 )
   {
   		out.print("<td><input type=button value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit('"+cj.cssjs+"')>");
   }
  // if(cj.isLayerExisted(teasession._nLanguage))
	if(AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs().indexOf("/2/")!=-1 )
   {
     out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=f_action('delete',"+cj.cssjs+")>");
   }
   out.print(Node.find(realnode).getAncestor(teasession._nLanguage));
}
%><tr><td>
<input   type="button" value="批量隐藏" onclick="f_hidden()"/></td></tr>
</table>
<%
	if(AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getCssjs().indexOf("/0/")!=-1 )
		{
%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0)">
<%} %>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
