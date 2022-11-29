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

String nexturl = request.getParameter("nexturl");
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

  <script>

  function loadTo()
  {
    var loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
    var loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?community=<%=teasession._strCommunity%>&type=2&field=member&index=form1.labnames',self,'edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:300px;dialogTop:'+loc_y+'px;dialogLeft:'+loc_x+'px');

    var arr = form1.labnames.value;
     var app = arr.split("/");

      for(var i=0;i<app.length;i++)
      {
        form1.labname.value=app[0];
        form1.labnames.value=app[1];
        form1.card.value=app[2];
      }
  }


  function LoadWindow2()
  {
    URL="/jsp/admin/laborage/branch_role.jsp?type=0";
    loc_x=document.body.scrollLeft+event.clientX-event.offsetX-140;
    loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:240px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
    var app = arr.split("/");
      for(var i=0;i<app.length;i++)
      {
        form1.branch.value=app[0];
        form1.branchs.value=app[1];
      }

  }

 function LoadWindow1()
  {
    URL="/jsp/admin/laborage/branch_role.jsp?type=1";
    loc_x=document.body.scrollLeft+event.clientX-event.offsetX-140;
    loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
    var arr= window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:320px;dialogHeight:240px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
    var app = arr.split("/");
      for(var i=0;i<app.length;i++)
      {
        form1.role.value=app[0];
        form1.roles.value=app[1];
      }
  }



  function sub()
  {
    if(form1.labnames.value=='')
    {
      alert("请填写员工姓名！");
      return false;
    }
    if(form1.card.value=='')
    {
      alert("请填写员工身份证号！");
      return false;
    }
    if(form1.branchs.value=='')
    {
      alert("请填写员工部门！");
      return false;
    }
    if(form1.roles.value=='')
    {
      alert("请填写员工类型！");
      return false;
    }
    if(form1.bank.value==0)
    {
      alert("请填写银行！");
      return false;
    }
    if(form1.bankaccounts.value==0)
    {
      alert("请填写银行卡号！");
      return false;
    }
    if(form1. months.value=='')
    {
      alert("请填写出勤月数！");
      return false;
    }
    if(form1.days.value=='')
    {
      alert("请填写出勤天数！");
      return false;
    }
    if(form1.basiclab.value=='')
    {
      alert("请填写员工基本工资！");
      return false;
    }


  }
  function clear_dept()
  {
    document.form1.branch.value="";
    document.form1.branchs.value="";

  }
  function clear_dept1()
  {
    document.form1.branch.value="";
    document.form1.branchs.value="";

  }

  function rad(id)
  {

    var ewebeditor=document.all('a');
    if(id==1)
    {
       ewebeditor.style.display="";
    }
    if(id==0)
    {
       ewebeditor.style.display="none";
    }
  }

  function moban()
  {

    form1.action='/jsp/admin/laborage/EditLaborage.jsp';
    form1.submit();
  }

  </script>
    <body  onload="rad('<%=iftype%>')">
  <h1>新建员工工资</h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
    <br>

    <form name="form1" METHOD="post" action="/servlet/EditLaborage" onSubmit="return sub(this);">
      <input  type="hidden" name="nexturl" value="<%=nexturl%>"/>
      <input type="hidden" name="act" value="EditLaborage"/>
      <input type="hidden" name="laborage" value="<%=laborage%>"/>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr >
          <td >转账日期：</td><td><input name="changetime" size="7"  value="<%if(changetime!=null)out.print(changetime);else out.print(timestr);%>" readonly><A href="###"><img onclick="showCalendar('form1.changetime');" src="/tea/image/public/Calendar2.gif" align="top" ></a> </td>

          <td>模板选择</td><td>
          <select name ="mb" onchange="moban()"> );">
          <option value ="0">-------</option>
                   <%
                           if(laborage==0){
                             java.util.Enumeration e = Laborage.find(teasession._strCommunity," and iftype=1",0,Integer.MAX_VALUE);
                             while(e.hasMoreElements())
                             {
                               int lab = ((Integer)e.nextElement()).intValue();
                               Laborage obj = Laborage.find(lab);

                               out.print("<option value="+lab);
                               out.print(">"+obj.getCyclostylename());
                               out.print("</option>");
                             }
                           }
                   %>
          </select>
          </td>
      </tr>
         <tr>

          <td>姓名：</td><td><input  type="text" name="labnames" value="<% if(labname!=null){Profile p = Profile.find(labobj.getLabname()); out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));}%>" size="20" readonly>
            <input type="button" name="" value="添加" onClick="loadTo();" >
            <input type="button" name="" value="清空" onClick="clear_dept1();">
            <input type="hidden" name="labname" value="<%=labobj.getLabname()%>"/>
          </td>
          <td>身份证号：</td><td><input type="text" name="card" value="<%if(card!=null)out.print(card);%>" size=30></td>


        </tr>
        <tr>

          <td>部门：</td><td><input type="text" name="branchs" value="<%if(branch!=0){AdminUnit auobj = AdminUnit.find(branch);out.print(auobj.getName());}%>"   readonly>

            <input type="button" name="" value="添加" onClick="LoadWindow2();" >
            <input type="button" name="" value="清空" onClick="clear_dept();">
            <input type="hidden"  value="<%=branch%>" name="branch">

          </td>

          <td>人员类型：</td><td><input type="text" name="roles" value="<% if(role!=0){AdminRole roobj = AdminRole.find(role);out.print(roobj.getName());}%>"   readonly>

            <input type="button" name="" value="添加" onClick="LoadWindow1();" >
            <input type="button" name="" value="清空" onClick="clear_dept();">
            <input type="hidden"  value="<%=role%>" name="role" >
          </td>
        </tr>
        <tr>
            <td>帐号银行:</td>
            <td><select name="bank">
              <%
                   for(int i=0;i<Laborage.BANK_TYPE.length;i++)
                   {
                     out.print("<option value="+i);
                     if(bank==i)
                         out.print(" selected");
                    out.print(">"+Laborage.BANK_TYPE[i]);
                    out.print("</option>");
                   }
              %>

             </select><input type="text" name="bankaccounts" value="<%if(bankaccounts!=null)out.print(bankaccounts);%>" size=30></td>

          <td>出勤月数：</td><td><input type="text" name="months" value="<%if(months!=0)out.print(months);if(mbobj.getMonths()!=0)out.print(mbobj.getMonths());%>"></td>
        </tr>
        <tr>
          <td>出勤天数：</td><td><input type="text" name="days" value="<%if(days!=0)out.print(days);if(mbobj.getDays()!=0)out.print(mbobj.getDays());%>" ></td>

          <td>基本工资：</td><td><input type="text" name="basiclab" value="<%if(basiclab!=null)out.print(basiclab);if(mbobj.getBasiclab()!=null)out.print(mbobj.getBasiclab());%>" ></td>
        </tr>
          <tr>
          <td>降暑费：</td><td><input type="text" name="dropheat" value="<%if(dropheat!=null)out.print(dropheat);if(mbobj.getDropheat()!=null)out.print(mbobj.getDropheat());%>" ></td>

          <td>伙食补贴：</td><td><input type="text" name="mess" value="<%if(mess!=null)out.print(mess);if(mbobj.getMess()!=null)out.print(mbobj.getMess());%>" ></td>
        </tr>
          <tr>
          <td>其他：</td><td><input type="text" name="rests" value="<%if(rests!=null)out.print(rests);if(mbobj.getRests()!=null)out.print(mbobj.getRests());%>" ></td>

          <td>应发工资：</td><td><input type="text" name="shouldlab" value="<%if(shouldlab!=null)out.print(shouldlab);if(mbobj.getShouldlab()!=null)out.print(mbobj.getShouldlab());%>" ></td>
        </tr>
           <tr>
          <td>保险基数：</td><td><input type="text" name="actuary" value="<%if(actuary!=null)out.print(actuary);if(mbobj.getActuary()!=null)out.print(mbobj.getActuary());%>" ></td>

          <td>基本养老保险：</td><td><input type="text" name="provide" value="<%if(provide!=null)out.print(provide);if(mbobj.getProvide()!=null)out.print(mbobj.getProvide());%>" ></td>
        </tr>
         <tr>
          <td>基本医疗保险：</td><td><input type="text" name="medical" value="<%if(medical!=null)out.print(medical);if(mbobj.getMedical()!=null)out.print(mbobj.getMedical());%>" ></td>

          <td>失业金：</td><td><input type="text" name="idleness" value="<%if(idleness!=null)out.print(idleness);if(mbobj.getIdleness()!=null)out.print(mbobj.getIdleness());%>" ></td>
        </tr>

        <tr>
          <td>公积金基数：</td><td><input type="text" name="accumulation" value="<%if(accumulation!=null)out.print(accumulation);if(mbobj.getAccumulation()!=null)out.print(mbobj.getAccumulation());%>" ></td>

          <td>住房公积金：</td><td><input type="text" name="housingacc" value="<%if(housingacc!=null)out.print(housingacc);if(mbobj.getHousingacc()!=null)out.print(mbobj.getHousingacc());%>" ></td>
        </tr>

      <tr>
          <td>补充养老保险基数：</td><td><input type="text" name="supplyprovidebase" value="<%if(supplyprovidebase!=null)out.print(supplyprovidebase);if(mbobj.getSupplyprovidebase()!=null)out.print(mbobj.getSupplyprovidebase());%>" ></td>

          <td>工龄：</td><td><input type="text" name="service" value="<%if(service!=0)out.print(service);if(mbobj.getService()!=0)out.print(mbobj.getService());%>" ></td>
        </tr>
         <tr>
          <td>补充养老保险：</td><td><input type="text" name="supplyprovide" value="<%if(supplyprovide!=null)out.print(supplyprovide);if(mbobj.getSupplyprovide()!=null)out.print(mbobj.getSupplyprovide());%>" ></td>

          <td>补充医疗保险：</td><td><input type="text" name="supplymedical" value="<%if(supplymedical!=null)out.print(supplymedical);if(mbobj.getSupplymedical()!=null)out.print(mbobj.getSupplymedical());%>" ></td>
        </tr>
        <tr>
          <td>扣税基数：</td><td><input type="text" name="agiobase" value="<%if(agiobase!=null)out.print(agiobase);if(mbobj.getAgiobase()!=null)out.print(mbobj.getAgiobase());%>" ></td>

          <td>劳保：</td><td><input type="text" name="labor" value="<%if(labor!=null)out.print(labor);if(mbobj.getLabor()!=null)out.print(mbobj.getLabor());%>" ></td>
        </tr>
         <tr>
          <td>税率：</td><td><input type="text" name="cess" value="<%if(cess!=0)out.print(cess);if(mbobj.getCess()!=0)out.print(mbobj.getCess());%>" >%</td>

          <td>代扣税：</td><td><input type="text" name="eraagio" value="<%if(eraagio!=null)out.print(eraagio);if(mbobj.getEraagio()!=null)out.print(mbobj.getEraagio());%>" ></td>
        </tr>
        <tr>
          <td>扣款合计：</td><td><input type="text" name="bucklefund" value="<%if(bucklefund!=null)out.print(bucklefund);if(mbobj.getBucklefund()!=null)out.print(mbobj.getBucklefund());%>" ></td>

          <td>实发工资(元)：</td><td><input type="text" name="factlab" value="<%if(factlab!=null)out.print(factlab);if(mbobj.getFactlab()!=null)out.print(mbobj.getFactlab());%>" ></td>
        </tr>
         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
        <td>备注:</td><td><textarea cols=50 name="content" rows=2  title="备注" ><%if(content!=null)out.print(content);if(mbobj.getContent()!=null)out.print(mbobj.getContent());%></textarea></td>
        </tr>
         </table>
         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>是否设为工资模板：</td><td>
            是<input name="iftype" type="radio" value="1" onclick ="rad('1');" <%if(iftype==1)out.print("checked");%> />
            否<input name="iftype" type="radio" value="0" onclick ="rad('0');" <%if(iftype==0)out.print("checked");%>/>
            <span id="a" style="display:none">请输入模板的名字:<input type="text" name="cyclostylename" value="<%if(cyclostylename!=null)out.print(cyclostylename);%>" ></span>
          </td>
        </tr>

         </table>
      <br>
      <input type="Submit" name="Submit1" value="保存并继续添加"> <input type="Submit" name="Submit1" value="保存"><input type="reset" name="" value="重填" >
      <input type="button" name="" value="返回" onClick="location='/jsp/admin/laborage/laborage.jsp'" >
    </FORM>

    <br>
   <div id="head6"><img height="6" src="about:blank" alt=""></div>
  </body>
</HTML>




