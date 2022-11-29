<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int expertres=Integer.parseInt(request.getParameter("expertres"));



Resource r=new Resource();

String name,unit,duty,title,phone,fax,mobile,email,zip,bookname,bookconcern,article,magazine  ,specialty,degree,experience,address,birthtime;
int calling=-1;
java.util.Date issuetime=null,appeartime=null;
if(expertres!=0)
{
  Expertres obj=Expertres.find(expertres);
  name=obj.getName();
  unit=obj.getUnit();
  calling=obj.getCalling();
  specialty=obj.getSpecialty();
  duty=obj.getDuty();
  title=obj.getTitle();
  phone=obj.getPhone();
  mobile=obj.getMobile();
  fax=obj.getFax();
  email=obj.getEmail();
  zip=obj.getZip();
  bookname=obj.getBookname();
  bookconcern=obj.getBookconcern();
  article=obj.getArticle();
  magazine=obj.getMagazine();
  issuetime=obj.getIssuetime();
  appeartime=obj.getAppeartime();
  birthtime=obj.sdf.format(obj.getBirthtime());
  degree=obj.getDegree();
  experience=obj.getExperience();
  address=obj.getAddress();
}else
{
  specialty=name=unit=duty=title=phone=fax=mobile=email=zip=bookname=bookconcern=article=magazine=  degree=experience=address=birthtime="";
//  java.util.Calendar c=java.util.Calendar.getInstance();
//  c.set(c.YEAR,c.get(c.YEAR)-35);
//  birthtime=c.getTime();
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
  document.form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>专家资源创建</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditItem" method="post" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-姓名')&&submitText(this.birthtime, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-出生日期')&&submitText(this.calling, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-行业')&&submitText(this.specialty, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-专长')">
<input type=hidden name="expertres" value="<%=expertres%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="EditExpertres"/>
<input type=hidden name="item" value="0"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>姓名:</td>
         <TD><input name="name" type="text" id="name" value="<%=name%>"></TD>
     </tr>
       <tr>
        <td>出生日期</td>
         <td nowrap>
           <textarea name="birthtime" mask="yyyy-mm-dd" cols="12" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"><%=birthtime%></textarea><img onClick="showCalendar('form1.birthtime');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >
           <%//=new tea.htmlx.TimeSelection("birthtime", birthtime)%>
         </td>
       </tr>

              <tr>
         <td>专长</td>
         <td nowrap>
         <input type="text" name="specialty" value="<%=specialty%>" size="40"/>
         <%--
         <select name="specialty" id="specialty">
	   <option value="" >------------
       <%
           for(int index=0;index<Expertres.SPECIALTY_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==specialty)
            out.print(" SELECTED ");
            out.println(" >"+Expertres.SPECIALTY_TYPE[index]);
           }
           %></select> --%>
         </td>
       </tr>





 <tr>
        <td>通讯地址</td>
         <td nowrap><input name="address" type="text" id="address" value="<%=address%>" size="40"></td>
       </tr>
	    <tr>
        <td>邮编</td>
        <td nowrap><input name="zip"  type="text" id="zip" value="<%=zip%>" maxlength="6" ></td>
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
        <td>职位</td>
         <td nowrap><input name="duty" type="text" id="duty" value="<%=duty%>" size="40"></td>
       </tr>
        <tr>
        <td>职称</td>
         <td nowrap><input name="title" type="text" id="title" value="<%=title%>" size="40"></td>
       </tr>
        <tr>
        <td>单位</td>
         <td nowrap><input name="unit" type="text" id="unit" value="<%=unit%>" size="40"></td>
       </tr>
       <tr>
        <td>学历</td>
         <td nowrap><input name="degree" type="text"  value="<%=degree%>" size="40"></td>
       </tr>
       <tr>
        <td>工作经历</td>
         <td nowrap>
		 <textarea name="experience" cols="50" rows="6" id="experience"><%=experience%></textarea>
	</td>
       </tr>
       <tr>
        <td>著作论文</td>
         <td nowrap>
		 <textarea name="bookname" cols="50" rows="6" id="bookname"><%=bookname%></textarea>
	</td>
       </tr>

</table>
<table style="display:none" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>行业</td>
         <td nowrap>
           <select name="calling" id="calling">
	  <option value="255" >------------
       <%
           for(int index=0;index<Expertres.CALLING_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(index==calling)
            out.print(" SELECTED ");
            out.println(" >"+Expertres.CALLING_TYPE[index]);
           }
           %></select>         </td>
       </tr>
       <tr>

        <td>出版社</td>
         <td nowrap><input name="bookconcern" type="text" id="bookconcern" value="<%=bookconcern%>" size="40"></td>
       </tr>
       <tr>
        <td>出版日期</td>
         <td nowrap>
         <%=new tea.htmlx.TimeSelection("issuetime", issuetime)%></td>
       </tr>
       <tr>
        <td>文章</td>
         <td nowrap><input name="article" type="text" id="article" value="<%=article%>" size="40"></td>
       </tr>
       <tr>
        <td>发表期刊</td>
         <td nowrap><input name="magazine" type="text" id="magazine" value="<%=magazine%>" size="40"></td>
       </tr>
       <tr>
        <td>发表日期</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("appeartime", appeartime)%></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>

         </td>
       </tr>
  </table>
             <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


