<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SOrder");
String community=node.getCommunity();

String member=node.getCreator().toString();

tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);

java.math.BigDecimal balance =tea.entity.member.SClient.find(community,member).getPrice();



tea.entity.node.SOrder so_obj=  tea.entity.node.SOrder.find(teasession._nNode,teasession._nLanguage);

String Preview="";

String    educateParam="";
boolean edit=true;

String subject=null,phone=null;
{
  Preview="<A href=/jsp/type/resume/Preview.jsp?node="+teasession._nNode+" style=color=#ffffff target=_blank >预览简历</A>";
  educateParam="Node="+teasession._nNode;
  subject=node.getSubject(teasession._nLanguage);
  phone=so_obj.getPhone();
}
%>
<html>
<head>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FinishedSOrder")%></h1>
<div id="head6"><img height="6" alt=""></div>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
    <tr>
      <td width="22%">客户姓名</td>
      <td width="48%"><%=subject%></td>
      <td width="9%">电话</td>
      <td width="21%"><%=phone%></td>
    </tr>
    <tr>
      <td>服务地址</td>
      <td colspan="3">
        <%=        tea.entity.admin.Area.find(so_obj.getArea()).getAncestor()%> <%=so_obj.getAddress()      %>
      </td>
    </tr>
    <tr>
      <td>预约时间</td>
      <td colspan="3">
      <%
      java.util.Calendar bespeak_time=java.util.Calendar.getInstance();
      bespeak_time.setTime(so_obj.getTime());
      %>
      <%=bespeak_time.get(java.util.Calendar.YEAR)%>年
      <%=bespeak_time.get(java.util.Calendar.MONTH)+1%>月
      <%=bespeak_time.get(java.util.Calendar.DAY_OF_MONTH)%>日
      <%=bespeak_time.get(java.util.Calendar.HOUR_OF_DAY)%>时
      <%=bespeak_time.get(java.util.Calendar.MILLISECOND)%>分
</td>
    </tr>
    <tr align="center" id=tableonetr>
      <td>预约项目编号名称</td>
      <td>作业数量</td>
      <td colspan="2">收费金额</td>
    </tr>
    <%
    int aa=0;
    for(int index=0;index<so_obj.getService().length;index++)
    if(so_obj.getService()[index]!=0)
    {
      aa++;
      tea.entity.node.Service ser=tea.entity.node.Service.find( so_obj.getService()[index],teasession._nLanguage);
      %>
    <tr>
      <td> <%=tea.entity.node.Node.find(so_obj.getService()[index]).getSubject(teasession._nLanguage)%> </td>
      <td><%=so_obj.getAmount()[index]%><%=ser.getUnit()%></td>
      <td colspan="2">￥<%=ser.getPrice().multiply(new java.math.BigDecimal(so_obj.getAmount()[index]))%> 元</td>
    </tr>
    <%}
    for(;aa<4;aa++)
    {
      out.print("<TR><TD>&nbsp;</td><TD>&nbsp;</td><TD colspan=2>&nbsp;</td></TR>");
    }
    %>


    <tr>
      <td colspan="4">
      <table width="100%" >
      <tr><td>现金收费合计(¥)</td><td><%if(so_obj.getPtype()==1)out.print("0");else out.print(so_obj.getTotal());%>元</td>
        <td>易洁卡收费合计(¥)</td><td><%if(so_obj.getPtype()==2)out.print("0");else out.print(so_obj.getTotal());%>元</td>
        <td>易洁卡余额(¥)</td><td><%if(so_obj.getAptype()==1)balance=balance.add(so_obj.getAtotal());out.print(balance);%>元</td>
      </table>
</td>
    </tr>


    <tr align="center" id=tableonetr>
      <td>附加项目编号名称</td>
      <td>作业数量</td>
      <td colspan="2">收费金额</td>
    </tr>
    <%
     aa=0;
    for(int index=0;index<so_obj.getAservice().length;index++)
    if(so_obj.getAservice()[index]!=0)
    {
      aa++;
      tea.entity.node.Service ser=tea.entity.node.Service.find( so_obj.getAservice()[index],teasession._nLanguage);
      %>
    <tr>
      <td> <%=tea.entity.node.Node.find(so_obj.getAservice()[index]).getSubject(teasession._nLanguage)%> </td>
      <td><%=so_obj.getAamount()[index]%><%=ser.getUnit()%></td>
      <td colspan="2">￥<%=ser.getPrice().multiply(new java.math.BigDecimal(so_obj.getAamount()[index]))%> 元</td>
    </tr>
    <%}
    for(;aa<2;aa++)
    {
      out.print("<TR><TD>&nbsp;</td><TD>&nbsp;</td><TD colspan=2>￥ 　　　　　元</td></TR>");
    }
    %>
    <tr>
      <td colspan="4">
      <table width="100%" >
      <tr>
        <td>现金收费合计(¥)</td><td><%if(so_obj.getAptype()==2&&so_obj.getAtotal().floatValue()>0)out.print(so_obj.getAtotal());%>元</td>
        <td>易洁卡收费合计(¥)</td><td><%if(so_obj.getAptype()==1&&so_obj.getAtotal().floatValue()>0)out.print(so_obj.getAtotal());%>元</td>
        <td>易洁卡余额(¥)</td><td><%if(so_obj.getAtotal().floatValue()>0)out.print(balance);%>元</td>
      </table>
