<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.entity.admin.AdminUnit" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int unit=Integer.parseInt(request.getParameter("unit"));



Resource r=new Resource();

String calling,specialty,address,product,linkmanname,job,phone,fax,mobile,email,name,zip,url,have_a_project,bank=null,account=null;

java.util.Date issuetime=null,appeartime=null;

AdminUnit au_obj=AdminUnit.find(unit);
name=au_obj.getName();

Unitres obj=Unitres.find(unit);
if(unit!=0&&obj.isExists())
{
  address=obj.getAddress().replaceAll("\"","&quot;");
  product=obj.getProduct().replaceAll("\"","&quot;");
  linkmanname=obj.getLinkmanname().replaceAll("\"","&quot;");
  job=obj.getJob().replaceAll("\"","&quot;");
  phone=obj.getPhone().replaceAll("\"","&quot;");
  fax=obj.getFax();
  mobile=obj.getMobile().replaceAll("\"","&quot;");
  email=obj.getEmail().replaceAll("\"","&quot;");
  calling=obj.getCalling();
  specialty=obj.getSpecialty();
  zip=obj.getZip();
  url=obj.getUrl();
  have_a_project=obj.getHave_a_project();
  bank=obj.getBank();
  account=obj.getAccount();
}else
{
  calling=specialty=address=product=linkmanname=job=phone=fax=mobile=email=zip=have_a_project="";
  url="http://www.";
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
  document.form1.address.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>编制单位资源</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return submitText(this.address, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-地址')&&submitText(this.calling, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-行业')&&submitText(this.specialty, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-专长')">
<input type=hidden name="unit" value="<%=unit%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="EditUnitres"/>
<input type=hidden name="item" value="0"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称:</td>
         <TD><%=name%></TD>
     </tr>
       <tr>
        <td>地址</td>
         <td nowrap><input name="address" type="text" id="address" value="<%=address%>" size="40"></td>
       </tr>
       <tr>
         <td>邮编</td>
         <td nowrap><input name="zip" type="text" id="zip" value="<%=zip%>" maxlength="6" ></td>
       </tr>
       <tr>
         <td>行业</td>
         <td nowrap>
         <input name="calling" type="text" id="calling" value="<%=calling%>" size="40">
           <%--
           <select name="calling" id="calling">
	   <option value="" >------------
       <%
           for(int index=0;index<Unitres.CALLING_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==calling)
            out.print(" SELECTED ");
            out.println(" >"+Unitres.CALLING_TYPE[index]);
           }
           %></select>
           --%>
         </td>
       </tr>
              <tr>
         <td>专长</td>
         <td nowrap>
         <input name="specialty" type="text" id="specialty" value="<%=specialty%>" size="40">
         <%--
         <select name="specialty" id="specialty">
	   <option value="" >------------
       <%
           for(int index=0;index<Unitres.SPECIALTY_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==specialty)
            out.print(" SELECTED ");
            out.println(" >"+Unitres.SPECIALTY_TYPE[index]);
           }
           %></select> --%>         </td>
       </tr>
	          <tr>
        <td>产品</td>
         <td nowrap><input name="product" type="text" id="product" value="<%=product%>" size="40"></td>
       </tr>
 <tr>
        <td>联系人姓名</td>
         <td nowrap><input name="linkmanname" type="text" id="linkmanname" value="<%=linkmanname%>" size="40"></td>
       </tr>
       <tr style="display:none">
         <td>职务</td>
         <td nowrap><input name="job" type="text" id="job" value="<%=job%>" size="40"></td>
       </tr>
       <tr>
        <td>联系电话</td>
         <td nowrap><input name="phone" type="text" id="phone" value="<%=phone%>" size="40"></td>
       </tr>
        <tr>
        <td>传真</td>
         <td nowrap><input name="fax" type="text" id="fax" value="<%=fax%>" size="40"></td>
       </tr>
 <tr>
        <td>手机</td>
         <td nowrap><input name="mobile" type="text" id="mobile" value="<%=mobile%>" size="40"></td>
       </tr>
       <tr>
         <td>E-Mail</td>
         <td nowrap><input name="email" type="text" id="email" value="<%=email%>" size="40"></td>
       </tr>

              	<tr>
         <td>网址</td>
         <td nowrap><input name="url" type="text" id="url" value="<%=url%>" size="40"></td>
       </tr>
       <tr>
         <td>已做项目</td>
         <td nowrap><input name="have_a_project" type="text" id="have_a_project" value="<%=have_a_project%>" size="40"></td>
       </tr>
	   <tr>
         <td>开户行</td>
         <td nowrap><input name="bank" type="text" value="<%if(bank!=null)out.print(bank);%>" size="40"></td>
       </tr>
       <tr>
         <td>帐号</td>
         <td nowrap><input name="account" type="text"  value="<%if(account!=null)out.print(account);%>" size="40"></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

