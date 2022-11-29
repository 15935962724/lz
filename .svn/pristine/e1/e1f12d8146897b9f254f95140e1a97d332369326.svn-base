<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.site.*" %>
<%@ page import="tea.entity.site.*" %>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer("");
int pos=0;

String community = teasession._strCommunity;
Communityintegral comint = Communityintegral.find(teasession._strCommunity);
boolean falg = false;

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">
<h1>
积分系统管理平台
</h1>
<form action="/servlet/EditIntegralManage" method="POST" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
  <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="act" value="manage" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td  nowrap="nowrap">系统说明：</td><td>为了更加有效的反映网站的活跃度，网站积分算法，同时将会员的积分消费在商城商品上。
</td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>积分设置：</td><td></td>
</tr>
<br>

<tr><td>暂无会员类型</td><td></td>
</tr>


<tr><td>注册会员：</td><td>赠送积分:<input type="text"  size="10" name="linemember" value="10"/></td></tr>
<tr><td></td> <td></td></tr>
<tr><td>登录积分：登录<input  type="text" size="5" name="logintime" value="<%=comint.getLogintime()%>"/>次数<input  type="text" size="5" name="loginlimit" value="<%=comint.getLoginlimit()%>"/>限制的次数</td><td>赠送积分:<input type="text"  name="loginintegral" value="<%=comint.getLoginintegral()%>" size="10"/></td></tr>
<tr><td>论坛发帖：A类型(精华贴)</td> <td>赠送积分:<input type="text"  size="10" value="<%=comint.getPink_A()%>" name="pink_A"/></td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B类型(普通贴)</td> <td>赠送积分:<input type="text"  size="10" name="pink_B" value="<%=comint.getPink_B()%>"/></td></tr>
<tr><td></td> <td></td></tr>
<tr><td>问答中心模块</td> <td></td></tr>
<tr><td>发布问题最低支付分值：<input  type="text" size="10" value="<%=comint.getQu_low()%>" name="qu_low"/></td> <td>发布问题最高支付分值：<input type="text"  size="10" value="<%=comint.getQu_high()%>" name="qu_high"/></td></tr>
<tr><td>回答问题系统奖励分值：<input  type="text" size="10" value="<%=comint.getQu_answer()%>" name="qu_answer"/></td> <td></td></tr>
<tr>
<td colspan="2" align="center"><input type="submit" value="提交" /></td>
</tr>
</table>
</form>
</body>
</html>
