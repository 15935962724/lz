<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.ui.TeaSession"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  /*if(teasession._rv==null)
   {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
   }*/
  String community = teasession._strCommunity;
  DbAdapter db = new DbAdapter();
  String name = "";
  String introduce = "";
  try {
    db.executeQuery("select clientname,downloadpath from updatepath");
    if (db.next()) {
      name = db.getString(1);
      introduce = db.getString(2);
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  if (request.getMethod().equals("POST")) {
    name = request.getParameter("name");
    introduce = request.getParameter("introduce");
    try {
      int count = db.getInt("select count(1) from updatepath");
      if (count == 0) {
        db.executeUpdate("insert into  updatepath(clientname,downloadpath )values(" + DbAdapter.cite(name) + "," + DbAdapter.cite(introduce) + ")");
      }
      else {
        db.executeUpdate("update updatepath set clientname=" + DbAdapter.cite(name) +
                         ",downloadpath=" + DbAdapter.cite(introduce));
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    db.close();
    response.sendRedirect("/jsp/version/setpath.jsp");
  }else
  db.close();
%>
<html>
<head>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>设置客户号</title>
<style type="text/css">
  <!--
    .style1 {font-size: 12px}
  -->
</style>
</head>
<body bgColor=#fffde8>
<center>
  <FORM name=form1 METHOD=POST action="<%=request.getRequestURI()%>" onSubmit="">
  <table class="right" id="tablecenter" width="800" border="1" cellpadding="0" cellspacing="0">
    <tr class="right">
      <td class="right" colspan="8">&nbsp;</td>
    </tr>
    <tr class="right">
      <td class="right" colspan="8">设置升级路径</td>
    </tr>
    <tr class="right">
      <td width="91" class="style1">客户号</td>
      <td class="right" width="114">
        <input name="name" type="text" class="style1" value="<%=name%>" size="15"/>
        <font color="red">*</font>
      </td>
    </tr>
    <tr class="right">
      <td class="right">升级服务器路径</td>
      <td class="right" colspan="7">
        <input name="introduce" value="<%=introduce%>" type="text" size="100">
      </td>
    </tr>
    <tr class="right">
      <td class="right" colspan="8">
        <input type="submit" name="Submit" value="提交">
      </td>
    </tr>
  </table>
  </form>
</center>
</body>
</html>
