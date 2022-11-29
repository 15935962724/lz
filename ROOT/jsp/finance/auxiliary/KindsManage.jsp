<%@ page contentType="text/html; charset=UTF-8" %>
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
    Kinds.del(id);
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
<title>添加收/支类别</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body style="margin:0;">
<h1>类别管理</h1>


<table id="tablecenter">

  <tr>
    <td>序号</td>
    <td>类别</td>
    <td>收/支</td>
    <td>周期性</td>
    <td>备注</td>
    <td>操作</td>
  </tr>
  <%
  int index = 1;
  Enumeration e = Kinds.find(" and member="+DbAdapter.cite(member),0,100);
  while(e.hasMoreElements())
  {
    int id = ((Integer)e.nextElement()).intValue();
    Kinds k = Kinds.find(id);
    String sz = k.getSandz()==1?"支出":"收入";
    String cc = k.getCycle()==1?"是":"否";
    String ps = k.getPs().length()>0?k.getPs():"&nbsp;";
    out.print("<tr><td>"+index);
    out.print("<td>"+k.getKname());
    out.print("<td>"+sz);
    out.print("<td>"+cc);
    out.print("<td>"+ps);
    out.print("<td id=up"+id+"><a href=# onclick=c_seat(up"+id+",uper,"+id+",'"+k.getSandz()+"','"+k.getKname()+"','"+k.getCycle()+"','"+k.getPs()+"');>编辑</a>&nbsp;&nbsp;<a href=# onclick=if(confirm('是否确定删除该类别？')){window.location.href='/jsp/finance/auxiliary/KindsManage.jsp?id="+id+"&act=del';}>删除</a>");
    index++;
  }
  %>

</table>
<center>
<input type="button" value="创建" onclick="sel_hidden();"/>
</center>
<div id="uper" style="display:none;width:350px;position:absolute;z-index:99;background-color:#E0EDFE;">
 <h1>编辑收/支类别</h1>
  <form name="bjform" action="/servlet/EditMoney" method="POST" onsubmit="return check(this);">
  <input type="hidden" name="act" value="uper"/>
  <input type="hidden" name="id"/>
  <table>
    <tr>
      <td>
      收入/支出：
      </td>
      <td>
        <input id="upsr" type="radio" name="sandz" value="2"/><label for="upsr">收入</label><br />
        <input id="upzc" type="radio" name="sandz" value="1"/><label for="upzc">支出</label>
      </td>
    </tr>
    <tr>
      <td>
      类别：
      </td>
      <td>
        <input type="text" name="kinds"/>&nbsp;
        <input id="cl1" type="checkbox" name="cycle" value="1"/>&nbsp;&nbsp;<label for="cl1">是否为周期性</label>
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
      <td colspan="2" align="center">
        <input type="submit" value="修改"/>
        <input type="reset" value="重置"/>
      </td>
    </tr>
  </table>
  </form>
</div>

<div id="wai" style="display:none">
  <h1>添加收/支类别</h1>
  <form name="form1" action="/servlet/EditMoney" method="POST" onsubmit="return check(this);">
  <input type="hidden" name="act" value="kid"/>
  <table>
    <tr>
      <td>
      收入/支出：
      </td>
      <td>
        <input id="sr" type="radio" name="sandz" value="2"/><label for="sr">收入</label><br />
        <input id="zc" type="radio" name="sandz" value="1" checked="checked"/><label for="zc">支出</label>
      </td>
    </tr>
    <tr>
      <td>
      类别：
      </td>
      <td>
        <input id="kd" type="text" name="kinds"/>&nbsp;
        <input id="cl" type="checkbox" name="cycle" value="1"/>&nbsp;&nbsp;<label for="cl">是否为周期性</label>
      </td>
    </tr>
    <tr>
      <td>
      备注：
      </td>
      <td>
        <textarea id="ps" cols="30" rows="3" name="ps"></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="添加"/>
        <input type="reset" value="重置"/>
      </td>
    </tr>
  </table>
  </form>
</div>

<script type="">
function check(form){
  return submitText(form.kinds,'请输入收支类别');
}
function sel_hidden()
{
  var dis = document.getElementById('wai').style.display;

  if(dis=='none')
  {
    document.getElementById('wai').style.display="";
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
    function c_seat(id,m,ids,sandz,kname,cycle,ps)
    {
      document.bjform.id.value=ids;
      if(sandz=='1')
      {
        document.getElementById('upzc').checked=true;
      }else
      {
        document.getElementById('upsr').checked=true;
      }
      if(cycle=='1')
      {
        document.bjform.cycle.checked=true;
      }
      document.bjform.kinds.value=kname;
      document.bjform.ps.value=ps;
      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left")+40;
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight-18;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }
</script>
</body>

<!-- Stock photography -->
</html>
