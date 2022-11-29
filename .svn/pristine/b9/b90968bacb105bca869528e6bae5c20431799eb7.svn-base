<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>

<%
int formsyear;
String _strFormsyear=request.getParameter("formsyear");
if(_strFormsyear!=null)
formsyear=Integer.parseInt(_strFormsyear);
else
{
  java.util.Calendar c=  java.util.Calendar.getInstance();
  formsyear= c.get(  java.util.Calendar.YEAR);
}



int rootid = tea.entity.admin.SubsidyMenu.getRootId(node.getCommunity());
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>


      <h1><%=formsyear+"-"+(formsyear+1)%>年度经费津贴项目总结</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>


  <table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<!--TR id="tableonetr">
    <td colspan="20"></td>
  </tr-->
<%
java.text.DecimalFormat df=new java.text.DecimalFormat("#,##0.00");
java.util.Enumeration enumer=tea.entity.admin.SubsidyMenu.findByFather(rootid);
while(enumer.hasMoreElements())
{
  int son_id=((Integer)enumer.nextElement()).intValue();
  tea.entity.admin.SubsidyMenu sm_obj=tea.entity.admin.SubsidyMenu.find(son_id);
  tea.entity.admin.SubsidyYear sy_obj=tea.entity.admin.SubsidyYear.find(formsyear,son_id);
    %>
    <tr>
      <td><%=sm_obj.getName(teasession._nLanguage)%></td>
      <td align=right><%=df.format(sy_obj.getTotal())%></td>
    </tr>
    <%
}
%>
</table>

<input type="button" id="buttonprint" onclick="window.open('<%=request.getRequestURI()+"?"+request.getQueryString()%>&print=ON');" value="打印"/>
<br/>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
<%
if(request.getParameter("print")!=null)
{
  %>
  <style type="text/css">
    #buttonprint,#language
    {
    display:none ;
    }
  </style>
  <object ID='WebBrowser' WIDTH=0 HEIGHT=0 CLASSID='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2'></object>
  <script type="">
  WebBrowser.ExecWB(7,1);
  window.close();
  </script>
  <%
}%>



