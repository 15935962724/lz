<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);

int id=0;
if(teasession.getParameter("id")!=null)
id=Integer.parseInt(teasession.getParameter("id"));

Employment employment=Employment.find(id);
if(!node.isCreator(teasession._rv)||(id!=0&&employment.getNode()!=teasession._nNode))
{
  response.sendError(403);
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

String nexturl=request.getParameter("nexturl");

%><HTML>
<HEAD>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>

<body>

<h1><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="Form1" method="post" action="/servlet/EditEmployments" onSubmit="return submitText(this.tbOrgName,'<%=r.getString(teasession._nLanguage,"1167530359328")%>')&&submitText(this.tbWorkSite,'<%=r.getString(teasession._nLanguage,"1167530380171")%>')&&submitText(this.tbPositionName,'<%=r.getString(teasession._nLanguage,"1167530406000")%>')&&submitText(this.tbFunction,'<%=r.getString(teasession._nLanguage,"1167530423890")%>')" id="Form1">
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />

<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"单位名称")%><!--公司名称--> </td>
    <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
    <td><%=r.getString(teasession._nLanguage,"1167465522578")%><!--工作地点--></td>
    <td><%=r.getString(teasession._nLanguage,"1167454389921")%><!--职位名称--></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration enumeration=Employment.find(teasession._nNode,teasession._nLanguage);
  while(enumeration.hasMoreElements())
  {
    Employment educateobj=Employment.find(((Integer)enumeration.nextElement()).intValue());
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=educateobj.getOrgName()%></td>
      <td><%=educateobj.getStartDate("yyyy/MM")%>--<%=educateobj.getEndDate("yyyy/MM")%></td>
      <td><%=educateobj.getWorkSite()%></td>
      <td><%=educateobj.getPositionName()%></td>
      <td><input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditEmployment.jsp?node=<%=teasession._nNode%>&id=<%=educateobj.getId()%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
        <input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteEmployment?node=<%=teasession._nNode%>&id=<%=educateobj.getId()%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')};"/> </td>
    </tr>
    <%} %>
  </table>
  <br>
  <h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--添加/编辑--></h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167466871093")%><!--公司名称--></td>
      <td><input name="tbOrgName" value="<%=employment.getOrgName()%>" class="edit_input" id="tbOrgName" type="text" maxlength="120" size="30" /></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167473216078")%><!--公司简单介绍--></td>
      <td><textarea name="tbOrgInfo" id="tbOrgInfo" class="edit_input" rows="3" cols="60"><%=employment.getOrgInfo()%></textarea>
        <span class="note"> <br>
          <%=r.getString(teasession._nLanguage,"1167529384234")%><!--了解你所任职的公司，有助于我们对你的了解。如：国内知名的大型机械制造企业（限300字）--><br>
            <span class="cell"><%=r.getString(teasession._nLanguage,"1167529411593")%><!--在该公司的工作经验－每次填写一个岗位的经验，可多次添加--></span>
      </td>
    </tr>
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167465522578")%><!--工作地点--></td>
      <td><input class="edit_input" name="tbWorkSite" value="<%=employment.getWorkSite()%>" id="tbWorkSite" type="text" size="30" maxlength="30" /></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529473046")%><!--所在部门--></td>
      <td><input name="tbDepartment" class="edit_input" value="<%=employment.getDepartment()%>" id="tbDepartment" type="text" size="30" maxlength="50" /></td>
    </tr>
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167454389921")%><!--职位名称--></td>
      <td><input class="edit_input" name="tbPositionName" value="<%=employment.getPositionName()%>" id="tbPositionName" type="text" size="30" maxlength="60" /></td>
    </tr>
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167471168140")%><!--开始时间--></td>
      <td> <select name="ymStartDate:ymYear" id="ymStartDate_ymYear" >
<%
java.util.Calendar c=java.util.Calendar.getInstance();
int year=c.get(java.util.Calendar.YEAR);
if(employment.getStartDate()!=null)
{
  c.setTime(employment.getStartDate());
}
for(int index=year;index>=1950;index--)
{
  out.print("<option value="+index);
  if(c.get(java.util.Calendar.YEAR)==index)
  out.print(" selected");
  out.print(">"+index);
}
%>                      </select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--年-->
                      <select name="ymStartDate:ymMonth" id="ymStartDate_ymMonth">
                <%
                int month=c.get(java.util.Calendar.MONTH)+1;
                for(int len=1;len<=12;len++)
                {
                  out.print("<option value=\""+len+"\" ");
                  if(len==month)
                  out.print("selected");
                  out.print(">"+len+"</option>");
                }
            %>
                      </select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--月--> </td>
                  </tr>
                  <tr>
                    <td>*<%=r.getString(teasession._nLanguage,"1167471229125")%><!--结束时间--></td>
                    <td valign="middle">
                      <select name="ymEndDate:ymYear" id="ymEndDate_ymYear" >
<option selected="selected" value="3000"><%=r.getString(teasession._nLanguage,"1167471250265")%><!--至今--></option>
<%
if(employment.getEndDate()!=null)
{
  c.setTime(employment.getEndDate());
}
for(int index=year;index>=1950;index--)
{
  out.print("<option value="+index);
  if(c.get(java.util.Calendar.YEAR)==index)
  out.print(" selected");
  out.print(">"+index);
}
%>                      </select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--年-->
<select name="ymEndDate:ymMonth" id="ymEndDate_ymMonth" >
<%
month=c.get(java.util.Calendar.MONTH)+1;
for(int len=1;len<=12;len++)
{
  out.print("<option value=\""+len+"\" ");
  if(len==month)
  out.print("selected");
  out.print(">"+len+"</option>");
}
%>
</select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--月--> <span class="note"><%=r.getString(teasession._nLanguage,"1167529713687")%><!--如果是当前工作，请选择“至今”--></td>
</tr>

