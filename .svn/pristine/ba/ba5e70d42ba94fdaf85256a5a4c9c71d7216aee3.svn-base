<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
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

<h1>项目经费明细表</h1>
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
                <td>项目类别<select name="type"><option value="">-----------------</option>
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
     <td nowrap width="1">&nbsp;</td>
       <td nowrap>计划号</td>
         <TD nowrap>名称</TD>
         <TD nowrap>类别</TD>
         <TD nowrap>总经费</TD>
         <TD nowrap>已拨经费</TD>
         <TD nowrap>状态</TD>
         <TD nowrap><%=Item.ROLE_PRINCIPAL%></TD>
         <TD nowrap>拨足经费</TD>
       </tr>
     <%

java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

  java.math.BigDecimal payment=Itemoutlay.findPaymentByItem(item);

  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap width="1"><%=index%></td>
         <td nowrap><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=Item.ITEM_TYPE[obj.getType()]%></td>
         <td nowrap><%=ItemBudget.getTotal(item)%></td>
         <td nowrap><%=payment%></td>
         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%>&nbsp;</td>
         <td nowrap><%=obj.getPrincipal()%>&nbsp;</td>
         <td nowrap>
         <%
         //payment=payment.subtract(obj.getOutlay());
         if(!obj.isAdequate())//if(payment.floatValue()<0.0F)
         {
           out.print("否");
         }else
         {
           out.print("是");
         }
         %>
         </td>

 </tr>
  <%
}
     %>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=Itemoutlays3.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('项目经费明细表'),'_self');">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

