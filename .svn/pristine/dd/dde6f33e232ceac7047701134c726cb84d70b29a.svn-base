<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(30))
  {
    //response.sendError(403);
    //return;
  }
}

r.add("/tea/resource/Financing");

%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[30])%></h1>
 <div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <SCRIPT language=JavaScript>
<!--
function checkform(theform){
    if(theform.Subject.value ==""){
        alert("对不起,节点标题不能为空");
        theform.Subject.focus();
        return false;
    }
    if(theform.name.value ==""){
        alert("对不起,您的项目名称不能为空");
        theform.name.focus();
        return false;
    }

        if(theform.synopsis.value =="")
        {
        alert("对不起,您的项目简介不能为空");
        theform.synopsis.focus();
        return false;
    }

        if(theform.allmoney.value ==""||isNaN(theform.allmoney.value)){
        alert("对不起,您的总投资金额必须是数字");
        theform.allmoney.focus();
        return false;
    }
      if(theform.financingmoney.value ==""||isNaN(theform.financingmoney.value)){
        alert("对不起,您的项目融资额必须是数字");
        theform.financingmoney.focus();
        return false;
    }
    if(theform.investcallback.value ==""||isNaN(theform.investcallback.value)){
        alert("对不起,您的投资回收期必须是数字");
        theform.investcallback.focus();
        return false;
    }
     if(theform.redound.value ==""||isNaN(theform.redound.value)){
        alert("对不起,您的回报率必须是数字");
        theform.redound.focus();
        return false;
    }
     if(theform.yearrestrict.value ==""||isNaN(theform.yearrestrict.value)){
        alert("对不起,您的合作年限必须是数字");
        theform.yearrestrict.focus();
        return false;
    }
    if(theform.unitname.value ==""){
        alert("对不起,您的单位名称不能为空");
        theform.unitname.focus();
        return false;
    } if(theform.linkman.value ==""){
        alert("对不起,您的联系人不能为空");
        theform.linkman.focus();
        return false;
    }
    if(theform.phone.value =="")
    {

			alert("对不起，您的电话不能为空");
			theform.phone.focus();
			return false;
    }
}
</script>
    <form action="/servlet/EditFinancing" method="POST" name="foNew" onSubmit="return checkform(this);" >
    <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
            Financing financing=Financing.find(0,teasession._nLanguage);
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="";
Date issueDate=null;
            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {subject=node.getSubject(teasession._nLanguage);
         financing=Financing.find(teasession._nNode,teasession._nLanguage);
         issueDate=node.getTime();
        }
            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <input type="hidden" name="node" value="<%=teasession._nNode%>">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


           <tr>
      <td><%=r.getString(teasession._nLanguage, "index")%>:&nbsp;</td>
      <td><input type="text" name="id"  class="edit_input"  value="<%=financing.getId()%>" ></td>
    </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Subject")%>:&nbsp;</td>
        <td><input type="TEXT" class="edit_input"  name=Subject value="<%=HtmlElement.htmlToText(subject)%>" size=70 maxlength=255>
        <FONT color=#ff0000>(*)</FONT></td>
      </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:&nbsp;</td>
      <td><input type="text" class="edit_input"   name="name" value="<%=financing.getName()%>"><FONT color=#ff0000>(*)</FONT></td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "Essence")%>:&nbsp;</td>
      <td><select name="essence" >
          <OPTION value=新建      selected>新建</OPTION>
          <OPTION value="改/扩建" <%=getSelect(financing.getEssence().equals("改/扩建"))%>>改/扩建</OPTION>
          <OPTION         value="新建+扩建"<%=getSelect(financing.getEssence().equals("新建+扩建"))%> >新建+扩建</OPTION>
          <OPTION value="重组"<%=getSelect(financing.getEssence().equals("重组"))%>>重组</OPTION>
          <OPTION         value="转让"<%=getSelect(financing.getEssence().equals("转让"))%>>转让</OPTION>
          <OPTION value="委托建设"<%=getSelect(financing.getEssence().equals("委托建设"))%>>委托建设</OPTION>
          <OPTION         value="组织管理"<%=getSelect(financing.getEssence().equals("组织管理"))%>>组织管理</OPTION>
          <OPTION value="委托运营"<%=getSelect(financing.getEssence().equals("委托运营"))%>>委托运营</OPTION>
          <OPTION         value="其他"<%=getSelect(financing.getEssence().equals("其他"))%>>其他</OPTION>
      </SELECT><FONT color=#ff0000>(*)</FONT>
