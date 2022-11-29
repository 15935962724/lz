<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);

EonNode en = EonNode.find(teasession._nNode);
if(teasession._rv==null&&en.isReg())
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String member=request.getParameter("member");//客服

int pn=Integer.parseInt(request.getParameter("processnum"));

Profile p=Profile.find(member);


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id=edntelwindow1>

<!--<h1><%=r.getString(teasession._nLanguage, EonRecord.PROCESS_TYPE[pn])%></h1>-->
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EonRecords" onSubmit="return submitText(form1.tel,'无效-号码');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="processnum" value="<%=pn%>">
<input type="hidden" name="nexturl" value="/jsp/eon/EonCall2.jsp?">
<input type="hidden" name="member" value="<%=member%>">
<input type="hidden" name="act" value="outbound">


  <!---->


<div id=edntelshuru>  请输入您的电话号码　
<input name="tel" type="text" style="width:174;margin:0;" onFocus="if (value =='11位手机号或者区号加电话号码'){value =''}" onBlur="if (value ==''){value='11位手机号或者区号加电话号码'}" onMouseOver=this.focus() value="11位手机号或者区号加电话号码"></div><!----><div id=edntelshuoming> 格式示例:01087654321 或 13987654321</div>
<input type="submit" value="　" id="edntelqueding"></form>
<div id="edntelshuoming1"><%//=teasession._rv._strV%>您将要接通的服务人员是：<%=member%><br>将要接通的电话是：<%=p.getTelephone(teasession._nLanguage)%>。</div>
<div id="edntelshuoming1">点击确定后您的电话将会振铃，接听后即为您接通商家。</div>
<div id="edntelshuoming2">（此项服务完全免费）</div>

</body>
</html>
