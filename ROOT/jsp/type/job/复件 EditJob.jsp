<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
int copyNode=teasession._nNode;
if(request.getParameter("copynode")!=null)
copyNode=Integer.parseInt(request.getParameter("copynode"));
Job job = Job.find(copyNode, teasession._nLanguage);
String name=job.getName();
if(name==null||name.length()<=0)
name=node.getSubject(teasession._nLanguage);


%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" href="/tea/CssJs/default.css" TYPE="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>

<SCRIPT language="javascript">
<%@include file="EditJob.js" %>
</SCRIPT>

</head>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" HEIGHT="100%" CLASS="bodystyle">



      <TABLE WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="5">
        <FORM NAME="form1" METHOD="post" action="/servlet/EditJob" onSubmit="return CheckForm();">
          <INPUT TYPE="hidden" NAME="hdnTodo" VALUE="save">
          <TR>
            <TD CLASS="alert" WIDTH="100">* 必须填写</TD>
            <TD colspan="3">&nbsp;</TD>
            <TD WIDTH="100">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD ALIGN="right">选择职位模板&nbsp;</TD>
            <TD COLSPAN="5"> <SPAN CLASS="note">
              <SELECT NAME="sltJobTemplate" onChange="window.open('EditJob.jsp?node=<%=teasession._nNode%>&copynode='+window.document.form1.sltJobTemplate.options[window.document.form1.sltJobTemplate.selectedIndex].value,'_self')" STYLE="WIDTH: 222px">
                <OPTION VALUE=""></OPTION>
                <%java.util.Enumeration enumerationtype=Node.findByType(50);int nodetype;
                while(enumerationtype.hasMoreElements()){nodetype=((Integer)enumerationtype.nextElement()).intValue();
                if(nodetype!=teasession._nNode){%>
                <OPTION VALUE="<%=nodetype%>"><%=Node.find(nodetype).getSubject(teasession._nLanguage)%></OPTION>
                <%}}%>
              </SELECT>
              使用职位模板，不必重复输入相同信息。</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 职位名称&nbsp;</TD>
            <TD colspan="3"> <INPUT NAME="txtJobTitle" TYPE="text" VALUE="<%=name%>" SIZE="30" MAXLENGTH="60" STYLE="WIDTH: 222px">
            </TD>
            <TD ALIGN="right">职位编号&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtRefCode" MAXLENGTH="30" VALUE="<%=job.getTxtRefCode()%>">
            </TD>
          </TR>
          <TR>
            <TD HEIGHT="11" ALIGN="right"><SPAN CLASS="alert">*</SPAN> 所属机构&nbsp;</TD>
            <TD HEIGHT="11" COLSPAN="5"><SELECT NAME="sltOrgId" STYLE="WIDTH: 292px">
                <OPTION VALUE="-1">--请选择--</OPTION>
                <%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21);int nodeCode;
