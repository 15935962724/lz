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

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and mrnumber >0 ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
//判断管理员的权限
String member =teasession._rv.toString();
Doctoradmin daobj = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,member));
AdminRole arobj = AdminRole.find(daobj.getDatype());
boolean fs = false,fs2=false,fs3=false;

// 医院名称
String xingming=teasession.getParameter("xingming");
if(daobj.getYiyuan()>0)
{
  Hospital h = Hospital.find(daobj.getYiyuan());
  xingming = h.getHoname();
 // fs = true;
}
if(xingming!=null && xingming.length()>0)
{
  xingming = xingming.trim();
  sql.append(" AND hospitalname LIKE ").append(DbAdapter.cite("%"+xingming+"%"));
  param.append("&xingming=").append(java.net.URLEncoder.encode(xingming,"UTF-8"));
 // fs=true;
  fs3=true;
}
//所属省市
int sheng=0;
if(daobj.getSheng()>0)
{
  sheng= daobj.getSheng();
  fs = true;
}
if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
{
  sheng = Integer.parseInt(teasession.getParameter("sheng"));
}
if(sheng>0)
{
  sql.append(" AND sheng = ").append(sheng);
  param.append("&sheng=").append(sheng);
  fs3=true;
}
int shi=0;

if(daobj.getShi()>0)
{
  shi = daobj.getShi();
  fs2 = true;
}
if(teasession.getParameter("shi")!=null && teasession.getParameter("shi").length()>0)
{
  shi = Integer.parseInt(teasession.getParameter("shi"));
}
 if(shi>0)
  {
    sql.append(" AND shi = ").append(shi);
    param.append("&shi=").append(shi);
    fs3=true;
  }

//医院级别
String yyjibie = teasession.getParameter("yyjibie");
if(yyjibie!=null && yyjibie.length()>0)
{
  sql.append(" AND yyjibie=").append(DbAdapter.cite(yyjibie));
  param.append("&yyjibie=").append(java.net.URLEncoder.encode(yyjibie,"UTF-8"));
}
int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = DoctorRanking.count(teasession._strCommunity,sql.toString());
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

sql.append(" order by mrnumber desc ");
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医院排名统计</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone"  onload="f_sheng('<%=shi%>','<%=fs2%>');" >

<script>
//所属省市
 function f_sheng(igd,bool){
         sendx("/jsp/admin/orthonline/city_ajax.jsp?bool="+bool+"&doid=0&shiid="+igd+"&act=city&sheng="+form1.sheng.value,
         function(data)
         {
           document.getElementById("show").innerHTML=data;
         }
         );
 }
 function f_shi()
 {}


//控制右键
function stop(){
return false;
}
document.oncontextmenu=stop;
//控制选择文本
var omitformtags=["input", "textarea", "select"]

omitformtags=omitformtags.join("|")

function disableselect(e){
if (omitformtags.indexOf(e.target.tagName.toLowerCase())==-1)
return false
}

function reEnable(){
return true
}

if (typeof document.onselectstart!="undefined")
document.onselectstart=new Function ("return false")
else{
document.onmousedown=disableselect
document.onmouseup=reEnable
}

</script>
<h1>医院排名统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询&nbsp;&nbsp;&nbsp;&nbsp;您目前是:<%if(arobj.getName()!=null)out.print(arobj.getName() );%></h2>
   <form action="?" name="form1"  method="GET"><!--/servlet/EditDoctor-->
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="doid" >
  <input type="hidden" name="act">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="repository" value="GeRenZhaoPian"/>
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
     <td>医院名称:</td>
     <td><input type="text" name="xingming" value="<%if(xingming!=null)out.print(xingming);%>"  <%if(fs)out.print(" disabled");%>></td>
     <td>所属省市:</td>
     <td>
      <select name="sheng" onchange="f_sheng('0','<%=fs2%>');" <%if(fs)out.print(" disabled");%>>
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
     </tr>
     <tr>
     <td>医院等级</td>
     <td>
      <select name="yyjibie">
          <option value="">请选择医院级别</option>
          <option value="三甲" <%if("三甲".equals(yyjibie))out.print(" selected");%>>三甲</option>
          <option value="三乙" <%if("三乙".equals(yyjibie))out.print(" selected");%>>三乙</option>
          <option value="二甲" <%if("二甲".equals(yyjibie))out.print(" selected");%>>二甲</option>
          <option value="二乙" <%if("二乙".equals(yyjibie))out.print(" selected");%>>二乙</option>
          <option value="未评级" <%if("未评级".equals(yyjibie))out.print(" selected");%>>未评级</option>
        </select>
     </td>
     <td><input type="submit" value="查询"/></td>
   </tr>
   <tr>

   </tr>
 </table>


<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个医院&nbsp;)</h2>
<%
if(fs){
  out.print("<h3>您搜索的范围是：");
  //省
  if(sheng>0)
  {
    Provinces pobj = Provinces.find(sheng);
    out.print("所属省市&nbsp;");
    out.print("<span id = xlsize>"+pobj.getProvincity()+"</span>&nbsp;");
  }
  //市
  if(shi>0)
  {
    Provinces pobj2= Provinces.find(shi);
    out.print("<span id = xlsize>"+pobj2.getProvincity()+"</span>&nbsp;");
  }



//管理医院
if(xingming!=null && xingming.length()>0)
{
  out.print("医院名称&nbsp;");
   out.print("<span  id=xlsize>"+xingming+"</span>");
}

  out.print("</h3>");
}
%>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>医院名称</td>
      <td nowrap>省/直辖市</td>
      <td nowrap>市县</td>
      <td nowrap>登记人数</td>
    </tr>
<%

java.util.Enumeration  e = DoctorRanking.find(teasession._strCommunity,sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
 for(int i =1;e.hasMoreElements();i++)
 {
   int drid =((Integer)e.nextElement()).intValue();
   DoctorRanking drobj = DoctorRanking.find(drid);
  // DoctorRanking hobj= Hospital.find(drid);
  Provinces pobj1 = Provinces.find(drobj.getSheng());
  Provinces pobj2 = Provinces.find(drobj.getShi());

%>
<tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td align="center" width="1"><%=i+pos %></td>
<td><%=drobj.getHospitalname() %></td>
<td ><%=pobj1.getProvincity() %></td>
<td ><%=pobj2.getProvincity() %></td>
<td ><a href="/jsp/admin/orthonline/doctor.jsp?act=DoctorRanking&sheng=<%=drobj.getSheng()%>&shi=<%=drobj.getShi() %>&gongzuodanwei=<%=java.net.URLEncoder.encode(drobj.getHospitalname() ,"UTF-8")%>&community=<%=teasession._strCommunity%>"><%=drobj.getMrnumber()%></a></td>
</tr>
<%} %>
<%if (count > pageSize) {  %>
<tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
<%}  %>
  </table>

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
