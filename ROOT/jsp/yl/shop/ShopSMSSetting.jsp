<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
StringBuffer sql=new StringBuffer(),par=new StringBuffer();


int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=ShopIntegralRules.count(sql.toString());
String acts=h.get("acts","");
int puid = h.getInt("puid");
ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+puid,pos,1);
ShopSMSSetting sms = ShopSMSSetting.find(0);
if(list.size() > 0)
	sms = list.get(0);
StringBuilder tjdd = new StringBuilder(); //提交订单
StringBuilder qrfh = new StringBuilder(); //确认发货
StringBuilder ckwc = new StringBuilder(); //出库完成
StringBuilder syfp = new StringBuilder(); //索要发票
StringBuilder fpjc = new StringBuilder(); //发票寄出
StringBuilder thsq = new StringBuilder(); //退货申请
StringBuilder thwc = new StringBuilder(); //退货完成

StringBuilder zhtx = new StringBuilder(); //资质到期提醒
StringBuilder qxckdd = new StringBuilder(); //取消出库订单
StringBuilder ckfh = new StringBuilder(); //出库复核
StringBuilder ckcs = new StringBuilder(); //出库复核
StringBuilder ckjgtz = new StringBuilder(); //出库结果通知
StringBuilder sczjbg = new StringBuilder(); //上传质检报告

StringBuilder dck = new StringBuilder(); //待出库通知
StringBuilder fpkj=new StringBuilder(); //发票开具

StringBuilder hkds = new StringBuilder(); //回款待审通知
StringBuilder hkshwc=new StringBuilder(); //回款审核完成通知
StringBuilder hkfpsh=new StringBuilder(); //回款匹配发票审核
StringBuilder fwfsh=new StringBuilder(); //回款匹配发票审核

StringBuilder cwykp=new StringBuilder(); //财务已开票通知
%>
<!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>

</head>
<body>
<h1>短信提醒</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/ShopSMSSettings.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act" value="edit"/>
	<input type="hidden" name="puid" value="<%= puid%>"/>

<input type="hidden" name="id" value="<%=sms.id %>"/>

