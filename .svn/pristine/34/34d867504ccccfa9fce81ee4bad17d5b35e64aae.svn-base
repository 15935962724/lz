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
<title>我的套餐</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
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
		 
	   }
}
</script>

<h1>我的套餐</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>已订阅电子报套餐</h2>

<form action="?" name="form1" method="POST" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
       <td nowrap>序号</td>
       <td nowrap>套餐名称</td>
       <td nowrap>价格(￥/＄)</td>
       <td nowrap>套餐开始时间</td>
       <td nowrap>套餐结束时间</td>
       <td nowrap>套餐状态</td>
    </tr>
    
    <%
    	java.util.Enumeration eo = PackageOrder.find(teasession._strCommunity," and node = "+teasession._nNode+" and member ="+DbAdapter.cite(teasession._rv._strR)+" and effect =1 and subtype <> 0 ",0,Integer.MAX_VALUE);
	    if(!eo.hasMoreElements())
	    {
	        out.print("<tr><td colspan=10 align=center>暂无已订阅电子报套餐</td></tr>");
	    }
       for(int i=1;eo.hasMoreElements();i++)
    	{
    		String poid = ((String)eo.nextElement());
    		PackageOrder pobj = PackageOrder.find(poid);
    %>
    
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
	    <td width="2"><%=i %></td>
	    <td><%=pobj.getSname() %></td>
	   	<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
	   	<td><%=pobj.getSubstarttimeToString() %></td>
	   	<td><%=pobj.getSubendtimeToString() %></td>
	   	<td><%if(pobj.getSubtype()==1){out.println("<font color=Green>"+pobj.SUBTYPE_TYPE[pobj.getSubtype()]+"</font>");}else if(pobj.getSubtype()==2){out.print("<font color=red>"+pobj.SUBTYPE_TYPE[pobj.getSubtype()]+"</font>");} %></td>
    </tr>
    <%} %> 
     
  </table>
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
	    Enumeration e = Subscribe.find(teasession._strCommunity," and publish = 1  and subid not in (select sid from PackageOrder where   node = "+teasession._nNode+"   and  member ="+DbAdapter.cite(teasession._rv._strR)+" )   ",0,Integer.MAX_VALUE);
	   
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
