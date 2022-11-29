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

Resource r = new Resource();


String membername = "游客";
if(teasession._rv!=null)
{
	membername = teasession._rv._strR;
}

if("POST".equals(request.getMethod()))
{
	int message = Integer.parseInt(teasession.getParameter("message"));
	Message obj = Message.find(message);
	String act = teasession.getParameter("act");

	//发送类型
	int radiotype = Integer.parseInt(teasession.getParameter("radiotype"));
	//会员ID if radiotype 等于1是
	String name = teasession.getParameter("name");
	//同时发送到该人员的外部邮箱
    boolean sendemail = teasession.getParameter("sendemail") != null; //同时发送到该人员的外部邮箱
    String sms = teasession.getParameter("sms"); //短信内容

	//外部邮件 if radiotype 等于2是
	String emailname = teasession.getParameter("emailname");
	String to ="/";
	String sj ="/";
   if (radiotype==2)
   {
	   sms="";
	   to = emailname; 
	   if(emailname.indexOf(",")==-1)
	   {
		   to = "/"+emailname+"/";
	   }else
	   {
		   to=","+emailname.replaceAll(",","/");

	   }
	   sendemail=true;
   }
   String tunit = teasession.getParameter("tunit"); // 部门
	String trole = teasession.getParameter("trole"); // 角色
	//String tgroup = teasession.getParameter("tgroup"); // 通讯录
	//String tcommunity = teasession.getParameter("tcommunity"); // 社区

	int hint = Integer.parseInt(teasession.getParameter("hint"));//提示符
	String subject = teasession.getParameter("subject");//主题
	String content = teasession.getParameter("content");//内容


	if (subject.length() < 1)
	{
		out.println(r.getString(teasession._nLanguage,"Themecannotbeempty"));//主题不能为空
	  return;
	}


	int status = 5;//保存到发件箱
	if (teasession.getParameter("sent") != null)
	{
	  status = 1;
	}
	if (teasession.getParameter("draft") != null)//草稿
	{
	  status = 2;
	}
	boolean feedback = teasession.getParameter("feedback") != null;//收件人查看时自动给我发送回馈


	String picture = null;
	
	obj.set(status, to, trole, tunit, hint, teasession._nLanguage, subject, content, feedback);
int altervalue = 0;
	 for(int i = 1;i<to.split("/").length;i++)
		  {
	        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
	        altervalue = se.sendEmail_int(to.split("/")[i],subject,content);
	     }	

if(altervalue==0) 
{
	  
	//添加成功 //邮件发送成功
	out.print("<script>alert('"+r.getString(teasession._nLanguage,"E-mailsentsuccessfully")+"!'); window.returnValue='1'; window.close();</script>");
	return;
}else
{
	////邮件发送失败，请重新发送...
	out.print("<script>alert('"+r.getString(teasession._nLanguage,"Mailfailedpleasere-send")+"'); window.returnValue='1'; window.close();</script>");
	return;
}
		
	  

   
}


String to = request.getParameter("to");
StringBuffer tmember=new StringBuffer("/");
StringBuffer name=new StringBuffer();
if(to!=null)
{
  tmember.append(to).append("/");
  Profile p=Profile.find(to);
  name.append(p.getName(teasession._nLanguage)).append("; ");
}

String subject = "";
String content = "<br/><br/>";

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
  message=Message.createTempMessage(teasession._strCommunity,membername);
}

int node=0;
 tmp = request.getParameter("node");
if(tmp!=null)
{
  node=Integer.parseInt(tmp);
  Node obj=Node.find(node);
  subject=obj.getSubject(teasession._nLanguage);
  content=content+obj.getText(teasession._nLanguage);
}else
{
	out.print("参数不正确，请重新打开这个页面");
	return ;
}

String ul = "";//转发返回URL
String act = request.getParameter("act");
//if("rc".equals(act))//推荐
{
  subject=r.getString(teasession._nLanguage,"Recommended")+": "+subject;
  content=r.getString(teasession._nLanguage,"Hello")+"！<br><br>"+r.getString(teasession._nLanguage,"Yourfriendstorecommend")+"<a href='http://"+request.getServerName()+":"+request.getServerPort()+"/servlet/Node?node="+node+"' target='_blank'>"+Node.find(node).getSubject(teasession._nLanguage)+"</a>"+content;
}


//r.add("/tea/ui/member/message/NewMessage").add("/tea/ui/member/messagefolder/ManageMessageFolders");


 


Community c=Community.find(teasession._strCommunity);



%><HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script type="text/javascript" language="javascript" src="/tea/ym/ymPrompt.js"></script>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>
  
  <script>
  window.name="dialog";

  function f_submit()
  {
   	if(form1.emailname.value=='')
   	{
   		alert('<%=r.getString(teasession._nLanguage,"E-mailcannotbeempty")%>');
   		form1.emailname.focus();
   		return false;
   	}
	form1.action="?";
	form1.method="POST";
   	ymPrompt.win({message:'<br><center><%=r.getString(teasession._nLanguage,"Informationsubmittedtothe")%></center>',title:'',width:'300',height:'50',titleBar:false});
   	form1.submit();
  }
  </script>
  </HEAD>
  <body>
  <DIV id="newmessage">

    <h1><%=r.getString(teasession._nLanguage, "Sendamessage")%></h1>
    
      <form name="form1"  action="?"    target="dialog">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
      <input type="hidden" name="act" value="act_simple">
      <input type="hidden" name="message" value="<%=message %>">
      <input type="hidden" name="to" value="<%=tmember.toString()%>">
      <input type="hidden" name="tunit" value="/">
      <input type="hidden" name="trole" value="/">
  <input type="hidden" name="radiotype" value="2" >
    <input type="hidden" name=hint value=0 checked>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 

      <tr id="mailtrid2" >
        <td nowrap align="right"><%=r.getString(teasession._nLanguage, "ExternalMail")%>:</td>
        <td>
          <textarea name="emailname"  cols="60" rows="2"></textarea><br><%=r.getString(teasession._nLanguage,"Forexample") %>:xx@xx.com/xx@xx.com
        </td>
      </tr>

      <tr id="trsms" style="display:none">
        <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Messagecontent")%></td>
        <td><%=SMSMessage.contentToHtml(teasession,"sms")%></td>
      </tr>

      
        <tr>
          <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
          <td><input name="subject" size=80 maxlength=255 value="<%=subject%>"></td>
        </tr>
       
        <tr>
          <td colspan="2" nowrap><textarea name="content" rows="10" cols="65"  style="display:none" ><%=tea.html.HtmlElement.htmlToText(content)%></textarea>
            <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="710" height="230" frameborder="no" scrolling="no"></iframe></td>
        </tr>
   
      </table>

      <input type=button value="<%=r.getString(teasession._nLanguage, "CBSend")%>" onclick="f_submit();" >
      <input type=button value="<%=r.getString(teasession._nLanguage,"Close") %>" onclick=window.close();>
   


      </form>

      

      <br>
      <div id="head6"><img height="6" src="about:blank"></div></div>
      <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

  </body>
</html>
