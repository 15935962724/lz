<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

int delid=0;
if(teasession.getParameter("delid")!=null && teasession.getParameter("delid").length()>0)
{
  delid =Integer.parseInt(teasession.getParameter("delid"));
  LevyPicture.delete(delid);
}


StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
param.append("?community="+teasession._strCommunity);
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
param.append("&id=").append(request.getParameter("id"));

String firstname="",tel="",card="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname= teasession.getParameter("firstname");
  sql.append(" and firstname =").append(DbAdapter.cite(firstname));
  param.append("&firstname=").append(firstname);
}
if(teasession.getParameter("card")!=null && teasession.getParameter("card").length()>0)
{
  card= teasession.getParameter("card");
  sql.append(" and card =").append(DbAdapter.cite(card));
  param.append("&card=").append(card);
}
if(teasession.getParameter("tel")!=null && teasession.getParameter("tel").length()>0)
{
  tel= teasession.getParameter("tel");
  sql.append(" and tel =").append(DbAdapter.cite(tel));
  param.append("&tel=").append(tel);
}
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count=LevyPicture.count(teasession._strCommunity,sql.toString());
%>
<html>
<head>
<link href="/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<script type="" >
function selectallf()
  {
    var a = document.getElementsByTagName("input");
    if(form2.selectall.checked==true)
    {
      for (var i=0; i<a.length; i++)
      {
        if (a[i].type == "checkbox" &&  (a[i].checked == false))
        {
          a[i].checked = true;
        }
      }
    }
    else
    {
      for (var i=0; i<a.length; i++)
      if (a[i].type == "checkbox" &&  (a[i].checked == true))
      {
        a[i].checked = false;
      }
    }
  }
  function find_sub()
  {
    var a = document.getElementsByTagName("input");
    if(form2.selectall.checked==false)
    {
      for (var i=0; i<a.length; i++)
      {
        if (a[i].type == "checkbox" &&  (a[i].checked == false))
        {
          alert("请点击全选后在进行全部导出。")
          return false;
        }
      }
    }
    else(form2.selectall.checked==true)
    {
     if(a.length==0)
     {
       alert("没有信息可以导出。")
       return false;
     }
    }
  }
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
</script>
</head>
<body>
<h1>征集摄影作品列表</h1>
<form action="?" method="GET"  name="form1">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table  id="tablecenter">
<tr>
<td>姓名：</td><td><input name="firstname" type="text" value="<%if(firstname!=null)out.print(firstname);%>" /></td><td>电话：</td><td><input name="tel" type="text" value="<%if(tel!=null)out.print(tel);%>" /></td>
</tr>
<tr><td>身份证号码：</td><td><input name="card" type="text" value="<%if(card!=null)out.print(card);%>" /></td><td><input type="submit"  value="查询" /></td>
</tr>
</table>
</form>

<form action="/jsp/ocean/LevyWord.jsp" name="form2" METHOD=POST >
<input  type="hidden" value="LevyPicture" name="act"/>
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="LevyPicture">
<input type="hidden" name="count" value="<%=count%>">
<table id="tablecenter">
<tr>
<td>序号</td><td>姓名</td><td>电话</td><td>身份证号码</td><td> </td>
</tr>
<%
java.util.Enumeration eu = LevyPicture.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!eu.hasMoreElements())
{
  %>
  <tr><td nowrap="nowrap" align="center" colspan="5">暂时没有信息</td></tr>
  <%
}
for(int i=0;eu.hasMoreElements();i++)
{
  int lid = Integer.parseInt(String.valueOf(eu.nextElement()));
  LevyPicture lobj = LevyPicture.find(lid);
  %>
  <tr>
  <td><input type="checkbox" name="ids" value="<%=lid%>" /><%=i%></td>
    <td><%if(lobj.getFirstname()!=null)out.print(lobj.getFirstname());%></td>
    <td><%if(lobj.getTel()!=null)out.print(lobj.getTel());%></td>
    <td><%if(lobj.getCard()!=null)out.print(lobj.getCard());%></td>
    <td><input type="button" value="编辑"  onclick="window.open('/jsp/ocean/EditLevyPicture.jsp?ids=<%=lid%>','_self')"/>

  <input name="按钮" type="button" value="删除" onClick="if(confirm('确认删除？')){window.open('/jsp/ocean/LevyPicture.jsp?delid=<%=lid%>', '_self');this.disabled=true;};" >
<input type="button" value="导出word" onclick="window.open('/jsp/ocean/LevyWord.jsp?ids=<%=lid%>','_self')"> </td>

  </tr>
  <%
}
%>  <tr>
    <td colspan="6"  ><input type="checkbox" name="selectall" onClick="selectallf();" class="1">全选</td>
  </tr>
 <tr><td colspan="5"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

</table>
<input type="submit" value="导出word"   onclick="return find_sub()"/>
</form>
</body>
</html>
