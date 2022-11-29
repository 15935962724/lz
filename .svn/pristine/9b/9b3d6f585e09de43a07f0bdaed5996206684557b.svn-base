<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.net.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
Resource r=new Resource();
r=r.add("/tea/resource/Workreport").add("/tea/ui/member/offer/Offers").add("/tea/ui/member/offer/ShoppingCarts").add("/tea/ui/member/Glance");
int srid = 0;
if(teasession.getParameter("srid")!=null && teasession.getParameter("srid").length()>0)
{
  srid = Integer.parseInt(teasession.getParameter("srid"));
}
SalesRecord srobj = SalesRecord.find(srid);
Node nobj = Node.find(srobj.getGoods());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >
<script>
function f_submit()
{
  if(form1.goods.value==0)
  {
    alert("请选择商品！");
    form1.goods.focus();
    return false;
  }
  if(form1.workproject.value==0)
  {
    alert("请选择客户或项目！");
    form1.workproject.focus();
    return false;
  }
  if(form1.buytime.value == '')
  {
    alert("请输入购买日期！");
    form1.buytime.focus();
    return false;
  }else
  {
    var ymd=form1.buytime.value.split("-");
    var month=ymd[1]-1
    var d = new Date(ymd[0],month,ymd[2]);
    if(d.getMonth()+1!=ymd[1]||d.getDate()!=ymd[2]||d.getFullYear()!=ymd[0]||ymd[0].length!=4)
    {
      alert('您输入的时间格式不正确，时间格式是：2009-01-01');
      form1.buytime.value='';
      form1.buytime.focus();
      return false;
    }
  }
  if(form1.workproject.value==0)
  {
    alert("请选择客户或项目！");
    form1.workproject.focus();
    return false;
  }
  if(form1.squantity.value!='')
  {
    var type= "^[0-9]*[1-9][0-9]*$";
    var re = new RegExp(type);
    if(form1.squantity.value.match(re)==null)
    {
      alert("请输入正确的购买数量！");
      form1.squantity.value='1';
      form1.squantity.focus();
      return false;
    }
  }
}
</script>
<!--选择会员-->
<h1><%=r.getString(teasession._nLanguage,"销售记录添加")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" METHOD="POST" action="/servlet/EditSalesRecord" onsubmit="return f_submit();" >
<input type=hidden name="act" value="EditSalesRecord"/>
<input type=hidden name="srid" value="<%=srid%>"/>
<input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr><td><%=r.getString(teasession._nLanguage,"商品名称")%></td>
    <td>
      <select name="goods">
        <option value="0">-------------</option>
        <%
        java.util.Enumeration e3=Node.findByType(34,teasession._strCommunity);
        while(e3.hasMoreElements())
        {
          int id=((Integer)e3.nextElement()).intValue();
          Node obj=Node.find(id);
          out.print("<option value="+id);
           if(id==srobj.getGoods()){
             out.print(" SELECTED ");
           }
          out.print(" >"+obj.getSubject(teasession._nLanguage));
        }
        %>
        </select>
        <input name="button" type="button" onClick="window.open('/jsp/admin/workreport/WrGoods_2.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.goods','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');" value="..."/>
    </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"客户或项目")%></td>
  <td>
    <select name="workproject" >
      <option value="0">-------------</option>
      <%
      java.util.Enumeration we=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
      while(we.hasMoreElements())
      {
        int id=((Integer)we.nextElement()).intValue();
        Workproject obj=Workproject.find(id);
        out.print("<option value="+id);
        if(srobj.getWorkproject()==id){
         out.print(" SELECTED ");
        }
        out.print(" >"+obj.getName(teasession._nLanguage));
      }
      %>
      </select>
      <input type="button" value="..." onClick="window.open('/jsp/admin/workreport/Workprojects_3.jsp?community=<%=teasession._strCommunity%>&fieldname=form1.workproject','','height=500,width=500,left=200,top=100,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"购买日期")%></td>
  <td><input name="buytime" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';" value="<%if(srobj.getBuytimeToString()!=null){out.print(srobj.getBuytimeToString());}else {out.print("yyyy-MM-dd");}%>">
    <A href="#"><img onClick="showCalendar('form1.buytime');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
  </td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"购买数量")%></td>
  <td><input type="text" name="squantity" value="<%=srobj.getSquantity() %>"></td>
</tr>
</table>
<br>
<input type="submit" value="保存销售记录">&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


