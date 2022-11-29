<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.Calendar" %><%@ page import="tea.entity.node.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
String community=teasession._strCommunity;
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String num="0";// 不同参数代表的意识   0 总部添加或修改加盟点信息。1 分店修改分店信息
if(teasession.getParameter("num")!=null)
{
  num=teasession.getParameter("num");
}
int idss =0;
if(teasession.getParameter("idss")!=null && teasession.getParameter("idss").length()>0)
{
  idss = Integer.parseInt(teasession.getParameter("idss"));
}

Date datenew  = new Date();
Calendar cc = Calendar.getInstance();
cc.setTime(datenew);

int lsaddtype=0;
int bumenx=0;
boolean falg=false;
if(teasession.getParameter("lsaddtype")!=null && teasession.getParameter("lsaddtype").length()>0)
{
  lsaddtype = Integer.parseInt(teasession.getParameter("lsaddtype"));

  AdminUsrRole adminobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  bumenx=adminobj.getUnit();
  idss= LeagueShop.findid(adminobj.getUnit());
  if(idss==0)
  {
    response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
    return;
  }
  LeagueShop leaobjfg = LeagueShop.find(idss);
  leaobjfg.getLstype();
  falg=true;
}
LeagueShop leaobj = LeagueShop.find(idss);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>新会员注册</title>
<script language="JavaScript" src="calendar.js"></script>
<script language="javascript">

function being()
{
  var userReg = /^[\u0391-\uFFE5]+$/;
  if(document.form3.lsname.value=="")
  {
    show.innerHTML="请填写用户名";
    show.style.color='red';
    return false;
  }

  var strtt = document.form3.lsname.value.replace(/[ ]/g,"");

  var idss = document.form3.idss.value.replace(/[ ]/g,"");
  sendx("/jsp/leagueshop/LeagueShop_ajax.jsp?act=cunzai&ids="+idss+"&lsname="+encodeURIComponent(strtt,"UTF-8"),member_show);
}

function member_show(v)
{
  if(v.indexOf('true')!=-1)
  {
    show.innerHTML="您的分店名称还没有被占用，您可以使用！";
    show.style.color='green';
  }else
  {
    show.innerHTML="分店名称已经被使用！";
    show.style.color='red';
  }
}
function checkuser(){

  if(document.form3.lsname.value==""){
    document.form3.lsname.focus();
    alert("分店名称不能为空！");
    return false;
  }
  if (document.form3.lsbusiness.value==""){
    document.form3.lsbusiness.focus();
    alert("营业执照注册店名不能为空！");
    return false;
  }
  if (document.form3.health.value==""){
    document.form3.health.focus();
    alert("卫生登记证书不能为空！");
    return false;
  }
  if (document.form3.legalperson.value==""){
    document.form3.legalperson.focus();
    alert("法人不能为空！");
    return false;
  }
  if (document.form3.buytype.value==""){
    document.form3.buytype.focus();
    alert("经营性质不能为空！");
    return false;
  }
  if (document.form3.s1.value==""){
    document.form3.s1.focus();
    alert("省不能为空！");
    return false;
  }
  if (document.form3.s2.value==""){
    document.form3.s2.focus();
    alert("市不能为空！");
    return false;
  }
  if (document.form3.region.value==""){
    document.form3.region.focus();
    alert("区不能为空！");
    return false;
  }
  if (document.form3.port.value==""){
    document.form3.port.focus();
    alert("巷不能为空！");
    return false;
  }
  if (document.form3.number.value==""){
    document.form3.number.focus();
    alert("号不能为空！");
    return false;
  }
  if (document.form3.tel.value==""){
    document.form3.tel.focus();
    alert("营业电话不能为空！");
    return false;
  }
  if (document.form3.lsbuyname.value==""){
    document.form3.lsbuyname.focus();
    alert("加盟商姓名不能为空！");
    return false;
  }
  if (document.form3.lsbuytel.value==""){
    document.form3.lsbuytel.focus();
    alert("加盟商手机不能为空！");
    return false;
  }
  if (document.form3.csarea.value==""){
    document.form3.csarea.focus();
    alert("所属区域不能为空！");
    return false;
  }
  if (document.form3.lsstype.value==""){
    document.form3.lsstype.focus();
    alert("请选择加盟级别！");
    return false;
  }
  if (document.form3.lsstype.value==""||document.form3.lsstype.value=="0" ){
    document.form3.lsstype.focus();
    alert("请选择加盟级别！");
    return false;
  }
  if (document.form3.adddate.value==""){
    document.form3.adddate.focus();
    alert("加盟时间不能为空！");
    return false;
  }
  if (document.form3.startdate.value==""){
    document.form3.startdate.focus();
    alert("开业时间不能为空！");
    return false;
  }
  if (document.form3.bednum.value==""){
    document.form3.bednum.focus();
    alert("美容床数不能为空！");
    return false;
  }
}
var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=leagueshop&value="+v,f_change);
}
function f_change(d)
{

  //  alert(d);
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "lsstype":
    form3.lsstype.value="<%=leaobj.getLsstype()%>";
    break;
  }
}
function f_load()
{
  form3.lstype.onchange();
}

