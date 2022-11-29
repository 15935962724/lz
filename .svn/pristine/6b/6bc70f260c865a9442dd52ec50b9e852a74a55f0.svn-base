<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="tea.entity.member.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String timestr = Laborage.getDateToString();
int mb = 0;
int laborage = 0;
if(request.getParameter("laborage")!=null && request.getParameter("laborage").length()>0)
laborage = Integer.parseInt(request.getParameter("laborage"));
if(request.getParameter("mb")!=null && request.getParameter("mb").length()>0){
  mb = Integer.parseInt(request.getParameter("mb"));
}

Laborage labobj = Laborage.find(laborage);
Laborage mbobj = Laborage.find(mb);

     String changetime=null;
     String labname=null;
     String card=null;
     int branch=0;
     int role=0;
     int bank=0;
     String bankaccounts=null;
     int months=0;
     int days=0;
     BigDecimal basiclab=null;
     BigDecimal dropheat=null;
     BigDecimal mess=null;
     BigDecimal rests=null;
     BigDecimal shouldlab=null;
     BigDecimal actuary=null;
     BigDecimal provide=null;
     BigDecimal medical=null;
     BigDecimal idleness=null;
     BigDecimal accumulation=null;
     BigDecimal housingacc=null;
     BigDecimal supplyprovidebase=null;
     int service=0;
     BigDecimal supplyprovide=null;
     BigDecimal supplymedical=null;
     BigDecimal agiobase=null;
     BigDecimal labor=null;
     float cess=0;
     BigDecimal eraagio=null;
     BigDecimal bucklefund=null;
     BigDecimal factlab=null;
     String content=null;
     int iftype=0;
     String cyclostylename=null;
     if(laborage>0)
     {
        changetime=labobj.getChangetimeToString();
        labname=labobj.getLabname();
        card=labobj.getCard();
        branch=labobj.getBranch();
        role=labobj.getRole();
        bank=labobj.getBank();
        bankaccounts=labobj.getBankaccounts();
        months=labobj.getMonths();
        days=labobj.getDays();
        basiclab=labobj.getBasiclab();
        dropheat=labobj.getDropheat();
        mess=labobj.getMess();
        rests=labobj.getRests();
        shouldlab=labobj.getShouldlab();
        actuary=labobj.getActuary();
        provide=labobj.getProvide();
        medical=labobj.getMedical();
        idleness=labobj.getIdleness();
        accumulation=labobj.getAccumulation();
        housingacc=labobj.getHousingacc();
        supplyprovidebase=labobj.getSupplyprovidebase();
        service=labobj.getService();
        supplyprovide=labobj.getSupplyprovide();
        supplymedical=labobj.getSupplymedical();
        agiobase=labobj.getAgiobase();
        labor=labobj.getLabor();
        cess=labobj.getCess();
        eraagio=labobj.getEraagio();
        bucklefund=labobj.getBucklefund();
        factlab=labobj.getFactlab();
        content=labobj.getContent();
        iftype=labobj.getIftype();
        cyclostylename=labobj.getCyclostylename();
     }



%>

