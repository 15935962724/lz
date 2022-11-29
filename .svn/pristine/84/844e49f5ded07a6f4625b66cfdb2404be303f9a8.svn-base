<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int flowitem = 0;
if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
{
  flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
}
StringBuffer sql = new StringBuffer("  AND flowitem="+flowitem);
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&flowitem=").append(flowitem);

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND timemoney >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND timemoney <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}




int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Already.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY timemoney DESC");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script type="">
window.name='tar';
function f_c(igd,igd2,igd3)
{

  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:375px;';
  var url = '/jsp/admin/workreport/EditAlready.jsp?flowitem='+igd+"&alid="+igd2+"&act="+igd3;
  var rs =  window.showModalDialog(url,self,y);
  if(rs==1)
  {
    window.open(location.href+"&t="+new Date().getTime(),window.name);
  }
}
</script>

<h1>项目收支记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form name=form1 method="POST" action="?"  target="tar">
    <input type="hidden" name="flowitem" value="<%=flowitem%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>收支日期：</td>
        <td>
        从&nbsp;
        <input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_c);" alt="" />
        &nbsp;到&nbsp;
        <input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_d);" alt="" />
        </td>
        <td><input type="submit" value="查询"/></td>
      </tr>
    </table>
    <h2>列表(项目收款记录共&nbsp;<%=count %>&nbsp;条)</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>收支日期</td>
        <td nowrap>收支说明</td>
        <td nowrap>收支方式</td>
        <td nowrap>甲方经办人</td>
        <td nowrap>乙方经办人</td>
        <td nowrap>发票情况</td>
        <td nowrap>收支金额</td>
        <td nowrap>收支类型</td>
        <td nowrap>&nbsp;</td>
      </tr>
      <%
      java.util.Enumeration e = Already.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      while(e.hasMoreElements()){
        int alid = ((Integer)e.nextElement()).intValue();
        Already  alobj = Already.find(alid);
        Profile pobja = Profile.find(alobj.getMembera());
        Profile pobjb = Profile.find(alobj.getMemberb());
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><%=alobj.getTimemoneyToString()%></td>
          <td><%=alobj.getProject()%></td>
          <td><%=Already.WAY_TYPE[alobj.getWay()]%></td>
          <td><%=pobja.getLastName(teasession._nLanguage)+pobja.getFirstName(teasession._nLanguage) %></td>
          <td><%=pobjb.getLastName(teasession._nLanguage)+pobjb.getFirstName(teasession._nLanguage)%></td>
          <td><%if(alobj.getInvoice()==0){out.print("未开");}else if(alobj.getInvoice()==1){out.print("已开");}%></td>
          <td><%=alobj.getAmount()%></td>
           <td nowrap><%=Already.ALREADYTYPE[alobj.getAtype()]%></td>
          <td><a href="#"  onclick="f_c('<%=flowitem%>','<%=alid%>','act');">编辑</a>&nbsp;<a href="#" onclick="f_c('<%=flowitem%>','<%=alid%>','delete');">删除</a></td>
        </tr>
        <%} %>
         <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
    </table>
    <br>

    <input type="button" value="添加项目收款记录" onclick="f_c('<%=flowitem%>','0','act');" >&nbsp;
    <input type="button" value="关闭"  onClick="javascript:window.close();">

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>



