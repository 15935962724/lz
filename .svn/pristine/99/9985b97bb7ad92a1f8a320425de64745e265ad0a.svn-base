<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getParameter("NewNode")==null&&request.getParameter("NewBrother")==null&&!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}



r.add("/tea/ui/node/type/Report/EditReport").add("/tea/ui/util/SignUp1");
Profile profile = Profile.find(teasession._rv._strR);
Admin summary=Admin.find(0,teasession._nLanguage);
String nationality =profile.getState(teasession._nLanguage);
if(nationality ==null||nationality .length()<=0)
nationality ="中国";

long len=0;
String _strPhotopath=profile.getPhotopath(teasession._nLanguage);
if(_strPhotopath!=null)
{
  java.io.File f=new java.io.File(application.getRealPath(_strPhotopath));
  len=f.length();
}












String  TYPE[][]=
{{"计算机/互联网","-- CTO/技术总监/经理","-- CIO/IT经理","-- 产品经理","-- 系统分析员","-- 软件工程师","-- 硬件工程师","-- 软件测试工程师","-- 硬件测试工程师","-- 数据库管理员","-- 信息安全工程师","-- 售前/售后支持工程师","-- 系统集成工程师","-- 系统管理员","-- 网络工程师","-- IT工程师","-- 语音/视频/图形","-- 游戏开发人员","-- ERP技术/应用顾问","-- 网站策划","-- 网站编辑","-- 网站美工","-- 网页设计与制作","-- 技术文档编写员","-- 研发工程师"},
{"电子/电器/通信","-- 电子工程师","-- 电器工程师","-- 电信工程师/通讯工程师","-- 电声工程师","-- 数码产品开发工程师","-- 单片机/DLC/DSP/底层软件开发","-- 无线电工程师","-- 半导体工程师","-- 电子元器件工程师","-- 电子/电器维修","-- 研发工程师","-- 光学工程师","-- 测试工程师","-- 技术文员/助理"},
{"电气/能源/动力","-- 电气工程师","-- 光源与照明工程","-- 变压器/磁电工程师","-- 电路工程师","-- 智能大厦/综合布线/弱电","-- 电力工程师","-- 电气维修技术员","-- 水利/水电工程师","-- 核力/火力工程师","-- 空调/热能工程师","-- 石油天然气技术人员","-- 自动控制"},
{"机械/仪器仪表","-- 机械工程师","-- 模具工程师","-- 机械设计师","-- 机械制图员","-- 机电工程师","-- 精密机械/仪器仪表技术员","-- 铸造/锻造工程师","-- 注塑工程师","-- CNC工程师","-- 冲压工程师","-- 夹具工程师","-- 锅炉工程师","-- 焊接工程师","-- 汽车/摩托车工程师","-- 船舶工程师","-- 飞行器设计与制造","-- 机械维修工程师"},
{"销售","-- 销售总监/经理/主管","-- 客户经理/业务经理","-- 渠道经理/主管","-- 销售代表","-- 售前/售后工程师","-- 销售助理","-- 业务拓展经理/主管","-- 业务拓展专员/助理"},
{"项目管理","-- 项目总监","-- 项目经理/主管"},
{"客户服务","-- 客户服务经理/主管","-- 客户服务专员/助理","-- 客户关系管理","-- 客户咨询/热线支持","-- 投诉处理/监控"},
{"市场/广告/公关与媒介","-- 市场推广专员","-- 市场联盟与拓展经理/主管","-- 市场联盟与拓展专员","-- 市场推广经理/主管","-- 产品/品牌专员","-- 市场调研与分析","-- 广告创意与策划/文案","-- 市场总监/经理","-- 市场专员/助理","-- 产品/品牌经理/主管","-- 公关与媒介经理/主管","-- 公关与媒介专员","-- 会务经理/主管","-- 会务专员"},
{"经营管理","-- CEO/总裁/总经理","-- COO/副总/董事会秘书","-- 总经理助理"},
{"咨询顾问","-- 咨询总监","-- 咨询师","-- 研究员"},
{"人力资源/行政/文职人员","-- 行政/人力资源总监","-- 人力资源经理/主管","-- 人力资源专员/助理","-- 招聘经理/主管","-- 招聘专员/助理","-- 培训经理/主管","-- 培训专员/助理","-- 培训师","-- 薪资福利经理/主管","-- 薪资福利专员/助理","-- 绩效考核经理/主管","-- 绩效考核专员/助理","-- 员工关系经理/主管","-- 员工关系专员/助理","-- 行政经理/主管/办公室主任","-- 行政专员/助理","-- 部门助理/秘书/文员","-- 前台/总机"},
{"财务/审计/统计","-- CFO/财务总监/经理","-- 财务主管","-- 会计","-- 出纳","-- 财务分析","-- 成本管理","-- 审计","-- 财务助理","-- 统计员","-- 税务主管/专员"},
{"金融/经济","-- 金融/经济机构管理和运营","-- 投资顾问/投资分析","-- 保险业务/经纪人/代理人","-- 证券/外汇/期货经纪人","-- 融资经理/主管/专员","-- 风险管理","-- 客户经理/主管/专员","-- 资产评估","-- 信贷/信用调查/分析人员","-- 预结算/清算人员","-- 银行专员/出纳员","-- 保险精算师","-- 税务人员"},
{"贸易/物流/采购/运输","-- 外贸经理/主管/专员/助理","-- 国内贸易经理/主管/专员/助理","-- 业务跟单","-- 单证员/报关员/海运/空运操作人员","-- 商务经理/主管/专员/助理","-- 采购经理/主管/专员/助理","-- 物流经理/主管/专员","-- 仓库经理/主管/管理员","-- 运输经理/主管","-- 货运代理","-- 海陆空交通运输","-- 调度员","-- 速递员"},
{"建筑/房地产/装饰装修/物业管理","-- 建筑师","-- 结构工程师/土建工程师","-- 建筑制图","-- 建筑工程管理","-- 工程监理","-- 给排水/强电/弱电/制冷暖通","-- 房地产开发/策划","-- 房地产评估","-- 设备工程师","-- 工程造价/估价/预决算","-- 路桥/隧道/港口/航道工程","-- 园林/园艺","-- 室内外装潢设计","-- 物业管理","-- 城市规划与设计","-- 房地产中介/交易"},
{"翻译","-- 英语","-- 日语","-- 法语","-- 德语","-- 俄语","-- 西班牙语","-- 朝鲜语"},
{"酒店/餐饮/旅游/运动休闲","-- 娱乐/餐饮管理","-- 大堂经理/副理","-- 楼面经理/主任","-- 厨师/调酒师","-- 服务员/侍者/门童","-- 接待/礼仪/接线生","-- 导游","-- 健身教练"},
{"工厂生产","-- 厂长/副厂长","-- 总工程师/副总工程师","-- 采购管理","-- 物料/物流管理","-- 设备管理","-- 安全/健康/环境管理","-- 产品开发","-- 生产工艺/技术","-- 质量管理","-- 仓库管理","-- 生产管理/督导/计划调度","-- 维修工程师"},
{"轻工","-- 纺织技术","-- 染整技术","-- 制鞋/制衣/制革/手袋","-- 服装制版/打版师","-- 印刷/包装","-- 纸浆造纸工艺","-- 食品/糖烟酒饮料/粮油","-- 陶瓷技术","-- 金银首饰加工","-- 家具制造"},
{"商业零售","-- 店长","-- 营运","-- 生鲜/防损技术人员","-- 理货员","-- 营业员/服务员/店员/导购员","-- 收银员"},
{"美术/设计/创意","-- 设计管理人员","-- 美术/图形设计","-- 工业/产品设计","-- 服装/纺织品设计师","-- 工艺品/珠宝设计","-- 家具设计","-- 平面设计","-- 媒体广告设计","-- 造型设计","-- 网页设计","-- 多媒体设计","-- 动画设计","-- 展示/装潢设计","-- 文案创意"},
{"文体/影视/写作/媒体","-- 作家/撰稿人","-- 总编/副总编","-- 编辑/记者","-- 美术编辑","-- 发行","-- 出版","-- 校对/录入","-- 排版设计","-- 艺术总监","-- 广播影视策划/制作","-- 导演/编导","-- 摄影/摄像","-- 录音/音效师","-- 化妆师/造型师","-- 演员/配音/模特","-- 主持人/播音员/DJ","-- 演艺/体育经纪人"},
{"教育/培训","-- 教学/教务管理人员","-- 幼儿教育","-- 教师","-- 讲师","-- 助教","-- 家教"},
{"法律","-- 律师","-- 法律顾问","-- 律师助理","-- 法务人员","-- 公/检/法系统"},
{"医疗卫生/美容保健","-- 医疗管理人员","-- 医疗技术人员","-- 医生/医师","-- 心理医生","-- 医药检验","-- 护士/护理人员","-- 药学技术与管理人员","-- 疾病控制/公共卫生","-- 美容/整形师","-- 兽医/宠物医生"},
{"生物/制药/化工/环保","-- 生物工程/生物制药","-- 药品注册","-- 药物研发/药物分析","-- 化学药剂/药品/化肥","-- 无机化学","-- 有机化学","-- 精细化工","-- 分析化工","-- 高分子化工","-- 应用化学","-- 材料物理","-- 材料化学","-- 环保工程"},
{"科研","-- 科研管理人员","-- 科研人员"},
{"技工/服务类/后勤保障","-- 电工/铆焊工/钳工","-- 空调工/电梯工/锅炉工","-- 油漆/钣金","-- 锯床/车床/磨床/铣床/冲床/锣床","-- 铲车/叉车工","-- 机修工","-- 寻呼/声讯服务","-- 食堂厨师","-- 司机","-- 保安","-- 普工","-- 裁减车缝熨烫","-- 水工/木工/油漆工","-- 美容美发技工","-- 社区/家政服务","-- 清洁工","-- 搬运工"},
{"农林牧渔"},
{"公务员"},
{"培训生"},
{"在校学生","-- 应届毕业生","-- 非应届毕业生"},
{"其他","-- 航空航天","-- 安全消防","-- 声光学技术/激光技术","-- 测绘技术","-- 地质矿产冶金","-- 气象"}};











