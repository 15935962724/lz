<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer(" AND states=2 ");//只显示"下达编辑组"的项目

/*
tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(teasession._rv.toString());
String role=aur_obj.getRole();

int adminrole_id_manager=tea.entity.admin.AdminRole.findByName("标准处",community);
int adminrole_id_sysmanager=tea.entity.admin.AdminRole.findByName("标准所",community);
if((adminrole_id_manager<1||role.indexOf("/"+adminrole_id_manager+"/")==-1)&&(adminrole_id_sysmanager<1||role.indexOf("/"+adminrole_id_sysmanager+"/")==-1))
{
  sql.append(" AND(supermanager="+DbAdapter.cite(teasession._rv.toString())+" OR manager="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR personnel LIKE "+DbAdapter.cite("%/"+teasession._rv.toString()+"/%")+")");
}
*/

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

String action=request.getParameter("action");

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>
<!--
标准所高级管理员登陆系统后，能够看到状态为“下达编制组”项目，并对该项目分配“标准所管理员"。
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>分配-<%=Item.ROLE_DIRECTOR%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号<input name="code" ></td>
       <td>项目名称<input name="name" ></td>
       <td>
项目类别<select name="type">
<option value="">-----------------</option>
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
         <TD>类别</TD>
<!--         <TD>项目目标</TD>
         <TD>项目经费</TD>-->
         <TD><%=Item.ROLE_PRINCIPAL%></TD>
		 <TD><%=Item.ROLE_DIRECTOR%></TD>
         <TD></TD>
       </tr>
     <%
java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);


  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=Item.ITEM_TYPE[obj.getType()]%></td>
<%--         <td nowrap><%if(obj.getAim()!=null)out.print(obj.getAim());%>&nbsp;</td>
         <td nowrap  align="right"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());%>&nbsp;</td>
		 --%>
         <td nowrap><%if(obj.getPrincipal()!=null)out.print(obj.getPrincipal());%>&nbsp;</td>
		 <td nowrap><%if(obj.getDirector()!=null)out.print(obj.getDirector());%>&nbsp;</td>
         <td>
           <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.location='/jsp/criterion/DirectorEditItem.jsp?item=<%=item%>&community=<%=community%>&nexturl=<%=nexturl%>';"/>

         </td>
       </tr>
  <%
}
     %>
  </table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


