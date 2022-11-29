<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r=new Resource();
String memberid =request.getParameter("memberid");
if(request.getParameter("delete")!=null && request.getParameter("delete").length()>0)
{

  if(memberid!=null)
  {
    Profile obj = Profile.find(memberid);
    //obj.setpwd();
    obj.setPassword("");
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode("密码清除成功","UTF-8")+"&nexturl=/jsp/csvclub/csvmember/Csvmembers_2.jsp");
    return;

  }
}

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
String members = request.getParameter("members");

if(members!=null && members.length()>0)
{

  sql.append(" and member like '%"+members+"%'");
  param.append("&member="+java.net.URLEncoder.encode(members,"UTF-8"));
}

String membernumber = request.getParameter("membernumber");
if(membernumber!=null && membernumber.length()>0)
{
  sql.append(" and membernumber like '%"+membernumber+"%'");
  param.append("&membernumber="+java.net.URLEncoder.encode(membernumber,"UTF-8"));
}

String firstname = request.getParameter("firstname");
if(firstname!=null && firstname.length()>0)
{
  sql.append(" and  member in (select member from ProfileLayer where firstname like '%"+firstname+"%')");
  param.append("&member in (select member from ProfileLayer where firstname like '%"+java.net.URLEncoder.encode(firstname,"UTF-8")+"%')");
}


//int mtype = 0;
//if(request.getParameter("mtype")!=null && request.getParameter("mtype").length()>0)
//{
//  mtype = Integer.parseInt(request.getParameter("mtype"));
//  sql.append(" and member in  (select member from ProfileCsv where membertype="+mtype+")");
//  param.append("&membertype="+mtype);
//}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=Profile.countByCommunity(teasession._strCommunity,sql.toString());



String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);


%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <body>
  <script>
  function sub(s)
  {

    currentPos = "show";
    send_request("/jsp/csvclub/Csv_ajax.jsp?no=no&s="+s);

  }
  </script>
  <h1>文章列表</h1>
  <br>
  <div id="head6"><img height="6"></div>
<form method="POST" action="" name="form2">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type=hidden name="csvservice" value="0"/>
<input type=hidden name="action" value="Csvmembers_2">
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<h2>列表（4）</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1" ></td>
    <td nowrap>标题</td>
    <td>作者</td>
    <td>时间</td>
  </tr>
  <tr>
  <td></td>
  <td>血统证书申请，都需要什么条件?<font color="red">[置顶]</font></td>
  <td>明月皓天</td>
  <td>2007-02-15</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr">
    <td nowrap width="1" ></td>
    <td nowrap>标题</td>
    <td>内容</td>
    <td>时间</td>
    <td>作者</td>
 </tr>
<tr>
<td>1</td>
  <td>回复的主题：血统证书申请，都需要什么条件?<font color="red">[置顶]</font></td>
  <td>内容：血统证书就是血统的证书</td>
  <td>时间：2007-02-15</td>
  <td>金庸</td>
  </tr>
  <tr>
<td>2</td>
  <td>回复的主题：血统证书申请，都需要什么条件?<font color="red">[置顶]</font></td>
  <td>内容：楼上的你那也叫解释啊！</td>
  <td>时间：2007-02-15</td>
  <td>罗贯中</td>
  </tr>
  <tr>
<td>3</td>
  <td>回复的主题：血统证书申请，都需要什么条件?<font color="red">[置顶]</font></td>
  <td>内容：不和你们贫了</td>
  <td>时间：2007-02-15</td>
  <td>郭德纲</td>
  </tr>
  <tr>
<td>4</td>
  <td>回复的主题：血统证书申请，都需要什么条件?<font color="red">[置顶]</font></td>
  <td>内容：杠杠的</td>
  <td>时间：2007-02-15</td>
  <td>范伟</td>
  </tr>

</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>回复</td><td><textarea cols="60" rows="6"></textarea></td>
</tr>
<tr><td colspan="2" align="center"><input type="submit" value="提交" name=""  align="middle"/><input type="button" value="返回" onclick="window.history.back();"></td></tr>
</table>
</form>
<br>
<div id="head6"><img height="6"></div>
  </body>
</html>
