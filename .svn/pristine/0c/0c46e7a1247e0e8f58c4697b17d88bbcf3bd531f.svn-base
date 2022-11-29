<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String applicant=request.getParameter("applicant");
String name=request.getParameter("name");
String type=request.getParameter("type");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (applicant != null && (applicant = applicant.trim()).length() > 0)
{
	sql.append(" AND applicant LIKE ").append(DbAdapter.cite("%"+applicant+"%"));
	param.append("&applicant=").append(java.net.URLEncoder.encode(applicant,"UTF-8"));
}
if (name != null && (name = name.trim()).length() > 0)
{
	sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if (type != null && (type = type.trim()).length() > 0)
{
	sql.append(" AND type LIKE ").append(DbAdapter.cite("%"+type+"%"));
	param.append("&type=").append(java.net.URLEncoder.encode(type,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crupdate";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crupdate.count(teasession._strCommunity,sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>变更补充公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>登记号:<input name="scrbid" size="10" value="<%if(scrbid!=null)out.print(scrbid);%>"></td>
       <td>申请者:<input name="applicant" value="<%if(applicant!=null)out.print(applicant);%>"></td>
       <td>软件名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>变更类别:<input name="type" value="<%if(type!=null)out.print(type);%>"></td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>
<br>

<h2>列表 ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
       <td>
         <%
         if("scrbid".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >登记号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=scrbid"+param.toString()+pos+" >登记号</a>");
         }
         %></td>
         <TD nowrap><%
         if("applicant".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >申请者 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=applicant"+param.toString()+pos+" >申请者</a>");
         }
         %></TD>
         <TD nowrap><%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >软件名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name"+param.toString()+pos+" >软件名称</a>");
         }
         %></TD>
         <TD nowrap><%
         if("type".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >变更类别 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=type"+param.toString()+pos+" >变更类别</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Crupdate.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crupdate obj=Crupdate.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td nowrap>&nbsp;<%=obj.getApplicant()%></td>
    <td>&nbsp;<%=obj.getName()%></td>
    <td>&nbsp;<%=obj.getType()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrupdateView.jsp?community=<%=teasession._strCommunity%>&crupdate=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

