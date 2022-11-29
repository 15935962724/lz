<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl =null;


String memberorder = teasession.getParameter("memberorder");
  int membertype = 0;
  if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
  {
    membertype = Integer.parseInt(teasession.getParameter("membertype"));
  }
MemberOrder moobj = MemberOrder.find(memberorder);
MemberType mtobj = MemberType.find(membertype);

int v=0;//表示用户是否需要审核
if("0".equals(memberorder))
{

  RegisterInstall riobj = RegisterInstall.find(membertype);
  if(!MemberOrder.isMemberOrder(teasession._strCommunity,membertype,0,teasession._rv.toString())){


  if(riobj.getVerify()==0){//如果这个用户类型注册时候不需要审核，则，把标示修改成3
    v=3;
  }
   MemberOrder.create(membertype,0,teasession._rv.toString(),teasession._strCommunity,v,0,0);
    memberorder = MemberOrder.getMemberOrder(teasession._strCommunity,membertype,teasession._rv.toString());
    moobj = MemberOrder.find(memberorder);
    mtobj = MemberType.find(membertype);
  }
//  if(riobj.getVerify()==0){
//    moobj.setVerifg(2);
//  }
}else
{
  membertype = moobj.getMembertype();
  mtobj = MemberType.find(membertype);
}

//判断是 如果 MemberRecord 表中没有着个类型的用户  和 MemberPay 表中 有记录时候
//System.out.print(!MemberRecord.isMemberRecord(teasession._rv.toString(),membertype) +"--"+MemberPay.isMembertype(membertype));
if(!MemberRecord.isMemberRecord(teasession._rv.toString(),membertype) ){//&& MemberPay.isMembertype(membertype)
  MemberRecord.create(teasession._rv.toString(),membertype,teasession._strCommunity);
}

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">
<script type="">
function f_submit(){
  var flag=0
  if(form1.payid.length!='undefined')
  {
   if(form1.payid.checked==true)//判断只有一条记录时候
   {
     flag=1;
   }
  }
    for(i=0;i<form1.payid.length;i++){

      if(form1.payid[i].checked==true){
        flag=1;
        break;
      }
    }
  if(!flag){
    alert("请先选择您注册的服务")
    return false
  }
}
</script>
<form action="/jsp/mov/Success2.jsp" name="form1" method="POST" onsubmit="return f_submit(this);" >
<input type="hidden" name="memberorder" value="<%=memberorder%>"/>
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
out.print("<tr><td align=center colspan=5>&nbsp;您注册的是 (<b>"+mtobj.getMembername()+"</b>) 下面列表是显示此类会员的收费情况，请您选择缴费！</td></tr>");
out.print(" <tr id=tableonetr> <td width=1>&nbsp;</td> <td nowrap>服务费用</td> <td nowrap>服务期限</td><td nowrap>服务说明</td></tr>");

java.util.Enumeration mpe= MemberPay.find(teasession._strCommunity," AND membertype="+membertype,0,Integer.MAX_VALUE);
if(!mpe.hasMoreElements())
{
  out.println("<script>alert('您注册的此会员不用缴费，请选择其他会员注册，点击“确定”，会跳转到上一页面!');</script>");
  out.println("<script>self.location='/jsp/mov/AdminTransfer.jsp'</script>");
}
while(mpe.hasMoreElements())
{
  int payid = ((Integer)mpe.nextElement()).intValue();
  MemberPay mpobj = MemberPay.find(payid);
 // out.print(payid);
  out.print("<tr>");
  out.print("<td>");
  out.print("<input type=radio name=payid value="+payid);
  if(payid==moobj.getPayid())
      out.print("  checked=checked");

  out.print("></td>");
  out.print("<td>"+mpobj.getPaymoney()+"&nbsp;元</td>");
  out.print("<td>"+mpobj.getPaytime()+"&nbsp;年</td>");
  out.print("<td>"+mpobj.getPaycontent()+"</td>");
  out.print("</tr>");
}

%>


</table>
<p>
  <input type=button value="上一步" onClick="javascript:history.back()">&nbsp;&nbsp;&nbsp;
  <input type="submit" value="下一步" />
</p>
</form>


</body>
</html>

