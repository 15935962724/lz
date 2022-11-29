<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Itemoutlay" %><%@ page import="tea.entity.criterion.Outlay" %><%@ page import="tea.ui.TeaSession" %><%
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
  sql.append(" AND type LIKE "+DbAdapter.cite("%"+type+"%"));
}

String from=request.getParameter("from");
if(from!=null&&from.length()>0)
{
  sql.append(" AND money>="+from);
}

String to=request.getParameter("to");
if(to!=null&&to.length()>0)
{
  sql.append(" AND money<"+to);
}

String timefrom=request.getParameter("timefrom");
if(timefrom!=null&&timefrom.length()>0)
{
  sql.append(" AND time>="+DbAdapter.cite(timefrom));
}

String timeto=request.getParameter("timeto");
if(timeto!=null&&timeto.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(timeto));
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

<h1><%=request.getParameter("info")%><!--经费支付查询--></h1>
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
       <td>经费类别</td>
         <TD>经费数额</TD>
         <TD>拨付时间</TD>
         <TD>已划拨经费</TD>
         <TD>剩余经费</TD>
       </tr>
     <%
java.util.Enumeration enumer=Outlay.find(community,sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int outlay=((Integer)enumer.nextElement()).intValue();
  Outlay obj=Outlay.find(outlay);

  java.math.BigDecimal payment=Itemoutlay.findPaymentByOutlay(outlay);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=obj.getType()%></td>
    <td nowrap><%=obj.getMoney()%></td>
    <td nowrap><%=obj.getTimeToString()%>&nbsp;</td>
    <td><%=payment%></td>
    <td><%=obj.getMoney().subtract(payment)%></td>
  </tr>
  <%
}
     %>
  </table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onClick="window.open('/jsp/criterion/Export.jsp?act=Outlays2.jsp&community=<%=community%>&sql=<%=java.net.URLEncoder.encode(sql.toString(),"UTF-8")%>&name='+encodeURI('经费支付'));">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

