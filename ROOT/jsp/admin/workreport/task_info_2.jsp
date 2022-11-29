<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.*" %>
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
int taid  = 0;
if(teasession.getParameter("taid")!=null && teasession.getParameter("taid").length()>0)
	taid =Integer.parseInt(teasession.getParameter("taid"));
Task taobj = Task.find(taid);
String nexturl = (String)request.getParameter("nexturl");
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
<h1>我的任务详细信息</h1>

<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
    <td nowrap>任务主题</td><td><%if(taobj.getMotif()!=null)out.print(taobj.getMotif()); %></td>
</tr>
<tr>
    <td nowrap>到期日期</td><td nowrap><%if(taobj.getAttime()!=null)out.print(taobj.getAttime()); %></td>
</tr>
<tr>
    <td nowrap>状态</td><td nowrap>
    	<%if(taobj.getFettle()!=0)out.print(Task.FETTLE[taobj.getFettle()]); %>
    </td>
</tr>
<tr>
    <td nowrap>优先级</td><td nowrap>
      <%
         if(taobj.getPri()!=0){
           out.print(Task.PRI[taobj.getPri()]);}else{out.print("暂无");
         }
      %>
    </td>
</tr>
<tr>
    <td nowrap>备注</td><td><%if(taobj.getRemark()!=null){out.print(taobj.getRemark());}else{out.print("暂无");} %>
	</td>
</tr>
<tr>
    <td nowrap>创建人</td><td nowrap>
      <%
      if(taobj.getMember()!=null){
        for (int i = 0; i < taobj.getMember().split("/").length; i++) {
          tea.entity.member.Profile probj = tea.entity.member.Profile.find(taobj.getMember().split("/")[i]);
          out.println(probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage));
        }
      }else{
        out.print("暂无");}
        %>
    </td>
</tr>
<tr>
    <td nowrap>创建时间</td><td nowrap><%if(taobj.getTimes()!=null){out.print(taobj.getTimesToString());}else{out.print("暂无");} %></td>
</tr>
<tr>
    <td nowrap>任务接受人</td><td nowrap>
      <%
      if(taobj.getAssigner()!=null){
          out.println(taobj.getAssigner());
      }else{out.print("暂无");}
      %>
    </td>
</tr>
<tr>
    <td nowrap>修改时间</td><td nowrap><%if(taobj.getTimexg()!=null){ out.print(taobj.getTimexgToString());}else{out.print("暂无");} %></td>
</tr>
</table>
 <input type="button" value="返回" onClick="location='<%=nexturl%>'">

</body>
</html>




