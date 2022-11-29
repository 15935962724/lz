<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SOrder");
String community=node.getCommunity();

String member=node.getCreator().toString();

tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);

java.math.BigDecimal balance =tea.entity.member.SClient.find(community,member).getPrice();
%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body {
	background-color: #CCCCCC;
}
-->
</style>
</head>
<body>
  <%
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
  <table width="700px" cellspacing="0" cellpadding="0">
    <tr height="24">
      <th width="680" height="24" colspan="12" align="center">三水吉屋  业务单</th>
    </tr>
    <tr height="19">
      <td  height="19">北京联合易洁物业管理有限公司</td>
      <td align="right"><a href="http://www.timade.com/">www.timade.com</a></td>
    </tr>
  </table>
  <table width="700px" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" style="border-collapse:collapse ;">
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
      <%=bespeak_time.get(java.util.Calendar.MINUTE)%>分
</td>
    </tr>
    <tr align="center">
      <th>预约项目编号名称</th>
      <th>作业数量</th>
      <th colspan="2">收费金额</th>
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
      <td colspan="2">¥<%=ser.getPrice().multiply(new java.math.BigDecimal(so_obj.getAmount()[index]))%> 元</td>
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


    <tr align="center">
      <th>附加项目编号名称</th>
      <th>作业数量</th>
      <th colspan="2">收费金额</th>
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
      <td colspan="2">¥<%=ser.getPrice().multiply(new java.math.BigDecimal(so_obj.getAamount()[index]))%> 元</td>
    </tr>
    <%}
    for(;aa<2;aa++)
    {
      out.print("<TR><TD>&nbsp;</td><TD>&nbsp;</td><TD colspan=2>¥ 　　　　　元</td></TR>");
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
      <td >
        <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox">很好
        <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox">好
        <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox">一般
        <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox">差
        <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" value="checkbox">很差
      </td>
	<td nowrap="nowrap">客户鉴字：
	<td>&nbsp;</td>
    </tr>
  </table>
  <table width="700px" border="0" cellpadding="3" cellspacing="0" bordercolor="#000000" style="border-collapse:collapse ;">

  <tr><td colspan="2">    <td colspan="2" align="right">      业务电话：010-62762002</td>
  </tr>
  </table>
  <input type="button" name="button" value="打印"  onclick="this.style.display='none';window.print();">


</body>
</html>

