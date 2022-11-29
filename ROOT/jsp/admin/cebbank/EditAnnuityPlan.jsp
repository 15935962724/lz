<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.admin.cebbank.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

int annuityplan=Integer.parseInt(request.getParameter("annuityplan"));

String nexturl=request.getParameter("nexturl");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
	try
	{
	  form1.annuityplan.focus();
	}catch(e)
	{
	  form1.name.focus();
    }
}
function fclick(bool)
{
  var plan=form1.annuityplan;
  if(bool)
  {
    plan.value=2147483647;
    plan.style.display="none";
  }else
  {
    plan.value="";
    plan.style.display="";
  }
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>计划创建/编辑</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditAnnuityPlan" method="post" onSubmit="return submitInteger(this.annuityplan, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-计划号')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')&&submitText(this.communityx, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-社区')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="editannuityplan"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td><%=r.getString(teasession._nLanguage,"1186540009531")%></td>
         <td>
         <%
         String name=null,communityx=null;
         if(annuityplan>-1)
         {
        	 out.println("<input type=hidden name=annuityplan value="+annuityplan+" >");
             if(annuityplan==Integer.MAX_VALUE)
             {
            	 out.print("多个计划");
             }else
             {
            	 out.print(annuityplan);
             }
        	 AnnuityPlan obj=AnnuityPlan.find(annuityplan);
        	 name=obj.getName();
        	 communityx=obj.getCommunity();
         }else
         {
        	 out.println("<input type=text name=annuityplan ><input type=checkbox  onclick=fclick(this.checked) >多个计划");
         }
         %>
         </td>
</tr>
       <tr>
        <td><%=r.getString(teasession._nLanguage,"1186540073562")%></td>
         <td nowrap><input name="name" type="text" value="<%if(name!=null)out.print(name);%>" size="40"></td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage,"1186540121187")%></td>
         <td nowrap><input name="communityx" type="text" value="<%if(communityx!=null)out.print(communityx);%>" size="40"></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" value="<%=r.getString(teasession._nLanguage,"1186542726218")%>">
           <input type="reset" value="<%=r.getString(teasession._nLanguage,"1186542790281")%>" onClick="defaultfocus();">
           <input type="button" value="<%=r.getString(teasession._nLanguage,"1186544778828")%>" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


