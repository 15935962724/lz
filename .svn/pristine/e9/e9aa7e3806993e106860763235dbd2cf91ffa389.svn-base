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


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

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

sql.append(" order by honame asc ");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医院管理</title>
</head>
<body id="bodynone" onload="f_sheng('<%=shi%>');" >
<script>
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

 function f_c(igd)
 {
   rs = window.showModalDialog('/jsp/admin/orthonline/Merge2.jsp?honame='+encodeURIComponent(form1.honame.value)+'&shi='+form1.shi.value+'&sheng='+form1.sheng.value+'&hoid='+igd+'&community='+form1.community.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
   if(rs!=null){
        window.open(location.href+"&t="+new Date().getTime(),window.name);
   }
 }
 function f_edit(igd)
 {
   form1.hoid.value=igd;
   form1.action='/jsp/admin/orthonline/EditHospital.jsp';
   form1.submit();
 }
 function f_delete(igd)
 {
    if(confirm('您真的要删除这个医院吗?'))
   {
     form1.hoid.value=igd;
     form1.act.value='delete';
     form1.action='/servlet/EditHospital';
     form1.submit();
   }

 }

</script>
<h1>医院管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询</h2>
   <form action="?" name="form1"  method="post"><!--/servlet/EditDoctor-->
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>" />
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
        <input type="hidden" name="nexturl" value="<%=nexturl%>" />
        <input type="hidden" name="hoid" />
        <input type="hidden" name="act"/>
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

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个医院&nbsp;)</h2>
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
   int hoid =((Integer)e.nextElement()).intValue();
  Hospital hobj = Hospital.find(hoid);


%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td width="1"><%=i+pos %></td>
<td><%=hobj.getHoname()%></td>
<td><%if(hobj.getProvincial()!=null)out.print(hobj.getProvincial()+"&nbsp;"+hobj.getCity());else out.print("暂无地区");%></td>
<td><a href="#"  onclick="f_edit('<%=hoid%>');">编辑</a>&nbsp;<a href="#"  onclick="f_delete('<%=hoid%>');">删除</a> </td>
</tr>
<%} %>
<%if (count > pageSize) {  %>
<tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
<%}  %>
  </table>
  </form>

<input type="button" value="添加医院" onclick="window.open('/jsp/admin/orthonline/EditHospital.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
<br>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
