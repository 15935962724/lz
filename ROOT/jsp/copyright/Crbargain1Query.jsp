<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String pubarea=request.getParameter("pubarea");
String crto=request.getParameter("crto");
String name=request.getParameter("name");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer(" AND flag=1");
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (pubarea != null && (pubarea = pubarea.trim()).length() > 0)
{
	sql.append(" AND pubarea LIKE ").append(DbAdapter.cite("%"+pubarea+"%"));
	param.append("&pubarea=").append(java.net.URLEncoder.encode(pubarea,"UTF-8"));
}
if (crto != null && (crto = crto.trim()).length() > 0)
{
	sql.append(" AND crto LIKE ").append(DbAdapter.cite("%"+crto+"%"));
	param.append("&crto=").append(java.net.URLEncoder.encode(crto,"UTF-8"));
}
if (name != null && (name = name.trim()).length() > 0)
{
	sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crbargain";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crbargain.count(teasession._strCommunity,sql.toString());

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

<h1>影视制品著作权合同登记公告</h1>
<br>
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
       <td>出品地:<input name="pubarea" value="<%if(pubarea!=null)out.print(pubarea);%>"></td>
       <td>出品单位:<input name="crto" value="<%if(crto!=null)out.print(crto);%>"></td>
       <td>节目名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>

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
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >节目名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name"+param.toString()+pos+" >节目名称</a>");
         }
         %></TD>
         <TD nowrap><%
         if("crto".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >出版单位 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=crto"+param.toString()+pos+" >出版单位</a>");
         }
         %></TD>
         <TD nowrap><%
         if("pubarea".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >出品地 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=pubarea"+param.toString()+pos+" >出品地</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
<%
java.util.Enumeration enumer=Crbargain.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crbargain obj=Crbargain.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td>&nbsp;<%=obj.getName()%></td>
    <td>&nbsp;<%=obj.getCrto()%></td>
    <td>&nbsp;<%=obj.getPubarea()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/Crbargain1View.jsp?community=<%=teasession._strCommunity%>&crbargain=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" ></td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


