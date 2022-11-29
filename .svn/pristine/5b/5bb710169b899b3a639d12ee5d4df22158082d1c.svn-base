<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

java.util.Calendar c=java.util.Calendar.getInstance();
int budgetyear=c.get(c.YEAR);

int item=Integer.parseInt(request.getParameter("item"));
int itembudget=Integer.parseInt(request.getParameter("itembudget"));



Resource r=new Resource();


boolean budgettype=false;

java.math.BigDecimal budgetoutlay;
String outlayapp=null,outlayappname=null;
if(itembudget!=0)
{
  ItemBudget lb_obj=ItemBudget.find(itembudget);
  budgetoutlay=lb_obj.getBudgetoutlay();
  budgettype=lb_obj.isBudgettype();

  outlayapp=lb_obj.getOutlayapp();
  outlayappname=lb_obj.getOutlayappname();
}else
{
  budgetoutlay=new java.math.BigDecimal("0.00");

}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  //form1.budgettype[0].focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目经费预算</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" enctype="multipart/form-data" method="post" onSubmit="return submitText(this.budgetoutlay, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目计划号')">
<input type=hidden name="itembudget" value="<%=itembudget%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="BudgetEditItem"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>项目计划号</td>
    <TD>
    <%
    if(item==0)
    {
      out.print("<select name=item >");
      java.util.Enumeration enumer=Item.find(community,"",0,Integer.MAX_VALUE);
      while(enumer.hasMoreElements())
      {
        int item_id=((Integer)enumer.nextElement()).intValue();
        Item obj=Item.find(item_id);
        out.print("<option value="+item_id+" >"+obj.getCode());
      }
      out.print("</select>");
    }else
    {
      Item obj=Item.find(item);
      String code=obj.getCode();
      out.print(code+"<input type=hidden name=item value="+item+" />");
    }
    %>

         </TD></tr>
         <!--tr>
           <td>项目名称</td>
           <td nowrap><%//=name%></td>
         </tr-->
       <tr>
         <td>经费类型</td>
         <td nowrap>
           <input name="budgettype" type="radio" <%if(budgettype)out.print(" checked ");%> value="true" onClick="document.form1.budgetyear.disabled=this.checked">总经费预算
           <input name="budgettype" type="radio" <%if(!budgettype)out.print(" checked ");%> value="false" onClick="document.form1.budgetyear.disabled=!this.checked">年度经费预算
         </td>
       </tr>
       <tr>
         <td>年度</td>
         <td nowrap><select <%if(budgettype)out.print(" disabled ");%> name="budgetyear">
         <%
         for(int index=2000;index<=2015;index++)
         {
           out.print("<option value="+index);
           if(budgetyear==index)
           {
             out.print(" SELECTED ");
           }
           out.print(">"+index);
         }
         %>
</select></td>
       </tr>
       <tr>
         <td>金额</td>
         <td nowrap><textarea name="budgetoutlay" mask="nnnnnnnn.nn" cols="20" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%=budgetoutlay%></textarea></td>
       </tr>

       <tr><td>经费申请表</td>
         <TD><input name="outlayapp"   onchange="fview(this);" type="file" size="40"   value="">
         <%
         if(outlayapp!=null&&outlayapp.length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=outlayapp&item="+item+"&itembudget="+itembudget+" >"+outlayappname+"</A>");
         }
         %>
         <a id="a_outlayapp" href="###" style="display:none" ><img id="img_outlayapp" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_outlayapp"></span></a>
         </TD>
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


