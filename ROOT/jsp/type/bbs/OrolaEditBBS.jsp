<%@page contentType="text/html;charset=UTF-8" %><%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.resource.Resource r = new tea.resource.Resource();
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "OrolaEditBBS")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditBBS" onSubmit="return(submitText(this.name, '无效姓名')&&submitText(this.phone, '无效电话')&&submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.Text, '无效内容'));">
  <%
  String parameter=request.getParameter("nexturl");
  boolean   parambool=(parameter!=null&&!parameter.equals("null"));
  if(parambool)
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
  if(request.getParameter("NewNode")!=null)
  {
    out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
  }
  %>
<INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">


<input type="hidden" name="Hint" value="0" >
 <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <tr>
      <td>姓名</td>
      <td><input name="name" type="text" maxlength="50">
        (必填)</td>
    </tr>
	    <tr>
      <td>电话</td>
      <td><input name="phone" type="text" maxlength="30">
(必填)</td>
    </tr>
    <tr>
      <td>E-Mail</td>
      <td><input name="email" type="text" maxlength="50"></td>
    </tr>
    <tr>
      <td>所在区域</td>
      <td><input name="area" type="text" size="10" maxlength="30">
        省</td>
    </tr>
    <tr>
      <td>地址</td>
      <td><input name="address" type="text" size="40" maxlength="128"></td>
    </tr>
    <tr>
      <td>主题</td>
      <td><input name="Subject" type="text" size="60">        </td>
    </tr>
    <tr>
      <td>内容</td>
      <td><textarea name="Text" cols="60" rows="8"></textarea></td>
    </tr>
  </table>
  <input type="submit" name="Submit" value="提交">
  <input type="reset" name="Submit" value="重置">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

