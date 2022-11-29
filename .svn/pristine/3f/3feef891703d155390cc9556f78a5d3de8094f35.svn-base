<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>

<%
java.util.Calendar c=  java.util.Calendar.getInstance();
int formsyear;
String _strFormsyear=teasession.getParameter("formsyear");
if(_strFormsyear!=null)
formsyear=Integer.parseInt(_strFormsyear);
else
{
  formsyear= c.get(  java.util.Calendar.YEAR);
}

boolean _bPrint=request.getParameter("print")!=null;

tea.entity.admin.SubsidyTime st_obj=tea.entity.admin.SubsidyTime.find(node.getCommunity());
int month=c.get(java.util.Calendar.MONTH)+1;
int day=c.get(java.util.Calendar.DAY_OF_MONTH);
boolean _bEdit= false;

java.util.Calendar c_start=  java.util.Calendar.getInstance();
c_start.set(java.util.Calendar.YEAR,formsyear);
c_start.set(java.util.Calendar.MONTH,st_obj.getStartSfaccountMonth()-1);
c_start.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStartSfaccountDay());

java.util.Calendar c_stop=  java.util.Calendar.getInstance();
c_stop.set(java.util.Calendar.YEAR,formsyear);
c_stop.set(java.util.Calendar.MONTH,st_obj.getStopSfaccountMonth()-1);
c_stop.set(java.util.Calendar.DAY_OF_MONTH,st_obj.getStopSfaccountDay());

_bEdit=c.getTime().compareTo(c_start.getTime())>=0&&c.getTime().compareTo(c_stop.getTime())<0&&!_bPrint;


if(_bEdit&&request.getMethod().equals("POST"))
{
  tea.entity.admin.FormsYear fy_obj=  tea.entity.admin.FormsYear.find(formsyear);
  fy_obj.setSfa(teasession._rv._strR);


  java.util.StringTokenizer tokenizer=  new java.util.StringTokenizer(teasession.getParameter("sfaccount"),"/");
  while(tokenizer.hasMoreTokens())
  {
    int subsidymenu2=Integer.parseInt(tokenizer.nextToken());
    tea.entity.admin.SFAccountYear sm2_obj = tea.entity.admin.SFAccountYear.find(formsyear,subsidymenu2);
    sm2_obj.set(new java.math.BigDecimal(teasession.getParameter("balance"+subsidymenu2).replaceAll(",","")),null,null,teasession._nLanguage);
  }
  tokenizer=  new java.util.StringTokenizer(teasession.getParameter("sfaccount_folder"),"/");
  while(tokenizer.hasMoreTokens())
  {
    int subsidymenu2=Integer.parseInt(tokenizer.nextToken());
    tea.entity.admin.SFAccountYear sm2_obj = tea.entity.admin.SFAccountYear.find(formsyear,subsidymenu2);
    String path=null;
    /*
    byte by[]=teasession.getBytesParameter("picture"+subsidymenu2);
    if(by!=null)
    path= write(node.getCommunity(),by);
    else
    path=sm2_obj.getPicture(teasession._nLanguage);
    */
    java.math.BigDecimal balance=new     java.math.BigDecimal(0D);
    java.util.Enumeration enumer=    tea.entity.admin.SFAccount.findSon(subsidymenu2);
    while(enumer.hasMoreElements())
    {
      int sm_id=((Integer)      enumer.nextElement()).intValue();
      tea.entity.admin.SFAccount sm_obj=tea.entity.admin.SFAccount.find(sm_id);
      if(sm_obj.isType())
      {
        tea.entity.admin.SFAccountYear sy_obj = tea.entity.admin.SFAccountYear.find(formsyear,sm_id);
        balance=balance.add(sy_obj.getBalance());
      }
    }
    sm2_obj.set(balance,teasession.getParameter("text"+subsidymenu2),path,teasession._nLanguage);
  }

  response.sendRedirect("InfoSuccess.jsp?node="+teasession._nNode);
  return;
  //sm_obj.set(new java.math.BigDecimal(request.getParameter("balance")),new java.math.BigDecimal(request.getParameter("subsidy")));
}
java.text.DecimalFormat df=new java.text.DecimalFormat("#,##0.00");
int rootid = tea.entity.admin.SFAccount.getRootId(node.getCommunity());
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>
   <h1><%=formsyear+"-"+(formsyear+1)%>年度学校流动现金</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>

<form action="/jsp/admin/schoolfinance/EditSFAccountOutlay.jsp" name="form111" method="POST" enctype="multipart/form-data">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="formsyear" value="<%=formsyear%>"/>
<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
    <td>户头</td>
    <td>结余</td>
    <td></td><td></td>
  </tr>
