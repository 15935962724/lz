<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.im.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl=request.getParameter("nexturl");

int imdirectory=Integer.parseInt(request.getParameter("imdirectory"));



Resource r=new Resource();

long len=0L;
int type=-1;
String name,picture,url;
if(imdirectory!=0)
{
  Imdirectory obj=Imdirectory.find(imdirectory);
  name=obj.getName().replaceAll("\"","&quot;");
  picture=obj.getPicture();
  if(picture!=null)
  len=new java.io.File(application.getRealPath(picture)).length();
  url=obj.getUrl();
  type=obj.getType();
}else
{
  name=picture=url="";
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
  form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditIm" method="post" enctype="multipart/form-data" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')&&submitText(this.url, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-URL')&&submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-类型')">
<input type=hidden name="imdirectory" value="<%=imdirectory%>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="editimdirectory"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
        <td>名称</td>
         <td nowrap><input name="name" type="text" id="name" value="<%=name%>" size="40"></td>
       </tr>
       <tr>
         <td>缩略图</td>
         <td nowrap><input type=file name="picture" > <%if(len>0)out.print(len+r.getString(teasession._nLanguage,"Bytes")+"<input type=checkbox name=clear onclick=\"form1.picture.disabled=this.checked;\"/>清空");%>
         </td>
       </tr>
       <tr>
         <td>URL</td>
         <td nowrap><input name="url" type="text" value="<%=url%>" size="50"></td>
       </tr>
       <tr>
         <td>类型</td>
         <td nowrap><select name="type">
         <option value="">----------------</option>
         <%
         for(int i=0;i<Imdirectory.IMD_TYPE.length;i++)
         {
           out.print("<option value="+i);
           if(type==i)
           out.print(" SELECTED ");
           out.print(" >"+Imdirectory.IMD_TYPE[i]);
         }
         %>
         </select>
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit"  value="提交">
           <input type="reset"  value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



