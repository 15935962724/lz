<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.integral.IntegralPrize"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

int gid = 0;
if(teasession.getParameter("gid")!=null && teasession.getParameter("gid").length()>0)
{
	gid = Integer.parseInt(teasession.getParameter("gid"));	
}

IntegralPrize ipobj = IntegralPrize.find(gid);

StringBuffer name=new StringBuffer();


if("POST".equals(request.getMethod()))
{
  String mtext = teasession.getParameter("mtext");
  
  String namec = teasession.getParameter("name");
  
  

  for(int i=1;i<namec.split("/").length;i++)
  {
	  String m = namec.split("/")[i];
	  if(m!=null && m.length()>0)
	  {
		  Profile pobj = Profile.find(m);
		  
		  mtext  = "您的积分是"+pobj.getMyintegral()+"，您现在可以兑换我们的"+ipobj.getShopping()+"礼品，详情请登录lvyou.westrac.com.cn，或咨询履友热线:400 650 1100.";
		  SMSMessage.create(teasession._strCommunity,m,pobj.getMobile(),teasession._nLanguage,mtext);
	  }
  }
  
 
  out.print("<script>alert('短信发送成功');parent.window.close();</script>");
  return;
}	 


Resource r=new Resource();
r.add("/tea/ui/member/message/NewMessage").add("/tea/ui/member/messagefolder/ManageMessageFolders");


%><HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
  <script>
  function f_open()
  {
   // window.open('/jsp/message/MemberList2.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name','','width=550px,height=480px,top=300px,left=400px');
  	var n = form1.name.value;
  	var u = '';
  	if(n!=''){
  		u = '&name='+encodeURIComponent(n);
  	}
  	
     var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:650px;dialogHeight:580px;';
	  var url = '/jsp/integral/MemberGoodsMobile.jsp?gid='+form1.gid.value+'&community='+form1.community.value+u;
	  var rs = window.showModalDialog(url,self,y);
	  
	  
	  /*
		if(rs!=''&& typeof rs!='undefined'&&rs!='/'){
			n = rs;
		 	form1.name.value=n;
		 	
		 }else if(rs!='')
			 { 
			 	form1.name.value='';
			 }
		  
	  */
	 
		
	if(rs!=''&& typeof rs!='undefined'&& rs!='/' )
	{  
		if(n!='' && n.length>0)
		{				
				for(var i=1;i<rs.split("/").length;i++)
				{
					var r = rs.split("/")[i];
					
					if(r!='' &&  r!='undefined' && n.indexOf("/"+r+"/")==-1 )
					{ 
						n = n+r+"/";
						
					}
				}
			
		}else
		{
			n = rs;
		}
		
  	 	form1.name.value=n;
  	 }else
  	 {
  		form1.name.value='';
  	 }
	
  }
  
 
  
  
  
  function f_clear()
  {

    form1.name.value="";
  }
  function f_sub()
  {
	  if(form1.name.value=='' || form1.name.value=="/")
	  {
		 	 alert('请选择兑换用户');
		 	 form1.name.focus();
		 	 return false;
	  }
	  if(form1.mtext.value=='')
		  {
		 	 alert('请填写短信内容');
		 	 form1.mtext.focus();
		 	 return false;
		  }
	  
	    document.getElementById('buttonid').value='短信正在发送,请稍候...';
		document.getElementById('buttonid').disabled=true;
		document.getElementById('closeid').disabled=true;
		ymPrompt.win({message:'<br><center>短信正在发送,请稍候...</center>',title:'',width:'300',height:'50',titleBar:false});
	   
	  
  }
  </script>
  </HEAD>

<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">

  <DIV id="newmessage">
 
    <h2><span><%=r.getString(teasession._nLanguage, "手机兑换")%></span></h2>

      <form name="form1" method="POST" action="?" onSubmit="return f_sub();">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
      <input type="hidden" name="act" value="WestracEditMemberMailbox">
      <input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl") %>"/>
       <input type="hidden" name="gid" value="<%=gid %>"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td nowrap align="right"><%=r.getString(teasession._nLanguage, "兑换商品")%>：</td>
          <td><%=ipobj.getShopping()%></td>
        </tr>
        <tr>
          <td  nowrap align="right"><%=r.getString(teasession._nLanguage, "兑换用户")%>：</td>
          <td>
            <textarea name="name"  cols="40" rows="2" ><%=name.toString()%></textarea>&nbsp;
            <a href=### onClick="f_open();">选择用户</a>&nbsp;
            <a href=### onClick="f_clear();">清空</a>&nbsp;
          </td>
        </tr> 
        <tr>
         <td  nowrap align="right"><%=r.getString(teasession._nLanguage, "短信内容")%>：</td>
           <td><textarea rows="3" cols="60" name="mtext">您的积分是XXXX，您现在可以兑换我们的XXX礼品，详情请登录lvyou.westrac.com.cn，或咨询履友热线:400 650 1100.</textarea></td>
          </tr>
      </table>
      <br>
<center>
        <input type=SUBMIT id="buttonid" value="<%=r.getString(teasession._nLanguage, "CBSend")%>" >&nbsp;
        <input type="button"  id="closeid" name="reset" value="取消" onClick="window.close();">
</center>

      </form>

</table>
  </body>
</html>
