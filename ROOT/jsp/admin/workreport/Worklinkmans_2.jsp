<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page import="tea.entity.member.*" %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}


String tel=(request.getParameter("tel"));
String lastname=request.getParameter("lastname");
String firstname=request.getParameter("firstname");
String fax=(request.getParameter("fax"));
String email=(request.getParameter("email"));

if((tel!=null&&tel.length()>0)||(lastname!=null&&(lastname=lastname.trim()).length()>0)||(firstname!=null&&(firstname=firstname.trim()).length()>0)||(fax!=null&&fax.length()>0)||(email!=null&&email.length()>0))
{
  sql.append(" AND wl.member IN ( SELECT member FROM ProfileLayer WHERE 1=1 ");
  if(tel!=null&&tel.length()>0)
  {
    sql.append(" AND telephone LIKE ").append(DbAdapter.cite("%"+tel+"%"));
    param.append("&tel=").append(java.net.URLEncoder.encode(tel,"UTF-8"));
  }

  if(lastname!=null&&(lastname=lastname.trim()).length()>0)
  {
    sql.append(" AND lastname LIKE ").append(DbAdapter.cite("%"+lastname+"%"));
    param.append("&lastname=").append(java.net.URLEncoder.encode(lastname,"UTF-8"));
  }

  if(firstname!=null&&(firstname=firstname.trim()).length()>0)
  {
    sql.append(" AND firstname LIKE ").append(DbAdapter.cite("%"+firstname+"%"));
    param.append("&firstname=").append(java.net.URLEncoder.encode(firstname,"UTF-8"));
  }

  if(fax!=null&&fax.length()>0)
  {
    sql.append(" AND fax LIKE ").append(DbAdapter.cite("%"+fax+"%"));
    param.append("&fax=").append(java.net.URLEncoder.encode(fax,"UTF-8"));
  }

  if(email!=null&&email.length()>0)
  {
    sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+email+"%"));
    param.append("&email=").append(java.net.URLEncoder.encode(email,"UTF-8"));
  }
  sql.append(")");
}

int workproject=0;
String _strWorkproject=request.getParameter("workproject");
if(_strWorkproject!=null&&_strWorkproject.length()>0)
{
  workproject=Integer.parseInt(_strWorkproject);
  Flowitem fobj = Flowitem.find(workproject);
  sql.append(" AND wl.workproject=").append(fobj.getWorkproject());
  param.append("&workproject=").append(workproject);
}



String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND wl.member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Worklinkman.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="name";
//param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
//param.append("&desc=").append(desc);

//sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

String fieldname=request.getParameter("fieldname");
if(fieldname==null)
{
  fieldname="form1.worklinkman";
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<!--联系人信息管理-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>
   <%
   if(workproject!=0)
   out.print("<input type=hidden name=workproject value="+workproject+" >");
   %>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
     <%--
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%><!--客户或项目--><input name="workproject" value="<%if(tel!=null)out.print(tel);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"1168574945796")%><!--电话--><input name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"1168574969234")%><!--传真--><input name="fax" value="<%if(fax!=null)out.print(fax);%>"></td>
       <td>E-Mail<input name="email" value="<%if(email!=null)out.print(email);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"LastName")%><input name="lastname" value="<%if(lastname!=null)out.print(lastname);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"FirstName")%><input name="firstname" value="<%if(firstname!=null)out.print(firstname);%>"></td>
       --%>
       <td><%=r.getString(teasession._nLanguage,"MemberId")%><input name="member" value="<%if(member!=null)out.print(member);%>"></td>
       <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap>
         <%=r.getString(teasession._nLanguage,"MemberId")
         //<!--会员-->
         /*
         if("member".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"MemberId")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=member&"+param.toString()+" >"+r.getString(teasession._nLanguage,"MemberId")+"</a>");
         }*/
         %></td>
         <td nowrap>
         <%=r.getString(teasession._nLanguage,"LastName")
         /*
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"Username")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >"+r.getString(teasession._nLanguage,"Username")+"</a>");
         }*/
         %></td>
         <td nowrap><%=r.getString(teasession._nLanguage,"FirstName")%>
         <td nowrap>
         <%=r.getString(teasession._nLanguage,"Sex")
         /*if("sex".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"Sex")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=sex&"+param.toString()+" >"+r.getString(teasession._nLanguage,"Sex")+"</a>");
         }*/
         %></td>
         <td nowrap><%=r.getString(teasession._nLanguage,"1168584443703")
         /*//客户或项目
         if("workproject".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584443703")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=workproject&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584443703")+"</a>");
         }*/
         %></td>
         <td>E-Mail
         </td>
       </tr>
     <%

java.util.Enumeration enumer=Worklinkman.find(community,sql.toString(),pos,10);
for(int index=1;enumer.hasMoreElements();index++)
{
  member=((String)enumer.nextElement());
  Worklinkman obj=Worklinkman.find(community,member);
  Profile profile=Profile.find(member);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" onclick="window.opener.document.<%=fieldname%>.value='<%=member%>';window.close();">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getMember()%></td>
    <td>&nbsp;<%=profile.getLastName(teasession._nLanguage)%></td>
    <td>&nbsp;<%=profile.getFirstName(teasession._nLanguage)%></td>
    <td>&nbsp;<%=r.getString(teasession._nLanguage,obj.isSex()?"Man":"Woman")%></td>
    <td>&nbsp;<%if(obj.getWorkproject()>0)out.print(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));%></td>
    <td>&nbsp;<a href="mailto:<%=profile.getEmail()%>" ><%=profile.getEmail()%></a></td>
 </tr>
  <%
}
     %>
<tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


