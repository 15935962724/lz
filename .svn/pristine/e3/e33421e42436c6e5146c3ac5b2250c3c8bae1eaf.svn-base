<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.confab.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



String community = request.getParameter("community");


Resource r=new Resource("/tea/resource/Dynamic");


String nexturl=request.getParameter("nexturl");

Confabhostel obj=Confabhostel.find(teasession._nNode,teasession._nLanguage);

Node node=Node.find(teasession._nNode);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >

<h1><%=r.getString(teasession._nLanguage,"1215677357850")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name="form1" METHOD=POST action="/servlet/EditConfab" onSubmit="return submitText(this.linkman,'无效-联系人')&&submitInteger(this.human,'无效-人数')&&submitInteger(this.days,'无效-信宿天数');">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="action" value="hostel"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
      <td><%=node.getCreator()%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"index")%></td>
      <td><A target="_blank" href="/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node=<%=teasession._nNode%>" ><%=request.getParameter("code")%></a></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Contact")%>:</td>
      <td><input name="linkman" type="text" id="linkman" value="<%if(obj.getLinkman()!=null)out.print(obj.getLinkman());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215677904647")%>:</td>
      <td><input name="cabaret" type="text" id="cabaret" value="<%if(obj.getCabaret()!=null)out.print(obj.getCabaret());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215677987366")%>:</td>
      <td><input name="roots" type="text" id="roots" value="<%if(obj.getRoots()!=null)out.print(obj.getCabaret());%>"></td>
    </tr>
	    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215678046053")%>:</td>
      <td><input name="human" type="text" id="human" value="<%=obj.getHuman()%>"></td>
    </tr>
		    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215678112241")%>:</td>
      <td><input name="days" type="text" id="days" value="<%=obj.getDays()%>"></td>
    </tr>
			    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215678172069")%>:</td>
      <td>
        <textarea name="outlay" mask="nnnnnn.nn" cols="20" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());else out.print("0.00");%></textarea>
<!--        <input name="outlay" type="text" id="outlay" value="<%if(obj.getOutlay()!=null)out.print(obj.getOutlay());%>"> --></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
      <td><%=new tea.htmlx.TimeSelection("time1", obj.getTime1())%> -- <%=new tea.htmlx.TimeSelection("time2", obj.getTime2())%>
      </td>
    </tr>
  </table>
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.history.back();">

</FORM>
<br>
<div id="head6"><img height="6" alt=""></div>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</html>


