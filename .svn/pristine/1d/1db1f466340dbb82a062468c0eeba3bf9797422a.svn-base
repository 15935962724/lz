<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.stat.*"%>
<%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);

int papcapp=h.getInt("papcapp");

PapcApp t=PapcApp.find(papcapp);

Profile p=Profile.find(t.member);


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/country.js"></script>
</head>
<body>
<h1>详细——数据申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form2" action="/Papcs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="papcapp" value="<%=papcapp%>"/>
<input type="hidden" name="act" value="appedit"/>
<input type="hidden" name="nexturl" value="/html/folder/9-1.htm"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">用户名：</td>
    <td><a href="/jsp/custom/papc/MemberView.jsp?member=<%=t.member%>"><%=p.getMember()%></a></td>
  </tr>
  <tr>
    <td class="th">申请人：</td>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <td class="th">身份：</td>
    <td><%=PapcApp.POSITION_TYPE[t.position]%></td>
    </tr>
  <tr>
    <td class="th">国家：</td>
    <td><script>mt.country(<%=t.country%>);</script></td>
  </tr>
  <tr>
    <td class="th">单位：</td>
    <td><%=MT.f(t.org)%></td>
  </tr>
  <tr>
    <td class="th">地址：</td>
    <td><%=MT.f(t.address)%></td>
  </tr>
  <tr>
    <td class="th">电子邮件：</td>
    <td><%=MT.f(t.email)%></td>
  </tr>
  <tr>
    <td class="th">电话：</td>
    <td><%=MT.f(t.tel)%></td>
  </tr>
  <tr>
    <td class="th">项目或课题名称及来源：</td>
    <td><%=MT.f(t.project)%></td>
  </tr>
  <tr>
    <td class="th">课题负责人：</td>
    <td><%=MT.f(t.leader)%></td>
  </tr>
  <tr>
    <td class="th">数据应用说明：</td>
    <td><%=MT.f(t.purpost)%></td>
  </tr>
  <tr>
    <td class="th">所需数据内容描述（地区、类群或馆别）：</td>
    <td><%=MT.f(t.content)%></td>
  </tr>
  <tr>
    <td class="th">承诺：</td>
    <td><%=MT.f(t.commitment)%></td>
  </tr>
  <tr>
    <td class="th">申请地址：</td>
    <td><%=t.ip+"　"+Ip.findByIp(t.ip)%></td>
  </tr>
  <tr>
    <td class="th">申请时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>


<input type="button" value="返回" onclick="history.back();"/>
</form>

</body>
</html>