String community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta content="SharePoint.WebPartPage.Document" name="ProgId">
<meta content="full" name="WebPartPageExpansion">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
<meta content="C#" name="CODE_LANGUAGE">
<meta content="JavaScript" name="vs_defaultClientScript">
<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<%--<script language="javascript" src="/tea/CssJs/AreaCityDataCN.js"></script>--%>
<script language="javascript" src="/tea/CssJs/CnoocAreaCityDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
<script language="javascript" type="text/javascript" src="/tea/CssJs/WebUIValidation.js"></script>
<script language="javascript">
function alteroption(big,small)
{
    var ccc=small.length;
    for(var len=0;ccc>=0;ccc--)
    small.options[ccc]=null;
  //  var index=big.options[big.selectedIndex].value;
    switch(big.selectedIndex)
    {
      <%java.util.Enumeration smallOccScript,bigOccScript=tea.entity.site.Occupation.findByFather(Occupation.getRootId(teasession._strCommunity));
      int occ;
      StringBuffer sbBig=new StringBuffer();
      StringBuffer sbSmall=new StringBuffer();
      for(int index=1;bigOccScript.hasMoreElements();index++)
      {
        occ=((Integer)bigOccScript.nextElement()).intValue();
        out.println("case "+index+" : ");
        String temp=tea.entity.site.Occupation.find(occ).getSubject();
        smallOccScript=tea.entity.site.Occupation.findByFather(occ);
        sbBig.append("<OPTION VALUE="+temp+">"+temp+"</OPTION>");
        sbSmall.append("<OPTION VALUE="+temp+">"+temp+"</OPTION>");
        out.println("small.options.add(new Option('"+temp+"','"+temp+"'));");
        for(int smallIndex=0;smallOccScript.hasMoreElements();smallIndex++)
        {
          occ=((Integer)smallOccScript.nextElement()).intValue();
          temp=tea.entity.site.Occupation.find(occ).getSubject();
//          out.println("small.options.add(new Option('-- "+temp+"',"+occ+"));");
//          sbSmall.append("<OPTION VALUE="+occ+">-- "+temp+"</OPTION>");
         out.println("small.options.add(new Option('-- "+temp+"','"+temp+"'));");
          sbSmall.append("<OPTION VALUE="+temp+">-- "+temp+"</OPTION>");
        }
        out.println("break;");
      }
    %>
  }
}

	function regInput(obj, reg, inputStr)
	{
		var docSel	= document.selection.createRange()
		if (docSel.parentElement().tagName != "INPUT")	return false
		oSel = docSel.duplicate()
		oSel.text = ""
		var srcRange	= obj.createTextRange()
		oSel.setEndPoint("StartToStart", srcRange)
		var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length)
		return reg.test(str)
	}
		function  save_onclick()
		{
		  var strTemp = document.all['Resume'].value;
		  if (strTemp.length == 0 )
		  {
			  alert("请输入简历名称！");
			  document.all['Resume'].focus();
			  return false;
          }
          var FirstName = document.all['FirstName'].value;
          if (FirstName.length == 0 )
          {
              alert("请输入姓名！");
              document.all['FirstName'].focus();
              return false;
          }
          var Email = document.all['Email'].value;
          if (Email.length == 0 )
          {
              alert("请填写E-mail！");
              document.all['Email'].focus();
              return false;
		  }
          var strage = document.all['age'].value;
		  if (isNaN(parseInt(strage)))
		  {
			  alert("请填写年龄！");
			  document.all['age'].focus();
			  return false;
		  }else
                  {
                    document.all['age'].value=parseInt(strage);
                  }

		  var strTemp = document.all['Address'].value;
		  if (strTemp.length == 0 )
		  {
			  alert("请填写居住地！");
			  document.all['Address'].focus();
			  return false;
                  }
                  var strTemp = document.all['school'].value;
                  if (strTemp.length == 0 )
                  {
                          alert("请填写毕业学校！");
                          document.all['school'].focus();
                          return false;
		  }
		  /*var strTemp = document.all['NowTrade'].value;
		  if (strTemp== 0 )
		  {
			  alert("请选择现从事行业！");
               document.all['NowTrade'].focus();
			  return false;
		  }*/
		  var strTemp =document.all['NowCareer'].value;// document.all['NowMainCareer'].value;
		  if (strTemp.length== 0 )
		  {
			  alert("请选择现从事职业！");
              document.all['NowMainCareer'].focus();
			  return false;
		  }
		  var strTemp = document.all['NowCareerLevel'].value;
		  if (strTemp== 0 )
		  {
			  alert("请选择现职位级别！");
              document.all['NowCareerLevel'].focus();
			  return false;
		  }
		  var strTemp = document.all['Experience'].value;
		  if (strTemp.length == 0 )
		  {
			  alert("请填写工作经验！");
			  document.all['Experience'].focus();
			  return false;
		  }
		  if ((!document.all['ExpectWorkKind:0'].checked)&&(!document.all['ExpectWorkKind:1'].checked)&&(!document.all['ExpectWorkKind:2'].checked)&&(!document.all['ExpectWorkKind:3'].checked))
		  {
			  alert("请填写期望工作性质！");
               document.all['ExpectWorkKind:0'].focus();
			  return false;
		  }
		  var strTemp = document.all['SelfValueCN'].value;
		  if (strTemp.length == 0 )
		  {
			  alert("请填写自我评价！");
			  document.all['SelfValueCN'].focus();
			  return false;
		  }
		  var strTemp = document.all['ExpectCareer'].length;
		  if (strTemp== 0 )
		  {
			  alert("请选择期望从事职业！");
               document.all['ExpectCareer'].focus();
			  return false;
		  }
		  for (var i=0;i<strTemp;i++)
		  {
		  		document.all['ExpectCareer'].options[i].selected=true;
		  }
		  var strTemp = document.all['ExpectCity'].length;
		  if (strTemp== 0 )
		  {
			  alert("请选择期望工作地区！");
               document.all['ExpectCity'].focus();
			  return false;
		  }
		  for (var i=0;i<strTemp;i++)
		  {
		  		document.all['ExpectCity'].options[i].selected=true;
		  }
          /*// 期望从事行业
		  var strTemp = document.all['ExpectTrade'].length;
		  for (var i=0;i<strTemp;i++)
		  {
		  		document.all['ExpectTrade'].options[i].selected=true;
		  }*/
		  return true;
		}

        <!--
        //给地区父控件设置选中值
      function SetSelectedValueType( objName,varValue )
      {
        for( var i=0; i < document.all(objName).length; i ++ )
        {
          if( document.all(objName).options[i].value == varValue )
          {
            document.all(objName).selectedIndex = i;
            break;
          }
        }
      }
      //给地区子控件设置选中值
      function SetSelectedValueList( objName,varValue )
      {
          changeChildList(document.all['ResidenceState'],document.all['ResidenceCity']) //选中当前父控件的子项目（调用onchange）
          for( var i=0; i < document.all(objName).length; i ++ )
          {
            if( document.all(objName).options[i].value == varValue )
            {
              document.all(objName).selectedIndex = i;
              break;
            }
          }
      }
      //
