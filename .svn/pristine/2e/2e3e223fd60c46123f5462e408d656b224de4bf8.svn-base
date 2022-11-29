<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@ page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getSelect(boolean i)
{
	return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}
String getDisplay(boolean bool)
{
    return bool?" style=\"display:\" ":" style=\"display:none\" ";
}
TeaServlet ts=new TeaServlet();
Resource r = new Resource();
Node node;
TeaSession teasession;
%>
<%
//response.setHeader("Expires", "0");
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");
teasession = new TeaSession(request);
//if(teasession._rv == null)
//{
//response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
//return;
//}

node=Node.find(teasession._nNode);
%>

<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.resource.Resource r = new tea.resource.Resource();
String member=request.getParameter("member");
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
String address,webpage,fax,email,telephone,zip, name,linkman,synopsis,property,license=null;
boolean sex=false;
int size=0,calling=0;
if(member!=null)
{
  ProfileEnterprise pe = ProfileEnterprise.find(member,community);
  name=pe.getName();
  linkman=pe.getLinkman();
  synopsis=pe.getSynopsis();
  license=pe.getLicense();
  sex=pe.isLinkmansex();
  property=pe.getProperty();
  size=pe.getSize();
  if(pe.getCalling()!=null&&pe.getCalling().length()>0)
  calling=Integer.parseInt(pe.getCalling());
  Profile profile=Profile.find(member);
  address=profile.getAddress(teasession._nLanguage);
  webpage=profile.getWebPage(teasession._nLanguage);
  fax=profile.getFax(teasession._nLanguage);
  email=profile.getEmail();
  telephone=profile.getTelephone(teasession._nLanguage);
  zip=profile.getZip(teasession._nLanguage);
}else
{
  address=webpage=fax=email=telephone=zip=name=linkman=synopsis=property="";
}

%><html>
<head>
<TITLE>填写注册信息</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" href="/tea/CssJs/default.css" TYPE="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="javascript" SRC="/jsp/type/job/validate.js"></SCRIPT>
<SCRIPT language="javascript" SRC="/tea/CssJs/CheckUserName.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>
<SCRIPT language = "javascript">
<!--
function SelectProvice()
{
  SelectLoc();

  var locbox = form1.sltAllLocId;
  if(locbox.length==0) fullup_P(locbox, '--请选择--', -1);
}

function cancel()
{
  form1.reset();

  return false;
}

function chkForm()
{
	var frm = document.form1;

	if(!submitText(frm.txtMem_Name, "公司名称")) return false;

//	if(!submitText(frm.txtAbbrName, "公司简称")) return false;

	if(ChkSel(frm.lstComType, -1, "公司性质")==false) return false;
	if(ChkSel(frm.lstSize, -1, "公司规模")==false) return false;

/*	if(frm.sltAllLocId.value == -1)
	{
	  alert('请选择公司所在地区！');
	  frm.sltProvinceId.focus();
	  return false;
	}*/

	var intCount=0;
	var frm=document.form1;
	for(var x=0;x<frm.lstIndustry.options.length;x++)
	{
	  if(frm.lstIndustry.options(x).selected)
	    intCount++;
	}
	if(intCount==0)
	{
	  alert("请选择公司所属行业！");
	  frm.lstIndustry.focus();
	  return false;
	}
	else if(intCount>3)
	{
	  alert("所属行业最多可以选三个！");
	  frm.lstIndustry.focus();
	  return false;
	}

	if(!submitText(frm.txtLinkManName, "联系人姓名")) return false;

	if(!submitText(frm.txtLinkManTitle, "联系人职位")) return false;

	if(!submitText(frm.txtEmail, "E-mail")) return false;
	if(IsMail(frm.txtEmail.value)==false)
	{
		alert("请输入正确的E-mail格式！");
		frm.txtEmail.focus();
		return false;
	}

	if(!submitText(frm.txtPhone, "电话")) return false;

  s = frm.txtComIntr.value;
  if(s.length < 100)
  {
    for(var i=0;i<frm.txtComIntr.value.length;i++)
      s = s.replace(/\s/i,'');
  }
  if(Trim(s).length == 0)
  {
    alert('公司简介必须填写！');
    frm.txtComIntr.focus();
    return false;
  }
	else if(!submitText(frm.txtComIntr, "公司简介")) return false;
	else if(!ChkLength(frm.txtComIntr, "公司简介",3000)) return false;

	if(!submitText(frm.txtUserName, "用户名")) return false;
//	if(!CheckUserName(form1.txtUserName)) return false;

	if(!submitText(frm.txtPassword, "密码")) return false;
	if(!Chkpwd(frm.txtPassword, "密码", 12, 6)) return false;

	if(!submitText(frm.txtConPassword, "确认密码")) return false;
	if(!Chkpwd(frm.txtConPassword,"确认密码",12, 6)) return false;

	if(frm.txtPassword.value != frm.txtConPassword.value)
	{
		alert("密码与确认密码不一致！");
		frm.txtPassword.focus();
		return false;
	}
	return true;
}

