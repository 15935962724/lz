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

Confabreception obj=Confabreception.find(teasession._nNode,teasession._nLanguage);
java.util.Date time=obj.getTime();
if(time==null)
time=new java.util.Date();

java.util.Calendar c=java.util.Calendar.getInstance();
c.setTime(time);

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

<h1><%=r.getString(teasession._nLanguage,"1215652235225")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>

<FORM name="form1" METHOD=POST action="/servlet/EditConfab" onSubmit="return submitText(this.dest,'无效-接待人')&&submitText(this.flight,'无效-车次航班')&&submitInteger(this.human,'无效-人数');">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="action" value="reception"/>

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
      <td><%=r.getString(teasession._nLanguage,"1215680252584")%>:</td>
      <td><input name="dest" type="text" id="dest" value="<%if(obj.getDest()!=null)out.print(obj.getDest());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215680377647")%>:</td>
      <td><input name="flight" type="text" id="flight" value="<%if(obj.getFlight()!=null)out.print(obj.getFlight());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1215680474787")%>:</td>
      <td><input name="human" type="text" id="human" value="<%out.print(obj.getHuman());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
      <td>
        <SELECT NAME="time_0" >
        <%
        int year=c.get(c.YEAR);
        for(int i=2006;i<2020;i++)
        {
          out.print("<option value="+i);
          if(i==year)
          {
            out.print(" selected");
          }
          out.print(" >"+i);
        }
        %></SELECT><%=r.getString(teasession._nLanguage,"1215680597991")%>
        <SELECT NAME="time_1" >
        <%
        int month=c.get(c.MONTH)+1;
        for(int i=1;i<=12;i++)
        {
          out.print("<option value="+i);
          if(i==month)
          {
            out.print(" selected");
          }
          out.print(" >"+i);
        }
        %>
        </SELECT><%=r.getString(teasession._nLanguage,"1215680765366")%>
        <SELECT NAME="time_2" >
        <%
        int day=c.get(c.DAY_OF_MONTH);
        for(int i=1;i<=31;i++)
        {
          out.print("<option value="+i);
          if(i==day)
          {
            out.print(" selected");
          }
          out.print(" >"+i);
        }
        %>
        </SELECT><%=r.getString(teasession._nLanguage,"1215680868600")%>
        <SELECT NAME="time_3" >
        <%
        int hour=c.get(c.HOUR_OF_DAY);
        for(int i=0;i<24;i++)
        {
          out.print("<option value="+i);
          if(i==hour)
          {
            out.print(" selected");
          }
          out.print(" >"+i);
        }
        %>
        </SELECT><%=r.getString(teasession._nLanguage,"1215680962397")%>
        <SELECT NAME="time_4" >
        <%
        int minute=c.get(c.MINUTE);
        for(int i=0;i<60;i=i+10)
        {
          out.print("<option value="+i);
          if(i==minute)
          {
            out.print(" selected");
          }
          out.print(" >"+i);
        }
        %>
        </select><%=r.getString(teasession._nLanguage,"1215681027959")%>
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


