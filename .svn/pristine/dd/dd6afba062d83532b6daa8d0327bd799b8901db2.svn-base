<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@page import="java.util.*"%><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
    response.sendError(403);
    return;
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function flen(obj,text)
{
  if(obj.value<1||obj.value>1000)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>
<body onload="form1.select.onchange();">

<h1>生成卡号</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="/servlet/EditCode" method="post" name="form1" onsubmit="return submitInteger(form1.parvalue,'无效-面值')&&submitInteger(form1.quantity,'无效-数量');" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="time" value=""/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><br>面值</td>
  <td>
  <span style="position:absolute;">
 <select name="select" style="position:absolute;top:0px; width: 150px; height: 0px; left: 0px; clip: rect(0 180 20 130) " onChange="parvalue.value=this.value;parvalue.focus();">
  <%
  for(int index=0;index<Code.PARVALUE_TYPE.length;index++)
  {
    out.print("<option value="+Code.PARVALUE_TYPE[index]);
    if(index==1)
    out.print(" selected ");
    out.print(" >"+Code.PARVALUE_TYPE[index]+"</option>");
  }
  %>
  </select>
  <input name="parvalue" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text" value="" style="position:absolute;top:0px; width: 132px; height:20px; left:0px;">
    </span>
  </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>数量</td>
    <td><input name="quantity" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" type="text" id="quantity" value="10"></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>有效期</td>
    <td><select name="validity" >
    <option>1
    <option>2
    <option>3
    <option>4
    <option>5
    <option>10
    <option>20
    </select>年</td>
  </tr>
</table>
<input type="submit"  value="提交" onclick="return submitInteger(form1.quantity,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-数量(1-1000)')&&flen(form1.quantity,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-数量(1-1000)')">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr"><td>卡号</td>
<td>数量</td>
<td>面值</td>
<td>时间</td>
<td></td>
</tr>
<%
int pos=0;
int pageSize=Integer.MAX_VALUE;
DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT MIN(code),MAX(code),COUNT(time),MAX(parvalue),time FROM Code WHERE community="+dbadapter.cite(teasession._strCommunity)+" GROUP BY time ORDER BY time DESC");
            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
           String code=dbadapter.getInt(1)+"-"+dbadapter.getInt(2);
           int count=dbadapter.getInt(3);
           java.math.BigDecimal parvalue=dbadapter.getBigDecimal(4, 2);
           java.util.Date time=dbadapter.getDate(5);
                      %>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" ><td><%=code%></td>
<td><%=count%></td>
<td><%= parvalue%></td>
<td><%=time%></td>
<td>
<input type="button" onclick="window.open('/jsp/profile/Codes.jsp?time=<%=time.getTime()%>&parvalue=<%=parvalue%>','_self');" value="查看">
<input type="submit" name="export" onclick="form1.time.value='<%=time.getTime()%>';" value="导出">
</td>
</tr>
  <%
                }
            }
        } catch (Exception exception)
        {
            exception.printStackTrace();
            //throw new EntityException(exception.toString());
        } finally
        {
            dbadapter.close();
        }
%>
<%--
java.util.Enumeration enumer=Code.find(community,pos,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  Code obj=(Code)enumer.nextElement();

  %>
<tr><td><%=obj.getCode()%></td>
<td><%=obj.getParvalue()%></td>
<td><%=obj.getTimeToString()%></td>
</tr>
  <%
}
--%>
</table>
</form>
<div id="head6"><img height="6" alt=""></div>
</body>
</html>
