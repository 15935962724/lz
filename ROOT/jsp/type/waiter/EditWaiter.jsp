<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@include file="/jsp/Header.jsp"%>
<%



r.add("/tea/ui/node/type/Report/EditReport").add("/tea/ui/util/SignUp1");
String member=request.getParameter("member");
if(member==null)member="";


Profile profile=Profile.find(member);
Waiter waiter=Waiter.find(0,teasession._nLanguage);
String nationality =profile.getState(teasession._nLanguage);
if(nationality ==null||nationality .length()<=0)
nationality ="北京";

long len=0;
String _strPhotopath=profile.getPhotopath(teasession._nLanguage);
if(_strPhotopath!=null)
{
  java.io.File f=new java.io.File(application.getRealPath(_strPhotopath));
  len=f.length();
}
Date birth=profile.getBirth();












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

String nexturl=request.getParameter("nexturl");

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_check(obj)
{
  var rs=document.getElementById(obj.name+"_rs");
  if(obj.value=="")
  {
    rs.innerHTML="<img src='/tea/image/public/check_error.gif'/>不能为空";
  }else
  {
    rs.innerHTML="<img src='/tea/image/public/load.gif'/>";
    var act;
    switch(obj.name)
    {
      case "member":
      act="checkmember";
      break;
      case "code":
      act="waiter";
      break;
    }
    sendx("/servlet/Ajax?act="+act+"&"+obj.name+"="+obj.value,function(r)
    {
      if(r=="true")
      {
        rs.innerHTML="<img src='/tea/image/public/check_error.gif'/>已经存在";
      }else
      {
        rs.innerHTML="<img src='/tea/image/public/check_right.gif'/>";
      }
    });
  }
}
function f_submit(form1)
{
  return submitMemberid(form1.member,'无效-会员ID')
  &&submitIdentifier(form1.code,'无效-代码')
  &&submitText(form1.FirstName,'无效-姓名')
  &&submitEmail(form1.Email,'无效-Email')
  &&submitText(form1.Address,'无效-城市')
  &&submitText(form1.school,'无效-毕业学校')
  ;
}
function f_load()
{
  try
  {
    form1.member.focus();
  }catch(e)
  {
    form1.code.focus();
  }
}
</script>
</head>
<body onload="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Resume")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=POST action="/servlet/EditWaiter" onsubmit="return f_submit(this);">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="community" VALUE="<%=community%>">
<%
if(nexturl!=null)
out.print("<input type='hidden' name=nexturl VALUE='"+nexturl+"'>");

    String Preview="";
    String educateParam="";
    if(request.getParameter("NewNode")!=null)
    {
      out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
    }else
    {
      Preview="<A href=/jsp/type/waiter/WaiterPreview.jsp?node="+teasession._nNode+" target=_blank >预览简历</A>";
      educateParam="Node="+teasession._nNode;
      waiter=tea.entity.node.Waiter.find(teasession._nNode,teasession._nLanguage);

      Conductor con_obj= Conductor.find(teasession._rv._strR,node.getCommunity());
      int zone=(waiter.getAdminUnit()) ;
      if(con_obj.getZone()!=null&&con_obj.getZone().indexOf("/"+zone+"/")==-1&& ! tea.entity.site.License.getInstance().getInstance().getWebMaster().equals(teasession._rv._strR))
      {
        response.sendError(403);
      }
    }
    %>
  选择已经存在的会员:
  <select name="all_list" onChange="window.location='?member='+encodeURIComponent(this.value)+'&<%=request.getQueryString()%>'" >
    <option value="">---------请选择--------</option>
    <%
java.util.Enumeration all_member=Profile.findByCommunity(community);
while(all_member.hasMoreElements())
{
String member_temp=(String)all_member.nextElement();
out.print("<option value="+member_temp+">"+member_temp);
}%>
  </select>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >基本信息</td>
      <td  align=right><%=Preview%></td>
    </tr>
    <tr>
      <td>* 会员ID </td>
      <td><%
      if(member!=null&&member.length()>0)
      {
        out.print("<input disabled value="+member+"><input type=hidden name=member value="+member+">");
      }else
      {
        out.print("<input name=member onblur=f_check(this)><input type=hidden name=newmember ><span id=member_rs></span>");
      }
      %>
      </td>
    </tr>
    <tr>
      <td>* 代号:</td>
      <td>
        <input type="text" name="code" value="<%=waiter.getCode()%>" onblur="f_check(this)"><span id="code_rs"></span>
      </td>
    </tr>
    <tr>
      <td>* 姓名 </td>
      <td><input type="TEXT"   name=FirstName VALUE="<%=getNull(profile.getFirstName(teasession._nLanguage))%><%//=getNull(profile.getLastName(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20>
        <!-- <%=r.getString(teasession._nLanguage, "LastName")%>: <input type="TEXT"   name=LastName value="<%=profile.getLastName(teasession._nLanguage)%>" size=20 maxlength=20>--></td>
    </tr>
    <tr>
      <td>密码</td>
      <td><input type=password name=password  value="<%=getNull(profile.getPassword())%>" ></td>
