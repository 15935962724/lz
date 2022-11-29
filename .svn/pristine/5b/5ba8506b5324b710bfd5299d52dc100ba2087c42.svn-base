<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
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

StringBuffer sql=new StringBuffer(" and type = 0 and manager like "+DbAdapter.cite("%"+teasession._rv.toString()+"%"));

String querykey = request.getParameter("querykey") ;

String _strId=request.getParameter("itemgenre");

int _id =(_strId==null?2:Integer.parseInt(_strId)) ;


String content=request.getParameter("content");

String order=request.getParameter("order");


if(querykey!=null&&(querykey=querykey.trim()).length()>0)
{
  sql.append(" and flowitem in (select flowitem from  FlowitemLayer  where name like "+DbAdapter.cite("%"+querykey+"%")+" )");
  param.append("&name=").append(java.net.URLEncoder.encode(querykey,"UTF-8"));

  order="flowitem";
  param.append("&order=").append(order);
}
else{
  //非查询语句

  param.append("&community=").append(community) ;

  if(_strId!=null&&_strId.length()>0)
  {
    param.append("&itemgenre=").append(_strId);
    sql.append(" AND itemgenre=").append(_strId);
  }
  else
  {
    param.append("&itemgenre=").append(_id);
    sql.append(" AND itemgenre=").append(_id);
  }


  if(content!=null&&(content=content.trim()).length()>0)
  {
    sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
  }

  if(order==null)
  order="ctime";
  param.append("&order=").append(order);

}



int count= Flowitem.count(community,sql.toString());


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();
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
function RequestParameter(c,wp,fi)
{
  //window.open('/jsp/admin/workreport/ItemMenu.jsp?community='+c+'&workproject='+wp+'&flowitem='+fi,'Itemmenu');
   window.open('/jsp/admin/workreport/ItemManage_1.jsp?community='+c+'&workproject='+wp+'&flowitem='+fi,'m');
  //window.open('/jsp/admin/workreport/WorkFormList.jsp?community='+c+'&workproject='+wp+'&flowitem='+fi,'m');
}

function ResponseOnload(wp,fi)
{
   window.open('/jsp/admin/workreport/ViewWorkproject2.jsp?workproject='+wp+'&flowitem='+fi,'VWproject2');
   window.open('/jsp/admin/workreport/ItemMenu.jsp?workproject='+wp+'&flowitem='+fi,'Itemmenu');
}

function ResponseOnloadNull(fi)
{
   window.open('/jsp/admin/workreport/ViewWorkproject2.jsp?flowitem='+fi,'VWproject2');
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
  <div>
  <!--h2><%=Flowitem.ITEMGENRE_TYPE[_id]%></h2-->
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter33">
  <%
  java.util.Enumeration enumer=Flowitem.find(community,sql.toString(),pos,15);
  String _itemName =  r.getString(teasession._nLanguage,"暂无项目");

  if(!enumer.hasMoreElements())
  {
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%out.print(_itemName);%> </td>
    </tr>
    <%
//    out.print("<script>document.body.onload=ResponseOnloadNull('kong');</script>");
  }
  else{
    int ii =1;
    while(enumer.hasMoreElements())
    {
      int flowitem=((Integer)enumer.nextElement()).intValue();

      Flowitem obj=Flowitem.find(flowitem);
      int workproject = obj.findByFlowitem(community,"AND flowitem= "+flowitem);

//      if(ii==1)
//      {
//        out.print("<script>document.body.onload=ResponseOnload("+workproject+","+flowitem+");</script>");
//      }
      _itemName = obj.getName(teasession._nLanguage);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td nowrap>&nbsp;<a href="javascript:RequestParameter('<%=teasession._strCommunity%>','<%=workproject%>','<%=flowitem%>');"><%=_itemName%></a></td>
      </tr>
      <%
      ii++;
    }
  }
  %>
  <tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,15)%></td></tr>
</table>
</div>
</body>
</html>


