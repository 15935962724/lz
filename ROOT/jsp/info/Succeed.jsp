<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");
Resource r=new Resource();
TeaSession teasession=new TeaSession(request);

r.add("tea/ui/util/SignUp1").add("/tea/ui/node/type/sms/EditUser");
String info=request.getParameter("info");
if(info==null)
{
	info=r.getString(teasession._nLanguage,"UpdateSuccessful");
}
//info=info.replaceAll("<","&lt;");

String nexturl=request.getParameter("nexturl");
nexturl = tea.entity.node.Report.getHtml2(nexturl);
String usrl=request.getRequestURL().substring(0,request.getRequestURL().length()-request.getRequestURI().length());
/*
if(nexturl!=null)
{
  info+=("<script>setTimeout(\"redirect('"+nexturl+"');\",7000);</script>");
}
*/

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);




info = tea.entity.node.Report.getHtml2(info);


String tip="提示",okstr="恭喜您注册成功!";
String ztrt ="如无操作， <span id=\"url_id\" style=\"font-size:20px; color:#FF0000;\"></span>&nbsp;秒后将自动返回首页";
String fstr ="返回首页";

if(teasession._nLanguage==0){
	 tip="Tip";
	 okstr="Thank you! You are now registered with "+request.getServerName();
	 ztrt ="Please wait... returning to homepage in &nbsp;<span id=\"url_id\" style=\"font-size:20px; color:#FF0000;\"></span>&nbsp; seconds.";
	 fstr ="Returning to homepage.";
}
 
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="text/javascript">

 function redirect(url)
 {
   window.location.replace(url);
 }


var time =10; //倒计时的秒数    
var URL ;    
function Load(url)
{    
	URL =url;    
	for(var i=time;i>=0;i--)    
	{    
	window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);    
	}    
}    
function doUpdate(num)    
{    
   document.getElementById("url_id").innerHTML = num;
 if(num == 0)
 {
    window.location=URL;
 }    
}     
  </script>
  
  <style>
#bodyvl h1{width:1002px;margin-left:0px;margin-bottom:25px;}
#bodyvl h2{width:1002px;margin-left:0px;}
#edit_Bodydiv #tablecenter{width:1002px;margin-bottom:15px;border-collapse:collapse;
}
</style>
  </head>
  <body id="bodyvl">

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

  <h1><%=r.getString(teasession._nLanguage, tip)%></h1>
  <div id="head6"><img height="6" alt=""></div>
    <DIV ID="edit_Bodydiv">
    <%if("1".equals(request.getParameter("type"))){//邮箱验证提示 %>
    
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td align="left"><%=okstr %>
       

		</td>
        </tr>
        <tr>
          <td align="left"><img src="/res/Home/1008/1008991.gif">&nbsp;<a href="http://<%=request.getServerName()+":"+request.getServerPort() %>"><%=fstr %></a>&nbsp;</td>
        </tr>
        <tr>
          <td align="left"><img src="/res/Home/1008/1008991.gif">&nbsp;<%=ztrt %>
        <script>Load('http://<%=request.getServerName()+":"+request.getServerPort()%>');</script> </td>
        </tr>
      </table> 
      
    <%}else if("2".equals(request.getParameter("type"))){ //该会员不存在或已经取消了验证 %>
 
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%=r.getString(teasession._nLanguage, "1169607402250")%></td></tr>
      </table>
     <%}else if("3".equals(request.getParameter("type"))){ //该会员已经通过验证了,无需在此验证. %>
 
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%=r.getString(teasession._nLanguage, "1169607851484")%></td></tr>
      </table>
      <%}else if("4".equals(request.getParameter("type"))){ //验证码错误.  %>
 
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%=r.getString(teasession._nLanguage, "1169607769453")%></td></tr>
      </table>

    	<%}else{ %>
    	
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr><td><%
        	if("redribbon".equals(info))
        	{
        		StringBuffer sp = new StringBuffer();
                sp.append("1.世界艾滋病日是每年的12月1日;<br>");  
                sp.append("2.预防艾滋病是全社会的责任; <br>");
            	sp.append("3.一个感染了艾滋病病毒的人从外表上是看不出来的；  <br>");
            	sp.append("4.蚊虫叮咬不会传播艾滋病；<br>");    
            	sp.append("5.与艾滋病病毒感染者或病人一起吃饭不会感染艾滋病；   <br>");
            	sp.append("6.输入带有艾滋病病毒的血液会得艾滋病；<br>");
            	sp.append("7.正确使用安全套可以减少艾滋病的传播；<br>");
            	sp.append("8.只与一个性伙伴发生性行为可以减少艾滋病的传播；<br>");
            	sp.append("9.与艾滋病病毒感染者公用注射器有可能得艾滋病；<br>");
            	sp.append("10.感染艾滋病病毒的妇女生下的小孩有可能得艾滋病；<br>");

            	sp.append("　恭喜注册成功，成为了我们的新朋友，现在就可以去“交流园地”参与我们的讨论啦！<br>");
        		out.print(sp.toString());
        	}else
        	{
        		out.println(info);
        	}
        %>&nbsp;
         <%if(info!=null&&info.indexOf("退订成功") !=-1){
				out.println("<a href='"+usrl+"'>返回主页</a>");
        } else {%>
        <a href="javascript:history.go(-1)">返回</a><%} %></td></tr>
      </table>
      <%} %>
    </DIV>


    <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  </body>
</html>
