<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
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
    <td nowrap>任务主题</td><td nowrap><%if(taobj.getMotif()!=null)out.print(taobj.getMotif()); %></td>
</tr>
<tr>
    <td nowrap>到期日期</td><td nowrap><%=taobj.getAttimeToString()%></td>
</tr>
<tr>
    <td nowrap>状态</td><td nowrap>
    	<%if(taobj.getFettle()!=0)out.print(Task.FETTLE[taobj.getFettle()]); %>
    </td>
</tr>
<tr>
    <td nowrap>状态说明</td><td nowrap>
    	<%if(taobj.getZtcontent()!=null)out.print(taobj.getZtcontent()); %>
    </td>
</tr>
<tr>
    <td nowrap>优先级</td><td nowrap><%if(taobj.getPri()!=0){out.print(Task.PRI[taobj.getPri()]);}else{out.print("暂无");} %></td>
</tr>
<tr>
    <td>备注</td><td nowrap><%if(taobj.getRemark()!=null){out.print(taobj.getRemark().replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;"));}else{out.print("暂无");} %></td>
</tr>
<tr>
    <td nowrap>创建人</td><td nowrap>
      <%
      if(taobj.getMember()!=null){
        Profile profi = Profile.find(taobj.getMember());
        out.print(profi.getLastName(teasession._nLanguage)+profi.getFirstName(teasession._nLanguage));
      }else{
        out.print("暂无");
       }
       %>
    </td>
</tr>
<tr>
    <td nowrap>创建时间</td><td nowrap><%=taobj.getTimesToString()%></td>
</tr>
<tr>
    <td nowrap>修改人</td><td nowrap>
      <%
      if(taobj.getMemberxg()!=null){
        Profile profi = Profile.find(taobj.getMemberxg());
        out.print(profi.getLastName(teasession._nLanguage)+profi.getFirstName(teasession._nLanguage));
      }else{
        out.print("暂无");
      }
      %>
    </td>
</tr>
<tr>
    <td nowrap>修改时间</td><td nowrap><%if(taobj.getTimexg()!=null){ out.print(taobj.getTimexgToString());}else{out.print("暂无");} %></td>
</tr>
<tr>
<td nowrap>附件</td>
<%
   String accessories = taobj.getAcceename();
   if(accessories!=null&&accessories.length()!=0)
   {
   String url = taobj.getAcceefile();
   String picType = accessories.substring(accessories.lastIndexOf(".")+1).toLowerCase();
   String picImg = "<img src=/tea/image/other/download.gif>";
   if(picType.equals("jpg")||picType.equals("gif")||picType.equals("bmp")||picType.equals("png"))
   {
     picImg="<img height=20 width=20 src="+url+">";
   }

   %>
   <td nowrap>
     <% out.println("<a href= /jsp/include/DownFile.jsp?uri="+url+"&name="+java.net.URLEncoder.encode(accessories,"UTF-8")+">"+accessories+"&nbsp"+picImg+"</a>");
     %>
   </td>
  <% }%>
</tr>
</table>
 <input type="button" value="返回" onclick="history.back();">

</body>
</html>


