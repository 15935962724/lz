<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*"%>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Resource r=new Resource("/tea/ui/node/section/Sections");
Node node =Node.find(teasession._nNode);
AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);
if(!node.isCreator(teasession._rv)&&am.getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
}

Http h=new Http(request,response);


int status=Integer.parseInt(request.getParameter("status"));

String title=r.getString(teasession._nLanguage, "CBSections");


%><html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_edit(v)
{
	window.open('EditSection.jsp?node=<%=teasession._nNode%>&status=<%=status%>&section='+v, '_self');
}
function f_delete(obj,v)
{
	if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
	{
		window.open('/servlet/DeleteSection?node=<%=teasession._nNode%>&status=<%=status%>&section='+v, '_self');
		obj.disabled=true;
	}
}
function f_hidden(){
	var content="隐藏方式:<table><tr><td><input name='hiden' id='radio' type='radio' value='0'/>在本树隐藏</td>"+
	"<td><input name='hiden' id='radio' type='radio' value='1'/>在子节点隐藏</td></tr><tr><td><input name='hiden' id='radio' type='radio' value='2'/>在该节点隐藏</td><td><input name='hiden' id='radio' type='radio' CHECKED='checked' value='3'/>不隐藏</td></tr></table>";
	mt.show(content,2,'请选择隐藏方式');
	mt.ok=function(){
		var sect=document.getElementsByName("sect");
		var sects="|";
		for(var i=0;i<sect.length;i++){
			if(sect[i].checked){
				sects=sects+sect[i].value+"|";
			}
		}
		form1.secs.value=sects;
		form1.thiden.value=mt.value($name('hiden'));
		form1.nexturl.value=window.location;
		form1.submit();
	}
}
</script>

</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form action="/servlet/EditSection" name="form1" >
<input type="hidden" name="act" value="hiden"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="secs" value=""/>
<input type="hidden" name="thiden" value=""/>
<input type="hidden" name="nexturl" value=""/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
  	<td><input type="checkbox" onclick="mt.select(form1.sect,checked)"/></td>
    <td><%=r.getString(teasession._nLanguage, "Section")%></td>
    <td><%=r.getString(teasession._nLanguage, "Position")%></td>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "Access")%></td>
    <td><%=r.getString(teasession._nLanguage, "HidenStyle")%></td>
    <td>&nbsp;</td>
  </tr>
<%
for(int i = 0; i < Section.SECTION_TYPE.length; i++)
{
  ArrayList al=Section.find(node,status, i, false);
  for(int x=0;x<al.size();x++)
  {
    Section obj =(Section)al.get(x);
    int k=obj.getStyle();
    int st=obj.getStyleType();
    int l = obj.getNode();


    out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
    out.print("<td><input type=\"checkbox\" name=\"sect\" value=\""+obj.section+"\"/></td>");
    out.print("<td>"+obj.section+"："+obj.getThemename(teasession._nLanguage));
    out.print("<td>"+r.getString(teasession._nLanguage, Section.SECTION_TYPE[i]));
    out.print("<td>"+r.getString(teasession._nLanguage, Section.APPLY_STYLE[k]));
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
    out.print("<td>"+r.getString(teasession._nLanguage, Section.USER_STATUS[obj.getVisible()]));
    out.print("<td>"+r.getString(teasession._nLanguage, Section.SECTION_HideStyle[Sectionhide.find(obj.section,teasession._nNode).getHiden()]));
    out.print("<td>");
    if(AccessMember.find(teasession._nNode,teasession._rv._strV).getSection()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getSection().indexOf("/1/")!=-1 ){
    	out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit("+obj.section+")>");
    }

    //if(obj.isLayerExisted(teasession._nLanguage))

    if(obj.isLayerExisted(teasession._nLanguage) && AccessMember.find(teasession._nNode,teasession._rv._strV).getSection()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getSection().indexOf("/2/")!=-1 )
    {
      out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=f_delete(this,"+obj.section+")>");
    }
    out.print(Node.find(l).getAncestor(teasession._nLanguage));
  }
}
%><tr><td>
<input   type="button" value="批量隐藏" onclick="f_hidden()"/></td></tr>
</table>
</form>
<%
	if(AccessMember.find(teasession._nNode,teasession._rv._strV).getSection()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getSection().indexOf("/0/")!=-1 )
    {
%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" onClick="f_edit('0');">
<%} %>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
