<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
if(request.getMethod().equals("POST"))
{
  String name=request.getParameter("name");
  if(request.getParameter("delete")!=null)
  {
     Msntemp obj=Msntemp.find(name);
     obj.delete();
  }else
  {
    String password=request.getParameter("password");
    if(Integer.parseInt(request.getParameter("msntemp"))==0)
    {
      Msntemp.create(community,name,password);
    }else
    {
      Msntemp obj = Msntemp.find(name);
      obj.set(password);
    }
    response.sendRedirect(request.getParameter("nexturl"));
    return;
  }
}
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body onload="form1.name.focus();">
<h1>访客账号</h1>
<div id="head6"><img height="6" src="about:blank" alt="">
</div>

<form name="form1" method="post" action="?" onsubmit="">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type="hidden" name="msntemp" value="0"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td width="1">&nbsp;</td>
<td><%=r.getString(teasession._nLanguage,"Name")%></td>
<td><%=r.getString(teasession._nLanguage,"Password")%></td>
<td>状态</td>
<td>客服</td>
<td>IP</td>
<td>上次发送时间</td>
<td>&nbsp;</td>
</tr>
<%
java.util.Enumeration enumer=Msntemp.findByCommunity(community);
for(int i=1;enumer.hasMoreElements();i++)
{
  String name=(String)enumer.nextElement();
  Msntemp obj=Msntemp.find(name);
  boolean fln="FLN".equals(obj.getStatus());
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><%=i%></td>
  <td><%=obj.getName()%></td>
  <td><%=obj.getPassword()%></td>
  <td><%=fln?"离线":"在线"%></td>
  <td>&nbsp;<%if(!fln)out.print(obj.getService());%></td>
  <td>&nbsp;<%if(!fln)out.print(obj.getIp());%></td>
  <td><%=obj.getTime()%></td>
  <td>
    <input type="button" onclick="form1.msntemp.value='21721';form1.name.value='<%=obj.getName()%>';form1.password.value='<%=obj.getPassword()%>';form1.name.style.color='#999999';form1.password.focus();" value="<%=r.getString(teasession._nLanguage,"Edit")%>">
    <input name="delete" type="submit" value="<%=r.getString(teasession._nLanguage,"Delete")%>" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form1.name.value='<%=obj.getName()%>';return true;}else return false;"></td>
</tr>
<%}%>
 </table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>用户名:</td><td><input name="name"  onkeydown="onfocus();"  onfocus="if(this.style.color=='#999999')form1.password.focus();"  type="text" id="name" size="40"></td>
  <td>密码:</td><td><input name="password" type="text" id="password" size="40"></td>
</tr>
</table>
<input type="submit" onclick="return submitEmail(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>');" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank" alt=""></div><br>
<a href="https://accountservices.passport.net/reg.srf" target="_blank">注册新的MSN账号</a>
</body>
</html>
