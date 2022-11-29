<%@page contentType="text/html;charset=utf-8" %><%@page import="tea.entity.criterion.Item" %><%request.setCharacterEncoding("UTF-8");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



String community=request.getParameter("community");

int item=Integer.parseInt(request.getParameter("item"));

Item obj=Item.find(item);
String supermanager=obj.getSupermanager();

String manager=obj.getManager();

tea.entity.member.Profile profile=tea.entity.member.Profile.find(supermanager);

tea.entity.member.Profile profile2=tea.entity.member.Profile.find(manager);

if(request.getMethod().equals("POST"))
{
  String message=request.getParameter("message");
  String subject=request.getParameter("subject");
//  tea.entity.site.Community community_obj=tea.entity.site.Community.find(community);

  int k = tea.entity.member.Message.create(teasession._strCommunity,null, teasession._rv.toString(), 0, 0, 2, 0, teasession._nLanguage, subject, message,null,null,"",null,supermanager+","+manager,"", "", null, null, 0, 0);
/*  try
  {
    tea.service.Robot.activateRoboty(teasession._nNode,k);
  } catch (Exception _ex)
  {}
*/
tea.service.SendEmaily se_obj=new tea.service.SendEmaily(teasession._nNode);
//subject=new String(subject.getBytes("ISO-8859-1"),"UTF-8");
//message=new String(message.getBytes("ISO-8859-1"),"UTF-8");
se_obj.sendEmail(profile.getEmail()+","+profile2.getEmail(),subject,message);

  String result = tea.entity.member.SMSMessage.send(teasession._rv._strV, teasession._nLanguage, profile.getMobile(), message, true, community, 0, null);

  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(result,"UTF-8")+"&community="+community);
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/SMS");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function LoadWindow(obj)
{
  URL="/jsp/sms/psmanagement/FrameGU.jsp?index="+obj;
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
  window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:320px;dialogHeight:265px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}
function fkey(obj,obj2)
{
  obj2.value=obj.value.length;
}
function submitMobile(obj,text)
{
  if(isNaN(parseInt(obj.value))||obj.value.indexOf("13")!=0||obj.value.length<11)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body onLoad="document.form1.subject.focus();">
<form name="form1" action="<%=request.getRequestURI()%>" method="POST" onSubmit="return submitText(this.subject,'无效主题')&&submitText(this.message,'无效内容');">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="item" value="<%=item%>"/>

   <h1><%=r.getString(teasession._nLanguage,"SendSMS")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Number")%></TD>
    <td><input type="text" disabled value="<%if(profile.getMobile()!=null)out.print(profile.getMobile());%>" name="number"><!-- input type="button" value="..." onclick="LoadWindow('form1.number');"/ --></td>
  </tr>
  <tr>
    <td nowrap>E-Mail:</TD>
    <td><input type="text" disabled size="40" name="email" value="<%=profile.getEmail()+";"+profile2.getEmail()%>"></td>
  </tr>
  <tr>
    <td nowrap>内部消息:</TD>
    <td><input type="text" disabled="disabled" size="40" name="member" value="<%=supermanager+";"+manager%>"></td>
  </tr>
    <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Subject")%></TD>
    <td><input type="text" size="40" name="subject" value=""> 注: 发短信时,只发主题中的内容
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></TD>
    <td><textarea name="message" cols="50"  onKeyUp="fkey(this,form1.count);" onChange="fkey(this,form1.count);" onMouseUp="fkey(this,form1.count);" onpaste="fkey(this,form1.count);" onKeyPress="fkey(this,form1.count);" rows="5"></textarea>
      <br/>
      <%=r.getString(teasession._nLanguage,"WordCount")%>:<input type=text name="count" style="border: 0px;" readonly="readonly" size="3" value="0">
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"CBSend")%>">
      <input type="reset" name="Submit" value="<%=r.getString(teasession._nLanguage,"Reset")%>">
    <input type="button" onClick="history.back();" value="返回"/>
    </td>
  </tr>
</table>
</form>
   <br>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br/>
   <div id="language"></div>
</body>
</html>