//城市缩进"--"
function CheckLoc(objloc)
{
  for(var x=0;x<objloc.length;x++)
  {
    var opt = objloc.options[x];
    if (opt.value.substring(opt.value.length-3,opt.value.length)!='000'&& opt.value!='5'&& opt.value!='115'&& opt.value!='140'&& opt.value!='25'&& opt.value!='185'&& opt.value!='190'&& opt.value!='195'&& opt.value!='200'&& opt.value!='205'&& opt.value!='210'&& opt.value!='215'&& opt.value!='230'&& opt.value!='235'&& opt.value!='255') //是省id
    {
      opt.text='-- '+opt.text;
    }
  }
}
//-->
</SCRIPT>
<html>
<head>
<title>填写注册信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<TABLE  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<FORM NAME = "form1" METHOD = "post"  enctype=multipart/form-data onSubmit = "return chkForm()&&submitMemberid(this.txtUserName,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')" action="/servlet/ProfileEnterpriseServlet">
<input type="hidden" name="community" value="<%=community%>"/>
    <INPUT TYPE="hidden" VALUE="resiger" NAME="hdnResiger">
          <TR>
            <TD colspan="4" ALIGN="right"><div align="left">填写注册信息  </div></TD>
          </TR>
		 <TR >
            <TD colspan="4" ALIGN="right">
		  * 必须填写</TD>
          </TR>
          <TR>
            <TD WIDTH="100" ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司名称&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text"  class="edit_input"  NAME="txtMem_Name" MAXLENGTH="60" VALUE="<%=name%>" SIZE="44">
            </TD>
          </TR>
         <TR>  <!--
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司简称&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtAbbrName" MAXLENGTH="20" VALUE="" SIZE="20">
              <SPAN CLASS="note">用于登录智聘系统</SPAN> </TD>-->
            <TD WIDTH="100" ALIGN="right" NOWRAP> 营业执照&nbsp;</TD>
            <TD><%=(license==null||license.length()<=0?"无":"<A HREF="+license+" >有</A>")%>
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司性质&nbsp;</TD>
            <TD> <%=getNull(property)%>
            </TD>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司规模&nbsp;</TD>
            <TD> <%if(size==1)out.print(" 1 - 49人 ");else
            if(size==50)out.print(" 50 - 99人 ");else
            if(size==100)out.print(" 100 - 499人 ");else
            if(size==500)out.print(" 500 - 999人 ");else
            if(size==1000)out.print(" 1000人以上 ");%>
          </TD>
          </TR>
          <%--          <TR>
  <TD ALIGN="right" NOWRAP><SPAN CLASS="alert">*</SPAN> 公司所在地区&nbsp;</TD>
            <TD COLSPAN="3"> <SELECT NAME="sltProvinceId"  STYLE="width:135px" ONCHANGE="javascript:SelectOption('Location',true, form1.sltProvinceId,form1.sltAllLocId,'', '255', '--选择城市--');CheckLoc(form1.sltAllLocId);">
                <OPTION VALUE="-1">--请选择--</OPTION>
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

              </SELECT>

              <SELECT NAME="sltAllLocId"  STYLE="width:135px">

                <OPTION VALUE = "-1">--请选择--</OPTION>

              </SELECT> </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right">地址&nbsp;</TD>
            <TD><input  class="edit_input"  type="text" name="txtAddress" maxlength="100" value="<%=address%>" size="44"></TD>
            <TD ALIGN="RIGHT">邮政编码&nbsp;</TD>
            <TD> <INPUT  class="edit_input" TYPE="text" NAME="txtZipCode" MAXLENGTH="10" VALUE="<%=zip%>">
            </TD>
          </TR>
          <TR>
            <TD ALIGN="right">公司网址&nbsp;</TD>
            <TD> <INPUT  class="edit_input"  NAME="txtMem_Url" TYPE="text" MAXLENGTH="100"  VALUE="<%=webpage%>" SIZE="44"> </TD>
            <TD ALIGN="right">&nbsp;</TD>
            <TD>&nbsp; </TD>
          </TR>
          <TR>
            <TD ALIGN="right">传真&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  name="txtFax" type="text"  value="<%=fax%>" size="20" maxlength="40">              <SPAN CLASS="note">格式：区号-传真号码</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> 所属行业&nbsp;</TD>
            <TD COLSPAN="3"> <%=tea.htmlx.TradeSelection.getTrade(calling)%>
			<%--<SELECT NAME="lstIndustry" SIZE="5"  MULTIPLE  STYLE="width:275px">
                <!--版本号：0003-->
