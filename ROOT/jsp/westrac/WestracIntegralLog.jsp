<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.westrac.WestracIntegralLog"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>



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


StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

  param.append("&id=").append(request.getParameter("id"));

  
 String sname = teasession.getParameter("sname");
 if(sname!=null && sname.length()>0)
 {
	 sname = sname.trim();
	 sql.append(" and member like ").append(DbAdapter.cite("%"+sname+"%"));
	 param.append("&sname=").append(URLEncoder.encode(sname,"UTF-8"));
 }
 
 
 String time_c = teasession.getParameter("time_c");
 if(time_c!=null && time_c.length()>0)
 {
   sql.append(" AND times >=").append(DbAdapter.cite(time_c+" 00:00"));
   param.append("&time_c=").append(time_c);
 }

 String time_d = teasession.getParameter("time_d");
 if(time_d!=null && time_d.length()>0)
 {
   sql.append(" AND times <=").append(DbAdapter.cite(time_d+" 23:59"));
   param.append("&time_d=").append(time_d);
 }

 int wlogtype = -1;
 if(teasession.getParameter("wlogtype")!=null && teasession.getParameter("wlogtype").length()>0)
 {
	 wlogtype = Integer.parseInt(teasession.getParameter("wlogtype"));
 }
 if(wlogtype>=0)
 {
	 sql.append(" and wlogtype = ").append(wlogtype);
	 param.append("&wlogtype=").append(wlogtype);
 } 

int pos=0;
int size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=WestracIntegralLog.Count(teasession._strCommunity,sql.toString());

 
sql.append(" ORDER BY times desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<script>


</script>
<h1>履友积分日志管理</h1>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
     <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
  

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


     <tr>
     <td align="right">用户名：<input type="text" name="sname" value="<%=Entity.getNULL(sname) %>"></td>
     <td align="right">积分日期：
        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />

</td>
<td align="right">积分类型：
<select name="wlogtype">
<option value="-1">-积分类型-</option>
	<%
		for(int i=0;i<WestracIntegralLog.WLOG_TYPE.length;i++)
		{
			out.println("<option value="+i);
			if(wlogtype==i)
			{
				out.print(" selected ");
			}
			out.println(">"+WestracIntegralLog.WLOG_TYPE[i]);
			out.println("</option>");
		}
	%>
	</select>
</td>
       <td><input type="submit" value="查询"/></td>
       </tr>
</table>
</form>
<form method="POST" action="" name="form2">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>


<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条日志&nbsp;)
</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
      
       <td nowrap>用户名</td>
       <td nowrap>积分日期</td>
       <td nowrap>积分类型</td>
       <TD nowrap>内容</TD>

       <td nowrap>所获积分</td>
       <td nowrap>扣减积分</td>
       <td nowrap>说明</td>
       </tr>
     <%
    
     java.util.Enumeration enumer = WestracIntegralLog.find(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     { 
       out.print("<tr><td colspan=6  align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int wlid =  Integer.parseInt(enumer.nextElement().toString());
       WestracIntegralLog wobj = WestracIntegralLog.find(wlid);
      
       %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
  
         <td><%=wobj.getMember()%></td>
         <td><%=Entity.sdf2.format(wobj.getTimes())%></td>
         <TD><%=WestracIntegralLog.WLOG_TYPE[wobj.getWlogtype()] %></TD>
      
         <td><%
         	if(wobj.getWname()!=null && wobj.getWname().length()>0)
         	{
         		out.print("<a href=\"/html/category/"+wobj.getNode()+"-1.htm\" target=_blank  >"+wobj.getWname()+"</a>");
         	}else
         	{
         		out.print(wobj.getNULL(wobj.getWname()));
         	}
         %></td>
          <td><%=wobj.getIntegral()%></td>
           <td><%=wobj.getCutintegral()%></td>
            <td><%=wobj.getNULL(wobj.getRemarks())%></td>
         
       </tr>
       <%
       }
       %>
       <%
       	if(count>size){
       %>
       <tr><td colspan="7" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
	<%} %>
</table>


</form>
<br>
<div id="head6"><img height="6" alt="" src=""></div>
</body>
</html>



