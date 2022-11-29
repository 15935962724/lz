<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.resource.*"%>
<%request.setCharacterEncoding("UTF-8");tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
Resource r = new Resource();

if(request.getMethod().equals("POST"))
{
  String LoginId = request.getParameter("LoginId").trim(); //.toLowerCase();
  for (int index = 0; index < LoginId.length(); index++)
  {
    if (LoginId.charAt(index) >= 'A' && LoginId.charAt(index) <= 'Z')
    {
      LoginId = LoginId.substring(0, index) + (char) (LoginId.charAt(index) + 32) + LoginId.substring(index + 1);
    }
  }
  int lt = 0;
  try
  {
    lt = Integer.parseInt(request.getParameter("LoginType"));
  } catch (NumberFormatException ex)
  {}
  String s1 = request.getParameter("Password");
  String s2 = request.getParameter("nexturl");
  if (s2 == null)
  {
    s2 = request.getContextPath() + "/servlet/Node?node=" + teasession._nNode;
  }
  String memberid = "";
  String mobile = "";
  if (lt == 0)
  {
    memberid = LoginId;
    mobile = tea.entity.member.Profile.find(LoginId).getMobile();
  } else
  {
    memberid = tea.entity.member.Profile.numtoid(LoginId);
    mobile = LoginId;
  }
  tea.entity.RV rv = new tea.entity.RV(memberid);
  if (!rv.isExisted())
  {
    out.print(new tea.html.Script("alert('"+r.getString(teasession._nLanguage, "InvalidMemberId")+"');history.back();"));
    return;
  }
  if (!tea.entity.member.Profile.isPassword(lt, LoginId, s1))
  {
    out.print(new tea.html.Script( "alert('"+r.getString(teasession._nLanguage, "InvalidPassword")+"');history.back();"));
    return;
  }
  tea.entity.member.Log.create(rv, 1, request.getRemoteHost() + " / " + request.getRemoteAddr());
  tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
  String s3 = node.getCommunity();
  tea.entity.site.Community community = tea.entity.site.Community.find(s3);
  if (community.getType() == 1)
  {
    tea.entity.site.Subscriber.create(s3, new tea.entity.RV(memberid),0);
  }
  if (!rv._strR.equals(rv._strV))
  {
    String s4 = tea.entity.member.Associate.find(rv._strR, rv._strV).getStartUrl();
    if (s4 != null && s4.length() != 0)
    {
      s2 = s4;
    }
  }
  HttpSession httpsession = request.getSession(true);
  httpsession.setAttribute("tea.RV", rv);
  httpsession.setAttribute("sms.phonenumber", mobile);
  httpsession.setAttribute("tea.Count", new Integer(0));
  out.print(new tea.html.Script("window.opener.location='"+s2+"';window.close();"));
  return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<TITLE>21世纪论坛 - 登陆�?/TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK REL=StyleSheet HREF>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
  <style type="text/css">
    <!--
	body{padding:0;margin:0}
      *{font-size:9pt;}
      .dl{background:url(/tea/image/section/12974.jpg);width:776px;height:247px;text-align:right;}
      .dl ul{margin-top:70px;margin-right:40px;float:right}
      .dl div{float:left;margin-left:136px;margin-top:86px;color:#fff;width:118px;}
      .dl li{list-style:none;margin:5px;}
      .dl input{border:1px solid #000;background:#FFF;}
      .deng{margin-left:55px;border:0}
    -->
  </style>
<script language="JavaScript">
function closewindow()
{

	window.open ("/servlet/Login", "newwindow")
	window.close();
}

function before_submit()
{
	if (document.foLogin.LoginId.value == '' || document.foLogin.Password.value == '')
	{
		alert('请输入用户名和密�?');
		document.foLogin.LoginId.focus();
		return false;
	}
	return true;
}

function reg()
{
	window.opener.location = 'reg.asp';
	window.close();
}

</script>  <div class="dl">
    <ul>
    <form name=foLogin METHOD=POST
	 onSubmit="javascript:return before_submit();return(submitText(this.LoginId,'无效会员ID'));return closewindow()">
      <input type='hidden' name=nexturl VALUE="/servlet/Node?node=20866">
      <input type='hidden' name=Node VALUE="20866">
      <li><%=r.getString(teasession._nLanguage, "MemberId")%>�?input type="text" class="edit_input" name=LoginId size="12">
</li>
      <li><%=r.getString(teasession._nLanguage, "Password")%>�?input type="password" class="edit_input" name="Password" size="12"></li>
      <li class="deng"><input type="submit" name="enter" value="<%=r.getString(teasession._nLanguage, "Enter")%>"  onClick="" style="border:1px solid #ccc;height:20px;padding:2px 15px;">
      </li>
    </form>
    </ul>
    <div>
      <marquee scrollAmount="2" direction="left" id="zxgg" onMouseOver=zxgg.stop() onMouseOut=zxgg.start()>
	  <%=r.getString(teasession._nLanguage, "WelcomeToForum")%></marquee>
    </div>
  </div>
</body>
</html>

