<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.bbs.*"%>

<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%@page import="tea.entity.lvyou.LvyouModels "%>
<%

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
Node node=Node.find(teasession._nNode);

String community=teasession._strCommunity;
Communitybbs ct=Communitybbs.find(community);
Resource r = new Resource();
r.add("/tea/ui/node/talkback/TalkbackServlet");
r.add("/tea/resource/BBS");


h.username=teasession._rv!=null?teasession._rv._strR:null;

boolean isNew=request.getParameter("NewNode")!=null;

int forum=node.getType()>1?node.getFather():node._nNode; //坛子的ID

RV rv=teasession._rv==null?RV.ANONYMITY:teasession._rv;

Profile profile =Profile.find(rv._strR);

if((node.getOptions1() & 1) == 0)
{
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode );
    return;
  }

  //!创建者 && 提供者57 && 当前论坛要审核 && 当前会员审核
  AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);

  Forum fc = Forum.find(node.getCommunity());

  if (!node.isCreator(teasession._rv) && !obj_am.isProvider(57) && fc.getAuditing() != null && fc.getAuditing().indexOf("/" + node._nNode + "/") != -1 &&
		  Subscriber.find(node.getCommunity(), teasession._rv).getOptions() != 2)
  {
    response.sendError(403);
    return;
  }

  //邮箱验证
  if (fc.getValidate() != null && fc.getValidate().indexOf("/" + node._nNode + "/") != -1)
  {
    tea.entity.member.ProfileBBS pb = tea.entity.member.ProfileBBS.find(teasession._strCommunity,teasession._rv._strR);
    if (!pb.isValidate())
    {
      String info = r.getString(teasession._nLanguage, "BBSEmailNoValidate") + new tea.html.Break().toString() + new tea.html.Break().toString() + new tea.html.Button("newsend", r.getString(teasession._nLanguage, "NewSend"), "window.location='/servlet/EditProfileBBS?node=" + teasession._nNode + "&sendaffirmemail=ON';").toString();
      info = java.net.URLEncoder.encode(info, "UTF-8");
      response.sendRedirect("/jsp/info/Alert.jsp?info=" + info);
      return;
    }
  }
  if (fc.getWait() > 0)
  {
    if ((System.currentTimeMillis() - profile.getTime().getTime()) < fc.getWait() * 60 * 1000)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(fc.getWait() + r.getString(teasession._nLanguage, "WaitCannotAppear"), "UTF-8"));
      return;
    }
  }
}

//判断是否禁止发言
if(profile.getNobanspeak()==1)
{
	 response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(profile.getBanspeakreason(teasession._nLanguage),"UTF-8"));
	 return;
}

if(h.username!=null)
{
  Profile p=Profile.find(h.username);
  Date gag=p.getGag();
  if(gag!=null&&gag.getTime()>System.currentTimeMillis())
  {
    out.print("<script>alert('抱歉，您被禁言了，于 "+MT.f(gag)+" 之前不能发贴！');history.back();</script>");
    return;
  }
}


//发贴校验积分
if(isNew)
{
  BBSForum bf=BBSForum.find(forum);
  if(!bf.isAuth(h.community,h.username,bf.ltopic,bf.rtopic))
  {
    out.print("<script>alert('您的积分不足，无权发贴！');history.back();</script>");
    return;
  }
}
tea.entity.site.Community com123 = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
function reloadVcode()//点击更换验证码
{
  var vcode = document.getElementById('vcodeImg');
  vcode.setAttribute('src','/NFasts.do?act=verify&r='+Math.random());
}
</script>
<body class="BBSReply">
<script LANGUAGE=JAVASCRIPT SRC="<%=com123.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>
<div class="BBSReplyCon">
<h1><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form name="form1" method="POST" action="/servlet/EditBBS" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="",text="";
int hint=0;
int bbsid=0;//-(int)(Math.random()*1000000);
BBS obj=new BBS(0,0);
String tmp=request.getParameter("special");
obj.special=tmp==null?0:Integer.parseInt(tmp);
if(isNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  subject=node.getSubject(teasession._nLanguage);
  text=MT.f(node.getText(teasession._nLanguage)).replaceAll("\r\n","\\\\r\\\\n");
  bbsid=teasession._nNode;
  //如果是修改，则表示已经查阅
  obj = BBS.find(node._nNode,teasession._nLanguage);
  obj.setSearch(1);
  //添加查阅人员和日期
  obj.setSearch(teasession._rv._strR,new Date());
}
%>
<input id="file" type="hidden" name="file"/>
<input TYPE="hidden" NAME="community" VALUE="<%=community%>">
<input TYPE="hidden" NAME="node" VALUE="<%=teasession._nNode%>">
<input type="hidden" name="special" value="<%=obj.special%>"/>
<input type="hidden" name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr class="tishifu">
  <td nowrap>表情符号：</Td>
    <td nowrap>
    <input id='radio' type='radio' name='Hint' value='0' checked='true'>无
    <%
    for(int i=1;i<17;i++)
    {
      out.print("<input id='radio' type='radio' name='Hint' value='"+i+"' ");
      if(hint==i)out.print(" checked='true'");
      out.print("><img src='/tea/image/hint/"+i+".gif'>");
    }
    %>    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td nowrap><script>document.write("<in"+"put name='Subj"+"ect' class='edit_input' value=\"<%=MT.f(subject)%>\" SIZE=70 MAXLENGTH=255 alt='主题' />");</script></td>
  </tr>
