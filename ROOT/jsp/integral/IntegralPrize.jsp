<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>



<jsp:directive.page import="tea.resource.Common"/>
<%@page import="tea.entity.MT"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
String memberid =request.getParameter("memberid");
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
String shopping = request.getParameter("shopping");
if(shopping!=null && shopping.length()>0)
{

	sql.append(" and shopping like '%"+shopping+"%'");
	param.append("&shopping="+java.net.URLEncoder.encode(shopping,"UTF-8"));
}
int shop_integral = 0;
if(request.getParameter("shop_integral")!=null && request.getParameter("shop_integral").length()>0)
{
	shop_integral = Integer.parseInt(request.getParameter("shop_integral"));
	sql.append(" and shop_integral ="+shop_integral);
	param.append("&shop_integral="+shop_integral);
}

int pos=0;
int size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=IntegralPrize.count(teasession._strCommunity,sql.toString());


sql.append(" ORDER BY times desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>

</head>
<body>
<script>
function f_delete(igd)
{
	if(confirm("您确定要删除这个商品吗？"))
	{
	
		 sendx("/jsp/admin/edn_ajax.jsp?act=IntegralPrizeDelete&ipid="+igd,
				 function(data)
				 {
	
				  
						alert("商品删除成功");
					   window.location.reload();
	
				 }
				 );
	}
}
function f_gm(igd) 
{
	//var n = '/jsp/message/MemberMailbox.jsp?folder='+form1.folder.value;
//	ymPrompt.win('/jsp/westrac/WestracEditMemberMailbox.jsp?t='+new Date().getTime()+'&nexturl='+n,750,530,'站内信',null,null,null,true);
	
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:270px;';
	 var url = '/jsp/integral/IntegralGoodsMobile.jsp?t='+new Date().getTime()+"&gid="+igd;
	 var rs = window.showModalDialog(url,self,y);

}

</script>
<h1>奖品列表</h1>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
     <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
  

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


     <tr>
     <td>商品名称：<input type="text" name="shopping" value="<%if(shopping!=null){out.print(shopping);}%>" /></td><td>商品积分：<input type="text" name="shop_integral" value="<%if(shop_integral!=0){out.print(shop_integral);}%>" /></td>
       <td><input type="submit" value="查询"/></td>
       </tr>
</table>
</form>
<form method="POST" action="" name="form2">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type=hidden name="csvservice" value="0"/>
<input type=hidden name="act" value="Csvmembers_2">
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个兑换商品&nbsp;)
&nbsp;<input type="button" onclick="location='/jsp/integral/IntegralPrizeAdd.jsp'" value="创建商品"/></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap >序号</td>
       <td nowrap>商品名称</td>
       <td nowrap>商品积分</td>
       <TD nowrap>创建时间</TD>

       <td nowrap>创建用户</td>
       <td nowrap>操作</td>
       </tr>
     <%
   
     java.util.Enumeration enumer = IntegralPrize.findByIntegral(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     {
       out.print("<tr><td colspan=6  align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int ids =  Integer.parseInt(enumer.nextElement().toString());
       IntegralPrize integralobj = IntegralPrize.find(ids);
       Profile probj = Profile.find(integralobj.getMember());
       %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap width="1" ><%=index%></td>
         <td><%=integralobj.getShopping()%></td>
         <td><%=integralobj.getShop_integral()%></td>
         <TD><%=MT.f(integralobj.getDatetime()) %></TD>
      
         <td><%=integralobj.getMember()%></td>
         <td>
         
          <input type="button" onclick="f_gm('<%=ids%>');"  value="手机兑换"/>
         <input type="button" onclick="window.open('/jsp/integral/IntegralPrizeAdd.jsp?id=<%=ids%>','_self')"  value="编辑"/>
        <input type="button" onclick="f_delete('<%=ids%>');"  value="删除"/></td>
       </tr>
       <%
       }
       %>
       <%
       	if(count>size){
       %>
       <tr><td colspan="7" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
	<%} %>
</table>

<p>
     <input type="hidden" name="sql" value="<%=sql %>">
     <input type="hidden" name="pos" value="<%=pos %>">
  </p>
</form>
<br>
<div id="head6"><img height="6" alt="" src=""></div>
</body>
</html>



