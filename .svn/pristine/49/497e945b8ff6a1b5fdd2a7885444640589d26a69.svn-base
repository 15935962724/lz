<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

int hoid = Integer.parseInt(teasession.getParameter("hoid"));
Hospital hoooobj = Hospital.find(hoid);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

sql.append(" and hoid!=").append(hoid);
param.append("&hoid=").append(hoid);
String honame = teasession.getParameter("honame");
if(honame!=null && honame.length()>0)
{
  sql.append(" and honame like ").append(DbAdapter.cite("%"+honame+"%"));
  param.append("&honame=").append(java.net.URLEncoder.encode(honame,"utf-8"));
}
//所属省市
int sheng=0;
if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
{
  sheng = Integer.parseInt(teasession.getParameter("sheng"));
}


if(sheng>0)
{
  Provinces p1 = Provinces.find(sheng);
  sql.append(" AND provincial ="+DbAdapter.cite(p1.getProvincity())+" ");
  param.append("&sheng=").append(sheng);
}
int shi=0;
if(teasession.getParameter("shi")!=null && teasession.getParameter("shi").length()>0)
{
  shi = Integer.parseInt(teasession.getParameter("shi"));
}

if(shi>0)
{
   Provinces p2 = Provinces.find(shi);
  sql.append(" AND city ="+DbAdapter.cite(p2.getProvincity())+" ");
  param.append("&shi=").append(shi);
}



int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Hospital.count(sql.toString());


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医院合并管理</title>
</head>
<body id="bodynone" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes" onload="f_sheng('<%=shi%>');" >
<script>
window.name='tar';
//所属省市
 function f_sheng(igd){
         sendx("/jsp/admin/orthonline/city_ajax.jsp?doid=0&shiid="+igd+"&act=city&sheng="+form1.sheng.value,
         function(data)
         {
           document.getElementById("show").innerHTML=data;
         }
         );
 }
 function f_shi()
 {}
 function f_hb(igd,igdname)
 {

   //if(confirm('您真的要确定合并这个医院吗？合并完成后，系统会自动删除此医院，请慎重合并.'))
   if(confirm('您要把医院【<%=hoooobj.getHoname()%>】合并成医院【'+igdname+'】吗?\n\r合并完成以后,系统会自动删除医院【<%=hoooobj.getHoname()%>】,请慎重合并.'))
   {
     sendx("/jsp/admin/orthonline/city_ajax.jsp?act=Merge2&hoid="+form1.hoid.value+'&hoid2='+igd,
     function(data)
     {
       //document.getElementById("show").innerHTML=data;
       alert(data);
       window.returnValue=1;
       window.close();
     }
     );
   }
 }


</script>
<h1>医院合并管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询</h2>
   <form action="/jsp/admin/orthonline/Merge2.jsp" name="form1"  method="get"   target="tar"><!--/servlet/EditDoctor-->
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>" />
   <input type="hidden" name="hoid" value="<%=hoid%>" />

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <td>医院名称:</td>
     <td><input type="text" name="honame" value="<%if(honame!=null)out.print(honame);%>" ></td>

     <td>所属省市:</td>
     <td>
      <select name="sheng" onchange="f_sheng('0');" >
          <option value="0">请选择省份/直辖市</option>
          <%
          java.util.Enumeration e2 = Provinces.find(" AND type=0 ");
          while(e2.hasMoreElements())
          {
            int proid = ((Integer)e2.nextElement()).intValue();
            Provinces pobj = Provinces.find(proid);
            out.print("<option value="+proid);
            if(sheng==proid)
            {
              out.print(" selected");
            }
            out.print(">"+pobj.getProvincity());
            out.print("</option>");
          }
          %>
        </select>
        <span id="show">
        <select name="shi">
          <option value="0">请选择市/县</option>
        </select>
       </span>
     </td>
     <td><input type="submit" value="查询"/></td>
     </table>
<h2>列表<%=count %></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>医院名称</td>
       <td nowrap>医院地区</td>
      <td nowrap>操作</td>
    </tr>
<%

java.util.Enumeration  e = Hospital.find(sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
 for(int i =1;e.hasMoreElements();i++)
 {
   int hoid2 =((Integer)e.nextElement()).intValue();
  Hospital hobj = Hospital.find(hoid2);


%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><%=i %></td>
<td><%=hobj.getHoname()%></td>
<td><%if(hobj.getProvincial()!=null)out.print(hobj.getProvincial()+"&nbsp;"+hobj.getCity());else out.print("暂无地区");%></td>
<td><input type="button" value="合并"  onclick="f_hb('<%=hoid2%>','<%=hobj.getHoname()%>');"></td>
</tr>
<%} %>
<%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
  </table>


  </form>
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
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
