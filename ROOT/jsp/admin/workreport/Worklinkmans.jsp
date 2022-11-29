<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page import="tea.entity.member.*" %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>


<%
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
String mobile=(request.getParameter("mobile"));
String email=(request.getParameter("email"));

//if((tel!=null&&tel.length()>0)||(lastname!=null&&(lastname=lastname.trim()).length()>0)||(firstname!=null&&(firstname=firstname.trim()).length()>0)||(fax!=null&&fax.length()>0)||(email!=null&&email.length()>0))
//if((tel!=null&&tel.length()>0))
//{
//}
int workproject = 0;
if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
{
  workproject = Integer.parseInt(teasession.getParameter("workproject"));
  if(workproject>0)
  {
    sql.append(" AND workproject  =  ").append(workproject);
    param.append("&workproject=").append(workproject);
  }
}
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

  if(mobile!=null&&mobile.length()>0)
  {
    sql.append(" AND mobile LIKE ").append(DbAdapter.cite("%"+mobile+"%"));
    param.append("&mobile=").append(java.net.URLEncoder.encode(mobile,"UTF-8"));
  }

  if(email!=null&&email.length()>0)
  {
    sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+email+"%"));
    param.append("&email=").append(java.net.URLEncoder.encode(email,"UTF-8"));
  }
  sql.append(")");



int pos=0,sizepage=10;
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
<h1><%=r.getString(teasession._nLanguage,"1168584403265")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 method="POST" action="?"  onSubmit="">

   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168584443703")%>：<!--客户或项目--></td><td>

         <select name="workproject">
           <option value="">-------------</option>
           <%
           java.util.Enumeration ed=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(ed.hasMoreElements())
           {
             int id=((Integer)ed.nextElement()).intValue();
             Workproject obj=Workproject.find(id);
             out.print("<option value="+id);
             if(id==workproject)
             out.print(" SELECTED ");
             out.print(" >"+obj.getName(teasession._nLanguage));
           }
           %>
    </select>
       </td>
       <td><%=r.getString(teasession._nLanguage,"1168574945796")%>：<!--电话--></td><td> <input name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"手机")%>：<!--传真--></td><td> <input name="mobile" value="<%if(mobile!=null)out.print(mobile);%>"></td>
     </tr>
     <tr>
       <td>E-Mail：</td><td><input name="email" value="<%if(email!=null)out.print(email);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"LastName")%><%=r.getString(teasession._nLanguage,"FirstName")%>：</td><td><input name="lastname" value="<%if(lastname!=null)out.print(lastname);if(firstname!=null)out.print(firstname);%>"></td>

       <td><input type="submit" value="GO"/></td>
     </tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
<form action="/servlet/EditExportExcel" method="POST">
   <input type="hidden" name="files" value="workation">
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
         %>
        <%=r.getString(teasession._nLanguage,"FirstName")%></td>
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
         <td nowrap>
         <%=r.getString(teasession._nLanguage,"1168584635593")
         /*//生日
         if("birthday".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584635593")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=birthday&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584635593")+"</a>");
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
         <td nowrap><%=r.getString(teasession._nLanguage,"1168584722562")
         /*//工作电话
         if("worktel".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584722562")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=worktel&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584722562")+"</a>");
         }*/
         %></td>
         <td nowrap><%=r.getString(teasession._nLanguage,"1168584761843")
         /*//手机
         if("mobile".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584761843")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=mobile&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168584761843")+"</a>");
         }*/
         %></td>
         <td nowrap>E-Mail<%
         /*
         if("email".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >E-Mail "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=email&"+param.toString()+" >E-Mail</a>");
         }*/
         %></td>

         <td>
         <select onChange="fchange(this.value);">
         <option value="msn">MSN</option>
         <option value="qicq">QQ</option>
         <option value="fpostcode"><%=r.getString(teasession._nLanguage,"1168585799359")%><!--家庭邮编--></option>
         <option value="ftel"><%=r.getString(teasession._nLanguage,"1168585870750")%><!--家庭电话--></option>
         <option value="faddress"><%=r.getString(teasession._nLanguage,"1168586146015")%><!--家庭住址--></option>
         <option value="blog"><%=r.getString(teasession._nLanguage,"1168586007609")%><!--博客网址--></option>
         <option value="job"><%=r.getString(teasession._nLanguage,"1168586069359")%><!--职位--></option>
         <option value="love"><%=r.getString(teasession._nLanguage,"Hobbies")%><!--爱好--></option>
         </select>         </td>
         <td></td>
       </tr>
     <%
StringBuffer sb=new StringBuffer();
java.util.Enumeration enumer=Worklinkman.find(community,sql.toString(),pos,sizepage);
  if(!enumer.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
for(int index=1;enumer.hasMoreElements();index++)
{
  String member=((String)enumer.nextElement());
  Worklinkman obj=Worklinkman.find(community,member);
  Profile profile=Profile.find(member);
  sb.append("switch(field){case 'msn':value=\"").append(obj.getMsn()).append("\";break; case 'qicq':value=\"").append(obj.getQicq()).append("\";break; case 'fpostcode':value=\"").append(profile.getZip(teasession._nLanguage)).append("\";break; case 'ftel':value=\"").append(obj.getFtel()).append("\";break; case 'faddress':value=\"").append(obj.getFaddress(teasession._nLanguage)).append("\";break; case 'blog':value=\"").append(obj.getBlog()).append("\";break; case 'job':value=\"").append(obj.getJob(teasession._nLanguage)).append("\";break; case 'love':value=\"").append(obj.getLove(teasession._nLanguage)).append("\";break;} document.getElementById('td_").append(index).append("').innerText=value;\r\n");

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1" nowrap><%=index%></td>
    <td nowrap >&nbsp;<%=obj.getMember()%></td>
    <td nowrap >&nbsp;<%=profile.getLastName(teasession._nLanguage)%><%=profile.getFirstName(teasession._nLanguage)%></td>

    <td nowrap align="center">&nbsp;<%=r.getString(teasession._nLanguage,obj.isSex()?"Man":"Woman")%></td>
    <td nowrap align="center">&nbsp;<%=profile.getBirthToString()%></td>
    <td nowrap >&nbsp;<%if(obj.getWorkproject()>0)out.print(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));%></td>
    <td nowrap >&nbsp;<%=obj.getWorktel()%></td>
    <td nowrap >&nbsp;<%=profile.getMobile()%></td>
    <td nowrap >&nbsp;<a href="mailto:<%=profile.getEmail()%>" ><%=profile.getEmail()%></a></td>
    <td nowrap id="td_<%=index%>"></td>
    <td nowrap align="center">
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/admin/workreport/EditWorklinkman.jsp?community=<%=community%>&member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/EditWorkreport?community=<%=community%>&member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>&action=deleteworklinkman&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self'); this.disabled=true;}">    </td>
 </tr>
<%
}
%>
<%if(count>sizepage) {%>
<tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,sizepage)%></td></tr>
<%}%>
</table>
<br>
<input type="button" value="<%=r.getString(teasession._nLanguage,"添加联系人")%>" onClick="window.open('/jsp/admin/workreport/EditWorklinkman.jsp?community=<%=community%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
  &nbsp;<input type="submit" name="exportall" value="导出Excel表" >
</form>


<script type="">
function fchange(field)
{
  var value;
  <%=sb.toString()%>
}
fchange('msn');
</script>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