function InitForm()
{
  var txtValue   = document.all['ResidenceCity'].value;
  var txtLength  = document.all['ResidenceCity'].value.length;
  var SplitValue = txtValue.substring(txtLength-1,txtLength) //最后一位是1
  //是否选择了其它城市
  if (SplitValue == "1")
  {
    //显示其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "";
    document.all['RequiredFieldValidatorOtherCity'].enabled = true;
  }
  ChangeContactType();
}
function SelectCity()
{
  var txtValue   = document.all['ResidenceCity'].value;
  var txtLength  = document.all['ResidenceCity'].value.length;
  var SplitValue = txtValue.substring(txtLength-1,txtLength) //最后一位是1
  //是否选择了其它城市
  if (SplitValue == "1")
  {
    //显示其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "";
    document.all['RequiredFieldValidatorOtherCity'].enabled = true;
  }
  else
  {
    //隐藏其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "none";
    document.all['RequiredFieldValidatorOtherCity'].enabled = false;
  }
}
function ChangeContactType()
{
  if (document.all['contact_type1'].selectedIndex==0)  //手机
  {
    document.all['RegularexpressionContactNo1'].enabled = true;
  }
  else
  {
    RegularexpressionContactNo1.enabled = false;
    //document.all['RegularexpressionContactNo1'].enabled = false;
  }
}
//-->
    </script>
<%------------职业概况/求职意向------------%>
<script language="javascript">
	function onChanged(obj)
      {
        if (obj.options[obj.selectedIndex].value==0)
          return false;

        if ((obj.options[obj.selectedIndex].value.length)>5)
          document.location=obj.options[obj.selectedIndex].value;
        else
          document.location="../SearchLocation.aspx?locid=" + obj.options[obj.selectedIndex].value;
      }
