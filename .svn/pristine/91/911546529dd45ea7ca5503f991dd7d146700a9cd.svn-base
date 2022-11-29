<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*" import="tea.db.*" import="tea.entity.site.*" import="tea.resource.*"%><%

TeaSession teasession = new TeaSession(request);

Node node =Node.find(teasession._nNode);
AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);
if(!node.isCreator(teasession._rv)&&am.getPurview()<2)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
}

Http h=new Http(request,response);


String tmp=request.getParameter("status");
int status=tmp==null?0:Integer.parseInt(tmp);

Resource r=new Resource();
String title=r.getString(teasession._nLanguage, "CBListings");

%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_edit(v)
{
  window.open('EditListing.jsp?node=<%=teasession._nNode%>&status=<%=status%>&listing='+v, '_self');
}
function f_delete(obj,v)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    window.open('/servlet/DeleteListing?node=<%=teasession._nNode%>&status=<%=status%>&listing='+v, '_self');
    obj.disabled=true;
  }
}


function f_hidden(){
	var content="隐藏方式:<table><tr><td><input name='hiden' id='radio' type='radio' value='0'/>在本树隐藏</td>"+
	"<td><input name='hiden' id='radio' type='radio' value='1'/>在子节点隐藏</td></tr><tr><td><input name='hiden' id='radio' type='radio' value='2'/>在该节点隐藏</td><td><input name='hiden' id='radio' type='radio' CHECKED='checked' value='3'/>不隐藏</td></tr></table>";
	mt.show(content,2,'请选择隐藏方式');
	mt.ok=function(){
		var sect=document.getElementsByName("listbtn");
		var sects="|";
		for(var i=0;i<sect.length;i++){
			if(sect[i].checked){
				sects=sects+sect[i].value+"|";
			}
		}
		form1.listsid.value=sects;
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

<form action="/servlet/EditListing" name="form1" >
<input type="hidden" name="act" value="hiden"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="thiden"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="listsid"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
  	<td><input type="checkbox" onclick="mt.select(form1.listbtn,checked)"/></td>
    <td><%=r.getString(teasession._nLanguage, "Listing")%></td>
    <td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td><%=r.getString(teasession._nLanguage, "Position")%></td>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "HidenStyle")%></td>
    <td>&nbsp;</td>
  </tr>
<%
for(int i = 0; i <Listing.LISTING_POSITION.length; i++)
{
  ArrayList al=Listing.find(node,status, i,false);
  for(int jj=0;jj<al.size();jj++)
  {
    int j=((Integer)al.get(jj)).intValue();
    Listing obj=Listing.find(j);
    int k = obj.getType();
    int style=obj.getStyle();
    int st=obj.getStyleType();
    int l = obj.getNode();
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td><input type=\"checkbox\" name=\"listbtn\" value=\""+obj.listing+"\"/></td>");
    out.print("<td>"+obj.listing+"：" + obj.getName(teasession._nLanguage));
    out.print("<td>"+r.getString(teasession._nLanguage,Listing.LISTING_TYPE[k]));
    out.print("<td>"+r.getString(teasession._nLanguage, Listing.LISTING_POSITION[obj.getPosition()]));
    out.print("<td>"+r.getString(teasession._nLanguage, Section.APPLY_STYLE[style]));
    if(style!=0)
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
    out.print("<td>"+r.getString(teasession._nLanguage, Listing.LISTING_HideSyle[Listinghide.find(obj.listing,teasession._nNode).getHiden()]));
    out.print("<td>");
    if(AccessMember.find(teasession._nNode,teasession._rv._strV).getListing()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getListing().indexOf("/1/")!=-1 )
    {
   		 out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBEdit CLASS=CB onClick=f_edit("+obj.listing+");>");
    }
   // if(obj.isLayerExisted(teasession._nLanguage))
	if(obj.isLayerExisted(teasession._nLanguage)&&AccessMember.find(teasession._nNode,teasession._rv._strV).getListing()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getListing().indexOf("/2/")!=-1 )
    {
      out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBDelete CLASS=CB onClick=f_delete(this,"+obj.listing+");>");
    }
    out.print(Node.find(l).getAncestor(teasession._nLanguage));


    if(k == 1 || obj.getPick() == 0)
    {
    	if(AccessMember.find(teasession._nNode,teasession._rv._strV).getListing()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getListing().indexOf("/3/")!=-1 )
    	{
    		 out.print("<input type='button' value="+r.getString(teasession._nLanguage, "CBBriefcaseItems")+" ID=CBBriefcaseItems CLASS=CB onClick=\"window.open('/jsp/listing/BriefcaseItems.jsp?node="+teasession._nNode+"&listing="+obj.listing+"', '_self');\">");
    	}

    }
    out.print("</td></tr>");
  }
}
%><tr><td>
<input   type="button" value="批量隐藏" onclick="f_hidden()"/></td></tr>
</table>
</form>
<%
	if(AccessMember.find(teasession._nNode,teasession._rv._strV).getListing()!=null &&AccessMember.find(teasession._nNode,teasession._rv._strV).getListing().indexOf("/0/")!=-1 )
		{
%>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0);">
<%} %>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
