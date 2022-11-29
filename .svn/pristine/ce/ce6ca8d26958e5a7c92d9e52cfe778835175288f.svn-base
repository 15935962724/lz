<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Outlay" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int outlay=Integer.parseInt(request.getParameter("outlay"));
if(request.getMethod().equals("POST"))
{
  String type=(request.getParameter("type"));
  java.math.BigDecimal money=new java.math.BigDecimal(request.getParameter("money"));
  java.util.Date time=Outlay.sdf.parse(request.getParameter("timeYear")+"-"+request.getParameter("timeMonth")+"-"+request.getParameter("timeDay"));

  if(outlay==0)
  Outlay.create(type,money,time,community);
  else
  {
    Outlay obj=Outlay.find(outlay);
    obj.set(type,money,time,community);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();

String type;
java.math.BigDecimal money;
java.util.Date time=null;
if(outlay!=0)
{
  Outlay obj=Outlay.find(outlay);
  type=obj.getType();
  money=obj.getMoney();
  time=obj.getTime();
}else
{
  type="";
  money=new java.math.BigDecimal("0.00");
}
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.type.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目创建</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="" method="post" onSubmit="return submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-经费类别')&&submitFloat(this.money, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-经费数额')">
<input type=hidden name="outlay" value="<%=outlay%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>经费类别</td>
         <TD><input name="type" type="text" id="type" value="<%=type%>" size="40"></TD>
</tr>
       <tr>

        <td>经费数额</td>
         <td nowrap>
         <textarea name="money" mask="nnnnnnnn.nn" cols="20" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%=money%></textarea>
         </td>
       </tr>
       <tr>
         <td>拨付日期</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("time", time)%> </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


