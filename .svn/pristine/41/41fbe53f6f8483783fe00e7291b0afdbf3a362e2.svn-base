<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.admin.SubsidyTime st_obj=tea.entity.admin.SubsidyTime.find(node.getCommunity());
if(request.getMethod().equals("POST"))
{
int startsubsidymonth=Integer.parseInt(request.getParameter("startsubsidymonth"));
int startsubsidyday=Integer.parseInt(request.getParameter("startsubsidyday"));

int stopsubsidymonth=Integer.parseInt(request.getParameter("stopsubsidymonth"));
int stopsubsidyday=Integer.parseInt(request.getParameter("stopsubsidyday"));

int startpayoutmonth=Integer.parseInt(request.getParameter("startpayoutmonth"));
int startpayoutday=Integer.parseInt(request.getParameter("startpayoutday"));

int stoppayoutmonth=Integer.parseInt(request.getParameter("stoppayoutmonth"));
int stoppayoutday=Integer.parseInt(request.getParameter("stoppayoutday"));

int startsfaccountmonth=Integer.parseInt(request.getParameter("startsfaccountmonth"));
int startsfaccountday=Integer.parseInt(request.getParameter("startsfaccountday"));

int stopsfaccountmonth=Integer.parseInt(request.getParameter("stopsfaccountmonth"));
int stopsfaccountday=Integer.parseInt(request.getParameter("stopsfaccountday"));

int startmonth=Integer.parseInt(request.getParameter("startmonth"));
int stopmonth=Integer.parseInt(request.getParameter("stopmonth"));

st_obj.set(startsubsidymonth,startsubsidyday,stopsubsidymonth,stopsubsidyday,startpayoutmonth,startpayoutday,stoppayoutmonth,stoppayoutday,
startsfaccountmonth,startsfaccountday,stopsfaccountmonth,stopsfaccountday,startmonth,stopmonth);
response.sendRedirect("InfoSuccess.jsp?node="+teasession._nNode);
return ;
}

%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>设置提交时间</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>
<form action="/jsp/admin/schoolfinance/EditSubsidyTime.jsp?node=<%=teasession._nNode%>" method="post">
<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
<TR id="tableonetr">
      <td>项目</td>
      <td>开始时间</td>
      <td>结束时间</td>
    </tr>
    <tr>
      <td>津贴单位组别及总数</td>
      <td><select name="startsubsidymonth">
        <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartSubsidyMonth())out.println("selected");%>><%=index%></option>
        <%}%>
        </select>
        月
        <select name="startsubsidyday">
                 <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartSubsidyDay())out.println("selected");%>><%=index%></option>
        <%}%>
        </select>
        日</td>
      <td><select name="stopsubsidymonth">
            <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopSubsidyMonth())out.println("selected");%>><%=index%></option>
        <%}%>
        </select>
        月
        <select name="stopsubsidyday">
           <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopSubsidyDay())out.println("selected");%>><%=index%></option>
        <%}%>
        </select>
        日</td>
    </tr>
    <tr>
      <td>支出预算</td>
      <td><select name="startpayoutmonth">
          <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartPayoutMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
月
<select name="startpayoutday">
    <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartPayoutDay())out.println("selected");%>><%=index%></option>
        <%}%>
</select>
日</td>
      <td><select name="stoppayoutmonth">
          <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopPayoutMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
月
<select name="stoppayoutday">
     <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopPayoutDay())out.println("selected");%>><%=index%></option>
        <%}%>
</select>
日</td>
    </tr>
    <tr>
      <td>学校流动现金</td>
      <td><select name="startsfaccountmonth">
         <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartSfaccountMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
月
<select name="startsfaccountday">
 <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartSfaccountDay())out.println("selected");%>><%=index%></option>
        <%}%>
</select>
日</td>
      <td><select name="stopsfaccountmonth">
         <%
        for(int index=1;index<=12;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopSfaccountMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
月
<select name="stopsfaccountday">
   <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopSfaccountDay())out.println("selected");%>><%=index%></option>
        <%}%>
</select>
日</td>
    </tr>
    <tr>
      <td>月财政报告</td>
      <td><select name="startmonth">
          <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStartMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
日</td>
      <td><select name="stopmonth">
         <%
        for(int index=1;index<=31;index++)
        {        %>
        <option value="<%=index%>" <%if(index==st_obj.getStopMonth())out.println("selected");%>><%=index%></option>
        <%}%>
      </select>
日</td>
    </tr>

  </table>
<input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>
<br/>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