</td>
    </tr>

    <tr >
      <td > 作业员编号:</td>
            <td>
            <%
            java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(getNull(so_obj.getWaiter()),"/");
            while(tokenizer.hasMoreTokens())
            try
            {
              out.println(getNull(tea.entity.node.Waiter.find(Integer.parseInt(tokenizer.nextToken()),teasession._nLanguage).getCode()));
            }catch(java.lang.Exception e)
            {}
            %>
                          </td>

      <td nowrap="nowrap">业务员编号:</td>
            <td>
<%=getNull(tea.entity.node.Waiter.find(so_obj.getWaiterFigure(),teasession._nLanguage).getCode())%>
</td>
    </tr>
	  <tr>
      <td>客户意见：</td>
      <td > <input  id="CHECKBOX" <%if(so_obj.getIdea()==0)out.print(" checked ");%>  type="CHECKBOX" name="checkbox" value="checkbox">
        很好
        <input  id="CHECKBOX" <%if(so_obj.getIdea()==1)out.print(" checked ");%>  type="CHECKBOX" name="checkbox" value="checkbox">
        好
        <input  id="CHECKBOX" <%if(so_obj.getIdea()==2)out.print(" checked ");%>  type="CHECKBOX" name="checkbox" value="checkbox">
        一般
        <input  id="CHECKBOX" <%if(so_obj.getIdea()==3)out.print(" checked ");%>  type="CHECKBOX" name="checkbox" value="checkbox">
        差
        <input  id="CHECKBOX" <%if(so_obj.getIdea()==4)out.print(" checked ");%>  type="CHECKBOX" name="checkbox" value="checkbox">
        很差</td>
		<td nowrap="nowrap">客户鉴字：
		<td><%=so_obj.getClientSign()%></td>
    </tr>
<tr>
       <td>日期</td>
    <td><%=so_obj.getSignTime()%></td>
        <td>发票</td>
    <td ><%=tea.entity.node.SOrder.INVOICE_TYPE[so_obj.getInvoice()]%></td>
</tr>
    <tr>
    <td>业务员签字</td>
    <td colspan="3"><%=so_obj.getWaiterSign()%></td>
  </tr>

  </table>

<div id="head6"><img height="6" alt=""></div>

</body>

</html>












<%--






<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SOrder");
String community=node.getCommunity();
//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.entity.member.Profile profile=tea.entity.member.Profile.find(node.getCreator()._strR);
tea.entity.node.SOrder sorder=tea.entity.node.SOrder.find(teasession._nNode,teasession._nLanguage);
tea.entity.admin.Area.find(sorder.getArea()).getFather();

tea.entity.member.SClient sc=tea.entity.member.SClient.find(community,teasession._rv._strV);

