<%@page import="tea.entity.integral.IntegralRecord"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="java.math.BigDecimal"%>

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



Resource r=new Resource("/tea/resource/Photography");
String memberorder = teasession.getParameter("memberorder");

MemberOrder  moobj = MemberOrder.find(memberorder);
int umid =  0;
if(teasession.getParameter("umid")!=null && teasession.getParameter("umid").length()>0)
{
	umid = Integer.parseInt(teasession.getParameter("umid")); 
}
UpgradeMember umobj = UpgradeMember.find(umid);
String submit1 =teasession.getParameter("submit1");
String delete =teasession.getParameter("delete");

if("POST".equals(request.getMethod())&&"提交".equals(submit1))
{
	
	 
	
	SimpleDateFormat sdfy = new SimpleDateFormat("yyyy");
	
	Profile pobj = Profile.find(moobj.getMember());
	//减去积分
	int period = 0;
	if(teasession.getParameter("period")!=null && teasession.getParameter("period").length()>0)
	{
		period = Integer.parseInt(teasession.getParameter("period"));
	}
	
	if(pobj.getIntegral()>=period){
	//修改会员的有效期天数
		Date becometime =null;
		if(teasession.getParameter("becometime")!=null && teasession.getParameter("becometime").length()>0)
		{
			becometime = tea.entity.Entity.sdf.parse(teasession.getParameter("becometime"));
		}
		 //修改发票信息和汇款金额
		 BigDecimal remittance = new BigDecimal("0.0");
		 if(teasession.getParameter("remittance")!=null&&teasession.getParameter("remittance").length()>0){
			 remittance = new BigDecimal(teasession.getParameter("remittance"));
		 }
		
		 String invoiceremarks = teasession.getParameter("invoiceremarks");
		 int invoicetype = Integer.parseInt(teasession.getParameter("invoicetype"));
		 int remtype = Integer.parseInt(teasession.getParameter("remtype"));
		 int proxymembertype = Integer.parseInt(teasession.getParameter("proxymembertype"));
		 String proxymember = teasession.getParameter("proxymember");
		 
	 //先添加记录表
	 if(umobj.isExists())
	 {
		 umobj.set(becometime,period,remittance,remtype,proxymembertype,proxymember,invoiceremarks,
					invoicetype,teasession._rv.toString(),Entity.sdf.parse(Entity.sdf.format(new Date())),Integer.parseInt(sdfy.format(new Date())));
	 }else
	 {
		 UpgradeMember.create(moobj.getMember(), becometime, period, remittance, remtype, proxymembertype, proxymember, invoiceremarks,
					 invoicetype, teasession._rv.toString(), teasession._strCommunity,Entity.sdf.parse(Entity.sdf.format(new Date())),Integer.parseInt(sdfy.format(new Date())));
	 }
	 
	 
	 Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember())+" ORDER BY becometime DESC ",0,1);
	   if(e.hasMoreElements())
	   {
		    int u = ((Integer)e.nextElement()).intValue();
		     umobj = UpgradeMember.find(u);
	   }
		
		
		 
		moobj.setVerifgtime(new Date());//审核日期
		moobj.setBecometime(umobj.getBecometime());
		
		
		 moobj.setPeriod(umobj.getPeriod());
		 
		 //如果是机房兑换，就减去 //新添加的记录
		
		 if(period>0 &&umid==0)
		 {  
		 	pobj.setIntegral(pobj.getIntegral()-(float)period);
			IntegralRecord.create(teasession._strCommunity, pobj.getMember(),-period, 10, 0, teasession._rv._strV,"会员兑换金牌会员减分");
		 }
		  
		 //转成数字报会员 
		 moobj.setMembertype(2); 
		  
		
		
		 
		 moobj.setInvoice(umobj.getRemittance(),umobj.getInvoiceremarks(),umobj.getInvoicetype()); 
		 moobj.setRemtype(umobj.getRemtype());
		 
		 
		 moobj.setProxymembertype(umobj.getProxymembertype());
		 moobj.setProxymember(umobj.getProxymember());
		 
		 MemberOrder mobj = 	 MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,umobj.getProxymember()));
		 if(umobj.getProxymember()!=null && umobj.getProxymember().length()>0)
		 {
			 mobj.setProxymembertype2(1);
		 }else
		 {
			 mobj.setProxymembertype2(0);
		 }
	
		 
		 
		 out.print("<script>"); 
		 out.print("alert('会员升级成功');window.returnValue=1;window.close();");
		 out.print("</script>"); 
	}else
	{
		out.print("<script>");
		 out.print("alert('您升级的会员积分不足,请确认!');window.returnValue=1;window.close();");
		 out.print("</script>"); 
	}
		return;
}else if("POST".equals(request.getMethod())&&"删除".equals(delete))
{
	SimpleDateFormat sdfy = new SimpleDateFormat("yyyy");
	
	Profile pobj = Profile.find(moobj.getMember());
	
	//减去积分
	int period = 0;
	if(teasession.getParameter("period")!=null && teasession.getParameter("period").length()>0)
	{
		period = Integer.parseInt(teasession.getParameter("period"));
	}

	//删除这条记录
	umobj.delete();
	 
	 
	   Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember())+" ORDER BY becometime DESC ",0,1);
	   if(e.hasMoreElements())
	   {
		    int u = ((Integer)e.nextElement()).intValue();
		     umobj = UpgradeMember.find(u);
	   }
		
		
		 
		moobj.setVerifgtime(new Date());//审核日期
		moobj.setBecometime(umobj.getBecometime());
		
		
		 moobj.setPeriod(umobj.getPeriod());
		  
		
		 pobj.setIntegral(pobj.getIntegral()+(float)period);
		 IntegralRecord.create(teasession._strCommunity, pobj.getMember(),period, 10, 0, teasession._rv._strV,"删除会员兑换金牌会员加分");
		
		 
		 //转成数字报会员
		 moobj.setMembertype(2); 
		 
		
		
		  
		 moobj.setInvoice(umobj.getRemittance(),umobj.getInvoiceremarks(),umobj.getInvoicetype()); 
		 moobj.setRemtype(umobj.getRemtype());
		 
		 
		 moobj.setProxymembertype(umobj.getProxymembertype());
		 moobj.setProxymember(umobj.getProxymember());
		 
		 if(umobj.getProxymember()!=null && umobj.getProxymember().length()>0)
		 {
			 MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,umobj.getProxymember())).setProxymembertype2(1);
		 }else
		 {
			 MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,umobj.getProxymember())).setProxymembertype2(0);
		 }
		 
		 
		
			//如果没有了记录
	  		if(UpgradeMember.count(teasession._strCommunity, "and member= "+DbAdapter.cite(moobj.getMember()))==0)
	  		{
	  			moobj.setBecometime(null);
	  			moobj.setInvoice(new BigDecimal("0"), null, 0);
	  		}
		 
		 
		 out.print("<script>"); 
		 out.print("alert('会员升级删除成功');window.returnValue=1;window.close();");
		 out.print("</script>"); 
	
		return;	
}