function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+240;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:400px;dialogHeight:600px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/leagueshop/leagueShopbumen.jsp";
   var rs=window.showModalDialog(url,self,sFeatures);
    if(rs!=null)
  {
   document.all.bumen.value= rs;
  }
}

</script>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../about/style.css" rel="stylesheet" type="text/css" />
</head>




<%
if(!falg)
{
  %>
  <body onLoad="f_load()">
  <%
  }
  else
  {
    %>
    <body>
    <%
    }

    %>
    <h1>
    分店
    </h1>
    <h2>连锁体系登记表</h2>
    <form name="form3" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">


    <input type="hidden" name="idss" value="<%=idss%>" />
    <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <%
    if(lsaddtype==1 && idss!=0)
    {
      AdminUnit obja=AdminUnit.find(bumenx);
      %>
      <input type="hidden" name="bumen" value="<%=leaobj.getBumen()%>" />
      <input type="hidden" name="act" value="EditLeagueShop2" />
      <%
      }
      else
      {
        %>
        <input type="hidden" name="act" value="EditLeagueShop" />
        <tr><td height="30" align="right" nowrap="nowrap">关联内网部门：</td>
          <td>
            <select name="bumen">
            <%
            Enumeration e = AdminUnit.findByCommunity(community,"");
            for(int j=0;e.hasMoreElements();j++)
            {
              AdminUnit obja=(AdminUnit)e.nextElement();
              int id=obja.getId();
              out.print("<option value="+id);
              if(leaobj.getBumen()==id)
              {
                out.print(" selected ");
              }
              out.print(">"+obja.getPrefix()+obja.getName());
              out.print("</option>");
            }
            %>
            </select>　
            <input type="button" value="查询" onclick="Loadnew(form3.bumen);" />（必填）</td>
</tr>
<%
}
%>

