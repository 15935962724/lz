<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.Properties" %>
<%@page import="java.io.File" %><%@page import="tea.resource.Resource" %><%@page import="java.io.FileInputStream" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

//TeaSession teasession=new TeaSession(request);
Http h=new Http(request);

String vertify=(String)session.getAttribute("sms.vertify");
String vertify1 = h.get("vertify").trim();

Resource r = new Resource("/tea/ui/node/type/sms/EditUser");

if (!vertify1.equals(vertify)&&!vertify1.equals("vertify"))
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(h.language, "ConfirmCodeError")+"<a href=\"javascript:history.back();\">"+r.getString(h.language, "Tautology")+"</A>","UTF-8"));
  return;
}

String s1 = h.get("MemberId").trim().toLowerCase();

//验证邮箱,是否存在.
boolean regmail=Boolean.parseBoolean(h.get("regmail"));
if(regmail)
{
  String domain=h.get("domain");
  Vpopmail vpopmail=Vpopmail.find(s1,domain);
  if(vpopmail.isExists())
  {
    response.sendRedirect( "/jsp/info/Alert.jsp?community="+h.community+"&info="+ java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(h.language, "RepetitionRegisters"), s1),"UTF-8"));
    return;
  }
  s1=s1+"@"+domain;
}

if(Profile.isExisted(s1))
{
  response.sendRedirect( "/jsp/info/Alert.jsp?community="+h.community+"&info="+ java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(h.language, "RepetitionRegisters"), s1),"UTF-8"));
  return;
}
String act = h.get("act");

String password = h.get("ConfirmPassword").trim();
String firstname = h.get("FirstName");
String lastname = h.get("LastName");
String email = h.get("Email").trim();
String organization = h.get("Organization");
String address = h.get("Address");
String city = h.get("City");
String state = h.get("State");
String zip = h.get("Zip");
String country = h.get("Country");
String phone1="",phone2="";
if(h.get("Telephone1")!=null)
  phone1=h.get("Telephone1");
if(h.get("Telephone2")!=null)
  phone2=h.get("Telephone2");
//手机
String mobile= h.get("Mobile");
String s12 = phone1+"-"+phone2;
String fax = h.get("Fax");
java.util.Date birth=null;
try
{
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd");
  birth=sdf.parse(h.get("BirthYear")+"-"+h.get("BirthMonth")+"-"+h.get("BirthDay"));
}catch(java.lang.Exception e)
{}
String s14 = h.get("WebPage");
String s15 = h.get("PhoneNumber");
String question = h.get("Question","");
String answer = h.get("Answer","");
int j = h.get("AddressTPublic") != null ? 1 : 0;

if("profile9000".equals(act))//注册并激活印象卡信息页
{
  String code=h.get("code").replaceAll(" ","");
  String cp=(String)session.getAttribute("activation."+code);
  Profile9000 p9=Profile9000.find(code);
  if(p9.isExists()&&(p9.getMember()==null||p9.getMember().length()<1)&&p9.getPassword().equals(cp))
  {
    p9.setMember(s1);
  }else
  {
    response.sendRedirect("/jsp/user/9000_ActivationError.jsp?community="+h.community+"&node="+h.node);
    return;
  }
}



Community community=Community.find(h.community);

///Profile.create(s1,password,community._strCommunity, birth, j, 1, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14,s15);
Profile.create(s1,password,community._strCommunity,email, birth, j, 1, firstname, lastname, organization, address, city, state, zip, country, s12, fax, s14, s15);


if(regmail)
{
  int i=s1.indexOf("@");
  Vpopmail.create(community.getSmtp(),s1.substring(0,i),s1.substring(i+1),password);
}

Profile profile=Profile.find(s1);
profile.setSex("1".equals(h.get("sex")));
profile.setCard(h.get("card"));
if(question.length()>0){
	profile.set(question,answer);
}
profile.setMobile(mobile);

String web=community.getWebName();

BBS.send(h, profile);




/*
String webn=community.getName(h.language);
String conent=s1+" 你好!<br>欢迎来到"+webn+"<a href="+web+">"+web+"</a><br>用户名:"+s1+"<br>密码:"+EnterPassword+"<br>注册时间:"+(new java.util.Date())+"<br/>本邮件为系统自动发送,请不要回复本邮件";
// conent=new String(conent.getBytes());

conent=new String(conent.getBytes(tea.ui.TeaServlet.CHARSET[h.language]),"iso-8859-1");
String str="注册"+webn;
str=new String(str.getBytes(tea.ui.TeaServlet.CHARSET[h.language]),"iso-8859-1");
int k = tea.entity.member.Message.create(null, community.getEmail(), 0, 0, 2, 0, h.language, str, conent,null,null,"",null,s5,"", "", null, null, 0, 0);
try
{
   tea.service.Robot.activateRoboty(h.node,k);
} catch (Exception _ex)
{}
*/

//注册成功后,登陆  暂时注释,和www.bwxw.com有冲突
//RV rv = new RV(profile.getMember());
//Log.create(h.community, rv, 1, h.node, request.getRemoteAddr());
//OnlineList ol_obj = OnlineList.find(session.getId());
//ol_obj.setMember(profile.getMember());
//session.setAttribute("tea.RV", rv);


if("profile9000".equals(act))//注册并激活印象卡信息页
{
  response.sendRedirect("9000_ActivationOk.jsp?node="+h.node);
}else
{
  response.sendRedirect("/jsp/user/regsuccess2.jsp?node="+h.node);
}


%>

