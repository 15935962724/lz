<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.admin.*" %><%@ page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{

  param.append("&id=").append(menu_id);
}

int ids=0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
ProjectNotPay probj = ProjectNotPay.find(ids);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<script type="">
function sub_finds()
{
  if(form1.paymoney.value=="")
  {
    document.form1.paymoney.focus();
    alert("转账金额不能为空！！");
    return false;
  }
  if(form1.paydate.value=="")
  {
    document.form1.paydate.focus();
    alert("转账时间不能为空！");
    return false;
  }

//  if(form1.paytype.value=="" ||form1.paytype.value=="0"  )
//  {
//    document.form1.paytype.focus();
//    alert("支付方式不能为空！");
//    return false;
//  }
  return true;
}
function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+240;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:445px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/admin/flow/ProjectNotPaymember.jsp";
  var aio ="";
  document.all.member.value =window.showModalDialog(url,aio,sFeatures);
}
</script>
<title>非项目及人工支出管理</title>
</head>
<body>
<h1>非项目及人工支出管理</h1>
<form name="form1" action="/servlet/EditFlowitem" method="POST" enctype="multipart/form-data">

<input type="hidden" value="EditProjectNotPay"   name="act"/>
<input type="hidden" value="/jsp/admin/flow/EditProjectNotPay.jsp"   name="nexturl"/>
<input type="hidden" value="<%=ids%>"  name="ids"/>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td nowrap align="right">说明：</td><td nowrap><textarea name="payinfo" cols="30" rows="4"><%if(probj.getPayinfo()!=null)out.print(probj.getPayinfo());%></textarea></td></tr>
  <tr><td nowrap align="right">金额：</td><td nowrap><input value="<%if(probj.getPaymoney()!=null)out.print(probj.getPaymoney());%>" name="paymoney"  mask="float"/>　

</td></tr>
<tr><td nowrap align="right">转账时间：</td><td nowrap> <input name="paydate" size="7"  value="<%if(probj.getPaydatetoString()!=null)out.print(probj.getPaydatetoString());%>"><A href="###"><img onclick="showCalendar('form1.paydate');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td></tr>
  <tr>
    <td nowrap="nowrap" align="right">支付方式：</td>
    <td>
      <select name="paytype"></option>
      <%
      for(int i =0;i<ProjectNotPay.PAYTYPES.length;i++)
      {
        out.print("<option  value="+i);
        out.print(">"+ProjectNotPay.PAYTYPES[i]+"</option>");
      }
      %>
      </select></td>
  </tr>
  <tr><td nowrap align="right">接受方：</td><td><input name="receives" value="<%if(probj.getReceives()!=null)out.print(probj.getReceives());%>" /></td></tr>
  <tr><td nowrap align="right">经办人：</td><td><select name="member">
            <%
            Enumeration e = AdminUsrRole.findByCommunity(teasession._strCommunity," and  member in (select member from Profile)");
            for(int j=0;e.hasMoreElements();j++)
            {
              String members=String.valueOf(e.nextElement());
              AdminUsrRole obja=AdminUsrRole.find(teasession._strCommunity ,members);
              out.print("<option value="+members);
              String name="";
              if(Profile.isExisted(members))
              {
                Profile pro = Profile.find(members);
                name=pro.getName(teasession._nLanguage);
              }
              out.print("  >"+name);
              out.print("</option>");
            }
            %>
            </select><input type="button" value="查询" onclick="Loadnew(form1.member);" /></td></tr>

  <tr><td nowrap colspan="3" align="center"><input type="submit" value="提交" onclick="return sub_finds();" />　<input type=button value="返回" onClick="javascript:history.back()"/></td></tr>
</table>
</form>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>