<tr>
  <td height="30" nowrap="nowrap" align="right">分店名称：</td><td>
    <input name="lsname" type="text"  onBlur="being()"  size="30" value="<%if(leaobj.getLsname()!=null)out.print(leaobj.getLsname());%>" />   <span id="show" style="margin-left:5px;"></span>  （必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">营业执照注册店名：</td><td>
    <input name="lsbusiness" type="text"  size="30" value="<%if(leaobj.getLsbusiness()!=null)out.print(leaobj.getLsbusiness());%>" />（必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">卫生登记证书：</td><td>
    <input name="health" type="text" size="30"  value="<%if(leaobj.getHealth()!=null)out.print(leaobj.getHealth());%>"/>（必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">法人：</td><td>
    <input name="legalperson" type="text"  size="15" value="<%if(leaobj.getLegalperson()!=null)out.print(leaobj.getLegalperson());%>" />（必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">经营性质：</td><td>
    <input name="buytype" type="text"  size="25" value="<%if(leaobj.getBuytype()!=null)out.print(leaobj.getBuytype());%>" /> （必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">营业地址：</td><td>
    <script src="/tea/card.js" type=""></script>
    <script type="">
    var delcct=new Array();
    function f_area(objcct)
    {
      var rscct=area[parseInt(objcct.value)][1];
      var op=form3.s1.options;
      for(var i=0;i<delcct.length;i++)
      {
        op[op.length]=new Option(delcct[i][0],delcct[i][1]);
      }
      delcct=new Array();
      for(var i=0;i<op.length;i++)
      {
        if(rscct.indexOf(op[i].value)==-1)
        {
          delcct[delcct.length]=new Array(op[i].text,op[i].value);
          op[i--]=null;
        }
      }
    }
    document.write("<select name='csarea' onchange=f_area(this)>");
    for(var i=0;i<area.length;i++)
    {
      document.write("<option value="+i+">"+area[i][0]+"</option>");
    }
    document.write("</select>　");
    selectcard("s1","s2",null,"<%=leaobj.getCity()%>");
    form3.csarea.value="<%=leaobj.getCsarea()%>";
    form3.csarea.onchange();
    </script>
    <br>
    <input name="region" type="text"  size="10" value="<%if(leaobj.getRegion()!=null)out.print(leaobj.getRegion());%>" />
    区
    <input name="port" type="text" size="15" value="<%if(leaobj.getPort()!=null)out.print(leaobj.getPort());%>" />
    巷
    <input name="number" type="text"  size="10" value="<%if(leaobj.getNumber()!=null)out.print(leaobj.getNumber());%>" />
    号 （必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">营业电话：</td><td>
    <input name="tel" type="text" value="<%if(leaobj.getTel()!=null)out.print(leaobj.getTel());%>"/>
    （必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">加盟商姓名：</td><td>
    <input name="lsbuyname" type="text"   size="12" value="<%if(leaobj.getLsbuyname()!=null)out.print(leaobj.getLsbuyname());%>" />
    <%
    for(int i=0;i<LeagueShop.SHOWSEX.length;i++)
    {
      out.print("<input type=radio name=lsbuysex value="+i);
      if(i==leaobj.getLsbuysex())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.SHOWSEX[i]+"　");
    }
    %>
    手机电话：
    <input name="lsbuytel" type="text" value="<%if(leaobj.getLsbuytel()!=null)out.print(leaobj.getLsbuytel());%>"  mask="float" maxlength="11"/>
    (必填）</td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">加盟商最高学历：</td><td>
    <input name="lsbuyschool" type="text"  value="<%if(leaobj.getLsbuyschool()!=null)out.print(leaobj.getLsbuyschool());%>"/></td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">加盟前所从事的职业：</td><td>
    <input name="lsbuyjob" type="text"    value="<%if(leaobj.getLsbuyjob()!=null)out.print(leaobj.getLsbuyjob());%>"/>
    职务
    <input name="lsbuypost" type="text"    value="<%if(leaobj.getLsbuypost()!=null)out.print(leaobj.getLsbuypost());%>"/></td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">是否专职经营连锁店：</td><td>
  <%
  for(int i=0;i<LeagueShop.FALGS.length;i++)
  {
    out.print("<input type=radio name=lsbuycsfalg value="+i);
    if(i==leaobj.getLsbuycsfalg())
    {
      out.print("  checked ");
    }
    out.print(">"+LeagueShop.FALGS[i]+"　");
  }
  %>
  </td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">店长姓名：</td><td>
    <input name="shopkeepername" type="text"  value="<%if(leaobj.getShopkeepername()!=null)out.print(leaobj.getShopkeepername());%>" size="12" />
    <%
    for(int i=0;i<LeagueShop.SHOWSEX.length;i++)
    {
      out.print("<input type=radio name=sksex value="+i);
      if(i==leaobj.getSksex())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.SHOWSEX[i]+"　");
    }
    %>
    手机电话：
    <input name="sktel" type="text" value="<%if(leaobj.getSktel()!=null)out.print(leaobj.getSktel());%>"  mask="float" maxlength="11"/></td>
