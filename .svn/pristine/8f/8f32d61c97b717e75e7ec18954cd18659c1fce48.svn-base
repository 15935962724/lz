<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;//request.getParameter("community");
String menuid=request.getParameter("id");

Resource r=new Resource();

StringBuffer sql=new StringBuffer(" ");
StringBuffer param=new StringBuffer();
StringBuffer strshow=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(menuid);
String time_k="",time_j="",firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname =teasession.getParameter("firstname");
  sql.append(" and  member in ( select member from profilelayer where lastname+firstname like "+DbAdapter.cite("%"+firstname+"%")+")");
  param.append("&firstname=").append(firstname);
}

if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  paydate>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
  strshow.append(" 　从：").append(time_k);
}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  paydate<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
  strshow.append(" 　到：").append(time_j);
}

int deleteid =0;
if(teasession.getParameter("deleteid")!=null && teasession.getParameter("deleteid").length()>0)
{
  deleteid = Integer.parseInt(teasession.getParameter("deleteid"));
  ProjectNotPay.delete(deleteid);
}

param.append("&pos=");
String tmp=request.getParameter("pos");
int pos=tmp==null?0:Integer.parseInt(tmp);
int count=ProjectNotPay.count(community,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
  o="paydate";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>
</head>
<body>

<h1>非项目及人工支出记录</h1>

<h2>查询</h2>
   <form name=form1 METHOD=get action="/jsp/admin/flow/ProjectNotPay.jsp" onSubmit="">
   <input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>经办人：<input name="firstname" value="<%if(firstname!=null)out.print(firstname);%>"></td>
       <td colspan="2">支付时间：</td>
    <td>&nbsp;从&nbsp;
      <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form3.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
        <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form3.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
       <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表 <%=count%></h2>
   <form name=form2 METHOD=get  action="/jsp/admin/workreport/EditFlowitem.jsp">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="flowitem" value="0"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap>序号</td>
       <td nowrap><a href="javascript:f_order('paydate');">支付日期</a>
  <%
  if(o.equals("paydate"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td>
       <td nowrap><a href="javascript:f_order('paymoney');">金额</a>
  <%
  if(o.equals("paymoney"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td>
       <td nowrap>说明</td>
       <td nowrap><a href="javascript:f_order('paydate');">支付方式</a>
  <%
  if(o.equals("paytype"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td>
       <td nowrap>接受方</td>
       <td nowrap>经办人</td>
       <td>操作</td>
     </tr>
<%
java.util.Enumeration enumer=ProjectNotPay.findByCommunity(community,sql.toString(),pos,10);
for(int i=0;enumer.hasMoreElements();i++)
{
  int proid=((Integer)enumer.nextElement()).intValue();
  ProjectNotPay obj=ProjectNotPay.find(proid);

  String nameshow="";
  if(true)
  {
    Profile pro = Profile.find(obj.getMember());
    nameshow = pro.getName(teasession._nLanguage);
  }

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=i+1%></td>
    <td><%=obj.getPaydatetoString()%></td>
    <td><%=obj.getPaymoney()%></td>
    <td><%=obj.getPayinfo()%></td>
    <td><%=ProjectNotPay.PAYTYPES[obj.getPaytype()]%></td>
    <td><%=obj.getReceives()%></td>
    <td><%=nameshow%></td>
    <td>
    <input value="编辑" type="button"  onclick="window.open('/jsp/admin/flow/EditProjectNotPay.jsp?ids=<%=proid%>','_self')" />
    <input  type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/admin/flow/ProjectNotPay.jsp?deleteid=<%=proid%>', '_self');this.disabled=true;};" >
    </td>
 </tr>
<%
}

%>
<tr> <td colspan="8" align="center"><input value="添加" type="button"  onclick="window.open('/jsp/admin/flow/EditProjectNotPay.jsp','_self')" /></td>
</tr>
  <tr><td colspan="8"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

</table>

</form>
</body>
</HTML>
