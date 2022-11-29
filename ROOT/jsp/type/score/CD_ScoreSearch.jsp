<%@page contentType="text/html;charset=UTF-8" %><%@ include file="/jsp/Header.jsp" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.db.*" %><%

String community=node.getCommunity();

String member=teasession._rv.toString();
tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(member);

r.add("/tea/resource/Score");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

Http h=new Http(request);
//pos
String tmp=request.getParameter("ps");
int pos=tmp!=null?Integer.parseInt(tmp):0;

String view=h.get("view","def"),s_start=h.get("start"),s_starty=h.get("startYear");
Date start,end;
if(s_start!=null||s_starty!=null)
{
  //start
  if(s_start==null)s_start=s_starty+"-"+request.getParameter("startMonth")+"-"+request.getParameter("startDay");
  start=Entity.sdf.parse(s_start);
  //end
  tmp=request.getParameter("end");
  if(tmp==null)tmp=request.getParameter("endYear")+"-"+request.getParameter("endMonth")+"-"+request.getParameter("endDay");
  end=Entity.sdf.parse(tmp);
  if("def".equals(view))view="tab";
}else
{
  end=new Date();
  Calendar c=Calendar.getInstance();
  c.setTime(end);
  c.add(Calendar.MONTH,-12);
  start=c.getTime();
}

StringBuffer sb=new StringBuffer(),par=new StringBuffer();;
sb.append(" AND member="+DbAdapter.cite(member));

sb.append(" AND times>="+DbAdapter.cite(start)).append(" AND times<"+DbAdapter.cite(MT.add(end,1)));

String s_str=Entity.sdf.format(start),e_str=Entity.sdf.format(end);
par.append("?node="+teasession._nNode);
par.append("&start="+s_str);
par.append("&end="+e_str);
par.append("&view="+view);
par.append("&ps=");

%>
<div class="title"><h2>历史差点</h2>
<span>会员ID：<%=profile_obj.getMember()%></span></div>

<form name="scoresearch" action="?">
<input type="hidden" name="view" value="<%=view%>"/>
<div id="tablesearch">
<table>
  <tr>
    <td>起始日期<%=new tea.htmlx.TimeSelection("start",start)%></td>
    <td rowspan="2" class="SubSearch"><input type="submit" name="Submit" value="" /></td>
  </tr>
  <tr>
    <td>结束日期<%=new tea.htmlx.TimeSelection("end", end)%></td>
  </tr>
</table>
</div>
</form>

<script>
function v(s)
{
  scoresearch.view.value=s;
  scoresearch.submit();
}
</script>
<div class="Switch"><a onclick="v('img')" class="<%=!"tab".equals(view)?"ScoreC":"ScoreA"%>">成绩走势图</a> <a  onclick="v('tab')" class="<%="tab".equals(view)?"ScoreC":"ScoreA"%>">成绩列表</a></div>
<%
if("tab".equals(view))
{%>


<table id="tablecenter">
  <tr id="tabletr"><td class="td01">序号</td>
    <td class="td02">日期</td>
    <td class="td01">球场名称</td>
    <td class="td02">成绩</td>
    <td class="td01">发球台</td>
    <td class="td02">是否比赛</td>
    <td class="td01">详细</td>
  </tr>
<%
int sum=Score.count(sb.toString());
if(sum==0)
{
  out.print("<tr><td colspan='50' align='center'>暂无数据!</td></tr>");
}else
{
java.util.Iterator e=Score.find(sb.toString(),pos,20).iterator();
for(int index=1;e.hasNext();index++)
{
  Score s=(Score)e.next();
  int sid=s.score;
  int gid=s.getNode();
  String gname;
%>
<tr <%if(s.calc)out.print(" bgcolor='#D2E8DC'");%>>
  <td class="td1"><%=index%></td>
  <td class="td2"><%=s.getTimesToString()%></td>
  <td class="td3"><%=(gid>0&&(gname=Node.find(gid).getSubject(teasession._nLanguage))!=null)?("<a href='/html/golf/"+gid+"-"+teasession._nLanguage+".htm' target='_blank'>"+gname+"</a>"):s.getName()%></td>
  <td class="td4"><%=s.getSums()+(s.isCompete()?"*":"")%></td>
  <td class="td5"><img SRC="/tea/image/score/0<%=s.getTee()+1%>.jpg" alt="发球台"/></td>
    <td class="td6"><%=s.isCompete()?"是":"否"%></td>
    <!-- /jsp/type/score/CD_ScoreView.jsp?community=<%=community%>&score=<%=sid%> -->
    <td class="td7"><a href="/servlet/Node?node=<%=teasession._nNode%>&score=<%=sid%>" target="_blank">查看详细</a></td>
</tr>
<%}
}%>
</table>
<div class="Indicate">注：其中背景为绿颜色的成绩被用于计算您的差点指数</div>
<br>
<%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, sum,20)%>


<%
/////////////////图////////
}else
{
  Iterator it = Score.find(" AND member="+DbAdapter.cite(member),0,1).iterator();
  Score s=it.hasNext()?(Score)it.next():new Score();
%>
<div class="ResultsAlmost">
  <blockquote>
    <p><img src="/jsp/img/lishi.gif" /></p>
  </blockquote>
</div>
<img src="/servlet/EditScore?act=img&start=<%=s_str%>&end=<%=e_str%>" width="740" height="280" usemap="#mt" onload="sendx('/servlet/EditScore?act=map',function(v){$('mt').innerHTML=v;})" />
<map name="mt" id="mt"></map>
<span id="minfo" style="display:none;position:absolute;z-index:1;left: 321px;top: 175px;background-color:#FDFDB5; border:1px solid #CCCCCC"></span>
<script>
var minfo=document.getElementById('minfo');
function f_time(t)
{
  minfo.style.left=event.clientX;
  minfo.style.top=event.clientY+document.body.scrollTop+20;
  minfo.innerHTML=t;
  minfo.style.display=t?"":"none";
}
</script>
<div class=Playtime>你上次打球时间是:<%=s.getTimesToString()+"　"+ MT.f(s.getName())%></div>
<table id="tablecenter" class="TakeView">
<tr id="tabletr"><td class="td01">柏忌</td><td class="td02">PAR</td><td class="td01">P3平均On果岭</td><td class="td02">P4平均On果岭</td><td class="td01">P5平均On果岭</td><td class="td02">Par On果岭率</td><td class="td01">平均推杆数</td><td class="td02">差点微分</td><td class="td01">总杆数</td><td class="td02">目前差点</td></tr>
<%
if(!s.exists)
out.print("<tr><td colspan='50' align='center'>暂无数据!</td></tr>");
else
{
%>
<tr><td><%=s.getBogey()%></td>
  <td><%=s.getPar()%></td>
  <td><%=s.getPar3C()%></td>
  <td><%=s.getPar4C()%></td>
  <td><%=s.getPar5C()%></td>
  <td><%=s.getParC()+"% ( "+s.getParON()+" )"%></td>
  <td><%=s.getBuntC()%></td>
  <td><%=s.diff%></td>
  <td><%=s.sums%></td>
  <td><%=Score.getIndex(s.member)%></td>
</tr>
<%}%>
</table>

<%}%>


