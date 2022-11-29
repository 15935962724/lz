<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.criterion.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");


StringBuffer sql=new StringBuffer();

tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,teasession._rv.toString());
String role=aur_obj.getRole();
//标准所高级管理员 标准处高级管理员 项目的标准处管理员 项目的标准所管理员 编制组高级管理员 编制组管理员

int adminrole_id_manager=tea.entity.admin.AdminRole.findByName("标准所高级管理员",community);
int adminrole_id_sysmanager=tea.entity.admin.AdminRole.findByName("标准处高级管理员",community);
int adminrole_id_manager2=tea.entity.admin.AdminRole.findByName(Item.ROLE_PRINCIPAL,community);//"标准处管理员"
int adminrole_id_sysmanager2=tea.entity.admin.AdminRole.findByName(Item.ROLE_DIRECTOR,community);//标准所管理员"

boolean bool_manager=adminrole_id_manager>0&&role.indexOf("/"+adminrole_id_manager+"/")!=-1;
boolean bool_sysmanager=adminrole_id_sysmanager>0&&role.indexOf("/"+adminrole_id_sysmanager+"/")!=-1;
boolean bool_manager2=adminrole_id_manager2>0&&role.indexOf("/"+adminrole_id_manager2+"/")!=-1;
boolean bool_sysmanager2=adminrole_id_sysmanager2>0&&role.indexOf("/"+adminrole_id_sysmanager2+"/")!=-1;

//System.out.println("会员:"+teasession._rv.toString()+"\t"+community);
//System.out.println("标准处管理员:"+adminrole_id_manager2+"\t"+bool_manager2+"\t"+role);
//System.out.println("标准所管理员:"+adminrole_id_sysmanager2+"\t"+bool_sysmanager2);

if(!bool_manager&&!bool_sysmanager)
{
  //sql.append(" AND(supermanager="+DbAdapter.cite(teasession._rv.toString())+" OR manager="+DbAdapter.cite(teasession._rv.toString())+" OR director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR personnel LIKE "+DbAdapter.cite("%/"+teasession._rv.toString()+"/%")+")");
  sql.append(" AND(director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR editgroup="+aur_obj.getUnit()+" )");
}
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onLoad="">
<h1>桌面</h1>
<br />
<div id="head6"><img height="6" alt=""></div>

<h2>收件箱</h2>
<table id="tablecenter">
<tr><td>
<A href="/jsp/message/Messages.jsp?folder=0&community=<%=community%>" >收件箱(<%=Message.count(teasession._rv._strV,0)%>)</A>
</td></tr>
</table>

<h2>项目状态</h2>
 <table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
     <tr id="tableonetr"><td><script>var index=0;</script></td><td nowrap>计划号</td>
     <TD nowrap>名称</TD>
     <TD nowrap>编制组</TD>
     <TD nowrap>状态</TD>
     <TD nowrap><%=Item.ROLE_PRINCIPAL%></TD>
     <TD nowrap><%=Item.ROLE_DIRECTOR%></TD>
     </tr>
<%
java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

//  java.math.BigDecimal payment=Itemoutlay.findPaymentByItem(item);

  AdminUnit au_obj=AdminUnit.find(obj.getEditgroup());

  String href=null;
  switch(obj.getStates())
  {
    case 0:
    href="/jsp/criterion/CreateItems.jsp";break;
    case 1:
    href="/jsp/criterion/InitItems.jsp";break;
    case 2:
    href="/jsp/criterion/EditgroupItems.jsp";break;
    case 3:
    href="/jsp/criterion/OpenItems.jsp";break;
    case 4:
    href="/jsp/criterion/IdeaItems.jsp";break;
    case 5:
    href="/jsp/criterion/FormulatingItems.jsp";break;
    case 6:
    href="/jsp/criterion/LevelItems.jsp";break;
    case 7:
    href="/jsp/criterion/StandardItems.jsp";break;
    //  case 9:
    //  href="/jsp/criterion/StandardItems.jsp";break;
    case 10:
    href="/jsp/criterion/DraftItems.jsp";break;
  }
  if(href!=null)
  {
    href=href+"?community="+community+"&node="+teasession._nNode;
    if(bool_manager||bool_sysmanager||bool_manager2||bool_sysmanager2)
    {
      href=href+"&action=auditing";
    }
  }
  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap width="1"><script>document.write(++index);</script></td>
         <td nowrap><%=obj.getCode()%></td>
         <td nowrap><%if(href!=null)out.print("<A href="+href+" >");out.print(obj.getName()+"</A>");%></td>
         <td nowrap><%if(au_obj.getName()!=null)out.print(au_obj.getName());%></td>
<%--         <td nowrap><%=obj.getOutlay()%></td>
         <td nowrap><%=payment%></td>
--%>         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%>&nbsp;</td>
         <td nowrap><%=obj.getPrincipal()%>&nbsp;</td>
         <td><%=obj.getDirector()%></td>
<%--          <td><input type="button" onclick="window.open('/jsp/criterion/Linkman.jsp?item=<%=item%>&community=<%=community%>','_self');" value="人员信息"/></td> --%>
 </tr>
  <%
}
     %>
</table>

<div id="head6"><img height="6" alt=""></div>
</body>
</html>