<%
if(obj.special==1)
{
%>
  <tr>
    <td>投票:</td><td>选项:每行填写 1 个选项 最多可填写 20 个选项<br/>
    <%
    int pstart=0;
    if(!isNew)
    {
      ArrayList al=BBSPoll.find(" AND node="+teasession._nNode,0,20);
      pstart=al.size();
      for(int i=0;i<pstart;i++)
      {
        BBSPoll bp=(BBSPoll)al.get(i);
        out.print("<div><input size='40' name='question"+bp.bbspoll+"' value='"+MT.f(bp.question)+"' alt='"+(i<2?"选项":"")+"'> <a href='###' onclick='pdel(this)'><img src='/tea/image/public/del2.gif'/></a></div>");
      }
    }
    for(int i=pstart;i<20;i++)out.print("<div style='display:"+(i<5?"":"none")+"'><input size='40' name='question' alt='"+(i<2?"选项":"")+"'> <a href='###' onclick='pdel(this)'><img src='/tea/image/public/del2.gif'/></a></div>");
    %>
    <a href="javascript:padd()">+增加一项</a>
    <input type="checkbox" name="multiple" id="multiple" <%=obj.multiple?" checked":""%> /><label for="multiple">多选投票</label>
    <input type="checkbox" id="_expiration" onClick="form1.expiration.disabled=!checked" <%=obj.expiration>0?" checked":""%> /><label for="_expiration">记票天数</label><input name="expiration" value="<%=MT.f(obj.expiration)%>" size="6" mask="int"/>
    <input type="checkbox" name="visibility" id="visibility" <%=obj.visibility?" checked":""%> /><label for="visibility">投票后结果可见</label>
    <input type="checkbox" name="overt" id="overt" <%=obj.overt?" checked":""%> /><label for="overt">公开投票参与人</label>
    </td>
  </tr>
  <script>$('_expiration').onclick();</script>
<%
}else if(obj.special==2)
{
%>
  <tr>
    <td>
    开始时间:</td><td><input type="text" name="starttime" value="<%=MT.f(obj.starttime,1)%>" onClick="mt.date(this,true)" alt="开始时间"/></td></tr>
  <tr><td>活动地点:</td><td><input type="text" name="place" value="<%=MT.f(obj.place)%>" alt="活动地点"/></td></tr>
     <tr><td>活动类别:</td><td><input type="text" name="category" value="<%=MT.f(obj.category)%>" alt="活动类别"/></td></tr>
     <tr><td> 每人花销:</td><td><input type="text" name="cost" value="<%=MT.f(obj.cost)%>" alt="每人花销" mask="float" size="10"/>元</td></tr>
    <tr><td>  所在城市:</td><td><input type="text" name="city" value="<%=MT.f(obj.city)%>"/></td></tr>
    <tr><td>  需要人数:</td><td><input type="text" name="number" value="<%=MT.f(obj.rnumber)%>" mask="int"/></td></tr>
     <tr><td> 姓名:</td><td><%=h.radios(BBS.SEX_TYPE,"sex",obj.sex)%></td></td>
     <tr><td> 征集截止日期:</td><td><input type="text" name="exptime" value="<%=MT.f(obj.exptime,1)%>" onClick="mt.date(this,true)"/></td>
     </tr>
<%
}else if(obj.special==3)
{
%>
  <tr><td>招聘人姓名:</td><td><input type="text" name="name" value="<%=MT.f(obj.name)%>" alt="招聘人姓名"/></td></tr>
  <tr><td>联系方式: </td><td><input type="text" name="phone" value="<%=MT.f(obj.phone)%>" alt="联系方式"/></td></tr>
  <tr><td>薪酬待遇: </td><td><select name="wage"><%=h.options(BBS.WAGE_TYPE,obj.wage)%></select></td></tr>
  <tr><td>工作地点: </td><td><script src="/tea/city.js"></script><script>mt.city("icity0","icity1",null,"<%=obj.icity%>");</script></td></tr>
  <tr><td>操作机型: </td><td><input type="text" name="professional" value="<%=MT.f(obj.professional)%>"/></td></tr>
  <tr><td>招聘人数: </td><td><input type="text" name="number" value="<%=MT.f(obj.rnumber)%>" mask="int"/></td></tr>
  <tr><td>对机手的要求:</td><td><textarea name="requires" rows="6" cols="60"><%=MT.f(obj.requires)%></textarea></td></tr>
<%
}else if(obj.special==4)
{
%>
  <tr><td>求职人姓名:</td><td><input name="name" value="<%=MT.f(obj.name)%>"/></td></tr>
  <tr><td>性　　别: </td><td><input name="sex" type="radio" value="1" id="sex1" checked/><label for="sex1">男</label>　<input name="sex" type="radio" value="2" id="sex2"<%=obj.sex==2?" checked":""%> /><label for="sex2">女</label></td></tr>
  <tr><td>年　　龄: </td><td><input name="age" value="<%=MT.f(obj.age)%>" mask="int"/></td></tr>
  <tr><td>联系方式: </td><td><input name="phone" value="<%=MT.f(obj.phone)%>"/></td></tr>
  <tr><td>期望薪酬: </td><td><select name="wage"><%=h.options(BBS.WAGE_TYPE,obj.wage)%></select></td></tr>
  <tr><td>工作地点: </td><td><script src="/tea/city.js"></script><script>mt.city("icity0","icity1",null,"<%=obj.icity%>");</script></td></tr>
  <tr><td>操作年限: </td><td><input name="experience" value="<%=MT.f(obj.experience)%>" mask="int"/></td></tr>
  <tr><td>身份类型: </td><td><select name="jobtype"><option value="0">------</option><%=JobType.options(h.community,obj.jobtype)%></select></td></tr>
  <tr><td>操作机型: </td><td>
  <select name="jobmodel">
  <% //h.options(Profile.WST_MODEL,obj.jobmodel)
 ArrayList modelist=LvyouModels.find();
	      for(int i=0;i<modelist.size();i++)
	      {
	    	  LvyouModels cata=(LvyouModels)modelist.get(i);
	    	  out.print("<option value="+i+">"+cata.getName());
	      }


  %>


  </select></td></tr>
<%
}
%>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</Td>
    <td nowrap>
      <script>document.write("<tex"+"tarea name='content' style='display:none'><%=text%></textarea><ifra"+"me id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?In"+"stanceName=content&Toolbar=MySetting<%//=teasession._strCommunity%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");</script>    </td>
  </tr>
