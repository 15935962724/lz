<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("delete")!=null)
{
  int outlay=Integer.parseInt(request.getParameter("outlay"));
  Outlay obj=Outlay.find(outlay);
  obj.delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+request.getParameter("nexturl"));
  return;
}
String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND o.type LIKE "+DbAdapter.cite("%"+type+"%"));
}

String from=request.getParameter("from");
if(from!=null&&from.length()>0)
{
  sql.append(" AND io.money>="+from);
}

String to=request.getParameter("to");
if(to!=null&&to.length()>0)
{
  sql.append(" AND io.money<"+to);
}

String timefrom=request.getParameter("timefrom");
if(timefrom!=null&&timefrom.length()>0)
{
  sql.append(" AND io.time>="+DbAdapter.cite(timefrom));
}

String timeto=request.getParameter("timeto");
if(timeto!=null&&timeto.length()>0)
{
  sql.append(" AND io.time<"+DbAdapter.cite(timeto));
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

<h1>经费支付明细</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td nowrap>经费类别
       <input name="type" size="10" ></td>
       <td nowrap>经费数额
              <textarea name="from" mask="nnnnnnnn.nn" cols="15" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea>
         -
         <textarea name="to" mask="nnnnnnnn.nn" cols="15" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea>
</td>
          <td nowrap>时间
            <textarea name="timefrom" mask="yyyy-mm-dd" cols="15" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea><img onClick="showCalendar('foEdit.timefrom');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >
         -
         <textarea name="timeto" mask="yyyy-mm-dd" cols="15" rows="1" style="BEHAVIOR:url(/jsp/EAFformat.htc);OVERFLOW: hidden ;"></textarea><img onClick="showCalendar('foEdit.timeto');"  align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >

       </td>
         <td nowrap><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td></td>
       <td>经费类别</td>
         <TD>计划号</TD>
         <TD>项目名称</TD>
         <TD>编制单位</TD>
         <TD>拨付金额</TD>
         <TD>拨付时间</TD>
       </tr>
     <%
java.util.Enumeration enumer=Itemoutlay.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int itemoutlay=((Integer)enumer.nextElement()).intValue();
  Itemoutlay obj=Itemoutlay.find(itemoutlay);

Outlay outlay=Outlay.find(obj.getOutlay());
Item item=Item.find(obj.getItem());

Itemmember im_obj=Itemmember.find(item.getSupermanager(),community);
tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//item.getEditgroup());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td><%=index%></td>
        <td><%=outlay.getType()%></td>
        <td><%=item.getCode()%></td>
        <td><%=item.getName()%></td>
        <td><%if(au_obj.getName()!=null)out.print(au_obj.getName());%></td>
         <td nowrap><%=obj.getMoney()%></td>
         <td nowrap><%=obj.getTimeToString()%>&nbsp;</td>
 </tr>
  <%
}
     %>
  </table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=Itemoutlays2.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('经费支付明细'));">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

