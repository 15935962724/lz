<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %>
<%@include file="/jsp/Header.jsp"%>
<%


r.add("/tea/resource/Score");

String tmp=request.getParameter("score");
int score=tmp!=null?Integer.parseInt(tmp):0;
if(score<1)
{
  out.print("<!--却少score参数-->");
  return;
}

Http h=new Http(request);

Score obj=Score.find(score);

int gid=obj.getNode();

Golf objcourt= Golf.find(gid,teasession._nLanguage);


tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(obj.member);

String gname=Node.find(obj.getNode()).getSubject(teasession._nLanguage);
if(gname==null)obj.getName();


%><%!
String[] FACT_ID={"eagle","birdie","par","bogey","duble"};
String fact_id(int v)
{
  v+=2;
  if(v<0)v=0;else if(v>4)v=4;
  return FACT_ID[v];
}

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function hole_img(a)
{
  var h_cur=document.getElementById("hole_cur");
  h_cur.id="";
  //
  var td=document.getElementById("tdimg");
  td.innerHTML="<img src='"+a.img+"' />";
  a.parentNode.id="hole_cur";
}
</script>
</head>
<body>
<h1>查看详细成绩</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table id="tablecenter">
 <tr>
    <td class="td001">球场：</td><td class="td002"><%=gname%></td>
    <td class="td003">发球时间：</td><td class="td004"><%=obj.getTimesToString()%></td>
  </tr>
  <tr>
    <td class="td001">会员ID：</td><td class="td002"><%=profile_obj.getMember()%></td>
    <td class="td003">发球台：</td><td class="td004"><%=r.getString(teasession._nLanguage,Score.TEE_TYPE[obj.getTee()])%></td>
  </tr>
    <tr>
    <td class="td001">是否是比赛：</td><td class="td002"><%=obj.isCompete()?"是":"否"%></td>
    <td class="td003">P3平均On果岭：</td><td class="td004"><%=obj.getPar3C()%>%</td>
  </tr>
  <tr>
    <td class="td001">球洞数：</td><td class="td002"><%=obj.cavity%></td>
    <td class="td003">P4平均On果岭：</td><td class="td004"><%=obj.getPar4C()%>%</td>
  </tr>
    <tr>
    <td class="td001">平均推杆数：</td><td class="td004"><%=obj.getBuntC()%></td>
    <td class="td003">P5平均On果岭：</td><td class="td004"><%=obj.getPar5C()%>%</td>
  </tr>
  <tr>
    <td class="td001">首杆上球道率：</td><td class="td002"><%=obj.getFairwayC()%>%</td>
    <td class="td003">Par On果岭率：</td><td class="td004"><%=obj.getParC()+"% ( "+obj.getParON()+" )"%></td>
  </tr>
    <tr>
    <td class="td001">本次差点微分：</td><td class="td002"><%=obj.diff%></td>
    <td class="td003">总杆数：</td><td class="td004"><font><%=obj.sums%></font></td>
  </tr>
  <tr>
    <td class="td001">目前差点指数：</td><td class="td002"><font><%=Score.getIndex(obj.member)%></font></td>
    <td class="td003">备忘记录：</td><td class="td004"><%=obj.text%>　</td>
  </tr>
 </table>
</div>
<div class="Balltype">
  <table>
  <tr>
    <td class="<%=fact_id(-2)%>">1</td><td>:EAGLE&nbsp;老鹰</td>
    <td class="<%=fact_id(-1)%>">1</td><td>:BLRDIE&nbsp;小鸟</td>
    <td class="<%=fact_id(0)%>">1</td><td>:PAR&nbsp;帕</td>
    <td class="<%=fact_id(1)%>">1</td><td>:BOGEY&nbsp;柏忌</td>
    <td class="<%=fact_id(2)%>">1</td><td>:DUBLE-BOGEY&nbsp;双柏忌</td>
  </tr>
   </table>
</div>

<table id="tablecenter">
  <tr id="tableonetr">
    <td>HOLE</td>
    <%
    for(int i=1;i<=obj.cavity;i++)
    {
      out.print("<td>"+i+"H</td>");
    }
    %>
    <td>总杆</td>
  </tr>
  <tr id="tabletr2">
    <td>标准杆</td>
    <%
    int sum=0;
    for(int i=0;i<obj.cavity;i++)
    {
      int v=(gid==0?obj.getStandard()[i]:objcourt.standard[i]);
      sum+=v;
      out.print("<td>"+v+"</td>");
    }
    %>
    <td><%=sum%></td>
    </tr>
  <tr>
    <td>实际杆</td>
    <%
    sum=0;
    for(int i=0;i<obj.cavity;i++)
    {
      int v=obj.fact[i]-objcourt.standard[i];
      sum+=obj.fact[i];
      out.print("<td class="+fact_id(v)+">"+obj.fact[i]);
    }
    %>
    <td><%=sum%></td>
    </tr>
    <tr><td>推杆</td> <%
sum=0;
for(int i=0;i<obj.cavity;i++)
{
  sum+=obj.bunt[i];
  out.print("<td>"+obj.bunt[i]+"</td>");
}
%>
<td><%=sum%></td>
</tr>
     <tr><td>加杆</td> <%
     sum=0;
     for(int i=0;i<obj.cavity;i++)
     {
       int v=obj.fact[i]-objcourt.standard[i];
       sum+=v;
       out.print("<td>"+(v>0?"+":"")+v+"</td>");
     }
    %>
    <td><%=sum%></td>
</tr>
<tr><td>ON果岭</td>
<%
sum=0;
for(int i=0;i<obj.cavity;i++)
{
  sum+=obj.up[i];
  out.print("<td>"+obj.up[i]);
}
%>
<td><%=sum%></td>
</tr>
</table>
<input type="button" value="返回" onclick="history.back();"/>
</body>
</html>
