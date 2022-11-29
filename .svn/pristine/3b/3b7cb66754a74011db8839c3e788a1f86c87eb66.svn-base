<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r = new Resource();
  int id = 0;
  if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     id = Integer.parseInt(teasession.getParameter("id"));

String nexturl = request.getRequestURI()+"?"+request.getContextPath();
 StringBuffer sql = new StringBuffer();
  StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

String member = request.getParameter("member");
if(member!=null && member.length()>0)
{
  sql.append(" AND member like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}

String subject = request.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND subject like ").append(DbAdapter.cite("%"+subject+"%"));
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

int hidden = -1;
if(request.getParameter("hidden")!=null && request.getParameter("hidden").length()>0)
   hidden = Integer.parseInt(request.getParameter("hidden"));
if(hidden!=-1)
{
  sql.append(" AND node IN (SELECT node FROM Node WHERE hidden =").append(hidden).append(")");
  param.append("&hidden=").append(hidden);
}
param.append("&id=").append(id);
 int pos = 0, pageSize = 20, count = 0;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  count = Supply.count(teasession._strCommunity,sql.toString());

 sql.append(" order by id desc ");




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<script type="">
function f_aditing(igd)
{
   form1.sid.value = igd;
   form1.action ='/jsp/type/supply/SupplyAuditShow.jsp';
   form1.submit();
}
</script>
<h1>供求信息审核</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM name=form2 METHOD=get action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
       <td>用户名：<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
       <td>主题：<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
        <td>审核状态：
        <select name="hidden">
        <option value="-1" <%if(hidden==-1)out.print(" selected");%>>---------</option>
        <option value="0" <%if(hidden==0)out.print(" selected");%>>审核</option>
        <option value="1" <%if(hidden==1)out.print(" selected");%>>未审核</option>
        </select>
        </td>
        <td><input type="submit" value="查询"> </td>
    </tr>
    </table>
    </form>
<FORM name=form1 METHOD=POST action="?" onSubmit="return CheckForm();">
<input type="hidden" name="sid"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
       <td>添加用户</td>
       <td>供求信息主题</td>
       <td>添加时间</td>
       <td>审核状态</td>
       <td>操作</td>
    </tr>

  <%
  //java.util.Enumeration e = Node.find(sql.toString(),pos,pageSize);
  java.util.Enumeration e = Supply.find(teasession._strCommunity,sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print(" <tr><td colspan=10 align=center>暂无记录</td></tr>");
  }

  while (e.hasMoreElements())
  {
    int sid = ((Integer)e.nextElement()).intValue();

    Supply sobj = Supply.find(sid);
    Node nobj = Node.find(sobj.getNode());
  %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=sobj.getMember() %></td>
  <td><a href="/jsp/type/supply/SupplyShow.jsp?sid=<%=sid%>"> <%=sobj.getSubject()%></a></td>
  <td><%=sobj.getTimesToString() %></td>
  <td><%
    if(nobj.isHidden()){out.print("未审核");}
    else{out.print("审核通过");}
  %></td>
  <td><input type="button" value="审核" onclick="f_aditing('<%=sid%>');"/></td>
  </tr>
  <%} %>
<tr>
  <%if (count > pageSize) {  %>
    <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td>
  <%}  %>
  </tr>
  </table>

</FORM>





<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
