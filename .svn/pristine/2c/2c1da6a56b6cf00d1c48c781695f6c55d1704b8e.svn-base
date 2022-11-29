<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.node.EntSearch entsearch=tea.entity.node.EntSearch.find(teasession.getParameter("name"),teasession._nLanguage);

String TYPE[][]={
{"勘探类","-- 石油地质","-- 地球物理勘探","-- 测井","-- 其他"},
{"开发类","-- 开发地质","-- 油藏工程","-- 其他"},
{"钻采类","-- 钻井","-- 完井","-- 采油","-- 油田化学","-- 其他"},
{"工程类","-- 工程项目管理","-- 工程设计","-- 工程制造","-- 工程安装","-- 工程维修","-- 其他"},
{"炼化气电","-- 炼油工艺","-- 炼油设备","-- 化工工艺","-- LNG","-- 发电","-- 管道","-- 其他"},
{"管理类","-- 财务/审计","-- 金融保险","-- 投资与经济评价","-- 规划/计划/统计","-- 资本运营","-- 市场营销","-- 物流管理","-- 合同/采办","-- 国际贸易","-- 法律","-- 安全环保","-- 行政管理","-- 党群工作","-- 人力资源","-- 科技管理","-- 新闻与媒体传播","-- 计算机与网络","-- 港口码头管理","-- 医学","-- 教育","-- 其他"},
{"工种","-- 采油操作工","-- 钻井司钻","-- 钻修工","-- 维修电工","-- 电器维修员","-- 发电工","-- 仪表工","-- 机工","-- 机电工（工程船舶）","-- 钳工（机修工）","-- 车工","-- 数控车工","-- 铆工","-- 焊工","-- 管工","-- 铣工","-- 起重工","-- 吊车司机","-- 铲/叉车司机","-- 起重水手","-- 水手","-- 潜水员","-- 测井全能操作手","-- 气爆主操","-- 探伤工","-- 外观检验员","-- 合成氨生产工","-- 尿素生产工","-- 化学检验工","-- 通讯工","-- 计算机及网络设备机务员","-- 一般秘书","-- 厨师","-- 司机","-- 物业","-- 其他"}
};
StringBuffer sb[]=new StringBuffer[7];
for(int indexlen=0;indexlen<sb.length;indexlen++)
{sb[indexlen]=new StringBuffer();
  for(int len=0;len<TYPE[indexlen].length;len++)
  {
    sb[indexlen].append("form1.sltOccId_list.options.add(new Option('"+TYPE[indexlen][len]+"','"+TYPE[indexlen][len]+"'));");
  }
}

%>
<%@ include file="EntSearchSave.jsp" %> 
</head>
<body> 
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1> 
<div id="head6"><img height="6" src="about:blank"></div> 
<form name="form1" method="POST"  action="/jsp/type/resume/cnoocjobresumemanage.jsp?node=15544"> 
  <table border="0" id="tablecenter" cellpadding="0" cellspacing="0"> 
  <td>年龄&nbsp;</td> 
    <td><select name="age"> 
        <option value="255" selected>--不限--</option> 
        <option value="6">18-25</option> 
        <option value="5">25-30</option> 
        <option value="4">30-35</option> 
        <option value="3">35-40</option> 
        <option value="2">40-45</option> 
        <option value="1">45-50</option> 
        <option value="-5">50以上</option> 
      </select> </td> 
  <tr> 
    <td> 期望从事职业&nbsp;</td> 
    <td><SELECT  NAME="sltOccId_BigClass"  class="edit_input" "width:200px" onchange="alteroption(form1.sltOccId_BigClass.selectedIndex)" > 
        <%-- %> ONCHANGE="javascript:SelectOption('Occupation',true, form1.sltOccId_BigClass,form1.sltOccId_list, '', '', '');">--%> 
        <OPTION VALUE="">--请选择职业--</OPTION> 
        <OPTION VALUE="勘探类">勘探类</OPTION> 
        <OPTION VALUE="开发类">开发类</OPTION> 
        <OPTION VALUE="钻采类">钻采类</OPTION> 
        <OPTION VALUE="工程类">工程类</OPTION> 
        <OPTION VALUE="炼化气电">炼化气电</OPTION> 
        <OPTION VALUE="管理类">管理类</OPTION> 
        <OPTION VALUE="工种">工种</OPTION> 
      </SELECT> 
      </select> 
      <select name="sltOccId_list"> </select> 
      <script>
