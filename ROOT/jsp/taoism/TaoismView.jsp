<%@page import="tea.entity.taoism.Situation"%>
<%@page import="tea.entity.taoism.Taoism"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
int id=h.getInt("tid",0);
Taoism t=Taoism.find(id);
String avatar=MT.f(t.picture,"/tea/image/avatar.gif");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/country3.js" type="text/javascript"></script>
</head>
<body>
<h1>皈依弟子信息</h1>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td align="right">系统编号:</td>
    <td colspan="2"><%=MT.f(t.sysId) %></td>
    <td align="right">姓名：</td>
    <td><%=MT.f(t.name) %></td>
    <td align="right">性别：</td>
    <td><%=t.sex==0?"男":"女" %></td>
    <td rowspan="6"><input type="hidden" name="picture"  value="<%if(avatar.equals("/tea/image/avatar.gif"))out.print("");else out.print(avatar);%>" /><img id="_avatar" src="<%=avatar%>" onClick="image_change(this)"/><br/><span style="color:red;font-size: 13px"></span></td>
  </tr>
  <tr>
    <td align="right">出生年月：</td>
    <td colspan="2"><%=MT.f(t.birthday)%></td>
    <td align="right">年龄：</td>
    <td><%=MT.f(t.age)%></td>
    <td align="right">名族：</td>
    <td><%=Taoism.ETHNIC[t.ethnic] %></td>
  </tr>
  <tr>
    <td align="right">文化程度：</td>
    <td colspan="2"><%=Taoism.EDUC_LV[t.educ_lv] %></td>
    <td align="right">毕业院校：</td>
    <td><%=MT.f(t.school)%></td>
    <td align="right">所学专业：</td>
    <td><%=MT.f(t.professional)%></td>
  </tr>
  <tr>
    <td align="right">手机：</td>
    <td colspan="2"><%=MT.f(t.mobile)%></td>
    <td align="right">E-mail：</td>
    <td><%=MT.f(t.email)%></td>
    <td align="right">QQ号：</td>
    <td><%=MT.f(t.qq)%></td>
  </tr>
  <tr>
    <td align="right">身份证号：</td>
    <td colspan="2"><%=MT.f(t.idCard)%></td>
    <td align="right">微信号：</td>
    <td colspan="3"><%=MT.f(t.weixinId)%></td>
  </tr>
  <tr>
    <td align="right">户籍所在地：</td>
    <td colspan="6"><script>document.write(mt.country('<%=t.huji_c%>,<%=t.huji_p%>,<%=t.huji_s%>'));</script><%=MT.f(t.huji_address)%></td>
  </tr>
  <tr>
    <td align="right">居住地址：</td>
    <td colspan="7"><script>document.write(mt.country('<%=t.live_c%>,<%=t.live_p%>,<%=t.live_s%>'));</script><%=MT.f(t.live_address)%></td>
  </tr>
  <tr>
    <td align="right">通信地址：</td>
    <td colspan="7"><script>document.write(mt.country('<%=t.communication_c%>,<%=t.communication_p%>,<%=t.communication_s%>));</script><%=MT.f(t.communication_address)%></td>
  </tr>
  <tr>
    <td align="right">师父姓名：</td>
    <td colspan="2"><%=MT.f(t.master_name)%></td>
    <td align="right">电话：</td>
    <td><%=MT.f(t.phone)%></td>
    <td align="right">皈依证编号：</td>
    <td colspan="2"><%=MT.f(t.convertId)%></td>
  </tr>
  <tr>
    <td align="right">从事工作：</td>
    <td colspan="2"><%=MT.f(t.job)%></td>
    <td align="right">工作单位：</td>
    <td><%=MT.f(t.job_unit)%></td>
    <td align="right">皈依时间：</td>
    <td colspan="2"><%=MT.f(t.convert_time)%></td>
  </tr>
  <tr>
    <td align="right">特长：</td>
    <td colspan="2"><%=MT.f(t.specialty)%></td>
    <td align="right">获得证书：</td>
    <td colspan="4"><%=MT.f(t.certificate)%></td>
  </tr>
  <tr>
    <td align="right">教育及工作简历：</td>
    <td colspan="7"><%=MT.f(t.job_resume)%></td>
  </tr>
  <tr>
    <td rowspan="2" align="right">宫观意见：</td>
    <td align="right">推荐意见：</td>
    <td colspan="6"><%=MT.f(t.temples_opinion)%></td>
  </tr>
  <tr>
    <td align="right">推荐人姓名：</td>
    <td><%=MT.f(t.t_name)%></td>
    <td align="right">日期：</td>
    <td><%=MT.f(t.t_time)%></td>
    <td align="right">备注：</td>
    <td colspan="2"><%=MT.f(t.t_ramark)%></td>
  </tr>
  <tr>
    <td rowspan="2" align="right">道协审核意见：</td>
    <td align="right">推荐意见：</td>
    <td colspan="6"><%=MT.f(t.ass_opinion)%></td>
  </tr>
  <tr>
    <td align="right">推荐人姓名：</td>
    <td><%=MT.f(t.a_name)%></td>
    <td align="right">日期：</td>
    <td><%=MT.f(t.a_time)%></td>
    <td align="right">备注：</td>
    <td colspan="2"><%=MT.f(t.a_ramark)%></td>
  </tr>
  <tr>
    <td align="right">最近年检情况：</td>
    <td align="right">皈依证颁发时间：</td>
    <%
     Situation s=Situation.findbytid(t.id);
    %>
    <td><%=MT.f(s.ctime) %></td>
    <td align="right">年检情况：</td>
    <td><%=MT.f(s.situation) %></td>
    <td colspan="3"><input type="button" value="查看年检情况" onclick="mt.show('/jsp/taoism/SituationList1.jsp?situationId=<%=t.id %>',2,'年检情况',700,500)"></td>
  </tr>
  
  <tr>
    <td align="right">参加学习及培训情况：</td>
    <td colspan="7"><%=MT.f(t.situation)%></td>
  </tr>
  <tr>
    <td align="right">宫观参访及参加宗教活动记录：</td>
    <td colspan="7"><%=MT.f(t.g_content)%></td>
  </tr>
  <tr>
    <td align="right">慈善捐赠情况：</td>
    <td colspan="7"><%=MT.f(t.c_content)%></td>
  </tr>
  <tr>
    <td align="right">学术文章投稿情况：</td>
    <td colspan="7"><%=MT.f(t.x_content)%></td>
  </tr>
  <tr>
    <td align="right">法务流通情况：</td>
    <td colspan="7"><%=MT.f(t.f_content)%></td>
  </tr>
  <tr>
    <td align="right">咨询及活动意向情况：</td>
    <td colspan="7"><%=MT.f(t.z_content)%></td>
  </tr>
</table>


</body>
</html>
