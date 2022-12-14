<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}




Resource r=new Resource("/tea/resource/Photography");

int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}

String nexturl = request.getRequestURI()+"?membertype="+membertype+request.getContextPath();




StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" AND  m.membertype ="+membertype +" and p.member !="+DbAdapter.cite("webmaster"));

String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}

param.append("&membertype=").append(membertype);


String firstname = teasession.getParameter("firstname");
if(firstname!=null && firstname.length()>0){
	firstname = firstname.trim();
	sql.append(" and p.member in (select member from ProfileLayer where firstname like "+DbAdapter.cite("%"+firstname+"%")+" ) ");
	param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8"));
}

String Country = teasession.getParameter("Country");
if(Country!=null && !"AA".equals(Country)){

	sql.append(" and p.member in (select member from ProfileLayer where Country = "+DbAdapter.cite(Country)+" )  ");
	param.append("&Country=").append(Country);
}

String address = teasession.getParameter("address");
if(address!=null && address.length()>0){
	address = address.trim();
	sql.append(" and p.member in (select member from ProfileLayer where address like "+DbAdapter.cite("%"+address+"%")+" ) ");
	param.append("&address=").append(URLEncoder.encode(address,"UTF-8"));
}





String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND m.times >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND m.times <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0){
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0){
	sql.append(" and p.sex= ").append(sex);
	param.append("&sex=").append(sex);
}
int verifg= -1;
if(teasession.getParameter("verifg")!=null && teasession.getParameter("verifg").length()>0){
	verifg = Integer.parseInt(teasession.getParameter("verifg"));
}
if(verifg>=0){
	sql.append(" AND m.verifg =").append(verifg);
	  param.append("&verifg=").append(verifg);
}



int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());
sql.append(" order by times desc ");

%>

<html>
<head>
<title>??????????????????</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("memberorder");
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




function f_sub(igd,strigd)
{

  if(submitCheckbox(form1.memberorder,strigd))
  {

		if(igd=='audit')//??????
		{
			if(confirm('????????????????????????????????????'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_audit';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}

		//??????

		if(igd=='cancel_audit')//
		{
			if(confirm('????????????????????????????????????'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_cancel_audit';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
		//??????
			if(igd=='refusal')//
		{
			if(confirm('????????????????????????????????????'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_refusal';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
		//??????

		if(igd=='delete')//
		{
			if(confirm('??????????????????????????????????????????\n????????????????????????'))
			{
				form1.action='/servlet/EditMemberType';
				form1.act.value='member_delete';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}



     }
}

function f_excel()
		{
			if(confirm("????????????????????????????"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='MemberList';
				form1.submit();
			}
	   }


function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }

</script>

<h1>??????????????????</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>

<input type="hidden" name="membertype" value="<%=membertype %>"/>
<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="????????????"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>



<input type="hidden" name="id" value="<%=request.getParameter("id") %>">


<h2>??????</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">??????ID???</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		<td align="right">?????????</td>
		<td><input type="text" name="firstname" value="<%=Entity.getNULL(firstname) %>"/></td>

		<td align="right">?????????</td>
		<td><%=new tea.htmlx.CountrySelection("Country",teasession._nLanguage,Country)%></td>
	</tr>
	<tr>
		<td align="right">???????????????</td>
		<td><input type="text" name="address" value="<%=Entity.getNULL(address) %>"/></td>

	    <td align="right">?????????</td>
		<td>
			<select name="sex">
				<option value="-1">-??????-</option>
				<option value="0" <%if(sex==0)out.print(" selected "); %>>???</option>
				<option value="1" <%if(sex==1)out.print(" selected "); %>>???</option>
			</select>
		</td>


	<td align="right">???????????????</td>
	<td>
	 ???&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;???&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />

	</td>
	</tr>

	<tr>
	 <td align="right">???????????????</td>
		<td>
			<select name="verifg">

		   		<option value="-1">-????????????-</option>
		   		<%
		   			for(int i=0;i<Photography.AUDIT_TYPE.length;i++){
		   				out.print("<option value = "+i);
		   				if(verifg == i){
		   					out.print(" selected ");
		   				}
		   				out.print(">"+Photography.AUDIT_TYPE[i]);
		   				out.print("</option>");
		   			}
		   		%>



		</select>
		</td>


      <td colspan="2"><input type="submit" value="??????"/></td>
	</tr>
 </table>

<h2>????????????&nbsp;(&nbsp;????????????&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;?????????&nbsp;)&nbsp;</h2>
<h2>
<input type="button" value="????????????" onclick="f_sub('audit','??????????????????????????????!');">&nbsp;
<input type="button" value="????????????" onclick="f_sub('cancel_audit','??????????????????????????????!');">&nbsp;
<input type="button" value="????????????" onclick="f_sub('refusal','??????????????????????????????!');">&nbsp;
<input type="button" value="????????????" onclick="f_sub('delete','??????????????????????????????!');">&nbsp;
<input type="button" value="??????EXCEL" onclick="f_excel();">


 </h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="??????" style="cursor:pointer"></td>
  			  <td nowrap>??????</td>
  			  <td nowrap>??????ID</td>
  			  <td nowrap>??????</td>
  			  <td nowrap>??????</td>
  			  <td nowrap>????????????</td>
  			  <td nowrap>??????</td>
  			  <td nowrap>????????????</td>
  			  <td nowrap>????????????</td>
  			  <td nowrap>??????</td>
	    </tr>

    <%


	    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>????????????</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String memberorder =((String)e.nextElement());
    	    MemberOrder  moobj = MemberOrder.find(memberorder);
    	    Profile pobj = Profile.find(moobj.getMember());


    %>

    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder value="<%=memberorder%>" style="cursor:pointer"></td>
      <td><%=i+pos%></td>
      <td><%=moobj.getMember() %></td>
      <td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></td>
      <td><%=new tea.htmlx.CountrySelection(teasession._nLanguage,pobj.getCountry(teasession._nLanguage)).toString() %></td>
      <td><%=pobj.getAddress(teasession._nLanguage) %></td>
      <td><%if(pobj.isSex()){out.print("???");}else {out.print("???");} %></td>
      <td><%=Entity.sdf2.format(pobj.getTime())%></td>
      <td nowrap><%
	      if(moobj.getVerifg()==0)
	      {
	    	  out.print("<font color=red>"+Photography.AUDIT_TYPE[moobj.getVerifg()]+"</font>");
	      }else if(moobj.getVerifg()==1)
	      {
	    	  out.print("<font color=#00ab00>"+Photography.AUDIT_TYPE[moobj.getVerifg()]+"</font>");
	      }else{
	    	  out.print(Photography.AUDIT_TYPE[moobj.getVerifg()]);
	      }
      %></td>

	   <td>
		   <%if(moobj.getVerifg()==0){ %>
		   <a href="/jsp/type/photography/EditMember.jsp?memberorder=<%=memberorder %>&act=member_audit&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">??????</a>&nbsp;
		   <%}%>
		   <a href="/jsp/type/photography/EditMember.jsp?memberorder=<%=memberorder %>&nexturl=<%=URLEncoder.encode(nexturl,"UTF-8") %>">??????</a>&nbsp;

	   </td>
    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
