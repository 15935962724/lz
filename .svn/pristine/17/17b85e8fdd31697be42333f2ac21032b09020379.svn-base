<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

String memberid = teasession.getParameter("memberid");
Profile pobj = Profile.find(memberid);
LeagueShop lsobj =LeagueShop.find(pobj.getAgent());
ICard ic=ICard.find(memberid);
String SHINE_TYPE[]={"","全脸","只在T字部位","少量"};
String STAB_TYPE[]={"","经常","偶尔","没有"};
String SENSITIVE_TYPE[]={"","会发红，不会晒黑","会发红，然后变黑，易黑不红","没有"};
String SPOTTED_TYPE[]={"","非常明显","不太明显","极不明显"};
String AGING_TYPE[]={"","有黑眼圈","有眼袋","眼圈出现细纹"};

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店会员信息详细信息</title>
</head>
<body id="bodynone">
<h1>分店会员信息详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <form accept="?" name="form2">
  <h2>基本信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>姓名:</td><td><%=pobj.getName(teasession._nLanguage)%></td>
      <td>性别：</td> <td><%if(pobj.isSex())out.print("男");else out.print("女");%></td>
      <td>卡号：</td>
      <td><%=memberid%></td>
      <td>入会日期:</td>
      <td><%=pobj.getTimeToString()%></td>
    </tr>
    <tr>
      <td>联系地址:</td>
      <td colspan="5"><%=pobj.getAddress(teasession._nLanguage) %></td>
      <td>Tel联系电话:</td>
      <td><%=pobj.getMobile()%></td>
    </tr>
  </table>
  <h2>皮肤状况分析</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td colspan="2">面部呈油光状况:</td>
      <td><%=SHINE_TYPE[ic.getShine()]%></td>
    </tr>
    <tr>
      <td rowspan="3">缺少干燥不适现象:</td>
      <td>因环境或接触引起刺疼、红疹：</td>
      <td><%=STAB_TYPE[ic.getStab()]%></td>
    </tr>
    <tr>
      <td>出现暗疮、粉刺：</td>
      <td><%=STAB_TYPE[ic.getAcne()]%></td>
    </tr>
    <tr>
      <td>因日晒敏感：</td>
      <td><%=SENSITIVE_TYPE[ic.getSensitive()]%></td>
    </tr>
    <tr>
      <td rowspan="2">日晒引起老化:</td>
      <td>肤色不均出现斑点：</td>
      <td><%=SPOTTED_TYPE[ic.getSpotted()]%></td>
    </tr>
    <tr>
      <td>松弛或出现细纹：</td>
      <td><%=SPOTTED_TYPE[ic.getRelaxation()]%></td>
    </tr>
    <tr>
      <td>自然老化：</td>
      <td>
        <%
        String a=ic.getAging();
        if(a==null||a.length()<2)
        out.print("无");
        else
        for(int i=1;i<AGING_TYPE.length;i++)
        {
          if(a.indexOf("/"+i+"/")!=-1)out.println(AGING_TYPE[i]);
        }
        %>
      </td>
    </tr>
  </table>
  </form>
  <br />
  <input type=button value="返回" onClick="javascript:history.back()">
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
