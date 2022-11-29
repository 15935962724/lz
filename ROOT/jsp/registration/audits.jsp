<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.Hotel_application" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv.toString()==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return ;
}
Community community =Community.find(teasession._strCommunity);
int id = 0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
    id = Integer.parseInt(request.getParameter("id"));

StringBuffer sql = new StringBuffer();
StringBuffer sql1 = new StringBuffer();

StringBuffer par=new StringBuffer("?");
par.append("&id=").append(id);
sql.append(" AND audit=0");
sql1.append(" AND audit=1");

String member = request.getParameter("member");
if (member != null && member.length() > 0) {
  sql1.append(" AND member like " + DbAdapter.cite("%" + member + "%"));
  par.append("&member=").append(java.net.URLEncoder.encode(member, "UTF-8"));
}
String comname = request.getParameter("comname");
if (comname != null && comname.length() > 0) {
sql1.append(" AND member IN(SELECT member FROM Profilelayer WHERE firstname like " + DbAdapter.cite("%" + comname + "%") + ")");
  par.append("&comname=").append(comname);
}
String mobile = request.getParameter("mobile");
if (mobile != null && mobile.length() > 0) {
sql1.append(" AND member IN(SELECT member FROM Profile WHERE mobile like " + DbAdapter.cite("%" + mobile + "%") + ")");
  par.append("&mobile=").append(mobile);
}
String type = request.getParameter("type");
if (type != null && type.length() > 0 && !("2".equals(type))) {
sql1.append(" AND manage_type="+type);
  par.append("&type=").append(type);
}

int count = Hotel_application.count(sql.toString());
int count1 = Hotel_application.count(sql1.toString());
int pos1=0,pos2=0,size=10;
if(request.getParameter("pos1")!=null)
{
  pos1 = Integer.parseInt(request.getParameter("pos1"));
}
if(request.getParameter("pos2")!=null)
{
  pos2 = Integer.parseInt(request.getParameter("pos2"));
}

sql.append(" ORDER BY times DESC ");
sql1.append(" ORDER BY times DESC ");

%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">


<title>audits</title>
<script type="">
function qx(mem){
if(confirm('确定取消其酒店管理者权限？'))
//window.open('/jsp/registration/qxjd.jsp?member='+mem,'anyname','width=500,height=200,top=300,left=400');
window.location.href='/jsp/registration/qxjd.jsp?member='+mem;
else
return false;
}
</script>
</head>
<body  id="bodynone">
<h1>酒店管理者审核</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<h2>待批准的申请( <%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td>用户姓名</td><td>公司名称</td><td>联系电话</td><td>申请类型</td><td>操作</td>
</tr>
  <%
  java.util.Enumeration  e = Hotel_application.find(sql.toString(),pos1,size);

  while(e.hasMoreElements())
  {
   Hotel_application hos = (Hotel_application) e.nextElement();
   Profile obj  = Profile.find(hos.getMember());
  %>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td><a href="/jsp/registration/ProfileView.jsp?member=<%=hos.getMember() %>"><%=hos.getMember() %></a></td>
   <td><%=obj.getFirstName(teasession._nLanguage) %>
    <input type="hidden" value="<%=obj.getFirstName(teasession._nLanguage) %>" name="firstname"/><!--酒店名称--></td>
   <td><%=obj.getMobile()%>
  <input type="hidden" value="<%=obj.getMobile()%>" name="telephone"/>
  <input type="hidden" value="<%=hos.getDocuments()%>" name="documents" />
  <input type="hidden" value="<%=hos.getIntroduce()%>" name="introduce" />
  </td>
<%
String managertype="";
int manager = hos.getManage_type();
if(manager==1)
{
  managertype = "酒店直营";
}
else
{
  managertype = "代理商";
}
%>
<td><%=managertype%></td>
<td><a href="/jsp/registration/audit.jsp?member=<%=java.net.URLEncoder.encode(hos.getMember(),"UTF-8")%>"> 审批 </a></td>
</tr>
<%}if(count>size){ %>
<tr><td colspan="10" align="center">
  <%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos1=",pos1,count,size)%></td></tr><%}%>
</table>
<h2>已批准的申请( <%=count1%> )</h2>
  <FORM name="form1" METHOD="POST" action="/jsp/registration/audits.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td>        用户姓名：
              <input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/>
              &nbsp;&nbsp;&nbsp;
              公司名称：
              <input type="text" name="comname" value="<%if(comname!=null)out.print(comname);%>"/>
              &nbsp;&nbsp;&nbsp;&nbsp;
                      联系电话：
              <input type="text" name="mobile" value="<%if(mobile!=null)out.print(mobile);%>"/>
              &nbsp;&nbsp;&nbsp;
              申请类型：
              <select name="type" >
              <option value="2">全部</option>
              <option value="1">酒店直营</option>
              <option value="0">代理商</option>
              </select>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" value=" GO "/>
            </td>
          </tr>
          </table><br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td>用户姓名</td><td>公司名称</td><td>联系电话</td><td>申请类型</td><td>操作</td>
</tr>
 <%
 java.util.Enumeration e1 = Hotel_application.find(sql1.toString(),pos2,size);
  while(e1.hasMoreElements())
  {
     Hotel_application yhos = (Hotel_application)e1.nextElement();
     Profile yobj = Profile.find(yhos.getMember());
 %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
 <td><a href="/jsp/registration/ProfileView.jsp?member=<%=yhos.getMember()%>"><%=yhos.getMember()%></a></td>
   <td><%=yobj.getFirstName(teasession._nLanguage)%></td>
   <td><%=yobj.getMobile()%></td>
   <%
   String managertype="";
   int manager = yhos.getManage_type();
     if(manager==1)
   {
     managertype = "酒店直营";
   }
   else if(manager==2)
   {
     managertype = "代理商";
   }
   %>
   <td><%=managertype%></td>
   <td>
        <input type="button" value="取消" onClick="qx('<%=yhos.getMember() %>');"/>
      </td>
 </tr>

<%}if(count1>size) {%>
<tr>
  <td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos2=",pos2,count1,size)%></td>
</tr><%} %>
</table>
</form>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
