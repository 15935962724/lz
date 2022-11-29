<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.println("没有权限不能操作");
  return;
}

Node node = Node.find(teasession._nNode);
if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview() < 2)
{
    response.sendError(403);
    return;
}


int listing = Integer.parseInt(request.getParameter("listing"));
Listing lobj = Listing.find(listing);

int pickid = 0;
if(teasession.getParameter("pickid")!=null && teasession.getParameter("pickid").length()>0)
{
  pickid = Integer.parseInt(teasession.getParameter("pickid"));
}


ArrayList al=PickManual.find(" AND listing="+listing,0,200);
int picont=al.size();
if(al.size()==1)//说明只有一个站点，则默认显示
{
  PickManual pm=(PickManual)al.get(0);
  pickid = pm.pickmanual;
}




if("EDIT".equals(teasession.getParameter("act")))
{
	String pn []  = teasession.getParameterValues("picknode");

	if(pn!=null && pn.length>0){

		for(int i2 =0;i2<pn.length;i2++)
		{
			int pnid = Integer.parseInt(pn[i2]);


			 Date date = null;

	          Listed.create(pnid, listing, date);
	          ListingCache.expire(listing);

		}
	}else
	{
		//System.out.println(teasession.getParameter("picknode2"));
		int pnid = Integer.parseInt(teasession.getParameter("picknode2"));


		 Date date = null;

         Listed.create(pnid, listing, date);
         ListingCache.expire(listing);
	}


	//添加成功
	out.print("<script>alert('添加成功'); window.returnValue='1'; window.close();</script>");
	return;

}




StringBuffer param = new StringBuffer();
StringBuffer sql = new StringBuffer();
param.append("?node=").append(teasession._nNode);
param.append("&listing=").append(listing);
param.append("&pickid=").append(pickid);

sql.append(" and hidden = 0 and finished = 1 ");

PickManual pickmanual = PickManual.find(pickid);

	if(!"".equals(pickmanual.community))
	{
	  sql.append(" and community = "+DbAdapter.cite(teasession._strCommunity));
	}

	 if(pickmanual.type!= 255)
	 {
		 sql.append(" and type= ").append(pickmanual.type);
	 }



String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject	= subject.trim();
	sql.append(" and    exists   (select node from NodeLayer nl where n.node=nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+")");
	param.append("&subject = ").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}


int pos = 0, pageSize =10 , count = 0;
 if (request.getParameter("pos") != null) {
   pos = Integer.parseInt(request.getParameter("pos"));
 }


 sql.append(" and not  exists (select node from Listed ld where n.node = ld.node   ) ");



 param.append("&pos=");


if(pickid>0)
{
	count = Node.count(sql.toString());
}






Resource r=new Resource("/tea/ui/node/listing/Picks");
r.add("/tea/ui/node/listing/ListingShow");

%><html>
<head>
<title>选择信息到手动列举</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name="dialog";
function f_on(igd)
{
	form1.pickid.value=igd;
	form1.submit();

}
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("picknode");
	var lname="";
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){
	      fname[i].checked=true;
	}
	}else{
	   for(var i=0; i<fname.length; i++){
	      fname[i].checked=false;
	   }
	}
}
function  f_sub()
{
	  if(submitCheckbox(form1.picknode,'请选择一条记录'))
	  {

		form1.act.value="EDIT";
		form1.action="?";
		form1.submit();
	}
}

function f_sub(igd)
{
	    form1.act.value="EDIT";
	    form1.picknode2.value=igd;
		form1.action="?";
		form1.submit();
}

</script>

</head>
<body>
<h1>选择信息到手动列举</h1>

<form name="form1" action="?" target="dialog">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="listing" value="<%=listing%>">
<input type='hidden' name="pickid" value="<%=pickid%>">
<input type='hidden' name="act" value="">
<input type='hidden' name="picknode2">

<%
	if(picont>1){
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>手动列举：<font color=red><%=lobj.getName(teasession._nLanguage) %></font>&nbsp;的选项</td>
  </tr>
  <tr>
  	<td>站点</td>
  	<td>类型</td>
  	<td>类型</td>
  </tr>
  <%
  for(int i=0;i<al.size();i++)
  {
    PickManual pickmanual1 =(PickManual)al.get(i);
    int j =pickmanual1.pickmanual;
    String s = pickmanual1.community;
    %>
  <tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' onclick="f_on('<%=j %>');" style="cursor:pointer" title="直接点击">
    <td><%
    if(s.equals(""))
        out.println(r.getString(teasession._nLanguage, "AllCommunities"));
        else
        out.println(s);
    %></td>
    <td>
    <%
    int type = pickmanual1.type;
    if(type == 255)
    {
   	 out.println(r.getString(teasession._nLanguage, "AllTypes"));
    }else if(type<1024)
    {
     	 out.println(r.getString(teasession._nLanguage, Node.NODE_TYPE[type]));
    }else if(type<65535)
    {
     	 out.println(Dynamic.find(type).getName(teasession._nLanguage));
    }else
    {
      TypeAlias ta = TypeAlias.find(type);
      out.println(ta.getName(teasession._nLanguage));
    }
    %>
    </td>
    <td><%=r.getString(teasession._nLanguage,PickManual.CLASSES_TYPE[pickmanual1.classes]) %></td>
  </tr>

 <%} %>

</table>

<%} %>
<h2>查询</h2>


<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
  	<td align="right">标题名称：</td>
  	<td>
  		 <input type="text" name="subject" value="<%if(subject!=null && subject.length()>0){out.print(subject);} %>" size=60>&nbsp;&nbsp;
  	     <input type="submit" value="查询">
  	</td>

  </tr>
</table>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条记录&nbsp;)&nbsp;</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  	  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
    <td>序号</td>
    <td>标题名称</td>
    <td>所在站点</td>

  </tr>
  <%

  if(pickid>0)
 {





	  Enumeration e2 = Node.find(sql.toString(),pos,pageSize);
	  for(int i=1;e2.hasMoreElements();i++)
	  {
		  int nid = ((Integer)e2.nextElement()).intValue();
		  Node nobj = Node.find(nid);
  %>
<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' >
  <td width=1><input type=checkbox name=picknode value="<%=nid%>" style="cursor:pointer"></td>
    <td title="单击这条记录，可以选中" style="cursor:pointer" onclick="f_sub('<%=nid %>');"><%=pos+i %></td>
    <td title="单击这条记录，可以选中" style="cursor:pointer" onclick="f_sub('<%=nid %>');"><%=nobj.getSubject(teasession._nLanguage) %></td>
    <td title="单击这条记录，可以选中" style="cursor:pointer" onclick="f_sub('<%=nid %>');"><%=nobj.getCommunity() %></td>
  </tr>
  <%
  	}


  %>
  <%if(count>pageSize){ %>
<tr><td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(), pos, count,pageSize)%></td></tr>
<%} %>


<%}else
{
	out.print("<tr><td colspan=20 align=center>请选择上面的站点，直接用鼠标点击记录</td></tr>");
}
%>
</table>

<input  type="button" class="edit_button" value="提交" onclick="f_sub();" >
<input type="button" class="edit_button" value="关闭" onclick="window.close()">
</FORM>

</body>
</html>