int invoicetype = 0;
if(memberorder!=null && memberorder.length()>0)
{
	invoicetype = moobj.getInvoicetype();
}


%>

<html>
<head>
<title>会员升级管理</title>

<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<script type="text/javascript">
window.name='tar';
function f_proxymembertype(igd)
{
	
		if(igd==0)
		{
			//document.getElementById("proxymemberid").style.display='none';
			document.getElementById("pid").style.display='none';
			document.getElementById("buttonid").style.display='none';

			form1.proxymember.value='';
		}else if(igd==1)
		{
			//document.getElementById("proxymemberid").style.display='';
		
			document.getElementById("pid").style.display='';
			document.getElementById("buttonid").style.display='';
			
		}
		
}
function f_pm()
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:450px;';
	 var url = '/jsp/mov/ClssnProxyMember.jsp?t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);

	 if(rs!='' && typeof(rs)!='undefined')
	 {
		form1.proxymember.value=rs; 
	 }
}
function f_sub()
{
		if(form1.becometime.value=='')
			{
				alert("请填写阅读有效期");
				form1.becometime.focus();
				return false;
			}
		
}
function f_edit(igd)
{
	form2.umid.value=igd;

	form2.submit();
	
}

</script>
<body >


<h1>会员升级管理</h1>
<h2>会员(<%=moobj.getMember() %>)&nbsp;汇款列表</h2>
<form action="?" name="form2" method="GET" target="tar" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl"> 
<input type="hidden" name="memberorder" value="<%=memberorder %>"/>
<input type="hidden" name="umid">
<input type="hidden" name="act">
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			 <td>阅读有效期</td>
  			 <td>兑换积分</td>
  			 <td>汇款金额</td>
  			 <td>汇款方式</td>
  			 <td>代理会员</td>
  			 <td>邮寄状态</td>
  			 <td>操作</td>
  	   </tr>
  	   <%
  	
  	   
  	   int count = UpgradeMember.count(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember()));
  	   		Enumeration e = UpgradeMember.find(teasession._strCommunity," and member= "+DbAdapter.cite(moobj.getMember())+" ORDER BY becometime ASC ",0,10);
		  	   if(!e.hasMoreElements())
		  	   {
		  	       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		  	   }
		  	   int j =1;
		  	while(e.hasMoreElements())
		  	{
		  		int u = ((Integer)e.nextElement()).intValue();
		  		UpgradeMember obj = UpgradeMember.find(u);
		  		
		  	
  	   %>
  	    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';  <%if(count==j){out.println("style=\"color:red\"");} %>  >
  	    	<td><%if(obj.getBecometime()!=null){out.print(Entity.sdf.format(obj.getBecometime()));} %></td>
  	    	<td><%=obj.getPeriod() %></td>
  	    	<td><%=obj.getRemittance() %></td>
  	    	<td><%=MemberOrder.REM_TYPE[obj.getRemtype()] %></td>
  	    	<td><%=MemberOrder.PROXYMEMBER_TYPE[obj.getProxymembertype()] %></td>
  	    	<td><%=MemberOrder.INVOICE_TYPE[obj.getInvoicetype()] %></td>
  	    	<td><input type="button" value="编辑" onclick="f_edit('<%=u%>');"></td>
  	    	
  	    
  	    <tr>
  	    <%
  	    		j++;
		  	} %>
		  	 <tr  >
  	    	<td colspan="7">注：红色字体是现在生效的阅读有效期.</td>
  
  	    
  	    <tr>
  	   
  	</table>
