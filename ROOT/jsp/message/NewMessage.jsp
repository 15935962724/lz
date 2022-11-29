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
if(to!=null&&to.length()>0)
{
  if(to.charAt(0)=='|')to=to.substring(1,to.indexOf('|',2));
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
  MessageOld obj=MessageOld.find(message);
  subject=obj.getSubject(teasession._nLanguage);
  content=content+obj.getContent(teasession._nLanguage);
}else
{
  message=MessageOld.createTempMessage(teasession._strCommunity,teasession._rv._strV);
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
  subject="Re: "+subject;
  message=MessageOld.createTempMessage(teasession._strCommunity,teasession._rv._strV);
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
    window.open('/jsp/user/list/SelMembers2.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name','','width=450px,height=390px,top=300px,left=400px');
  }
  function f_clear()
  {
    form1.to.value="/";
    form1.tunit.value="/";
    form1.name.value="";
  }
  </script>
  </HEAD>
  <body>
  <DIV id="newmessage">

    <h1><%=r.getString(teasession._nLanguage, "发送消息")%></h1>
    <div id="head6"><img height="6" src="about:blank"></div>
      <br>

      <form name="form1" method="post" action="/servlet/NewMessage" enctype="multipart/form-data" onSubmit="return(submitText(document.getElementById('showtm'),'无效人员')&&submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&(this.sms.disabled||submitText(this.sms, '<%=r.getString(teasession._nLanguage, "无效-短信内容")%>')) );">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
      <input type="hidden" name="act" value="<%=act%>">
      <input type="hidden" name="message" value="<%=message%>">
      <input type="hidden" name="talkback" value="<%=talkback%>">
      <input type="hidden" name="to" value="<%=tmember.toString()%>">
      <input type="hidden" name="tunit" value="/">
      <input type="hidden" name="trole" value="/">


      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "内部人员")%>:</td>
          <td>
          <%
          if(!au.isHiddenorg()){
            %>
            <textarea name="name" readonly cols="50" rows="2"><%=name.toString()%></textarea>
            <input type="button" value="添加" onClick="f_open();" />
            <input type="button" value="清空" onClick="f_clear();" />
            <%
            }else{
              %>
              <input id="showtm" type="text" name="tm" value="<%=name.toString()%>"
              <%
              if(act!=null&&act.equals("re"))out.print("disabled");
              %>/><%

                %>
                <input id="seltm" type="button" value="选择" <%if(act!=null&&act.equals("re"))out.print("style=display:none;");%> onClick="f_show(seltm,tm_show);" />
                <%

              }
              %>

            <br>
            <input type="CHECKBOX" name="sendemail"><%//=r.getString(teasession._nLanguage, "MsgOSendEmail")%>同时发送到该人员的外部邮箱
            <%
            if(CommunityOption.find(teasession._strCommunity).get("smstype")!=null)
            out.print("<input type='checkbox' onclick=\"trsms.style.display=checked?'':'none';form1.sms.disabled=!checked;form1.sms.value=form1.subject.value;\">同时发送到该人员的手机短信");
            %>
          </td>
        </tr>
        <tr id="trsms" style="display:none">
          <td nowrap><%=r.getString(teasession._nLanguage, "短信内容")%></td>
          <td><%=SMSMessage.contentToHtml(teasession,"sms")%></td>
        </tr>
        <tr class="NewMessage_hint">
          <td nowrap><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
          <td>
            <input type="radio" name=hint value=0 checked><img src="/tea/image/hint/0.gif" >
            <input type="radio" name=hint value=1><img src="/tea/image/hint/1.gif" >
            <input type="radio" name=hint value=2><img src="/tea/image/hint/2.gif" >
            <input type="radio" name=hint value=3><img src="/tea/image/hint/3.gif" >
            <input type="radio" name=hint value=4><img src="/tea/image/hint/4.gif" >
            <input type="radio" name=hint value=5><img src="/tea/image/hint/5.gif" >
            <input type="radio" name=hint value=6><img src="/tea/image/hint/6.gif" >
            <input type="radio" name=hint value=7><img src="/tea/image/hint/7.gif" >
            <input type="radio" name=hint value=8><img src="/tea/image/hint/8.gif" >
            <input type="radio" name=hint value=9><img src="/tea/image/hint/9.gif" >
            <input type="radio" name=hint value=10><img src="/tea/image/hint/10.gif" >
            <input type="radio" name=hint value=11><img src="/tea/image/hint/11.gif" >  </td>
        </tr>
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
          <td><input name="subject" size=80 maxlength=255 value="<%=subject%>"></td>
        </tr>
        <tr>
          <td nowrap align="left"><%=r.getString(teasession._nLanguage, "附件")%>:</td>
          <td><iframe id="attach" src="/jsp/message/NewMessageAttachment.jsp?community=<%=teasession._strCommunity%>&message=<%=message%>" style="width:100%; height:25px;text-align:left" frameborder="0" scrolling="no"></iframe></td>
        </tr>
        <tr>
          <td colspan="2" nowrap><textarea name="content" rows="10" cols="60"  style="display:none" ><%=tea.html.HtmlElement.htmlToText(content)%></textarea>
            <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=MySetting" width="720" height="200" frameborder="no" scrolling="no"></iframe></td>
        </tr>
        <tr>
          <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
          <td>
            <input type="CHECKBOX" name="sent" checked>保存到发件箱
            <input type="CHECKBOX" name="feedback">收件人查看时自动给我发送回馈
          </td>
        </tr>
      </table>

      <input type=SUBMIT value="<%=r.getString(teasession._nLanguage, "CBSend")%>" >
      <input type=SUBMIT name="draft" value="<%=r.getString(teasession._nLanguage, "CBDraft")%>">

      <div id="tm_show" style="display:none;position:absolute;width:200px;background-color:#F2F2F2;z-index:99;border:1px solid #F2F2F2;">
        <table id="tablecenter" style="margin-bottom:5px;margin-top:5px;">
          <tr>
            <td colspan="2" align="center">收件人</td>
          </tr>
          <%
          List fMemberArray = new ArrayList();
          Iterator it= MessageOld.find(teasession._strCommunity,teasession._rv._strR,0,"", 0, Integer.MAX_VALUE).iterator();
          for(int i = 1;it.hasNext() ;i++)
          {
            int id = ((Integer)it.next()).intValue();
            String chk = "";
            if(i == 1){
              chk = "checked";
            }
            MessageOld m = MessageOld.find(id);
            String fmember = m.getFMember();
            if(fMemberArray.indexOf(fmember)==-1){
              out.print("<tr><td width=30% ><input id=fm"+i+" type=radio name=fmember value="+fmember+" "+chk+"/></td><td>"+fmember+"<br/>");
              fMemberArray.add(fmember);
            }
          }
          %>
          <tr><td align="center" colspan="2"><input type="button" value="添加" onclick="add_tm('fmember');"/>&nbsp;<input type="button" value="关闭" onclick="document.getElementById('tm_show').style.display='none';"/>
        </table>
      </div>
      <script>
      if(history.length>0)
      {
        document.write("<input type=button value=返回 onclick=history.back();>");
      }else
      {
        document.write("<input type=button value=关闭 onclick=window.close();>");
      }

      function add_tm(radioName){
        var fm = "";
        var obj = document.getElementsByName(radioName);             //这个是以标签的name来取控件
        for(i = 0; i < obj.length; i++){
          if(obj[i].checked){
            fm = obj[i].value;
          }
        }
        document.getElementById('showtm').value = fm;
        document.getElementById('tm_show').style.display='none';
      }

      function getPos(el,sProp)
      {
        var iPos = 0 ;
        　　while (el!=null)   　　
        {
          iPos+=el["offset" + sProp];
          　el = el.offsetParent;
        }
        　　return iPos;
      }

      function f_show(id,m)
      {
        if(m.style.display=='none')
        {
          m.style.display='';
          m.style.left = getPos(id,"Left")+37;
          m.style.top = getPos(id,"Top") + id.offsetHeight-24;
          cm=id;
        }else
        {
          m.style.display='none';
        }
      }
      </script>

      </form>

      <%--
      <iframe id="attach" src="about:blank" style="display:none"></iframe>
      <form name="form2" method="post" action="/servlet/NewMessage" enctype="multipart/form-data" target="attach">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
      <input type="hidden" name="message" value="<%=message%>">
      <input type="hidden" name="act" value="<%=act%>">
      <input type="hidden" name="part" value="1" />
      </form>
      --%>

      <br>
      <div id="head6"><img height="6" src="about:blank"></div></div>
      <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

  </body>
</html>
