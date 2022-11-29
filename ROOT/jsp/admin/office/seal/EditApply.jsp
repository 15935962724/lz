<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page import="tea.ui.TeaSession" %>

<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.admin.office.Cachet"%>
<%@page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
int sealapply =0;
if(request.getParameter("sealapply")!=null && request.getParameter("sealapply").length()>0)
    sealapply = Integer.parseInt(request.getParameter("sealapply"));

tea.entity.admin.office.Sealapply saobj = tea.entity.admin.office.Sealapply.find(sealapply);
String nexturl = request.getParameter("nexturl");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body>

<h1>申请用印</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/servlet/EditSealapply" method="post">
<input type ="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type =hidden name="act" value="EditApply"/>
<input type =hidden name="sealapply" value="<%=sealapply%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

 <%
    if(saobj.getExaminetype()==-1){
      out.print("<tr><td>没有通过审批原因:</td><td>");
      out.print(saobj.getNotcausation());
      out.print("&nbsp;(请根据具体原因，重新填写申请)");
      out.print("</td></tr>");

    }

 %>

  <tr>
  	<td>印章名称:</td>
    <td><select name="cachet">
    <option value="">-------</option>
   	<%

       // String cesql =null;
        AdminUsrRole  arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

   		//Enumeration ce = Cachet.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
   		//while(ce.hasMoreElements())
   		//{
                  String cachet[] = arobj.getCachet().split("/");

                  for(int i=1 ;i<cachet.length;i++){

                    //int ceid = ((Integer)ce.nextElement()).intValue();
                   Cachet caobj = Cachet.find(Integer.parseInt(cachet[i]));
                   out.print("<option value="+cachet[i]);
                   if(saobj.getCachet()==Integer.parseInt(cachet[i]))
                       out.print(" selected");
                    out.print(">"+caobj.getName()+caobj.getType());
                    out.print("</option>");
                  }
   		//}
  	%>

    </select></td>
  </tr>
   <tr>
    <td>使用时间:</td>
    <td>
    	<input name="usetime" size="7"  value="<%if(saobj.getUsetime()!=null)out.print(saobj.getUsetimeToString());%>"><A href="###"><img onclick="showCalendar('form1.usetime');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
  </tr>
   <tr>
   		<td>使用的项目:</td>
   		<td>
      <select name="item">
        <option value="">---------</option>
      <%
        String member = teasession._rv.toString();//登录的用户
            String _sql = " and (manager like "+DbAdapter.cite("%"+member+"%")+" or member like "+DbAdapter.cite("%"+member+"%")+" )  ";
               java.util.Enumeration fme =  Flowitem.find(teasession._strCommunity,_sql,0,Integer.MAX_VALUE);
               while(fme.hasMoreElements())
               {

                 int fid = ((Integer)fme.nextElement()).intValue();
                 Flowitem fobj = Flowitem.find(fid);
                     out.print("<option value="+fid);
                     if(fid == saobj.getItem())
                          out.print(" selected ");
                     out.print(">"+fobj.getName(teasession._nLanguage));
                     out.print("</option>");
              }
      %>
      </select>
     <!-- <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
-->
    </td>
   </tr>
    <tr>
   		<td>份数:</td>
   		<td><input type="text" name="share" value="<%if(saobj.getShare()!=0)out.print(saobj.getShare());%>"></td>
   </tr>
  <tr>
  	<td>事由:</td>
  	<td><textarea name="usecausation" rows="5" cols="30"><%if(saobj.getUsecausation()!=null)out.print(saobj.getUsecausation()); %></textarea></td>
  </tr>

</table>
<input type="submit" value="提交" >
<input type="button" value="返回" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