while(                enumeration.hasMoreElements()){
   nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>" <%=getSelect(job.getSltOrgId()==nodeCode)%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}enumeration=tea.entity.node.Node.findByType(18);
while(enumeration.hasMoreElements()){
     nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>"  <%=getSelect(job.getSltOrgId()==nodeCode)%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}%>
              </SELECT> <SPAN CLASS="note">轻松管理分公司或部门的职位和应聘简历。</SPAN><A href="/sysset/mem_org_manage.asp">设置机构</A></TD>
          </TR>
          <TR>
            <TD HEIGHT="11" ALIGN="right" NOWRAP><SPAN CLASS="alert">*</SPAN>
              职位性质&nbsp;</TD>
            <TD HEIGHT="11" colspan="3"> <SELECT NAME="sltJobType">
                <OPTION VALUE = "-1">--请选择--</OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="全职" <%=getSelect(job.getSltJobType().equals("全职"))%>>全职</OPTION>
<OPTION VALUE="兼职" <%=getSelect(job.getSltJobType().equals("兼职"))%>>兼职</OPTION>
<OPTION VALUE="临时" <%=getSelect(job.getSltJobType().equals("临时"))%>>临时</OPTION>
<OPTION VALUE="实习" <%=getSelect(job.getSltJobType().equals("实习"))%>>实习</OPTION>

              </SELECT> </TD>
            <TD ALIGN="right">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD ALIGN="right" valign="top"><SPAN CLASS="alert">*</SPAN> 职业类别&nbsp;</TD>
            <TD colspan="5"> <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <TR>
                  <TD><SELECT NAME="sltOccId_BigClass" "width:200px"  ONCHANGE="javascript:SelectOption('Occupation',true, form1.sltOccId_BigClass,form1.sltOccId_list, '', '', '');">
                      <OPTION VALUE="-1">--请选择职业--</OPTION>
                     <!--版本号：0002-->
<!--Action:1-->
<OPTION VALUE="600">计算机/互联网</OPTION>
<OPTION VALUE="700">电子/电器/通信</OPTION>
<OPTION VALUE="2700">电气/能源/动力</OPTION>
<OPTION VALUE="3420">机械/仪器仪表</OPTION>
<OPTION VALUE="100">销售</OPTION>
<OPTION VALUE="604">项目管理</OPTION>
<OPTION VALUE="900">客户服务</OPTION>
<OPTION VALUE="3600">市场/广告/公关与媒介</OPTION>
<OPTION VALUE="1200">经营管理</OPTION>
<OPTION VALUE="2100">咨询顾问</OPTION>
<OPTION VALUE="300">人力资源/行政/文职人员</OPTION>
<OPTION VALUE="400">财务/审计/统计</OPTION>
<OPTION VALUE="1013000">金融/经济</OPTION>
<OPTION VALUE="1014000">贸易/物流/采购/运输</OPTION>
<OPTION VALUE="702">建筑/房地产/装饰装修/物业管理</OPTION>
<OPTION VALUE="1016001">翻译</OPTION>
<OPTION VALUE="1017000">酒店/餐饮/旅游/运动休闲</OPTION>
<OPTION VALUE="3400">工厂生产</OPTION>
<OPTION VALUE="1019000">轻工</OPTION>
<OPTION VALUE="1020000">商业零售</OPTION>
<OPTION VALUE="3800">美术/设计/创意</OPTION>
<OPTION VALUE="3500">文体/影视/写作/媒体</OPTION>
<OPTION VALUE="1900">教育/培训</OPTION>
<OPTION VALUE="1700">法律</OPTION>
<OPTION VALUE="2000">医疗卫生/美容保健</OPTION>
<OPTION VALUE="1026000">生物/制药/化工/环保</OPTION>
<OPTION VALUE="800">科研</OPTION>
<OPTION VALUE="3300">技工/服务类/后勤保障</OPTION>
<OPTION VALUE="1029000">农林牧渔</OPTION>
<OPTION VALUE="2600">公务员</OPTION>
<OPTION VALUE="3700">培训生</OPTION>
<OPTION VALUE="2500">在校学生</OPTION>
<OPTION VALUE="1033000">其他</OPTION>

                    </SELECT></TD>
                  <TD COLSPAN="2" CLASS="note"> &nbsp;按住Ctrl键点击可多选，最多可选三项</TD>
                </TR>
                <TR>
                  <TD>
                  <SELECT NAME="sltOccId_list"  SIZE="5" MULTIPLE STYLE="width:200px">
                   <Script language="javascript">SelectOption('Occupation',true, form1.sltOccId_BigClass,form1.sltOccId_list, '', '', '');//处理后退时条件保存不住的问题</Script>
                   <!--版本号：0002-->
<!--Action:1-->
<OPTION VALUE="600">计算机/互联网</OPTION>
<OPTION VALUE="1001001">-- CTO/技术总监/经理</OPTION>
<OPTION VALUE="1001002">-- CIO/IT经理</OPTION>
<OPTION VALUE="1001003">-- 产品经理</OPTION>
<OPTION VALUE="608">-- 系统分析员</OPTION>
<OPTION VALUE="601">-- 软件工程师</OPTION>
<OPTION VALUE="606">-- 硬件工程师</OPTION>
<OPTION VALUE="1001004">-- 软件测试工程师</OPTION>
<OPTION VALUE="1001005">-- 硬件测试工程师</OPTION>
<OPTION VALUE="610">-- 数据库管理员</OPTION>
<OPTION VALUE="1001006">-- 信息安全工程师</OPTION>
<OPTION VALUE="607">-- 售前/售后支持工程师</OPTION>
<OPTION VALUE="603">-- 系统集成工程师</OPTION>
<OPTION VALUE="609">-- 系统管理员</OPTION>
<OPTION VALUE="602">-- 网络工程师</OPTION>
<OPTION VALUE="1001007">-- IT工程师</OPTION>
<OPTION VALUE="605">-- 语音/视频/图形</OPTION>
<OPTION VALUE="1001008">-- 游戏开发人员</OPTION>
<OPTION VALUE="1001009">-- ERP技术/应用顾问</OPTION>
<OPTION VALUE="1001010">-- 网站策划</OPTION>
<OPTION VALUE="1001011">-- 网站编辑</OPTION>
<OPTION VALUE="1001012">-- 网站美工</OPTION>
<OPTION VALUE="1400">-- 网页设计与制作</OPTION>
<OPTION VALUE="1001013">-- 技术文档编写员</OPTION>
<OPTION VALUE="1001014">-- 研发工程师</OPTION>
<OPTION VALUE="700">电子/电器/通信</OPTION>
<OPTION VALUE="1002001">-- 电子工程师</OPTION>
<OPTION VALUE="1002002">-- 电器工程师</OPTION>
<OPTION VALUE="1002003">-- 电信工程师/通讯工程师</OPTION>
<OPTION VALUE="1002004">-- 电声工程师</OPTION>
<OPTION VALUE="1002005">-- 数码产品开发工程师</OPTION>
<OPTION VALUE="1002006">-- 单片机/DLC/DSP/底层软件开发</OPTION>
<OPTION VALUE="1002007">-- 无线电工程师</OPTION>
<OPTION VALUE="1002008">-- 半导体工程师</OPTION>
<OPTION VALUE="1002009">-- 电子元器件工程师</OPTION>
<OPTION VALUE="1002010">-- 电子/电器维修</OPTION>
<OPTION VALUE="1002011">-- 研发工程师</OPTION>
<OPTION VALUE="1002012">-- 光学工程师</OPTION>
<OPTION VALUE="1002013">-- 测试工程师</OPTION>
<OPTION VALUE="1002014">-- 技术文员/助理</OPTION>
<OPTION VALUE="2700">电气/能源/动力</OPTION>
<OPTION VALUE="1003001">-- 电气工程师</OPTION>
<OPTION VALUE="1003002">-- 光源与照明工程</OPTION>
<OPTION VALUE="1003003">-- 变压器/磁电工程师</OPTION>
<OPTION VALUE="1003004">-- 电路工程师</OPTION>
<OPTION VALUE="2720">-- 智能大厦/综合布线/弱电</OPTION>
<OPTION VALUE="1003005">-- 电力工程师</OPTION>
<OPTION VALUE="1003006">-- 电气维修技术员</OPTION>
<OPTION VALUE="1003007">-- 水利/水电工程师</OPTION>
<OPTION VALUE="1003008">-- 核力/火力工程师</OPTION>
<OPTION VALUE="1003009">-- 空调/热能工程师</OPTION>
<OPTION VALUE="1003010">-- 石油天然气技术人员</OPTION>
<OPTION VALUE="1003011">-- 自动控制</OPTION>
<OPTION VALUE="3420">机械/仪器仪表</OPTION>
<OPTION VALUE="1004001">-- 机械工程师</OPTION>
<OPTION VALUE="1004002">-- 模具工程师</OPTION>
<OPTION VALUE="1004003">-- 机械设计师</OPTION>
<OPTION VALUE="1004004">-- 机械制图员</OPTION>
<OPTION VALUE="2800">-- 机电工程师</OPTION>
<OPTION VALUE="2900">-- 精密机械/仪器仪表技术员</OPTION>
<OPTION VALUE="1004005">-- 铸造/锻造工程师</OPTION>
<OPTION VALUE="1004006">-- 注塑工程师</OPTION>
<OPTION VALUE="1004007">-- CNC工程师</OPTION>
<OPTION VALUE="1004008">-- 冲压工程师</OPTION>
<OPTION VALUE="1004009">-- 夹具工程师</OPTION>
<OPTION VALUE="1004010">-- 锅炉工程师</OPTION>
<OPTION VALUE="1004011">-- 焊接工程师</OPTION>
<OPTION VALUE="1004012">-- 汽车/摩托车工程师</OPTION>
<OPTION VALUE="1004013">-- 船舶工程师</OPTION>
<OPTION VALUE="1004014">-- 飞行器设计与制造</OPTION>
<OPTION VALUE="1004015">-- 机械维修工程师</OPTION>
<OPTION VALUE="100">销售</OPTION>
<OPTION VALUE="1005001">-- 销售总监/经理/主管</OPTION>
<OPTION VALUE="1005002">-- 客户经理/业务经理</OPTION>
<OPTION VALUE="1005003">-- 渠道经理/主管</OPTION>
<OPTION VALUE="1005004">-- 销售代表</OPTION>
<OPTION VALUE="1005005">-- 售前/售后工程师</OPTION>
<OPTION VALUE="1005006">-- 销售助理</OPTION>
<OPTION VALUE="1005007">-- 业务拓展经理/主管</OPTION>
<OPTION VALUE="1005008">-- 业务拓展专员/助理</OPTION>
<OPTION VALUE="604">项目管理</OPTION>
<OPTION VALUE="1006001">-- 项目总监</OPTION>
<OPTION VALUE="1006002">-- 项目经理/主管</OPTION>
<OPTION VALUE="900">客户服务</OPTION>
<OPTION VALUE="1007001">-- 客户服务经理/主管</OPTION>
<OPTION VALUE="1007002">-- 客户服务专员/助理</OPTION>
<OPTION VALUE="1007003">-- 客户关系管理</OPTION>
<OPTION VALUE="1007004">-- 客户咨询/热线支持</OPTION>
<OPTION VALUE="1007005">-- 投诉处理/监控</OPTION>
<OPTION VALUE="3600">市场/广告/公关与媒介</OPTION>
<OPTION VALUE="1008001">-- 市场推广专员</OPTION>
<OPTION VALUE="1008002">-- 市场联盟与拓展经理/主管</OPTION>
<OPTION VALUE="1008003">-- 市场联盟与拓展专员</OPTION>
<OPTION VALUE="1008004">-- 市场推广经理/主管</OPTION>
<OPTION VALUE="1008005">-- 产品/品牌专员</OPTION>
<OPTION VALUE="3630">-- 市场调研与分析</OPTION>
<OPTION VALUE="1500">-- 广告创意与策划/文案</OPTION>
<OPTION VALUE="1008006">-- 市场总监/经理</OPTION>
<OPTION VALUE="1008007">-- 市场专员/助理</OPTION>
<OPTION VALUE="1008008">-- 产品/品牌经理/主管</OPTION>
<OPTION VALUE="1008009">-- 公关与媒介经理/主管</OPTION>
<OPTION VALUE="1008010">-- 公关与媒介专员</OPTION>
<OPTION VALUE="1008011">-- 会务经理/主管</OPTION>
<OPTION VALUE="1008012">-- 会务专员</OPTION>
<OPTION VALUE="1200">经营管理</OPTION>
<OPTION VALUE="1009001">-- CEO/总裁/总经理</OPTION>
<OPTION VALUE="1009002">-- COO/副总/董事会秘书</OPTION>
<OPTION VALUE="1009003">-- 总经理助理</OPTION>
<OPTION VALUE="2100">咨询顾问</OPTION>
<OPTION VALUE="1010001">-- 咨询总监</OPTION>
<OPTION VALUE="1010002">-- 咨询师</OPTION>
<OPTION VALUE="1010003">-- 研究员</OPTION>
<OPTION VALUE="300">人力资源/行政/文职人员</OPTION>
<OPTION VALUE="1011001">-- 行政/人力资源总监</OPTION>
<OPTION VALUE="1011002">-- 人力资源经理/主管</OPTION>
<OPTION VALUE="1011003">-- 人力资源专员/助理</OPTION>
<OPTION VALUE="1011004">-- 招聘经理/主管</OPTION>
<OPTION VALUE="1011005">-- 招聘专员/助理</OPTION>
<OPTION VALUE="1011006">-- 培训经理/主管</OPTION>
<OPTION VALUE="1011007">-- 培训专员/助理</OPTION>
<OPTION VALUE="1011008">-- 培训师</OPTION>
<OPTION VALUE="1011009">-- 薪资福利经理/主管</OPTION>
<OPTION VALUE="1011010">-- 薪资福利专员/助理</OPTION>
<OPTION VALUE="1011011">-- 绩效考核经理/主管</OPTION>
<OPTION VALUE="1011012">-- 绩效考核专员/助理</OPTION>
<OPTION VALUE="1011013">-- 员工关系经理/主管</OPTION>
<OPTION VALUE="1011014">-- 员工关系专员/助理</OPTION>
<OPTION VALUE="1011015">-- 行政经理/主管/办公室主任</OPTION>
<OPTION VALUE="1011016">-- 行政专员/助理</OPTION>
<OPTION VALUE="1011017">-- 部门助理/秘书/文员</OPTION>
<OPTION VALUE="1011018">-- 前台/总机</OPTION>
<OPTION VALUE="400">财务/审计/统计</OPTION>
<OPTION VALUE="1012001">-- CFO/财务总监/经理</OPTION>
<OPTION VALUE="1012002">-- 财务主管</OPTION>
<OPTION VALUE="1012003">-- 会计</OPTION>
<OPTION VALUE="1012004">-- 出纳</OPTION>
<OPTION VALUE="1012005">-- 财务分析</OPTION>
<OPTION VALUE="1012006">-- 成本管理</OPTION>
<OPTION VALUE="1012007">-- 审计</OPTION>
<OPTION VALUE="1012008">-- 财务助理</OPTION>
<OPTION VALUE="1012009">-- 统计员</OPTION>
<OPTION VALUE="1012010">-- 税务主管/专员</OPTION>
<OPTION VALUE="1013000">金融/经济</OPTION>
<OPTION VALUE="1013001">-- 金融/经济机构管理和运营</OPTION>
<OPTION VALUE="2300">-- 投资顾问/投资分析</OPTION>
<OPTION VALUE="1013002">-- 保险业务/经纪人/代理人</OPTION>
<OPTION VALUE="1013003">-- 证券/外汇/期货经纪人</OPTION>
<OPTION VALUE="1013004">-- 融资经理/主管/专员</OPTION>
<OPTION VALUE="1013005">-- 风险管理</OPTION>
<OPTION VALUE="1013006">-- 客户经理/主管/专员</OPTION>
<OPTION VALUE="1013007">-- 资产评估</OPTION>
<OPTION VALUE="1013008">-- 信贷/信用调查/分析人员</OPTION>
<OPTION VALUE="1013009">-- 预结算/清算人员</OPTION>
<OPTION VALUE="1013010">-- 银行专员/出纳员</OPTION>
<OPTION VALUE="1013011">-- 保险精算师</OPTION>
<OPTION VALUE="1013012">-- 税务人员</OPTION>
<OPTION VALUE="1014000">贸易/物流/采购/运输</OPTION>
<OPTION VALUE="1014001">-- 外贸经理/主管/专员/助理</OPTION>
<OPTION VALUE="1014002">-- 国内贸易经理/主管/专员/助理</OPTION>
<OPTION VALUE="1014003">-- 业务跟单</OPTION>
<OPTION VALUE="1014004">-- 单证员/报关员/海运/空运操作人员</OPTION>
<OPTION VALUE="1014005">-- 商务经理/主管/专员/助理</OPTION>
<OPTION VALUE="1014006">-- 采购经理/主管/专员/助理</OPTION>
<OPTION VALUE="1014007">-- 物流经理/主管/专员</OPTION>
<OPTION VALUE="1014008">-- 仓库经理/主管/管理员</OPTION>
<OPTION VALUE="1014009">-- 运输经理/主管</OPTION>
<OPTION VALUE="1014010">-- 货运代理</OPTION>
<OPTION VALUE="1014011">-- 海陆空交通运输</OPTION>
<OPTION VALUE="1014012">-- 调度员</OPTION>
<OPTION VALUE="1014013">-- 速递员</OPTION>
<OPTION VALUE="702">建筑/房地产/装饰装修/物业管理</OPTION>
<OPTION VALUE="3103">-- 建筑师</OPTION>
<OPTION VALUE="1015001">-- 结构工程师/土建工程师</OPTION>
<OPTION VALUE="1015002">-- 建筑制图</OPTION>
<OPTION VALUE="1015003">-- 建筑工程管理</OPTION>
<OPTION VALUE="1015004">-- 工程监理</OPTION>
<OPTION VALUE="3107">-- 给排水/强电/弱电/制冷暖通</OPTION>
<OPTION VALUE="3101">-- 房地产开发/策划</OPTION>
<OPTION VALUE="3102">-- 房地产评估</OPTION>
<OPTION VALUE="1015005">-- 设备工程师</OPTION>
<OPTION VALUE="1015006">-- 工程造价/估价/预决算</OPTION>
<OPTION VALUE="3108">-- 路桥/隧道/港口/航道工程</OPTION>
<OPTION VALUE="3109">-- 园林/园艺</OPTION>
<OPTION VALUE="3110">-- 室内外装潢设计</OPTION>
<OPTION VALUE="2200">-- 物业管理</OPTION>
<OPTION VALUE="1015007">-- 城市规划与设计</OPTION>
<OPTION VALUE="1015008">-- 房地产中介/交易</OPTION>
<OPTION VALUE="1016001">翻译</OPTION>
<OPTION VALUE="1801">-- 英语</OPTION>
<OPTION VALUE="1802">-- 日语</OPTION>
<OPTION VALUE="1803">-- 法语</OPTION>
<OPTION VALUE="1804">-- 德语</OPTION>
<OPTION VALUE="1805">-- 俄语</OPTION>
<OPTION VALUE="1806">-- 西班牙语</OPTION>
<OPTION VALUE="1807">-- 朝鲜语</OPTION>
<OPTION VALUE="1017000">酒店/餐饮/旅游/运动休闲</OPTION>
<OPTION VALUE="1017001">-- 娱乐/餐饮管理</OPTION>
<OPTION VALUE="1017002">-- 大堂经理/副理</OPTION>
<OPTION VALUE="1017003">-- 楼面经理/主任</OPTION>
<OPTION VALUE="1017004">-- 厨师/调酒师</OPTION>
<OPTION VALUE="3308">-- 服务员/侍者/门童</OPTION>
<OPTION VALUE="3309">-- 接待/礼仪/接线生</OPTION>
<OPTION VALUE="1017005">-- 导游</OPTION>
<OPTION VALUE="1017006">-- 健身教练</OPTION>
<OPTION VALUE="3400">工厂生产</OPTION>
<OPTION VALUE="1018001">-- 厂长/副厂长</OPTION>
<OPTION VALUE="1018002">-- 总工程师/副总工程师</OPTION>
<OPTION VALUE="1018003">-- 采购管理</OPTION>
<OPTION VALUE="1018004">-- 物料/物流管理</OPTION>
<OPTION VALUE="1018005">-- 设备管理</OPTION>
<OPTION VALUE="1018006">-- 安全/健康/环境管理</OPTION>
<OPTION VALUE="1018007">-- 产品开发</OPTION>
<OPTION VALUE="1018008">-- 生产工艺/技术</OPTION>
<OPTION VALUE="1000">-- 质量管理</OPTION>
<OPTION VALUE="3430">-- 仓库管理</OPTION>
<OPTION VALUE="3440">-- 生产管理/督导/计划调度</OPTION>
<OPTION VALUE="1018009">-- 维修工程师</OPTION>
<OPTION VALUE="1019000">轻工</OPTION>
<OPTION VALUE="1019001">-- 纺织技术</OPTION>
<OPTION VALUE="1019002">-- 染整技术</OPTION>
<OPTION VALUE="1019003">-- 制鞋/制衣/制革/手袋</OPTION>
<OPTION VALUE="1019004">-- 服装制版/打版师</OPTION>
<OPTION VALUE="1019005">-- 印刷/包装</OPTION>
<OPTION VALUE="1019006">-- 纸浆造纸工艺</OPTION>
<OPTION VALUE="1019007">-- 食品/糖烟酒饮料/粮油</OPTION>
<OPTION VALUE="1019008">-- 陶瓷技术</OPTION>
<OPTION VALUE="1019009">-- 金银首饰加工</OPTION>
<OPTION VALUE="1019010">-- 家具制造</OPTION>
<OPTION VALUE="1020000">商业零售</OPTION>
<OPTION VALUE="1020001">-- 店长</OPTION>
<OPTION VALUE="1020002">-- 营运</OPTION>
<OPTION VALUE="1020003">-- 生鲜/防损技术人员</OPTION>
<OPTION VALUE="1020004">-- 理货员</OPTION>
<OPTION VALUE="1020005">-- 营业员/服务员/店员/导购员</OPTION>
<OPTION VALUE="3307">-- 收银员</OPTION>
<OPTION VALUE="3800">美术/设计/创意</OPTION>
<OPTION VALUE="1021001">-- 设计管理人员</OPTION>
<OPTION VALUE="1021002">-- 美术/图形设计</OPTION>
<OPTION VALUE="1021003">-- 工业/产品设计</OPTION>
<OPTION VALUE="1021004">-- 服装/纺织品设计师</OPTION>
<OPTION VALUE="1021005">-- 工艺品/珠宝设计</OPTION>
<OPTION VALUE="1021006">-- 家具设计</OPTION>
<OPTION VALUE="1021007">-- 平面设计</OPTION>
<OPTION VALUE="1021008">-- 媒体广告设计</OPTION>
<OPTION VALUE="1021009">-- 造型设计</OPTION>
<OPTION VALUE="1021010">-- 网页设计</OPTION>
<OPTION VALUE="1021011">-- 多媒体设计</OPTION>
<OPTION VALUE="1021012">-- 动画设计</OPTION>
<OPTION VALUE="1021013">-- 展示/装潢设计</OPTION>
<OPTION VALUE="1021014">-- 文案创意</OPTION>
<OPTION VALUE="3500">文体/影视/写作/媒体</OPTION>
<OPTION VALUE="1022001">-- 作家/撰稿人</OPTION>
<OPTION VALUE="1022002">-- 总编/副总编</OPTION>
<OPTION VALUE="1600">-- 编辑/记者</OPTION>
<OPTION VALUE="1022003">-- 美术编辑</OPTION>
<OPTION VALUE="1022004">-- 发行</OPTION>
<OPTION VALUE="1022005">-- 出版</OPTION>
<OPTION VALUE="1022006">-- 校对/录入</OPTION>
<OPTION VALUE="1022007">-- 排版设计</OPTION>
<OPTION VALUE="1022008">-- 艺术总监</OPTION>
<OPTION VALUE="1022009">-- 广播影视策划/制作</OPTION>
<OPTION VALUE="1022010">-- 导演/编导</OPTION>
<OPTION VALUE="1022011">-- 摄影/摄像</OPTION>
<OPTION VALUE="1022012">-- 录音/音效师</OPTION>
<OPTION VALUE="1022013">-- 化妆师/造型师</OPTION>
<OPTION VALUE="1022014">-- 演员/配音/模特</OPTION>
<OPTION VALUE="1022015">-- 主持人/播音员/DJ</OPTION>
<OPTION VALUE="1022016">-- 演艺/体育经纪人</OPTION>
<OPTION VALUE="1900">教育/培训</OPTION>
<OPTION VALUE="1023001">-- 教学/教务管理人员</OPTION>
<OPTION VALUE="1023002">-- 幼儿教育</OPTION>
<OPTION VALUE="1023003">-- 教师</OPTION>
<OPTION VALUE="1023004">-- 讲师</OPTION>
<OPTION VALUE="1023005">-- 助教</OPTION>
<OPTION VALUE="1023006">-- 家教</OPTION>
<OPTION VALUE="1700">法律</OPTION>
<OPTION VALUE="1024001">-- 律师</OPTION>
<OPTION VALUE="1024002">-- 法律顾问</OPTION>
<OPTION VALUE="1024003">-- 律师助理</OPTION>
<OPTION VALUE="1024004">-- 法务人员</OPTION>
<OPTION VALUE="1024005">-- 公/检/法系统</OPTION>
<OPTION VALUE="2000">医疗卫生/美容保健</OPTION>
<OPTION VALUE="1025001">-- 医疗管理人员</OPTION>
<OPTION VALUE="1025002">-- 医疗技术人员</OPTION>
<OPTION VALUE="1025003">-- 医生/医师</OPTION>
<OPTION VALUE="1025004">-- 心理医生</OPTION>
<OPTION VALUE="1025005">-- 医药检验</OPTION>
<OPTION VALUE="1025006">-- 护士/护理人员</OPTION>
<OPTION VALUE="1025007">-- 药学技术与管理人员</OPTION>
<OPTION VALUE="1025008">-- 疾病控制/公共卫生</OPTION>
<OPTION VALUE="1025009">-- 美容/整形师</OPTION>
<OPTION VALUE="1025010">-- 兽医/宠物医生</OPTION>
<OPTION VALUE="1026000">生物/制药/化工/环保</OPTION>
<OPTION VALUE="1026001">-- 生物工程/生物制药</OPTION>
<OPTION VALUE="1026002">-- 药品注册</OPTION>
<OPTION VALUE="1026003">-- 药物研发/药物分析</OPTION>
<OPTION VALUE="1026004">-- 化学药剂/药品/化肥</OPTION>
<OPTION VALUE="1026005">-- 无机化学</OPTION>
<OPTION VALUE="1026006">-- 有机化学</OPTION>
<OPTION VALUE="1026007">-- 精细化工</OPTION>
<OPTION VALUE="1026008">-- 分析化工</OPTION>
<OPTION VALUE="1026009">-- 高分子化工</OPTION>
<OPTION VALUE="1026010">-- 应用化学</OPTION>
<OPTION VALUE="1026011">-- 材料物理</OPTION>
<OPTION VALUE="1026012">-- 材料化学</OPTION>
<OPTION VALUE="1026013">-- 环保工程</OPTION>
<OPTION VALUE="800">科研</OPTION>
<OPTION VALUE="1027001">-- 科研管理人员</OPTION>
<OPTION VALUE="1027002">-- 科研人员</OPTION>
<OPTION VALUE="3300">技工/服务类/后勤保障</OPTION>
<OPTION VALUE="1028001">-- 电工/铆焊工/钳工</OPTION>
<OPTION VALUE="1028002">-- 空调工/电梯工/锅炉工</OPTION>
<OPTION VALUE="3313">-- 油漆/钣金</OPTION>
<OPTION VALUE="3302">-- 锯床/车床/磨床/铣床/冲床/锣床</OPTION>
<OPTION VALUE="3303">-- 铲车/叉车工</OPTION>
<OPTION VALUE="3304">-- 机修工</OPTION>
<OPTION VALUE="3305">-- 寻呼/声讯服务</OPTION>
<OPTION VALUE="1028003">-- 食堂厨师</OPTION>
<OPTION VALUE="3311">-- 司机</OPTION>
<OPTION VALUE="3312">-- 保安</OPTION>
<OPTION VALUE="1028004">-- 普工</OPTION>
<OPTION VALUE="1028005">-- 裁减车缝熨烫</OPTION>
<OPTION VALUE="1028006">-- 水工/木工/油漆工</OPTION>
<OPTION VALUE="1028007">-- 美容美发技工</OPTION>
<OPTION VALUE="1028008">-- 社区/家政服务</OPTION>
<OPTION VALUE="1028009">-- 清洁工</OPTION>
<OPTION VALUE="1028010">-- 搬运工</OPTION>
<OPTION VALUE="1029000">农林牧渔</OPTION>
<OPTION VALUE="2600">公务员</OPTION>
<OPTION VALUE="3700">培训生</OPTION>
<OPTION VALUE="2500">在校学生</OPTION>
<OPTION VALUE="1032001">-- 应届毕业生</OPTION>
<OPTION VALUE="1032002">-- 非应届毕业生</OPTION>
<OPTION VALUE="1033000">其他</OPTION>
<OPTION VALUE="1033001">-- 航空航天</OPTION>
<OPTION VALUE="1033002">-- 安全消防</OPTION>
<OPTION VALUE="1033003">-- 声光学技术/激光技术</OPTION>
<OPTION VALUE="1033004">-- 测绘技术</OPTION>
<OPTION VALUE="1033005">-- 地质矿产冶金</OPTION>
<OPTION VALUE="1033006">-- 气象</OPTION>

                  </SELECT>

                  </TD>
                  <TD WIDTH="95" ALIGN="CENTER"> <INPUT NAME="btnAdd" TYPE="image" SRC="/images/btn_add_y.gif" ALT="添加" WIDTH="52" HEIGHT="20" BORDER="0" onClick="AddOption('Occupation', form1.sltOccId_list, form1.sltOccId, 3);return false;">
                    <br/> <br/> <INPUT NAME="btnDelete" TYPE="image" SRC="/images/btn_del_y.gif" ALT="删除" WIDTH="52" HEIGHT="20" BORDER="0" onClick="DelOption(form1.sltOccId);return false;">
                  </TD>
                  <TD>
                    <SELECT NAME="sltOccId" SIZE="5" MULTIPLE STYLE="width:200px">
                   <!--版本号：0002-->
<!--Action:1--><%java.util.Enumeration enumerationOccId=job.getSltOccId();
while(enumerationOccId.hasMoreElements()){
%><option><%=enumerationOccId.nextElement()%></option><%}%>

                    </SELECT> </TD>
                </TR>
              </TABLE> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"> <SPAN CLASS="alert">* </SPAN>

              职位有效期

            &nbsp;</TD>
            <TD> <%=new TimeSelection("Validity", job.getValidityDate())%><INPUT NAME="sltExpiryDays" type="hidden" VALUE="1" SIZE="3" MAXLENGTH="3">
               </TD>
            <TD align="right">招聘人数</TD>
            <TD><INPUT NAME="txtHeadCount" TYPE="text" VALUE="<%if(job.getTxtHeadCount()>0)out.println(job.getTxtHeadCount());%>" SIZE="4" MAXLENGTH="4"></TD>
            <TD ALIGN="right">月薪范围&nbsp;</TD>
            <TD> <SELECT NAME="sltSalaryId">
              <%--  <OPTION VALUE = "255"></OPTION>--%>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="面议" <%=getSelect(job.getSltSalaryId().equals("面议"))%>>面议</OPTION>
<OPTION VALUE="1000以下"<%=getSelect(job.getSltSalaryId().equals("1000以下"))%>>1000以下</OPTION>
<OPTION VALUE="1000~2000"<%=getSelect(job.getSltSalaryId().equals("1000~2000"))%>>1000~2000</OPTION>
<OPTION VALUE="2000~3000"<%=getSelect(job.getSltSalaryId().equals("2000~3000"))%>>2000~3000</OPTION>
<OPTION VALUE="3000~4000"<%=getSelect(job.getSltSalaryId().equals("3000~4000"))%>>3000~4000</OPTION>
<OPTION VALUE="4000~6000"<%=getSelect(job.getSltSalaryId().equals("4000~6000"))%>>4000~6000</OPTION>
<OPTION VALUE="6000~8000"<%=getSelect(job.getSltSalaryId().equals("6000~8000"))%>>6000~8000</OPTION>
<OPTION VALUE="8000~10000"<%=getSelect(job.getSltSalaryId().equals("8000~10000"))%>>8000~10000</OPTION>
<OPTION VALUE="10000~15000"<%=getSelect(job.getSltSalaryId().equals("10000~15000"))%>>10000~15000</OPTION>
<OPTION VALUE="15000~20000"<%=getSelect(job.getSltSalaryId().equals("15000~20000"))%>>15000~20000</OPTION>
<OPTION VALUE="20000~30000"<%=getSelect(job.getSltSalaryId().equals("20000~30000"))%>>20000~30000</OPTION>
<OPTION VALUE="30000~50000"<%=getSelect(job.getSltSalaryId().equals("30000~50000"))%>>30000~50000</OPTION>
<OPTION VALUE="50000+"<%=getSelect(job.getSltSalaryId().equals("50000+"))%>>50000+</OPTION>

              </SELECT> </TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="TOP"><SPAN CLASS="alert">*</SPAN> 工作地区&nbsp;</TD>
            <TD COLSPAN="5"> <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <TR>
                  <TD><SELECT NAME="sltProvinceId" onChange="javascript:SelectOption('Location',true, form1.sltProvinceId,form1.sltAllLocId, '', '', '');CheckLoc(form1.sltAllLocId);" STYLE="width:140px">
                      <OPTION VALUE="-1">--请选择省区--</OPTION>
                      <!--版本号：0001-->
<!--Action:1-->
<OPTION VALUE="30000">北京</OPTION>
<OPTION VALUE="31000">上海</OPTION>
<OPTION VALUE="32000">天津</OPTION>
<OPTION VALUE="33000">重庆</OPTION>
<OPTION VALUE="16000">广东省</OPTION>
<OPTION VALUE="7000">江苏省</OPTION>
<OPTION VALUE="8000">浙江省</OPTION>
<OPTION VALUE="9000">安徽省</OPTION>
<OPTION VALUE="10000">福建省</OPTION>
<OPTION VALUE="24000">甘肃省</OPTION>
<OPTION VALUE="17000">广西自治区</OPTION>
<OPTION VALUE="20000">贵州省</OPTION>
<OPTION VALUE="18000">海南省</OPTION>
<OPTION VALUE="1000">河北省</OPTION>
<OPTION VALUE="13000">河南省</OPTION>
<OPTION VALUE="6000">黑龙江省</OPTION>
<OPTION VALUE="14000">湖北省</OPTION>
<OPTION VALUE="15000">湖南省</OPTION>
<OPTION VALUE="5000">吉林省</OPTION>
<OPTION VALUE="11000">江西省</OPTION>
<OPTION VALUE="4000">辽宁省</OPTION>
<OPTION VALUE="3000">内蒙古自治区</OPTION>
<OPTION VALUE="26000">宁夏自治区</OPTION>
<OPTION VALUE="25000">青海省</OPTION>
<OPTION VALUE="12000">山东省</OPTION>
<OPTION VALUE="2000">山西省</OPTION>
<OPTION VALUE="23000">陕西省</OPTION>
<OPTION VALUE="19000">四川省</OPTION>
<OPTION VALUE="22000">西藏自治区</OPTION>
<OPTION VALUE="27000">新疆自治区</OPTION>
<OPTION VALUE="21000">云南省</OPTION>
<OPTION VALUE="34000">香港</OPTION>
<OPTION VALUE="35000">澳门</OPTION>
<OPTION VALUE="36000">台湾</OPTION>
<OPTION VALUE="37000">其他亚洲国家和地区</OPTION>
<OPTION VALUE="38000">北美洲</OPTION>
<OPTION VALUE="41000">南美洲</OPTION>
<OPTION VALUE="39000">大洋洲</OPTION>
<OPTION VALUE="40000">欧洲</OPTION>
<OPTION VALUE="42000">非洲</OPTION>

                    </SELECT></TD>
                  <TD COLSPAN="2" ALIGN="CENTER" CLASS="note"> &nbsp;如选择了省/区，则不能再选择该省/区下属城市
                  </TD>
                </TR>
                <TR>
                  <TD> <SELECT NAME="sltAllLocId" SIZE="5" MULTIPLE STYLE="width:140px"  >
                      <!--版本号：0001-->
<!--Action:1-->
<OPTION VALUE="5">北京</OPTION>
<OPTION VALUE="115">上海</OPTION>
<OPTION VALUE="140">天津</OPTION>
<OPTION VALUE="25">重庆</OPTION>
<OPTION VALUE="16000">广东省</OPTION>
<OPTION VALUE="40">广州</OPTION>
<OPTION VALUE="16010">潮州</OPTION>
<OPTION VALUE="225">东莞</OPTION>
<OPTION VALUE="16050">佛山</OPTION>
<OPTION VALUE="16020">惠州</OPTION>
<OPTION VALUE="16030">清远</OPTION>
<OPTION VALUE="117">汕头</OPTION>
<OPTION VALUE="125">深圳</OPTION>
<OPTION VALUE="16040">顺德</OPTION>
<OPTION VALUE="16060">湛江</OPTION>
<OPTION VALUE="16080">肇庆</OPTION>
<OPTION VALUE="16070">中山</OPTION>
<OPTION VALUE="180">珠海</OPTION>
<OPTION VALUE="7000">江苏省</OPTION>
<OPTION VALUE="100">南京</OPTION>
<OPTION VALUE="7010">常熟</OPTION>
<OPTION VALUE="18">常州</OPTION>
<OPTION VALUE="7020">昆山</OPTION>
<OPTION VALUE="7070">连云港</OPTION>
<OPTION VALUE="7060">南通</OPTION>
<OPTION VALUE="220">苏州</OPTION>
<OPTION VALUE="7040">太仓</OPTION>
<OPTION VALUE="152">无锡</OPTION>
<OPTION VALUE="7030">徐州</OPTION>
<OPTION VALUE="167">扬州</OPTION>
<OPTION VALUE="7080">镇江</OPTION>
<OPTION VALUE="8000">浙江省</OPTION>
<OPTION VALUE="55">杭州</OPTION>
<OPTION VALUE="107">宁波</OPTION>
<OPTION VALUE="147">温州</OPTION>
<OPTION VALUE="8050">绍兴</OPTION>
<OPTION VALUE="8060">金华</OPTION>
<OPTION VALUE="8080">台州</OPTION>
<OPTION VALUE="8090">湖州</OPTION>
<OPTION VALUE="73">嘉兴</OPTION>
<OPTION VALUE="8110">瞿州</OPTION>
<OPTION VALUE="8100">丽水</OPTION>
<OPTION VALUE="8070">舟山</OPTION>
<OPTION VALUE="9000">安徽省</OPTION>
<OPTION VALUE="65">合肥</OPTION>
<OPTION VALUE="9040">安庆</OPTION>
<OPTION VALUE="9030">蚌埠</OPTION>
<OPTION VALUE="9020">芜湖</OPTION>
<OPTION VALUE="10000">福建省</OPTION>
<OPTION VALUE="35">福州</OPTION>
<OPTION VALUE="10030">泉州</OPTION>
<OPTION VALUE="155">厦门</OPTION>
<OPTION VALUE="10040">漳州</OPTION>
<OPTION VALUE="24000">甘肃省</OPTION>
<OPTION VALUE="85">兰州</OPTION>
<OPTION VALUE="24020">嘉峪关</OPTION>
<OPTION VALUE="24030">酒泉</OPTION>
<OPTION VALUE="17000">广西自治区</OPTION>
<OPTION VALUE="105">南宁</OPTION>
<OPTION VALUE="17040">北海</OPTION>
<OPTION VALUE="42">桂林</OPTION>
<OPTION VALUE="17020">柳州</OPTION>
<OPTION VALUE="17050">玉林</OPTION>
<OPTION VALUE="20000">贵州省</OPTION>
<OPTION VALUE="45">贵阳</OPTION>
<OPTION VALUE="20020">遵义</OPTION>
<OPTION VALUE="18000">海南省</OPTION>
<OPTION VALUE="50">海口</OPTION>
<OPTION VALUE="18020">三亚</OPTION>
<OPTION VALUE="1000">河北省</OPTION>
<OPTION VALUE="130">石家庄</OPTION>
<OPTION VALUE="7">保定</OPTION>
<OPTION VALUE="1070">承德</OPTION>
<OPTION VALUE="53">邯郸</OPTION>
<OPTION VALUE="1080">廊坊</OPTION>
<OPTION VALUE="1030">秦皇岛</OPTION>
<OPTION VALUE="1020">唐山</OPTION>
<OPTION VALUE="1060">张家口</OPTION>
<OPTION VALUE="13000">河南省</OPTION>
<OPTION VALUE="175">郑州</OPTION>
<OPTION VALUE="78">开封</OPTION>
<OPTION VALUE="92">洛阳</OPTION>
<OPTION VALUE="6000">黑龙江省</OPTION>
<OPTION VALUE="60">哈尔滨</OPTION>
<OPTION VALUE="6030">大庆</OPTION>
<OPTION VALUE="6040">佳木斯</OPTION>
<OPTION VALUE="6050">牡丹江</OPTION>
<OPTION VALUE="6020">齐齐哈尔</OPTION>
<OPTION VALUE="14000">湖北省</OPTION>
<OPTION VALUE="150">武汉</OPTION>
<OPTION VALUE="14020">十堰</OPTION>
<OPTION VALUE="14040">襄樊</OPTION>
<OPTION VALUE="14030">宜昌</OPTION>
<OPTION VALUE="14050">潜江</OPTION>
<OPTION VALUE="14060">荆门</OPTION>
<OPTION VALUE="14070">荆州</OPTION>
<OPTION VALUE="14080">黄石</OPTION>
<OPTION VALUE="15000">湖南省</OPTION>
<OPTION VALUE="15">长沙</OPTION>
<OPTION VALUE="15030">湘潭</OPTION>
<OPTION VALUE="15020">株州</OPTION>
<OPTION VALUE="5000">吉林省</OPTION>
<OPTION VALUE="10">长春</OPTION>
<OPTION VALUE="5020">吉林市</OPTION>
<OPTION VALUE="11000">江西省</OPTION>
<OPTION VALUE="95">南昌</OPTION>
<OPTION VALUE="11020">九江</OPTION>
<OPTION VALUE="4000">辽宁省</OPTION>
<OPTION VALUE="120">沈阳</OPTION>
<OPTION VALUE="4030">鞍山</OPTION>
<OPTION VALUE="30">大连</OPTION>
<OPTION VALUE="4040">葫芦岛</OPTION>
<OPTION VALUE="3000">内蒙古自治区</OPTION>
<OPTION VALUE="70">呼和浩特</OPTION>
<OPTION VALUE="3020">包头</OPTION>
<OPTION VALUE="3030">赤峰</OPTION>
<OPTION VALUE="26000">宁夏自治区</OPTION>
<OPTION VALUE="170">银川</OPTION>
<OPTION VALUE="25000">青海省</OPTION>
<OPTION VALUE="165">西宁</OPTION>
<OPTION VALUE="12000">山东省</OPTION>
<OPTION VALUE="75">济南</OPTION>
<OPTION VALUE="12090">德州</OPTION>
<OPTION VALUE="12040">东营</OPTION>
<OPTION VALUE="12060">济宁</OPTION>
<OPTION VALUE="12100">临沂</OPTION>
<OPTION VALUE="110">青岛</OPTION>
<OPTION VALUE="12080">日照</OPTION>
<OPTION VALUE="12070">泰安</OPTION>
<OPTION VALUE="146">威海</OPTION>
<OPTION VALUE="12050">潍坊</OPTION>
<OPTION VALUE="168">烟台</OPTION>
<OPTION VALUE="12030">淄博</OPTION>
<OPTION VALUE="2000">山西省</OPTION>
<OPTION VALUE="135">太原</OPTION>
<OPTION VALUE="2010">大同</OPTION>
<OPTION VALUE="2020">临汾</OPTION>
<OPTION VALUE="2030">运城</OPTION>
<OPTION VALUE="23000">陕西省</OPTION>
<OPTION VALUE="160">西安</OPTION>
<OPTION VALUE="23010">宝鸡</OPTION>
<OPTION VALUE="23020">咸阳</OPTION>
<OPTION VALUE="19000">四川省</OPTION>
<OPTION VALUE="20">成都</OPTION>
<OPTION VALUE="19060">乐山</OPTION>
<OPTION VALUE="19030">泸州</OPTION>
<OPTION VALUE="19040">绵阳</OPTION>
<OPTION VALUE="19050">内江</OPTION>
<OPTION VALUE="19070">宜宾</OPTION>
<OPTION VALUE="19020">自贡</OPTION>
<OPTION VALUE="22000">西藏自治区</OPTION>
<OPTION VALUE="90">拉萨</OPTION>
<OPTION VALUE="22020">日喀则</OPTION>
<OPTION VALUE="27000">新疆自治区</OPTION>
<OPTION VALUE="145">乌鲁木齐</OPTION>
<OPTION VALUE="27030">喀什</OPTION>
<OPTION VALUE="27020">克拉玛依</OPTION>
<OPTION VALUE="27040">伊犁</OPTION>
<OPTION VALUE="21000">云南省</OPTION>
<OPTION VALUE="80">昆明</OPTION>
<OPTION VALUE="21030">大理</OPTION>
<OPTION VALUE="21040">丽江</OPTION>
<OPTION VALUE="21020">玉溪</OPTION>
<OPTION VALUE="185">香港</OPTION>
<OPTION VALUE="190">澳门</OPTION>
<OPTION VALUE="195">台湾</OPTION>
<OPTION VALUE="200">其他亚洲国家和地区</OPTION>
<OPTION VALUE="205">北美洲</OPTION>
<OPTION VALUE="230">南美洲</OPTION>
<OPTION VALUE="210">大洋洲</OPTION>
<OPTION VALUE="215">欧洲</OPTION>
<OPTION VALUE="235">非洲</OPTION>

                    </SELECT><SCRIPT language="javascript">CheckLoc(form1.sltAllLocId);</script> </TD>
                  <TD WIDTH="80" ALIGN="CENTER"> <INPUT NAME="btnAdd" TYPE="image" SRC="/images/btn_add_y.gif" ALT="添加" WIDTH="52" HEIGHT="20" BORDER="0" onClick="AddOption('Location', form1.sltAllLocId, form1.sltLocId, 0);return false;">
                    <br/> <br/> <INPUT NAME="btnDelete" TYPE="image" SRC="/images/btn_del_y.gif" ALT="删除" WIDTH="52" HEIGHT="20" BORDER="0" onClick="DelOption(form1.sltLocId);return false;">
                  </TD>
                  <TD> <SELECT NAME="sltLocId" SIZE="5" MULTIPLE STYLE="width:140px">
<!--Action:1--><%java.util.Enumeration enumerationLocId=job.getSltLocId();
while(enumerationLocId.hasMoreElements()){
%><option><%=enumerationLocId.nextElement()%></option><%}%>

                    </SELECT></script> </TD>

                </TR>
              </TABLE></TD>
          </TR>

          <TR>
            <TD ALIGN="right">最低工作经验&nbsp;</TD>
            <TD colspan="3"> <SELECT NAME="sltReqWyearId">
                <OPTION VALUE = ""></OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="0" <%=getSelect(job.getSltReqWyearId()==0)%>>一年以下</OPTION>
<OPTION VALUE="1"<%=getSelect(job.getSltReqWyearId()==1)%>>1年</OPTION>
<OPTION VALUE="2"<%=getSelect(job.getSltReqWyearId()==2)%>>2年</OPTION>
<OPTION VALUE="3"<%=getSelect(job.getSltReqWyearId()==3)%>>3年</OPTION>
<OPTION VALUE="4"<%=getSelect(job.getSltReqWyearId()==4)%>>4年</OPTION>
<OPTION VALUE="5"<%=getSelect(job.getSltReqWyearId()==5)%>>5年</OPTION>
<OPTION VALUE="6"<%=getSelect(job.getSltReqWyearId()==6)%>>6年</OPTION>
<OPTION VALUE="7"<%=getSelect(job.getSltReqWyearId()==7)%>>7年</OPTION>
<OPTION VALUE="8"<%=getSelect(job.getSltReqWyearId()==8)%>>8年</OPTION>
<OPTION VALUE="9"<%=getSelect(job.getSltReqWyearId()==9)%>>9年</OPTION>
<OPTION VALUE="10"<%=getSelect(job.getSltReqWyearId()==10)%>>10年</OPTION>

              </SELECT> 以上</TD>
            <TD>&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD ALIGN="right">学历&nbsp;</TD>
            <TD colspan="3"> <SELECT NAME="sltReqDegId">
                <OPTION VALUE = ""></OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="博士" <%=getSelect(job.getSltReqDegId().equals("博士"))%>>博士</OPTION>
<OPTION VALUE="MBA" <%=getSelect(job.getSltReqDegId().equals("MBA"))%>>MBA</OPTION>
<OPTION VALUE="硕士" <%=getSelect(job.getSltReqDegId().equals("硕士"))%>>硕士</OPTION>
<OPTION VALUE="本科" <%=getSelect(job.getSltReqDegId().equals("本科"))%>>本科</OPTION>
<OPTION VALUE="大专" <%=getSelect(job.getSltReqDegId().equals("大专"))%>>大专</OPTION>
<OPTION VALUE="中专" <%=getSelect(job.getSltReqDegId().equals("中专"))%>>中专</OPTION>
<OPTION VALUE="中技" <%=getSelect(job.getSltReqDegId().equals("中技"))%>>中技</OPTION>
<OPTION VALUE="高中" <%=getSelect(job.getSltReqDegId().equals("高中"))%>>高中</OPTION>
<OPTION VALUE="初中" <%=getSelect(job.getSltReqDegId().equals("初中"))%>>初中</OPTION>

              </SELECT>
              以上 </TD>
            <TD>&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>

          <TR>
            <TD ALIGN="right" VALIGN="top" NOWRAP><SPAN CLASS="alert">*</SPAN>
              职位描述及要求&nbsp;</TD>
            <TD COLSPAN="5"> <TEXTAREA NAME="txtJobDuty" COLS="70" ROWS="5"><%=HtmlElement.htmlToText(node.getText(teasession._nLanguage))%></TEXTAREA>
              <br/> <FONT CLASS="note">最多可以输入3000个字。</FONT><A HREF="javascript:getLength(form1.txtJobDuty.value);">查看字数</A>
            </TD>
          </TR>
<%-- %><input NAME="txtJobDuty" type="hidden" value="aa">
          <TR ID="trJobCcType">
            <TD ALIGN="right" VALIGN="top">&nbsp;</TD>
            <TD COLSPAN="5"> <INPUT STYLE="display:none"  id="radio" type="radio" NAME="rdoJobCcType" VALUE="0" onClick="DisableCcMailTxt();">
              <!--不抄送-->
              <INPUT  id="radio" type="radio" NAME="rdoJobCcType" VALUE="1" onClick="DisableCcMailTxt();" CHECKED>
              公司E-mail
              <INPUT  id="radio" type="radio" NAME="rdoJobCcType" VALUE="2" onClick="DisableCcMailTxt();">
              职位所属分支机构的E-mail<br/> <INPUT  id="radio" type="radio" NAME="rdoJobCcType" VALUE="4" onClick="EnableCcMailTxt();">
              其他E-mail
              <INPUT TYPE="text" NAME="txtCcMailAddr" MAXLENGTH="363" DISABLED>
              <FONT CLASS="note">最多可以输入3个E-mail，用英文逗号分隔</FONT></TD>
          </TR>--%>

          <SCRIPT language="javascript">
            document.form1.chkGetCvTypeEmail.checked = true;
            document.all.trJobCcType.style.display = "";
          </SCRIPT>

          <TR>
            <TD COLSPAN="6" ALIGN="CENTER">

<input  type="hidden" value="<%=teasession._nNode%>" name="Node"/>
           <%-- %>   &nbsp; <INPUT NAME="btnPost" TYPE="image" SRC="/images/btn_launch.gif" WIDTH="60" HEIGHT="21" BORDER="0" onClick="return doAction('post');">

              &nbsp; <INPUT NAME="btnSave" TYPE="image" SRC="/images/btn_save.gif" WIDTH="60" HEIGHT="21" BORDER="0" onClick="return doAction('save');">
             --%><input type="submit" value="发布"/>
             <input type="submit" value="保存" name="save"/>
              <input type="button" value="取消" name="cancel" onclick="window.open('/servlet/Job?node=<%=teasession._nNode%>','_self')"/>
            </TD>
          </TR>
        </FORM>
      </TABLE>
      <TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="0">
        <TR>
          <TD WIDTH="380"> <TABLE WIDTH="120" BORDER="0" CELLSPACING="0" CELLPADDING="0">
              <TR BGCOLOR="#FF6600">
                <TD BGCOLOR="#FF6600" VALIGN="top" WIDTH="5"><IMG SRC="/images/pic_corner7.gif" WIDTH="3" HEIGHT="3"></TD>
                <TD HEIGHT="16" VALIGN="bottom"><IMG SRC="/images/arrow_white.gif" WIDTH="3" HEIGHT="5" ALIGN="absmiddle">
                  <FONT COLOR="#FFFFFF">新增职位说明</FONT></TD>
                <TD ALIGN="right" VALIGN="top" WIDTH="5"><IMG SRC="/images/pic_corner9.gif" WIDTH="3" HEIGHT="3"></TD>
              </TR>
            </TABLE></TD>
        </TR>
        <TR BGCOLOR="#EEEEEE">
          <TD ALIGN="center" VALIGN="top" STYLE="padding-top:5px;padding-bottom:5px"> <TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
              <TR>
                <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                <TD>发布：30分钟后，求职者即可查询到该职位并投递应聘简历。你可以在<A href="/jobs/job_manage.asp">招聘中职位</A>页面看到你发布的职位。</TD>
              </TR>
              <TR>
                <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                <TD>保存：保存后的职位处于“未发布”状态，求职者不能查询到。保存职位不限数量，你可以进入“未发布职位”页面选择职位将其发布。</TD>
              </TR>
            </TABLE></TD>
        </TR>
      </TABLE></TD>
  </TR>
  <TR>
    <TD VALIGN="bottom" HEIGHT="40"> <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
  <TR>
    <TD align="center" height="20" class="note">&nbsp;</TD>
  </TR>
  <TR>
    <TD align="center" class="bottomstyle" height="20">&nbsp;</TD>
  </TR>
</TABLE>
 </TD>
  </TR>
</TABLE>
</BODY>
</html>

