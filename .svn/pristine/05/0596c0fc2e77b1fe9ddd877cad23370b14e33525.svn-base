<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");

int item=Integer.parseInt(teasession.getParameter("item"));
Item obj=Item.find(item);


Resource r=new Resource();

String code=null,name=null,aim=null,content=null,principal=null;
int planyear=0;
java.math.BigDecimal outlay=null;



content=obj.getContent();


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
<script>
function defaultfocus()
{
  form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目初始化</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目名称')&&submitText(this.planyear, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-计划年度')">
<input type=hidden name="act" value="InitEditItem"/>
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><%=obj.getCode()%></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><input name="name" type="text" id="name" value="<%if(obj.getName()!=null)out.print(obj.getName());%>" size="40"></td>
       </tr>
<input type="hidden" name="states" value="1">
       <!--tr>
         <td>项目状态</td>
         <td nowrap><select name="states">
		 <option value=0 SELECTED>创建
 		 <option value=1 <%if(obj.getStates()==1)out.print(" SELECTED ");%>>初始化
           </select>
         </td>
       </tr-->
	   <%--
	 <tr><td>项目目标</td>
         <TD><input name="aim" type="text" id="aim" value="<%if(obj.getAim()!=null)out.print(obj.getAim());%>"></TD>
</tr>--%>
       <tr>

        <td>计划年度</td>
         <td nowrap>
         <select name="planyear">
           <%
           for(int index=2000;index<=2000+15;index++)
           {
             out.print("<option value="+index);
             if(index==obj.getPlanyear())
             out.print(" SELECTED ");
             out.print(" >"+index);
           }
           %>
         </select>
         </td>
       </tr>
   <%--    <tr>
         <td>项目经费</td>
         <td nowrap>
<textarea name="outlay" mask="nnnnnnnn.nn" cols="30" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%if(obj.getOutlay()!=null)out.print(obj.getOutlay());else out.print("0.00");%></textarea>
         </td>
       </tr>
	   --%>
	   <tr>
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
             if(member.equals(obj.getPrincipal()))
             out.print(" SELECTED ");
             out.print(" >"+member);
           }
         %>
         </select>
         </td>
       </tr>
       <%-- tr><td>经费申请表</td>
         <TD><input name="outlayapp" type="file" size="40"   value="<%if(obj.getOutlayapp()!=null)out.print(obj.getOutlayapp());%>">
         <%
         if(obj.getOutlayapp()!=null&&obj.getOutlayapp().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=outlayapp&item="+item+" >下载</A>");
         }
         %>
         </TD>
</tr --%>

       <tr><td>计划任务书</td>
         <TD><input name="plantask" type="file" size="40"  id="plantask" value="<%if(obj.getPlantask()!=null)out.print(obj.getPlantask());%>">
                  <%
         if(obj.getPlantask()!=null&&obj.getPlantask().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=plantask&item="+item+" >"+obj.getPlantaskname()+"</A>");
         }
         %>
         </TD>
</tr>

       <tr>
         <td>内容</td>
         <td nowrap>
         <textarea name="content" cols="50" rows="5" id="content" ><%if(obj.getContent()!=null)out.print(obj.getContent().replaceAll("&","&amp;").replaceAll("<","&lt;"));%></textarea></td>
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

