<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*"%><%@ page import="tea.ui.TeaSession"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

NightShop nightShop=NightShop.find(teasession._nNode,teasession._nLanguage);

String value = new String("<table width=\"100%\"  border=\"0\" cellspacing=\"1\" cellpadding=\"2\" class=\"hue\">  <tr bgcolor=\"#E9EAD1\">    <td width=\"25%\" align=\"right\">整体印象</td>    <td width=\"25%\"><div style=\"width:" + nightShop.getHolisticMark() +
                                      "%\" class=\"g1\" ></div></td>    <td width=\"25%\" align=\"right\">身心放松度</td>    <td><div style=\"width:" +
                                      nightShop.getRelaxMark() + "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">环境气氛</td>    <td><div style=\"width:" + nightShop.getAuraMark() + "%\" class=\"g1\" ></div></td>    <td align=\"right\">灯光</td>    <td><div style=\"width:" +
                                      nightShop.getLamplightMark() +
                                      "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">服务</td>    <td><div style=\"width:" + nightShop.getServeMark() + "%\" class=\"g1\" ></div></td>    <td align=\"right\">温度</td>    <td><div style=\"width:" + nightShop.getTemperatureMark() +
                                      "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">音乐</td>    <td><div style=\"width:"
                                      + nightShop.getMusicMark() + "%\" class=\"g1\" ></div></td>    <td align=\"right\">空气清新度</td>    <td><div style=\"width:" + nightShop.getAirMark() + "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">人群素质</td>    <td><div style=\"width:" +
                                      nightShop.getCrowdMark() +
                                      "%\" class=\"g1\" ></div></td>    <td align=\"right\">安全系数</td>    <td><div style=\"width:" + nightShop.getSafetyMark() + "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">酒水</td>    <td><div style=\"width:" + nightShop.getDrinkMark() +
                                      "%\" class=\"g1\" ></div></td>    <td align=\"right\">美女含量</td>    <td><div style=\"width:" + nightShop.getBelleMark() + "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">食品</td>    <td><div style=\"width:" + nightShop.getDeliMark() +
                                      "%\" class=\"g1\" ></div></td>    <td align=\"right\">价格</td>    <td><div style=\"width:" +
                                      nightShop.getPriceMark() + "%\" class=\"g1\" ></div></td>  </tr>  <tr bgcolor=\"#E9EAD1\">    <td align=\"right\">卫生间</td>    <td><div style=\"width:"
                                      + nightShop.getToiletMark() + "%\" class=\"g1\" ></div></td>    <td align=\"right\"></td>    <td></td>  </tr>  </table>");
out.print(value);
%>