<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">

  </head>
    <body>
  <h1>员工工资详细内容</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr >
          <td >转账日期：</td><td><%if(changetime!=null)out.print(changetime);else out.print(timestr);%></td>

          <td>&nbsp;</td><td>
          &nbsp;
          </td>
      </tr>
         <tr>

          <td>姓名：</td><td><% if(labname!=null){Profile p = Profile.find(labobj.getLabname()); out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));}%> </td>
          <td>身份证号：</td><td><%if(card!=null)out.print(card);%></td>
        </tr>
        <tr>

          <td>部门：</td><td><%if(branch!=0){AdminUnit auobj = AdminUnit.find(branch);out.print(auobj.getName());}%> </td>

          <td>人员类型：</td><td><% if(role!=0){AdminRole roobj = AdminRole.find(role);out.print(roobj.getName());}%>
          </td>
        </tr>
        <tr>
            <td>帐号银行:</td>
            <td><%=Laborage.BANK_TYPE[bank] %>---
             <%if(bankaccounts!=null)out.print(bankaccounts);%></td>

          <td>出勤月数：</td><td><%if(months!=0)out.print(months);if(mbobj.getMonths()!=0)out.print(mbobj.getMonths());%></td>
        </tr>
        <tr>
          <td>出勤天数：</td><td><%if(days!=0)out.print(days);if(mbobj.getDays()!=0)out.print(mbobj.getDays());%></td>

          <td>基本工资：</td><td><%if(basiclab!=null)out.print(basiclab);if(mbobj.getBasiclab()!=null)out.print(mbobj.getBasiclab());%></td>
        </tr>
          <tr>
          <td>降暑费：</td><td><%if(dropheat!=null)out.print(dropheat);if(mbobj.getDropheat()!=null)out.print(mbobj.getDropheat());%></td>

          <td>伙食补贴：</td><td><%if(mess!=null)out.print(mess);if(mbobj.getMess()!=null)out.print(mbobj.getMess());%></td>
        </tr>
          <tr>
          <td>其他：</td><td><%if(rests!=null)out.print(rests);if(mbobj.getRests()!=null)out.print(mbobj.getRests());%></td>

          <td>应发工资：</td><td><%if(shouldlab!=null)out.print(shouldlab);if(mbobj.getShouldlab()!=null)out.print(mbobj.getShouldlab());%></td>
        </tr>
           <tr>
          <td>保险基数：</td><td><%if(actuary!=null)out.print(actuary);if(mbobj.getActuary()!=null)out.print(mbobj.getActuary());%></td>

          <td>基本养老保险：</td><td><%if(provide!=null)out.print(provide);if(mbobj.getProvide()!=null)out.print(mbobj.getProvide());%></td>
        </tr>
         <tr>
          <td>基本医疗保险：</td><td><%if(medical!=null)out.print(medical);if(mbobj.getMedical()!=null)out.print(mbobj.getMedical());%></td>

          <td>失业金：</td><td><%if(idleness!=null)out.print(idleness);if(mbobj.getIdleness()!=null)out.print(mbobj.getIdleness());%></td>
        </tr>

        <tr>
          <td>公积金基数：</td><td><%if(accumulation!=null)out.print(accumulation);if(mbobj.getAccumulation()!=null)out.print(mbobj.getAccumulation());%></td>

          <td>住房公积金：</td><td><%if(housingacc!=null)out.print(housingacc);if(mbobj.getHousingacc()!=null)out.print(mbobj.getHousingacc());%></td>
        </tr>

      <tr>
          <td>补充养老保险基数：</td><td><%if(supplyprovidebase!=null)out.print(supplyprovidebase);if(mbobj.getSupplyprovidebase()!=null)out.print(mbobj.getSupplyprovidebase());%></td>

          <td>工龄：</td><td><%if(service!=0)out.print(service);if(mbobj.getService()!=0)out.print(mbobj.getService());%></td>
        </tr>
         <tr>
          <td>补充养老保险：</td><td><%if(supplyprovide!=null)out.print(supplyprovide);if(mbobj.getSupplyprovide()!=null)out.print(mbobj.getSupplyprovide());%></td>

          <td>补充医疗保险：</td><td><%if(supplymedical!=null)out.print(supplymedical);if(mbobj.getSupplymedical()!=null)out.print(mbobj.getSupplymedical());%></td>
        </tr>
        <tr>
          <td>扣税基数：</td><td><%if(agiobase!=null)out.print(agiobase);if(mbobj.getAgiobase()!=null)out.print(mbobj.getAgiobase());%></td>

          <td>劳保：</td><td><%if(labor!=null)out.print(labor);if(mbobj.getLabor()!=null)out.print(mbobj.getLabor());%></td>
        </tr>
         <tr>
          <td>税率：</td><td><%if(cess!=0)out.print(cess);if(mbobj.getCess()!=0)out.print(mbobj.getCess());%>%</td>

          <td>代扣税：</td><td><%if(eraagio!=null)out.print(eraagio);if(mbobj.getEraagio()!=null)out.print(mbobj.getEraagio());%></td>
        </tr>
        <tr>
          <td>扣款合计：</td><td><%if(bucklefund!=null)out.print(bucklefund);if(mbobj.getBucklefund()!=null)out.print(mbobj.getBucklefund());%></td>

          <td>实发工资(元)：</td><td><%if(factlab!=null)out.print(factlab);if(mbobj.getFactlab()!=null)out.print(mbobj.getFactlab());%></td>
        </tr>
         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
        <td>备注:</td><td><%if(content!=null)out.print(content);if(mbobj.getContent()!=null)out.print(mbobj.getContent());%></td>
        </tr>
         </table>

      <br>

      <input type="button" id="printbutton" value="打印" onClick="window.print();">
      <input type="button" id="c" value="关闭"  onClick="javascript:window.close();">
    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <script type="">
    //-----  下面是打印控制语句  ----------
    window.onbeforeprint=beforePrint;
    window.onafterprint=afterPrint;
    //打印之前隐藏不想打印出来的信息
    var printbutton=document.getElementById('printbutton');
    var c = document.getElementById('c');
    function beforePrint()
    {
      printbutton.style.display='none';
      c.style.display='none';
    }
    //打印之后将隐藏掉的信息再显示出来
    function afterPrint()
    {
      printbutton.style.display='';
       c.style.display='';
    }
　　</SCRIPT>
  </body>
</HTML>




