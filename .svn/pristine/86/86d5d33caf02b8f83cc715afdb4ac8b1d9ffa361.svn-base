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

StringBuffer sql=new StringBuffer();


/////标准所高级管理员登陆，点击“任务管理”，再点击“人员变动管理”时，主界面先显示标准所管理员的名单，选择被更换的标准所管理员，选中后，再显示该管理员负责的项目，再对该项目进行人员更换；也可以直接输入项目计划号，显示项目相关内容后，再对该项目人员变更；同样，标准处高级管理员更换经办人时也是这个流程
tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,teasession._rv.toString());
String role=aur_obj.getRole();

int adminrole_id_principal=tea.entity.admin.AdminRole.findByName("标准处高级管理员",community);
int adminrole_id_director=tea.entity.admin.AdminRole.findByName("标准所高级管理员",community);

boolean bool_principal=(adminrole_id_principal>0&&role.indexOf("/"+adminrole_id_principal+"/")!=-1);
boolean bool_director=(adminrole_id_director>0&&role.indexOf("/"+adminrole_id_director+"/")!=-1);
/*
if(bool_principal&&bool_director)
{
  sql.append(" AND( (principal IS NULL OR DATALENGTH(principal)<1) OR (director IS NULL OR DATALENGTH(director)<1) )");
}else
if(bool_principal)
{
  sql.append(" AND(principal IS NULL OR DATALENGTH(principal)<1)");
}else
if(bool_director)
{
    sql.append(" AND(director IS NULL OR DATALENGTH(director)<1)");
}else
{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("标准处高级管理员 和 标准所高级管理员 才可以访问.","UTF-8"));
//  return;
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

String principal=(request.getParameter("principal"));
if(principal!=null&&principal.length()>0)
{
  sql.append(" AND principal="+DbAdapter.cite(principal));
}

String director=(request.getParameter("director"));
if(director!=null&&director.length()>0)
{
  sql.append(" AND director="+DbAdapter.cite(director));
}
//principal
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
<script type="">
function fcheck()
{
  try
  {
    var obj=document.foList.item;
    if(obj.checked)
    {
      return true;
    }
    for(var i=0;i<obj.length;i++)
    {
      if(obj[i].checked)
      return true;
    }
  }catch(e)
  {}
  alert('无效选择.');
  return false;
}
</script>
</head>
<body>

<h1>人员变动管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td nowrap>项目计划号<input name="code" ></td>
       <td nowrap>项目名称<input name="name" ></td>
<%--
       <td nowrap>
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
           %></select></td> --%>

         <%
         if(bool_principal)
         {
           out.print("<td nowrap>"+Item.ROLE_PRINCIPAL+"<select name=principal ><option value=\"\">------------</option>");

           DbAdapter dbadapter=new DbAdapter();
           try
           {
             dbadapter.executeQuery("SELECT DISTINCT principal FROM Item");
             while(dbadapter.next())
             {
               String member=dbadapter.getString(1);
               out.print("<option value="+member);
               out.print(" >"+member);
             }
           }catch(Exception e)
           {
             e.printStackTrace();
           }finally
           {
             dbadapter.close();
           }
           out.print("</select></td>");
         }

         if(bool_director)
         {
           out.print("<td nowrap>"+Item.ROLE_DIRECTOR+"<select name=director ><option value=\"\">------------</option>");

           DbAdapter dbadapter=new DbAdapter();
           try
           {
             dbadapter.executeQuery("SELECT DISTINCT director FROM Item");
             while(dbadapter.next())
             {
               String member=dbadapter.getString(1);
               out.print("<option value="+member);
               out.print(" >"+member);
             }
           }catch(Exception e)
           {
             e.printStackTrace();
           }finally
           {
             dbadapter.close();
           }
           out.print("</select></td>");
         }
         %>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
   <FORM name=foList METHOD=post action="/jsp/criterion/UserEditItem2.jsp?community=<%=community%><%if(bool_principal)out.print("&principal=ON");if(bool_director)out.print("&director=ON");%>&nexturl=<%=nexturl%>" onSubmit="">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td><input type="checkbox" onClick="try{var obj=document.foList.item;obj.checked=this.checked;for(var i=0;i<obj.length;i++)obj[i].checked=this.checked;}catch(e){}"/></td>
       <td nowrap="nowrap">项目计划号</td>
         <TD nowrap>项目名称</TD>
         <TD nowrap>类别</TD>
         <TD nowrap>状态</TD>
<%--         <TD nowrap>项目目标</TD>
         <TD nowrap>项目经费</TD>
		 --%>
         <TD nowrap><%=Item.ROLE_PRINCIPAL%></TD>
         <TD nowrap><%=Item.ROLE_DIRECTOR%></TD>
       </tr>
     <%
java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);


  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';">
    <td><input type="checkbox"  name="item" value="<%=item%>"/></td>
        <td><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=Item.ITEM_TYPE[obj.getType()]%></td>
         <td nowrap><%=Item.STATES_TYPE[obj.getStates()]%></td>
<%--         <td nowrap><%if(obj.getAim()!=null)out.print(obj.getAim());%>&nbsp;</td>
         <td nowrap  align="right"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());%>&nbsp;</td>
--%>
         <td nowrap><%if(obj.getPrincipal()!=null)out.print(obj.getPrincipal());%>&nbsp;</td>
         <td nowrap><%if(obj.getDirector()!=null)out.print(obj.getDirector());%>&nbsp;</td>
 </tr>
  <%
}
     %>
  </table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="return fcheck();"/>
  </form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