<!--Action:2-->
<OPTION VALUE="100">计算机</OPTION>
<OPTION VALUE="3600">互联网·电子商务</OPTION>
<OPTION VALUE="300">电子·微电子技术</OPTION>
<OPTION VALUE="400">通讯·电信业</OPTION>
<OPTION VALUE="1300">快速消费品(食品·饮料·日化·烟酒等)</OPTION>
<OPTION VALUE="3800">纺织品业(服饰鞋帽·家纺用品·皮具等)</OPTION>
<OPTION VALUE="1400">家电业</OPTION>
<OPTION VALUE="1101000">家具·工艺品</OPTION>
<OPTION VALUE="1102000">木材加工及木、竹、藤、棕、草制品业</OPTION>
<OPTION VALUE="1103000">橡胶·塑料·非金属矿物制品业</OPTION>
<OPTION VALUE="1104000">金属制品业</OPTION>
<OPTION VALUE="1500">家居·室内设计·装潢</OPTION>
<OPTION VALUE="600">批发·零售(商场·专卖店·百货·超市)</OPTION>
<OPTION VALUE="700">贸易·进出口</OPTION>
<OPTION VALUE="1700">运输·物流·快递</OPTION>
<OPTION VALUE="1600">旅游·酒店·餐饮服务</OPTION>
<OPTION VALUE="3700">物业管理·商业中心</OPTION>
<OPTION VALUE="1100">建筑·房地产</OPTION>
<OPTION VALUE="800">市场·广告·公关</OPTION>
<OPTION VALUE="900">专业服务·咨询·财会·法律</OPTION>
<OPTION VALUE="2800">中介服务(人才·房地产·商标专利·技术等)</OPTION>
<OPTION VALUE="1000">金融业(投资·保险·证券·银行·基金)</OPTION>
<OPTION VALUE="1200">娱乐·运动·休闲</OPTION>
<OPTION VALUE="2500">媒体·影视制作·新闻出版</OPTION>
<OPTION VALUE="4000">艺术·文化传播</OPTION>
<OPTION VALUE="2000">医疗设备</OPTION>
<OPTION VALUE="2300">制药·生物工程</OPTION>
<OPTION VALUE="3200">医疗·保健·卫生服务</OPTION>
<OPTION VALUE="1800">办公设备·用品</OPTION>
<OPTION VALUE="2100">汽车·摩托车(制造与维护·配件·用品)</OPTION>
<OPTION VALUE="2200">石油·化工·采掘·冶炼·原材料</OPTION>
<OPTION VALUE="500">电力·电气·能源</OPTION>
<OPTION VALUE="3900">仪器·仪表·工业自动化</OPTION>
<OPTION VALUE="1900">机械制造·机电设备·重工业</OPTION>
<OPTION VALUE="2600">印刷·包装·造纸</OPTION>
<OPTION VALUE="2700">生产·制造·加工</OPTION>
<OPTION VALUE="2400">环保服务·设备</OPTION>
<OPTION VALUE="1105000">航空/航天研究与制造</OPTION>
<OPTION VALUE="1106000">服务业</OPTION>
<OPTION VALUE="2900">农·林·牧·渔</OPTION>
<OPTION VALUE="3100">培训机构·教育·科研院所</OPTION>
<OPTION VALUE="3300">政府·公共事业</OPTION>
<OPTION VALUE="3400">协会·学会·社团·非营利机构</OPTION>
<OPTION VALUE="3500">在校学生</OPTION>
<OPTION VALUE="4100">其他</OPTION>

              </SELECT> --%><SPAN CLASS="note">按住Ctrl键可多选，最多选三种行业 </SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>联系人姓名&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtLinkManName" maxlength="60" value="<%=linkman%>">
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="1" CHECKED>
              先生
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="0" <%if(!sex)out.println(" CHECKED ");%>>
            女士</TD>
          </TR><%-- %>
          <TR VALIGN="TOP">
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 联系人职位&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text" NAME="txtLinkManTitle" MAXLENGTH="60" VALUE="">
            </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">* </SPAN>E-mail&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="text" name="txtEmail" maxlength="120" value="<%=email%>">              <SPAN CLASS="alert">重要！</SPAN><SPAN CLASS="note">E-mail是你今后使用本网的重要工具，请务必填写正确。</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 电话&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT  class="edit_input"  TYPE="text" NAME="txtPhone" MAXLENGTH="40" VALUE="<%=telephone%>">
              <SPAN CLASS="note">格式：区号-电话-分机</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> 公司简介&nbsp;</TD>
            <TD COLSPAN="3"> <TEXTAREA NAME="txtComIntr" class="edit_input"  COLS="70" ROWS="5"><%=synopsis%></TEXTAREA>
              <br/> <SPAN CLASS="note">最多可以输入3000个字。</SPAN><A HREF="javascript:getLength(form1.txtComIntr.value);">查看字数</A></TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 用户名&nbsp;</TD>
            <TD COLSPAN="3"><input class="edit_input"  type="text" name="txtUserName" maxlength="20" value="<%if(member!=null)out.println(new String(member.getBytes("ISO-8859-1")));%>">              <SPAN CLASS="note"> 20位以内，字母、数字、下划线的组合</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 密码&nbsp;</TD>
            <TD COLSPAN="3"><input  class="edit_input"  type="password" name="txtPassword" maxlength="12">              <SPAN CLASS="note"> 6－12位</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 确认密码&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT class="edit_input" TYPE="password" NAME="txtConPassword" MAXLENGTH="12">
            </TD>
          </TR>

          <TR>
            <TD COLSPAN="4" ALIGN="center" HEIGHT="50"> <INPUT NAME="hiddenSubmit" VALUE="1" TYPE="hidden">
                            <input name="提交" type="submit" id="提交" value="提交"  class="edit_button" >
              &nbsp; <input name="取消" type="submit" id="取消" value="取消" onClick="return cancel();"  class="edit_button" >
            </TD>
          </TR>
        </TABLE>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>

</html>

