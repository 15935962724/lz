<%@page contentType="text/html;charset=UTF-8" %>




<html>
<head>
<link href="/res/cpcc/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">

</div>

<div id="tablebgnone">
<h1>发布计算机软件著作权登记证书</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value=""/>
<input type="hidden" name="id" value=""/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr>
  <td>申请日期：自
    <input type="text" name="trade" value=""/>到<input type="text" name="trade" value=""/></td>
<td> 软件名称：
    <input type="text" name="price_from" value=""/></td>
</tr>
<tr>
<td>　登记号：　
     <input type="text" name="price_from" value=""/>   　　分类号：<input type="text" name="price_from" value=""/></td>
<td>　申请者：
    <input type="text" name="price_from" value=""/></td>
<td><input type="submit" value="查询" onClick=""/></td>
</tr>
</table>
</form>

<FORM name=form2 METHOD=POST action="/servlet/EditTrade">

<input type="hidden" name="community" value=""/>
<input type="hidden" name="act" value="saleneworder"/>
<input type="hidden" name="trade" value=""/>

<h2>列表 </h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr id="tableonetr">
    <td ><input name="checkbox" type="checkbox" onClick="selectAll(form2.trades,this.checked);"/></td>
    <td>登记号</td>
	<td>申请日期</td>
    <td>软件名称</td>
    <td>分类号</td>
    <td>申请人</td>
    <td>状态</td>
    <td>处理</td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>CPO图书管理系统</td>
    <td>1200--8800</td>
    <td>北京日居科技</td>
    <td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月15日</td>
    <td>摩托车全自动检测系统软件</td>
    <td>64000-5600</td>
    <td>广州铭华机动车测试设备有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>公用事业IC卡充值服务平台软件系统</td>
    <td>65000-7400</td>
    <td>北京金卡通达科技有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>爱迪尔指纹卡Active X控件开发软件  V1.0</td>
    <td>31000-0000</td>
    <td>深圳市爱迪尔电子有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>楼宇经济信息管理系统 V1.0</td>
    <td>65000-0000</td>
    <td>厦门精图数码产业发展有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>物业管理信息系统  V1.0</td>
    <td>165000-80000</td>
    <td>大连金杨电子有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>富信多媒体异型光碟生成平台软件  V1.0</td>
    <td>5500-6000</td>
    <td>杭州富信信息系统集成有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>升源并网电厂指令下发系统软件  V1.0</td>
    <td>65500-7300</td>
    <td>杭州国电升源科技有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>CPO图书管理系统</td>
    <td>1200--8800</td>
    <td>北京日居科技</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>银江卡口实时监控布防系统软件  V1.0</td>
    <td>65500-7300</td>
    <td>杭州银江智能交通系统有限公司</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>CPO图书管理系统</td>
    <td>1200--8800</td>
    <td>北京日居科技</td>
	<td>已发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月15日</td>
    <td>摩托车全自动检测系统软件</td>
    <td>64000-5600</td>
    <td>广州铭华机动车测试设备有限公司</td>
	<td>未发证</td>
	<td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>公用事业IC卡充值服务平台软件系统</td>
    <td>65000-7400</td>
    <td>北京金卡通达科技有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>爱迪尔指纹卡Active X控件开发软件  V1.0</td>
    <td>31000-0000</td>
    <td>深圳市爱迪尔电子有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>楼宇经济信息管理系统 V1.0</td>
    <td>65000-0000</td>
    <td>厦门精图数码产业发展有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>物业管理信息系统  V1.0</td>
    <td>165000-80000</td>
    <td>大连金杨电子有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>富信多媒体异型光碟生成平台软件  V1.0</td>
    <td>5500-6000</td>
    <td>杭州富信信息系统集成有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>升源并网电厂指令下发系统软件  V1.0</td>
    <td>65500-7300</td>
    <td>杭州国电升源科技有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>CPO图书管理系统</td>
    <td>1200--8800</td>
    <td>北京日居科技</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><input type="checkbox" name="trades" value=""/></td>
    <td>2007SRBJ5641</td>
	<td>2007年3月12日</td>
    <td>银江卡口实时监控布防系统软件  V1.0</td>
    <td>65500-7300</td>
    <td>杭州银江智能交通系统有限公司</td>
	<td>未发证</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/MakeCertifi_2.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input name="button2" type=button value="已发证 "></td>
  </tr>
</table>
<div style="text-align:left;width:80%"> 1 <A HREF="#">2</A> <A HREF="#">3</A> <A HREF="#">4</A> <A HREF="#">5</A> <A HREF="#">6</A> <A HREF="#">7</A> <A HREF="#">8</A> <A HREF="#">9</A> <A HREF="#">10</A> <A HREF="#">下一页</A> <A HREF="#" ID=CBLast>最后</A> </div>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="jspafter" style="display:none">

</div>


</body>
</html>


