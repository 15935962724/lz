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
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(54))
  {
    //response.sendError(403);
    //return;
  }
}

r.add("/tea/resource/LInvestor");
tea.entity.node.LInvestor investor =tea.entity.node.LInvestor.find(0, teasession._nLanguage);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0051)http://www.chinaip.net/admin_self/fund/add_fund.asp -->
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK
href="add_fund.files/mystyle.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript>
<!--
function checkform(theform){
    if(theform.Subject.value ==""){
		alert("对不起,节点标题不能为空");
		theform.Subject.focus();
		return false;
	}
	if(theform.fund_name.value ==""){
		alert("对不起,您的资金方名称不能为空");
		theform.fund_name.focus();
		return false;
	}
	if(theform.fund_info.value==""){
	   alert("对不起,您的资金方简介不能为空");
	   theform.fund_info.focus();
	   return false;
	}
	if(theform.fund_sum.value==""){
	   alert("对不起,您的欲投金额不能为空");
	   theform.fund_sum.focus();
	   return false;
	}
	if(isNaN(theform.fund_sum.value)){
		alert("对不起，欲投金额必须为数值");
		theform.fund_sum.value="";
		theform.fund_sum.focus();
		return false;
	}
	if(theform.fund_area_pro.value==""){
	   alert("对不起,您的投资地区不能为空");
	   theform.fund_area_pro.focus();
	   return false;
	 }
	 if(theform.fund_trade.value==""){
	   alert("对不起,您的投资领域不能为空");
	   theform.fund_trade.focus();
	   return false;
	 }
	 if(!check_symbiosis(theform.fund_symbiosis)){
	 	alert("对不起，合作方式不能为空");
		return false;
	 }
	 if(theform.fund_linkMan.value==""){
	   alert("对不起,联系人不能为空");
	   theform.fund_linkMan.focus();
	   return false;
	 }
	 if(theform.fund_IDcard.value!=""&&theform.fund_IDcard.value!=" "){
	 	if(isNaN(theform.fund_IDcard.value))
        {
			alert("对不起，身份证号必须为数字");
			theform.fund_IDcard.value="";
			theform.fund_IDcard.focus();
			return false;
		}
		if(theform.fund_IDcard.value.length!=15&&theform.fund_IDcard.value.length!=18){
			alert("对不起，身份证号的位数不正确");
			theform.fund_IDcard.value="";
			theform.fund_IDcard.focus();
			return false;
		}
	 }
	 if(theform.fund_tel.value==""&&theform.fund_fax.value==""&&
	 	theform.fund_mail.value==""&&theform.fund_address.value==""){
		alert("对不起，电话、传真、电子邮件、地址最少填写一项");
		theform.fund_tel.focus();
		return false;
	}
	return true;
}
function check_symbiosis(sym_ob){
	var re = false;
	for(i=0;i<8;i++){
		if(sym_ob[i].checked)
			return true;
	}
	return false;
}
//-->
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[51])%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<FORM name=form1 onSubmit="return checkform(this);" action="/servlet/EditLInvestor"  method=post>
  <%
    String parameter=request.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
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
        investor= tea.entity.node.LInvestor.find(teasession._nNode, teasession._nLanguage);
        issueDate=node.getTime();
    }
            %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type='hidden' name=Node value="<%=teasession._nNode%>">
  <TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <TBODY>
      <%--
       <TR>
        <TD align=right width="13%"><%=r.getString(teasession._nLanguage, "index")%>：</TD>
        <TD colSpan=3><INPUT name=id value="<%=investor.getId()%>"  class="edit_input"  >
          <!--<FONT color=#ff0000>(*)</FONT>--></TD>
      </TR> --%>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Subject value="<%=HtmlElement.htmlToText(subject)%>" size=70 maxlength=255>
          <FONT color=#ff0000>(*)</FONT> </td>
      </tr>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundname")%>：</TD>
        <TD><INPUT name=fund_name  class="edit_input" value="<%=investor.getFundname()%>" size="40" maxlength="50">
          <FONT color=#ff0000>(*)</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundinfo")%>：</TD>
        <TD> <TABLE cellSpacing="0" cellPadding="0" border=0 id="tablecenter">
            <TBODY>
              <TR>
                <TD><TEXTAREA name=fund_info  class="edit_input" rows=6 cols=45><%=HtmlElement.htmlToText(investor.getFundinfo())%></TEXTAREA> </TD>
                <TD><FONT
        color=#ff0000>(*)</FONT></TD>
              </TR>
            </TBODY>
          </TABLE></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundsum")%>：</TD>
        <TD><INPUT name=fund_sum class="edit_input"  value="<%=investor.getFundsum()%>" maxlength="10">
          万<FONT color=#ff0000>(*)</FONT></TD>
        <TD><%=r.getString(teasession._nLanguage, "Fundsumload")%>：</TD>
        <TD> <%  Calendar calendar = Calendar.getInstance();
          Date
          _date=investor.getFundsumload();
          if(_date==null)
          _date=new Date();
        calendar.setTime(_date);
                      int i = calendar.get(1);
            StringBuffer sb=new StringBuffer("<select name=fund_sum_load_1>");
            for (int k = i - 9; k <= i + 4; k++)
            sb.append("<option value="+k+" "+getSelect(k==i)+">"+k+"</option>");
            out.print(sb.toString()+"</select>年");

          DropDown dropdown = new DropDown("fund_sum_load_2", calendar.get(2) + 1);
        int j = 1;
        do
            dropdown.addOption(j, Integer.toString(j));
        while (++j <= 12);
        out.println(dropdown+"月");
            %>
          <FONT
  color=#ff0000>(*)</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundarea")%>：</TD>
        <TD> <input name="fund_area_pro"  class="edit_input" value="<%=investor.getFundarea()%>" maxlength="20"/>
          <FONT
      color=#ff0000>(*)</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundtrade")%>：</TD>
        <TD><SELECT name=fund_trade>
            <OPTION value="高新技术"        selected>高新技术</OPTION>
            <OPTION value="生物医药" <%=getSelect(investor.getFundtrade().equals("生物医药"))%>>生物医药</OPTION>
            <OPTION        value="石油化工" <%=getSelect(investor.getFundtrade().equals("石油化工"))%>>石油化工</OPTION>
            <OPTION value="教育培训"<%=getSelect(investor.getFundtrade().equals("教育培训"))%>>教育培训</OPTION>
            <OPTION        value="电子电工"<%=getSelect(investor.getFundtrade().equals("电子电工"))%>>电子电工</OPTION>
            <OPTION value="计 算 机"<%=getSelect(investor.getFundtrade().equals("计 算 机"))%>>计 算 机</OPTION>
            <OPTION value="IT 软 件"<%=getSelect(investor.getFundtrade().equals("IT 软 件"))%>>IT 软 件</OPTION>
            <OPTION value="出版印刷"<%=getSelect(investor.getFundtrade().equals("出版印刷"))%>>出版印刷</OPTION>
            <OPTION value="轻工纺织"<%=getSelect(investor.getFundtrade().equals("轻工纺织"))%>>轻工纺织</OPTION>
            <OPTION value="农林牧渔"<%=getSelect(investor.getFundtrade().equals("农林牧渔"))%>>农林牧渔</OPTION>
            <OPTION value="服 务 业"<%=getSelect(investor.getFundtrade().equals("服 务 业"))%>>服 务 业</OPTION>
            <OPTION        value="邮政通讯"<%=getSelect(investor.getFundtrade().equals("邮政通讯"))%>>邮政通讯</OPTION>
            <OPTION value="交通运输"<%=getSelect(investor.getFundtrade().equals("交通运输"))%>>交通运输</OPTION>
            <OPTION        value="机械设备"<%=getSelect(investor.getFundtrade().equals("机械设备"))%>>机械设备</OPTION>
            <OPTION value="食品饮料"<%=getSelect(investor.getFundtrade().equals("食品饮料"))%>>食品饮料</OPTION>
            <OPTION        value="能源环保"<%=getSelect(investor.getFundtrade().equals("能源环保"))%>>能源环保</OPTION>
            <OPTION value="建筑材料"<%=getSelect(investor.getFundtrade().equals("建筑材料"))%>>建筑材料</OPTION>
            <OPTION value="房 地 产"<%=getSelect(investor.getFundtrade().equals("房 地 产"))%>>房 地 产</OPTION>
            <OPTION value="冶金矿产"<%=getSelect(investor.getFundtrade().equals("冶金矿产"))%>>冶金矿产</OPTION>
            <OPTION        value="运动休闲"<%=getSelect(investor.getFundtrade().equals("运动休闲"))%>>运动休闲</OPTION>
            <OPTION value="娱乐产业"<%=getSelect(investor.getFundtrade().equals("娱乐产业"))%>>娱乐产业</OPTION>
            <OPTION        value="连锁经营"<%=getSelect(investor.getFundtrade().equals("连锁经营"))%>>连锁经营</OPTION>
            <OPTION value="特许经营"<%=getSelect(investor.getFundtrade().equals("特许经营"))%>>特许经营</OPTION>
            <OPTION        value="生产加工"<%=getSelect(investor.getFundtrade().equals("生产加工"))%>>生产加工</OPTION>
            <OPTION value="医疗卫生"<%=getSelect(investor.getFundtrade().equals("医疗卫生"))%>>医疗卫生</OPTION>
            <OPTION value="其 他"<%=getSelect(investor.getFundtrade().equals("其 他"))%>>其 他</OPTION>
          </SELECT>
          <FONT color=#ff0000>(*)</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundsymbiosis")%>：</TD>
        <TD><INPUT  id="radio" type="radio" checked="checked" value=合资 name=fund_symbiosis <%=getCheck(investor.getFundsymbiosis().equals("合资"))%>>
          合资　　　
          <INPUT       id="radio" type="radio" value=合作 name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("合作"))%>>
          合作　　　
          <INPUT  id="radio" type="radio" value=独资      name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("独资"))%>>
          独资　　　
          <INPUT  id="radio" type="radio" value=入股 name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("入股"))%>>
          入股 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<FONT color=#ff0000>(*)</FONT> <br/>
          <INPUT  id="radio" type="radio" value=固定回报
      name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("固定回报"))%>>
          固定回报　
          <INPUT  id="radio" type="radio" value=风险回报
      name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("风险回报"))%>>
          风险回报　
          <INPUT  id="radio" type="radio" value=借款 name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("借款"))%>>
          借款　　　
          <INPUT  id="radio" type="radio" value=面洽 name=fund_symbiosis<%=getCheck(investor.getFundsymbiosis().equals("面洽"))%>>
          面洽 </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundwill")%>：</TD>
        <TD><TEXTAREA class="edit_input"  name=fund_will rows=6 cols=45><%=investor.getFundwill()%></TEXTAREA></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundwebsite")%>：</TD>
        <TD><INPUT name=fund_website class="edit_input"  id=fund_website value="<%=investor.getFundwebsite()%>" maxlength="50"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundperiod")%>：</TD>
        <TD><SELECT name=fund_period>
            <OPTION value=1  <%=getSelect(investor.getFundperiod()==1)%>>一个月</OPTION>
            <OPTION value=3<%=getSelect(investor.getFundperiod()==3)%>>三个月</OPTION>
            <OPTION         value=6<%=getSelect(investor.getFundperiod()==6)%>>六个月</OPTION>
            <OPTION value=12<%=getSelect(investor.getFundperiod()==12)%>>十二个月</OPTION>
          </SELECT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage,"FundLocal")%>：</TD>
        <TD> <INPUT name=fund_local  class="edit_input" value="<%=investor.getFundlocal()%>" size="40" maxlength="50">
          (<FONT
      color=#ff0000>详细地址</FONT>) </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundidcard")%>：</TD>
        <TD><INPUT name=fund_IDcard  class="edit_input" value="<%=investor.getFundidcard()%>" size=18 maxlength="50"> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundlinkman")%>：</TD>
        <TD><INPUT name=fund_linkMan  class="edit_input" value="<%=investor.getFundlinkman()%>" size=15 maxlength="50">
          <FONT
      color=#ff0000>(*)</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "mobile")%>：</TD>
        <TD><INPUT name=mobile  class="edit_input" value="<%=investor.getMobile()%>" maxlength="50"> </TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundtel")%>：</TD>
        <TD><INPUT name=fund_tel  class="edit_input" value="<%=investor.getFundtel()%>" maxlength="50">
          <FONT
      color=#ff0000>(*)以下（电话、传真、电子邮件、地址最少填写一项）</FONT></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundfax")%>：</TD>
        <TD><INPUT name=fund_fax class="edit_input"  value="<%=investor.getFundfax()%>" maxlength="50"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundmail")%>：</TD>
        <TD><INPUT name=fund_mail  class="edit_input" value="<%=investor.getFundmail()%>" maxlength="50"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundpostcode")%>：</TD>
        <TD><INPUT  name=fund_postcode class="edit_input" value="<%=investor.getFundpostcode()%>" size=10 maxlength="10"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "Fundaddress")%>：</TD>
        <TD><INPUT name=fund_address  class="edit_input" value="<%=investor.getFundaddress()%>" size=35 maxlength="128"></TD>
      </TR>
      <TR>
        <TD><%=r.getString(teasession._nLanguage, "IssueTime")%>：</TD>
        <TD><%=new TimeSelection("Issue", issueDate)%></TD>
      </TR>
      <TR align=middle>
        <TD colSpan=4><INPUT type=submit  ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Submit")%>" name=Submit>
          <INPUT type=reset value=<%=r.getString(teasession._nLanguage, "Reset")%>  ID="edit_GoFinish" class="edit_button" name=Submit2>
          <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>"> </TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
<script>document.form1.fund_name.focus();</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

