<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
/*
if(request.getParameter("delete")!=null)
{
  int item=Integer.parseInt(request.getParameter("item"));
  Item obj=Item.find(item);
  obj.delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+request.getParameter("nexturl"));
  return;
}*/
String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer(" AND states>=7 ");//(" AND( states=6 OR states=7) ");

tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,teasession._rv.toString());
String role=aur_obj.getRole();
//标准所高级管理员 标准处高级管理员 项目的标准处管理员 项目的标准所管理员 编制组高级管理员 编制组管理员

int adminrole_id_manager=tea.entity.admin.AdminRole.findByName("标准所高级管理员",community);
int adminrole_id_sysmanager=tea.entity.admin.AdminRole.findByName("标准处高级管理员",community);
if((adminrole_id_manager<1||role.indexOf("/"+adminrole_id_manager+"/")==-1)&&(adminrole_id_sysmanager<1||role.indexOf("/"+adminrole_id_sysmanager+"/")==-1))
{
  //sql.append(" AND(supermanager="+DbAdapter.cite(teasession._rv.toString())+" OR manager="+DbAdapter.cite(teasession._rv.toString())+" OR director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR personnel LIKE "+DbAdapter.cite("%/"+teasession._rv.toString()+"/%")+")");
  sql.append(" AND(director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR editgroup="+aur_obj.getUnit()+" )");
}

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
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>存档管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>计划号
         <input name="code" ></td>
       <td>名称
         <input name="name" ></td>
       <td>
类别
  <select name="type">
<option value="">-------------</option>
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

<FORM name=form1 METHOD=post action="/servlet/EditItem" onSubmit="" >
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="item" value="0"/>
<input type="hidden" name="act" value="DownArchiveItems"/>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr"><td nowrap>计划号</td>
         <TD nowrap>名称</TD>
         <TD nowrap>类别</TD>
         <TD nowrap>状态</TD>
         <TD nowrap>经费</TD>
         <TD nowrap><%=Item.ROLE_PRINCIPAL%></TD>
         <TD nowrap>存档日期</TD>
         <TD nowrap></TD>
       </tr>
     <%
java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

  java.io.File dir = new java.io.File(application.getRealPath("/item/" + obj.getCode()));

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

        <td nowrap><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=Item.ITEM_TYPE[obj.getType()]%></td>
         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%></td>
         <td nowrap  align="right"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());%>&nbsp;</td>
         <td nowrap><%if(obj.getPrincipal()!=null)out.print(obj.getPrincipal());%>&nbsp;</td>
         <td nowrap><%if(dir.exists())out.print(new java.util.Date(dir.lastModified()).toLocaleString());%></td>
         <td nowrap>


<input type="button" value="编辑" onClick="window.location='/jsp/criterion/EditArchiveItems.jsp?item=<%=item%>&community=<%=community%>&nexturl=<%=nexturl%>';"/>
<%
if(dir.exists())
out.print("<input  type=submit value=打包下载 onclick=\"form1.item.value="+item+";\">");
%>



          </td>
 </tr>
  <%
}
     %>
</table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


