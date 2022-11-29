<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.taoism.Taoism"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("member");
Profile t=Profile.find(key.length()<1?0:Integer.parseInt(MT.dec(key)));
LmsOrg lo=LmsOrg.find(t.getAgent());

String photo=t.getPhotopath(h.language);
boolean isEdit=t.getType()==0;

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
.print{display:none}
</style>
<style media="print">
h1,#head6,input{display:none}
.print{display:block}
</style>
</head>
<body>
<h1>查看学员信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<!--<h2>全国中小企业经理人证书考试学籍信息确认表</h2>-->
<form name="form2">

学习服务中心名称：<%=lo.orgname%>　　
学习服务中心编号：<%=lo.orgno%>
<h2>基本信息</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">用 户 名:</th>
    <td><%=t.getMember()%></td>
    <td rowspan="8" class="tright1" align="center"><div class="picc"><img name="_photopath" src="<%=MT.f(photo,"/tea/image/avatar.gif")%>?max-age=0" height="210px" width="160px;"/></div></td>
  </tr>
  <tr>
    <th>学习服务中心:</th>
    <td><%=MT.f(LmsOrg.find(t.getAgent()).orgname)%></td>
  </tr>
  <tr>
    <th>姓　　名:</th>
    <td><%=t.getName(h.language)%></td>
  </tr>
  <tr>
    <th>性　　别:</th>
    <td><%=t.isSex()?"男":"女"%></td>
  </tr>
  <tr>
    <th>出生日期:</th>
    <td><%=MT.f(t.getBirth())%></td>
  </tr>
  <tr>
    <th>民　　族:</th>
    <td><%=t.getZzracky()%></td>
  </tr>
  <tr>
    <th>政治面貌:</th>
    <td><%=Lms.POLITY_TYPE[t.getPolity()]%></td>
  </tr>
  <tr>
    <th>证件类型:</th>
    <td><%=Lms.CARD_TYPE[t.getCardType()]%></td>
  </tr>
  <tr>
    <th>证件号码:</th>
    <td colspan="2"><%=t.getCard()%></td>
  </tr>
  <tr>
    <th>籍　　贯:</th>
    <td colspan="2"><script>mt.city("<%=t.getJcity()%>");</script></td>
  </tr>
  <tr>
    <th>报名所在地:</th>
    <td colspan="2"><script>mt.city("<%=t.getProvince(h.language)%>");</script></td>
  </tr>
  <tr>
    <th>户　　籍:</th>
    <td colspan="2"><%=Lms.ZZNYHK_TYPE[t.isZznyhk()?1:0]%></td>
  </tr>
  <tr>
    <th>职　　业:</th>
    <td colspan="2"><%=Lms.JOB_TYPE[t.getJob()]%></td>
  </tr>
  <tr>
    <th>单位性质:</th>
    <td colspan="2"><%=Lms.ORG_NATURE[t.orgnature]%></td>
  </tr>
</table>

<h2>报名情况</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">证书级别:<br/>(学历层次)</th>
    <td>二级（独立本科）</td>
  </tr>
  <tr>
    <th>专业方向:</th>
    <td><%=LmsCert.f(t.getLeveltype())%></td>
  </tr>
</table>


<h2>学历信息</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">学　　历:</th>
    <td><%=t.getDegree(h.language)%></td>
  </tr>
  <tr>
    <th height="21">是否在读:</th>
    <td><%=t.rclass==1?"是　"+t.getSection(h.language):"否"%></td>
  </tr>
  <tr>
    <th>毕业院校:</th>
    <td><%=t.getSchool(h.language)%></td>
  </tr>
  <tr>
    <th>毕业专业:</th>
    <td><%=t.getFunctions(h.language)%></td>
  </tr>
  <tr>
    <th>毕业时间:</th>
    <td><%=MT.f(t.gtime)%></td>
  </tr>
</table>

<h2>联系方式</h2>
<table id="tablecenter" cellspacing="0" class="alignLeft">
  <tr>
    <th width="130">工作单位:</th>
    <td colspan="2"><%=t.getOrganization(h.language)%></td>
  </tr>
  <tr>
    <th>固定电话:</th>
    <td colspan="2"><%=t.getTelephone(h.language)%></td>
  </tr>
  <tr>
    <th>移动电话:</th>
    <td colspan="2"><%=t.getMobile()%></td>
  </tr>
  <tr>
    <th>通讯地址:</th>
    <td colspan="2"><%=t.getAddress(h.language)%></td>
  </tr>
  <tr>
    <th>邮政编码:</th>
    <td colspan="2"><%=t.getZip(h.language)%></td>
  </tr>
  <tr>
    <th>电子邮箱:</th>
    <td colspan="2"><%=t.getEmail()%></td>
  </tr>
</table>

<table width="100%" class="print">
  <tr>
    <td colspan="2" style="text-align:center;font-size:16px;">承诺：</td>
  </tr>
  <tr>
    <td colspan="2" style="text-align:center;font-size:16px;">本人已检查此表格并确认其中所有信息均准确无误！如有错误，本人愿承担一切后果。</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="text-align:right;">承诺人（签字）： ________________________</td>
    <td width="20"></td>
  </tr>
  <tr>
    <td style="text-align:right;">日期：_______年_____月______日</td>
    <td width="20"></td>
  </tr>
</table>

<input type="button" value="打印" onclick="window.print();"/>

<input type="button" value="返回" onClick="history.back();"/>
</form>

<script>

</script>
</body>
</html>
