<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import=" tea.htmlx.*"%>

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


%>

<html>
<head>
<title>会员统计</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >



<h1>会员统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >


<h2>
<a href="#" onclick="document.getElementById('tablecenter').style.display='';document.getElementById('tablecenter2').style.display='none';">会员注册总统计</a>&nbsp;
<a href="#" onclick="document.getElementById('tablecenter').style.display='none';document.getElementById('tablecenter2').style.display='';">会员注册性别统计</a>
</h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td nowrap>国家</td>
  			  <td nowrap>比例图示</td>
  			  <td nowrap>统计数量</td>
	    </tr>
	    <%
	    boolean f = false;
	    	for(int i = 1;i<CountrySelection.COUNTRY_TYPE.length;i++){
	    		String country = CountrySelection.COUNTRY_TYPE[i];
	    		String sqls =" and p.member in (select member from ProfileLayer where  country = "+DbAdapter.cite(country) +")";
	    		int count = tea.entity.admin.mov.MemberOrder.countMP(teasession._strCommunity, " and m.verifg =1 "+sqls);
	    if(count>0){
	    	int countb = tea.entity.admin.mov.MemberOrder.countMP(teasession._strCommunity, " and m.verifg =1 and p.sex =0 "+sqls);
	    	int countg = tea.entity.admin.mov.MemberOrder.countMP(teasession._strCommunity, " and m.verifg =1 and p.sex =1 "+sqls);
	    	f =true;
	    	
	    %>
		   <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
		      <td align="right"><%=r.getString(teasession._nLanguage,"Country."+country) %></td>
		      <td > 
		      	男：<div title="<%=r.getString(teasession._nLanguage,"Country."+country) %>注册男性会员：<%=countb %>" style="width:100%;height:5px;border:1px solid #1874CD;">
			   	    <div style="width:<%=Photography.getMembericon(teasession._strCommunity,sqls,countb) %>;background:#1874CD;height:5px"></div>
			   </div>
		      	女：<div title="<%=r.getString(teasession._nLanguage,"Country."+country) %>注册女性会员：<%=countg %>" style="width:100%;height:5px;border:1px solid #DC143C;">
			   	    <div style="width:<%=Photography.getMembericon(teasession._strCommunity,sqls,countg) %>;background:#DC143C;height:5px"></div>
			   </div>
				 总：
				 <div title="<%=r.getString(teasession._nLanguage,"Country."+country) %>总注册会员：<%=count %>" style="width:100%;height:5px;border:1px solid #333;">
			   	    <div style="width:<%=Photography.getMembericon(teasession._strCommunity,"",count) %>;background:#333;height:5px"></div>
			   </div>
	   </td>
		      <td><%=count %></td>
	      </tr>
      <%}} %>
        
    <%
    if(!f)
    {
        out.print("<tr><td colspan=10 align=center>暂无统计记录</td></tr>");
    }
    %>

  </table>
  
  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter2" style="display:none">

	   <tr align="center">
	
	    <td nowrap>
	    <%
	    int bcount =  tea.entity.admin.mov.MemberOrder.countMP(teasession._strCommunity, " and m.verifg =1 and p.sex =0 ");
	    int gcount =  tea.entity.admin.mov.MemberOrder.countMP(teasession._strCommunity, " and m.verifg =1 and p.sex =1 ");
	    if(bcount>0 || gcount >0){
	    %>
	    <img src="http://chart.apis.google.com/chart?cht=p&chd=t:<%=bcount %>,<%=gcount %>&chs=350x200&chl=<%=URLEncoder.encode("男","UTF-8") %>|<%=URLEncoder.encode("女","UTF-8") %>&chdl=<%=bcount %>|<%=gcount %>"/>
	   <%}else {out.print("暂无统计图示");} %>
	</td>
	    </tr>
	    
  </table>
  
</form>
</body>
</html>
