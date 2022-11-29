<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String _strId=request.getParameter("id");

Resource r=new Resource();

StringBuffer param=new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

int type=0;
String _strType=request.getParameter("type");
if(_strType!=null&&_strType.length()>0)
{
  type=Integer.parseInt(_strType);
  switch(type)
  {
  case 1:
	  sql.append(" AND status=").append(type);
	  break;
  default:
	  sql.append(" AND status!=3");
	  break;
  }
  param.append("&type=").append(type);
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

int count=Adword.count(teasession._rv._strR,sql.toString());

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

<h1>广告系列管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>显示:
       <select name="type">
	   <option value="">-------全部--------
	   <option value="1" <%if(type==1)out.print(" SELECTED ");%>>所有有效的
	   <option value="2" <%if(type==2)out.print(" SELECTED ");%>>除已删除系列外的所有广告系列
       </select></td>
       <td>时间:<input name="from" value="<%if(from!=null)out.print(from);%>" ><a href=### onclick="javascript:showCalendar('form1.from');"><img src=/tea/image/public/Calendar2.gif></a>
               -<input name="to" value="<%if(to!=null)out.print(to);%>" ><a href=### onclick="javascript:showCalendar('form1.to');"><img src=/tea/image/public/Calendar2.gif></a>
       </td>
       <td><input type="submit" value="查询"/></td></tr>
</table>
</form>

<FORM name=form2 METHOD=get action="/servlet/EditAdword" onSubmit="">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type=hidden name="act" value="editadwordstatus"/>
<input type=hidden name="adword" value="0"/>
<input type=hidden name="status" value="0"/>

<h2>列表( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"><input type=checkbox onclick="form2.adwords.checked=this.checked;for(var i=0;i<form2.adwords.length;i++)form2.adwords[i].checked=this.checked;"></td>
       <td nowrap>
         <%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >名称</a>");
         }
         %></td>
         <TD nowrap><%
         if("status".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >当前状态 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=status&"+param.toString()+" >当前状态</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("bid".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >当前预算 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=bid&"+param.toString()+" >当前预算</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("click".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >点击次数 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=click&"+param.toString()+" >点击次数</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("hits".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" > 展示次数 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=hits&"+param.toString()+" >展示次数</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("click/hits".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >点击率 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=click/hits&"+param.toString()+" >点击率</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("outlay/hits".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >平均每次点击费用 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=outlay/hits&"+param.toString()+" >平均每次点击费用</a>");
         }
         %></TD>
         <TD nowrap align="right"><%
         if("outlay".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >费用 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=outlay&"+param.toString()+" >费用</a>");
         }
         %></TD>
         <td></td>
       </tr>
<%

java.util.Enumeration enumer=Adword.find(teasession._rv._strR,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Adword obj=Adword.find(id);
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><input type=checkbox name=adwords value="<%=id%>"></td>
  <td><%=obj.getName()%></td>
  <td><%=Adword.STATUS_TYPE[obj.getStatus()]%></td>
  <td align="right"><%if(obj.getBid()!=null)out.print(obj.getBid());else out.print("-");%></td>
  <td align="right"><a href="/jsp/adword/AdwordClicks.jsp?community=<%=teasession._strCommunity%>&adword=<%=id%>"  target="_blank"><%=obj.getClick()%></a></td>
  <td align="right"><%=obj.getHits()%></td>
  <td align="right">
  <%
  if(obj.getHits()<1)
	  out.print("-");
  else
  {
	 float f=(obj.getClick()/obj.getHits())*100;
	 out.print(f+"%");
  }
  %>
  </td>
  <td align="right"><%
  if(obj.getHits()<1 || obj.getOutlay()==null)
	  out.print("-");
  else
  {
	 out.print("¥"+obj.getOutlay().subtract(new java.math.BigDecimal(obj.getHits())));
  }
  %></td>
  <td align="right"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());else out.print("-");%></td>
  <td><input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/adword/EditAdwordName.jsp?community=<%=teasession._strCommunity%>&adword=<%=id%>','_self');">
  </td>
 </tr>
<%
}
%>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"暂停")%>" onClick="form2.status.value=2;">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"恢复")%>" onClick="form2.status.value=1;">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="form2.status.value=3;">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.open('/jsp/adword/EditAdwordName.jsp?community=<%=teasession._strCommunity%>&adword=0','_self');">

</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


