<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource"   %><%@ page  import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
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

StringBuffer param=new StringBuffer("&community="+community);
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
  param.append("&code="+java.net.URLEncoder.encode(code,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}

String principal=(request.getParameter("principal"));
if(principal!=null&&principal.length()>0)
{
  sql.append(" AND principal="+DbAdapter.cite(principal));
  param.append("&principal="+java.net.URLEncoder.encode(principal,"UTF-8"));
}

String states=(request.getParameter("states"));
if(states!=null&&states.length()>0)
{
  sql.append(" AND states="+(states));
  param.append("&states="+java.net.URLEncoder.encode(states,"UTF-8"));
}


String order=request.getParameter("order");
if(order==null)
order="code";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);

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

<h1>项目执行情况</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>项目计划号
         <input name="code" value="<%if(code!=null)out.print(code);%>"></td>
       <td>项目名称
         <input name="name" value="<%if(name!=null)out.print(name);%>"></td>
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
     <td nowrap width="1"></td>
       <td nowrap><%
         if("code".equals(order))
         {
           out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >计划号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href="+request.getRequestURI()+"?order=code&"+param.toString()+" >计划号</a>");
         }
         %></td>
         <TD nowrap>名称</TD>
         <TD nowrap>编制单位</TD>
         <TD nowrap>总经费</TD>
         <TD nowrap>已拨经费</TD>
         <TD nowrap>目前状态</TD>
         <TD nowrap><%=Item.ROLE_PRINCIPAL%></TD>
         <TD nowrap>是否已拨足经费</TD>
         <TD nowrap>是否延迟</TD>
       </tr>
     <%
//java.util.Enumeration
enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

  java.math.BigDecimal payment=Itemoutlay.findPaymentByItem(item);

Itemmember im_obj=Itemmember.find(obj.getSupermanager(),community);
tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//obj.getEditgroup());

  %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td><%if(au_obj.getName()!=null)out.print(au_obj.getName());%></td>
         <td><%=obj.getOutlay()%></td>
         <td><%=payment%></td>
         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%>&nbsp;</td>
         <td nowrap><%=obj.getPrincipal()%>&nbsp;</td>
         <td>
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
         <td>
         <%=obj.isDefer()?"是":"否"%>
         </td>
<%--         <td><input type="button" onClick="window.open('/jsp/criterion/Linkman.jsp?item=<%=item%>&community=<%=community%>','_self');" value="人员信息"/></td>  --%>
 </tr>
  <%
}
     %>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=Itemstates.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('项目执行情况'),'_self');">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

