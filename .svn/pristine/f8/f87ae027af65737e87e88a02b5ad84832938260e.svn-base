<%@page import="tea.entity.westrac.WestracIntegralLog"%>
<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.westrac.WestracClue"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}

  


StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));

sql.append(" and member = ").append(DbAdapter.cite(teasession._rv.toString()));


int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = WestracClue.count(teasession._strCommunity,sql.toString());



sql.append(" order by times desc ");


%>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
 
  <script src="/tea/Calendar.js" type="text/javascript"></script>
  <script src="/tea/city.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
  <link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
/*
function f_delete(igd)
{
	if(confirm('您确定要删除这条线索吗？删除以后，数据不能恢复！'))
	  {
			sendx("/jsp/admin/edn_ajax.jsp?act=WestracCluewDelete&wcid="+igd,
					 function(data)
					 {
					
					
					   if(data!=''&&data.length>1 )//如果有这个用户  则写入Cookie .trim()
					   { 
							data = data.trim();
							
							if(data=='true'){ 
								ymPrompt.close();
						       ymPrompt.win({message:'<br><center>线索删除成功</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});
						       
							}
						 
					   }
					 }
			);
			  }
}
*/



function noTitlebar(){
	window.location.reload();
}
 
function f_ymig(igd) 
{
	ymPrompt.win('/jsp/westrac/EditWestracClue.jsp?myact=my&t='+new Date().getTime()+'&wcid='+igd+'&nexturl='+form1.nexturl.value,600,560,'修改我的线索',null,null,null,true);
} 
function f_ymigshow(igd)
{
	ymPrompt.win('/jsp/westrac/WestracClueShow.jsp?myact=my&t='+new Date().getTime()+'&wcid='+igd+'&nexturl='+form1.nexturl.value,600,520,'我的线索详细查看',null,null,null,true);
}
</script>
<div class="title">我提供的线索</div>
<form name="form1" action="?" method="GET">


<!--<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;条销售线索&nbsp;)&nbsp;&nbsp;</h2>-->

<input type="hidden" name="nexturl" value="<%=nexturl %>">


<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 	
      <td nowrap>提交日期</td>
      <td nowrap>购买人名称</td>
      <td nowrap>移动电话</td>
      <td nowrap>购买人所在地 </td>
      <td nowrap>获得积分</td>
      <td nowrap>操作</td>
    
</tr>
<%
java.util.Enumeration eu = WestracClue.find(teasession._strCommunity,sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int wcid = ((Integer)eu.nextElement()).intValue();
 	WestracClue wcobj = WestracClue.find(wcid);
 	
 
	String cname = "";
	if(wcobj.getCity()!=null && wcobj.getCity().length()>0)
	{
		cname = Card.find(Integer.parseInt(wcobj.getCity())).toString();
	}
	float c = WestracIntegralLog.count_integral(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=4 and node ="+wcid);
	float c2 = WestracIntegralLog.count_cutintegral(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=12 and node ="+wcid);
	
	float c3 = WestracIntegralLog.count_integral(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=5 and node ="+wcid);
	float c4 = WestracIntegralLog.count_cutintegral(teasession._strCommunity," and member ="+DbAdapter.cite(wcobj.getMember())+" and  wlogtype=13 and node ="+wcid);

	float cc = (c+c2)+(c3+c4);
	
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
   <td nowrap><%=Entity.sdf.format(wcobj.getTimes()) %></td>
    <td nowrap><%=wcobj.getClientname() %></td>

    <td nowrap><%=wcobj.getClientmobile() %></td>
    
    <td nowrap><%=cname %></td>
  
   
    <td nowrap><%if(cc>0){out.print(cc);} %></td>
    <td>
    <%
    	if(wcobj.getWctype()==0)
    	{
    		out.print(" <a href=\"###\"   onclick=\" f_ymig('"+wcid+"');\">修改</a>&nbsp;");
   		}
    	out.print("<a href=\"###\"  onclick=\" f_ymigshow('"+wcid+"');\">查看详细</a>&nbsp;");
    
    	%>
   </td>

  </tr> 
  
  <%
  }
  %>
  
  <%
  	if(count>size){
  %>
  <tr>
  <td colspan="20"  align="right" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
</tr>
<%} %>
  </table>
  <div class="ContinueTo"><a href="/html/folder/95-1.htm"></a></div>
</form>