</tr>
    <tr>
      <td><span class="alert">*</span>性别</td>
      <td>
        <input id="radio" type="radio" name="gender" value="1" checked />
        <label for="gender_0">男</label>
        <input id="radio" type="radio" name="gender" value="0" <%=getCheck(!profile.isSex())%>/>
        <label for="gender_1">女</label></td>
    </tr>
    <tr>
      <td>* <%=r.getString(teasession._nLanguage, "EmailAddress")%></td>
      <td><input type="TEXT"   name=Email VALUE="<%=getNull(profile.getEmail())%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><%--=r.getString(teasession._nLanguage, "Handset")--%>
        手机</td>
      <td><input type="TEXT"   name=Mobile  VALUE="<%=getNull(profile.getMobile())%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><%--=r.getString(teasession._nLanguage, "Handset")--%>
        电话</td>
      <td><input type="TEXT"   name=telephone  VALUE="<%=getNull(profile.getTelephone(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><span class="alert">*</span>年龄</td>
      <td><%=new tea.htmlx.TimeSelection("birth", birth)%></td>
    </tr>
    <tr>
      <td>照片</td>
      <td><input type=file name="photo">
      <%
      if(len>0)
      {
      	out.print("<a href='"+_strPhotopath+"' target='_blank'>"+len+r.getString(teasession._nLanguage,"Bytes")+"</a>");
      	out.print("<input type='checkbox' name='clear' onClick='form1.photo.disabled=this.checked;' >"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
      <br>
        尺寸：90X120 pixels
    </tr>
    <tr>
      <td>籍贯</td>
      <td><input  name="NationalityCN" type="text" maxlength="20" size="20" value="<%=nationality%>" />
        政治面貌
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
      <td><span class="alert">*</span>现居住地区/城市</td>
      <td><TEXTAREA name="Address"  ROWS="2" COLS="60"><%=getNull(profile.getAddress(teasession._nLanguage))%></TEXTAREA>
      </td>
    </tr>
    <tr>
      <td><span class="alert">*</span>教育程度</td>
      <td><font size="2"><%=new tea.htmlx.DegreeSelection("Degree",profile.getDegree(teasession._nLanguage))%> </font> * 毕业学校
        <input  value="<%=getNull(profile.getSchool(teasession._nLanguage))%>" name="school" type="text" size="50" maxlength="50" />
      </td>
    </tr>
    <!--
      <tr>
        <td> 教育背景</td>
        <td> <input class="edit_button" name="Educate" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEducate.jsp?<%=educateParam%>')"></td>
      </tr>
      <tr>
        <td> 工作经验</td>
        <td> <input class="edit_button" name="" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEmployment.jsp?<%=educateParam%>')"></td>
      </tr>-->
    <%---
      <tr>
        <td> \u00BD\u00CC\u00D3\u00FD±\u00B3\u00BE°</td>
        <td> <input class="edit_button" name="Educate" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="submit" ></td>
      </tr><!--onclick="window.open('EditEducate.jsp')"-->
      <tr>
        <td> \u00B9¤×÷\u00BE\u00AD\u00D1é</td>
        <td> <input class="edit_button" name="Employment" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="submit"></td>
      </tr><!--- onclick="window.open('EditEmployment.jsp')"------>

      -----%>
    <tr>
      <td><span class="alert">*</span>业务处: </TD>
      <td><select name="adminunit">
          <option value=0>---请选择-----</option>
          <%
              java.util.Enumeration au_enumer=AdminZone.findByFather(AdminZone.getRootId(node.getCommunity()));
              while(au_enumer.hasMoreElements())
              {
                int au_int=((Integer)au_enumer.nextElement()).intValue();
                AdminZone au_obj=  AdminZone.find(au_int);
                out.print("<option value="+au_int);
                if( waiter.getAdminUnit()==au_int)
                out.print(" SELECTED ");
                out.print(">"+au_obj.getName());

                java.util.Enumeration au2_enumer=AdminZone.findByFather(au_int);
                while(au2_enumer.hasMoreElements())
                {
                  int au2_int=((Integer)au2_enumer.nextElement()).intValue();
                  AdminZone au2_obj=  AdminZone.find(au2_int);
                  out.print("<option value="+au2_int);
                  if( waiter.getAdminUnit()==au2_int)
                  out.print(" SELECTED ");
                  out.print(">├"+au2_obj.getName());
                }
              }%>
        </select>
        身份:
        <INPUT NAME="figure" type="radio" VALUE="0" CHECKED><label  for="figure0">普通作业员</label>
        <INPUT type="radio" NAME="figure" VALUE="1" <%=getCheck(waiter.isFigure())%>><label  for="figure1">业务员</label></td>
    </tr>
  </table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

