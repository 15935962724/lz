<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.entity.criterion.Egqb" %><%@ page import="tea.ui.TeaSession" %><%
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
int egqb=Integer.parseInt(request.getParameter("egqb"));



Resource r=new Resource();

Item obj=Item.find(item);

String question,advice,result,fileuri,filename;
if(item!=0)
{
  Egqb obj2=Egqb.find(egqb);
  question=obj2.getQuestion().replaceAll("&lt;","<").replaceAll("&","&amp;");
  advice=obj2.getAdvice().replaceAll("&lt;","<").replaceAll("&","&amp;");
  result=obj2.getResult().replaceAll("&lt;","<").replaceAll("&","&amp;");
  fileuri=obj2.getFileuri();
  filename=obj2.getFilename();
}else
{
  question=advice=result=fileuri=filename="";
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
  form1.question.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>季报</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" onSubmit="return submitText(this.item,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目计划号')&&submitText(this.question, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-存在问题');">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="egqb" value="<%=egqb%>"/>
<input type=hidden name="act" value="egqb"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD>
         <%
         if(item==0)
         {
           StringBuffer sql=new StringBuffer();
           tea.entity.admin.AdminUsrRole aur_obj=tea.entity.admin.AdminUsrRole.find(community,teasession._rv.toString());
           String role=aur_obj.getRole();
           int adminrole_id_manager=tea.entity.admin.AdminRole.findByName("标准所高级管理员",community);
           int adminrole_id_sysmanager=tea.entity.admin.AdminRole.findByName("标准处高级管理员",community);
           if((adminrole_id_manager<1||role.indexOf("/"+adminrole_id_manager+"/")==-1)&&(adminrole_id_sysmanager<1||role.indexOf("/"+adminrole_id_sysmanager+"/")==-1))
           {
             //  sql.append(" AND(supermanager="+DbAdapter.cite(teasession._rv.toString())+" OR manager="+DbAdapter.cite(teasession._rv.toString())+" OR director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR personnel LIKE "+DbAdapter.cite("%/"+teasession._rv.toString()+"/%")+")");
             sql.append(" AND(director="+DbAdapter.cite(teasession._rv.toString())+" OR principal="+DbAdapter.cite(teasession._rv.toString())+" OR editgroup="+aur_obj.getUnit()+" )");
           }

           StringBuffer script=new StringBuffer();
           out.print("<select name=item onchange=fonchange(this.value) >");
           out.print("<option value=\"\" >-------------");
           java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
           while(enumer.hasMoreElements())
           {
             item=((Integer)enumer.nextElement()).intValue();
             Item item_obj=Item.find(item);
             script.append("case '"+item+"': obj.innerText='"+item_obj.getName()+"';break;");
             out.print("<option value="+item +">"+Item.find(item).getCode());
           }
           out.print("</select>　<span id=span_itemname ></span>");
           out.print("<script>function fonchange(value){ var obj=document.getElementById('span_itemname');switch(value){"+script.toString()+"default:obj.innerText='';} }</script>");
         }else
         {
           out.print(obj.getCode()+"<input type=hidden name=item value="+item+" >　　"+obj.getName());
         }
         %>

</TD>
</tr>
       <tr>
         <td>存在问题</td>
         <td nowrap><textarea name="question" cols="50" rows="4" id="question" ><%=question%></textarea>
         </td>
       </tr>
       <tr>
         <td>措施或建议</td>
         <td nowrap>
         <textarea name="advice" cols="50" rows="4" id="advice" ><%=advice%></textarea></td>
       </tr>
       <tr>
         <td>处理结果</td>
         <td nowrap>
         <textarea name="result" cols="50" rows="4" id="result" ><%=result%></textarea></td>
       </tr>
       <tr>
         <td>季报文档</td>
         <td nowrap><input name="fileuri" type="file" id="fileuri"  onChange="fview(this);"  size="40">
         <%
         java.io.File file=new java.io.File(application.getRealPath(fileuri));
         if(file.exists()&&file.isFile())
         {
           out.print(file.length()+r.getString(teasession._nLanguage,"Bytes"));
           out.print("　<a href=ItemDownload.jsp?egqbs=ON&act=file&item="+item+"&egqb="+egqb+" >"+filename+"</a>");
         }
         %>
         <a id="a_fileuri" href="###" style="display:none" ><img id="img_fileuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_fileuri"></span></a>
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="reset" value="返回" onClick="history.back();">
        </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