</form>






<form action="?" name="form1" method="POST" target="tar" onsubmit="return f_sub();">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl"> 
<input type="hidden" name="memberorder" value="<%=memberorder %>"/>
<input type="hidden" name="umid" value="<%=umid %>">
<input type="hidden" name="act" value="edit">
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			 <td align="right">升级会员用户名：</td>
  			 <td><%=moobj.getMember() %></td>
  			</tr>
  		<tr id=tableonetr> 
  			 <td align="right">阅读有效期：</td>
  			 <td><input id="time_c" name="becometime" size="7"  value="<%if(umobj.getBecometime()!=null){out.print(tea.entity.Entity.sdf.format(umobj.getBecometime()));} %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.becometime');"> 
	        <img style="margin-bottom:-8px;cursor:pointer;"  src="/tea/image/bbs_edit/table.gif"   onclick="new Calendar().show('form1.becometime');" /></td>
  		</tr>
  		<tr id=tableonetr> 
  			 <td align="right">兑换积分：</td>
  			 <td><input type="text" name="period" value="<%=umobj.getPeriod() %>" size=4/>(数字报会员直接输入“0”)</td>
  		</tr>
  		<tr id=tableonetr> 
  			 <td align="right">汇款金额：</td>
  			 <td><input type="text" name="remittance" value="<%if(umobj.getRemittance()!=null)out.print(umobj.getRemittance());else{out.print("0");} %>" size=4/></td>
  		</tr>
  		<tr id=tableonetr> 
  			 <td align="right">汇款方式：</td>
  			
				<td>
					<% 
						for(int i=0;i<MemberOrder.REM_TYPE.length;i++)
						{
							out.print("<input type=radio name=remtype value="+i);
							if(umobj.getRemtype()==i)
							{
								out.print(" checked ");
							}
							out.print(">"+MemberOrder.REM_TYPE[i]+"&nbsp;");
						}
					%>
			</td>
  		</tr>
  		
  		<tr id=tableonetr> 
  			 <td align="right">代理会员：</td>
  			
				<td>
					<% 
						for(int i=0;i<MemberOrder.PROXYMEMBER_TYPE.length;i++)
						{
							out.print("<input type=radio id=proxymembertype name=proxymembertype value="+i+"  onclick=f_proxymembertype('"+i+"');");
							if(umobj.getProxymembertype()==i)
							{
								out.print(" checked ");
							}
							out.print(">"+MemberOrder.PROXYMEMBER_TYPE[i]+"&nbsp;");
						}
					%>&nbsp;
					<span id="pid" <%if(umobj.getProxymembertype()==0){out.print(" style=display:none ");} %> >代理会员：<input type="text" name="proxymember" value="<%=umobj.getNULL(umobj.getProxymember()) %>" size="8" readonly></span>&nbsp;
				<input type=button id="buttonid"  value="选择" onclick="f_pm();"  <%if(umobj.getProxymembertype()==0){out.print(" style=\"display:none\" ");} %> >
					
			</td>
  		</tr> 
  		
  		<tr id=tableonetr>  
  			 <td align="right">发票备注：</td>
  			 <td>
  			 	<textarea rows="4" cols="40" name="invoiceremarks"><%=umobj.getNULL(umobj.getInvoiceremarks()) %></textarea>
  			 
  		</tr>
  		<tr id=tableonetr> 
  			 <td align="right">邮寄状态：</td>
  			 <td>
					<% 
						for(int i=0;i<MemberOrder.INVOICE_TYPE.length;i++)
						{
							out.print("<input type=radio name=invoicetype value="+i);
							if(invoicetype==i)
							{
								out.print(" checked ");
							}
							out.print(">"+MemberOrder.INVOICE_TYPE[i]+"&nbsp;");
						}
					%>
			</td>
  		</tr>
  </table>
  <br/>
  <input type="submit" value="提交" name="submit1"/>&nbsp;<%if(umid>0){ %><input type="submit" name="delete" value="删除"/><%} %>&nbsp;<input type="button" value="关闭" onclick=window.close();>
</form>
</body>
</html>
