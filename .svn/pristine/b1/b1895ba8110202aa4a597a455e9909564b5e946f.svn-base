
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String inpname=teasession.getParameter("inpname");
Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer(" and (manager like "+DbAdapter.cite("%"+teasession._rv.toString()+"%")+" or member like "+DbAdapter.cite("%"+teasession._rv.toString()+"%")+")");
sql.append(" and  itemgenre>0 and itemgenre<5   ");
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
sql.append(" and type=0");
String tel=(request.getParameter("tel"));
if(tel!=null&&tel.length()>0)
{
  sql.append(" and  workproject in (select workproject from Workproject where tel like '%"+tel+"%' )");
  param.append("&tel=").append(java.net.URLEncoder.encode(tel,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND  flowitem in (select flowitem from FlowitemLayer where name like "+DbAdapter.cite("%"+name+"%")+" )");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String fax=(request.getParameter("fax"));
if(fax!=null&&fax.length()>0)
{
  sql.append(" AND fax LIKE ").append(DbAdapter.cite("%"+fax+"%"));
  param.append("&fax=").append(java.net.URLEncoder.encode(fax,"UTF-8"));
}

String email=(request.getParameter("email"));
if(email!=null&&email.length()>0)
{
  sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+email+"%"));
  param.append("&email=").append(java.net.URLEncoder.encode(email,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Flowitem.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="flowitem";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String fieldname=request.getParameter("fieldname");
if(fieldname==null)
{
  fieldname="form1.workproject";
}

int show=0;
if(teasession.getParameter("show")!=null && teasession.getParameter("show").length()>0)
{
  show=  Integer.parseInt(teasession.getParameter("show"));
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
<script>
var pmt=parent.mt;
function ret(h){
pmt.receive(h,'<%=inpname%>');
pmt.close();
}

</script>
<style>
.modetit{
font-size:12px;
color:#123456;
font-weight:bold;
}
</style>

</head>
<body>
<!--客户或项目管理-->
<br>

<!--h2><%=r.getString(teasession._nLanguage,"1168574879546")%><查询></h2-->
   <form name=form1 METHOD=post action="?" onSubmit="" target="_self">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="inpname" value="<%=inpname%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>
   <input type=hidden name="show" value="1"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter111">
     <tr>
      <!-- <td><%=r.getString(teasession._nLanguage,"1168574945796")%>电话<input name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>-->
<%--
         <td><%=r.getString(teasession._nLanguage,"1168574969234")%><!--传真--><input name="fax" value="<%if(fax!=null)out.print(fax);%>"></td>
           <td>E-Mail<input name="email" value="<%if(email!=null)out.print(email);%>"></td>
--%>
             <td><%//r.getString(teasession._nLanguage,"1168575002906")%><!--名称--><font color="red" style="font-weight:bold;font-size:15px;">查询<font><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
               <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>
<!--h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><列表></h2-->
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter11">
     <!--tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap>
         <%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("tel".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574945796")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=tel&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574945796")+"</a>");
         }
         %></td>

         <td nowrap><时间>
         <%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time&"+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+"</a>");
         }
         %></td>
       </tr-->
       <%
       if(show==0)
       {
     %>



       <tr><td align="left"><font class='modetit' >最近填写的项目</font></td></tr>
     <%
     StringBuffer sb = new StringBuffer();
     String member = teasession._rv.toString();//登录的用户ID
        java.util.Enumeration flmejc = Flowitem.findzuijin(teasession._strCommunity, "",teasession._rv.toString());
     //java.util.Enumeration flmejc = Flowitem.find(teasession._strCommunity, "and Flowitem in (select top 10 workproject from  Worklog  where member ="+DbAdapter.cite(member)+" group by workproject order by count(workproject) desc)");
     while (flmejc.hasMoreElements())
     {
       int flid = ((Integer) flmejc.nextElement()).intValue();
       Flowitem flobj = Flowitem.find(flid);

       if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
       {
         out.print("<tr><td nowrap=nowrap >　<a href=### onclick=\"ret("+flid+");\">"+ flobj.getName(teasession._nLanguage)+"</a></td></tr>");
       }
     }
%>
    <tr><td align="left"><font class='modetit' >进行中的项目</font></td></tr>
     <%
     java.util.Enumeration flmejx = Flowitem.find(teasession._strCommunity, " and type = 0 and itemgenre=2 order by flowitem desc");
     while (flmejx.hasMoreElements())
     {
       int flid = ((Integer) flmejx.nextElement()).intValue();
       Flowitem flobj = Flowitem.find(flid);

       if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
       {
         out.print("<tr><td nowrap=nowrap >　<a href=### onclick=\"ret("+flid+");\">"+ flobj.getName(teasession._nLanguage)+"</a></td></tr>");
       }
     }
%>

  <tr><td align="left"><font class='modetit' >洽谈中的项目</font></td></tr>
     <%
   java.util.Enumeration flmeqt = Flowitem.find(teasession._strCommunity, "  and type = 0 and itemgenre=1 order by flowitem desc");
        while (flmeqt.hasMoreElements())
        {
          int flid = ((Integer) flmeqt.nextElement()).intValue();
       Flowitem flobj = Flowitem.find(flid);

       if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
       {
         out.print("<tr><td nowrap=nowrap >　<a href=### onclick=\"ret("+flid+");\">"+ flobj.getName(teasession._nLanguage)+"</a></td></tr>");
       }
     }
%>

  <tr><td align="left"><font class='modetit' >维护中的项目</font></td></tr>
     <%
   java.util.Enumeration flmewh = Flowitem.find(teasession._strCommunity, "  and type = 0 and itemgenre=3 order by flowitem desc");
        while (flmewh.hasMoreElements())
        {
          int flid = ((Integer) flmewh.nextElement()).intValue();
       Flowitem flobj = Flowitem.find(flid);

       if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
       {
         out.print("<tr><td nowrap=nowrap >　<a href=### onclick=\"ret("+flid+");\">"+ flobj.getName(teasession._nLanguage)+"</a></td></tr>");
       }
     }
%>

      <tr><td align="left"><font class='modetit' >完成的项目</font></td></tr>
     <%
    java.util.Enumeration flme = Flowitem.find(teasession._strCommunity, "  and type = 0 and itemgenre=4  order by flowitem desc");
        while (flme.hasMoreElements())
        {
          int flid = ((Integer) flme.nextElement()).intValue();
       Flowitem flobj = Flowitem.find(flid);

       if(flobj.getManager().indexOf(member)!=-1 || flobj.getMember().indexOf(member)!=-1)
       {
         out.print("<tr><td nowrap=nowrap >　<a href=### onclick=\"ret("+flid+");\">"+ flobj.getName(teasession._nLanguage)+"</a></td></tr>");
       }
     }
%>

     <%}
     else
     {


       java.util.Enumeration flmer =  Flowitem.find(teasession._strCommunity,sql.toString(),pos,Integer.MAX_VALUE);
       for(int index=1;flmer.hasMoreElements();index++)
       {
       int flid=((Integer)flmer.nextElement()).intValue();
       Flowitem flobj=Flowitem.find(flid);
       Workproject obj=Workproject.find(flobj.getWorkproject());

       %>

       <tr>

         <td nowrap> <a href="###" onclick=ret(<%=flid%>) ><%=flobj.getName(teasession._nLanguage)%></a></td>
       </tr>
       <%
       }
     }
       %>




<!--java.util.Enumeration flmer =  Flowitem.find(teasession._strCommunity,sql.toString(),pos,10);
////out.print(sql.toString());
//for(int index=1;flmer.hasMoreElements();index++)
//{
//  int flid=((Integer)flmer.nextElement()).intValue();
//    Flowitem flobj=Flowitem.find(flid);
//    Workproject obj=Workproject.find(flobj.getWorkproject());


  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td width="1"><%//index%></td>
    <td nowrap> <a href="#" onclick="ret(<%//flid%>);" ><%//flobj.getName(teasession._nLanguage)%></a></td>
    <td nowrap>&nbsp;<%//obj.getTel()%></td>
    <td>&nbsp;</td>
 </tr-->
<!--tr><td colspan="4" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr-->
</table>

</body>
</html>