</tr>
<tr>
  <td height="30" nowrap="nowrap" align="right">店长最高学历：</td><td>
    <input name="skschool" type="text"  size="12" value="<%if(leaobj.getSkschool()!=null)out.print(leaobj.getSkschool());%>" /></td>
</tr>
<tr>
  <td height="30" align="right">加盟前所从事的职事：</td><td>
    <input name="skjob" type="text"  value="<%if(leaobj.getSkjob()!=null)out.print(leaobj.getSkjob());%>"/>
    职务
    <input name="skpost" type="text"  value="<%if(leaobj.getSkpost()!=null)out.print(leaobj.getSkpost());%>" /></td>
</tr>
</table>
<h2>连锁店基本信息</h2>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr>
    <td align="right" nowrap="nowrap">
    <%
    if(lsaddtype==1 && idss!=0)
    {
      LeagueShopServer lst = LeagueShopServer.find(leaobj.getLsstype());
      %>
      加盟级别：</td><td>
        <input type="hidden" name="lstype" value="<%=leaobj.getLstype()%>" />
        <input type="hidden" name="lsstype" value="<%=leaobj.getLsstype()%>" />
        <%
        out.print(""+lst.getLssname()+"　　　");
      }
      else
      {
        %>

        <div align="right">加盟类型：</div></td><td>
          <select  name="lstype" onChange="f_ajax(value,'lsstype')"><option  value="0">-------</option>
          <%
          Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,8);
          for(int i=0;eu.hasMoreElements();i++)
          {
            int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
            LeagueShopType objty = LeagueShopType.find(idtt);
            out.print("<option value="+idtt);
            if(leaobj.getLstype()==idtt)
            {
              out.print(" selected ");
            }
            out.print(">"+objty.getLstypename()+"</option>");
          }
          %>
          </select>　
          级别<select name="lsstype" ><option value="0" >-------</option><option value="5000">其他</option>
</select>　
<%
}
%>
加盟时间<input name="adddate" size="7"  value="<%if(leaobj.getAdddate()!=null)out.print(leaobj.getAdddateToString());%>"><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2004', '<%=cc.get(cc.YEAR)%>', 0,'yyyy-MM-dd').show(adddate);" alt="" />
      （必填）</td>
  </tr>
  <tr>
  <td height="30" nowrap="nowrap" align="right">分店关联的品牌：</td><td>

<%
if(lsaddtype==1 && idss!=0)
    {
      int j=0;
        java.util.Enumeration enumer=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        if(!enumer.hasMoreElements())
        {
          out.print("暂无品牌信息");

        }
        for(int i=0;enumer.hasMoreElements();i++)
        {
          int bid=Integer.parseInt(String.valueOf(enumer.nextElement()));
          Brand bobj = Brand.find(bid);
          j = Brand.countByCommunity(teasession._strCommunity,"");
          if(j>0)
          {
            j =j-1;
          }

          if(leaobj.getBrands()!=null && leaobj.getBrands().length()>0)
          {
            if(leaobj.getBrands().indexOf(String.valueOf(bid))!=-1)
            {
              out.print(bobj.getName(teasession._nLanguage)+"  ");
            }
          }
        }
      }
      else
      {
        int j=0;
        java.util.Enumeration enumer=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        if(!enumer.hasMoreElements())
        {
          out.print("暂无品牌信息");

        }
        for(int i=0;enumer.hasMoreElements();i++)
        {
          int bid=Integer.parseInt(String.valueOf(enumer.nextElement()));
          Brand bobj = Brand.find(bid);
          j = Brand.countByCommunity(teasession._strCommunity,"");
          if(j>0)
          {
            j =j-1;
          }
          out.print("<input type=checkbox name=brands"+i+" value="+bid);
          if(leaobj.getBrands()!=null && leaobj.getBrands().length()>0)
          {
            if(leaobj.getBrands().indexOf(String.valueOf(bid))!=-1)
            {
              out.print("  checked ");
            }
          }
          out.print(" /> "+bobj.getName(teasession._nLanguage)+"　");
        }
      }
