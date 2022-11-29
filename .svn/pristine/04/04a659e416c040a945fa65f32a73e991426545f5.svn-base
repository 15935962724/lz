<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%
  java.util.Calendar c=  java.util.Calendar.getInstance();
int formsyear=2005;
String _strFormsyear=request.getParameter("formsyear");
if(_strFormsyear!=null)
formsyear=Integer.parseInt(_strFormsyear);
else
{
  formsyear= c.get(  java.util.Calendar.YEAR);
}

boolean _bPrint=request.getParameter("print")!=null;

tea.entity.admin.SubsidyTime st_obj=tea.entity.admin.SubsidyTime.find(node.getCommunity());


java.util.Calendar c_start=  java.util.Calendar.getInstance();
c_start.set(java.util.Calendar.YEAR,formsyear);
c_start.set(java.util.Calendar.MONTH,st_obj.getStartSubsidyMonth()-1);
c_start.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStartSubsidyDay());

java.util.Calendar c_stop=  java.util.Calendar.getInstance();
c_stop.set(java.util.Calendar.YEAR,formsyear);
c_stop.set(java.util.Calendar.MONTH,st_obj.getStopSubsidyMonth()-1);
c_stop.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStopSubsidyDay());

boolean _bEdit=c.getTime().compareTo(c_start.getTime())>=0&&c.getTime().compareTo(c_stop.getTime())<0&&!_bPrint;


if (_bEdit&&request.getMethod().equals("POST")) {
  String _strId[]=    request.getParameterValues("id");
  for(int index=0;index<_strId.length;index++)
  {
    int id = Integer.parseInt(_strId[index]);
    tea.entity.admin.SubsidyYear sy_obj = tea.entity.admin.SubsidyYear.find(formsyear,id);
    sy_obj.setUseper(Integer.parseInt(request.getParameter("useper"+id)));
  }
  response.sendRedirect("InfoSuccess.jsp?node="+teasession._nNode);
  return;
}
  int rootid = tea.entity.admin.SubsidyMenu.getRootId(node.getCommunity());

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check()
{
  for(var index=0;index<formform111.elements.legnth;index++)
  {
    if(formform111.elements[index].type=="text")
    {
      if(!submitInteger(formform111.elements[index],'无效参数'))
      {
        return false;
      }
    }
  }
  return true;
}
</script>
</head>
<body>
      <h1><%=formsyear+"-"+(formsyear+1)%>支出预算</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>

<form name="formform111" action="/jsp/admin/schoolfinance/SubsidyPayout.jsp?node=<%=teasession._nNode%>" method="POST" onSubmit="return check()">
  <input type="hidden" name="formsyear" value="<%=formsyear%>">

<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
  <TR id="tableonetr">
    <td>项目</td>
    <td>津贴总额</td>
    <td>    </td>
    <td>使用率</td>
    <td>财政预算支出</td>
    <td>    </td>
  </tr>
<%
java.text.DecimalFormat df=new java.text.DecimalFormat("#,##0.00");
  java.math.BigDecimal total = new java.math.BigDecimal(0D);
  java.math.BigDecimal result_total = new java.math.BigDecimal(0D);
  java.util.Enumeration enumer = tea.entity.admin.SubsidyMenu.findByFather(rootid);
  while (enumer.hasMoreElements()) {
    int son_id = ((Integer) enumer.nextElement()).intValue();
    tea.entity.admin.SubsidyMenu sm_obj = tea.entity.admin.SubsidyMenu.find(son_id);
    tea.entity.admin.FormsYear fy_obj = tea.entity.admin.FormsYear.find(formsyear);
    tea.entity.admin.SubsidyYear sy_obj=    tea.entity.admin.SubsidyYear.find(formsyear,son_id);

    java.math.BigDecimal result = sy_obj.getTotal().multiply(new java.math.BigDecimal(sy_obj.getUseper() / 100D));

    result_total = result_total.add(result);
%>
  <input type="hidden" name="id" value="<%=son_id%>">
  <tr>
    <td><%=sm_obj.getName(teasession._nLanguage)%>    </td>
    <td align=right><%=df.format(sy_obj.getTotal())%>    </td>
    <td>X</td>
    <td>
      <%
      if(_bEdit)
      {
      %>
      <input type="text" name="useper<%=son_id%>" size="5" value="<%=sy_obj.getUseper()%>">
<%}else
out.print(sy_obj.getUseper());%>%
</td>
    <td align=right><%=df.format( result)%>    </td>
  </tr>
<%}%>
  <tr>
    <td>总数</td>
    <td align=right><%=df.format( tea.entity.admin.SubsidyYear.find(formsyear,rootid).getTotal())%>    </td>
    <td align=right>    </td>
    <td>    </td>
    <td align=right><%=df.format(result_total)%>    </td>
  </tr>
</table>
<%if(_bEdit){%>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<%}%>
<input type="button" id="buttonprint" onClick="window.open('<%=request.getRequestURI()+"?"+request.getQueryString()%>&print=ON');" value="打印"/>

</form>
<br/>
  <div id=note>
  注:<%=st_obj.getStartPayoutMonth()%>月<%=st_obj.getStartPayoutDay()%>日-<%=st_obj.getStopPayoutMonth()%>月<%=st_obj.getStopPayoutDay()%>日 时才可以新提交或修改数据
</div>
<%
if(_bPrint)
{
   tea.entity.admin.FormsYear fm_obj=  tea.entity.admin.FormsYear.find(formsyear);
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
  %>
  打印者:<%=teasession._rv%> 打印时间:<%=sdf.format(new java.util.Date())%>
  <%
}
%>
<br/>
<div id="head6"><img height="6" src="about:blank"></div>

   <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>


<%
if(_bPrint)
{
  %>
  <style type="text/css">
    #buttonprint,#language,#note
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