</script>
<script language="javascript">
	function onChanged(obj)
      {
        if (obj.options[obj.selectedIndex].value==0)
          return false;

        if ((obj.options[obj.selectedIndex].value.length)>5)
          document.location=obj.options[obj.selectedIndex].value;
        else
          document.location="../SearchLocation.aspx?locid=" + obj.options[obj.selectedIndex].value;
      }
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Brief")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<FORM name="Form1" METHOD=POST action="/servlet/EditAdmin" >
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <%
    String parameter=teasession.getParameter("nexturl");
    String Preview="";
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
String    educateParam="";
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");

            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");

            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {
         Preview="<A href=/jsp/type/resume/Preview.jsp?node="+teasession._nNode+" style=color=#ffffff target=_blank >预览简历</A>";
       educateParam="Node="+teasession._nNode;
summary=Admin.find(teasession._nNode,teasession._nLanguage);
   }
            %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >基本信息</td>
      <td  align=right ><%=Preview%></td>
    </tr>
    <tr>
      <td><div align="right"><strong>* 简历名称&nbsp;&nbsp; </strong></div></td>
      <td><input type="TEXT" class="edit_input"  name=Resume value="<%=getNull(summary.getName())%>" size=20 maxlength=20>
      </td>
    </tr>
    <tr>
      <td><div align="right"><strong>* 姓名&nbsp;&nbsp; </strong></div></td>
      <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=getNull(profile.getFirstName(teasession._nLanguage))%><%//=getNull(profile.getLastName(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20>
        <!-- <%=r.getString(teasession._nLanguage, "LastName")%>: <input type="TEXT" class="edit_input"  name=LastName value="<%=profile.getLastName(teasession._nLanguage)%>" size=20 maxlength=20>--></td>
    </tr>
    <TR>
      <TD align="right" ></TD>
      <TD><span id="RequiredFieldValidatorName" controltovalidate="NameCN" errormessage="请填写姓名！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写姓名！</span></TD>
    </TR>
    <tr>
      <td align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;性别&nbsp;&nbsp;</strong></td>
      <td><span id="gender">
        <input   id="radio" type="radio" name="gender" value="1" checked />
        <label for="gender_0">&nbsp;男&nbsp;</label>
        <input   id="radio" type="radio" name="gender" value="0" <%=getCheck(!profile.isSex())%>/>
        <label for="gender_1">&nbsp;女</label>
        </span></td>
    </tr>
    <TR>
      <TD align="right"></TD>
      <TD><span id="ccTypeReqVal" controltovalidate="gender" errormessage="请选择性别！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请选择性别！</span></TD>
    </TR>
    <tr>
      <td  align="right"><strong>* <%=r.getString(teasession._nLanguage, "EmailAddress")%>&nbsp;&nbsp;</strong></td>
      <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=profile.getEmail()%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td  align="right"><strong>
        <%--=r.getString(teasession._nLanguage, "Handset")--%>
        手机&nbsp;&nbsp;</strong></td>
      <td><input type="TEXT" class="edit_input"  name=Mobile  VALUE="<%=profile.getMobile()%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td  align="right"><strong>
        <%--=r.getString(teasession._nLanguage, "Handset")--%>
        电话&nbsp;&nbsp;</strong></td>
      <td><input type="TEXT" class="edit_input"  name=telephone  VALUE="<%=profile.getTelephone(teasession._nLanguage)%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td align="right"><span class="alert"><strong>*</strong></span><strong>年龄&nbsp;&nbsp;</strong></td>
      <td><input type="TEXT" class="edit_input"  name=age  VALUE="<%=profile.getAge()==0?"":String.valueOf(profile.getAge())%>" >
      </td>
    </tr>
    <tr>
      <td><div align="right"><strong>照片&nbsp;&nbsp;</strong></div></td>
      <td><iframe SRC="/jsp/type/resume/PhotoUp.jsp" frameborder="0" scrolling="no" width="400" height="40"></iframe>
        <%--<input type=file name=Photo  <%if(len>0)out.print("ondblclick=\"javascript:showPicture('/servlet/PhotoPicture')\""); %> ><%if(len>0)out.print(len+"字节");%><input  id="CHECKBOX" type="CHECKBOX" name="Clear"/>清空</td>--%>
        <br>
        尺寸：90X120 pixels
    </tr>
    <tr>
      <td align="right"><strong>国籍&nbsp;&nbsp;</strong></td>
      <td><input class="edit_input" name="NationalityCN" id="NationalityCN" type="text" maxlength="20" size="20" value="<%=nationality%>" />
        政治面貌&nbsp;&nbsp;
        <%
        tea.html.DropDown select=new tea.html.DropDown("polity",profile.getPolity());
        for(int index=0;index<profile.POLITY_TYPE.length;index++)
        {
          select.addOption(index,r.getString(teasession._nLanguage,profile.POLITY_TYPE[index]));
        }
        out.print(select.toString());
        %></td>
    </tr>
    <tr>
      <td align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;现居住地区/城市&nbsp;&nbsp;</strong></td>
      <td><TEXTAREA name="Address" class="edit_input" ROWS="2" COLS="60"><%=profile.getAddress(teasession._nLanguage)%></TEXTAREA>
      </td>
    </tr>
    <TR>
      <TD align="right"></TD>
      <TD><span id="RequiredFieldValidator4" controltovalidate="ResidenceState" errormessage="请选择现居住地区/城市！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="0" style="color:Red;display:none;">请选择现居住地区/城市！</span></TD>
    </TR>
    <tr id="TrOtherCity" style="DISPLAY: none">
      <td align="right">&nbsp;</td>
      <td><input class="edit_input" name="OtherCityCN" id="OtherCityCN" type="text" maxlength="30" />
&nbsp;&nbsp;<span class="note">请填写你居住的城市</span> </td>
    </tr>
    <TR>
      <TD align="right"></TD>
      <TD><span id="RequiredFieldValidatorOtherCity" controltovalidate="OtherCityCN" errormessage="请填写你居住的城市！" display="Dynamic" enabled="False" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写你居住的城市！</span></TD>
    </TR>
    <tr>
      <td align="right"><span class="alert"><strong>*&nbsp;</strong></span><strong>教育程度&nbsp;&nbsp;</strong></td>
      <td><font size="2"><%=new tea.htmlx.DegreeSelection("Degree",profile.getDegree(teasession._nLanguage))%> </font>&nbsp; <b>* 毕业学校</b>
        <input class="edit_input" value="<%=profile.getSchool(teasession._nLanguage)%>" name="school" id="OtherCityCN" type="text" size="50" maxlength="50" />
      </td>
    </tr>
    <!--
      <tr>
        <td><div align="right"><strong> 教育背景&nbsp;&nbsp;</strong></div></td>
        <td> <input class="edit_button" name="Educate" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEducate.jsp?<%=educateParam%>')"></td>
      </tr>
      <tr>
        <td><div align="right"><strong> 工作经验&nbsp;&nbsp;</strong></div></td>
        <td> <input class="edit_button" name="" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEmployment.jsp?<%=educateParam%>')"></td>
      </tr>-->
    <%---
      <tr>
        <td><div align="right"><strong> \u00BD\u00CC\u00D3\u00FD±\u00B3\u00BE°&nbsp;&nbsp;</strong></div></td>
        <td> <input class="edit_button" name="Educate" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="submit" ></td>
      </tr><!--onclick="window.open('EditEducate.jsp')"-->
      <tr>
        <td><div align="right"><strong> \u00B9¤×÷\u00BE\u00AD\u00D1é&nbsp;&nbsp;</strong></div></td>
        <td> <input class="edit_button" name="Employment" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="submit"></td>
      </tr><!--- onclick="window.open('EditEmployment.jsp')"------>

      -----%>
    <tr>
      <td></td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td vAlign="baseline" ><span >职业概况</span></td>
      <td align="right"></td>
    </tr>
    <!--
      <tr>
        <td vAlign="baseline" align="right" width="130"><span class="alert"><strong>*&nbsp;</strong></span><strong>现从事行业</strong></td>
        <td><span class="note"> <%=new tea.htmlx.TradeSelection("NowTrade",summary.getNowTrade())%> &nbsp;<span class="note">学生请选择“在校学生”</span><br>
          <span id="valNowTrade" controltovalidate="NowTrade" errormessage="请选择现从事行业！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事行业！</span></span></td>
      </tr>-->
    <tr>
      <td vAlign="baseline" align="right"><strong><nobr>*&nbsp;现从事职业&nbsp;&nbsp;</nobr></strong></td>
      <td><span class="note">
        <%--
            <SELECT id="NowMainCareer" name="NowMainCareer" onchange="alteroption(this,Form1.NowCareer)">
                     <OPTION VALUE="-1">--请选择职业--</OPTION>
                     <!--版本号：0002-->
