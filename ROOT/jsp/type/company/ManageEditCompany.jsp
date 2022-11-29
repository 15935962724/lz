<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
//            if(!node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }
            r.add("/tea/ui/node/type/classified/EditClassified");
            Company classified;
            String name;
            String text;
             int len=0;
           if(request.getParameter("NewNode")!=null||request.getParameter("NewBrother")!=null)
           {  classified = Company.find(0);
             name="";
             text="";
          } else
          { classified=Company.find(teasession._nNode);
            name=node.getSubject(teasession._nLanguage);
            text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
            len=(int)new File(getServletContext().getRealPath(classified.getLicense(teasession._nLanguage))).length();
        }
%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function submit()
{
return true;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ManageEditCompany")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM  enctype="multipart/form-data"  name=foEdit METHOD=POST action="/servlet/EditCompany" onsubmit="return submitText(this.Name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submit()">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");

            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }
            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr><td>*<%=r.getString(teasession._nLanguage, "Name")%>:</td>
              <td colspan="2"><input type="TEXT" class="edit_input"  name="Name" size="40" MAXLENGTH="255" VALUE="<%=(name)%>"></td>
            </tr>
              <tr><td><%=r.getString(teasession._nLanguage, "Intro")%>:</td>
              <td colspan="2"><textarea name="Text" rows="8" cols="70" class="edit_input"><%=text%></textarea></td>
            </tr>

            <tr><td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Contact VALUE="<%=getNull(classified.getContact(teasession._nLanguage))%>"></td>
           <td width="234">
               <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="1" CHECKED>先生
              <INPUT  id="radio" type="radio" NAME="rdoGender" VALUE="0"<%=getCheck(!classified.getSex(teasession._nLanguage))%>>女士</TD>
</tr>
            <tr><td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=getNull(classified.getEmail(teasession._nLanguage))%>"></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
              <td colspan="2"><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=getNull(classified.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
              <td colspan="2"><TEXTAREA name=Address  class="edit_input" ROWS=2 COLS=60><%=HtmlElement.htmlToText(getNull(classified.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "City")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=getNull(classified.getCity(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "State")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=State VALUE="<%=getNull(classified.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(classified.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Country")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=getNull(classified.getCountry(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(classified.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(classified.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
              <td colspan="2"><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=getNull(classified.getWebPage(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "WebLanguage")%>:</td>
              <td><SELECT name=WebLanguage>
                  <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[0])%></OPTION>
                  <OPTION VALUE="1"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[1])%></OPTION>
                  <OPTION VALUE="2"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[2])%></OPTION>
                  <OPTION VALUE="3"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[3])%></OPTION>
                  <OPTION VALUE="4"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[4])%></OPTION>
                  <OPTION VALUE="5"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[5])%></OPTION>
                  <OPTION VALUE="6"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[6])%></OPTION>
                  <OPTION VALUE="7"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[7])%></OPTION>
                  <OPTION VALUE="8"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[8])%></OPTION>
                  <OPTION VALUE="9"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[9])%></OPTION>
                </SELECT></td>
            </tr>
            <tr><td><%=r.getString(teasession._nLanguage, "License")%>:</td>
              <td colspan="2"><input type="file" name="license" class="edit_input" />
                <%if(len>0)out.print(len+r.getString(teasession._nLanguage, "Bytes"));%>
            <input  id="CHECKBOX" type="CHECKBOX" name=Clear value=null><%=r.getString(teasession._nLanguage, "Clear")%>
              </td></tr>
              <TR>
            <TD ALIGN="right"><SPAN CLASS="alert">*</SPAN> 公司性质&nbsp;</TD>
            <TD> <SELECT NAME="lstComType" STYLE="width:135px">
                <OPTION VALUE="" >--请选择--</OPTION>
<OPTION <%=getSelect("外商独资．外企办事处".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="外商独资．外企办事处">外商独资．外企办事处</OPTION>
<OPTION  <%=getSelect("中外合营(合资．合作)".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="中外合营(合资．合作)">中外合营(合资．合作)</OPTION>
<OPTION  <%=getSelect("私营．民营企业".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="私营．民营企业">私营．民营企业</OPTION>
<OPTION  <%=getSelect("国有企业".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="国有企业">国有企业</OPTION>
<OPTION  <%=getSelect("国内上市公司".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="国内上市公司">国内上市公司</OPTION>
<OPTION  <%=getSelect("政府机关／非盈利机构".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="政府机关／非盈利机构">政府机关／非盈利机构</OPTION>
<OPTION  <%=getSelect("事业单位".equals(classified.getProperty(teasession._nLanguage)))%>VALUE="事业单位">事业单位</OPTION>
             </SELECT> </TD>
            <TD ><SPAN CLASS="alert">*</SPAN> 公司规模&nbsp;
             <SELECT NAME="lstSize">
                <OPTION VALUE="-1">--请选择--</OPTION>
<OPTION  <%=getSelect(classified.getSize(teasession._nLanguage)==1)%>VALUE="1">1 - 49人</OPTION>
<OPTION <%=getSelect(classified.getSize(teasession._nLanguage)==50)%> VALUE="50">50 - 99人</OPTION>
<OPTION <%=getSelect(classified.getSize(teasession._nLanguage)==100)%> VALUE="100">100 - 499人</OPTION>
<OPTION <%=getSelect(classified.getSize(teasession._nLanguage)==500)%> VALUE="500">500 - 999人</OPTION>
<OPTION <%=getSelect(classified.getSize(teasession._nLanguage)==1000)%> VALUE="1000">1000人以上</OPTION>

              </SELECT> </TD>
          </TR>
             <TR>
            <TD ALIGN="right" VALIGN="top"><SPAN CLASS="alert">*</SPAN> 所属行业&nbsp;</TD>
            <TD COLSPAN="3">
              <%=new tea.htmlx.TradeSelection("lstIndustry",classified.getCalling(teasession._nLanguage))%>
<%--
 <SELECT  class="edit_input" NAME="lstIndustry" SIZE="5"  MULTIPLE  STYLE="width:275px">
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

              </SELECT> <SPAN CLASS="note">按住Ctrl键可多选，最多选三种行业 </SPAN>--%>
            </TD>
          </TR>
          </table>
          <P ALIGN=CENTER>
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
          </P>
        </form>
        <script>foEdit.Name.focus();</script>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

