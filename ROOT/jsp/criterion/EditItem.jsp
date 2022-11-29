<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));
if(request.getMethod().equals("POST"))
{
  int type=Integer.parseInt(request.getParameter("type"));
  String code=request.getParameter("code");
  String name=request.getParameter("name");
  String remark=request.getParameter("remark");
  //  String principal=request.getParameter("principal");

  int _nItem=Item.findItemByCode(code);
  if(_nItem!=0&&_nItem!=item)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(code+" 计划号,已经存在.","UTF-8"));
    return;
  }
  if(item==0)
  {
    Item.create(code,name,type,0,remark,community);
  }else
  {
    Item obj=Item.find(item);
    obj.set(code,name,type,0,remark);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();

String code,name,remark,principal=null;
int type=-1;
if(item!=0)
{
  Item obj=Item.find(item);
  code=obj.getCode();
  name=obj.getName();
  type=obj.getType();
  remark=obj.getRemark().replaceAll("&","&amp;").replaceAll("<","&lt;");
//  principal=obj.getPrincipal();
}else
{
  code=name=remark="";
}
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.code.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目创建</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="<%=request.getRequestURI()%>" method="post" onSubmit="return submitText(this.code, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目计划号')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目名称')&&submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目类别')">
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><input name="code" type="text" id="code" value="<%=code%>"></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><input name="name" type="text" id="name" value="<%=name%>" size="40"></td>
       </tr>
       <tr>
         <td>项目类别</td>
         <td nowrap><select name="type">
         <option value="">------------</option>
           <%
           for(int index=0;index<Item.ITEM_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==type)
            out.println(" SELECTED ");
            out.println(" >"+Item.ITEM_TYPE[index]);
           }
           %></select>
         </td>
       </tr>
<%--              <tr>
         <td><%=Item.ROLE_PRINCIPAL%></td>
         <td nowrap>
         <select name="principal">
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
       </tr>--%>
       <tr>
         <td>备注</td>
         <td nowrap>
         <textarea name="remark" cols="50" rows="5" id="remark" ><%=remark%></textarea></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


