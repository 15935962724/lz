<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String name=request.getParameter("name");
String author=request.getParameter("author");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (name != null && (name = name.trim()).length() > 0)
{
	sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if (author != null && (author = author.trim()).length() > 0)
{
	sql.append(" AND author>=").append(DbAdapter.cite(author));
	param.append("&author=").append(java.net.URLEncoder.encode(author,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crtransfercontract";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crtransfercontract.count(teasession._strCommunity,sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>转让合同公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form_crtc METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>登记号:<input name="scrbid" size="10" value="<%if(scrbid!=null)out.print(scrbid);%>"></td>
       <td>软件名称:<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>合同登记人:<input name="author" size="10" value="<%if(author!=null)out.print(author);%>"></td>
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
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >软件名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name"+param.toString()+pos+" >软件名称</a>");
         }
         %></TD>
         <TD nowrap><%
         if("author".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >合同登记人 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=author"+param.toString()+pos+" >合同登记人</a>");
         }
         %></TD>
         <TD nowrap><%
         if("droit".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >转让权利 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=droit"+param.toString()+pos+" >转让权利</a>");
         }
         %></TD>
         <TD nowrap><%
         if("assignor".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >转让人 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=assignor"+param.toString()+pos+" >转让人</a>");
         }
         %></TD>
         <TD nowrap><%
         if("alienee".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >受让人 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=alienee"+param.toString()+pos+" >受让人</a>");
         }
         %></TD>
         <TD nowrap><%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >发证日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time"+param.toString()+pos+" >发证日期</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
<%
java.util.Enumeration enumer=Crtransfercontract.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crtransfercontract obj=Crtransfercontract.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td>&nbsp;<%=obj.getName()%></td>
    <td>&nbsp;<%=obj.getAuthor()%></td>
    <td>&nbsp;<%=obj.getDroit()%></td>
    <td>&nbsp;<%=obj.getAssignor()%></td>
    <td>&nbsp;<%=obj.getAlienee()%></td>
    <td>&nbsp;<%=obj.getTime()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrtransfercontractView.jsp?community=<%=teasession._strCommunity%>&crtransfercontract=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
     </td>
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

