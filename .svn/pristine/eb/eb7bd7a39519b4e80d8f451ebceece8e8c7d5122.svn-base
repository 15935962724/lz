<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int itemoutlay=Integer.parseInt(request.getParameter("itemoutlay"));
if(request.getMethod().equals("POST"))
{
  java.math.BigDecimal money=new java.math.BigDecimal(request.getParameter("money"));
  int item=Integer.parseInt(request.getParameter("item"));

  //已拨经费
  java.math.BigDecimal money2=Itemoutlay.findPaymentByItem(item);
  if(itemoutlay==0)
  money2=money2.add(money);
  else
  {
    Itemoutlay obj=Itemoutlay.find(itemoutlay);
    money2=money2.add(money).subtract(obj.getMoney());
  }
  if(ItemBudget.getTotal(item).compareTo(money2)<0)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("已拨付经费加上本次划拨经费大于该项目总经费,经费已超支！拒绝拨付.","UTF-8"));
    return;
  }

  int outlay=Integer.parseInt(request.getParameter("outlay"));
  int poyear=Integer.parseInt(request.getParameter("poyear"));
  java.util.Date time=Itemoutlay.sdf.parse(request.getParameter("timeYear")+"-"+request.getParameter("timeMonth")+"-"+request.getParameter("timeDay"));
  boolean adequate=Boolean.parseBoolean(request.getParameter("adequate"));
  if(itemoutlay==0)
  {
    Itemoutlay.create(item,poyear,money,outlay,time);
  }else
  {
    Itemoutlay obj=Itemoutlay.find(itemoutlay);
    obj.set(item,poyear,money,outlay,time);
  }
  Item item_obj=Item.find(item);
  item_obj.setAdequate(adequate);
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();

int outlay=0,poyear=2006,item=0;
java.math.BigDecimal money;
java.util.Date time=null;
boolean adequate=false;
if(itemoutlay!=0)
{
  Itemoutlay obj=Itemoutlay.find(itemoutlay);
  outlay=obj.getOutlay();
  poyear=obj.getPoyear();
  item=obj.getItem();
  Item item_obj=Item.find(item);
  adequate=item_obj.isAdequate();
  money=obj.getMoney();
  time=obj.getTime();
}else
{
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
  form1.poyear.focus();
}
function fcheck()
{

}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目经费划拨</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="" method="post" onSubmit="return submitInteger(this.poyear, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-拨付年度')&&submitFloat(this.money, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-经费数额')&&submitText(this.outlay, '无效-经费来源');">
<input type=hidden name="itemoutlay" value="<%=itemoutlay%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr>
         <td>项目计划号</td>
         <td nowrap>
		 <select name="item" id="item">
		 <%
java.util.Enumeration enumer= Item.find(community,"",0,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(id);
  out.print("<option value="+id);
  if(item==id)
  {
      out.print(" SELECTED ");
  }
  out.println(" >"+obj.getCode());

}
                 %>
		 </select>
		 </td>
       </tr>
	        <tr>
         <td>拨付日期</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("time", time)%> </td>
       </tr>
     <tr>
       <td>拨付年度</td>
         <TD>
           <select name="poyear">
         <%
         for(int index=2000;index<2016;index++)
         {
           out.print("<option value="+index);
           if(poyear==index)
           out.print(" selected ");
           out.print(">"+index);
         }
         %>
           </select>
         </TD>
</tr>
       <tr>

        <td>拨付经费</td>
         <td nowrap>
         <textarea name="money" mask="nnnnnnnn.nn" cols="20" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%=money%></textarea>
         </td>
       </tr>
	          <tr>

        <td>本经费来源 </td>
         <td nowrap><select name="outlay">
		 <option value="">-------------
<%
java.util.Enumeration enumer2= Outlay.find(community,"",0,Integer.MAX_VALUE);
while(enumer2.hasMoreElements())
{
  int id=((Integer)enumer2.nextElement()).intValue();
  Outlay obj=Outlay.find(id);
  out.print("<option value="+id);
  if(outlay==id)
  {
      out.print(" SELECTED ");
  }
  out.println(" >"+obj.getType());

}%>
</select>
</td>
</tr>
<tr>
<td>是否已拨足经费</td>
<td><input type="radio" name="adequate" <%if(adequate)out.print(" checked ");%> value="true"/>是
  <input type="radio" name="adequate" <%if(!adequate)out.print(" checked ");%> value="false"/>否</td>
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
<div id="head6"><img height="6" alt=""></div>
</body>
</html>


