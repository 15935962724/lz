<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.women.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
}
    
String cid = teasession.getParameter("cid");
Contributions cobj = Contributions.find(cid);
%>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>


 
<h2>捐赠者基本信息</h2>
 
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">类型</td>
      <td><%=Contributions.CID_TYPE[cobj.getCidtype()] %></td>
    </tr>
    
    <tr>
      <td align="right">是否要发票</td>
      <td><%if(cobj.getIsinvoice()==1){out.print("否 ");}else{out.print("是");}%></td>
    </tr>
      <tbody  id ="xid" <%if(cobj.getIsinvoice()==1)out.print(" style=display:none"); %>>
    <tr>
      <td align="right">支付宝姓名/名称：</td>
      <td><%=cobj.getNULL(cobj.getName()) %></td>
    </tr>
    <tr>
      <td align="right">手机号：</td>
      <td><%=cobj.getNULL(cobj.getMobile()) %></td>
    </tr>
    <tr>
      <td align="right">发票抬头：</td>
      <td><%=cobj.getNULL(cobj.getInvoice()) %></td>
    </tr>
    <tr>
      <td align="right">收件人姓名：</td>
      <td class="td03"><%=cobj.getNULL(cobj.getRecipientname()) %></td>
    </tr>
    
    <tr>
      <td align="right">邮寄地址：</td>
      <td><%=cobj.getNULL(cobj.getAddress()) %></td>
    </tr>
    <tr>
      <td align="right">邮编：</td>
      <td><%=cobj.getNULL(cobj.getZip()) %></td>
    </tr> 
    </tbody>
</table>

<h2>捐赠者详细信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">汇款单登记日期：</td>
      <td><%if(cobj.getPaytimes()!=null)out.print(cobj.sdf2.format(cobj.getPaytimes())); %></td>
    </tr>
    
    <tr>
      <td align="right">财务登记日期：</td>
      <td><%if(cobj.getFinancetime()!=null){out.print(cobj.sdf2.format(cobj.getFinancetime()));} %></td>
    </tr>
    <tr>
      <td align="right">捐赠方式：</td>
      <td><%if(cobj.getDonationmethods()>-1){out.print(Contributions.DONATION_METHODS[cobj.getDonationmethods()]);} %>
      		      		
      		&nbsp;<%if(cobj.getDonationmethods()==4){out.print(cobj.getNULL(cobj.getDmname()));} %>
      		
      </td>
    </tr>
     <tr>
      <td align="right"><font color="red"><b>捐赠金额：</b></font></td>
      <td><%if(cobj.getPaymoney()!=null)out.print(cobj.getPaymoney()); %>&nbsp;
      	币种：<%=Contributions.CURRENCY_TYPE[cobj.getCurrency()] %>
     &nbsp;<%if(cobj.getCurrency()==1){out.print(cobj.getNULL(cobj.getCurrencyname()));} %></td>
    </tr>
    <tr>
      <td align="right">捐赠要求：</td>
      <td><%=cobj.getNULL(cobj.getDonation_requested()) %></td>
    </tr>
    <tr>
      <td align="right">指定地点：</td>
      <td><%=cobj.getNULL(cobj.getDesignated_place()) %></td>
    </tr>
    <tr>
      <td align="right">捐赠收据编号：</td>
      <td><%=cobj.getNULL(cobj.getReceiptno()) %></td>
    </tr>
    <tr>
      <td align="right">收据开具日期：</td>
      <td><%if(cobj.getReceipttime()!=null){out.print(cobj.sdf2.format(cobj.getReceipttime()));} %></td>
    </tr>
    <tr> 
      <td align="right">是否邮寄：</td>
      <td><%=Contributions.WHETHERTHEMAIL_TYPE[cobj.getWhetherthe_mail()] %>
      
      </td>
    </tr>
    <tr>
      <td align="right">是否退信：</td>
      <td><%=Contributions.WHETHERTHEMAIL_TYPE[cobj.getBounce()] %></td>
    </tr>

</table>
<h2>落实情况</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">落实时间：</td>
      <td><%if(cobj.getImplementationtimes()!=null)out.print(cobj.sdf.format(cobj.getImplementationtimes())); %></td>
    </tr>
   
    <tr>
      <td align="right">落实地点：</td>
      <td>
     	 省-县：<%=cobj.getNULL(cobj.getImp_ddress_city()) %>
     	 村：<%=cobj.getNULL(cobj.getImp_ddress_village()) %>
      	</td>
    </tr>
     <tr>
      <td align="right">回馈情况：</td>
      <td>
     	<%=cobj.getNULL(cobj.getFeedback()) %></td>
    </tr>
    <!-- 
    <tr>
      <td align="right">上传图片：</td>
      <td>
     	图片名称：<%=cobj.getNULL(cobj.getImgname()) %><br/><br/>
     	图片路径：<%if(cobj.getImgpath()!=null) {%><img src="<%=cobj.getImgpath() %>" width="300"/><%} %>
     
      	</td>
    </tr>
     -->
</table>
<h2>备 注</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td align="right">备注信息：</td>
      <td><%=cobj.getNULL(cobj.getRemarks()) %></td>
    </tr>
    </table>
<br/>
<br/>


