<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%><%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/jsp/info/Succeed.jsp";
}
String community=request.getParameter("community");
String name=null,fullname=null;
int productid=0;
java.util.Date invalidtime=null;

if(request.getMethod().equals("POST"))
{
  fullname=request.getParameter("fullname");
  productid=Integer.parseInt(request.getParameter("productid"));
  invalidtime=NetdiskEnterprise.sdf.parse(request.getParameter("invalidtimeYear")+"-"+request.getParameter("invalidtimeMonth")+"-"+request.getParameter("invalidtimeDay"));
  NetdiskEnterprise.create(community,fullname,productid,invalidtime);
  response.sendRedirect(nexturl);
  return;
}



if(community!=null)
{
  NetdiskEnterprise obj = NetdiskEnterprise.find(community);
  fullname=obj.getFullname();
  productid=obj.getProductid();

  Community community_obj = Community.find(community);
  name=community_obj.getName(teasession._nLanguage);
}


%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/tea/CssJs/<%=(community!=null)?community:"Home"%>.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="document.form1.name.focus();">
<h1>企业管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="<%=request.getRequestURI()%>" method="post" onsubmit="return submitText(this.community,'无效-企业标识.')&&submitText(this.fullname,'无效-企业全名.');">
<input type="hidden" name="act" value="EditCommunity">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<TABLE id="tablecenter">
<tr><td>企业标识:</td><td>
  <%

  if(community!=null)
  out.print(community+"<input type=hidden name=community value="+community+" >");
  else
  {
    out.print("<select name=community >");
    ArrayList al=Community.find("",0,10000);
    for(int i=0;i<al.size();i++)
    {
      Community tt=(Community)al.get(i);
      out.print("<option value="+tt.community);
      out.print(" >"+tt.community);
    }
    out.print("</select>");
//    out.print("<input name=community type=text>");
  }
  %>
</td></tr>
<tr>
  <td>企业名称:</td>
<td><input name="name" type="text" value="<%if(name!=null)out.print(name);%>" size="30"></td></tr>
<tr>
  <td>企业全名:</td><td><input name="fullname" type="text" id="fullname" value="<%if(fullname!=null)out.print(fullname);%>" size="50"></td></tr>
<tr>
  <td>业务套餐编号:</td><td>
  <select name="productid" id="productid">
    <option value="100" selected>100MB</option>
    <option value="300"<%if(300==productid)out.print(" selected ");%>>300MB</option>
    <option value="1000"<%if(1000==productid)out.print(" selected ");%>>1000MB</option>
    <option value="5000"<%if(5000==productid)out.print(" selected ");%>>5000MB</option>
    </select>
    </td></tr>
  <tr><td>有效期:</td>
  <td><%=new tea.htmlx.TimeSelection("invalidtime", invalidtime)%></td>
  </tr>
</table>
<input type="submit" value="提交"><input type="button" value="返回" onClick="history.back();">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

