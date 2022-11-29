<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));

Adword obj = Adword.find(adword);

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

为广告命名 > 目标客户 > 制作广告 > 选择关键字 > 定价 > <b>审核与保存</b>
<div id="head6"><img height="6" src="about:blank"></div>
<br>


<form name="form1" action="/servlet/EditAdword" enctype="multipart/form-data">
<input type=hidden name=community value=<%=teasession._strCommunity%> >
<input type=hidden name=adword value=<%=adword%> >
<input type=hidden name=act value=editadwordconfirm >
<input type=hidden name=nexturl value="/jsp/adword/Adwords.jsp">

<h2>审核您的选择</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><h2>为广告命名</h2></td><td>[ <a href="/jsp/adword/EditAdwordName.jsp?community=<%=teasession._strCommunity%>&adword=<%=adword%>">修改</a> ]</td></tr>
<tr>
  <td>广告名称:</td>
  <td><%=obj.getName()%></td>
</tr>

<tr><td><h2>目标客户</h2></td><td>[ <a href="/jsp/adword/EditAdwordTarget.jsp?community=<%=teasession._strCommunity%>&adword=<%=adword%>">修改</a> ]</td></tr>
<tr>
  <td>您的客户位置:</td>
  <td><%=obj.getRegion()%>
<%
String region=obj.getRegion();
if("/".equals(region))
	out.print("所有地区");
else
{
	String s[]=region.split("/");
	for(int i=1;i<s.length;i++)
	{
		out.print(Card.find(Integer.parseInt(s[i])).getAddress()+"<br/>");
	}
}
%></td>
</tr>
<tr>
  <td>您的客户使用语言:</td>
  <td>
<%
String language=obj.getLanguage();
if("/".equals(language))
	out.print("所有语言");
else
{
	String s[]=language.split("/");
	for(int i=1;i<s.length;i++)
	for(int j=0;j<Adword.LANGUAGE_TYPE.length;j++)
	{
		if(Adword.LANGUAGE_TYPE[j][0].equals(s[i]))
		{
			out.print(Adword.LANGUAGE_TYPE[j][1]+"<br/>");
			break;
		}
	}
}
%>
  </td>
</tr>

<tr><td><h2>制作广告</h2></td><td>[ <a href="/jsp/adword/EditAdwordShow.jsp?community=<%=teasession._strCommunity%>&adword=<%=adword%>">修改</a> ]</td></tr>
<tr>
  <td>广告:</td>
  <td>
<table cellpadding="3" width="260" style="border:1px solid #b4d0dc;" cellspacing="0" border="0" >
  <tr>
    <td bgcolor="#ffffff" nowrap valign="bottom"><a href="<%=obj.getAdurl()%>" id="exampleUrl" target="google_popup" onclick="return HPU_helpPopUp(this, {target: &#39;google_popup&#39;, width: null, height: null})" ><font size="+0"><span id="example1"><%=obj.getAdtitle()%></span></font></a> <br>
      <span id="example2"><%=obj.getAdexplain1()%></span> <br>
      <span id="example3"><%=obj.getAdexplain2()%></span> <br>
      <font color="green" size="-1"><span id="example4"><%=obj.getAdshow()%></span></font><br></td>
  </tr>
</table>
<img src="<%=obj.getAdpic()%>" >
</td>
</tr>

<tr><td><h2>选择关键字</h2></td><td>[ <a href="/jsp/adword/EditAdwordKeywords.jsp?community=<%=teasession._strCommunity%>&adword=<%=adword%>">修改</a> ]</td></tr>
<tr>
  <td>关键字:</td>
  <td><%=obj.getKeyworlds().replaceAll("\r\n","<br/>")%></td>
</tr>

<tr><td><h2>定价</h2></td><td>[ <a href="/jsp/adword/EditAdwordPricing.jsp?community=<%=teasession._strCommunity%>&adword=<%=adword%>">修改</a> ]</td></tr>
<tr>
  <td>每日预算:</td>
  <td>¥<%=obj.getBudget()%></td>
</tr>
<tr>
  <td>每次点击费用出价:</td>
  <td>¥<%=obj.getBid()%></td>
</tr>
<tr>
  <td>截止日期:</td>
  <td><%=obj.getStoptimeToString()%></td>
</tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/EditAdwordPricing.jsp'" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"确认")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

