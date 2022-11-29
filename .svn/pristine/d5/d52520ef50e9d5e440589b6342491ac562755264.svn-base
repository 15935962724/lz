<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.io.*" %><%@page import="tea.db.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);

int lang=teasession._nLanguage;
if("POST".equals(request.getMethod()))
{
  String member=h.get("member"),newm=h.get("newmember");
  String pwd=h.get("password"),email=h.get("email");
  if(newm!=null)
  {
    if(Profile.isExisted(newm))
    {
      out.print("<script>alert('“"+newm+"”会员名已存在！');history.go(-1);</script>");
      return;
    }else
    {
      Profile.create(newm,pwd,h.community,email,request.getServerName());
    }
    member=newm;
  }
  Profile p=Profile.find(member);
  p.setPassword(pwd);
  p.setEmail(email);
  p.setFirstName(h.get("name"),lang);
  p.setPinyin(h.get("pinyin"));
  p.setCreditcard(h.get("creditcard").replace(" ",""));
  p.setSex(h.getBool("sex"));
  p.setBirth(h.getDate("birth"));
  p.setCountry(h.get("country"),lang);
  p.setCard(h.get("card"));
  p.setCardType(h.getInt("cardtype"));
  p.setFamst(h.getInt("famst"));
  p.setDegree(h.get("degree"),lang);
  p.setPAddress(h.get("paddress"),lang);
  p.setPTelephone(h.get("ptelephone"),lang);
  p.setOrganization(h.get("organization"),lang);
  p.setAddress(h.get("address"),lang);
  p.setOrgnature(h.getInt("orgnature"));
  p.setJob(h.get("job"),lang);
  p.setFunctions(h.get("functions"),lang);
  p.setZip(h.get("zip"),lang);
  p.setTelephone(h.get("telephone"),lang);
  p.setFax(h.get("fax"),lang);
  p.setMobile(h.get("mobile"));
  p.setClub(h.get("club"),lang);
  ProfileGolf.set(member,h.getInt("golgage"),h.getInt("results"),h.get("oldsys"),h.getFloat("oldindex"),h.get("oldmember"));
  out.print("<script>alert('信息修改成功!');history.go(-2);</script>");
  return;
}
String member=MT.f(h.key);
Profile p=Profile.find(member);
ProfileGolf pg=ProfileGolf.find(member);

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>会员添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST" onsubmit="return this.member||submitText(this.newmember,'会员号不能为空!')&&submitText(this.password,'密码不能为空!')&&submitText(this.name,'姓名不能为空!')&&submitText(this.creditcard,'信用卡号不能为空!')">
<table id="tablecenter">
<tr><td>*差点会员号：</td><td>
<%
if(member!=null&&member.length()>0)
{
  out.print("<input name='member' value='"+member+"' style='background-color:#CCCCCC' readonly='' />");
}else
{
  out.print("<input name='newmember' mask='exists' alt='minfo' /><script>form1.newmember.focus();</script>");
}
%>
<span id="minfo"></span><td>*密码：</td><td><input type="password" name="password" value="<%=p.getPassword()%>" /></tr>
<tr><td>*姓名（中文）：</td><td><input name="name" value="<%=p.getName(lang)%>" /><td>姓名拼音/英文：</td><td><input name="pinyin" value="<%=p.pinyin%>" /></tr>
<tr><td>*差点信用卡号：</td><td><input name="creditcard" value="<%=p.getCreditcard()%>" /><td>性别：</td><td><input name="sex" type="radio" checked="checked" value="true" />男 <input name="sex" type="radio" <%if(!p.isSex())out.print(" checked='' ");%> value="false" />女</tr>
<tr><td>出生日期：</td><td><%=new tea.htmlx.TimeSelection("birth", p.getBirth())%><td>国籍：</td><td><input name="country" value="<%=p.getCountry(lang)%>" /></tr>
<tr><td>证件名称：</td><td><select name="cardtype"><%=h.options(Profile.CARD_TYPE,p.getCardType())%></select>
<td>证件号码：</td><td><input name="card" value="<%=p.getCard()%>" /></tr>
<tr><td>婚姻状况：</td><td><select name="famst"><%=h.options(Common.FAMST_TYPE,p.getFamst())%></select><td>教育程度：</td><td><input name="degree" value="<%=p.getDegree(lang)%>" /></tr>
<tr><td>住宅地址：</td><td><input name="paddress" value="<%=p.getPAddress(lang)%>" /><td>住宅电话：</td><td><input name="ptelephone" value="<%=p.getPTelephone(lang)%>" /></tr>
<tr><td>公司名称：</td><td><input name="organization" value="<%=p.getOrganization(lang)%>" /><td>公司地址：</td><td><input name="address" value="<%=p.getAddress(lang)%>" /></tr>
<tr><td>公司性质：</td><td><select name="orgnature"><%=h.options(Profile.ORG_NATURE,p.orgnature)%></select><td>现任职务：</td><td><input name="job" value="<%=p.getJob(lang)%>" /></tr>
<tr><td>业务性质：</td><td><input name="functions" value="<%=p.getFunctions(lang)%>" /><td>邮编：</td><td><input name="zip" value="<%=p.getZip(lang)%>" /></tr>
<tr><td>公司电话：</td><td><input name="telephone" value="<%=p.getTelephone(lang)%>" /><td>公司传真：</td><td><input name="fax" value="<%=p.getFax(lang)%>" /></tr>
<tr><td>移动电话：</td><td><input name="mobile" value="<%=p.getMobile()%>" /><td>电子邮箱：</td><td><input name="email" value="<%=p.getEmail()%>" /></tr>
<tr><td>高尔夫打球年限：</td><td><select name="golgage"><%=h.options(ProfileGolf.GOLF_AGE,pg.golfage)%></select><td>总杆最好成绩：</td><td><input name="results" value="<%=pg.results%>" mask="int" /></tr>
<tr><td>球会名称：</td><td><input name="club" value="<%=p.getClub(lang)%>" /><td>原有差点系统名称：</td><td><input name="oldsys" value="<%=pg.oldsys%>" /></tr>
<tr><td>原有差点指数：</td><td><input name="oldindex" value="<%=pg.oldindex%>" mask="float" /><td>原差点系统会员号：</td><td><input name="oldmember" value="<%=pg.oldmember%>" /></tr>
</table>
<!-- <td>是否是球会会员：</td><td><input name="club" value="" />  <td>是否加入过其它差点系统：</td><td><input name="soldsys" value="" />-->
<input type="submit" value="提交" />
<input type="button" value="返回" onclick="history.back();" />
</form>
</body>
</html>
