<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.Enumeration"%>
<%
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String member = request.getParameter("member");
Profile p = Profile.find(member);
ProfileZh pz = ProfileZh.find(member);
%>
<html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id="bdone">
<div class="lujing"><li>当前位置：<a href="/servlet/Folder?node=2">首页</a><span><span id="PathID1"> ><a href="/servlet/Folder?node=2&amp;language=1">中韩友好协会</a></span><span id="PathID2"> ><a href="/servlet/Folder?node=46&amp;language=1">协会组成</a></span><span id="PathID3"> ><a href="/jsp/user/ProfileZhList.jsp"><%=pz.getRegToHtml()%>名单</a></span><span id="PathID4"> ><%=pz.getName()%>简历</span></span></li></div>
<div class="xijie">
        <ul>
          <li>
            <div class="xijie_bt"><span id="CurrentlyNode"><%=pz.getName()%>简历</span></div>
            <div class="xijie_neirong"><span>
<table width="365" align="center" cellpadding="5" cellspacing="0" style="font-size:12px;line-height:150%;">
  <TR >
    <TD colSpan="2" valign="middle"><p align="center"><%if(pz.getPhoto()!=null&&!pz.getPhoto().equals("null")){%><IMG height="100" alt="" src="<%=pz.getPhoto()%>" width="80"><%}%></p></TD>
  </TR>
  <TR >
    <TD colSpan="2" valign="middle"></TD>
  </TR>
  <TR >
    <TD colSpan="2" align="center" valign="middle">
      <%
      String sex = p.isSex()?"男":"女";
      String[] birth = p.getBirthToString().split("-");
      out.print(sex+","+pz.getNationnal()+","+birth[0]+"年"+birth[1]+"月"+birth[2]+"日生,"+pz.getPolitical()+","+pz.getBplace()+"<br>现任"+pz.getComname()+pz.getJob());
      %>
    </TD>
  </TR>
  <TR >
    <TD colSpan="2" valign="middle"></TD>
  </TR>
  <%
  String resume = pz.getResume();
  String[] rowResume = resume.split(",");
  for(int i =1; i < rowResume.length; i++)
  {
    out.print("<tr>");
    String[] colResume = rowResume[i].split("`");
    out.print("<td valign=middle>"+colResume[0]+"</td>");
    out.print("<td valign=middle>"+colResume[1]+"　"+colResume[2]);
    out.print("</tr>");
  }
  %>
</table> </span></div>
          </li>
        </ul>
        <img src="/res/china-corea/u/0810/081020106.jpg"></div>

</body>
</html>
