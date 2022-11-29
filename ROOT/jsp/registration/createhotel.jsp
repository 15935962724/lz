<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
Community community=Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" >
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "创建酒店")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <FORM name="form1"  method="POST" action="/servlet/CreateHostel">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <th nowrap>*<%=r.getString(teasession._nLanguage, "名称：")%></th>
      <td ><input type="TEXT" class="edit_input"  name="subject" size="30" maxlength="40" style="width=500;"><span id="domain"></span></td>
      </tr>
      <tr>
    <th> <%=r.getString(teasession._nLanguage,"星级：")%></th>
    <td><select name="starclass">
        <option value="0" selected="selected">----无----</option>
        <option value="5">☆☆☆☆☆</option>
        <option value="4">☆☆☆☆</option>
        <option value="3">☆☆☆</option>
        <option value="2">☆☆</option>
        <option value="1">☆</option>
         </select></td>
    </tr>
      <tr>
      <th>*<%=r.getString(teasession._nLanguage, "电话：")%></th>
      <td><input type="text" name="phone"  /></td>
      </tr>
    <tr><th> <%=r.getString(teasession._nLanguage,"传真：")%></th>
      <td >
           <input type="text" name="fax" />
      </td>
      </tr>
     <tr>
      <th>*<%=r.getString(teasession._nLanguage, "联系人：")%></th>
      <td><input type="TEXT" class="edit_input"  name="name" size=30 maxlength=20></td>
      </tr>
     <tr>
      <th>*<%=r.getString(teasession._nLanguage, "地址：")%></th>
      <td><input type="text" class="edit_input"  name="address" size="30" maxlength="16" style="width=500;"></td>
      </tr>
       <tr>
	    <th> <%=r.getString(teasession._nLanguage,"邮编：")%></th>
      <td colspan="2"><input name="postcode" type="text"  size="30"></td>
    </tr>
      <tr>
      <th>*<%=r.getString(teasession._nLanguage, "城市：")%></th>
      <td><input type="text" class="edit_input"  name="city" value="" size=30 maxlength=16>
      &nbsp;&nbsp; *<%=r.getString(teasession._nLanguage, "市/区：")%> <input type="text" name="district" />
      </td>
   </tr>
      <tr>
        <th>
        <%=r.getString(teasession._nLanguage,"地理位置：")%>
        </th>
        <td>
        距火车站：<input type="text" name="tostaion"   style="width=60;"/>公里 &nbsp; &nbsp;&nbsp;
        距飞机场：<input type="text"  name="toairport" style="width=60;"/>公里 &nbsp;&nbsp; &nbsp;
        距市中心：<input type="text"  name="tocenter"  style="width=60;"/>公里 &nbsp; &nbsp;&nbsp;
        距地铁： <input type="text"   name="tosubway"  style="width=60;"/>公里 &nbsp; &nbsp;&nbsp;
        </td>
      </tr>
     <tr id=type_1>
      <th><%=r.getString(teasession._nLanguage, "图片：")%></th>
      <td><input type="file" class="edit_input"  name="pic" size=30 maxlength=20></td>
    </tr>
    <tr id="type_0">
      <th>*<%=r.getString(teasession._nLanguage, "logo：")%></th>
      <td><input type="file" class="edit_input"  name="logo" size=30 maxlength=40></td>
    </tr>
   <tr>
   <th><%=r.getString(teasession._nLanguage,"特价：") %></th>
   <td>
   房型：<input type="text" name="roomtype"/> &nbsp;&nbsp;
   价格：<input type="text"  name="price" /> &nbsp;&nbsp;
   有效期：<input type="text"  name="duration"/> &nbsp;&nbsp;
   </td>
   </tr>
   <tr> <th> <%=r.getString(teasession._nLanguage,"简介：")%></th>
    <td><textarea cols="120" rows="5" name="intro"></textarea>
    </td> </tr>
    <tr><th> <%=r.getString(teasession._nLanguage,"酒店设施：")%></th>
    <td>
    餐&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;厅：<input type="text" name="restaurant" style="width=700;" /><br />
    商务中心：<input type="text" name="businesscenter" style="width=700;" /><br />
    娱乐中心：<input type="text" name="entertainmentcenter" style="width=700;"/><br />
    商&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;场：<input type="text" name="shopping" style="width=700;"/><br />
    其&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;他：<input type="text" name="other" style="width=700;"/><br />
    </td>
    </tr>
   <tr>
   <th><%=r.getString(teasession._nLanguage,"图片：") %></th>
   <td><input type="button" value="创建" /></td>
   </tr>
   <tr>
   <th><%=r.getString(teasession._nLanguage,"房型：") %></th>
   <td><input type="button" value="创建" /></td>
   </tr>
    <tr>
    <th> <%=r.getString(teasession._nLanguage,"付款方式：")%></th>
     <td>
    <input type="radio" name="paytype" checked="checked" value="1"/>前台自付&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="text"  value=" " name="introduce1" style="width=750;"/><br />
    <input type="radio" name="paytype" value="2"/>担保&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text" value=" " name="introduce2" style="width=750;"/><br />
    <input type="radio" name="paytype" value="3"/>预付&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text"  value=" " name="introduce3" style="width=750;"/><br />
    <input type="radio" name="paytype" value="4"/>代收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text"  value=" " name="introduce4" style="width=750;"/><br />
    <input type="radio" name="paytype" value="5"/>会员积分担保
    <input type="text" value=" "  name="introduce5" style="width=750;"/><br />
   </td>
    </tr>
    <tr>
    <td></td>
    <td align="center" colspan="2">
      <input type="button" value="<%=r.getString(teasession._nLanguage, " 上一步  ")%> " onclick="history.back();" />
      <input type="submit" class="edit_button" id="edit_submit" value="创建酒店">
    </td>
    </tr>
  </table>
  </FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</div>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
