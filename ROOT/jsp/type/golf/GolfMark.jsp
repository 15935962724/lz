<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %><%

int node=Integer.parseInt(request.getParameter("node"));
int language=Integer.parseInt(request.getParameter("language"));

Golf obj=Golf.find(node,language);
%>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="hue">
  <tr bgcolor="#E9EAD1">
    <td width="25%" align="right">整体印象</td>
    <td width="25%">
      <div style="width:<%= obj.getHolisticMark()%>%" class="g1">      </div>
    </td>
    <td width="25%" align="right">交通条件</td>
    <td>
      <div style="width:<%= obj.getRelaxMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">球场景观</td>
    <td>
      <div style="width:<%= obj.getAuraMark()%>%" class="g1">      </div>
    </td>
    <td align="right">会所印象</td>
    <td>
      <div style="width:<%= obj.getLamplightMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">前台服务</td>
    <td>
      <div style="width:<%= obj.getServeMark()%>%" class="g1">      </div>
    </td>
    <td align="right">餐厅与饮食</td>
    <td>
      <div style="width:<%= obj.getTemperatureMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">球场难度</td>
    <td>
      <div style="width:<%= obj.getMusicMark()%>%" class="g1">      </div>
    </td>
    <td align="right">更衣间</td>
    <td>
      <div style="width:<%= obj.getAirMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">球童水平</td>
    <td>
      <div style="width:<%= obj.getCrowdMark()%>%" class="g1">      </div>
    </td>
    <td align="right">洗手间</td>
    <td>
      <div style="width:<%= obj.getSafetyMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">消费客户群素质</td>
    <td>
      <div style="width:<%= obj.getDrinkMark()%>%" class="g1">      </div>
    </td>
    <td align="right">心情指数</td>
    <td>
      <div style="width:<%= obj.getBelleMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <tr bgcolor="#E9EAD1">
    <td align="right">草坪</td>
    <td>
      <div style="width:<%= obj.getDeliMark()%>%" class="g1">      </div>
    </td>
    <td align="right">沙坑</td>
    <td>
      <div style="width:<%= obj.getPriceMark()%>%" class="g1">      </div>
    </td>
  </tr>
  <%--<tr bgcolor="#E9EAD1">
    <td align="right">卫生间</td>
    <td>
      <div style="width:<%= obj.getToiletMark()%>%" class="g1">      </div>
    </td>
    <td align="right">    </td>
    <td>    </td>
  </tr>--%>
</table>

