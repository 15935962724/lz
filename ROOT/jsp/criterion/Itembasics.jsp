<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource"  import="tea.entity.criterion.Itemoutlay"  import="tea.entity.criterion.Item"  import="tea.entity.criterion.Outlay" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,teasession._rv.toString());
String role=aur_obj.getRole();
//标准所高级管理员 标准处高级管理员 项目的标准处管理员 项目的标准所管理员 编制组高级管理员 编制组管理员

int adminrole_id_manager=tea.entity.admin.AdminRole.findByName("标准所高级管理员",community);
int adminrole_id_sysmanager=tea.entity.admin.AdminRole.findByName("标准处高级管理员",community);
if((adminrole_id_manager<1||role.indexOf("/"+adminrole_id_manager+"/")==-1)&&(adminrole_id_sysmanager<1||role.indexOf("/"+adminrole_id_sysmanager+"/")==-1))
{
//  sql.append(" AND(supermanager="+DbAdapter.cite(teasession._rv.toString())+" OR manager="+DbAdapter.cite(teasession._rv.toString())+" OR director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR personnel LIKE "+DbAdapter.cite("%/"+teasession._rv.toString()+"/%")+")");
sql.append(" AND(director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR editgroup="+aur_obj.getUnit()+" )");
}


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

String principal=(request.getParameter("principal"));
if(principal!=null&&principal.length()>0)
{
  sql.append(" AND principal="+DbAdapter.cite(principal));
}

String states=(request.getParameter("states"));
if(states!=null&&states.length()>0)
{
  sql.append(" AND states="+(states));
}

//项目基本信息中：项目计划号、项目名称、项目状态、是否延迟；
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

<h1>项目基本信息</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>项目计划号
         <input name="code" value="<%if(code!=null)out.print(code);%>"></td>
       <td>项目名称
         <input name="name" value="<%if(name!=null)out.print(name);%>"></td>
  <%--
         <td><%=Item.ROLE_PRINCIPAL%><select name="principal">
         <option value="">------------</option>
         <%
           int adminrole_id=tea.entity.admin.AdminRole.findByName(Item.ROLE_PRINCIPAL,community);//"标准处管理员"
           java.util.Enumeration enumer=tea.entity.admin.AdminUsrRole.findByRole(adminrole_id);
           while(enumer.hasMoreElements())
           {
             String member=(String)enumer.nextElement();
             out.print("<option value="+member);
             if(member.equals(principal))
             out.print(" SELECTED ");
             out.print(" >"+member);
           }
         %>
         </select>
				</td>
--%>
                <td>项目状态<select name="states"><option value="">-----------------</option>
           <%
           for(int index=0;index<Item.STATES_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(String.valueOf(index).equals(states))
            out.println(" SELECTED ");
            out.println(" >"+Item.STATES_TYPE[index]);
           }
           %></select></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap></td>
       <td nowrap>计划号</td>
         <TD nowrap>名称</TD>
         <TD nowrap>目前状态</TD>
         <TD nowrap>是否延迟</TD>
       </tr>
     <%
java.util.Enumeration
enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);



  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%>&nbsp;</td>
         <td>
         <%=obj.isDefer()?"是":"否"%>
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

