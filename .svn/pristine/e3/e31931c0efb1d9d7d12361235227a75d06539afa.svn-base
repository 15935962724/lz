<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.meeting.*"%><%@page import="tea.ui.*"%><%

Http h=new Http(request,response);
TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}


Profile m=Profile.find(h.member);

int message=h.getInt("message");
Message t=Message.find(message);

String nexturl=h.get("nexturl","/admin/member/Messages.jsp");

int attach=0;

StringBuilder to=new StringBuilder();
if(message>0)
{
  Profile f=Profile.find(t.member);
  to.append("<span id='"+t.member+"'><input type='hidden' name='members' value='"+t.member+"'>"+f.getMember()+"<img onclick=mt.del(this) src='/tea/image/d7.gif'></span>");
}

//int type=h.getInt("type");//1:email
//if(type==1)

if(h.key==null)
{
  int member=h.getInt("member");
  String members=member>0?"|"+member+"|":h.get("members","|");
  members=members.substring(1).replace('|',',')+0;
  h.key=" AND profile IN("+members+")";
}
if(h.key!=null)
{
  int sum=0;
  Enumeration e=Profile.find(h.key,0,Integer.MAX_VALUE);
  while(e.hasMoreElements())
  {
    String mid=(String)e.nextElement();
    Profile p=Profile.find(mid);
    if(sum++==10)to.append("<span style='display:none'>");
    to.append("<span><input type='hidden' name='members' value='"+p.getProfile()+"'>"+p.getMember()+"<img onclick='mt.del(this)' src='/tea/image/d7.gif' /></span>");
  }
  if(sum>10)to.append("</span><span style='cursor:pointer' onclick='mt.hidden(previousSibling)'>还有"+(sum-10)+"位收件人</span>");
}

String subject="";
String content="";
String act=h.get("act");
if("re".equals(act))
{
  subject="Re: "+t.subject;
  content="<br/><br/><br/><br/><br/><br/><br/><br/>在"+MT.f(t.time,1)+"，“"+t.getFrName(h.language)+"” <"+Profile.find(t.member).getMember()+"> 写道：<br/>"+t.content;
  attach=message;
  message=0;
}else if("fw".equals(act))
{
  subject="Fw: "+t.subject;
  content="<br/><br/><br/><br/><br/><br/><br/><br/>---------- 转发邮件信息 ----------"+
  "<br/>发 件 人: "+t.getFrName(h.language)+" <"+Profile.find(t.member).getMember()+">"+
  "<br/>发送日期: "+MT.f(t.time,1)+
  "<br/>收 件 人: "+t.getToName(h.language)+
  "<br/>主　　题: "+t.subject+"<br/>"+t.content;
  attach=message;
  message=0;
}
String tname="";
String tmember=h.get("tmember","|");
//if(tmember.length()>2)
//{
//  tname+=Member.find(tmember.substring(1,tmember.length()-1)).name+"; ";
//}
////邮件签名
//String tmp=MT.f(m.emailsignature);
//if(tmp.length()>0)
//  content+="<br/><br/><br/><br/><br/>-----------<br/>"+tmp.replaceAll("http://([\\w-]+\\.)+[\\w]+[\\w/.?=&%+]*","<a href='$0' target='_blank'>$0</a>").replaceAll("\r\n","<br/>");


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
//function f_send()
//{
//  if(!form1.members&&!form1.tdept&&!form1.invites&&!form1.meetings&&!form1.zones)
//    mt.show("您没有填写“收件人”，确定要发送给网站所有人员吗？",2,"form1.submit()");
//  else
//    form1.submit();
//  return false;
//}
function f_send(f)
{
//  if(!form1.msg.checked&&!form1.email.checked)
//  {
//    mt.show('“发送类型”至少要选择一项！');
//    return false;
//  }
  if(!mt.check(f))return false;
  mt.show(null,0);
  mt.submit(f);
}
mt.sel=function()
{
  mt.show("/jsp/profile/Member1Sel.jsp?member="+mt.value(form1.members,"|"),2,"添加管理员",500,400);
}

mt.sel2=function()
{
  INV=mt.value(form1.invites,"|");
  mt.show("/admin/meeting/InviteSel.jsp?invite=INV&meeting="+mt.value(form1.meetings,"|")+"&zone="+mt.value(form1.zones,"|"),2,"选择学者",500,400);
}
mt.del=function(p)
{
  p=p.parentNode;
  //t=form1.tmember;
  //t.value=t.value.replace("|"+p.firstChild.value+"|","|");
  p.parentNode.removeChild(p);
}
mt.receive=function(a,b,c){$('t_member').innerHTML+=c;}
</script>
</head>
<body>
<h1>撰写新消息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/Messages.do?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return f_send(this);">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="message" value="<%=message%>"/>
<input type="hidden" name="attach" value="|<%//=attach%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="url"/>
<input type="hidden" name="invite" value="0"/>

