<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.women.*" %>
<% 
    response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
}
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
int paytype =0;//默认是未付款订单
if(teasession.getParameter("paytype")!=null && teasession.getParameter("paytype").length()>0)
{
	paytype = Integer.parseInt(teasession.getParameter("paytype"));	
}
String sname ="未付款订单";
if(paytype ==1)
{
	sname ="已付款订单"; 
}
 
  StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
  
  sql.append(" and paytype = ").append(paytype);
 param.append("&paytype=").append(paytype);

  param.append("&id= ").append(teasession.getParameter("id"));

  //订单号
  String strcid = teasession.getParameter("strcid");
  if(strcid!=null && strcid.length()>0)
  {
	  sql.append(" and cid like ").append(DbAdapter.cite("%"+strcid+"%"));
	  param.append("&strcid=").append(strcid);
  }
  //类型
  int cidtype = 0;
  if(teasession.getParameter("cidtype")!=null && teasession.getParameter("cidtype").length()>0){
	  cidtype = Integer.parseInt(teasession.getParameter("cidtype"));
  }
  if(cidtype>0){
	  sql.append(" and cidtype = ").append(cidtype);
	  param.append("&cidtype=").append(cidtype);
  }
	//姓名
  String name = teasession.getParameter("name");
  if(name!=null && name.length()>0)
  {
	  sql.append(" and name like ").append(DbAdapter.cite("%"+name+"%"));
	  param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
  }
  //收据编号
   String receiptno = teasession.getParameter("receiptno");
  if(receiptno!=null && receiptno.length()>0)
  {
	  sql.append(" and receiptno like ").append(DbAdapter.cite("%"+receiptno+"%"));
	  param.append("&receiptno=").append(URLEncoder.encode(receiptno,"UTF-8"));
  }
  
  
  //捐赠时间
 String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND paytimes >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND paytimes <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}
   
int donationmethods = -1;
if(teasession.getParameter("donationmethods")!=null && teasession.getParameter("donationmethods").length()>0)
{
	donationmethods = Integer.parseInt(teasession.getParameter("donationmethods"));	
}
if(donationmethods>=0){
	
	sql.append(" and donationmethods =").append(donationmethods);
	param.append("&donationmethods=").append(donationmethods);
}
String dmname = teasession.getParameter("dmname");
if(dmname!=null && dmname.length()>0){
	sql.append(" and dmname like ").append(DbAdapter.cite("%"+dmname+"%"));
	param.append("&dmname=").append(URLEncoder.encode(dmname,"UTF-8"));
}
//是否要发票
int isinvoice=-1;
if(teasession.getParameter("isinvoice")!=null && teasession.getParameter("isinvoice").length()>0){
	isinvoice =Integer.parseInt(teasession.getParameter("isinvoice"));
}
if(isinvoice>0){
	sql.append(" and isinvoice = ").append(isinvoice);
	param.append("&isinvoice=").append(isinvoice);
}

 int pos = 0, pageSize = 50, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }

  
   count = Contributions.count(teasession._strCommunity, sql.toString());
   
   
   String o=request.getParameter("o");
   if(o==null)
   {
   
   if(paytype==1){
     o="paytimes"; 
     }else
     {
     o="times";
     }
   }
   boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
   sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
   param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="text/javascript" language="javascript" src="/tea/ym/ymPrompt.js"></script> 
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title><%=sname %></title>
</head>
<script>
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("cidorder");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	}   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	} 
}
function f_excel()
	{
		if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='Contributions';
				form1.submit();
			}
	}
function f_excel2()
	{
		if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='Contributions2';
				form1.submit();
			}
	}
function f_delete(igd)
	{
		if(confirm("您确定要删除订单吗?"))
		{
			sendx("/jsp/admin/edn_ajax.jsp?act=Contributions_delete&cid="+igd,
			 function(data)
			 {
	
			   if(data!=''&&data.length>0)//如果有这个用户  则写入Cookie
			   {
					data = data.trim();
					
					alert(data);
					window.location.reload(); 
				  
			   }
			 }
			 );
		}
	}
function f_show(igd)
{
	ymPrompt.win('/jsp/type/women/ContributionsShwo.jsp?cid='+igd,700,400,'订单信息查看',function (igd){},null,null,{id:'a'});
}
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
function f_dm(){
	if(form2.donationmethods.value==4){
		document.getElementById('dmnameid').style.display='';
	}else{
		document.getElementById('dmnameid').style.display='none';
		form2.dmname.value='';
	}
}

 function   check(formObj)
	{

	      for(var   i=0;i<formObj.length;i++)
      	  {         
               if(formObj[i].checked)
               {
              	  return   true;
               }
	      }   
	     
	      return   false;
	}

</script>
<body id="bodynone">
  <h1><%=sname %></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>

