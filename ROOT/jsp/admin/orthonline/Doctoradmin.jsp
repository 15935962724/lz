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
int dy = 0;


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

//判断管理员的权限
String members =teasession._rv.toString();
Doctoradmin daobjs = Doctoradmin.find(Doctoradmin.isMemberDaid(teasession._strCommunity,members));

boolean fs = false;//省
boolean fs2 = false;
boolean fs3 = false;//市
//姓名
String xingming = teasession.getParameter("xingming");
if(xingming!=null && xingming.length()>0)
{
  xingming = xingming.trim();
  sql.append(" AND member in (select member from ProfileLayer where firstname like "+DbAdapter.cite("%"+xingming+"%")+" or lastname like "+DbAdapter.cite("%"+xingming+"%")+")");
  param.append("&xingming=").append(java.net.URLEncoder.encode(xingming,"UTF-8"));
  fs2   = true;
}
//用户名
String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" AND member like  ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
    fs2 = true;
}
//级别
int datype = 0;
if(teasession.getParameter("datype")!=null&&teasession.getParameter("datype").length()>0)
{
  datype = Integer.parseInt(teasession.getParameter("datype"));
}


//if(daobjs.getDatype()>0)
//{
//  datype= daobjs.getDatype();
//  if(daobjs.getDatype()==366)
//  {
//    if(teasession.getParameter("datype")!=null&&teasession.getParameter("datype").length()>0){
//      datype = Integer.parseInt(teasession.getParameter("datype"));
//    }
//    if(datype==0)
//    {
//       datype=0;
//    }
//
//  }
//  if(daobjs.getDatype()==373)
//  {
//     sql.append(" AND datype!=366");
//     if(teasession.getParameter("datype")!=null&&teasession.getParameter("datype").length()>0){
//       datype = Integer.parseInt(teasession.getParameter("datype"));
//     }
//     if(datype==0)
//     {
//       datype=0;
//     }
//  }
//}
if(datype>0)
{
  sql.append(" AND datype=").append(datype);
  param.append("&datype=").append(datype);
    fs2 = true;
}
//省
int sheng = 0;
if(teasession.getParameter("sheng")!=null&&teasession.getParameter("sheng").length()>0)
{
  sheng = Integer.parseInt(teasession.getParameter("sheng"));
}
if(daobjs.getSheng()>0)
{
  sheng= daobjs.getSheng();
  fs = true;
}
if(sheng>0)
{
  sql.append(" AND sheng =").append(sheng);
  param.append("&sheng=").append(sheng);
    fs2 = true;
}
//市
int shi = 0;
if(teasession.getParameter("shi")!=null&&teasession.getParameter("shi").length()>0)
{
  shi = Integer.parseInt(teasession.getParameter("shi"));
}
if(daobjs.getShi()>0)
{
  shi = daobjs.getShi();
  fs3 = true;
}
if(shi>0)
{
  sql.append(" AND shi =").append(shi);
  param.append("&shi=").append(shi);
  fs2 = true;
}

int gongzuodanwei = 0;
if(teasession.getParameter("gongzuodanwei")!=null&&teasession.getParameter("gongzuodanwei").length()>0)
{
  gongzuodanwei = Integer.parseInt(teasession.getParameter("gongzuodanwei"));
}
if(daobjs.getYiyuan()>0)
{
  gongzuodanwei = daobjs.getYiyuan();
  fs = true;
}
if(gongzuodanwei>0)
{
  sql.append(" AND yiyuan =").append(gongzuodanwei);
  param.append("&gongzuodanwei=").append(gongzuodanwei);
  fs2 = true;
}


int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Doctoradmin.count(teasession._strCommunity,sql.toString());

sql.append(" order by member asc ");