<!--Action:1--><%=sbBig.toString()%>
            </SELECT>
 <%//if(summary.getNowMainCareer()!=null)out.println("<option>"+summary.getNowMainCareer()+"</option>");%>
          <select name="NowCareer" id="NowCareer">
      <%if(summary.getNowMainCareer()!=null)out.println("<option>"+summary.getNowMainCareer()+"</option>");%>
          </select>--%>
        <SELECT id="NowMainCareer" name="NowMainCareer" onchange="fadd(this.selectedIndex)">
          <%
for(int index=0;index<TYPE.length;index++)
out.print("<option value="+TYPE[index][0]+">"+TYPE[index][0]+"</option>");
               %>
        </SELECT>
        <select name="NowCareer" id="NowCareer">
          <%if(summary.getNowMainCareer()!=null)out.println("<option>"+summary.getNowMainCareer()+"</option>");%>
        </select>
        <script>
          function fadd(value)
          {
for(index=Form1.NowCareer.length;index>0           ;index--)
Form1.NowCareer.remove(index-1);

              <%
              for(int index=0;index<TYPE.length;index++)
              {StringBuffer sb=new StringBuffer();
               for(int lenindex=0;lenindex<TYPE[index].length;lenindex++)
               sb.append("Form1.NowCareer.options.add(new Option('"+TYPE[index][lenindex]+"','"+TYPE[index][lenindex].replaceAll("-- ","")+"'));");
              if(index==TYPE.length-1)
                out.println("if(value=="+index+"){"+sb.toString()+"}");
              else
               out.println("if(value=="+index+"){"+sb.toString()+"}else ");
          }
              %>
          }
          </script>
        <span class="note"><nobr>学生请选择“在校学生”</nobr><br>
        <span id="valNowCareer" controltovalidate="NowCareer" errormessage="请选择现从事职业！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事职业！</span></span></FONT></FONT></span></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;现职位级别&nbsp;&nbsp;</strong></td>
      <td noWrap><select class="edit_input" name="NowCareerLevel" id="NowCareerLevel">
          <option value="0"></option>
          <option value="高级决策层(CEO, EVP, GM...)"<%=getSelect(summary.getNowCareerLevel().equals("高级决策层(CEO, EVP, GM...)"))%>>高级决策层(CEO, EVP, GM...)</option>
          <option value="高级职位(管理类)" <%=getSelect(summary.getNowCareerLevel().equals("高级职位(管理类)"))%>>高级职位(管理类)</option>
          <option value="高级职位(非管理类)"<%=getSelect(summary.getNowCareerLevel().equals("高级职位(非管理类)"))%>>高级职位(非管理类)</option>
          <option value="中级职位(两年以上工作经验)"<%=getSelect(summary.getNowCareerLevel().equals("中级职位(两年以上工作经验)"))%>>中级职位(两年以上工作经验)</option>
          <option value="初级职位(两年以下工作经验)"<%=getSelect(summary.getNowCareerLevel().equals("初级职位(两年以下工作经验)"))%>>初级职位(两年以下工作经验)</option>
          <option value="学生"<%=getSelect(summary.getNowCareerLevel().equals("学生"))%>>学生</option>
        </select>
