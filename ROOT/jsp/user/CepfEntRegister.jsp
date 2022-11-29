<%@page contentType="text/html;charset=UTF-8"  %>
<!--
	中华环境保护基金会
	http://www.cepf.org.cn/
	 注册企业会员
	-->
<%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.resource.Resource r=new tea.resource.Resource();
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String trueName="",mailbox="",job="",address="",phone="",nation="",principal="",fax="",linkman="",state="";

int select=0;

String checkpsw="";

java.util.Calendar c= java.util.Calendar.getInstance();
c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);
java.util.Date birth=c.getTime();
if(request.getMethod().equals("POST"))
{
  String theName=null;
  tea.entity.member.Profile profile=null;
  if(teasession._rv==null)
  {
    theName=request.getParameter("theName");
    if(tea.entity.member.Profile.isExisted(theName))
    {
      out.print(new tea.html.Script("alert('这个用户名称已经有人注册，请重新输入！');history.back();"));
      return;
    }
    String password=request.getParameter("pswc");
    profile=tea.entity.member.Profile.create(theName,teasession._strCommunity,password);
  }else
  {
    theName=teasession._rv._strV;
    profile=tea.entity.member.Profile.find(teasession._rv._strV);
  }
  profile.setOrganization(request.getParameter("trueName"),teasession._nLanguage);
  profile.setState(request.getParameter("state"),teasession._nLanguage);
  profile.setFirstName(request.getParameter("linkman"),teasession._nLanguage);
  profile.setEmail(request.getParameter("mailbox"));
  profile.setJob(request.getParameter("job"),teasession._nLanguage);
  profile.setAddress(request.getParameter("address"),teasession._nLanguage);
  profile.setFax(request.getParameter("fax"),teasession._nLanguage);
  profile.setTelephone(request.getParameter("phone"),teasession._nLanguage);
  profile.setCountry(request.getParameter("nation"),teasession._nLanguage);
  tea.entity.member.ProfileCepf pc= tea.entity.member.ProfileCepf.find(theName);
  pc.setType(Integer.parseInt(request.getParameter("select")));
  pc.setEnterprise(true);
  pc.setPrincipal(request.getParameter("principal"));
  if(teasession._rv==null)
  {
    response.sendRedirect("/jsp/user/regsuccess.jsp?node="+teasession._nNode);
    return;
  }else
  out.print(new tea.html.Script("alert('修改成功');"));
}else
if(teasession._rv!=null)
{
   tea.entity.member.Profile profile=tea.entity.member.Profile.find(teasession._rv._strV);
   trueName= profile.getOrganization(teasession._nLanguage);
   linkman= profile.getFirstName(teasession._nLanguage);
   mailbox=profile.getEmail();
   job=profile.getJob(teasession._nLanguage);
   address=profile.getAddress(teasession._nLanguage);
   phone=profile.getTelephone(teasession._nLanguage);
   nation=profile.getCountry(teasession._nLanguage);
   birth=profile.getBirth();

   fax=profile.getFax(teasession._nLanguage);
   state=profile.getState(teasession._nLanguage);

   tea.entity.member.ProfileCepf pc=tea.entity.member.ProfileCepf.find(teasession._rv._strV);
   select=pc.getType();
   principal=pc.getPrincipal();
}else
{
     checkpsw="&&submitText(this.psw,'"+r.getString(teasession._nLanguage, "InvalidPassword")+"')&&submitEqual(this.psw,this.pswc,'"+r.getString(teasession._nLanguage, "InvalidConfirmPassword")+"')";
}
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="" onSubmit="return(submitMemberid(this.theName,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitText(this.trueName,'无效单位名称')<%=checkpsw%>&&submitEmail(this.mailbox,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitSelect(this.select,'无效会员级别'));">
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tbody>
      <tr>
        <td width="541" height="20" class="textread"><div align="center">单位会员注册</div></td>
      </tr>
      <tr>
        <td valign="top" width="541" class="text" align="center"><br>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td height="30">会员代号<font class=text2>**</font>：</td>
              <td height="30"><input name="theName"  <%if(teasession._rv!=null)out.print(" disabled value="+teasession._rv._strV);%> type="text" class=text id="theName3"  maxlength="12">
              </td>
              <td>单位名称<font class=text2>**</font>：</td>
              <td><input name="trueName" type="text" class=text id="trueName2" value="<%=trueName%>" maxlength="12"></td>
            </tr>
            <%if(teasession._rv==null){%>
            <tr>
              <td height="30">会员密码<font class=text2>**</font>：</td>
              <td height="30"><input name="psw" type="password" class=text id="psw3" maxlength="12"></td>
              <td>确认密码<font class=text2>**</font>：</td>
              <td><input name="pswc" type="password" class=text id="pswc" maxlength="12">
              </td>
            </tr>
            <%}%>
            <tr>
              <td height="30">Email<font class=text2>**</font>：</td>
              <td height="30"><input name="mailbox" type="text" class=text value="<%=mailbox%>" id="mailbox" maxlength="50">
              </td>
              <td>国家：</td>
              <td><input name="nation" type="text" class=text id="nation2" value="<%=nation%>" maxlength="10"></td>
            </tr>
            <tr>
              <td height="30">省/州：</td>
              <td height="30"><input name="state" type="password" class=text id="state2" value="<%=state%>" maxlength="20">
              </td>
              <td>单位负责人：</td>
              <td><input name=principal type=text class=text id="admin2" value="<%=principal%>" maxlength="12"></td>
            </tr>
            <tr>
              <td height="30">联系地址：</td>
              <td height="30"><input name="address" type="text" class=text id="address" value="<%=address%>" maxlength="30"></td>
              <td>会员级别<font class=text2>**</font>：</td>
              <td><select name=select size=1>
                  <option value="0" selected>---请选择---</option>
                  <option value="0" <%if(select==0&&teasession._rv!=null)out.print(" selected");%>>普通会员</option>
                  <option value="1" <%if(select==1)out.print(" selected");%>>VIP（贵宾）会员</option>
                  <option value="2" <%if(select==2)out.print(" selected");%>>理事会员</option>
                </select></td>
            </tr>
            <tr>
              <td height="30">联系电话：</td>
              <td height="30"><input name="phone" type="text" class=text id="phone2" value="<%=phone%>" maxlength="10"></td>
              <td>传真：</td>
              <td><input name="fax" type="text" class=text id="fax" value="<%=fax%>" maxlength="20"></td>
            </tr>
            <tr>
              <td height="30">联系人：</td>
              <td height="30"><input name=linkman type=text class=text id="linkman2" value="<%=linkman%>" maxlength="12"></td>
              <td>所属行业：</td>
              <td><input name=job type=text class=text id="job" value="<%=job%>" maxlength="20"></td>
            </tr>
          </table>
      <tr>
        <p align=center>
        <td align=center valign="bottom" width="541" class="text" height="40"><input class="text" name="goback" type=button value=返回 onClick="javascript:history.go(-1)">
&nbsp;&nbsp;&nbsp;&nbsp;
          <input class="text" name=regin type=submit value=提交>
&nbsp;&nbsp;&nbsp;&nbsp;
          <input class="text" name=B2 type=reset value=重写>
&nbsp;&nbsp;&nbsp;</td>
        <p></p>
      </tr>
    </tbody>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

