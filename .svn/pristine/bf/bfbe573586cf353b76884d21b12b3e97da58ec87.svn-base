<%@page contentType="text/html;charset=UTF-8" %><%@ include file="/jsp/Header.jsp" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.*" %><%

String community=node.getCommunity();

String member=teasession._rv.toString();
tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(member);

r.add("/tea/resource/Score");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

String tmp=request.getParameter("score");
if(tmp!=null)
{
	response.sendRedirect("/jsp/type/score/CD_ScoreView.jsp?"+request.getQueryString());
	return;
}


%>
<div class="title"><h2>最近20次成绩</h2>
<span>会员ID：<%=profile_obj.getMember()%></span></div>
<table id="tablecenter">
  <tr id="tabletr"><td class="td01" nowrap="nowrap">序号</td>
    <td class="td02" nowrap="nowrap">日期</td>
    <td class="td01" nowrap="nowrap">球场名称</td>
    <td class="td02" nowrap="nowrap">成绩</td>
    <td class="td01" nowrap="nowrap">发球台</td>
    <td class="td02" nowrap="nowrap">是否比赛</td>
    <td class="td01" nowrap="nowrap">详细</td>
  </tr>
<%
java.util.Iterator e=Score.find(" AND member="+DbAdapter.cite(member),0,20).iterator();
for(int index=1;e.hasNext();index++)
{
  Score objTop=(Score)e.next();
  int sid=objTop.score;
  int gid=objTop.getNode();
  String gname;
%>
<tr <%if(objTop.calc)out.print(" bgcolor='#D2E8DC'");%>>
  <td class="td1"><%=index%></td>
  <td class="td2"><%=objTop.getTimesToString()%></td>
  <td class="td3"><%=(gid>0&&(gname=Node.find(gid).getSubject(teasession._nLanguage))!=null)?("<a href='/html/golf/"+gid+"-"+teasession._nLanguage+".htm' target='_blank'>"+gname+"</a>"):objTop.getName()%></td>
  <td class="td4"><%=objTop.getSums()+(objTop.isCompete()?"*":"")%></td>
  <td class="td5"><img SRC="/tea/image/score/0<%=objTop.getTee()+1%>.jpg" alt="发球台"/></td>
    <td class="td6"><%=objTop.isCompete()?"是":"否"%></td>
    <td class="td7"><a href="/servlet/Node?node=<%=teasession._nNode%>&score=<%=sid%>">查看详细</a></td>
</tr>
<%}%>
</table>
<div class="Indicate">注：其中背景为绿颜色的成绩被用于计算您的差点指数</div>