<form action="?" name="form2" method="GET">
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>">
    <input type="hidden" name="paytype" value="<%=paytype %>"/> 
    
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
 		<td align="right" nowrap>捐赠号：</td>
 		<td><input type="text" name="strcid" value="<%if(strcid!=null)out.print(strcid); %>"/></td>
 		
 		<td align="right" nowrap>类型</td>
	      <td><select name="cidtype">
	      		<option value="0">-类型-</option>
	      		<%
	      			for(int i=1;i<Contributions.CID_TYPE.length;i++){
	      				out.print("<option value="+i);
	      				if(cidtype == i){
	      					out.print(" selected ");
	      				}
	      				out.print(">"+Contributions.CID_TYPE[i]);
	      				out.print("</ption>");
	      			}
	      		%>
	      </select></td>
	 		
 		
 		<td align="right" nowrap>支付宝姓名/名称：</td>
 		<td><input type="text" name="name" value="<%if(name!=null)out.print(name); %>"/></td>
 		
 	</tr>
     <tr >
        <td align="right" nowrap>收据编号：</td>
 		<td>
 			<input type="text" name="receiptno" value="<%=tea.entity.Entity.getNULL(receiptno) %>"/>
 		</td>
           <td align="right" nowrap>捐赠时间：</td>
           <td> 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form2.time_c');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form2.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.time_d');" />

           </td>
         <td align="right" nowrap>捐赠方式：</td>
 		<td><select name="donationmethods" onchange="f_dm();">
 		<option value="-1">-捐赠方式-</option>
				<%
					for(int i=0;i<Contributions.DONATION_METHODS.length;i++){
						out.print("<option value="+i);
						if(donationmethods==i){
							out.print(" selected ");
						}
						out.print(">"+Contributions.DONATION_METHODS[i]);
						out.print("</option>"); 
					}
				%>      		
      		</select>&nbsp;<span id="dmnameid" <%if(donationmethods!=4){out.print(" style=display:none");} %>>
      		<input type="text" name="dmname" value="<%if(dmname!=null)out.print(dmname); %>"/></span></td>  
           
           </tr>
         <tr>
         	 <td align="right">是否要发票：</td>
	      <td class="td02">
	      	<select name="isinvoice"> 
	      		<option value="-1" <%if(isinvoice==-1)out.print(" selected "); %>>-全部-</option>
	      		<option value="1" <%if(isinvoice==1)out.print(" selected "); %>>否</option>
	      		<option value="2" <%if(isinvoice==2)out.print(" selected "); %>>是</option>
	      	</select>
     	 </td>
           <td colspan="8" align="center"><input type="submit" value="查询"> </td>
   		 </tr>
 </table>
</form>

<h2><%=sname %>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条数据&nbsp;)&nbsp;
<%if(paytype==1){ %>
	<input type="button" value="添加捐赠单" onclick="window.open('/jsp/type/women/EditContributionsDetails.jsp?nexturl=<%=nexturl %>','_self');">&nbsp;
	&nbsp;
	<input type="button" value="导出修改信息EXCEL" onclick="f_excel2();">&nbsp;
	<input type="button" value="导入修改信息EXCEL" onclick="window.open('/jsp/type/women/Imports.jsp?nexturl=<%=nexturl %>','_self')">&nbsp;
<%} %>
</h2>
  <form action="?" name="form1" method="POST">
      <input type="hidden" name="nexturl" value="<%=nexturl%>">
       <input type="hidden" name="act">
<input type="hidden" name="files" value="<%=sname %>"/> 
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>
<input type="hidden" name="paytype" value="<%=paytype %>"/>
<input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="aq" VALUE="<%=aq%>">
 <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
 <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>捐赠号</td>
      <td nowrap>类型</td>
      <td nowrap><a href="javascript:f_order('name');">支付宝姓名/名称</a>
           <%
          if(o.equals("name"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
      <td nowrap>捐赠金额</td>
       
     <!-- 
        <td nowrap><a href="javascript:f_order('receiptno');">收据编号</a>
           <%
          if(o.equals("receiptno"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td> --> 
          
          
       <td nowrap>
       <%
       	if(paytype==0)
       	{
        %>
         <a href="javascript:f_order('times');">下单时间</a>
           <%
          if(o.equals("times"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
        
        
        <%}else{ %>
       <a href="javascript:f_order('paytimes');">捐赠时间</a>
           <%
          if(o.equals("paytimes"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          <%} %>
          </td>
          
        <%if(paytype==1){ %><td nowrap>收据状态</td><%} %>
       <td>操作</td>
    </tr>
    <%
   		 boolean f = true;
    //out.println(sql.toString());
        java.util.Enumeration e = Contributions.find(teasession._strCommunity, sql.toString(), pos, pageSize);
          if(!e.hasMoreElements())
           { 
               out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
               f=false;
           }
        while(e.hasMoreElements()){
            String cid = ((String)e.nextElement());
            Contributions cobj = Contributions.find(cid);
            

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td width=1><input type=checkbox name=cidorder value="<%=cid%>" style="cursor:pointer"></td>
     	<td><%=cid %></td>
     	<td nowrap><%=cobj.CID_TYPE[cobj.getCidtype()] %></td>
     	<td><%=cobj.getNULL(cobj.getName())%></td>
        <td><%=cobj.getPaymoney()%></td>
      
       
       
        <td><%
        
        if(paytype==0)
        {
        	out.print(cobj.sdf2.format(cobj.getTimes()));
        }
        if(cobj.getPaytimes()!=null)out.print(cobj.sdf2.format(cobj.getPaytimes()));
        
        
        %></td>
          <%if(paytype==1){ %>
          	<td> 
          		<%
          			if(cobj.getCidtype()>0){out.print("<font color=Green>已设置</font>");}else{out.print("<font color=red>未设置</font>");}
          		%>
          	</td> 
          <%} %>  
        <td nowrap>
        <%if(paytype==1){ %>
      	  <a href="/jsp/type/women/EditContributionsDetails.jsp?cid=<%=cid %>&nexturl=<%=nexturl %>">设置详细信息</a>
        <%} %>
        <a href="###" onclick="f_show('<%=cid %>');">详细信息</a>
         <a href="###" onclick="f_delete('<%=cid %>');">删除</a></td>
     </tr> 
     <%}%> 

    <%if (count > pageSize) {  %>
     <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
   <%}  %> 

  </table>
<br/>
<input type="button" value="导出EXCEL" onclick="f_excel();">&nbsp;
  
  
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>