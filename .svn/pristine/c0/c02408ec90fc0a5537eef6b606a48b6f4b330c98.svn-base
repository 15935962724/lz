<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="name";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script language="javascript">
function RequestParameter(c,wp)
{
   window.open('/jsp/admin/workreport/ItemMenu.jsp?community='+c+'&workproject='+wp,'Itemmenu');
   window.open('/jsp/admin/workreport/ViewWorkproject2.jsp?community='+c+'&workproject='+wp,'VWproject2');
   //window.open('/jsp/admin/workreport/WorkFormList.jsp?community='+c+'&workproject='+wp,'VWproject2');

}

function ResponseWorklogs(page,v)
{
   window.open('/jsp/admin/workreport/'+page+'?go='+v,'Worklogs_10');
}

function changId(a)
{
  var ci=document.getElementById('currentbunan');
  if(ci)
  {
    ci.id='bunan';
  }
  a.id='currentbunan';
}
</script>
</head>
<body>
  <%
   String quanxian = request.getParameter("quanxian");
   String webpage = "Worklogs_10.jsp";
   String pages = "Worklogs_10.jsp";
   if(quanxian!=null)
   {
     webpage = "Worklogs_11.jsp";
     pages = "Worklogs_11.jsp";
   }
   %>

<form method="POST"  name="form1">
<input type="hidden" name="sql" value="">
  <input type="hidden" name="files" value="clientserver">
  <div style="width:100%;border-bottom:3px solid #f2f2f2;">

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter1" >
       <tr>
         <td><a id="bunan" onClick="changId(this)"  onfocus=this.blur()  href="/jsp/admin/workreport/<%=webpage%>?itemgenre=1" target="Worklogs_10"><img style="margin-top:3px;" src="/jsp/img/qt.gif" alt="<%=r.getString(teasession._nLanguage,"洽谈中")%>"></a></td>
         <td><a id="bunan" onClick="changId(this)"  onfocus=this.blur()  href="/jsp/admin/workreport/<%=webpage%>?itemgenre=2" target="Worklogs_10"><img style="margin-top:3px;" src="/jsp/img/jx.gif" alt="<%=r.getString(teasession._nLanguage,"进行中")%>"></a></td>
         <td><a id="bunan" onClick="changId(this)"  onfocus=this.blur()  href="/jsp/admin/workreport/<%=webpage%>?itemgenre=3" target="Worklogs_10"><img style="margin-top:3px;" src="/jsp/img/wh.gif" alt="<%=r.getString(teasession._nLanguage,"维护中")%>"></a></td>
         <td><a id="bunan" onClick="changId(this)"  onfocus=this.blur()  href="/jsp/admin/workreport/<%=webpage%>?itemgenre=4" target="Worklogs_10"><img style="margin-top:3px;" src="/jsp/img/wc.gif" alt="<%=r.getString(teasession._nLanguage,"已完成")%>"></a></td>
         <td><a id="bunan" onClick="changId(this)"  onfocus=this.blur()  href="/jsp/admin/workreport/<%=webpage%>?itemgenre=5" target="Worklogs_10"><img style="margin-top:3px;" src="/jsp/img/qx.gif" alt="<%=r.getString(teasession._nLanguage,"已取消")%>"></a></td>
       </tr>
  </table>
</div>
</form>
</body>
</html>



