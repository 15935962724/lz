<%@page import="tea.entity.MT"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*"%><%@ page import="tea.entity.member.*"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%@page import="tea.entity.admin.mov.*"%>
<%
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
r.add("/tea/resource/Classes");


StringBuffer sp = new StringBuffer("/");



if("POST".equals(request.getMethod()))
{
	String memberemail = teasession.getParameter("memberemail");
	
	String mtext= teasession.getParameter("mtext");


  //  int  message=Message.create(teasession._strCommunity, teasession._rv._strR,memberemail, teasession._nLanguage, subject, contents);
   // Message obj2 = Message.find(message);
  //  obj2.setFolder(1);
  
  if(memberemail!=null && memberemail.length()>0)
  {
	  for(int i=1;i<memberemail.split("/").length;i++)
	  {
		  String m = memberemail.split("/")[i];
		//发送短信
		   
		   SMSMessage.create(teasession._strCommunity,m,Profile.find(m).getMobile(),teasession._nLanguage,mtext); 
	  }
  }
   
  
  
  
 
	out.print("<script>alert('手机短信发送完毕！');window.returnValue=1;window.close();</script>");
	return;   
	  
}else 
{
	if(teasession.getParameter("member")!=null &&teasession.getParameter("member").length()>0&&!"/".equals(teasession.getParameter("member")))
	{
		String member = teasession.getParameter("member");
		sp.append(member);
	}else
	{
		String sql = teasession.getParameter("sql");
		sql = MT.dec(sql);
		 java.util.Enumeration e = Profile.find(sql,0,Integer.MAX_VALUE);
		 for(int i=1;e.hasMoreElements();i++)
	 	{
	 		String memberorder =((String)e.nextElement());
	 	   
	 	    sp.append(memberorder).append("/");
	 	    
	 	}
		 
	}
}

%>
<html>
<head>
<title>发生会员手机短信</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
window.name='dialog';
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
function f_sub()
{
	
		if(form1.mtext.value=='')
	{
		alert("请填写发送短消息内容");
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
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<h1>发送会员短消息</h1>
<form name="form1" method="POST" action="?" target="dialog" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" nowrap>用户名：</td>
    <td><textarea rows="2" cols="60" name="memberemail" readonly="readonly" ><%if(!"/".equals(sp.toString())){out.print(sp.toString());} %> </textarea></td>
  </tr>
   
  <tr id=tableonetr>
	  <td nowrap>短信内容：</td>
	  <td><textarea rows="3" cols="60" name="mtext"></textarea></td>
    </tr>
      
</table>

<br>
<input type="button" id="buttonid" value="发送短消息" onclick=f_sub();>&nbsp;<input type="button" id="closeid" value="关闭" onclick=window.close();>

</form>
</body>
</html>
