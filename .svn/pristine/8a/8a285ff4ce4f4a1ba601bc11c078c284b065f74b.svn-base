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

//项目经费信息：项目计划号、项目名称、总经费、已拨经费、经费是否拨足；
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

<h1>项目经费信息</h1>
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
     <td nowrap>&nbsp;</td>
       <td nowrap>计划号</td>
         <TD nowrap>名称</TD>
         <TD nowrap>类别</TD>
         <TD nowrap>总经费</TD>
         <TD nowrap>已拨经费</TD>
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
         <td nowrap><%=obj.getOutlay()%></td>
         <td nowrap><%=payment%></td>
         <td nowrap>
         <%
		          if(obj.isAdequate())	
         out.print("是");
         else
         out.print("否");
		 /*
         payment=payment.subtract(obj.getOutlay());
         if(payment.floatValue()<0.0F)
         {
           out.print("否");
         }else
         {
           out.print("是");
         }*/
         %>
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

