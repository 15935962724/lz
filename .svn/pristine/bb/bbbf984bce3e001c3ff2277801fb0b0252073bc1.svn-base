<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.net.URLEncoder"%>

<%@include file="/jsp/Header.jsp"%>
<%

int listing =0;
if(request.getParameter("listing")!=null && request.getParameter("listing").length()>0)
{
		listing = Integer.parseInt(request.getParameter("listing"));
}

if(listing==0)
{
	out.print("<link href=\"/res/"+teasession._strCommunity+"/cssjs/community.css\" rel=\"stylesheet\" type=\"text/css\">");
	out.print("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" id=\"tablecenter\">");
	out.print(" <tr id=\"TableCaption\"><td>请选择一个手动列举</td></tr></table>");

	return;
}

StringBuffer param = new StringBuffer();
StringBuffer sql = new StringBuffer();

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject	= subject.trim();
	sql.append(" and    exists   (select node from NodeLayer nl where Listed.node=nl.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+")");
	param.append("&subject = ").append(URLEncoder.encode(subject,"UTF-8"));
}


int pos = 0, pageSize =20 , count = 0;
 if (request.getParameter("pos") != null) {
   pos = Integer.parseInt(request.getParameter("pos"));
 }

param.append("?node=").append(teasession._nNode);
param.append("&listing=").append(listing);

 count = Listed.countBriefcaseItems(listing,sql.toString());

 sql.append(" order by listed desc ");


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>

<body>
<script>

function f_sn()
{

	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
	 var url = '/jsp/listing/NodeSelected.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&listing="+form1.listing.value;
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
function f_sequence(igd)
{

	var seq = document.getElementById("sequence"+igd).value;

	 sendx("/jsp/admin/edn_ajax.jsp?act=sequence&node="+igd+"&seq="+seq,
			 function(data)
			 {
					// window.location.reload();
			 }
			 );
}
</script>

<h1><%=r.getString(teasession._nLanguage, "CBBriefcaseItems")%>:手动列举:<font color="#000000" size="3"><%=Listing.find(listing).getName(teasession._nLanguage) %></font></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=Node.find(teasession._nNode).getAncestor(teasession._nLanguage)%></div>

<h2>查询</h2>
<form action="?" name="form1" method="get">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="listing" value="<%=listing %>">
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
  	<td align="right">标题名称：</td>
  	<td>
  		 <input type="text" name="subject" value="<%if(subject!=null && subject.length()>0){out.print(subject);} %>" size=60>&nbsp;&nbsp;
  	     <input type="submit" value="查询">
  	</td>

  </tr>
</form>
<h2>
列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;

<input type="button" value="选择信息" onclick="f_sn();">

</h2>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr id="TableCaption">
  	<td  nowrap>序号</td>
  	<td>标题名称</td>
  	<td>发生时间</td>
  	<td>节点路径</td>
  	<td>排序</td>
  	<td>操作</td>
  </tr>

  <%

    Enumeration e = Listed.findBriefcaseItems(listing,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
    	out.print("<tr><td colspan=10>暂无记录</td></tr>");
    }
    for(int i2=1;e.hasMoreElements();i2++)
    {
      int k = ((Integer)e.nextElement()).intValue();
      Listed listed = Listed.find(k);
      int l = listed.getNode();
      Node nobj = Node.find(l);
      %>
      <tr>
      <td nowrap><%=i2%></td>
        <td nowrap><%=nobj.getAnchor(teasession._nLanguage)%></td>
       	<td nowrap><%=nobj.getTimeToString() %></td>
       	<td nowrap><%=Node.find(nobj.getFather()).getAncestor(teasession._nLanguage)%></td>
       	<td nowrap><input type="text" name="sequence<%=l %>" id="sequence<%=l %>" value="<%=nobj.getSequence() %>" size=4 onkeyup="f_sequence('<%=l%>');"></td>
        <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID=CBDelete CLASS=CB onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteFromBriefcase?node=<%=teasession._nNode%>&listed=<%=k%>','_self');}"> </td>
      </tr>
      <%
    }


   if (count > pageSize)
   {
	   out.print("<tr><td colspan=10>"+new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)+"</td></tr>");

   }


%>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