function alteroption(index)
{
    var ccc=form1.sltOccId_list.length;
    for(var len=0;ccc>=0;ccc--)
    form1.sltOccId_list.options[ccc]=null;
    if(index==1)
{
    <%=sb[0].toString()      %>
}else if(index==2)
{
        <%=sb[1].toString()      %>
}else if(index==3)
{
        <%=sb[2] .toString()     %>
}else if(index==4)
{
        <%=sb[3]   .toString()   %>
}else if(index ==5)
{
        <%=sb[4]   .toString()   %>
}else if(index==6)
{
        <%=sb[5]  .toString()    %>
}else if(index==7)
{
        <%=sb[6]    .toString()  %>
}
}
</script> 
  </tr> 
  <tr> 
    <td>期望地区&nbsp; <select name="tgt_loc_id" onChange="javascript:SelectOption('Location',false, form1.tgt_loc_id,form1.tgt_loc_city_id,'', '255', '--选择城市--');CheckLoc(form1.tgt_loc_city_id);">
      <option value ="255">--不限--</option>
      <!--版本号：0001-->
      <!--Action:1-->
      <option value="30000">北京</option>
      <option value="31000">上海</option>
      <option value="32000">天津</option>
      <option value="33000">重庆</option>
      <option value="16000">广东省</option>
      <option value="7000">江苏省</option>
      <option value="8000">浙江省</option>
      <option value="9000">安徽省</option>
      <option value="10000">福建省</option>
      <option value="24000">甘肃省</option>
      <option value="17000">广西自治区</option>
      <option value="20000">贵州省</option>
      <option value="18000">海南省</option>
      <option value="1000">河北省</option>
      <option value="13000">河南省</option>
      <option value="6000">黑龙江省</option>
      <option value="14000">湖北省</option>
      <option value="15000">湖南省</option>
      <option value="5000">吉林省</option>
      <option value="11000">江西省</option>
      <option value="4000">辽宁省</option>
      <option value="3000">内蒙古自治区</option>
      <option value="26000">宁夏自治区</option>
      <option value="25000">青海省</option>
      <option value="12000">山东省</option>
      <option value="2000">山西省</option>
      <option value="23000">陕西省</option>
      <option value="19000">四川省</option>
      <option value="22000">西藏自治区</option>
      <option value="27000">新疆自治区</option>
      <option value="21000">云南省</option>
      <option value="34000">香港</option>
      <option value="35000">澳门</option>
      <option value="36000">台湾</option>
      <option value="37000">其他亚洲国家和地区</option>
      <option value="38000">北美洲</option>
      <option value="41000">南美洲</option>
      <option value="39000">大洋洲</option>
      <option value="40000">欧洲</option>
      <option value="42000">非洲</option>
    </select></td> 
    <td>      <select name="tgt_loc_city_id"> 
        <script language="javascript">SelectOption('Location',false, form1.tgt_loc_id,form1.tgt_loc_city_id,'', '255', '--选择城市--');CheckLoc(form1.tgt_loc_city_id);//处理后退时条件保存不住的问题</script> 
      </select> </td> 
  </tr> 
  <tr> 
    <td>学历&nbsp;</td> 
    <td><select name=skr_deg_id> 
        <option value="0">博士</option> 
        <option value="1">MBA</option> 
        <option value="2">硕士</option> 
        <option value="3">本科</option> 
        <option selected value="4">大专</option> 
        <option value="5">中专</option> 
        <option value="6">中技</option> 
        <option value="7">高中</option> 
        <option value="8">初中</option> 
        <option value="9">其它</option> 
      </select> </td> 
  </tr> 
  <tr> 
    <td> 性别 </td> 
    <td><input name="sex"  id="radio" type="radio" checked="checked" value=""> 
      男
      <input name="sex"  id="radio" type="radio" value=""> 
      女</td> 
  </tr> 
  <tr> 
    <td>工作经验&nbsp;</td> 
    <td><!--INPUT TYPE="text" NAME="skr_wrk_year" MAXLENGTH="2" VALUE=""--> 
      <select name="skr_wrk_year"> 
        <option value="255" selected>--不限--</option> 
        <!--版本号：0001--> 
        <!--Action:2--> 
        <option value="0">一年以下</option> 
        <option value="1">1年</option> 
        <option value="2">2年</option> 
        <option value="3">3年</option> 
        <option value="4">4年</option> 
        <option value="5">5年</option> 
        <option value="6">6年</option> 
        <option value="7">7年</option> 
        <option value="8">8年</option> 
        <option value="9">9年</option> 
        <option value="10">10年</option> 
      </select> 
      以上 </td> 
  </tr> 
  <tr> 
    <td>关键词&nbsp;</td> 
    <td><input type="text" name="keyword" maxlength="20" value=""> 
      <span class="note">请填写对候选人的现职位、特长与技能要求，如：销售经理、Linux等</span></td> 
  </tr> 
  <tr> 
    <td>&nbsp;</td> 
    <td><input type="submit" value="查询" /> </td> 
  </tr> </table>
</form> 
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
</BODY>
</html>

