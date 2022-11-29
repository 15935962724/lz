<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource"  %><%@ page  import="tea.entity.criterion.*"   %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer(" AND states=9");//已完成

String code=(request.getParameter("code"));
if(code!=null&&code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
}

String fromplanyear=(request.getParameter("fromplanyear"));
if(fromplanyear!=null&&fromplanyear.length()>0)
{
  sql.append(" AND planyear>="+fromplanyear);
}

String toplanyear=(request.getParameter("toplanyear"));
if(toplanyear!=null&&toplanyear.length()>0)
{
  sql.append(" AND planyear<"+toplanyear);
}
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
</head>
<body>

<h1>已发布标准的项目</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>计划号
       <input name="code" size="10" ></td>
       <td>名称
       <input name="name"></td>
       <td>类别
         <select name="type">
	   <option value="">-------------
       <%
           for(int index=0;index<Item.ITEM_TYPE.length;index++)
           {
            out.print("<option value="+index);
            //if(index==type)
            //out.println(" SELECTED ");
            out.println(" >"+Item.ITEM_TYPE[index]);
           }
           %></select></td>

                <td>年度<textarea name="fromplanyear" mask="yyyy" cols="6" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea>
                -<textarea name="toplanyear" mask="yyyy" cols="6" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea>
       </td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>序号</td>
       <td nowrap>项目计划号</td>
         <TD nowrap>项目名称</TD>
         <TD nowrap>标准编号</TD>
         <TD nowrap>批准时间</TD>
         <TD nowrap>发布时间</TD>
         <TD nowrap>实施时间</TD>
         <!--TD nowrap>标准类别</TD-->
         <TD nowrap>是否现行标准</TD>
         <TD nowrap>编制单位</TD>
         <!--TD nowrap>备注</TD-->
       </tr>
     <%

java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int item=((Integer)enumer.nextElement()).intValue();
  Item obj=Item.find(item);

Itemmember im_obj=Itemmember.find(obj.getSupermanager(),community);
tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//obj.getEditgroup());
  %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><%=index%></td>
         <td nowrap><%=obj.getCode()%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=obj.getNumber()%></td>
         <td nowrap><%=obj.getGranttimeToString()%></td>
         <td nowrap><%=obj.getIssuetimeToString()%></td>
         <td nowrap><%=obj.getActualizetimeToString()%></td>
         <td nowrap><%=obj.isNonce()?"是":"否"%></td>
         <td nowrap><%if(au_obj.getName()!=null)out.print(au_obj.getName());%>&nbsp;</td>
        <!--td nowrap><%=obj.getRemark()%>&nbsp;</td-->

 </tr>
  <%
}
     %>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=FinishedItems.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('已发布标准的项目'));">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