%></td>

  </tr>


  <tr>
    <td height="30" nowrap="nowrap" align="right">开业时间：</td><td>
      <input name="startdate" size="7"  value="<%if(leaobj.getStartdate()!=null)out.print(leaobj.getStartdateToString());%>"><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('2004', '<%=cc.get(cc.YEAR)%>', 0,'yyyy-MM-dd').show(startdate);" alt="" />

      美容床数：
      <input name="bednum" type="text" id="bednum" value="<%if(leaobj.getBednum()!=null)out.print(leaobj.getBednum());%>"  mask="float" maxlength="4"/>
      张（必填）</td>
  </tr>
  <tr>
    <td height="30" nowrap="nowrap" align="right">经营面积：</td><td>
      <input name="shoparea" type="text"  id="shoparea" value="<%if(leaobj.getShoparea()!=null)out.print(leaobj.getShoparea());%>" />
      是否有SPA：
      <%
      for(int i=0;i<LeagueShop.YESNO.length;i++)
      {
        out.print("<input type=radio name=spa value="+i);
        if(i==leaobj.getComputernum())
        {
          out.print("  checked ");
        }
        out.print(">"+LeagueShop.YESNO[i]+"　");
      }
      %>
    </td>
  </tr>
  <tr>
    <td height="30" nowrap="nowrap" align="right">店长：</td><td>
      <input name="shopkeeper" type="text"   size="8"  value="<%if(leaobj.getShopkeeper()!=null)out.print(leaobj.getShopkeeper());%>" mask="float" maxlength="4"/>
      人 　　前台顾问
      <input name="adviser" type="text" size="8"  value="<%if(leaobj.getAdviser()!=null)out.print(leaobj.getAdviser());%>" mask="float" maxlength="4"/>
      人 　　　美容师
      <input name="hairdresser" type="text" size="8"  value="<%if(leaobj.getHairdresser()!=null)out.print(leaobj.getHairdresser());%>" mask="float" maxlength="4"/>
      人</td>
  </tr>
  <tr>
    <td height="30" nowrap="nowrap" align="right">固定（办卡）会员：</td><td>
      <input name="fixmember" type="text" value="<%if(leaobj.getFixmember()!=null)out.print(leaobj.getFixmember());%>" mask="float" maxlength="4"/>
      流动顾客：约
      <input name="movemember" type="text"  value="<%if(leaobj.getMovemember()!=null)out.print(leaobj.getMovemember());%>" mask="float" maxlength="4"/>
      人</td>
  </tr>
  <tr>
    <td height="30" align="right">连锁店是否有电脑：</td><td>
    <%
    for(int i=0;i<LeagueShop.FALGS.length;i++)
    {
      out.print("<input type=radio name=computernum value="+i);
      if(i==leaobj.getComputernum())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.FALGS[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30" nowrap="nowrap" align="right">是否有网络连接：</td><td>
    <%
    for(int i=0;i<LeagueShop.FALGS.length;i++)
    {
      out.print("<input type=radio name=network value="+i);
      if(i==leaobj.getNetwork())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.FALGS[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30" align="right" nowrap>上网方式：</td><td>

    <%
    for(int i=0;i<LeagueShop.INTERNETTYPES.length;i++)
    {
      out.print("<input type=radio name=internettype value="+i);
      if(i==leaobj.getInternettype())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.INTERNETTYPES[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30" align="right" nowrap="nowrap">是否能操作内部会员系统：</td><td>

    <%
    for(int i=0;i<LeagueShop.FALGS.length;i++)
    {
      out.print("<input type=radio name=systemtype value="+i);
      if(i==leaobj.getSystemtype())
      {
        out.print("  checked ");
      }
      out.print(">"+LeagueShop.FALGS[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr><td></td>
    <td>　　　　　　　　　　　　　　　　　
      <input name="Submit4" type="submit" class="input3" value="提交" onClick="return checkuser();" />　
      <input name="Submit5" type="reset" class="input3" value="重填"  />　
      <input type=button value="返回" onClick="javascript:history.back()"/></td>
</tr>
</table>

    </form>
    </body>
    <%@include file="/jsp/include/Calendar4.jsp" %>
</html>