<%

out.print("<tr ID=forumid><td nowrap>"+r.getString(teasession._nLanguage, "附件")+":</td><td nowrap style='height:100px'><iframe src='/jsp/type/bbs/EditBBSAttach.jsp?type=false&bbsid="+bbsid+"&node="+forum+"' allowtransparency='true' scrolling='no' id='ba' height='100px' width='100%' frameborder='0'></iframe></td></tr>");

Forum fc = Forum.find(teasession._strCommunity);
String vertify = fc.getVertify();
if(vertify!=null&&vertify.indexOf("/"+forum+"/")!=-1)
{
  out.print("<tr><td>验证码:</td><td><input name='vertify' alt='验证码' size='10'><img id='vcodeImg'  align='absmiddle' class='CodeImg'  src='/NFasts.do?act=verify'/><a href='###'   style='cursor:pointer'  onClick='reloadVcode();'>重新获得验证码</a></td></tr>");
}
%>


<tr <%if(ct.getUpFileType()!=1)out.print("style=display:none;");//按社区显示  默认隐藏%>>
  <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "UploadFile")%>:</td>
<td nowrap="nowrap">  <a style="position:absolute"><img src="/tea/image/netdisk/deplacer.gif" align="absmiddle"><%=r.getString(teasession._nLanguage, "AddFile")%></a>
    <input id="fdoc" type="file" name=fdoc style="position:absolute;width:12px;cursor:hand;filter:Alpha(opacity=0)" onChange="f_click(this)"/>　　　　　　　　<span id="fi"></span>
   <%=r.getString(teasession._nLanguage, "AddFileAction")%></td>
</tr>
</table>

<input TYPE="submit" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input TYPE="button" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "返回")%>" onClick="history.back();">
</form>



<br>
<div id="head6"><img height="6" src="about:blank"></div>
<script>

var hlast=5;
function padd()
{
  var t=form1.question;
  if(t.length<=hlast)return;
  t[hlast++].parentNode.style.display='';
}
function pdel(a)
{
  a=a.parentNode;
  a.parentNode.removeChild(a);
}

document.form1.Subject.focus();

function f_click(obj)
{
  if(!obj)obj=this;

  var td = document.getElementById("fi");
  var path=obj.value;
  var name=path.substring(path.lastIndexOf("\\")+1);
  var ex=name.substring(name.lastIndexOf(".")+1);
  td.innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name+"　<a href=javascript:f_del();><b>移除</b></a>";
  document.form1.file.value = path;
}
function f_del()
{
  var obj = document.getElementById("fdoc");
  obj.outerHTML = obj.outerHTML;
  var obj1 = document.getElementById("file");
  obj1.outerHTML = obj1.outerHTML;
  document.getElementById("fi").innerHTML="&nbsp;";
}
</script>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=com123.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
