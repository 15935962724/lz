<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.admin.map.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String sid=request.getParameter("sid");

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getRequestURI()+"?"+request.getQueryString();
}

String name=null,addr=null,tel=null,info=null,email=null,keyword=null;

if(sid!=null)
{
  Mapabc obj=Mapabc.find(sid);
  name=obj.getName();
  addr=obj.getAddr();
  tel=obj.getTel();
  info=obj.getInfo();
  email=obj.getEmail();
  keyword=obj.getKeyword();
}

String jsid=(String)session.getAttribute("map.sessionid");
if(jsid==null)
{
	jsid=Mapabc.getSessionid();
	session.setAttribute("map.sessionid",jsid);
}


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel=stylesheet type=text/css>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>创建/修改地图标点</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form NAME="form1" ACTION="/servlet/EditMapabc" METHOD="post" enctype="multipart/form-data" onSubmit="return submitText(this.name,'无效-名称')&&submitText(this.addr,'无效-地址')&&submitText(this.tel,'无效-电话');">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type='hidden' name="oper" value="1">
  <input type='hidden' name="jsid" value="<%=jsid%>">
  <input type='hidden' name="sid" value="<%if(sid!=null)out.print(sid);%>">
  <%--
  if(sid!=null)
	  out.print("<input type=hidden name=sid value="+sid+" >");
  --%>
  <input type="hidden" name="nexturl" value="<%=nexturl%>">


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>标点:</td><td>

<iframe frameborder="0" width=720 height=530 src="http://mc.mapabc.com/newedit/pointmap/gridmap.jsp;jsessionid=<%=jsid%>?citycode=010&w=700&h=300<%if(sid!=null)out.print("&sid="+sid);%>"></iframe>

</td></tr>

    <tr>
      <td>*名称:</td>
      <td><input name="name" size="30" maxlength="50" value="<%if(name!=null)out.print(name);%>"></td>
    </tr>
    <tr>
      <td>*地址:</td>
      <td><input name="addr" size="30" maxlength="100" value="<%if(addr!=null)out.print(addr);%>"></td>
    </tr>
    <tr>
      <td>*电话:</td>
      <td><input name="tel" size="30" maxlength="100" value="<%if(tel!=null)out.print(tel);%>">
    </tr>
    <tr>
      <td>简介</td>
      <td><input name="info" size="30" maxlength="20" value="<%if(info!=null)out.print(info);%>"></td>
    </tr>
    <tr>
      <td>电子邮件:</td>
      <td><input name="email" size="30" maxlength="100" value="<%if(email!=null)out.print(email);%>"></td>
    </tr>
    <tr>
      <td>关键字:</td>
      <td colspan=3><input type="text" name="keyword" maxlength="60" size="60" value="<%if(keyword!=null)out.print(keyword);%>"></td>
    </tr>
    <%--
    <tr>
      <td>东:</td>
      <td><input type="file" name="pic0"></td>
    </tr>
    <tr>
      <td>南</td>
      <td><input type="file" name="pic1"></td>
    </tr>
    <tr>
      <td>西</td>
      <td><input type="file" name="pic2"></td>
    </tr>
    <tr>
      <td>北</td>
      <td><input type="file" name="pic3"></td>
    </tr>
    <tr>
      <td>天</td>
      <td><input type="file" name="pic4"></td>
    </tr>
    --%>
    <tr>
      <td></td>
      <td><input TYPE="SUBMIT" VALUE="下一步">
      <input TYPE="RESET" VALUE="重置"></td>
    </tr>
  </TABLE>

</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
