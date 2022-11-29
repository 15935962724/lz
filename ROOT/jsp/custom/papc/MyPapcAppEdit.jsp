<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);

int papcapp=h.getInt("papcapp");

PapcApp t=new PapcApp(0);
Profile p=Profile.find(h.member);
t.name=p.getName(h.language);
t.org=p.getOrganization(h.language);
t.email=p.getEmail();
t.tel=p.getTelephone(h.language);



%>
<script src="/tea/country.js"></script>
<form name="form2" action="/Papcs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="papcapp" value="<%=papcapp%>"/>
<input type="hidden" name="act" value="appedit"/>
<input type="hidden" name="nexturl" value="/html/folder/9-1.htm"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">申请人(Applicant)：
      <input name="name" value="<%=MT.f(t.name)%>"/></td>
    </tr>
  <tr>
    <td class="th">身份(Position)：
      <select name="position">
        <%=h.options(PapcApp.POSITION_TYPE,t.position)%>
      </select></td>
    </tr>
  <tr>
    <td class="th">国家(Country)：
      <script>mt.country('country',<%=t.country%>);</script></td>
    </tr>
  <tr>
    <td class="th">单位(Institution)：
      <input name="org" value="<%=MT.f(t.org)%>"/></td>
    </tr>
  <tr>
    <td class="th">地址(Address)：
      <input name="address" value="<%=MT.f(t.address)%>"/></td>
    </tr>
  <tr>
    <td class="th">电子邮件(Email address)：
      <input name="email" value="<%=MT.f(t.email)%>"/></td>
    </tr>
  <tr>
    <td class="th">电话(Telephone)：
      <input name="tel" value="<%=MT.f(t.tel)%>"/></td>
    </tr>
  <tr>
    <td class="th">项目或课题名称及来源(name and source of Grant & Project)：</td>
    </tr>
   <tr>
    <td class="th"><textarea name="project" cols="50" rows="1"><%=MT.f(t.project)%></textarea></td>
    </tr>
  <tr>
    <td class="th">课题负责人(Project Leader)：
      <textarea name="leader" cols="20" rows="1"><%=MT.f(t.leader)%></textarea></td>
    </tr>
  <tr>
    <td class="th">数据应用说明(purpost of the data)：</td>
    </tr>
   <tr>
    <td class="th"><textarea name="purpost" cols="50" rows="1"><%=MT.f(t.purpost)%></textarea></td>
    </tr>
  <tr>
    <td class="th">所需数据内容描述（地区、类群或馆别）
    (Description of the request)：</td>
    </tr>
  <tr>
    <td class="th"><textarea name="content" cols="50" rows="1"><%=MT.f(t.content)%></textarea></td>
    </tr>
  <tr>
    <td class="th">承诺(Commitment and signature)：</td>
    </tr>
  <tr>
    <td class="th"><textarea name="commitment" cols="50" rows="1"><%=MT.f(t.commitment)%></textarea></td>
    </tr>
</table>

<div class="subut">
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/></div>
</form>
