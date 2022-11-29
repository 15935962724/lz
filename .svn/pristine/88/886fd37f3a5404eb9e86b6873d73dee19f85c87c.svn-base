<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.subscribe.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*" %> 
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

%>
<html>
<head>
<title>我的订单</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >


<script>
//点击订阅
function f_mypackage()
{
	

	var ck = document.getElementsByName("sid_radio"); 
	var sid_radio = 0;
	var flat = true;
	for(var i = 0; i < ck.length; i++) {
		if(ck[i].checked) {
			flat = false;
			sid_radio=ck[i].value;
			break;
		}
	}
	if(flat)
	{
		alert("请选择您要订阅的套餐");
		return false;
	}
	
	   if(confirm('您确认订阅此套餐吗?'))
	   {
		   
		   var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
		   var url = '/jsp/general/subscribe/PackageOrder1.jsp?node='+form1.node.value+'&sid='+sid_radio+"&community="+form1.community.value;
		   var rs = window.showModalDialog(url,self,y);

	 
		   if(rs==1 || typeof(rs)=='undefined')
		   {
			   window.location.reload();
		   }
			/**
		   if(rs>1)
		   {  
				 window.open('/jsp/pay/newspaperbeijing/Send.jsp?community='+form1.community.value+'&pkorder='+rs,'_blank');
				 window.location.reload();
		   }
		   */
		 
	   }
}
function f_zx(igd)
{
	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
	  var url = '/jsp/general/subscribe/PackageOrder3.jsp?act=zx&pkorder='+igd;
	  var rs = window.showModalDialog(url,self,y);
	  
	  //if(rs>1) 
	 // {
		//  window.open('/jsp/pay/newspaperbeijing/Send.jsp?community='+form1.community.value+'&pkorder='+igd,'_blank');
	//  }
	  
}
function f_xx(igd)
{
	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:457px;';
	  var url = '/jsp/general/subscribe/PackageOrder3.jsp?act=xx&pkorder='+igd;
	  var rs = window.showModalDialog(url,self,y);
}
</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT> 
<h1>我的订单</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<form action="?" name="form1" method="POST" >

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="act"/>
<%

Enumeration ep = PackageOrder.find(teasession._strCommunity," and node ="+teasession._nNode+" and member ="+DbAdapter.cite(teasession._rv._strR),0,Integer.MAX_VALUE);
if(ep.hasMoreElements())
  {
     // out.print("<tr><td colspan=10 align=center>暂无订单</td></tr>");

%>
<h2>您已经提交过的订单</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
       <td nowrap>超过30天未付费的订单，系统会自动删除；您可以通过下面的套餐列表订阅更多的套餐。</td>
    </tr>
    <tr>
       <td nowrap>若您已成功缴费，而订单状态依然显示为“未付费”，请发邮件（admin@redcome.com）与我们联系，切勿删除订单！</td>
    </tr>
    <tr>
    	<td>
    		  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    		  <tr id=tableonetr>
			       <td nowrap>序号</td>
			       <td nowrap>套餐名称</td>
			       <td nowrap>价格(￥/＄)</td>
			       <td nowrap>订单号</td>
			       <td nowrap>下单时间</td>
			       <td nowrap>订单状态</td>
			       <td nowrap>使用状态</td> 
			       <td nowrap>付费方式</td>
    		  </tr>
    		  
    		  <%
    		  
    		  for(int i =1;ep.hasMoreElements();i++)
    		  {
    			  String porder = ((String)ep.nextElement());
    			  PackageOrder pobj = PackageOrder.find(porder);
    		  %>
				    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
					    <td width="2"><%=i %></td>
					    <td><%=pobj.getSname() %></td>
					   	<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
					   	<td><%=porder %></td>
					   	<td><%=pobj.getOrderstimeToString() %></td>
					   	<td><%if(pobj.getType()==0){out.print("<font color=red>未付费</font>");}else if(pobj.getType()==1){out.print("已付费");}%></td>
					   		<td><%if(pobj.getSubtype()==0){out.print("未生效");}else if(pobj.getSubtype()==1){out.println("<font color=Green>"+pobj.SUBTYPE_TYPE[pobj.getSubtype()]+"</font>");}else if(pobj.getSubtype()==2){out.print("<font color=red>"+pobj.SUBTYPE_TYPE[pobj.getSubtype()]+"</font>");} %></td>
					   	<td>
					   	<%
					   		if(pobj.getType()==0)
					   		{
					   			out.print("	<input type=button value=\"在线付费\"  onclick=\"f_zx('"+porder+"');\">&nbsp;<input type=button value=\"线下支付\" onclick=\"f_xx('"+porder+"');\">");
					   		}else if(pobj.getType()==1)
					   		{
					   			out.print(pobj.getPayname());
					   		}
					   	%>
					   
					   	
					   	</td>
				    </tr>
		    <%} %>
		   
		    		  
    		  </table>
    	</td>
    </tr>
  </table>
  <%} %>
   <h2>选择订阅电子报套餐</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
       <td nowrap>&nbsp;</td>
       <td nowrap>套餐名称</td>
       <td nowrap>价格(￥/＄)</td>
       <td nowrap>套餐备注说明</td>
    </tr>
	    <%
	    //获取用户的角色
	    AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
	    boolean f = false;
	    Enumeration e = Subscribe.find(teasession._strCommunity,"  and publish = 1  and subid not in (select sid from PackageOrder where    node ="+teasession._nNode+"  and    member ="+DbAdapter.cite(teasession._rv._strR)+" )   ",0,Integer.MAX_VALUE);
	    
	    while(e.hasMoreElements())
	    {
	    	int sid = ((Integer)e.nextElement()).intValue();
	    	Subscribe sobj = Subscribe.find(sid);
	    	MemberType mtobj = MemberType.find(sobj.getMembertype());
	    	//如果在套餐里面绑定了会员类型 是不是当前登陆者的会员
	    	if(arobj.getRole()!=null && arobj.getRole().indexOf("/"+mtobj.getRole()+"/")!=-1)
	    	{
	    		f = true;
	    %>
    
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    	<td width="1"><input type="radio" id ="sid_radio" name="sid_radio" value="<%=sid %>"/></td>
    	<td><%=sobj.getSubject() %></td>
    	<td>￥<%=sobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=sobj.getPromotionsprice() %></td>
    	<td><%=sobj.getRemarks() %></td>
    </tr>
    
    <%
	    	} 
  	  }
	    if(!f)
	    {
	        out.print("<tr><td colspan=10 align=center>暂无套餐</td></tr>");
	    }
	    
	%>
    
    </table>
    <br/>
    <input type="button" value="　订阅套餐　" onclick="f_mypackage();">
</form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
