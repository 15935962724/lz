<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="java.math.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

Communitytrial obj = Communitytrial.find(teasession._strCommunity);

int role=0,unit=0,daycount=30;
if(request.getMethod().equals("POST"))
{
	role=Integer.parseInt(request.getParameter("role"));
	unit=Integer.parseInt(request.getParameter("unit"));
	daycount=Integer.parseInt(request.getParameter("daycount"));

	obj.set(role,unit,daycount);

	response.sendRedirect("/jsp/info/Succeed.jsp");
	return;
}

if(obj.isExists())
{
	role=obj.getRole();
	unit=obj.getUnit();
	daycount=obj.getDaycount();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="fload();" >

<h1>试用管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST" onSubmit="return(submitInteger(this.role, '<%=r.getString(teasession._nLanguage,"角色")%>')&&submitInteger(this.unit, '<%=r.getString(teasession._nLanguage,"部门")%>')&&submitInteger(this.daycount, '<%=r.getString(teasession._nLanguage,"试用天数")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">

  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"角色")%>:</td>
      <td>
      <select name="role">
      <option value="0">------------</option>
      <%
      Enumeration e=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
      while(e.hasMoreElements())
      {
    	  int id=((Integer)e.nextElement()).intValue();
    	  out.print("<option value="+id);
    	  if(id==role)
    		  out.print(" SELECTED ");
    	  out.print(">"+AdminRole.find(id).getName());
      }
      %>
      </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"部门")%>:</td>
      <td>
      <select name="unit">
      <option value="0">------------</option>
      <%
      e=AdminUnit.findByCommunity(teasession._strCommunity,"");
      while(e.hasMoreElements())
      {
        AdminUnit obj=(AdminUnit)e.nextElement();
        int id=obj.getId();
        out.print("<option value="+id);
        if(id==unit)out.print(" SELECTED ");
        out.print(">"+obj.getName());
      }
      %>
      </select>
	  </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"试用天数")%>:</td>
      <td><input type="text" name="daycount" value="<%=daycount%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td>
    </tr>
      <tr>
          <td></td><td><input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
        </tr>
  </table>
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

