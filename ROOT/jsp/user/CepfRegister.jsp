<%@page contentType="text/html;charset=UTF-8"  %>
<!--
	中华环境保护基金会
	http://www.cepf.org.cn/
	 注册会员
	-->
<%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.resource.Resource r=new tea.resource.Resource();
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String trueName="",mailbox="",job="",idnumber="",address="",phone="",nation="";
boolean sex=true;
String edu=null;
int idtype=0,select=0;

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
  profile.setFirstName(request.getParameter("trueName"),teasession._nLanguage);
  profile.setSex(Boolean.getBoolean(request.getParameter("sex")));
  profile.setBirth(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("BirthYear")+"-"+request.getParameter("BirthMonth")+"-"+request.getParameter("BirthDay")));
  profile.setEmail(request.getParameter("mailbox"));
//  profile.setDegree(Integer.parseInt(request.getParameter("edu")),teasession._nLanguage);
  profile.setJob(request.getParameter("job"),teasession._nLanguage);
  profile.setCardType(Integer.parseInt(request.getParameter("idtype")));
  profile.setCard(request.getParameter("idnumber"));
  profile.setAddress(request.getParameter("address"),teasession._nLanguage);
  profile.setTelephone(request.getParameter("phone"),teasession._nLanguage);
  profile.setCountry(request.getParameter("nation"),teasession._nLanguage);
  tea.entity.member.ProfileCepf.find(theName).setType(Integer.parseInt(request.getParameter("select")));
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
   trueName= profile.getFirstName(teasession._nLanguage);
   mailbox=profile.getEmail();
   job=profile.getJob(teasession._nLanguage);
   idnumber=profile.getCard();
   address=profile.getAddress(teasession._nLanguage);
   phone=profile.getTelephone(teasession._nLanguage);
   nation=profile.getCountry(teasession._nLanguage);
   birth=profile.getBirth();
//   edu=profile.getDegree(teasession._nLanguage);
   select= tea.entity.member.ProfileCepf.find(teasession._rv._strV).getType();


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
  <form name="form1" method="post" action="" onSubmit="return(submitMemberid(this.theName,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')<%=checkpsw%>&&submitEmail(this.mailbox,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitSelect(this.select,'会员级别'));">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tbody>
              <tr>
                <td width="541" height="20" class="textread"><div align="center">个人会员注册</div></td>
              </tr>
              <tr>
                <td valign="top" width="541" class="text" align="center"><br>
                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                    <tr>
                      <td width="100" height="30">会员代号<font class=text2>**</font>：</td>
                      <td><input name="theName" <%if(teasession._rv!=null)out.print(" disabled value="+teasession._rv._strV);%> type="text" class=text id="theName2" maxlength="12"></td>
                      <td height="30">真实姓名：</td>
                      <td><input name="trueName" type="text" class=text id="trueName" value="<%=trueName%>" maxlength="12"></td>
                    </tr>
                    <%if(teasession._rv==null){%>
                    <tr>
                      <td width="100" height="30">会员密码<font class=text2>**</font>：</td>
                      <td><input name="psw" type="password" class=text id="psw" maxlength="12"></td>
                      <td width="100" height="30">确认密码<font class=text2>**</font>：</td>
                      <td><input name="pswc" type="password" class=text id="pswc3" maxlength="12"></td>
                    </tr>
                    <%}%>
                  </table>
                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                    <tr>
                      <td width="100" height="30">性别<font class=text2>**</font>：</td>
                      <td><input  id="radio" type="radio" name="sex" value="true" checked="checked" >
                        男
                        <input  id="radio" type="radio" name="sex" value="false" <%if(!sex)out.print("checked");%>>
                        女 </td>
                    </tr>
                    <tr>
                      <td height="30">出生日期<font class=text2>**</font>：</td>
                      <td><%
                      out.print(new tea.htmlx.TimeSelection("Birth",birth));
                      %>
                      </td>
                    </tr>
                  </table>
                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                    <tr>
                      <td width="100" height="30">Email<font class=text2>**</font>：</td>
                      <td height="30"><input name="mailbox" type="text" class=text id="mailbox2" value="<%=mailbox%>" maxlength="50">
                      </td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="100" height="30">文化程度：</td>
                      <td height="30"><%=new tea.htmlx.DegreeSelection("edu",edu)%></td>
                      <td width="100">从事职业：</td>
                      <td><input name="job" type="text" class=text id="job2" maxlength="20" value="<%=job%>"></td>
                    </tr>
                    <tr>
                      <td width="100" height="30">证件类别：</td>
                      <td height="30"><%=new tea.htmlx.CardSelection("idtype",idtype) %> </td>
                      <td>证件号码：</td>
                      <td><input name=idnumber type=text maxlength="20" class=text value="<%=idnumber%>"></td>
                    </tr>
                    <tr>
                      <td width="100" height="30">联系地址：</td>
                      <td height="30"><input name="address" type="text" class=text id="address2"  value="<%=address%>" maxlength="50"></td>
                      <td>会员级别<font class=text2>**</font>：</td>
                      <td><select name=select size=1>
                          <option value="0" selected>---请选择---</option>
                          <option value="0"<%if(select==0&&teasession._rv!=null)out.print(" selected");%>>普通会员</option>
                          <option value="1" <%if(select==1)out.print(" selected");%>>VIP（贵宾）会员</option>
                          <option value="2"<%if(select==2)out.print(" selected");%>>理事会员</option>
                        </select></td>
                    </tr>
                    <tr>
                      <td width="100" height="30">联系电话：</td>
                      <td height="30"><input name="phone" type="text" class=text id="phone" value="<%=phone%>" maxlength="10">
                      </td>
                      <td>国籍：</td>
                      <td><input name="nation" type="text" class=text id="nation3" value="<%=nation%>" maxlength="10"></td>
                    </tr>
                  </table>
              <tr>
                <p align=center>
                <td align=center valign="bottom" width="541" class="text" height="40"><input class="text" name="goback" type=button value=返回 onClick="javascript:history.go(-1)">
&nbsp;&nbsp;&nbsp;&nbsp;
                  <input class="text" name=regin type=submit value=提交>
&nbsp;&nbsp;&nbsp;&nbsp;
                  <input class="text"  name=B2 type=reset value=重写>
&nbsp;&nbsp;&nbsp;</td>
                <p></p>
              </tr>
            </tbody>
          </table>
  </form>
 <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

