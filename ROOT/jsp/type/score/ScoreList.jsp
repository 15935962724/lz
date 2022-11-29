<%@page contentType="text/html;charset=UTF-8" %><%@ include file="/jsp/Header.jsp" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.*" %><%

String community=node.getCommunity();

String member=teasession._rv.toString();
tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(member);

r.add("/tea/resource/Score");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreList")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　最近20次成绩</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：<%=profile_obj.getName(teasession._nLanguage)%></span>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr><td>
      <td scope="col">打球日期</td>
    <td scope="col">球场</td>
    <td scope="col"><div align="center">发球台</div></td>
    <td scope="col"><div align="center">成绩</div></td>
    <td scope="col"><div align="center">是否比赛</div></td>
	 <td scope="col"><div align="center">详细</div></td>
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
<tr <%if(objTop.calc)out.print(" bgcolor='#FFFFCC'");%>>
  <td><%=index%>
    <td>
    <%
    String text=objTop.getText();
    if(text!=null&&text.length()>0)
    {
      out.print(new tea.html.Anchor("#",new tea.html.Text(objTop.getTimes("yyyy-MM-dd")),"openmemo"+sid+"();"));
      out.print(new tea.html.Script("function openmemo"+sid+"(){ winobj=window.open('','备忘记录','edge:raised;help:0;resizable:1;width=400px;height=300px;');"+"winobj.document.write(\""+objTop.getText().replaceAll("\"","&quot;").replaceAll("\r\n","<br/>")+"\");}"));
    }else
    out.print(objTop.getTimes("yyyy-MM-dd"));
    %>
    </td>
    <td><%
    if(gid>0&&(gname=Node.find(gid).getSubject(teasession._nLanguage))!=null)
    out.print("<a href='/servlet/Golf?node="+gid+"' target='_blank'>"+gname+"</a>");
    else
    out.print(objTop.getName());
    %></td>
    <td align="center"><img SRC="/tea/image/score/0<%=objTop.getTee()+1%>.jpg" alt="发球台"></td>
      <td align="center"><%=objTop.getSums()%></td>
      <td align="center"><%=objTop.isCompete()?"是":"否"%></td>
      <td align="center"><a href="/jsp/type/score/ScoreView.jsp?community=<%=community%>&score=<%=sid%>" target="_blank"><img src="/tea/image/score/0002.jpg" alt="详细" width="17" height="14" border="0"></a>	  </td>
</tr>
<%}%>
</table>
<br>
注：其中背景为黄颜色的成绩被用于计算您的差点指数
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
