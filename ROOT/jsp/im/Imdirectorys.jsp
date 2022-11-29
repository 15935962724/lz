<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.im.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();


String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}

String _strId=request.getParameter("id");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function moveimd(igd,sequence)
{
  form1.imdirectory.value=igd;
  form1.act.value='moveimdirectory';
  form1.sequence.value=sequence;
  form1.action='/servlet/EditIm';
  form1.submit();
}
function editimd(igd)
{
  form1.imdirectory.value=igd;
  form1.action='/jsp/admin/im/EditImdirectory.jsp';
  form1.submit();
}
function deleteimd(igd)
{
  if(confirm('确认删除'))
  {
    form1.imdirectory.value=igd;
    form1.action='/servlet/EditIm';
    form1.act.value='deleteimdirectory';
    form1.submit();
  }
}
</script>
</head>
<body>

<h1>主页内容目录管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<FORM name=form1 METHOD=get action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<script>document.write("<input type=hidden name=nexturl value="+document.location+">");</script>
<input type=hidden name="id" value="<%=_strId%>"/>
<input type=hidden name="act" >
<input type=hidden name="imdirectory">
<input type=hidden name="sequence">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><input type="submit" value="查询"/></td>
     </tr>
</table>


<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
         <TD>名称</TD>
         <TD>缩略图</TD>
         <TD>URL</TD>
         <TD>类型</TD>
         <TD>排序</TD>
         <TD>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration e=Imdirectory.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;e.hasMoreElements();index++)
{
  int igd=((Integer)e.nextElement()).intValue();
  Imdirectory obj=Imdirectory.find(igd);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><img onerror="this.style.display='none';" src="<%=obj.getPicture()%>" ></td>
         <td nowrap><a href="<%=obj.getUrl()%>" target="_blank"><%=obj.getUrl()%></a></td>
         <td nowrap><%=Imdirectory.IMD_TYPE[obj.getType()]%></td>
         <td nowrap><%
         if(index>1)
         {
           out.print("<a href=javascript:moveimd("+igd+",-3); ><img src=/tea/image/public/arrow_up.gif></a>");
         }
         if(e.hasMoreElements())
         {
           out.print("<a href=javascript:moveimd("+igd+",3); ><img src=/tea/image/public/arrow_down.gif></a>");
         }
         %></td>
        <td nowrap>
        <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="editimd(<%=igd%>);">
       <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="deleteimd(<%=igd%>);">
      </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="editimd(0);">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