%>
<head>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK href="add_fund.files/mystyle.css" type=text/css rel=stylesheet>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "FinishedSOrder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td>客户姓名</td>
    <td><%=profile.getFirstName(teasession._nLanguage)%></td>
    <td>电话</td>
    <td><%=profile.getTelephone(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>服务地址</td>
    <td colspan="3"><%=tea.entity.admin.Area.find(sorder.getArea()).getAncestor()%></td>
  </tr>
    <tr>
    <td>详细地址</td>
    <td colspan="3"><%=sorder.getAddress()%></td>
  </tr>
  <tr>
    <td>预约时间</td>
    <td colspan="3"> <%=sorder.getTime()%> </td>
  </tr>
  <tr align="center" id=tableonetr>
    <td>预约项目编号名称</td>
    <td>作业数量</td>
    <td>&nbsp;</td>
    <td>收费金额</td>
  </tr>
  <%java.math.BigDecimal total=new    java.math.BigDecimal(0);
  for(int index=0;index<sorder.getService().length;index++)
  {

    if(sorder.getService()[index]!=0&&sorder.getAmount()[index]!=0)
    {
      tea.entity.node.Service service=  tea.entity.node.Service.find(sorder.getService()[index],teasession._nLanguage);

      java.math.BigDecimal total_sub=service.getPrice().multiply(new java.math.BigDecimal(sorder.getAmount()[index]));
      total=total.add(total_sub);
      %>
  <tr>
    <td><a href="/servlet/Node?node=<%=sorder.getService()[index]%>"><%=tea.entity.node.Node.find(sorder.getService()[index]).getSubject(teasession._nLanguage)%></a></td>
    <td><%=sorder.getAmount()[index]%><%=service.getUnit()%></td>
    <td>￥</td>
    <td><%=total_sub%>元</td>
  </tr>
  <%}}
%>
  <tr>
    <td>收费金额合计</td>
    <td>￥<%=total%>元</td>
    <td>账户余额￥</td>
    <td><%=sc.getPrice()%>元</td>
  </tr>
  <tr align="center" id=tableonetr>
    <td>附加项目编号名称</td>
    <td>作业数量</td>
    <td>&nbsp;</td>
    <td>收费金额</td>
  </tr>
  <%total=new    java.math.BigDecimal(0);
  for(int index=0;index<sorder.getAservice().length;index++)
  {

    if(sorder.getAservice()[index]!=0&&sorder.getAamount()[index]!=0)
    {
      tea.entity.node.Service service=  tea.entity.node.Service.find(sorder.getAservice()[index],teasession._nLanguage);

      java.math.BigDecimal total_sub=service.getPrice().multiply(new java.math.BigDecimal(sorder.getAamount()[index]));
      total=total.add(total_sub);
      %>
  <tr>
    <td><a href="/servlet/Node?node=<%=sorder.getAservice()[index]%>"><%=tea.entity.node.Node.find(sorder.getAservice()[index]).getSubject(teasession._nLanguage)%></a></td>
    <td><%=sorder.getAamount()[index]%><%=service.getUnit()%></td>
    <td>￥</td>
    <td><%=total_sub%>元</td>
  </tr>
  <%}
}%>
  <tr>
    <td>附加项收费金额</td>
    <td>￥<%=total.toString()%>元</td>
    <td>账户余额￥</td>
    <td><%=sc.getPrice()%>元</td>
  </tr>
  <tr>
    <td>期望作业员:</td>
    <td colspan="3">
      <%=getNull(tea.entity.node.Waiter.find(sorder.getExwaiter(),teasession._nLanguage).getCode())%>
</td>
  </tr>
  <tr>
    <td ROWSPAN="2">客户意见</td>
    <td colspan="3"> <%
      switch(sorder.getIdea())
      {
        case 0:
        out.print("很好");
        break;
        case 1:
        out.print("好");
        break;
        case 2:
        out.print("一般");
        break;
        case 3:
        out.print("差");
        break;
        case 4:
        out.print("很差");
      }
    %></td>
  </tr>
  <tr>
    <td colspan="3"><%=sorder.getFeedback()%></td>
  </tr>
  <tr>
    <td>客户鉴字</td>
    <td ><%=sorder.getClientSign()%></td>
    <td>日期</td>
    <td><%=sorder.getSignTime()%></td>
  </tr>
  <tr>
    <td>扣除余额</td>
    <td ><%=sorder.getSubtract()%></td>
    <td >支付</td>
    <td ><%=sorder.getCash()%></td>
    <td >&nbsp;</td>
  </tr>
  <tr>
    <td>发票</td>
    <td colspan="3"><%=tea.entity.node.SOrder.INVOICE_TYPE[sorder.getInvoice()]%></td>
  </tr>
  <tr> <td > 操作员编号:</td>
            <td>
              <%=getNull(tea.entity.node.Waiter.find(sorder.getWaiterFigure(),teasession._nLanguage).getCode())%>
            </td>
    <td>业务员编号</td>
    <td colspan="3"> <%
            java.util.StringTokenizer tokenizer=new java.util.StringTokenizer (getNull(sorder.getWaiter()),"/");
            while(tokenizer.hasMoreTokens())
            try
            {
              out.println(getNull(tea.entity.node.Waiter.find(Integer.parseInt(tokenizer.nextToken()),teasession._nLanguage).getCode()));
            }catch(java.lang.Exception e)
            {}
            %></td>
  </tr>
  <tr>
    <td>业务员签字</td>
    <td colspan="3"><%=sorder.getWaiterSign()%></td>
  </tr>
</table>
<br>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
--%>

