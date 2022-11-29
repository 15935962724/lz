<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword=Integer.parseInt(request.getParameter("adword"));

Resource r=new Resource();

StringBuffer param=new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
//param.append("&member=").append(teasession._rv._strR);

StringBuffer sql=new StringBuffer();

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String from=request.getParameter("from");
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(from));
  param.append("&from=").append(java.net.URLEncoder.encode(from,"UTF-8"));
}

String to=request.getParameter("to");
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<").append(DbAdapter.cite(to));
  param.append("&to=").append(java.net.URLEncoder.encode(to,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=AdwordClick.count(adword,sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>广告点击管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>时间:<input name="from" value="<%if(from!=null)out.print(from);%>" ><a href=### onclick="javascript:showCalendar('form1.from');"><img src=/tea/image/public/Calendar2.gif></a>
               -<input name="to" value="<%if(to!=null)out.print(to);%>" ><a href=### onclick="javascript:showCalendar('form1.to');"><img src=/tea/image/public/Calendar2.gif></a>
       </td>
       <td><input type="submit" value="查询"/></td></tr>
</table>
</form>

<FORM name=form2 METHOD=get action="/servlet/EditAdword" onSubmit="">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>

<h2>列表( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap>
         <%
         if("ip".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >IP "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=ip&"+param.toString()+" >IP</a>");
         }
         %></td>
         <TD nowrap><%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >时间 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time&"+param.toString()+" >时间</a>");
         }
         %></TD>
         <td></td>
       </tr>
<%

java.util.Enumeration enumer=AdwordClick.find(adword,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  AdwordClick obj=AdwordClick.find(id);
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=id%></td>
  <td><%=obj.getIp()%>/<%=NodeAccessWhere.findByIp(obj.getIp())%></td>
  <td><%=obj.getTimeToString()%></td>
 </tr>
<%
}
%>
</table>
<!--
<input type="submit" value="<%=r.getString(teasession._nLanguage,"暂停")%>" onClick="form2.status.value=2;">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"恢复")%>" onClick="form2.status.value=1;">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="form2.status.value=3;">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.open('/jsp/adword/EditAdwordName.jsp?community=<%=teasession._strCommunity%>&adword=0','_self');">
-->
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