<div class='radiusBox'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2'>短信设置：（确认发货、出库完成、退货订单申请、厂家出库驳回通知、上传质检报告通知这五项的短信提醒，发送相关发货厂家的这五项配置的管理员。）</td></tr>
</thead>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;width:150px'>发送项</td>
		<td>发送人</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>提交订单</td><!-- item 1 -->
		<%
			String[] arr=MT.f(sms.tjdd,"|").split("[|]");
			for(int i=1;i<arr.length;i++){
				  if(arr[i]!=null&&arr[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr[i]));
				    tjdd.append("<span><input type='hidden' name='tjdd' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_tjdd"><%=tjdd.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='tjdd';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=tjdd&member='+mt.value(form2.tjdd,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>确认发货</td><!-- item 2 -->
		<%
			String[] arr1=MT.f(sms.qrfh,"|").split("[|]");
			for(int i=1;i<arr1.length;i++){
				  if(arr1[i]!=null&&arr1[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr1[i]));
				    qrfh.append("<span><input type='hidden' name='qrfh' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_qrfh"><%=qrfh.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='qrfh';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=qrfh&member='+mt.value(form2.qrfh,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>出库完成</td><!-- item 3 -->
		<%
			String[] arr2=MT.f(sms.ckwc,"|").split("[|]");
			for(int i=1;i<arr2.length;i++){
				  if(arr2[i]!=null&&arr2[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr2[i]));
				    ckwc.append("<span><input type='hidden' name='ckwc' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_ckwc"><%=ckwc.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='ckwc';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=ckwc&member='+mt.value(form2.ckwc,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>索要发票</td><!-- item 0 -->
		<%
			String[] arr3=MT.f(sms.syfp,"|").split("[|]");
			for(int i=1;i<arr3.length;i++){
				  if(arr3[i]!=null&&arr3[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr3[i]));
				    syfp.append("<span><input type='hidden' name='syfp' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_syfp"><%=syfp.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='syfp';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=syfp&member='+mt.value(form2.syfp,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>发票寄出</td><!-- item 0 -->
		<%
			String[] arr4=MT.f(sms.fpjc,"|").split("[|]");
			for(int i=1;i<arr4.length;i++){
				  if(arr4[i]!=null&&arr4[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr4[i]));
				    fpjc.append("<span><input type='hidden' name='fpjc' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_fpjc"><%=fpjc.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='fpjc';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpjc&member='+mt.value(form2.fpjc,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>退货订单申请</td><!-- item 0 -->
		<%
			String[] arr5=MT.f(sms.thsq,"|").split("[|]");
			for(int i=1;i<arr5.length;i++){
				  if(arr5[i]!=null&&arr5[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr5[i]));
				    thsq.append("<span><input type='hidden' name='thsq' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_thsq"><%=thsq.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='thsq';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=thsq&member='+mt.value(form2.thsq,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>退货订单完成</td><!-- item 0 -->
		<%
			String[] arr6=MT.f(sms.thwc,"|").split("[|]");
			for(int i=1;i<arr6.length;i++){
				  if(arr6[i]!=null&&arr6[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr6[i]));
				    thwc.append("<span><input type='hidden' name='thwc' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_thwc"><%=thwc.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='thwc';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=thwc&member='+mt.value(form2.thwc,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='thwc';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=thwc&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>资质到期提醒</td><!-- item 0 -->
		<%
			String[] arr7=MT.f(sms.zhtx,"|").split("[|]");
			for(int i=1;i<arr7.length;i++){
				  if(arr7[i]!=null&&arr7[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr7[i]));
				    zhtx.append("<span><input type='hidden' name='zhtx' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_zhtx"><%=zhtx.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='zhtx';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=zhtx&member='+mt.value(form2.zhtx,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> 
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>取消出库订单</td><!-- item 0 -->
		<%
			String[] arr8=MT.f(sms.qxckdd,"|").split("[|]");
			for(int i=1;i<arr8.length;i++){
				  if(arr8[i]!=null&&arr8[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr8[i]));
				    qxckdd.append("<span><input type='hidden' name='qxckdd' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_qxckdd"><%=qxckdd.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='qxckdd';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=qxckdd&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>待入库通知</td><!-- item 0 -->
		<%
			String[] arr9=MT.f(sms.ckfh,"|").split("[|]");
			for(int i=1;i<arr9.length;i++){
				  if(arr9[i]!=null&&arr9[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr9[i]));
				    ckfh.append("<span><input type='hidden' name='ckfh' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_ckfh"><%=ckfh.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='ckfh';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=ckfh&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>质量验收通知</td><!-- item 0 -->
		<%
			String[] arr10=MT.f(sms.ckcs,"|").split("[|]");
			for(int i=1;i<arr10.length;i++){
				  if(arr10[i]!=null&&arr10[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr10[i]));
				    ckcs.append("<span><input type='hidden' name='ckcs' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_ckcs"><%=ckcs.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='ckcs';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=ckcs&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>厂家出库驳回通知</td><!-- item 0 -->
		<%
			String[] arr11=MT.f(sms.ckjgtz,"|").split("[|]");
			for(int i=1;i<arr11.length;i++){
				  if(arr11[i]!=null&&arr11[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr11[i]));
				    ckjgtz.append("<span><input type='hidden' name='ckjgtz' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_ckjgtz"><%=ckjgtz.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='ckjgtz';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=ckjgtz&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>上传质检报告通知</td><!-- item 0 -->
		<%
			String[] arr12=MT.f(sms.sczjbg,"|").split("[|]");
			for(int i=1;i<arr12.length;i++){
				  if(arr12[i]!=null&&arr12[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr12[i]));
				    sczjbg.append("<span><input type='hidden' name='sczjbg' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_sczjbg"><%=sczjbg.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='sczjbg';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=sczjbg&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>待出库通知</td><!-- item 0 -->
		<%
			String[] arr13=MT.f(sms.dck,"|").split("[|]");
			for(int i=1;i<arr13.length;i++){
				  if(arr13[i]!=null&&arr13[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr13[i]));
				    dck.append("<span><input type='hidden' name='dck' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_dck"><%=dck.toString()%></span>
			<button class="btn btn-primary btn-xs" onClick="FIE='dck';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=dck&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<!-- <td style='border-right:solid 1px #d7d7d7;'>开具发票通知</td> --><!-- item 0 -->
		<td style='border-right:solid 1px #d7d7d7;'>通知财务开票</td>
		<%
			String[] arr14=MT.f(sms.fpkj,"|").split("[|]");
			for(int i=1;i<arr14.length;i++){
				  if(arr14[i]!=null&&arr14[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr14[i]));
				    fpkj.append("<span><input type='hidden' name='fpkj' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_fpkj"><%=fpkj.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>回款待审通知</td><!-- item 0 -->
		<%
			String[] arr15=MT.f(sms.hkds,"|").split("[|]");
			for(int i=1;i<arr15.length;i++){
				  if(arr15[i]!=null&&arr15[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr15[i]));
				    hkds.append("<span><input type='hidden' name='hkds' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_hkds"><%=hkds.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='hkds';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=hkds&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>回款审核完成通知</td><!-- item 0 -->
		<%
			String[] arr16=MT.f(sms.hkshwc,"|").split("[|]");
			for(int i=1;i<arr16.length;i++){
				  if(arr16[i]!=null&&arr16[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr16[i]));
				    hkshwc.append("<span><input type='hidden' name='hkshwc' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_hkshwc"><%=hkshwc.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='hkshwc';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=hkshwc&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>回款匹配发票审核通知</td><!-- item 0 -->
		<%
			String[] arr17=MT.f(sms.hkfpsh,"|").split("[|]");
			for(int i=1;i<arr17.length;i++){
				  if(arr17[i]!=null&&arr17[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr17[i]));
				    hkfpsh.append("<span><input type='hidden' name='hkfpsh' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_hkfpsh"><%=hkfpsh.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='hkfpsh';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=hkfpsh&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<td style='border-right:solid 1px #d7d7d7;'>服务费审核通知</td><!-- item 0 -->
		<%
			String[] arr18=MT.f(sms.fwfsh,"|").split("[|]");
			for(int i=1;i<arr18.length;i++){
				  if(arr18[i]!=null&&arr18[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr18[i]));
				    fwfsh.append("<span><input type='hidden' name='fwfsh' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_fwfsh"><%=fwfsh.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='fwfsh';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fwfsh&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
	<tr>
		<!-- <td style='border-right:solid 1px #d7d7d7;'>开具发票通知</td> --><!-- item 0 -->
		<td style='border-right:solid 1px #d7d7d7;'>财务已开票通知</td>
		<%
			String[] arr19=MT.f(sms.cwykp,"|").split("[|]");
			for(int i=1;i<arr19.length;i++){
				  if(arr19[i]!=null&&arr19[i].length()>0){
				    Profile p=Profile.find(Integer.parseInt(arr19[i]));
				    cwykp.append("<span><input type='hidden' name='cwykp' value='"+p.profile+"'/>"+p.getName(h.language)+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>");
				  }
			}
		%>
		<td style="padding:0px;"><span id="_cwykp"><%=cwykp.toString()%></span>
			<!-- <button class="btn btn-primary btn-xs" onClick="FIE='fpkj';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=fpkj&member='+mt.value(form2.fpkj,'|')+'',1,'添加后台用户',500,500)" type="button">选择用户</button> -->
			<button class="btn btn-primary btn-xs" onClick="FIE='cwykp';mt.show('/jsp/profile/Member1Sel_SMS.jsp?smstype=cwykp&member=',1,'添加后台用户',500,500)" type="button">选择用户</button>
		</td>
	</tr>
</table>
</div>
<div class='mt15'><input type="submit" value="提交" class='btn btn-primary' />&nbsp;&nbsp;<input type="button" value="返回"  onclick="history.back(-1)" class='btn btn-default' /></div>
<br/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.id.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='';
    else if(a=='edit')
      form2.action='/jsp/yl/shop/ShopHospitalsEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};

var FIE='_type_';
mt.receive=function(v,n,h){
  if(FIE=='tjdd'){
    $$('_tjdd').innerHTML+=h;
  }else if(FIE=='qrfh'){
	  $$('_qrfh').innerHTML+=h;
  }else if(FIE=='ckwc'){
	  $$('_ckwc').innerHTML+=h;
  }else if(FIE=='syfp'){
	  $$('_syfp').innerHTML+=h;
  }else if(FIE=='fpjc'){
	  $$('_fpjc').innerHTML+=h;
  }else if(FIE=='thsq'){
	  $$('_thsq').innerHTML+=h;
  }else if(FIE=='thwc'){
	  $$('_thwc').innerHTML+=h;
  }else if(FIE=='zhtx'){
	  $$('_zhtx').innerHTML+=h;
  }else if(FIE=='qxckdd'){
	  $$('_qxckdd').innerHTML+=h;
  }else if(FIE=='ckfh'){
	  $$('_ckfh').innerHTML+=h;
  }else if(FIE=='ckcs'){
	  
	  $$('_ckcs').innerHTML+=h;
	  
  }else if(FIE=='ckjgtz'){
	  $$('_ckjgtz').innerHTML+=h;
  }else if(FIE=='sczjbg'){
	  $$('_sczjbg').innerHTML+=h;
  }else if(FIE=='dck'){
	  $$('_dck').innerHTML+=h;
  }else if(FIE=='fpkj'){
	  $$('_fpkj').innerHTML+=h;
  }else if(FIE=='hkds'){
	  $$('_hkds').innerHTML+=h;
  }else if(FIE=='hkshwc'){
	  $$('_hkshwc').innerHTML+=h;
  }else if(FIE=='hkfpsh'){
	  $$('_hkfpsh').innerHTML+=h;
  }else if(FIE=='fwfsh'){
	  $$('_fwfsh').innerHTML+=h;
  }else if(FIE=='cwykp'){
	  $$('_cwykp').innerHTML+=h;
  }
};
mt.del=function(p){p=p.parentNode;p.parentNode.removeChild(p);};

</script>
</body>
</html>
