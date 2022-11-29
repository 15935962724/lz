<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="tea.entity.site.*"%>
<%@ page import=" tea.resource.*"%>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
TeaServlet ts=new TeaServlet();
//
NightShop nightShop=NightShop.find(teasession._nNode,teasession._nLanguage);
%>
<style type="text/css">
<!--
.g1 {
	background-image: url(/tea/image/section/11332.gif);
	background-repeat: repeat-x;height:8px;
}
-->
</style>

<ul class="frame" style="width:395px;background:#D9DAC1;"><div class="bg">∥会员评分</div>



<table width="100%"  border="0" cellspacing="1" cellpadding="2" class="hue">
<tr bgcolor="#E9EAD1">
<td width="25%" align="right">整体印象</td>
<td width="25%"><div style="width:" <%= nightShop.getHolisticMark()%> "%" class="g1" ></div></td>
<td width="25%" align="right">交通条件</td>
<td><div style="width:" <%=     nightShop.getRelaxMark()%> "%" class="g1" ></div>
									  </td>  </tr>
									  <tr bgcolor="#E9EAD1">    <td align="right">球场景观</td>    <td><div style="width:" <%= nightShop.getAuraMark()%> "%" class="g1" ></div></td>    <td align="right">会所印象</td>    <td><div style="width:" <%= nightShop.getLamplightMark()%>
                                      "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">草坪前台服务</td>    <td><div style="width:" <%= nightShop.getServeMark()%> "%" class="g1" ></div></td>    <td align="right">沙坑餐厅与饮食</td>    <td><div style="width:" <%= nightShop.getTemperatureMark()%>
                                      "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">球场难度</td>    <td><div style="width:"
                                      <%= nightShop.getMusicMark()%> "%" class="g1" ></div></td>    <td align="right">更衣间</td>    <td><div style="width:" <%= nightShop.getAirMark()%> "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">球童水平</td>    <td><div style="width:" <%= nightShop.getCrowdMark()%>
                                      "%" class="g1" ></div></td>    <td align="right">洗手间</td>    <td><div style="width:" <%= nightShop.getSafetyMark()%> "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">消费客户群素质</td>    <td><div style="width:" <%= nightShop.getDrinkMark()%>
                                      "%" class="g1" ></div></td>    <td align="right">心情指数</td>    <td><div style="width:" <%= nightShop.getBelleMark()%> "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">食品</td>    <td><div style="width:" <%= nightShop.getDeliMark()%> "%" class="g1" ></div></td>    <td align="right">价格</td>    <td><div style="width:" <%=
                                      nightShop.getPriceMark()%> "%" class="g1" ></div></td>  </tr>  <tr bgcolor="#E9EAD1">    <td align="right">卫生间</td>    <td><div style="width:"
                                      <%= nightShop.getToiletMark()%> "%" class="g1" ></div></td>    <td align="right"></td>    <td></td>  </tr>  <tr align="right" bgcolor="#E9EAD1">    <td colspan="4">[会员评论] [我要打分] </td>  </tr></table>