&nbsp;<span class="note"><span class="note">学生请选择“在校学生”</span><br>
        <span id="valNowCareerLevel" controltovalidate="NowCareerLevel" errormessage="请选择现从事职业级别！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事职业级别！</span></span></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><span class="alert"><strong>*&nbsp;</strong></span><strong>工作经验&nbsp;&nbsp;</strong></td>
      <td><input class="edit_input" onkeyup="Form1.Employment.disabled=(this.value=='0');" name="Experience" id="Experience" type="text" maxlength="2" onKeyPress	= "return regInput(this,	/^\d*\.?\d{0,2}$/,		String.fromCharCode(event.keyCode))"
		onpaste		= "return regInput(this,	/^\d*\.?\d{0,2}$/,		window.clipboardData.getData('Text'))"
		ondrop		= "return regInput(this,	/^\d*\.?\d{0,2}$/,		event.dataTransfer.getData('Text'))" size="2" value="<%=summary.getExperience()%>" />
        年 <span class="note"><span class="note">请填写数字，没有工作经验请填写0。</span><br>
        </FONT><span id="valExperience_required" controltovalidate="Experience" errormessage="请填写工作经验！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写工作经验！</span><span id="valExperience_limit" controltovalidate="Experience" errormessage="请填写正确的工作经验年限！" display="Dynamic" type="Integer" evaluationfunction="RangeValidatorEvaluateIsValid" maximumvalue="99" minimumvalue="0" style="color:Red;display:none;">请填写正确的工作经验年限！</span></span></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;是否有海外工作经历&nbsp;&nbsp;</strong></td>
      <td><table id="Has_Abroad" border="0">
          <tr>
            <td><input id="Has_Abroad_0"  id="radio" type="radio" name="Has_Abroad" value="True" <%=getCheck(summary.isHasAbroad())%> />
              <label for="Has_Abroad_0">是 </label></td>
            <td><input id="Has_Abroad_1"  id="radio" type="radio" name="Has_Abroad" value="False"  <%=getCheck(!summary.isHasAbroad())%> />
              <label for="Has_Abroad_1">否 </label></td>
          </tr>
        </table>
        </FONT></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><strong>目前月薪（税前）&nbsp;&nbsp;</strong></td>
      <td><input class="edit_input" name="SalarySum" id="SalarySum" type="text" maxlength="7" size="8" value="<%=summary.getSalarySum()%>" />
        元(人民币) <br>
        <span id="valSalarySum" controltovalidate="SalarySum" errormessage="请填写正确的薪资数额！" display="Dynamic" type="Integer" evaluationfunction="CompareValidatorEvaluateIsValid" operator="DataTypeCheck" style="color:Red;display:none;">请填写正确的薪资数额！</span></td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td colspan="4" align="right" vAlign="baseline"><div align="left"><span >求职意向</span></div></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right" width="130"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望工作性质</strong></td>
      <td colSpan="3"><table id="ExpectWorkKind" border="0">
          <tr>
            <td><input id="ExpectWorkKind_0"  id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:0" <%=getCheck((summary.getExpectWorkKind()&2)!=0)%> />
              <label for="ExpectWorkKind_0">全职</label></td>
            <td><input id="ExpectWorkKind_1"  id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:1" <%=getCheck((summary.getExpectWorkKind()&4)!=0)%>/>
              <label for="ExpectWorkKind_1">兼职</label></td>
            <td><input name="ExpectWorkKind:2"  id="CHECKBOX" type="CHECKBOX" id="ExpectWorkKind_2" <%=getCheck((summary.getExpectWorkKind()&8)!=0)%>name="ExpectWorkKind:2" />
              <label for="ExpectWorkKind_2">临时</label></td>
            <td><input id="ExpectWorkKind_3" <%=getCheck((summary.getExpectWorkKind()&16)!=0)%>  id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:3" />
              <label for="ExpectWorkKind_3">实习</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"></td>
      <td colSpan="3"><span id="valExpectWorkKind" errormessage="请选择期望工作性质！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="ExpectWorkKindClientValidate" style="color:Red;display:none;">请选择期望工作性质！</span></td>
    </tr>
    <%--
      <tr>
        <td vAlign="top" noWrap align="right"><strong>期望从事行业&nbsp;&nbsp;<br>
          （可选5项）&nbsp;&nbsp;</strong> </td>
        <td vAlign="top" width="30%"><select id="srcExpectTrade" style="WIDTH: 160px" multiple size="5" name="srcExpectTrade"> </select> </td>
        <td width="12%"><input class="edit_button" id="btnAddExpectTrade" style="WIDTH: 60px" type="button" value="添加>>" name="btnAddExpectTrade">
          <br>
          <input class="edit_button" id="btnDelExpectTrade" style="WIDTH: 60px" type="button" value="<<删除" name="btnDelExpectTrade">
          </FONT> </td>
        <td vAlign="middle" width="33%"><select id="ExpectTrade" style="WIDTH: 160px" multiple size="5" name="ExpectTrade">
            <%
                    StringTokenizer tokenizer=new StringTokenizer(getNull(summary.getExpectTrade()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
            <option value="<%=str%>"><%=str%></option>
            <%}%>
          </select></td>
      </tr>--%>
    <TR>
      <TD vAlign="top" align="right" rowSpan="2"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望从事职业&nbsp;&nbsp;<br>
        （可选5项）&nbsp;&nbsp;</strong></TD>
      <TD vAlign="top" colSpan="3"><SELECT id="ExpectMainCareer" onchange="alteroption(this,Form1.srcExpectCareer)" name="ExpectMainCareer">
          <OPTION VALUE="-1">--请选择职业--</OPTION>
          <%=sbBig.toString()%>
        </SELECT>
      </TD>
    </TR>
    <tr>
      <td vAlign="top"><select class="edit_input" id="srcExpectCareer" style="WIDTH: 160px" multiple size="5" name="srcExpectCareer">
        </select>
        </FONT> <span id="ExpectCareerValidator" errormessage="请选择期望从事职业！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="expectCareerClientValidate" style="color:Red;display:none;">请选择期望从事职业！</span></td>
      <td><input class="edit_button" id="btnAddExpectCareer" style="WIDTH: 60px" type="button" value="添加&gt;&gt;" name="btnAddExpectCareer">
        <br>
        <input class="edit_button" id="btnDelExpectCareer" style="WIDTH: 60px" type="button" value="&lt;&lt;删除" name="btnDelExpectCareer">
        </FONT> </td>
      <td vAlign="top" width="33%"><select class="edit_input" id="ExpectCareer" style="WIDTH: 160px" multiple size="5" name="ExpectCareer">
          <%
                  StringTokenizer   tokenizer=new StringTokenizer(getNull(summary.getExpectCareer()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
          <option value="<%=str%>"><%=str%></option>
          <%}%>
        </select>
      </td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right" rowSpan="2"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望工作地区&nbsp;&nbsp;<br>
        （可选5项）&nbsp;&nbsp;</strong></td>
      <td colSpan="3"><select id="ExpectState" name="ExpectState">
        </select>
        </FONT> </td>
    </tr>
    <tr>
      <td vAlign="top"><select class="edit_input" id="srcExpectCity" style="WIDTH: 160px" multiple size="5" name="srcExpectCity">
        </select>
        </FONT> <span id="AreaCityValidator" errormessage="请选择期望工作地区！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="areaCityClientValidate" style="color:Red;display:none;">请选择期望工作地区！</span></td>
      <td><input class="edit_button" id="btnAddExpectCity" style="WIDTH: 60px" type="button" value="添加&gt;&gt;" name="btnAddExpectCity">
        <br>
        <input class="edit_button" id="btnDelExpectCity" style="WIDTH: 60px" type="button" value="&lt;&lt;删除" name="btnDelExpectCity">
        </FONT></td>
      <td vAlign="top" width="33%"><select class="edit_input" id="ExpectCity" style="WIDTH: 160px" multiple size="5" name="ExpectCity">
          <%
                     tokenizer=new StringTokenizer(getNull(summary.getExpectCity()),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
          <option value="<%=str%>"><%=str%></option>
          <%}%>
        </select></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><strong>期望月薪（税前）&nbsp;&nbsp;</strong></td>
      <td colSpan="3"><input class="edit_input" name="ExpectSalarySum" id="ExpectSalarySum" type="text" maxlength="7" size="8"  value="<%=summary.getExpectSalarySum()%>" />
        元(人民币) 不填表示面议<br>
        <span id="valExpectSalarySum" controltovalidate="ExpectSalarySum" errormessage="请填写正确的薪资数额！" display="Dynamic" type="Integer" evaluationfunction="CompareValidatorEvaluateIsValid" operator="DataTypeCheck" style="color:Red;display:none;">请填写正确的薪资数额！</span></td>
    </tr>
    <tr>
      <td vAlign="baseline" align="right"><strong>到岗时间&nbsp;&nbsp;</strong></td>
      <td colSpan="3"><select name="JoinDateType" id="JoinDateType">
          <option value="100" selected>面谈</option>
          <option value="0"<%=getSelect(summary.getJoinDateType().equals("0"))%>>立即</option>
          <option value="7" <%=getSelect(summary.getJoinDateType().equals("7"))%>>1周以内</option>
          <option value="30"<%=getSelect(summary.getJoinDateType().equals("30"))%>>1个月内</option>
          <option value="60"<%=getSelect(summary.getJoinDateType().equals("60"))%>>1～3个月</option>
          <option value="90"<%=getSelect(summary.getJoinDateType().equals("90"))%>>3个月后</option>
        </select>
      </td>
    </tr>
  </table>
  <div id="ValidationSummary1" headertext="你现在无法保存。原因是：" showmessagebox="True" showsummary="False" style="color:Red;display:none;"> </div>
  <br>
  <%--  </form>--%>
  <script language="javascript" type="">
/*期望工作地区*/
var expectStateObj=document.all['ExpectState'];
var srcExpectCityObj=document.all['srcExpectCity'];
var expectCityObj=document.all['ExpectCity'];
var areaCityValidatorObj=document.all['AreaCityValidator'];

if(typeof(Form1.btnAddExpectCity)=="object") Form1.btnAddExpectCity.onclick=function()
{
// addCityNodes(expectStateObj,srcExpectCityObj,expectCityObj,"期望工作地区限选5项！");
    addCityNodes(expectStateObj,srcExpectCityObj,expectCityObj,"期望工作地区限选5项！");
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(Form1.btnDelExpectCity)=="object") Form1.btnDelExpectCity.onclick=function()
{
    removeChildNodes(expectCityObj);
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(expectStateObj)=="object") expectStateObj.onchange=function()
{
    onChangeProvince(document.all['ExpectState'],document.all['srcExpectCity']);
}

function areaCityClientValidate(source,arguments)
{
    if (expectCityObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(expectStateObj)=="object" && typeof(srcExpectCityObj)=="object" && typeof(expectCityObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    initProvince(expectStateObj,srcExpectCityObj,"");
    initCityNodes(expectCityObj,"");
}

/*期望从事职业*/
var ExpectMainCareerObj = document.all['ExpectMainCareer'];
var srcExpectCareerObj=document.all['srcExpectCareer'];
var expectCareerObj=document.all['ExpectCareer'];
var expectCareerValidatorObj=document.all['ExpectCareerValidator'];

if(typeof(Form1.btnAddExpectCareer)=="object") Form1.btnAddExpectCareer.onclick=function()
{
    addOccupationNodes(ExpectMainCareerObj,srcExpectCareerObj,expectCareerObj,"期望从事职业限选5项！");
    ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(Form1.btnDelExpectCareer)=="object") Form1.btnDelExpectCareer.onclick=function()
{
    removeChildNodes(expectCareerObj);
   ValidatorValidate(expectCareerValidatorObj);
}/*
if(typeof(ExpectMainCareerObj)=="object") ExpectMainCareerObj.onchange=function()
{
    onChangeOccupation(ExpectMainCareerObj,srcExpectCareerObj);
}*/

function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}
/*
if(typeof(ExpectMainCareerObj)=="object" && typeof(srcExpectCareerObj)=="object" && typeof(expectCareerObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    InitMainOccupation(ExpectMainCareerObj,srcExpectCareerObj,"");
    initOccupationNodes(expectCareerObj,"");
}*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /*从事职业*//*
var NowMainCareerObj = document.all['NowMainCareer'];
var NowCareerObj=document.all['NowCareer'];
var NowCareerValidatorObj=document.all['valNowCareer'];

if(typeof(NowMainCareerObj)=="object") NowMainCareerObj.onchange=function()
{
    onChangeNowOccupation(NowMainCareerObj,NowCareerObj);
    if(NowCareerValidatorObj != null)
    ValidatorValidate(NowCareerValidatorObj);
}
if(typeof(NowMainCareerObj)=="object" && typeof(NowCareerObj)=="object" )
{
    InitNowMainOccupation(NowMainCareerObj,NowCareerObj,"");
    for(var i=0;i<NowCareerObj.options.length;i++)
    {
      var optiontemp = NowCareerObj.options[i];
      if(optiontemp.value == "")
        optiontemp.selected = true;
    }
}*/
/*期望从事行业*/
var srcExpectTradeObj=document.all['srcExpectTrade'];
var expectTradeObj=document.all['ExpectTrade'];

if(typeof(Form1.btnAddExpectTrade)=="object") Form1.btnAddExpectTrade.onclick=function()
{
    addChildNodes(srcExpectTradeObj,expectTradeObj,"期望从事行业限选5项！");
}
if(typeof(Form1.btnDelExpectTrade)=="object") Form1.btnDelExpectTrade.onclick=function()
{
    removeChildNodes(expectTradeObj);
}

function ExpectTradeClientValidate(source,arguments)
{
    if (expectTradeObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(srcExpectTradeObj)=="object" && typeof(expectTradeObj)=="object")
{
    initExpectTradeNodes(srcExpectTradeObj,expectTradeObj,"");
}


/*btnSave为服务器端button*/
if(typeof(document.all['btnSave'])=="object") document.all['btnSave'].onclick=function()
{
    if(typeof(Page_ClientValidate)!='function') return false;

    Page_ClientValidate();
    if(!Page_IsValid) return false;

    selectAll(expectCityObj);
    selectAllOccupations(expectCareerObj);
    selectAll(expectTradeObj);
    return true;
}

/*ExpectWorkKindValidator*/
var workKindObjs=new Array(document.all['ExpectWorkKind_0'],document.all['ExpectWorkKind_1'],document.all['ExpectWorkKind_2'],document.all['ExpectWorkKind_3']);
var expectWorkKindValidatorObj=document.all['valExpectWorkKind'];

for(var i=0;i<4;i++)
{
    if(typeof(workKindObjs[i])=="object") workKindObjs[i].onclick=function()
    {
        ValidatorValidate(expectWorkKindValidatorObj);
    }
}

function ExpectWorkKindClientValidate(source,arguments)
{
    for(var i=0;i<4;i++)
    {
        if(workKindObjs[i].checked)
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}

//取得mm月的总天数
//d31={1,3,5,7,8,10,12};
//d30={4,6,9,11};
//d28/d29={2}
function getMonthDays(yy,mm)
{
    if(mm==2)
    {
        if(yy%4==0 || (yy%100==0 && yy%400==0)) return 29;
        else return 28;
    }
    else if(mm==4 || mm==6 || mm==9 || mm==11) return 30;
    else return 31;
}

/*TwoChangeClientValidate*/
var lang1Objs=new Array(document.all['sLanguageCN1'],document.all['sLevelCN1'],document.all['Language1Validator'],document.all['Level1Validator']);
var lang2Objs=new Array(document.all['sLanguageCN2'],document.all['sLevelCN2'],document.all['Language2Validator'],document.all['Level2Validator']);
var lang3Objs=new Array(document.all['sLanguageCN3'],document.all['sLevelCN3'],document.all['Language3Validator'],document.all['Level3Validator']);
function initTwoControls(firstObj,secondObj)
{
    if(secondObj.selectedIndex==0) secondObj.disabled=true;
    else secondObj.remove(0);
}

function changeTwoControls(firstObj,secondObj)
{
    if(firstObj.selectedIndex==0)
    {
        if(secondObj.options[0].value!="0")
        {
            secondObj.options.add(new Option("","0"),0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=true;
    }
    else
    {
        if(secondObj.options[0].value=="0")
        {
            secondObj.remove(0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=false;
    }
}

if(lang1Objs[0]!=null)
{
    initTwoControls(lang1Objs[0],lang1Objs[1]);
}
if(lang1Objs[0]!=null) lang1Objs[0].onchange=function()
{
    changeTwoControls(lang1Objs[0],lang1Objs[1]);
}

if(lang2Objs[0]!=null)
{
    initTwoControls(lang2Objs[0],lang2Objs[1]);
}
if(lang2Objs[0]!=null) lang2Objs[0].onchange=function()
{
    changeTwoControls(lang2Objs[0],lang2Objs[1]);
}

if(lang3Objs[0]!=null)
{
    initTwoControls(lang3Objs[0],lang3Objs[1]);
}
if(lang3Objs[0]!=null) lang3Objs[0].onchange=function()
{
    changeTwoControls(lang3Objs[0],lang3Objs[1]);
}
    </script>
  <table class="section" id="table20" cellspacing="0" cellpadding="3"  border="0">
    <tr>
      <td valign="top" align="right" ><span class="alert"><strong>*&nbsp;</strong></span><strong>自我评价&nbsp;&nbsp;</strong></td>
      <td><span class="note">
        <textarea class="edit_input" name="SelfValueCN" rows="4" cols="60" id="textarea"><%=summary.getSelfValue()%></textarea>
        <br>
        概述你的职业优势，如：“3年IT销售经验”、“5年外资大型企业人事经理经验”。 <br>
        （限200字。 <a id="linkSelfValueCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['SelfValueCN'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
        <span id="valSelfValue_required" controltovalidate="SelfValueCN" errormessage="请填写自我评价！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写自我评价！</span> <span id="valSelfValue_limit" controltovalidate="SelfValueCN" errormessage="自我评价限200个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,200}" style="color:Red;display:none;">自我评价限200个字！</span> </span> </td>
    </tr>
    <tr>
      <td valign="top" align="right"><strong>职业目标&nbsp;&nbsp;</strong></td>
      <td><span class="note">
        <textarea class="edit_input" name="ObjectCN" rows="7" cols="60" id="ObjectCN"><%=summary.getSelfAim()%></textarea>
        <br>
        让招聘单位了解你的职业方向。（限500字。 <a id="linkObjectCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['ObjectCN'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
        <span id="valObject" controltovalidate="ObjectCN" errormessage="职业目标限500个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,500}" style="color:Red;display:none;">职业目标限500个字！</span><br>
        </span> </td>
    </tr>
  </table>
  <table class="section" id="table20" cellspacing="0" cellpadding="3"  border="0">
    <tr>
      <td valign="top" align="right" ><span class="alert"></span><strong>奖励和其它&nbsp;&nbsp;</strong></td>
      <td><span class="note">
        <textarea class="edit_input" name="other" rows="5" cols="60" id="textarea"><%=getNull(summary.getOther())%></textarea>
        <br>
        概述你的奖励或其它优势。 （限200字。 <a id="linkSelfValueCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['other'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
      </td>
    </tr>
  </table>
  <P ALIGN=CENTER>
    <input class="edit_button"  name="Educate" VALUE="教育背景" type="submit" onClick="return save_onclick();">
    <!--- onclick="window.open('EditEducate.jsp?<%=educateParam%>')">-->
    <input class="edit_button" name="Employment" VALUE="工作经验" type="submit" onClick="return save_onclick();">
    <!-- onclick="window.open('EditEmployment.jsp?<%=educateParam%>')">-->
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" onClick="return save_onclick();">
    <%if(License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>"  onClick="return save_onclick();">
    <%}%>
  </P>
  <%/////////////////////JAVASCRIPT///////////START/////////////////%>
  <script language="javascript">
var startYearObj=document.all['ymStartDate_ymYear'];
var startMonthObj=document.all['ymStartDate_ymMonth'];
var endYearObj=document.all['ymEndDate_ymYear'];
var endMonthObj=document.all['ymEndDate_ymMonth'];

function startDateClientValidate(source,arguments)
{
    arguments.IsValid=(startYearObj.selectedIndex>0);
}

function startEndDateClientValidate(source,arguments)
{
    if((startYearObj.selectedIndex>0 && startMonthObj.selectedIndex>0) && !(endYearObj.selectedIndex>0 && endMonthObj.selectedIndex==0))
    {
        var start=new Date(startYearObj.value,startMonthObj.value,1);
        var end=new Date(endYearObj.value,endMonthObj.value,1);
        arguments.IsValid=(end>=start);
    }
}

      </script>
  <script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valOrgName"], document.all["valOrgInfo"], document.all["valWorkSite"], document.all["valPositionName"], document.all["valStartDate"], document.all["valStartEndDate"], document.all["valFunction_1"], document.all["valFunction_2"], document.all["valReasonOfLeaving"]);
		// -->
</script>
  <script language="javascript" type="text/javascript">
function ValidatorOnSubmit() {
    if (Page_ValidationActive) {
        return ValidatorCommonOnSubmit();
    }
    return true;
}
// -->
</script>
  <script language="javascript" type="text/javascript">
<!--
function ValidatorOnSubmit() {
    if (Page_ValidationActive) {
        return ValidatorCommonOnSubmit();
    }
    return true;
}
// -->
</script>
  <script language="javascript" type="text/javascript">
function ValidatorOnSubmit() {
    if (Page_ValidationActive) {
        return ValidatorCommonOnSubmit();
    }
    return true;
}
// -->
</script>
</FORM>
<script language="javascript">
function areaCityClientValidate(source,arguments)
{
    if (expectCityObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}
function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}
function ExpectTradeClientValidate(source,arguments)
{
    if (expectTradeObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}
for(var i=0;i<4;i++)
{
    if(typeof(workKindObjs[i])=="object") workKindObjs[i].onclick=function()
    {
        ValidatorValidate(expectWorkKindValidatorObj);
    }
}

function ExpectWorkKindClientValidate(source,arguments)
{
    for(var i=0;i<4;i++)
    {
        if(workKindObjs[i].checked)
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}

//取得mm月的总天数
function getMonthDays(yy,mm)
{
    if(mm==2)
    {
        if(yy%4==0 || (yy%100==0 && yy%400==0)) return 29;
        else return 28;
    }
    else if(mm==4 || mm==6 || mm==9 || mm==11) return 30;
    else return 31;
}

/*TwoChangeClientValidate*/
var lang1Objs=new Array(document.all['sLanguageCN1'],document.all['sLevelCN1'],document.all['Language1Validator'],document.all['Level1Validator']);
var lang2Objs=new Array(document.all['sLanguageCN2'],document.all['sLevelCN2'],document.all['Language2Validator'],document.all['Level2Validator']);
var lang3Objs=new Array(document.all['sLanguageCN3'],document.all['sLevelCN3'],document.all['Language3Validator'],document.all['Level3Validator']);

function initTwoControls(firstObj,secondObj)
{
    if(secondObj.selectedIndex==0) secondObj.disabled=true;
    else secondObj.remove(0);
}

function changeTwoControls(firstObj,secondObj)
{
    if(firstObj.selectedIndex==0)
    {
        if(secondObj.options[0].value!="0")
        {
            secondObj.options.add(new Option("","0"),0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=true;
    }
    else
    {
        if(secondObj.options[0].value=="0")
        {
            secondObj.remove(0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=false;
    }
}
    </script>
<%
          if(summary.getNowMainCareer()!=null)
          out.println("<script>Form1.NowCareer.options[Form1.NowCareer.selectedIndex].text='"+summary.getNowMainCareer()+"';Form1.NowCareer.options[Form1.NowCareer.selectedIndex].value='"+summary.getNowMainCareer()+"';</script>");
          %>
<script>Form1.Resume.focus();Form1.Employment.disabled=(Form1.Experience.value=='0');</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

