<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
//  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  Community community = Community.find(teasession._strCommunity);

StringBuffer s1=new StringBuffer();
StringBuffer s2=new StringBuffer();
  java.util.Enumeration e = City.find(teasession._strCommunity, " and father = 0", 0, Integer.MAX_VALUE);
   s1.append("var c0=new Array(new Array(0,'--------不限--------')");
  while (e.hasMoreElements()) {
    int id = ((Integer) e.nextElement()).intValue();
    City c = City.find(id);

   s1.append(",new Array(" + id + ",\"" +c.getCityname() + "\")");
   s2.append("var c" + id+ "=new Array(new Array(0,'--------不限--------')");

      java.util.Enumeration e2 = City.find(teasession._strCommunity, " AND father=" + id, 0, Integer.MAX_VALUE);
      while (e2.hasMoreElements()) {
        int id2 = ((Integer) e2.nextElement()).intValue();
        City  cy = City.find(id2);
        s2.append(",new Array(" + id2 + ",\"" + cy.getCityname() + "\")");
      }
      s2.append(");\r\n");

  }
  s1.append(");");

%>

<script type="">
<%=s1.toString()%>
<%=s2.toString()%>


function f_load()
{

  var o1=form1.city.options;
  for(var i=1;i<c0.length;i++)
  {
    o1[o1.length]=new Option(c0[i][1],c0[i][0]);
  }


}
function f_load2()
{
  var o1=form1.city.options;
  var o2=form1.borough.options;
  while(o2.length>0)
  {
    o2[0]=null;
  }
    var c=eval("c"+o1.value);

     if("c"+o1.value != 'c0'){
       for(var i=0;i<c.length;i++)
       {
         o2[o2.length]=new Option(c[i][1],c[i][0]);
       }
     }else
      {
         o2[0]=new Option('--------不限--------','0');
      }
}
</script>
<!--/jsp/registration/search2.jsp-->
  <form action="/servlet/Node" name="form1">
<input type=hidden name=node value=5>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter_chax" align="left">
    <tr><td id="left_01"><img src="/res/jiudian/u/0802/080245216.gif"></td>
      <td align="left" nowrap="nowrap"><span id="left_02_01">省/城市</span>：</td>
      <td id="left_03"  colspan="2">
        <select name="city" id="city2" onchange="f_load2()">
       <option value="0">--------不限--------</option>
        </select>

      </td>
    </tr>
    <tr>
    <tr><td><img src="/res/jiudian/u/0802/080245216.gif"></td>
      <td align="left"><span id="left_02_02">市/区</span>：</td>
      <td colspan="2">
         <select name="borough" id="borough2">
       <option value="0">--------不限--------</option>
        </select>
      </td>
    </tr>
    <tr><td><img src="/res/jiudian/u/0802/080245216.gif"></td>
      <td align="left">星　　级：</td>
      <td colspan="2">
        <select name="starclass" id="starclass2">
          <option value="0" selected="selected">--------不限--------</option>
          <option value="5">　五星级</option>
          <option value="10">准五星级</option>
          <option value="4">　四星级</option>
          <option value="9">准四星级</option>
          <option value="3">　三星级</option>
          <option value="8">准三星级</option>
          <option value="2">　二星级</option>
          <option value="7">准二星级</option>
          <option value="1">　星级</option>
          <option value="6">准星级</option>
        </select>
      </td>
    </tr>
    <tr><td><img src="/res/jiudian/u/0802/080245216.gif"></td>
      <td align="left">价　　格：</td>
      <td colspan="2">
        <select name="price" id="price2">
          <option value="0" selected="selected">--------不限--------</option>
          <option value="100">0-100</option>
          <option value="200">100-200</option>
          <option value="400">200-400</option>
          <option value="600">400-600</option>
          <option value="1000">600-1000</option>
          <option value="1200">1000以上</option>
        </select>
      </td>
    </tr>
    <tr><td><img src="/res/jiudian/u/0802/080245216.gif"></td>
      <td align="left">酒店名称：</td>
      <td>
        <input id="jdname2" type=text name="jdname" size="18">
      </td>
	    <td align="right">
        <INPUT  TYPE=image id="jd_chaxun" src="/res/jiudian/u/0802/080250269.jpg" VALUE=" 查 询 " >
      </td>
    </tr>
  </table>
  </form>

  <script>
  f_load();
  </script>
