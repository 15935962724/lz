<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource"  import="tea.entity.criterion.Itemoutlay"  import="tea.entity.criterion.Item"  import="tea.entity.criterion.Outlay" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("delete")!=null)
{
  int itemoutlay=Integer.parseInt(request.getParameter("itemoutlay"));
  Itemoutlay obj=Itemoutlay.find(itemoutlay);
  obj.delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+request.getParameter("nexturl"));
  return;
}
String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String code=(request.getParameter("code"));
if(code!=null&&code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
}

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>项目经费划拨</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>项目计划号
         <input name="code" ></td>
       <td>项目名称
         <input name="name"></td>
                <td>项目类别<select name="type">
           <%
           for(int index=0;index<Item.ITEM_TYPE.length;index++)
           {
            out.print("<option value="+index);
            //if(index==type)
            //out.println(" SELECTED ");
            out.println(" >"+Item.ITEM_TYPE[index]);
           }
           %></select></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td>项目计划号</td>
         <TD>项目名称</TD>
         <TD>项目类别</TD>
         <TD>总经费</TD>
         <TD>已拨经费</TD>
         <TD>项目创建时间</TD>
         <TD></TD>
       </tr>
     <%
     java.math.BigDecimal total = new java.math.BigDecimal("0.00");
java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

  %>
       <tr>

        <td><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td><%=Item.ITEM_TYPE[obj.getType()]%></td>
         <td><%=obj.getOutlay()%></td>
         <td><A href="/jsp/criterion/Itemoutlays.jsp?community=<%=community%>&code=<%=obj.getCode()%>" ><%=Itemoutlay.findPaymentByItem(item)%></A></td>
         <td nowrap><%=obj.getUpdatetimeToString()%>&nbsp;</td>


 </tr>
  <%
}
     %>
  </table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onclick="window.location='/jsp/criterion/EditItemoutlay.jsp?itemoutlay=0&community=<%=community%>&nexturl=<%=nexturl%>';"/>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

