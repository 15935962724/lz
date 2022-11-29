<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1");
r.add("/tea/ui/node/type/sms/EditUser");

if(request.getMethod().equals("POST"))
{
  HttpSession httpsession = request.getSession(true);
  String vertify=(String)httpsession.getAttribute("sms.vertify");
  String vertify1 = request.getParameter("vertify").trim();
  String ConfirmPassword = request.getParameter("ConfirmPassword").trim();
  String EnterPassword = request.getParameter("EnterPassword").trim();


  if (!vertify1.equals(vertify)&&!vertify1.equals("vertify"))
  {
    response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError"),"UTF-8"));
    return;
  }
  String s1 = request.getParameter("MemberId").trim();//.toLowerCase();
  for(int index=0;index<s1.length();index++)
  if(s1.charAt(index)>='A'&&s1.charAt(index)<='Z')
  s1=s1.substring(0,index)+(char)(s1.charAt(index)+32)+ s1.substring(index+1);

  if(tea.entity.member.Profile.isExisted(s1) )
  {
    response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(teasession._nLanguage, "RepetitionRegisters"), s1),"UTF-8"));
    return;
  }
 tea.entity.member.Profile profile= tea.entity.member.Profile.create(s1,teasession._strCommunity,ConfirmPassword,null,null);
 String s5=request.getParameter("Email");
 profile.setEmail(s5);



 tea.entity.site.Community community=tea.entity.site.Community.find(teasession._nNode);
 String webn=community.getName(teasession._nLanguage);
 String web="http://"+request.getServerName()+":"+request.getServerPort()+"/servlet/Node?node="+teasession._nNode;
 String conent=s1+" 你好!<br>欢迎来到"+webn+"<a href="+web+">"+web+"</a><br>用户名:"+s1+"<br>密码:"+EnterPassword+"<br>注册时间:"+(new java.util.Date())+"<br/>本邮件为系统自动发送,请不要回复本邮件";

 //conent=new String(conent.getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]),"iso-8859-1");
 String str="注册"+webn;
 //str=new String(str.getBytes(tea.ui.TeaServlet.CHARSET[teasession._nLanguage]),"iso-8859-1");
 int k = 0;//tea.entity.member.Message.create(teasession._strCommunity, null, community.getEmail(), 0, 0, 2, 0, teasession._nLanguage, str, conent,null,null,"",null,s5,"", "", null, null, 0, 0);
 try
 {
   tea.service.Robot.activateRoboty(teasession._nNode,k);
 } catch (Exception _ex)
 {}
 response.sendRedirect("regsuccess.jsp?node="+teasession._nNode);

                   /************自动创建博客的首页节点***************/
                 /*  tea.entity.site.BLOGCommunity bc=tea.entity.site.BLOGCommunity.find(community._strCommunity);
                   teasession._nNode=tea.entity.node.Node.create(bc.getNode(),1,community._strCommunity,new tea.entity.RV(s1),0,0,false,0,0,teasession._nLanguage,null,null,teasession._nLanguage,s1+" BLOG",s1,"",null,"",0,null,"","","","",null);
                   tea.entity.node.Node.find(teasession._nNode).finished(teasession._nNode);
                   tea.entity.member.Profile.find(s1).setStartUrl("/servlet/Node?node="+teasession._nNode,teasession._nLanguage);

                   tea.entity.node.CssJs cssjs =tea.entity.node.CssJs.find(bc.getCssjs());
                   tea.entity.node.CssJs.create("",2,teasession._nNode,3,teasession._nLanguage,cssjs.getCss(teasession._nLanguage),cssjs.getJs(teasession._nLanguage),0);
                */
                   /*******************************/
                 //  response.sendRedirect("/servlet/Login?LoginType=0&LoginId="+s1+"&Password="+ConfirmPassword+"&node="+teasession._nNode+"&nexturl=/jsp/admin/Frame.jsp?node="+teasession._nNode);
            return;
}


String vertify=sms.password();
HttpSession httpsession = request.getSession(true);
//httpsession.setAttribute("sms.vertify" ,vertify);
 String s2 = request.getParameter("Node");
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
	%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/CnoocAreaCityDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
<script type="">

function submitSelect(obj,alerttext)
{
  if(obj.selectedIndex==0)
  {
    alert(alerttext);
    obj.focus();
    return false;
  }
  return true;
}
function readProtocol(button,bool)
{
button.disabled=!bool;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "WeblogRegister")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <%//=r.getString(teasession._nLanguage, "InfSignUp")%>
  <FORM name=foSignUp METHOD=POST ACTION="" onSubmit="return(submitMemberid(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&
    submitIdentifier(this.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&
    submitEqual(this.EnterPassword,this.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&
    submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
    <input type='hidden' name=NextUrl VALUE="EditUser.jsp">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=MemberId VALUE="" SIZE=20 MAXLENGTH=40>
          <input name="" onClick="if(submitIdentifier(foSignUp.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')) document.all['checkmember'].src='MemberIdExist.jsp?member='+foSignUp.MemberId.value;" value=检测是否存在 type="button">
        </td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</TD>
        <td><input type="password" class="edit_input"  name=EnterPassword VALUE="" SIZE=20 MAXLENGTH=16></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</TD>
        <td><input type="password" class="edit_input"  name=ConfirmPassword VALUE="" SIZE=20 MAXLENGTH=16></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "Validate")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=vertify VALUE="" SIZE=20 MAXLENGTH=20>
          <img alt="" src="validate.jsp"/></td>
      </tr>
      <tr>
        <td> 接受协议 </td>
        <td colspan="2"><input name="protocol" onClick="readProtocol(foSignUp.submit,this.checked)"  id="CHECKBOX" type="CHECKBOX" value="">
          我已阅读，并接受<a href="WeblogSignUp.jsp" onClick="window.open(this.href,'注册协议','width=770,height=500,top=80,left=20,toolbar=no,scrollbars=yes,menubar=no,location=no,status=yes,resizable=yes');return false;" >注册协议</a></td>
      </tr>
    </table>
    <input type="submit"  class="edit_button" id="edit_submit" name="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  注: <br/>
  用户ID格式只能是字母、数字或下划线，长度最小4位.
  <SCRIPT type="">
  readProtocol(foSignUp.submit,foSignUp.protocol.checked);
  document.foSignUp.MemberId.focus();</SCRIPT><div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <iframe src="" name="checkmember" width="0" height="0" />

</body>
</html>

