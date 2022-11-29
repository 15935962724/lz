<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

if(request.getMethod().equals("POST"))
{
  boolean bool=request.getParameter("auditing")!=null;
  String members[]=request.getParameterValues("object");
  for(int i=0;i<members.length;i++)
  {
    ProfileJob pj = ProfileJob.find(members[i],community);
    pj.set(bool);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?community="+community,"UTF-8"));
  return;
}

int pagesize=20;
boolean auditing=request.getParameter("auditing")!=null;

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

Resource r=new Resource("/tea/resource/Job");

String sql=" AND auditing="+DbAdapter.cite(auditing);

int count=ProfileJob.count(community,sql);


%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
  <script>
  function fclick()
  {
    for(var counter=0;counter<form1.elements.length;counter++)
    if(form1.elements[counter].type=='checkbox')
    form1.elements[counter].checked=form1.selectall.checked;
  }
 function   fsubmit()
 {
   for(var counter=0;counter<form1.elements.length;counter++)
   if(form1.elements[counter].type=='checkbox'&&form1.elements[counter].checked&&form1.elements[counter].name!='selectall')
   return true;
   window.alert('<%=r.getString(teasession._nLanguage, "1167458485203")%>');//请先选择
   return false;
 }
 function   fallstarturl(allstarturl)
 {
   for(var counter=0;counter<form1.elements.length;counter++)
   if(form1.elements[counter].type=='text')
   form1.elements[counter].value=allstarturl.value;
 }
  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Auditing")%>:<%=count%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form name="form1" method="POST" action="<%=request.getRequestURI()%>" onSubmit="return fsubmit();">
  <input type="hidden" name="community" value="<%=community%>"/>
	  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr id="tableonetr">
            <td  width="1"></td>
            <td ><%=r.getString(teasession._nLanguage,"MemberId")%><!--会员ID--></td>
            <td><%=r.getString(teasession._nLanguage,"1167442318656")%><!--姓名--></td>
            <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
          </tr>
          <%
          Enumeration enumeration = ProfileJob.find(community,sql,pos,pagesize);
          for(int show=0; enumeration.hasMoreElements()&&show<pagesize;show++)
          {
            String member=(String)enumeration.nextElement();
            Profile profile=Profile.find(member);
            ProfileJob pj = ProfileJob.find(member,community);
            /*
            java.util.Date showValidity;
            if(pe.getValidity()==null)
            {
              java.util.Calendar calendar=java.util.Calendar.getInstance();
              calendar.set(1,calendar.get(1)+1);
              showValidity =calendar.getTime();
            }else
            {
              showValidity=pe.getValidity();
            }
            */

            %>
            <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
              <td width="1"><input type="CHECKBOX" name="object" value="<%=(member)%>"></td>
              <td ><a href="###" onClick="javascript:window.open('EnterpriseView.jsp?member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>')"><%=member%></a></td>
              <td><%=profile.getFirstName(teasession._nLanguage)%></td>
              <td><%=profile.getTime()%></td>
            </tr>
        <%}%>
		<tr><td colspan="2"><input type="CHECKBOX" name="selectall" onClick="fclick()"/><%=r.getString(teasession._nLanguage,"1167445122937")%><!--全选--></td>
                  <td colspan="2"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+("?"+request.getQueryString()).replaceFirst("&pos=","&")+"&pos=", pos, count,pagesize)%></td>
</tr>
          </table>

   <%if(!auditing)
   {
     //设为批准状态
     %>
                <input type="submit" onClick=""  class="edit_button" name="auditing" value="<%=r.getString(teasession._nLanguage, "1167467282578")%>"/>
<% }else
{
  //设为拒绝状态
  %>
              <input type="submit" onClick=""  class="edit_button" name="submit" value="<%=r.getString(teasession._nLanguage, "1167467312812")%>"/>
<%}%>
<!--发邮件,并删除-->
  <input type="submit" onClick="form1.action='/jsp/user/SendEmailToEnterprise.jsp';" name="delete" class="edit_button" value="<%=r.getString(teasession._nLanguage, "1167467330593")%>"/>
<!--未审核  已审核-->
  <input  class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,auditing?"1167467364812":"1167467378593")%>" onClick="window.open('<%=request.getRequestURI()%><%if(!auditing)out.print("?auditing=ON");%>','_self')"/>
  </form>



<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>



</body>
</html>

