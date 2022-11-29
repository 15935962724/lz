<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

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
String member = teasession.getParameter("member");

if(member!=null && member.length()>0&& "all".equals(member))
{
	member="发送所有的会员";
}

Node nobj = Node.find(teasession._nNode);

if("POST".equals(request.getMethod()))
{
	String name = teasession.getParameter("name");
	String mtext = teasession.getParameter("mtext");
	mtext = "时尚高尔夫会员联盟邀请您参与我们的活动：活动内容如下:"+mtext;
	
	  if(name!=null && name.length()>0)
	  {
		  if("发送所有的会员".equals(name))
		  {
			  StringBuffer sql=new StringBuffer(" and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));
			  java.util.Enumeration e = Profile.find(sql.toString(),0,Integer.MAX_VALUE);
			
		    	for(int i=1;e.hasMoreElements();i++)
		    	{
		    		String m =((String)e.nextElement());
		    	 
		    	    Profile pobj = Profile.find(m);
		    	  //发送短信
					   
					   SMSMessage.create(teasession._strCommunity,m,pobj.getMobile(),teasession._nLanguage,mtext); 
		    	}
		    	 
		  
			  
		  }else
		  {
				  for(int i=1;i<name.split("/").length;i++)
				  {
					  String m = name.split("/")[i];
					//发送短信
					   
					   SMSMessage.create(teasession._strCommunity,m,Profile.find(m).getMobile(),teasession._nLanguage,mtext); 
				  }
		  }
	  }
	
	  
	  
		out.print("<script>alert('手机短信发送完毕！');window.returnValue=1;window.close();</script>");
		return;   
	
}

 
%>

<html>
<head>
<base target="dialog"/>
<title>履友管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
window.name="dialog";
function f_open2()
{

	var n = form1.name.value;
	var u = '';
	if(n!=''){
		u = '&name='+encodeURIComponent(n);
	}
	
   var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:650px;dialogHeight:580px;';
	  var url = '/jsp/type/event/WestracInviteMember.jsp?community='+form1.community.value+u;
	  var rs = window.showModalDialog(url,self,y);
	
	  
	if(rs!=''&& typeof rs!='undefined'&&rs!='/'){
		n = rs;
	 	form1.name.value=n;
	 	
	 }else if(rs!='')
		 { 
		 	form1.name.value='';
		 }
	

	
	 
} 
function f_sub()
{
	if(form1.name.value=='')
		{
			alert("请选择受邀会员");
			form1.name.focus();
			return false;
		}
	if(form1.mtext.value=='')
	{
		alert("请填写短信内容");
		form1.mtext.focus();
		return false;
	}
	document.getElementById('buttonid').value='短信正在发送,请稍候...';
	document.getElementById('buttonid').disabled=true;
	document.getElementById('closeid').disabled=true;
	ymPrompt.win({message:'<br><center>短信正在发送,请稍候...</center>',title:'',width:'300',height:'50',titleBar:false});
	form1.submit();
}


</script>

<h1>履友邀请</h1>

 
<form name="form1" action ="?" method="post" target="dialog">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

 
   <span id="rorderid" ></span>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
		  <td nowrap>活动名称：</td>
		  <td><%=nobj.getSubject(teasession._nLanguage) %></td> 
	    </tr>
	    
    <tr id=tableonetr>
		  <td nowrap>受邀会员：</td>
		  <td><textarea rows="2" cols="40" name="name" readonly="readonly"><%=member %></textarea>&nbsp;
		  
		  <%
	
		  if(member!=null && member.length()>0&& "all".equals(teasession.getParameter("member"))) 
		  {}else{
		  %>
		  <input type="button" value="查找并添加会员" onclick="f_open2();">
		  <%} %>
		  </td>
	    </tr>
     <tr id=tableonetr>
	  <td nowrap>短信内容：</td>
	  <td><textarea rows="3" cols="40" name="mtext">履友联盟邀请您参与我们的活动：活动内容如下</textarea></td>
    </tr>
    
  </table>
  <br>
  <input type="button" id="buttonid" value="发送短信" onclick=f_sub();>&nbsp;
  <input type="button" id="closeid" value="取消"  onClick="javascript:window.close();">
</form>
</body>
</html>