<table id="tablecenter">
  <tr>
    <td>收件人</td>
    <td><div id="t_member" alt="收件人"><%=to%></div> <input type="button" onclick="mt.sel()" value="添加管理员"/></td>
  </tr>
  <tr>
    <td>主　题</td>
    <td><input name="subject" value="<%=subject%>" size="60" alt="主题"/></td>
  </tr>
  <tr>
    <td>附　件</td>
    <td><input id="attch" type="button" value="上传附件"/><div id="list"></div></td>
  </tr>
  <tr>
    <td colspan="2">
      <!--<input type="button" value="网页邮件" onclick="mt.act('url')"/>
      <input type="button" value="写信模板" onclick="mt.act('tmp')"/>
      <br/>-->
      <textarea name="content" style="display:none" rows="12" cols="90"><%=content%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="735" height="300" frameborder="no"></iframe>
    </td>
  </tr>
  <tr>
    <td>选　项</td>
    <td>
      <input type="checkbox" name="msg" id="msg" checked="checked" onclick="mt.dis(checked)"/><label for="msg">发送到站内信　</label>
      <input type="checkbox" name="save" id="save" checked="checked"/><label for="save">保存在发件箱</label>
      <input type="checkbox" name="receipt" id="receipt"/><label for="receipt">收件人查看时自动给我发送回执</label>
      <br/>
      <input type="checkbox" name="email" id="email" checked="checked"/><label for="email">发送到外部邮箱</label>
    </td>
  </tr>
</table>
<br/>
<input class="but" type="submit" value="发　送"/> <input class="but" type="button" value="返　回" onclick="location='<%=nexturl%>';"/>
</form>


<script>
var up=new Upload($$('attch'));
up.fileQueued=function(f)
{
  $$('list').innerHTML+="<div><img src='/tea/image/netdisk/"+f.type.substring(1)+".gif' />"+f.name+"　"+mt.f(f.size/1024,2)+"KB　<img src='/tea/image/d7.gif' onclick=up.del(this,'"+f.id+"')></div>";
};
up.del=function(a,id)
{
  up.cancel(id);
  a=a.parentNode;
  a.parentNode.removeChild(a);
};
up.uploadProgress=function(f,b,t)
{
  if(!t)return;
  mt.progress(b,f.size,"文件：" +f.name+"<br/>总计：" + mt.f(f.size/1024,2)+' KB' + "　已传：" + mt.f(b/1024,2)+' KB');
};
up.uploadSuccess=function(file,d,responseReceived)
{
  form1.attach.value+=d.substring(d.indexOf('\n')+1)+'|';
};
up.complete=function()
{
  mt.submit(this.but.form);
};
mt.submit=function(f)
{
  var file=up.getFile();
  if(file)
  {
    up.start();
    //$$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB';
    //$$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
    return;
  }
  $$('dialog_content').innerHTML="数据提交中,请稍等...";
  f.submit();
};

mt.act=function(a)
{
  if(a=='url')
  {
    mt.show('网址：<input id=_url size=30>',2,'发送网页');
    mt.ok=function()
    {
      var t=$('_url').value;//t='http://www.beijingforum.org/201103en/index.html';
      if(t=='')
      {
        alert('“网址”不能为空！');
        return false;
      }
      if(t.indexOf('http')!=0)t='http://'+t;
      if(t.indexOf('/',10)==-1)t+='/';
      mt.send('/Messages.do?act=url&url='+encodeURIComponent(t),function(h)
      {
        mt.close();
        form1.url.value=t;
        form1.content.value=h;
        var doc=$('editor').contentWindow.document;
        doc.write(h);
        doc.close();//关闭后,再写就会清空之间内容
      });
      //mt.post('/Messages.do?act=url&url='+encodeURIComponent(t));
      mt.show(null,0);
      return false;
    }
  }else if(a=='tmp')
  {
    mt.show('/admin/member/MessageTmpSel.jsp',1,'写信模板',400,300);
  }
};

mt.dis=function(b)
{
  form1.save.disabled=form1.receipt.disabled=!b;
};

<%
if(h.getBool("tmp"))out.print("mt.act('tmp');");
%>
</script>
</body>
</html>