<%
StringBuffer sb=new StringBuffer("/"+rootid);
StringBuffer sb2=new StringBuffer();
  java.math.BigDecimal total=new java.math.BigDecimal(0D);
  java.util.Enumeration enumer = tea.entity.admin.SFAccount.findByFather(rootid);
  while (enumer.hasMoreElements()) {
  int sm_id = ((Integer) enumer.nextElement()).intValue();
  tea.entity.admin.SFAccount sm_obj = tea.entity.admin.SFAccount.find(sm_id);
   tea.entity.admin.SFAccountYear sfay_obj = tea.entity.admin.SFAccountYear.find(formsyear,sm_id);

  sb.append("/"+sm_id);
  %>
  <tr>
    <td><%=sm_obj.getName(teasession._nLanguage)%></td>
  </tr>
<%
  java.math.BigDecimal totalBalance=new java.math.BigDecimal(0D);
 java.util.Enumeration enumer2 = tea.entity.admin.SFAccount.findByFather(sm_id);
 int count=0;
  while (enumer2.hasMoreElements()) {
    count++;
    int sm2_id = ((Integer) enumer2.nextElement()).intValue();
    tea.entity.admin.SFAccount sm2_obj = tea.entity.admin.SFAccount.find(sm2_id);
    tea.entity.admin.SFAccountYear sfay_obj2 = tea.entity.admin.SFAccountYear.find(formsyear,sm2_id);

    sb2.append("/"+sm2_id);
    %>
      <tr>
    <td><img alt="" src="/tea/image/tree/tree_blank.gif"/><%=sm2_obj.getName(teasession._nLanguage)%></td>
    <td >
      <%if(_bEdit){%>
      <input  type="text" value="<%=sfay_obj2.getBalance()%>" name="balance<%=sm2_id%>"/>
    <%}else out.print(df.format(sfay_obj2.getBalance()));%></td>
  </tr>
    <%
  }
if(count>1){
%>
<tr><td><img alt="" src="/tea/image/tree/tree_blank.gif"/><%=r.getString(teasession._nLanguage,"Total")%></td>
  <td><%=df.format(sfay_obj.getBalance())%></td></tr>
  <%}
  if(_bEdit){
  %>
  <tr><td >注解:</td>
    <td colspan="2"><textarea name="text<%=sm_id%>" rows="5" cols="50"><%if(sfay_obj.getText(teasession._nLanguage)!=null)out.print(sfay_obj.getText(teasession._nLanguage));%></textarea></td></tr>
  <tr><td >结单:</td>
    <td colspan="2">
      <iframe src="/jsp/admin/schoolfinance/EditSFAccountYearAccessories.jsp?node=<%=teasession._nNode%>&formsyear=<%=formsyear%>&sfaccount=<%=sm_id%>" frameborder="0" scrolling="auto" height="80">


      </iframe>
      <!--input type="file" name="picture<%=sm_id%>" ondblclick="window.open('<%=sfay_obj.getPicture(teasession._nLanguage)%>')">上传附件
    <select name="picture<%=sm_id%>list">
      <option></option>

    </select-->
    </td></tr>
<%}else
{%>
  <tr><td>注解:</td>
    <td><%if(sfay_obj.getText(teasession._nLanguage)!=null)out.print(sfay_obj.getText(teasession._nLanguage));%></td></tr>
  <tr><td>结单:</td>
    <td><%
    java.util.Enumeration sfaya_enumer= tea.entity.admin.SFAccountYearAccessories.find(formsyear,sm_id);
while(sfaya_enumer.hasMoreElements())
{
  int id=((Integer) sfaya_enumer.nextElement()).intValue();
  tea.entity.admin.SFAccountYearAccessories sfaya_obj=  tea.entity.admin.SFAccountYearAccessories.find(id);
  out.print("<A  target=_blank href="+sfaya_obj.getPicture()+">"+sfaya_obj.getName()+"</A><br/>");
}
%></td></tr>
<%}%>
  <tr><td colspan="20"><hr size="1" /></td></tr>
<%  }
%>
<input type="hidden" name="sfaccount_folder" value="<%=sb.toString()%>"/>
  <input type="hidden" name="sfaccount" value="<%=sb2.toString()%>"/>
</table>
<%if(_bEdit){%>
<input type="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
 <% }%>
 <input type="button" id="buttonprint" onClick="window.open('<%=request.getRequestURI()+"?"+request.getQueryString()%>&print=ON');" value="打印"/>

</form>

<br/>
  <div id="note">
注:<%=st_obj.getStartSfaccountMonth()%>月<%=st_obj.getStopSfaccountDay()%>日-<%=st_obj.getStopSfaccountMonth()%>月<%=st_obj.getStopSfaccountDay()%>日 时才可以新提交或修改数据
</div>
<%
if(_bPrint)
{
   tea.entity.admin.FormsYear fm_obj=  tea.entity.admin.FormsYear.find(formsyear);
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm");
  %>
  打印者:<%=teasession._rv%> 打印时间:<%=sdf.format(new java.util.Date())%> 提交者:<%=fm_obj.getSfaMember()%> 提交时间:<%=sdf.format(fm_obj.getSfaTime())%>
  <%
}
%>

<br/>
<div id="head6"><img height="6" alt=""></div>
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



