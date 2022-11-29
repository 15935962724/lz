<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.service.*"%>
<%@page import="tea.entity.csvclub.*"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%
TeaSession teasession=new TeaSession(request);

Date timeDate = new Date();
java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());//Timestamp类型,timeDate.getTime()返回一个long型
long timeStamp = System.currentTimeMillis();
//SMS.md5("youku_"+timeStamp+"_csv-youku").toLowerCase();
String member = "";
member = teasession._rv.toString();
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Profile pro = Profile.find(member);


Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
String ykpid=obj.get("ykpid");
if(ykpid==null)
{
  ykpid="";
}
int yktype=obj.getInt("yktype");
if(yktype==2)
{
  yktype=1;
}
String ykreurl=obj.get("ykreurl");
if(ykreurl==null)
{
  ykreurl="";
}

%>
<html>
<body bgcolor="#ffffff">
<form action="http://api.youku.com/api_ptuser/action_login" method="post" name="login" id="login">
<p>puid: <input type="text" name="puid" id="puid" value="<%=member%>" /></p>
<p>pwd: <input type="text" name="pwd" id="pwd" value="<%=SMS.md5("123456").toLowerCase()%>" /></p>
  <p>email: <input type="text" name="email" id="email" value="<%=pro.getEmail()%>" /> 注册邮箱（介意填写）</p>
  <div class="verify">
    <p>参数部分：<br/>
      type: <input type="text" name="type" value="<%=yktype%>" /> 返回类型 1.直接输出结果 2.转向url<br/>
      reurl: <input type="text" name="reurl" value="<%=ykreurl%>" size="30" /> 回调url<br/>
      pid: <input type="text" name="pid" value="<%=ykpid%>" /> 合作商编号<br/>
      ctime: <input type="text" name="ctime" value="<%=timeStamp%>" /> 当前时间<br/>
      token: <input type="text" name="token" value="<%=SMS.md5("youku_"+timeStamp+"_csv-youku").toLowerCase()%>" /> 验证 md5('youku_<%=timeStamp%>_csv-youku)<br/>
</p>
  </div>
  <p><input type="submit" name="button" id="button" value="提交" /></p>
</form>
</body>
</html>
