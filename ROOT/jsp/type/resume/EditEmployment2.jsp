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
String nexturl2=request.getRequestURI()+"?nexturl="+nexturl+""+request.getContextPath();

%><HTML>
<HEAD>
  <script src="/tea/tea.js" type="text/javascript"></script>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
</HEAD>

<body>
<script type="text/javascript">
function check(){
  return submitText(Form1.tbOrgName,'<%=r.getString(teasession._nLanguage,"1167530359328")%>')
  &&submitText(Form1.tbWorkSite,'<%=r.getString(teasession._nLanguage,"1167530380171")%>')&&
  submitText(Form1.tbPositionName,'<%=r.getString(teasession._nLanguage,"1167530406000")%>')&&
  submitText(Form1.tbFunction,'<%=r.getString(teasession._nLanguage,"1167530423890")%>');
}

function f_add()
{
  Form1.nexturl.value="<%=nexturl2%>";
  Form1.action='/servlet/EditEmployments';
  if(check()){
    Form1.submit();
  }
}
function f_add2()
{
  Form1.nexturl.value="<%=nexturl%>";
  Form1.action='/servlet/EditEmployments';
  if(check()){
    Form1.submit();
  }
}
</script>
<h1><%=r.getString(teasession._nLanguage,"1167457783859")%><!--????????????--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form name="Form1" method="post" action="/servlet/EditEmployments" onSubmit="" id="Form1">
  <input type="hidden" name="node" value="<%=teasession._nNode%>" />
  <input type="hidden" name="id" value="<%=id%>" />
  <input type="hidden" name="nexturl"  />


  <h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--??????/??????--></h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167466871093")%><!--????????????--></td>
      <td><input name="tbOrgName" value="<%=employment.getOrgName()%>" class="edit_input" id="tbOrgName" type="text" maxlength="120" size="30" /></td>
    </tr>
    <%--
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167473216078")%><!--??????????????????--></td>
      <td><textarea name="tbOrgInfo" id="tbOrgInfo" class="edit_input" rows="3" cols="60"><%=employment.getOrgInfo()%></textarea>
        <span class="note"> <br>
          <%=r.getString(teasession._nLanguage,"1167529384234")%><!--??????????????????????????????????????????????????????????????????????????????????????????????????????????????????300??????--><br>
            <span class="cell"><%=r.getString(teasession._nLanguage,"1167529411593")%><!--?????????????????????????????????????????????????????????????????????????????????--></span>
</td>
    </tr>
    --%>
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167465522578")%><!--????????????--></td>
      <td><input class="edit_input" name="tbWorkSite" value="<%=employment.getWorkSite()%>" id="tbWorkSite" type="text" size="30" maxlength="30" /></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529473046")%><!--????????????--></td>
      <td><input name="tbDepartment" class="edit_input" value="<%=employment.getDepartment()%>" id="tbDepartment" type="text" size="30" maxlength="50" /></td>
    </tr>
    <tr>
      <td>*<%=r.getString(teasession._nLanguage,"1167454389921")%><!--????????????--></td>
      <td><input class="edit_input" name="tbPositionName" value="<%=employment.getPositionName()%>" id="tbPositionName" type="text" size="30" maxlength="60" /></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167471168140")%><!--????????????--></td>
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
      %>                      </select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--???-->
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
      </select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--???--> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167471229125")%><!--????????????--></td>
      <td valign="middle">
        <select name="ymEndDate:ymYear" id="ymEndDate_ymYear" >
          <option selected="selected" value="3000"><%=r.getString(teasession._nLanguage,"1167471250265")%><!--??????--></option>
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
          %>                      </select><%=r.getString(teasession._nLanguage,"1167448647531")%><!--???-->
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
          </select><%=r.getString(teasession._nLanguage,"1167471209125")%><!--???--> <span class="note"><%=r.getString(teasession._nLanguage,"1167529713687")%><!--?????????????????????????????????????????????--></td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage,"??????")%><!--????????????--></td>
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
      <td><%=r.getString(teasession._nLanguage,"1167529795828")%><!--?????????????????????--></td>
      <td><input type="text" name="zzmr" class="edit_input" value="<%=employment.getZzmr()%>"  size="50"/></td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529833984")%><!--?????????????????????????????????--></td>
      <td><input type="text" name="zzlxfs" class="edit_input" value="<%=employment.getZzlxfs()%>" size="80"/></td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529870187")%><!--??????????????????--></td>
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
    <%--
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529893359")%><!--????????????--></td>
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
      <td><%=r.getString(teasession._nLanguage,"1167529920218")%><!--????????????--></td>
      <td><input name="zzpcdw" type="text" id="zzpcdw" class="edit_input" size="40" maxlength="40" value="<%if(employment.getZzpcdw()!=null)out.print(employment.getZzpcdw());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1167529942906")%><!--????????????--></td>
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
    --%>
    <!--<tr>
      <td><%=r.getString(teasession._nLanguage,"1167447133937")%>??????</td>
      <td><input name="zzjrll" type="radio" value="true" checked id="zzjrll_radiobutton_1"><label for="zzjrll_radiobutton_1"><%=r.getString(teasession._nLanguage,"1167469410921")%>???</label>
        <input type="radio" name="zzjrll" value="false" id="zzjrll_radiobutton_2" <%if(!employment.isZzjrll())out.print(" checked");%>><label for="zzjrll_radiobutton_2"><%=r.getString(teasession._nLanguage,"1167469442484")%>???</label>
</td>
</tr>-->

<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530025578")%><!--????????????--></td>
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
  <td>* <%=r.getString(teasession._nLanguage,"1167465545156")%><!--?????????????????????--></td>
  <td style="HEIGHT: 130px">
    <textarea name="tbFunction" class="edit_input" id="tbFunction" rows="7" wrap="VIRTUAL" cols="60"><%=employment.getFunction()%></textarea>
    <span class="note"><%=r.getString(teasession._nLanguage,"1167530123656")%><!--??????2000??????--></span>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530143921")%><!--??????/????????????--></td>
  <td><input  class="edit_input" name="tbReasonOfLeaving"  value="<%=employment.getReasonOfLeaving()%>" id="tbReasonOfLeaving" type="text" maxlength="100" size="60" />
</td>
</tr>
<%--
<tr>
  <td><%=r.getString(teasession._nLanguage,"1167530185062")%><!--????????????--></td>
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
--%>
  </table>

  <input type="button"   value="<%=r.getString(teasession._nLanguage,"??????")%>" onclick="f_add2();"  />
  <input type="button"    value="<%=r.getString(teasession._nLanguage,"1167530223796")%>" onclick="f_add();"/>
  <input type=button value="??????" onClick="javascript:window.location.href='/jsp/type/resume/EditResume2.jsp?node=<%=teasession._nNode%>';">

  <%--
  <!--?????????-->
  <input type="button"  name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditEducate.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
  <input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditResumeOther.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>

  <input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')" />

  --%>


  </form>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br>
</body>
</HTML>