<tr>
  <td><%=r.getString(teasession._nLanguage,"行业")%><!--行业代码--></td>
  <td>
    <select name="branc">
    <%
    for(int index=0;index<Common.ZCSZY.length;index++)
    {
      out.print("<option value="+Common.ZCSZY[index][0]);
      if(Common.ZCSZY[index][0].equals(employment.getBranc()))
      out.print(" SELECTED ");
      out.print(">"+Common.ZCSZY[index][1]);
    }
    %>
    </select>
  </td>
</tr>

<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529795828")%><!--工作经历证明人--></td>
  <td><input type="text" name="zzmr" class="edit_input" value="<%=employment.getZzmr()%>"  size="50"/></td>
</tr>

<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529833984")%><!--工作经历证明人联系方式--></td>
  <td><input type="text" name="zzlxfs" class="edit_input" value="<%=employment.getZzlxfs()%>" size="80"/></td>
</tr>

<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529870187")%><!--工作经历类型--></td>
  <td>
    <select name="zzjllx" >
<%
for(int index=0;index<Employment.ZZJLLX_TYPE.length;index++)
{
  %><option value="<%=index%>" <%if(employment.getZzjllx()==index) out.print(" selected");%>><%=Employment.ZZJLLX_TYPE[index]%></option>
  <%
}
%>
    </select>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529893359")%><!--加入方式--></td>
  <td>
    <select  name="zzjrfs">
<%
for(int index=0;index<Employment.ZZJRFS_TYPE.length;index++)
{
  %><option value="<%=Employment.ZZJRFS_TYPE[index][0]%>" <% if(Employment.ZZJRFS_TYPE[index][0].equals(employment.getZzjrfs()))out.print(" SELECTED ");%>><%=Employment.ZZJRFS_TYPE[index][1]%></option>
  <%
}
%>
    </select>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529920218")%><!--派出单位--></td>
  <td><input name="zzpcdw" type="text" id="zzpcdw" class="edit_input" size="40" maxlength="40" value="<%if(employment.getZzpcdw()!=null)out.print(employment.getZzpcdw());%>"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167529942906")%><!--派出原因--></td>
  <td>
    <select name="zzpcyy">
    <option value="">-----------------------</option>
    <%
    for(int index=0;index<Employment.ZZPCYY_TYPE.length;index++)
    {
      out.print("<option value="+Employment.ZZPCYY_TYPE[index][0]);
      if(Employment.ZZPCYY_TYPE[index][0].equals(employment.getZzpcyy()))
      out.print(" SELECTED");
      out.print(" >"+Employment.ZZPCYY_TYPE[index][1]);
    }
    %>
    </select></td>
</tr>
<!--<tr>
  <td><%=r.getString(teasession._nLanguage,"1167447133937")%>兼职</td>
  <td><input name="zzjrll" type="radio" value="true" checked id="zzjrll_radiobutton_1"><label for="zzjrll_radiobutton_1"><%=r.getString(teasession._nLanguage,"1167469410921")%>是</label>
    <input type="radio" name="zzjrll" value="false" id="zzjrll_radiobutton_2" <%if(!employment.isZzjrll())out.print(" checked");%>><label for="zzjrll_radiobutton_2"><%=r.getString(teasession._nLanguage,"1167469442484")%>否</label>
</td>
</tr>-->

<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530025578")%><!--用工类型--></td>
  <td>
    <select name="zzyglx">
    <%
    for(int index=0;index<Employment.ZZYGLX_TYPE.length;index++)
    {
      out.print("<option value="+Employment.ZZYGLX_TYPE[index][0]);
      if(Employment.ZZYGLX_TYPE[index][0].equals(employment.getZzyglx()))
      out.print(" SELECTED");
      out.print(" >"+Employment.ZZYGLX_TYPE[index][1]);
    }
    %>
    </select>
  </td>
</tr>
<tr>
  <td>* <%=r.getString(teasession._nLanguage,"1167465545156")%><!--工作职责和业绩--></td>
  <td style="HEIGHT: 130px">
    <textarea name="tbFunction" class="edit_input" id="tbFunction" rows="7" wrap="VIRTUAL" cols="60"><%=employment.getFunction()%></textarea>
    <span class="note"><%=r.getString(teasession._nLanguage,"1167530123656")%><!--（限2000字）--></span>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530143921")%><!--离职/转岗原因--></td>
  <td><input  class="edit_input" name="tbReasonOfLeaving"  value="<%=employment.getReasonOfLeaving()%>" id="tbReasonOfLeaving" type="text" maxlength="100" size="60" />
</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530185062")%><!--调出原因--></td>
  <td>
    <select name="zzdcyy">
    <%
    for(int index=0;index<Employment.ZZDCYY_TYPE.length;index++)
    {
      out.print("<option value="+index);
      if(index==employment.getZzdcyy())
      out.print(" SELECTED");
      out.print(" >"+Employment.ZZDCYY_TYPE[index]);
    }
    %>
    </select>
  </td>
</tr>

<tr>
  <td colspan="2" align="center"><input type="submit"  class="edit_button" name="btnSaveAndNew" value="<%=r.getString(teasession._nLanguage,"1167530223796")%>"  id="btnSaveAndNew" /></td>
</tr>

</table>

<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditEducate.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditResumeOther.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>

<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')" />



</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
</body>
</HTML>
