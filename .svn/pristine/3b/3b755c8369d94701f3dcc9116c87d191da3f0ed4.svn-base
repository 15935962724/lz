<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community=").append(teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String id=(request.getParameter("id"));
param.append("&id=").append(id);

String _strCode=(request.getParameter("code"));
if(_strCode!=null&&_strCode.length()>0)
{
  sql.append(" AND code LIKE ").append(DbAdapter.cite("%"+_strCode+"%"));
  param.append("&code=").append(_strCode);
}

String _strFincode=(request.getParameter("fincode"));
if(_strFincode!=null&&_strFincode.length()>0)
{
  sql.append(" AND fincode LIKE ").append(DbAdapter.cite("%"+_strFincode+"%"));
  param.append("&fincode=").append(_strFincode);
}

int count=SMSSubcode.count(sql.toString());

String order=request.getParameter("order");
if(order==null)
order="code";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
  //param.append("&pos=").append(_strPos);
}
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

<h1>子号</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=id%>"/>
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>子号<input name="code" size="10" value="<%if(_strCode!=null)out.print(_strCode);%>"></td>
       <td>企业号<input name="fincode" value="<%if(_strFincode!=null)out.print(_strFincode);%>"></td>
       <%--<td>类别
         <select name="type">
	   <option value="">----------------
       <%
           for(int index=0;index<Item.ITEM_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(type!=null&&String.valueOf(index).equals(type))
            out.println(" SELECTED ");
            out.println(" >"+Item.ITEM_TYPE[index]);
           }
           %></select></td>
             --%>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>

<h2>列表 ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap>
         <%
         if("code".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >子号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=code&"+param.toString()+" >子号</a>");
         }
         %></td>
         <TD nowrap><%
         if("password".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >密码 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=password&"+param.toString()+" >密码</a>");
         }
         %></TD>
         <TD nowrap><%
         if("autoreverse".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >自动回复 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=autoreverse&"+param.toString()+" >自动回复</a>");
         }
         %></TD>
         <TD nowrap><%
         if("fincode".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >企业号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=fincode&"+param.toString()+" >企业号</a>");
         }
         %></TD>
         <TD nowrap><%
         if("mobileno".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >手机号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=mobileno&"+param.toString()+" >手机号</a>");
         }
         %></TD>
       </tr>
<%

java.util.Enumeration enumer=SMSSubcode.find(sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int code=((Integer)enumer.nextElement()).intValue();
  SMSSubcode obj=SMSSubcode.find(code);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td nowrap><%=obj.getCode()%></td>
         <td nowrap><%=obj.getPassword()%></td>
         <td nowrap><%=obj.isAutoreverse()%></td>
         <td nowrap><%=obj.getFincode()%></td>
        <td nowrap><%=obj.getMobileno()%></td>
        <td></td>
    </tr>
<%
}%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage, "?" + param.toString() + "&pos=", pos, count)%></td></tr>
</table>

<%--  input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=Items.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('计划或正在执行的项目清单'),'_self');">  --%>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