//如果用户是超级管理员和1级管理员
if(daobjs.getDatype()==366||daobjs.getDatype()==373)
{

 fs = false;//省
 fs3 = false;//市
}
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>骨科医生登记表</title>
</head>
<body id="bodynone"  onload="f_ajax('<%=shi%>','<%=fs3%>');" >
<script>
function f_ajax(igd,bool)
{
  f_sheng(igd,bool);
  f_shi();
}
function f_edit(igd)
{
  form1.daid.value=igd;
  form1.action='/jsp/admin/orthonline/EditDoctoradmin.jsp'
  form1.submit();
}
function f_delete(igd)
{
   if(confirm('您确定要删除此内容吗？')){
     form1.daid.value=igd;
     form1.act.value='delete';
     form1.action='/servlet/EditDoctoradmin'
     form1.submit();
   }
}
function f_sheng(igd,bool){
  sendx("/jsp/admin/orthonline/city_ajax.jsp?bool="+bool+"&act=city&shiid="+igd+"&sheng="+form1.sheng.value,
  function(data)
  {
    document.getElementById("show").innerHTML=data;
  }
  );
}
 function f_shi()
 {
   var s = 0;
  if(form1.shi.value==0)
  {
   s = <%=shi%>;
  }else
  {
    s= form1.shi.value;
  }
        sendx("/jsp/admin/orthonline/city_ajax.jsp?act=gongzuodanwei&gongzuodanweids=<%=gongzuodanwei%>&sheng="+form1.sheng.value+"&shi="+s,
         function(data)
         {
           //alert(data);
           document.getElementById("wei").innerHTML=data;
         }
         );
 }

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
<h1>管理员账户管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <h2>查询</h2>
   <form action="?" name="form1"  method="POST"><!--/servlet/EditDoctor-->
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="daid" >
  <input type="hidden" name="act">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
     <td>管理员姓名:</td>
     <td><input type="text" name="xingming" value="<%if(xingming!=null)out.print(xingming);%>"/></td>
     <td>用户名:</td>
     <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>

   </tr>
   <tr>
     <td>级别:</td>
     <td>
       <select name="datype"   >
         <option value="0" >---请选择管理员级别---</option>
         <%if(daobjs.getDatype()==366){%>
         <option value=366 <%  if(datype==366){out.print(" selected ");}%>>1级,超级管理员</option>
         <%} %>
          <%if(daobjs.getDatype()==373||daobjs.getDatype()==366){%>
         <option value=373  <% if(datype==373){out.print(" selected ");}%>>1级,管理员</option>
         <%} %>
               <%if(daobjs.getDatype()==373||daobjs.getDatype()==366||daobjs.getDatype()==367){%>
         <option value=367 <%  if(datype==367){out.print(" selected ");}%>>2级,省份级管理员</option>
         <%}%>
         <option value=368 <%  if(datype==368){out.print(" selected ");}%>>3级,市县级管理员</option>
         <option value=369 <%  if(datype==369){out.print(" selected ");}%>>4级,大型医院管理员</option>
       </select>
     </td>
       <td>管理员权限:</td>
       <td>
       省份/直辖市&nbsp;
         <select name="sheng" onchange="f_sheng('0','<%=fs3%>');"  <%if(fs)out.print(" disabled");%>>
           <option value="0">请选择省份/直辖市</option>
           <%
           java.util.Enumeration e2 = Provinces.find(" AND type=0 ORDER BY provincity ASC ");
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
           </select>&nbsp;市/县&nbsp;<span id="show">
            <select name="shi">
              <option value="0">请选择市/县</option>
            </select>
          </span>&nbsp;管理医院&nbsp;
        <span id="wei">
          <select name="gongzuodanwei">
            <option value="0">请选择医院</option>
          </select>
        </span>&nbsp;
       </td>
         <td><input type="submit" value="查询"/></td>
   </tr>


 </table>


<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位管理员&nbsp;)</h2>
<%
if(fs2){
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
//管理员姓名
if(xingming!=null && xingming.length()>0)
{
  out.print("管理员姓名&nbsp;");
  out.print("<span  id=xlsize>"+xingming+"</span>");
}
//用户名
if(member!=null && member.length()>0)
{
  out.print("用户名&nbsp;");
  out.print("<span  id=xlsize>"+member+"</span>");
}
//管理员级别
if(datype>0)
{
  out.print("管理员级别&nbsp;");
  out.print("<span  id=xlsize>");

  if(datype==366){out.print("1级,超级管理员");}
  if(datype==373){out.print("1级,管理员");}
  if(datype==367){out.print("2级,省份级管理员");}
  if(datype==368){out.print("3级,市县级管理员");}
  if(datype==369){out.print("4级,大型医院管理员");}
  out.print("</span>");

}
//管理医院
if(gongzuodanwei>0)
{
  out.print("管理医院&nbsp;");
   Hospital hobj = Hospital.find(gongzuodanwei);
   out.print("<span  id=xlsize>"+hobj.getHoname()+"</span>");
}

  out.print("</h3>");
}
%>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>管理员姓名</td>
      <td nowrap>用户名</td>
      <td nowrap>密码</td>
      <td nowrap>级别</td>
      <td nowrap>管理权限</td>
      <td nowrap>操作</td>
    </tr>
<%

java.util.Enumeration  e = Doctoradmin.find(teasession._strCommunity,sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
 for(int i =1;e.hasMoreElements();i++)
 {
   int daid =((Integer)e.nextElement()).intValue();
   Doctoradmin daobj= Doctoradmin.find(daid);
   Profile p = Profile.find(daobj.getMember());
   Hospital hobj = Hospital.find(daobj.getYiyuan());
   Provinces pobj1=Provinces.find(daobj.getSheng());
   Provinces pobj2=Provinces.find(daobj.getShi());

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td align="center" width="1"><%=i+pos %></td>
<td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
<td><%=daobj.getMember() %></td>
<td><%=p.getPassword() %></td>
<td><%=AdminRole.find(daobj.getDatype()).getName() %></td>
<td><%
if(pobj1.getProvincity()!=null)
{
  out.print(pobj1.getProvincity()+"&nbsp;");
}
if(pobj2.getProvincity()!=null)
{
  out.print(pobj2.getProvincity()+"&nbsp;");
}
if(hobj.getHoname()!=null)
{
  out.print(hobj.getHoname()+"&nbsp;");
}
%></td>
<td><a href="#" onclick="f_edit('<%=daid%>');">编辑</a>&nbsp;<a href="#" onclick="f_delete('<%=daid%>');">删除</a></td>
</tr>
<%} %>
<%if (count > pageSize) {  %>
<tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
<%}  %>
  </table>

  <input type="button" value="添加管理员" onclick="window.open('/jsp/admin/orthonline/EditDoctoradmin.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
  </form>

  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
