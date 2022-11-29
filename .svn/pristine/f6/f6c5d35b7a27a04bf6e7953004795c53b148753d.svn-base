<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page import="tea.entity.admin.AdminUnit" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.entity.criterion.Egqb" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

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

StringBuffer sql=new StringBuffer();//" AND states=0 "

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
}

String code=request.getParameter("code");
if(code!=null&&code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
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

<h1>季报</h1>
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
         <option value="">------------</option>
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
       <tr id="tableonetr"><td>项目计划号</td>
         <TD>项目名称</TD>
         <TD>编制组</TD>
         <TD>季报文档</TD>
         <TD>上报时间</TD>
         <TD></TD>
       </tr>
     <%
java.util.Enumeration enumer=Egqb.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int egqb=((Integer)enumer.nextElement()).intValue();
  Egqb obj=Egqb.find(egqb);
  Item item=Item.find(obj.getItem());

  AdminUnit au=AdminUnit.find(item.getEditgroup());
  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><%=item.getCode()%></td>
         <td nowrap><%=item.getName()%></td>
         <td nowrap><%=au.getName()%></td>
         <td nowrap><%
         if(obj.getFileuri()!=null&&obj.getFileuri().length()>0)
         {
           out.print("<a href=ItemDownload.jsp?egqbs=ON&act=file&item="+obj.getItem()+"&egqb="+egqb+" >"+obj.getFilename()+"</a>");
         }
         %></td>
         <td nowrap><%=obj.getTimeToString()%></td>
         <td>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.location='/jsp/criterion/EditEgqb.jsp?item=<%=obj.getItem()%>&egqb=<%=egqb%>&community=<%=community%>&nexturl=<%=nexturl%>';"/>
         </td>
 </tr>
  <%
}
     %>
  </table>

<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.location='/jsp/criterion/EditEgqb.jsp?item=0&egqb=0&community=<%=community%>&nexturl=<%=nexturl%>';"/>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

