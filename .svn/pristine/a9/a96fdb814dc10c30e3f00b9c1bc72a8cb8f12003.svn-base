<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.finance.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
String member = teasession._rv._strR;

String act = request.getParameter("act");
if(act!=null)
{
  if(act.equals("del")){
    int id = Integer.parseInt(request.getParameter("id"));
    KindsMoney.del(id);
  }
}
%>
<html>
<!-- Stock photography -->
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">


</script>
<style>
h1{color:#333;margin:20px 10px 5px 10px;display: block;width:100%;height:26px;padding-left:30px;vertical-align: middle;line-height: 30px;text-align:left;background:url(/res/bigpic/u/0812/08126036.gif) no-repeat left center;font-size:14px;font-weight:bold;}

</style>
<title>Money</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body style="margin:0;">
<h1>收/支管理</h1>



<table id="tablecenter">

  <tr>
    <td align="center" width="5%">序号</td>
    <td align="center" width="15%">日期</td>
    <td align="center" width="10%">收/支</td>
    <td align="center" width="15%">类别</td>
    <td align="center" width="10%">周期</td>
    <td align="center" width="10%">花费</td>
    <td align="center" width="25%">备注</td>
    <td align="center" width="10%">操作</td>
  </tr>
  <%
  int index = 1;
 Enumeration mon = KindsMoney.find(" and member="+DbAdapter.cite(member),0,100);
  while(mon.hasMoreElements())
  {
    int id = ((Integer)mon.nextElement()).intValue();
    KindsMoney km = KindsMoney.find(id);
    Kinds k = Kinds.find(km.getKid());
    String sz = km.getSandz()==1?"支出":"收入";
    String cycle = k.getCycle()==1?"是":"否";
    String ps = km.getPs().length()>0?km.getPs():"&nbsp;";
    out.print("<tr><td align=center>"+index);
    out.print("<td align=center>"+km.getDateToString());
    out.print("<td align=center>"+sz);
    out.print("<td align=center>"+k.getKname());
    out.print("<td align=center>"+cycle);
    out.print("<td align=right>"+km.getMoney()+"&nbsp;<b>￥</b>");
    out.print("<td>"+ps);
    out.print("<td align=center id=up"+id+"><a href=# onclick=c_seat(up"+id+",wai,"+id+",'upMoney',"+km.getSandz()+","+km.getKid()+","+km.getMoney()+",'"+km.getDateToString()+"','"+km.getPs()+"');>编辑</a>&nbsp;&nbsp;<a href=# onclick=if(confirm('是否确定删除该类别？')){window.location.href='/jsp/finance/auxiliary/MoneyManage.jsp?id="+id+"&act=del';}>删除</a>");
    index++;
  }
  %>
<tr>
<td align="right" colspan="2">
收入总计：
</td>
<td colspan="3"><%=KindsMoney.sum(" and sandz=2",0,100)%>&nbsp;<b>RMB</b></td>
<td align="right">
消费总计：
</td>
<td colspan="3"><%=KindsMoney.sum(" and sandz=1",0,100)%>&nbsp;<b>RMB</b></td>
</tr>
</table>
<center>
<input type="button" value="创建" onclick="sel_hidden();"/>
</center>

<div id="wai" style="display:none">

  <h1>信息变更</h1>
  <form name="form1" action="/servlet/EditMoney" method="POST" onsubmit="return check(this);">
  <input type="hidden" name="id"/>
  <input type="hidden" name="act" value="cremoney"/>
  <table>
    <tr>
      <td>
        收入/支出：
</td>
<td>
  <input id="sr" type="radio" name="sandz" value="2" onclick="oc(this.id);"/><label for="sr">收入</label><br />
  <input id="zc" type="radio" name="sandz" value="1" onclick="oc(this.id);" checked="checked"/><label for="zc">支出</label>
</td>
    </tr>
    <tr>
      <td align="right">
        类别：
      </td>

      <td>
      <div id="k1">
        <select name="kinds1" style="width:100px">
        <option value="0">-----------</option>
        <%
        Enumeration e = Kinds.find(" and member="+DbAdapter.cite(member)+" and sandz=1",0,100);
        while(e.hasMoreElements())
        {
          int id = ((Integer)e.nextElement()).intValue();
          Kinds k = Kinds.find(id);
          out.print("<option value="+id+">"+k.getKname()+"</option>");
        }
        %>
        </select>
      </div>
      <div id="k2" style="display:none">
        <select name="kinds2" style="width:100px">
        <option value="0">-----------</option>
        <%
        Enumeration ee = Kinds.find(" and member="+DbAdapter.cite(member)+" and sandz=2",0,100);
        while(ee.hasMoreElements())
        {
          int id = ((Integer)ee.nextElement()).intValue();
          Kinds k = Kinds.find(id);
          out.print("<option value="+id+">"+k.getKname()+"</option>");
        }
        %>
        </select>
        </div>
      </td>
    </tr>
    <tr>
    <td align="right">
    花费：
    </td>
    <td>
      <input style="width:70px" type="text" name="money" value=""/>&nbsp;RMB
    </td>
    </tr>
    <tr>
    <td align="right">
    日期：
    </td>
    <td>
   <input type="TEXT" name="date" readonly="readonly" onclick="new Calendar('2008', '2010', 0,'yyyy-MM-dd').show(this);">
    </td>
    </tr>
     <tr>
      <td>
      备注：
      </td>
      <td>
        <textarea cols="30" rows="3" name="ps"></textarea>
      </td>
    </tr>
    <tr>
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="添加&修改"/>
        <input type="reset" value="重置"/>
      </td>
    </tr>
  </table>
    </form>
</div>

<script type="">
function check(form){
  return check_select()&&submitInteger(form.money,'无效-钱数')&&submitText(form.date,'无效-日期');
}

function check_select()
{
  if(document.getElementById("kinds1").value==0 &&document.getElementById("kinds2").value==0)
  {
    alert("请选择类别");
    return false;
  }
  return true;
}

function sel_hidden()
{
  var dis = document.getElementById('wai').style.display;

  if(dis=='none')
  {
    document.getElementById('wai').style.display="";
    document.form1.act.value='cremoney';
    document.form1.id.value = '';
    document.getElementById("kinds1").options[0].selected=true;
    document.getElementById("kinds2").options[0].selected=true;
    document.form1.money.value='';
    document.form1.date.value='';
    document.form1.ps.value='';
  }else
  {
    document.getElementById('wai').style.display="none";
  }
}

    var cm = null;

    function getPos(el,sProp)
    {
      var iPos = 0 ;
      　　while (el!=null)   　　
      {
        iPos+=el["offset" + sProp];
        　el = el.offsetParent;
      }
      　　return iPos;
    }
    function c_seat(id,m,ids,act,sandz,kid,money,date,ps)
    {
      document.form1.id.value = ids;
      document.form1.act.value=act;
      if(sandz=='1')
      {
        document.getElementById('zc').checked=true;
        oc('zc');
        for(var i = 0; i < 99; i ++)
      {
        if(document.getElementById("kinds1").options[i].value==kid)
        {
          document.getElementById("kinds1").options[i].selected=true;
          break;
        }
      }
      }else
      {
        document.getElementById('sr').checked=true;
        oc('sr');
        for(var i = 0; i < 99; i ++)
      {
        if(document.getElementById("kinds2").options[i].value==kid)
        {
          document.getElementById("kinds2").options[i].selected=true;
          break;
        }
      }
      }

      document.form1.money.value=money;
      document.form1.date.value=date;
      document.form1.ps.value=ps;

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left")-50;
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }

    function oc(obj)
{
  if(obj == 'sr')
  {
    document.getElementById('k2').style.display='';
    document.getElementById('k1').style.display='none';
  }
  if(obj == 'zc')
  {
    document.getElementById('k2').style.display='none';
    document.getElementById('k1').style.display='';
  }
  if(obj == 'upsr')
  {
    document.getElementById('k22').style.display='';
    document.getElementById('k11').style.display='none';
  }
  if(obj == 'upzc')
  {
    document.getElementById('k22').style.display='none';
    document.getElementById('k11').style.display='';
  }
}
</script>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>

<!-- Stock photography -->
</html>
