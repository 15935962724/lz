<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.bpicture.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%
Http h=new Http(request);

TeaSession teasession =new TeaSession(request);

Resource r = new Resource("/tea/resource/Photography");

if("POST".equals(request.getMethod()))
{

  if(!h.get("verify").equalsIgnoreCase((String)session.getAttribute("sms.vertify")))
  {
    out.print("<script>parent.window.f_verify();</script>");
    return;
  }

  String member=h.get("MemberId");
  if(Profile.isExisted(member))
  {
    out.print("<script>parent.window.alert('该会员名已被使用。')</script>");
    return;
  }

  Profile.create(member,h.get("EnterPassword"),h.community,h.get("email"),request.getServerName());
  Profile p=Profile.find(member);
  p.setMembertype(0);
  p.setFirstName(h.get("firstname"),h.language);
  boolean sex = false;
  if(h.getInt("sex")==2)
  {
	  sex = true;
  }
  p.setSex(sex);
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
  Date birthyear =null;
	 if(h.get("BirthYear")!=null && h.get("BirthYear").length()>0)
	 {
	      birthyear = sdf.parse(h.get("BirthYear") + "-" +h.get("BirthMonth") + "-" + h.get("BirthDay"));
	 }
	p.setBirth(birthyear);
	p.setTelephone(h.get("telephone "),h.language);
	p.setMobile(h.get("mobile"));
	p.setAddress(h.get("address"),h.language);
	p.setPinyin(h.get("pinyin"));

	String wv [] = teasession.getParameterValues("woid");
	StringBuffer sp = new StringBuffer();
	if(wv!=null)
	{
		for(int i=0;i<wv.length;i++)
		{
			sp.append(wv[i]).append("/");
		}
		p.setWoid("/"+sp.toString());
	}



  session.setAttribute("tea.RV",new RV(member));
  out.print("<script>window.alert('会员注册成功！');window.open('"+h.get("nexturl")+"','_parent')</script>");
  return;

}

String member=h.get("member");

Profile p=Profile.find(member);


%>

<html>
<head>
<title><%=r.getString(teasession._nLanguage,"9203379366") %></title><!-- 用户注册 -->
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>会员详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="frmsrch" method="POST" action="?"  target="_ajax" >
<input type="hidden" name="nexturl" value="/html/folder/2345900-1.htm" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="DxEditMember"/>


<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td  align="right">道号/昵称：<td><%=member%></td>
  </tr>
  <tr>
    <td align="right">姓名：</td>
    <td><%=p.getName(h.language)%></td>
  </tr>
<tr>
  <td align="right">性别：</td>
  <td><%=p.isSex()?"女士":"先生"%></td>
</tr>
<tr>
  <td align="right">出生日期：</td>
  <td><%=MT.f(p.getBirth())%></td>
</tr>
<tr>
  <td nowrap align="right">电话：</td>
  <td><%=p.getTelephone(h.language)%></td>
</tr>
<tr>
  <td align="right">手机：</td>
  <td><%=p.getMobile()%></td>
</tr>
<tr>
  <td align="right">E-mail：</td>
  <td><a href="mailto:<%=p.getEmail()%>"><%=p.getEmail()%></a></td>
</tr>
<tr>
  <td nowrap align="right">所在地：</td>
  <td><%=p.getAddress(h.language)%></td>
</tr>
<tr>
  <td nowrap align="right">行业：</td>
  <td><%=MT.f(p.pinyin)%></td>
</tr>
<tr>
  <td nowrap align="right">关注：</td>
  <td>
  <%
  String[] arr=MT.f(p.getWoid(),"/").split("/");

  for(int i=0;i<(arr.length-1);i++)
  {
    out.print(Profile.WOID_TYPE[i]+"、");
  }
  %>
 </td>
  <tr>
    <td align="right">登陆次数：</td>
    <td colspan="3"><%=Logs.count(member,1)%></td>
  </tr>

  <tr>
    <td align="right">注册时间：</td>
    <td colspan="3"><%=MT.f(p.getTime(),1)%></td>
  </tr>
</table>

<input type="button" value="返回" onclick="history.back()">
</form>

</body>
</html>