</td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "Reside")%>:&nbsp;</td>
      <td>
          <SELECT name=reside>
	<OPTION value=高新技术 selected>高新技术</OPTION>
        <OPTION value=生物医药 <%=getCheck(financing.getReside().equals("生物医药"))%>>生物医药</OPTION>
        <OPTION value=石油化工<%=getCheck(financing.getReside().equals("石油化工"))%>>石油化工</OPTION>
        <OPTION    value=教育培训<%=getCheck(financing.getReside().equals("教育培训"))%>>教育培训</OPTION>
        <OPTION value=电子电工<%=getCheck(financing.getReside().equals("电子电工"))%>>电子电工</OPTION>
        <OPTION value="计 算 机"<%=getCheck(financing.getReside().equals("计 算 机"))%>>计 算 机</OPTION>
        <OPTION value="IT 软 件"<%=getCheck(financing.getReside().equals("IT 软 件"))%>>IT 软 件</OPTION>
        <OPTION value=出版印刷<%=getCheck(financing.getReside().equals("出版印刷"))%>>出版印刷</OPTION>
        <OPTION value=轻工纺织<%=getCheck(financing.getReside().equals("轻工纺织"))%>>轻工纺织</OPTION>
        <OPTION value=农林牧渔<%=getCheck(financing.getReside().equals("农林牧渔"))%>>农林牧渔</OPTION>
        <OPTION value="服 务 业"<%=getCheck(financing.getReside().equals("服 务 业"))%>>服 务 业</OPTION>
        <OPTION value=邮政通讯<%=getCheck(financing.getReside().equals("邮政通讯"))%>>邮政通讯</OPTION>
        <OPTION     value=交通运输<%=getCheck(financing.getReside().equals("交通运输"))%>>交通运输</OPTION>
        <OPTION value=机械设备<%=getCheck(financing.getReside().equals("机械设备"))%>>机械设备</OPTION>
        <OPTION value=食品饮料<%=getCheck(financing.getReside().equals("食品饮料"))%>>食品饮料</OPTION>
        <OPTION value=能源环保<%=getCheck(financing.getReside().equals("能源环保"))%>>能源环保</OPTION>
        <OPTION      value=建筑材料<%=getCheck(financing.getReside().equals("建筑材料"))%>>建筑材料</OPTION>
        <OPTION value="房 地 产"<%=getCheck(financing.getReside().equals("房 地 产"))%>>房 地 产</OPTION>
        <OPTION
        value=冶金矿产<%=getCheck(financing.getReside().equals("冶金矿产"))%>>冶金矿产</OPTION>
        <OPTION value=运动休闲<%=getCheck(financing.getReside().equals("运动休闲"))%>>运动休闲</OPTION>
        <OPTION
        value=娱乐产业<%=getCheck(financing.getReside().equals("娱乐产业"))%>>娱乐产业</OPTION>
        <OPTION value=连锁经营<%=getCheck(financing.getReside().equals("连锁经营"))%>>连锁经营</OPTION>
        <OPTION
        value=特许经营<%=getCheck(financing.getReside().equals("特许经营"))%>>特许经营</OPTION>
        <OPTION value=生产加工<%=getCheck(financing.getReside().equals("生产加工"))%>>生产加工</OPTION>
        <OPTION         value=医疗卫生<%=getCheck(financing.getReside().equals("医疗卫生"))%>>医疗卫生</OPTION>
        <OPTION value="其 他"<%=getCheck(financing.getReside().equals("其 他"))%>>其 他</OPTION></SELECT>
