<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();

int pagesize=20;
boolean auditing=request.getParameter("auditing")!=null;

int count=ProfileEnterprise.countByAuditing(auditing,community);

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

Enumeration enumeration = ProfileEnterprise.findByAuditing(auditing,community,pos,pagesize);

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Auditing")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <form name="form1" method="POST" action="/servlet/AuditingEnterprise" onSubmit="return fsubmit();">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Auditing")%>:<%=count%></td>
    </tr>
    <tr>
      <td class="listing">
	  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr id="tableonetr">
            <td ></td>
            <td >会员ID</td>
            <td><input type="text" onKeyUp="this.onchange();" onChange="fallstarturl(this);" value="<%=r.getString(teasession._nLanguage, "StartUrl")%>"/></td>
            <td>有效期</td>
          </tr>
          <%
          for(int show=0; enumeration.hasMoreElements()&&show<pagesize;show++)
          {
            String member=(String)enumeration.nextElement();
            Profile profile=Profile.find(member);
            ProfileEnterprise pe = ProfileEnterprise.find(member,community);
            //member=new String(member.getBytes("ISO-8859-1"));
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
            %>
            <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
              <td><input  id="CHECKBOX" type="CHECKBOX" name="object" value="<%=(member)%>"></td>
              <td ><a href="###" onClick="javascript:window.open('EnterpriseView.jsp?member=<%=member%>')"><%=member%></a></td>
              <td><input type="text" class="edit_input"  name="starturl" value="<%=getNull(profile.getStartUrl(teasession._nLanguage))%>"/></td>
              <td><%=new TimeSelection("validity", showValidity)%></td>
            </tr>
        <% }%>
		<tr><td><input  id="CHECKBOX" type="CHECKBOX" name="selectall" onClick="fclick()"/>全选</td></tr>
          </table>
          <%//=new FPNL(teasession._nLanguage, "/servlet/SonNodes?node=" + teasession._nNode + "&Pos=", i, Node.countSons(teasession._nNode, teasession._rv))%>
    </td></tr>
  </table>

   <%if(!auditing){%>
                <input type="submit" onClick="form1.action='/servlet/AuditingEnterprise';"  class="edit_button" name="auditing" value="<%=r.getString(teasession._nLanguage, "Auditing")%>"/>
<%                  }else{%>
              <input type="submit" onClick="form1.action='/servlet/AuditingEnterprise';"  class="edit_button" name="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
<%}%>
                <input type="submit" onClick="form1.action='/jsp/user/SendEmailToEnterprise.jsp';" name="delete" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBDeny")%>"/>


  <input  class="edit_button" type="button" value="<%=auditing?"未审核":"已审核"%>" onClick="window.open('<%=request.getRequestURI()%><%if(!auditing)out.print("?auditing=ON");%>','_self')"/>
  </form>

<%=new FPNL(teasession._nLanguage, request.getRequestURI()+("?"+request.getQueryString()).replaceFirst("&pos=","&")+"&pos=", pos, count,pagesize)%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

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
   window.alert('请选中要操作的会员');
   return false;
 }
 function   fallstarturl(allstarturl)
 {
   for(var counter=0;counter<form1.elements.length;counter++)
   if(form1.elements[counter].type=='text')
   form1.elements[counter].value=allstarturl.value;
 }
  </script>

</body>
</html>

