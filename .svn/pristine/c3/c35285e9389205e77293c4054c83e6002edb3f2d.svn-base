<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
String member = teasession._rv.toString();//当前用户


%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <body>
  <script>
  function sub()
  {
    if(form1.cause.value=="")
    {
      alert("请填写主题!");
      return false;
    }
    if(form1.leavetype.value=="")
    {
      alert("请选择请假类型!");
      return false;
    }
    if(form1.time_k.value=="")
    {
      alert("请你选择日期!");
      return false;
    }
    if(form1.time_j.value=="")
    {
      alert("请您选择日期!");
      return false;
    }
    if(form1.name.value=='')
    {
      alert("请选择你发送的人员!");
      return false;
    }
     // function compareDate(date1, date2){
       var  date1 =form1.time_k.value;
       var  date2 =form1.time_j.value;
        year1 = date1.substring(0,date1.indexOf("-"));
        year2 = date2.substring(0,date2.indexOf("-"));
        month1 = date1.substring(date1.indexOf("-")+1,date1.lastIndexOf("-"));
        month2 = date2.substring(date2.indexOf("-")+1,date2.lastIndexOf("-"));
        day1 = date1.substring(date1.lastIndexOf("-")+1,10);
        day2 = date2.substring(date2.lastIndexOf("-")+1,10);


        if(parseInt(year1) > parseInt(year2)){
          alert("开始时间不能大于结束时间!");
          return false;
        }else if( parseInt(month1) > parseInt(month2) ){
          alert("开始时间不能大于结束时间!");
          return false;
        }else if( parseInt(day1) > parseInt(day2) ){
          alert("开始时间不能大于结束时间!");
          return false;
        }

  }
  </script>
  <h1>请假登记</h1>

  <div id="head6"><img height="6" src="about:blank"></div>

    　  <br />
    <form name=form1 METHOD=get  action="/servlet/EditLeave" onsubmit="return sub(this);">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap>请假原因：<input type="text" name="cause" value="" size=90></td>
          </tr>
          <tr>
            <td nowrap>请假类型：<select name="leavetype">
            <%
            for(int i=0;i<Leavec.LEAVE_TYPE.length;i++)
            {
              out.print("<option value="+i);
              out.print(">"+Leavec.LEAVE_TYPE[i]);
              out.print("</option>");
            }
            %>
            </select></td>
</tr>
<tr>
            <td nowrap>请假时间：由
<%
out.print(new tea.htmlx.TimeSelection("time_k", new Date(),true,true));
%>
              至
<%
out.print(new tea.htmlx.TimeSelection("time_j", new Date(),true,true));
%>
</td>
</tr>
<tr>
<td nowrap>选择请假的领导：至

<%
AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
out.print("<input type=\"hidden\" value="+au_obj.getUnit()+" name=\"un\">");
out.print("<input type=\"hidden\" value="+au_obj.getClasses()+" name=\"cl\">");


String sql=" AND member!="+DbAdapter.cite(member);

if(au_obj.getUnit()==0)//无部门
{
  sql+=" AND classes!='' AND classes!='/'";
}else
{
  sql+=" AND classes LIKE '%/"+au_obj.getUnit()+"/%'";
}
out.print("<select name=name>");
java.util.Enumeration enu=AdminUsrRole.findByCommunity(teasession._strCommunity,sql);
System.out.print(sql); 
while(enu.hasMoreElements())
{
  String _member = (String)enu.nextElement();
  tea.entity.member.Profile p=tea.entity.member.Profile.find(_member);
  if(p.getTime()!=null)
  {
    AdminUsrRole obj1=AdminUsrRole.find(teasession._strCommunity,_member);
    out.print("<option value="+obj1.getMember()+"> "+p.getName(teasession._nLanguage));
  }
}
out.print("</select>");

%>



</td>
        </tr>
        <tr><td><input type="submit" value="提交请假申请" name="">&nbsp;<input type="button" value="返回上一页" onClick="history.back();"></td></tr>
      </table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
  </body>
</html>