<FONT color=#ff0000>(*)</FONT>
</td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "Area")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="area" value="<%=financing.getArea()%>"></td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "Synopsis")%>:&nbsp;</td>
      <td><textarea  class="edit_input"  rows="8" cols="70"  name="synopsis" ><%=HtmlElement.htmlToText(financing.getSynopsis())%></textarea><FONT color=#ff0000>(*)</FONT></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Evolve")%>:&nbsp;</td>
      <td><SELECT name=evolve>
        <OPTION value=项目已立项完成项目建议书或预可研报告 selected>项目已立项完成项目建议书或预可研报告</OPTION>
        <OPTION value=完成正式项目可研报告<%=financing.getEvolve().equals("完成正式项目可研报告")%>>完成正式项目可研报告</OPTION>
        <OPTION value=项目可研报告已得到批复<%=financing.getEvolve().equals("项目可研报告已得到批复")%>>项目可研报告已得到批复</OPTION>
        <OPTION value=已落实项目投资人<%=financing.getEvolve().equals("已落实项目投资人")%>>已落实项目投资人</OPTION>
        <OPTION value=已完成融资安排<%=financing.getEvolve().equals("已完成融资安排")%>>已完成融资安排</OPTION>
        <OPTION value=已正式成立项目公司或已开工建设<%=financing.getEvolve().equals("已正式成立项目公司或已开工建设")%>>已正式成立项目公司或已开工建设</OPTION>
        <OPTION value=项目已建成正式运营<%=financing.getEvolve().equals("项目已建成正式运营")%>>项目已建成正式运营</OPTION></SELECT>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Future")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="future" value="<%=financing.getFuture()%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AllMoney")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="allmoney" value="<%=financing.getAllmoney()%>">万<FONT color=#ff0000>(*)</FONT></td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "FinancingMoney")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="financingmoney" value="<%=financing.getFinancingmoney()%>">万<FONT color=#ff0000>(*)</FONT></td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "InvestCallback")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="investcallback" value="<%=financing.getInvestcallback()%>"><%=r.getString(teasession._nLanguage, "Year")%><FONT color=#ff0000>(*)</FONT></td>
    </tr>
	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Redound")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="redound" value="<%=financing.getRedound()%>">%<FONT color=#ff0000>(*)</FONT></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "YearRestrict")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="yearrestrict" value="<%=financing.getYearrestrict()%>"><%=r.getString(teasession._nLanguage, "Year")%><FONT color=#ff0000>(*)</FONT></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Fashion")%>:&nbsp;</td>
      <td>
          <INPUT  id="radio" type="radio" checked value=合资 <%=getCheck(financing.getFashion().equals("合资"))%> name=fashion>合资　　　
          <INPUT        id="radio" type="radio" value=合作 <%=getCheck(financing.getFashion().equals("合作"))%>name=fashion>合作　
          <INPUT  id="radio" type="radio" value=独资   <%=getCheck(financing.getFashion().equals("独资"))%>    name=fashion>独资　　　
          <INPUT  id="radio" type="radio" value=入股<%=getCheck(financing.getFashion().equals("入股"))%>   name=fashion>入股
      <br/><INPUT  id="radio" type="radio" value=固定回报  <%=getCheck(financing.getFashion().equals("固定回报"))%>  name=fashion>固定回报　
      <INPUT  id="radio" type="radio" value=风险回报   <%=getCheck(financing.getFashion().equals("风险回报"))%>  name=fashion>风险回报　
      <INPUT  id="radio" type="radio" value=借款  <%=getCheck(financing.getFashion().equals("借款"))%>  name=fashion>借款　　　
      <INPUT  id="radio" type="radio" value=面洽  <%=getCheck(financing.getFashion().equals("面洽"))%> name=fashion>面洽
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>(*)</FONT>
          </td>
    </tr>
    </table>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitName")%>:&nbsp;</td>
      <td><input type="text" size="40"  class="edit_input"  name="unitname" value="<%=financing.getUnitname()%>">&nbsp;<FONT color=#ff0000>(*)</FONT></td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "IDCard")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="idcard" value="<%=financing.getIdcard()%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Homeplace")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="homeplace" value="<%=financing.getHomeplace()%>"></td>
    </tr>

      <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitEssence")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="unitessence" value="<%=financing.getUnitessence()%>"></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "UnitSynopsis")%>:&nbsp;</td>
      <td><textarea rows="3" cols="60" class="edit_input"  name="unitsynopsis" ><%=HtmlElement.htmlToText(financing.getUnitsynopsis())%></textarea></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Website")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="website" value="<%=financing.getWebsite()%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Linkman")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="linkman" value="<%=financing.getLinkman()%>"><FONT color=#ff0000>(*)</FONT></td>
    </tr>

    <tr>
      <td><%=r.getString(teasession._nLanguage, "Phone")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="phone" value="<%=financing.getPhone()%>"><FONT color=#ff0000>(*)</FONT></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="fax" value="<%=financing.getFax()%>"></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "E-mail")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="email" value="<%=financing.getEmail()%>"></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Postalcode")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="postalcode" value="<%=financing.getPostalcode()%>"></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:&nbsp;</td>
      <td><input type="text"  class="edit_input"  name="address"  size=70 value="<%=financing.getAddress()%>"></td>
    </tr>	 <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>:&nbsp;</td>
      <td><%=new TimeSelection("Issue", issueDate)%></td>
    </tr>
  </table><center>
    <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</center>
 </form>
      <script>document.foNew.name.focus();</script>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

