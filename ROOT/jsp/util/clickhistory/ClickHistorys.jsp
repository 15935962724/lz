<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if(request.getMethod().equals("POST"))
{
  int ch=Integer.parseInt(request.getParameter("clickhistory"));
  if(request.getParameter("delete")!=null)
  {
    ClickHistory obj=ClickHistory.find(ch);
    obj.delete();
  }else
  {
    String name=request.getParameter("name");
    int type=Integer.parseInt(request.getParameter("type"));
    int quantity=Integer.parseInt(request.getParameter("quantity"));
    if(ch<1)
    {
      ClickHistory.create(teasession._strCommunity,type,quantity,name);
    }else
    {
      ClickHistory obj=ClickHistory.find(ch);
      obj.set(type,quantity,name);
    }
  }
  response.sendRedirect(request.getParameter("nexturl"));
  return;
}

Resource r=new Resource();

String id=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "浏览历史管理")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name=form1 METHOD=POST action="?" >
<input type="hidden" name="clickhistory" value="0"/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "Subject")%></td><td><input name="name" type="text" value=""></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "Type")%></td>
<td><select name="type">
<OPTION VALUE="255" ><%=r.getString(teasession._nLanguage, "AllTypes")%></OPTION>
  <%
  CLicense cl_obj=CLicense.find(teasession._strCommunity);
  String licensetype= cl_obj.getType();
  String nts[]=licensetype.split("/");
  for(int index = 1; index < nts.length; index++)
  {
    int t=Integer.parseInt(nts[index]);
    if(t<200)
    {
      out.print("<option value="+nts[index]);
      out.print(" >"+r.getString(teasession._nLanguage,Node.NODE_TYPE[t]));
    }
  }
  %>
</select></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "Quantity")%></td><td><input name="quantity" type="text" value="20" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"></td></tr>
</table>
<input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return(submitText(document.form1.name,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td><%=r.getString(teasession._nLanguage, "Subject")%></td>
<td><%=r.getString(teasession._nLanguage, "Type")%></td>
<td></td>
</tr>
<%
java.util.Enumeration enumer=ClickHistory.findByCommunity(teasession._strCommunity);
while(enumer.hasMoreElements())
{
	int ch=((Integer)enumer.nextElement()).intValue();
	ClickHistory obj=ClickHistory.find(ch);

%><tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
	<td><%=obj.getName()%></td>
  	<td><%=r.getString(teasession._nLanguage, obj.getType()==255?"AllTypes":Node.NODE_TYPE[obj.getType()])%></td>
	<td>
	<input type="button" onclick="form1.clickhistory.value='<%=ch%>'; form1.type.value='<%=obj.getType()%>';form1.quantity.value='<%=obj.getQuantity()%>'; form1.name.value='<%=obj.getName()%>'; form1.name.focus(); " value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"/>
	<input type="submit" name="delete" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>')){ form1.clickhistory.value='<%=ch%>'; }else return false;" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"/>
  	<input type="button" onclick="window.open('/jsp/util/clickhistory/EditClickHistoryDetail.jsp?community=<%=teasession._strCommunity%>&clickhistory=<%=ch%>&clickhistorydetail=0','_self');" value="<%=r.getString(teasession._nLanguage,"细节")%>"/>
<!--	<input type="button" onclick="window.open('/jsp/util/ViewClickHistory.jsp?community=<%=teasession._strCommunity%>&clickhistory=<%=ch%>');" value="<%=r.getString(teasession._nLanguage,"View")%>"/>
    -->
  </td>
</tr>
<%
}
%></table>


</form>

<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

