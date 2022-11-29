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

String to = request.getParameter("to");
StringBuffer tmember=new StringBuffer("/");
StringBuffer name=new StringBuffer();
if(to!=null)
{
  tmember.append(to).append("/");
  name.append("/").append(to).append("/");
//  Profile p=Profile.find(to);
  //name.append(p.getName(teasession._nLanguage)).append("; ");
}

String subject = "";
String content = "";

int message=0;
String tmp = request.getParameter("message");
if(tmp!=null)
{
  message=Integer.parseInt(tmp);
  Message obj=Message.find(message);
  subject=obj.getSubject(teasession._nLanguage);
  content=content+obj.getContent(teasession._nLanguage);
}else
{
  message=Message.createTempMessage(teasession._strCommunity,teasession._rv._strV);
}
int talkback=0;
tmp = request.getParameter("talkback");
if(tmp!=null)
{
  talkback=Integer.parseInt(tmp);
  Talkback obj=Talkback.find(talkback);
  subject=obj.getSubject(teasession._nLanguage);
  content=content+obj.getContent(teasession._nLanguage);
}
int node=0;
tmp = request.getParameter("node");
if(tmp!=null)
{
  node=Integer.parseInt(tmp);
  Node obj=Node.find(node);
  subject=obj.getSubject(teasession._nLanguage);
  content=content+obj.getText(teasession._nLanguage);
}

String ul = "";//转发返回URL
String act = request.getParameter("act");
if("fw".equals(act))//转发
{
  subject="Fw: "+subject;

}else if("re".equals(act))//回复
{
  subject="回复: "+subject;
  message=Message.createTempMessage(teasession._strCommunity,teasession._rv._strV);
}else if("rc".equals(act))//推荐
{
  subject="推荐: "+subject;
  content="您好！<br><br>您的朋友向您推荐<a href='http://"+request.getServerName()+":"+request.getServerPort()+"/servlet/Node?node="+node+"' target='_blank'>"+Node.find(node).getSubject(teasession._nLanguage)+"</a>"+content;
}

Resource r=new Resource();
r.add("/tea/ui/member/message/NewMessage").add("/tea/ui/member/messagefolder/ManageMessageFolders");


String s7 = request.getParameter("messagefolder");
if(s7!=null)
{
  int i=Integer.parseInt(s7);
  MessageFolder messagefolder = MessageFolder.find(i);
  String s9 = messagefolder.getMember();
  subject = r.getString(teasession._nLanguage, "Invite") + ":";
  content = r.getString(teasession._nLanguage, "InviteSubscription") + ":  " + "<a href=\"/servlet/MessageFolderContents?community="+teasession._strCommunity+"&messagefolder=" + s7 + "\">" + messagefolder.getName(teasession._nLanguage) + "</a>";
}

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);

Community c=Community.find(teasession._strCommunity);

AdminUnit au=AdminUnit.find(aur.getUnit());

%><HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
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
	  var url = '/jsp/message/MemberList2.jsp?community='+form1.community.value+u;
	  var rs = window.showModalDialog(url,self,y);
	  
	if(rs!=''&& typeof rs!='undefined'&&rs!='/')
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
  	 }
	
  }
  
  function f_open2()
  {
  
  	var n = form1.name.value;
  	var u = '';
  	if(n!=''){
  		u = '&name='+encodeURIComponent(n);
  	}
  	
     var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:650px;dialogHeight:580px;';
	  var url = '/jsp/message/MemberFriendList.jsp?community='+form1.community.value+u;
	  var rs = window.showModalDialog(url,self,y);
	if(rs!=''&& typeof rs!='undefined'&&rs!='/'){
		  
		
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
		 	 alert('请选择收件人');
		 	 return false;
	  }
	  if(form1.subject.value=='')
		  {
		 	 alert('请填写主题');
		 	 return false;
		  }
	    if(form1.content.value=='')
		  {
		  	alert('请填写内容');
		  	return false;
		  }
	  
  }
  </script>
  </HEAD>
<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">

  <DIV id="newmessage">

    <h1><span><%=r.getString(teasession._nLanguage, "新建信息")%></span></h1>
    <div id="head6"><img height="6" src="about:blank"></div>
      <br>

      <form name="form1" method="post" action="/servlet/NewMessage" onSubmit="return f_sub();">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
      <input type="hidden" name="act" value="EditMemberMailbox">
      <input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl") %>"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "收件人")%>:</td>
          <td>
            <textarea name="name"  cols="50" rows="2"><%=name.toString()%></textarea>&nbsp;
            <a href=### onClick="f_open();">选择已有联系人</a>&nbsp;
             <a href=### onClick="f_open2();">选择好友</a>&nbsp;
            <a href=### onClick="f_clear();">清空</a>&nbsp;
          </td>
        </tr>
       
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
          <td><input name="subject" size=80 maxlength=255 value="<%=subject%>"></td>
        </tr>
        
        <tr>
         <td nowrap><%=r.getString(teasession._nLanguage, "内容")%>:</td>
          <td colspan="2" nowrap>
          <!-- <textarea name="content" rows="10" cols="60" ><%=tea.html.HtmlElement.htmlToText(content)%></textarea> -->
          
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=tea.html.HtmlElement.htmlToText(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
          
          
        </tr> 
        <tr style="display:none;">
          <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
          <td>
            <input type="CHECKBOX" name="sent" checked>保存到发件箱
            <input type="CHECKBOX" name="feedback">收件人查看时自动给我发送回馈
          </td>
        </tr>
      </table>

      <input type=SUBMIT value="<%=r.getString(teasession._nLanguage, "CBSend")%>" >&nbsp;
        <input type="button" name="reset" value="取消" onClick="window.open('<%=teasession.getParameter("nexturl") %>','_self');">


      </form>

      <br>
      <div id="head6"><img height="6" src="about:blank"></div></div>
      <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
</table>
  </body>
</html>
