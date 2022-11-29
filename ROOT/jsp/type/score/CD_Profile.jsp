<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %><%@page import="java.util.*" %>
<%@include file="/jsp/Header.jsp"%>
<%

String member=teasession._rv.toString();
Profile profile_obj=Profile.find(member);

if("POST".equals(request.getMethod()))
{
  String org=request.getParameter("org");
  String job=request.getParameter("job");
  String tel=request.getParameter("tel");
  String address=request.getParameter("address");
  profile_obj.setOrganization(org,teasession._nLanguage);
  profile_obj.setJob(job,teasession._nLanguage);
  profile_obj.setTelephone(tel,teasession._nLanguage);
  profile_obj.setAddress(address,teasession._nLanguage);
  out.print("<script>");
  out.print("alert('修改成功!');");
  out.print("window.open('?node="+teasession._nNode+"','_self');</script>");
  return;
}

Iterator it=Score.findByMember(member).iterator();
Score s=it.hasNext()?(Score)it.next():new Score();

%>
<div class="title"><h2>个人资料</h2><span>会员ID：<%=profile_obj.getMember()%></span></div>
<form name="form_pro" method="POST" action="?" onsubmit="return submitText(this.newp,'新密码不能为空!')&&submitLength(6,20,this.newp,'密码长度必需在6-20位之间!')&&submitEqual(this.newp,this.cp,'您输入的两次密码不相同!')">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<div id="tablecenter03">
<table>
 <tr>
    <td class="td001">差点会员号码：</td><td class="td002"><%=member%></td>
    <td class="td003">差点信用卡号：</td><td class="td004"><%=profile_obj.getCreditcard()%>　</td>
 </tr>
 <tr>
    <td class="td001">姓名：</td><td class="td002"><%=profile_obj.getName(teasession._nLanguage)%>　</td>
    <td class="td003">即时差点指数：</td><td class="td004"><%=Score.getIndex(member)%></td>
 </tr>
  <tr>
    <td class="td001">产生日期：</td><td class="td002"><%=s.getTimesToString()%></td>
    <td class="td003">临时差点指数：</td><td class="td004"><%=s.getIndex()%></td>
  </tr>
  <tr>
    <td class="td001">所在单位：</td><td class="td002"><input name="org" value="<%=profile_obj.getOrganization(teasession._nLanguage)%>" /></td>
    <td class="td003">现任职务：</td><td class="td004"><input name="job" value="<%=profile_obj.getJob(teasession._nLanguage)%>"/></td>
  </tr>
  <tr>
    <td class="td001">联系方式：</td><td class="td002"><input name="tel" value="<%=profile_obj.getTelephone(teasession._nLanguage)%>" /></td>
    <td class="td003">详细地址：</td><td class="td004"><input name="address" value="<%=profile_obj.getAddress(teasession._nLanguage)%>"/></td>
  </tr>
 </table>
 </div>
<div class="submit"><input  class="input1" type="submit" value="" />  <input type="button" value="" class="input2" onclick="history.back();" /></div>
</form>
<script>form_pro.org.focus();</script>
