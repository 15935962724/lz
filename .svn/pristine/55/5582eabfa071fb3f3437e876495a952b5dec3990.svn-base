<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if(request.getParameter("delete")!=null)
{
  int item=Integer.parseInt(request.getParameter("item"));
  Item obj=Item.find(item);
  obj.delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(request.getParameter("nexturl"),"UTF-8"));
  return;
}
String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();//" AND states=0 "  代号:802 暗号:64787997 编号:155800

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND i.type="+type);
  param.append("&type="+type);
}

String code=request.getParameter("code");
if(code!=null&&code.length()>0)
{
  sql.append(" AND i.code LIKE "+DbAdapter.cite("%"+code+"%"));
  param.append("&code="+java.net.URLEncoder.encode(code,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND i.item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="budgetyear";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>
<html>
<head>
<title>项目经费预算</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>项目经费预算</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号<input name="code" ></td>
       <td>项目名称<input name="name" ></td>
       <td>项目类别<select name="type">
       <option value="">---------------</option>
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
       <td>计划号</td>
       <TD>项目名称</TD>
       <TD><%
       if("budgettype".equals(order))
       {
         out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >经费类别 "+("desc".equals(desc)?"▼":"▲")+"</a>");
       }else
       {
         out.print("<A href="+request.getRequestURI()+"?order=budgettype&"+param.toString()+" >经费类别</a>");
       }
       %></TD>
       <TD><%
       if("budgetyear".equals(order))
       {
         out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >年度 "+("desc".equals(desc)?"▼":"▲")+"</a>");
       }else
       {
         out.print("<A href="+request.getRequestURI()+"?order=budgetyear&"+param.toString()+" >年度</a>");
       }
       %></TD>
       <TD><%
       if("budgetoutlay".equals(order))
       {
         out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >经费金额 "+("desc".equals(desc)?"▼":"▲")+"</a>");
       }else
       {
         out.print("<A href="+request.getRequestURI()+"?order=budgetoutlay&"+param.toString()+" >经费金额</a>");
       }
       %></TD><!--↓↑▲▼△▽-->
       <TD></TD>
     </tr>
     <%
java.util.Enumeration enumer=ItemBudget.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int itembudget=((Integer)enumer.nextElement()).intValue();
  ItemBudget obj=ItemBudget.find(itembudget);
  int item=obj.getItem();
  Item item_obj=Item.find(item);

  %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

        <td><%=item_obj.getCode()%></td>
         <td nowrap><%=item_obj.getName()%></td>
         <td><%=obj.isBudgettype()?"总经费预算":"年度经费预算"%></td>
         <td><%=obj.getBudgetyear()%></td>
         <td nowrap><%=obj.getBudgetoutlay()%></td>
         <td>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.location='/jsp/criterion/BudgetEditItem.jsp?item=<%=item%>&community=<%=community%>&itembudget=<%=itembudget%>&nexturl=<%=nexturl%>';"/>
<%--
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='<%=request.getRequestURI()%>?item=<%=item%>&community=<%=community%>&delete=ON&nexturl=<%=nexturl%>';}"/>
--%>
         </td>
 </tr>
  <%
}
     %>
  </table>

<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.location='/jsp/criterion/BudgetEditItem.jsp?item=0&community=<%=community%>&itembudget=0&nexturl=<%=nexturl%>';"/>

<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=BudgetItems.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('经费预算'),'_self');">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


