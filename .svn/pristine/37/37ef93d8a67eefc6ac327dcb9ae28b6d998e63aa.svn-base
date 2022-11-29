<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SOrder");
String community=node.getCommunity();


boolean NewNode=request.getParameter("NewNode")!=null;
if(request.getParameter("destine")!=null)
{
  java.util.Enumeration fbt_enumer= tea.entity.node.Node.findByType(1,node.getCommunity());
  while(fbt_enumer.hasMoreElements())
  {
    int node_id=((Integer)fbt_enumer.nextElement()).intValue();
    if(tea.entity.node.Category.find(node_id).getCategory()==66)
    {
      NewNode=true;
      teasession._nNode=node_id;
      node=tea.entity.node.Node.find(node_id);
    }
  }
  if(!fbt_enumer.hasMoreElements()&&!NewNode)
  {
    out.print(new tea.html.Script("alert('对不起,还没有创建 服务订单别,请通知管理员');history.back();"));
    return;
  }
}

String member=node.getCreator().toString();
tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);

tea.entity.node.SOrder so_obj=     tea.entity.node.SOrder.find(teasession._nNode,teasession._nLanguage);
String Preview="";
String    educateParam="";
boolean edit=true;
String subject=null,phone=null;

{
  Preview="<A href=/jsp/type/resume/Preview.jsp?node="+teasession._nNode+" style=color=#ffffff target=_blank >预览简历</A>";
  educateParam="Node="+teasession._nNode;

  subject=node.getSubject(teasession._nLanguage);
  phone=so_obj.getPhone();
}





java.util.Enumeration enumer=tea.entity.node.Node.findByType(65,node.getCommunity());
StringBuffer sb=new StringBuffer("<option value=\"0\">---请选择---");
StringBuffer script=new StringBuffer("function fprice(select,count,price,sum,input_unit,unitprice){\r\n  switch(select.options[select.selectedIndex].value){");
script.append("case '0':unitprice.value='0'; price.value=0*parseFloat(count.value);input_unit.value='';break;\r\n");
while(enumer.hasMoreElements())
{
  int i=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Service ser=  tea.entity.node.Service.find(i,teasession._nLanguage);
  if(ser.isExists())
  {
    sb.append("<option value="+i);
    sb.append(">"+tea.entity.node.Node.find(i).getSubject(teasession._nLanguage)+"</option>");
    script.append("case '"+i+"':unitprice.value='"+ser.getPrice().toString()+"'; price.value="+ser.getPrice().toString()+"*parseFloat(count.value);input_unit.value='"+ser.getUnit()+"';break;\r\n");
  }
}
script.append("}form1.sumcash.value=0;form1.sumbank.value=0;");
if(so_obj.getPtype()==1)//如果是易洁卡支付
{
  script.append("for(index=0;index<form1.price.length;index++)if(!isNaN(parseFloat(form1.price[index].value)))form1.sumbank.value=parseFloat(form1.sumbank.value)+parseFloat(form1.price[index].value);");
  script.append("form1.balance1.value=form1.balance.value-form1.sumbank.value;");
}else
{
  script.append("for(index=0;index<form1.price.length;index++)if(!isNaN(parseFloat(form1.price[index].value)))form1.sumcash.value=parseFloat(form1.sumcash.value)+parseFloat(form1.price[index].value);");
  script.append("form1.balance1.value=form1.balance.value;");
}
script.append("form1.asumcash.value=0;form1.asumbank.value='0';if(form1.aptype.value==1)"+
"{  "+
"   for(index=0;index<form1.aprice.length;index++)if(!isNaN(parseFloat(form1.aprice[index].value)))form1.asumbank.value=parseFloat(form1.asumbank.value)+parseFloat(form1.aprice[index].value);form1.asumbank.value=parseFloat(form1.asumbank.value)+parseFloat(form1.sumbank.value);"+
"   form1.balance2.value=form1.balance.value-form1.asumbank.value;"+
"}else{"+
"form1.asumcash.value=0;form1.asumbank.value='0';for(index=0;index<form1.aprice.length;index++)if(!isNaN(parseFloat(form1.aprice[index].value)))form1.asumcash.value=parseFloat(form1.asumcash.value)+parseFloat(form1.aprice[index].value);form1.asumcash.value=parseFloat(form1.asumcash.value)+parseFloat(form1.sumcash.value);"+
"   form1.balance2.value=form1.balance1.value;"+
"}"
);


script.append("}");



%><html>
<head>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK
href="add_fund.files/mystyle.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript>
<!--
function checkform(theform){
  if(form1.Status=='[object]')
  for(Status_index=0;Status_index<form1.Status.length;Status_index++)
  {
    if(form1.Status[Status_index].checked)
    switch(form1.Status[Status_index].value)
    {
      case '1'://取消订单
//      if(form1.signtime.value.length<=0)
//      {
//        alert('如果取消订单,取消日期必须填写.');
//        form1.timeselect.focus();
//        return false;
//      }
      break;


      case '2':
      if(form1.waiter.options.length<=0)
      {
        alert('如果确认订单,业务员编号必须填写.');
        form1.waiter.focus();
        return false;
      }else
      for(var index=0;index<form1.waiter.options.length;index++)
       {       form1.waiter[index].selected=true;
	   //alert(form1.waiter.options[index].value+":"+index);
	   }
      break;

      case '3':
      if(form1.waiter.options.length<=0)
      {
        alert('如果完成订单,业务员编号必须填写.');
        form1.waiter.focus();
        return false;
      }else
      for(index=0;index<form1.waiter.options.length;index++)
              form1.waiter[index].selected=true;
      if(form1.waitersign.value.length<=0||isNaN(parseInt(form1.waitersign.value)))
      {
        alert('如果完成订单,业务员必须签字.');
        form1.waitersign.focus();
        return false;
      }
      if(form1.signtime.value.length<=0)
      {
        alert('如果完成订单,完成日期必须填写.');
        form1.timeselect.focus();
        return false;
      }

      break;
    }
  }

  index=0;
  bool=false;
  for(;index<theform.amount.length;index++)
  {
    value=parseInt(theform.amount[index].value);
    if(!isNaN(value)&&value>0)
    {bool=true;
      if(theform.service[index].selectedIndex==0)
      {
        alert('请选择服务项目');
        theform.service[index].focus();
        return false;
      }

    }
  }
  if(!bool)
  {
    alert('预约项目 数量 至少要填写一项');
    theform.amount[0].focus();
    return false;
  }

}
<%=script.toString()%>
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function fdisabled()
{
  for(index=0;index<form1.elements.length;index++)
  {
    form1.elements[index].disabled=true;
  }
}
function ftabidea()
{
  for(index=0;index<form1.Status.length;index++)
  {

    if(form1.Status[index].checked)
    {

      switch(form1.Status[index].value)
      {
        case '2'://确认订单
        document.all('tabwaiter').style.display= '';
        document.all('tabwaitersign').style.display= 'none';
        document.all('trsubtract').style.display='none';
        form1.subtract.disabled=true;
        form1.clientsign.disabled=true;
        form1.signtime.disabled=true;
        form1.feedback.disabled=true;
        form1.subtract.disabled=true;
        document.all('tabidea').style.display= 'none';
        break;
        case '4'://新订单
        document.all('tabwaiter').style.display= 'none';
        document.all('tabwaitersign').style.display= 'none';
        document.all('trsubtract').style.display='none';
        form1.subtract.disabled=true;
        form1.clientsign.disabled=true;
        form1.signtime.disabled=true;
        form1.feedback.disabled=true;
        form1.subtract.disabled=true;
        document.all('tabidea').style.display= 'none';
        break;
        case '1'://取消订单
        document.all('tabidea').style.display='none';
        form1.clientsign.disabled=false;
        form1.signtime.disabled=false;
        form1.feedback.disabled=false;
        document.all('trsubtract').style.display='none';
        form1.subtract.disabled=true;

        document.all('tabwaiter').style.display= 'none';
        document.all('tabwaitersign').style.display= 'none';

        break;
        case '3'://订单完成
        document.all('tabidea').style.display='';
        form1.clientsign.disabled=false;
        form1.signtime.disabled=false;
        form1.feedback.disabled=false;
        document.all('trsubtract').style.display='';
        form1.subtract.disabled=false;
        document.all('tabwaiter').style.display= '';

        document.all('tabwaitersign').style.display= '';
        break;
    }
  }
}
}

function fsubmit()
{
  document.write("<input name=提交 type=submit value=提交>");
}
//-->
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "接收新订单")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post"  action="/servlet/EditSOrder" onSubmit="return checkform(this)">

  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>" >
  <%

    String parameter=teasession.getParameter("nexturl");

    boolean   parambool=(parameter!=null&&!parameter.equals("null"));

    if(parambool)
    out.print("<input type='hidden' name=nexturl value=\""+parameter+"\">");




%>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>"><br>
  <table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
    <tr>
      <td>客户姓名</td>
      <td><input type="text" value="<%=subject%>"  name="Subject"></td>
      <td>电话</td>
      <td><input type="text" name="phone" value="<%=phone%>"></td>
    </tr>
    <tr>
      <td>服务地址</td>
      <td colspan="3">
        <%--
        <select name="address_father" onchange="fonchange(this)" disabled><!-- onchange="fonchange()">address_father-->
          <%
        StringBuffer script_address=new StringBuffer();
        StringBuffer address_secondly=new StringBuffer();
        StringBuffer script_exwaiter=new StringBuffer();
        java.util.Enumeration az_enumer=tea.entity.admin.Area.findByFather(tea.entity.admin.Area.getRootId(node.getCommunity()));
        while(az_enumer.hasMoreElements())
        {
          int id=((Integer)az_enumer.nextElement()).intValue();
          tea.entity.admin.Area a_obj     =   tea.entity.admin.Area.find(id);
          script_address.append("\r\ncase '"+id+"':\r\n");
          java.util.Enumeration a2_enumer=tea.entity.admin.Area.findByFather(id);
          while(a2_enumer.hasMoreElements())
          {
            int id2=((Integer)a2_enumer.nextElement()).intValue();
            tea.entity.admin.Area a2_obj     =   tea.entity.admin.Area.find(id2);
            script_address.append("form1.address_secondly.add(new Option('"+a2_obj.getName()+"','"+id2+"'));");

            address_secondly.append("\r\ncase '"+id2+"':\r\n");
            java.util.Enumeration a3_enumer=tea.entity.admin.Area.findByFather(id2);
            while(a3_enumer.hasMoreElements())
            {
              int id3=((Integer)a3_enumer.nextElement()).intValue();
              tea.entity.admin.Area a3_obj     =   tea.entity.admin.Area.find(id3);
              address_secondly.append("form1.address.add(new Option('"+a3_obj.getName()+"','"+id3+"'));");
              //作业员
              script_exwaiter.append("\r\ncase '"+id3+"':\r\n");
              java.util.Enumeration waiter_enumer=tea.entity.admin.AdminZone.findByArea(id3);
              while(waiter_enumer.hasMoreElements())
              {
                int waiter_node=  ((Integer)waiter_enumer.nextElement()).intValue();
                java.util.Enumeration waiter_enumer_sub=tea.entity.node.Waiter.findByZone(waiter_node);
                while(waiter_enumer_sub.hasMoreElements())
                {
                  waiter_node=  ((Integer)waiter_enumer_sub.nextElement()).intValue();
                  script_exwaiter.append("form1.exwaiter.add(new Option('"+tea.entity.node.Waiter.find(waiter_node,teasession._nLanguage).getCode()+"','"+waiter_node+"'));");
                }
              }
              script_exwaiter.append("break;");
            }
            address_secondly.append("break;");
          }
          script_address.append("break;");
	%>
          <option value="<%=id%>" <%//=getSelect(id==so_obj.getAddress())%>><%= a_obj.getName()%></option>
          <%}%>
        </select>
        <select name="address_secondly" onchange="fonchange(this)" disabled>
          <option></option>
        </select>
        <select name="address" onchange="fonchange(this)" disabled>
          <option></option>
        </select>--%>
        <input type="hidden" name="address" value="<%=so_obj.getArea()%>"/>
        <%=tea.entity.admin.Area.find(so_obj.getArea()).getAncestor()%>
      </td>
    </tr><tr>
      <td>详细地址</td>
      <td colspan="3"><textarea readonly="readonly" name="detailaddress" cols="60" rows=""><%=so_obj.getAddress()%></textarea></td></tr>
<tr>      <td>预约时间</td>
      <td colspan="3">
	  <%=new tea.htmlx.TimeSelection("bespeak",so_obj.getTime(),true,true)%>
        (年-月-日-时-分)</td>
    </tr>
    <tr align="center" id=tableonetr>
      <td>预约项目编号名称</td>
      <td>作业数量</td>
      <td>&nbsp;</td>
      <td>收费金额</td>
    </tr>
    <tr>
      <td><select name="service"  onChange="fprice(this,form1.amount[0],form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);" >
          <%=sb.toString()%>
        </select>
      </td>
      <td><input type="text" value="<%=so_obj.getAmount()[0]%>"   onKeyUp="fprice(form1.service[0],this,form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);" onChange="fprice(form1.service[0],this,form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);" name="amount"><input readonly=""  name="unit" id="unit" style="background-color:#e6e6e6;  " size="5"  style=" border:#FFFFFF">
<input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/>      </td>
      <td>￥</td>
      <td><input type="text" name="price" readonly="readonly"  style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[1],form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input type="text" value="<%=so_obj.getAmount()[1]%>"  onKeyUp="fprice(form1.service[1],this,form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);" onChange="fprice(form1.service[1],this,form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);"  name="amount"><input readonly=""  name="unit" id="unit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
<input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/>      </td>
      <td>￥</td>
      <td><input type="text" name="price" readonly="readonly"  style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[2],form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input type="text" value="<%=so_obj.getAmount()[2]%>"   onKeyUp="fprice(form1.service[2],this,form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);" onChange="fprice(form1.service[2],this,form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);" name="amount"><input readonly=""  name="unit" id="unit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="price" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[3],form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input type="text" value="<%=so_obj.getAmount()[3]%>"    onKeyUp="fprice(form1.service[3],this,form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);" onChange="fprice(form1.service[3],this,form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);"  name="amount"><input readonly=""  name="unit" id="unit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice" style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="price" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr style="display:none">
      <td><select name="service" onChange="fprice(this,form1.amount[4],form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);">
          <%=sb.toString()%>
        </select></td>
      <td><input type="text" value="<%=so_obj.getAmount()[4]%>"  onKeyUp="fprice(form1.service[4],this,form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);" onChange="fprice(form1.service[4],this,form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);"  name="amount"><input readonly=""  name="unit" id="unit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice" style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="price" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>


        <tr>
      <td colspan="4">
      <table width="100%" >
      <tr><td>现金收费合计(¥)</td><td><input type="text" name="sumcash" value="0" readonly style=" border:#FFFFFF">元</td>
        <td>易洁卡收费合计(¥)</td><td><input type="text" name="sumbank" value="0" readonly style=" border:#FFFFFF">元</td>
        <td>易洁卡余额(¥)</td><td>

<input type="hidden" name="balance" value="<%java.math.BigDecimal balance=tea.entity.member.SClient.find(community,member).getPrice();if(so_obj.getPtype()==1)balance=balance.add(so_obj.getTotal());if(so_obj.getAptype()==1)balance=balance.add(so_obj.getAtotal()); out.print(balance);%>"  style=" border:#FFFFFF">
	  <input type="text" name="balance1" readonly value="0" style=" border:#FFFFFF">元</td>
      </table>
</td>
    </tr>


    <tr align="center" id=tableonetr>
      <td>附加项目编号名称</td>
      <td>作业数量</td>
      <td>&nbsp;</td>
      <td>收费金额</td>
    </tr>
    <tr>
      <td><select name="aservice" onChange="fprice(this,form1.aamount[0],form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);">
          <%=sb.toString()%>
        </select></td>
      <td><input type="text"  value="<%=so_obj.getAamount()[0]%>"   onKeyUp="fprice(form1.aservice[0],this,form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);" onChange="fprice(form1.aservice[0],this,form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);" name="aamount"><input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="aunitprice" style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="aprice"  readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="aservice" onChange="fprice(this,form1.aamount[1],form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);">
          <%=sb.toString()%>
        </select></td>
      <td><input type="text"    value="<%=so_obj.getAamount()[1]%>"   onKeyUp="fprice(form1.aservice[1],this,form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);" onChange="fprice(form1.aservice[1],this,form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);"  name="aamount"><input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="aunitprice" style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="aprice" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr style="display:none">
      <td><select name="aservice" onChange="fprice(this,form1.aamount[2],form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);">
          <%=sb.toString()%>
        </select></td>
      <td><input type="text"    value="<%=so_obj.getAamount()[2]%>"    onKeyUp="fprice(form1.aservice[2],this,form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);" onChange="fprice(form1.aservice[2],this,form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);"  name="aamount"><input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="aunitprice" style=" border:#FFFFFF"/></td>
      <td>￥</td>
      <td><input type="text" name="aprice" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>

    <tr>
      <td>支付方式:</td>
      <td colspan="3">
      <select name="aptype" onChange="fprice(form1.aservice[0],form1.aamount[0],form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);">
      <%
      for(int index=1;index<SOrder.PTYPE_TYPE.length;index++)
      {
        out.print("<option value="+index);
        if(so_obj.getAptype()==index)
        out.print(" SELECTED ");
        out.print(" >"+SOrder.PTYPE_TYPE[index]);
      }
          %>
        </td>
    </tr>
     <tr>
      <td colspan="4">
      <table width="100%" >
      <tr><td>现金收费合计(¥)</td><td><input type="text" name="asumcash" value="0" readonly style=" border:#FFFFFF">元</td>
        <td>易洁卡收费合计(¥)</td><td><input type="text" name="asumbank" value="0" readonly style=" border:#FFFFFF">元</td>
        <td>易洁卡余额(¥)</td><td>
	  <input type="text" name="balance2" readonly value="0" style=" border:#FFFFFF">元</td>
      </table>
        </td>
    </tr>



    <script>

  <%
  int service[]=so_obj.getService();
  if(request.getParameter("destine")!=null)
  {
    service[0]=Integer.parseInt(request.getParameter("destine"));
  }
  for(int index=0;index<service.length;index++)
  {
   %>
   for(index=0;index<  form1.service[<%=index%>].length;index++)
   {
     if(  form1.service[<%=index%>].options[index].value=='<%=service[index]%>')
     {
       form1.service[<%=index%>].selectedIndex=index;
     //  break;
     }
   }
   fprice(form1.service[<%=index%>],form1.amount[<%=index%>],form1.price[<%=index%>],form1.sum,form1.unit[<%=index%>],form1.unitprice[<%=index%>]);
 <%
  }
  %>

  //附加项目编号
  <%
   service=so_obj.getAservice();
   for(int index=0;index<service.length;index++)
   {
   %>
   for(index=0;index<  form1.aservice[<%=index%>].length;index++)
   {
     if(  form1.aservice[<%=index%>].options[index].value=='<%=service[index]%>')
     {
       form1.aservice[<%=index%>].selectedIndex=index;
       break;
     }
   }
   fprice(form1.aservice[<%=index%>],form1.aamount[<%=index%>],form1.aprice[<%=index%>],form1.asum,form1.aunit[<%=index%>],form1.aunitprice[<%=index%>]);
   <%
  }
  %>
  </script>
    <tr>
      <td>期望作业员:</td>
      <td colspan="3"><select name="exwaiter">
          <option value=0>-----无-----</option>
                    <%
          java.util.Enumeration waiter_enumer_a=tea.entity.admin.AdminZone.findByArea(so_obj.getArea());////根据"地区"查找"办事处"
          while(waiter_enumer_a.hasMoreElements())
          {
            int waiter_node=((Integer)waiter_enumer_a.nextElement()).intValue();

            java.util.Enumeration waiter_enumer_sub=tea.entity.node.Waiter.findByZone(waiter_node);//根据"办事处"查找"作业员"
            while(waiter_enumer_sub.hasMoreElements())
            {
              waiter_node=  ((Integer)waiter_enumer_sub.nextElement()).intValue();

              out.print("<Option ");
              if(waiter_node==so_obj.getExwaiter())
              out.print(" SELECTED ");
              out.print(" VALUE="+waiter_node+">"+tea.entity.node.Waiter.find(waiter_node,teasession._nLanguage).getCode()+"</option>");

            }
          }
          %>
        </select></td>
    </tr>




    <tr id="tabidea" style="display:none ">
      <td colspan="4"><table width="100%"   >
        <tr>
          <td  rowspan="3">客户意见</td>
          <td colspan="3"><input name="idea"  id="radio" type="radio" value="0" checked>
      很好
        <input name="idea"  id="radio" type="radio" value="1" <%if(so_obj.getIdea()==1)out.print(" checked ");%>>
      好
      <input name="idea"  id="radio" type="radio" value="2"  <%if(so_obj.getIdea()==2)out.print(" checked ");%>>
      一般
      <input name="idea"  id="radio" type="radio" value="3" <%if(so_obj.getIdea()==3)out.print(" checked ");%>>
      差
      <input name="idea"  id="radio" type="radio" value="4" <%if(so_obj.getIdea()==4)out.print(" checked ");%>>
      很差</td>
        </tr>
        <tr>
          <td colspan="3"><textarea name="feedback" cols="" rows=""></textarea></td>
        <tr>
          <td width="51%">客户鉴字
              <input type="text" value="<%=getNull(so_obj.getClientSign())%>"  name="clientsign"></td>
          <td width="15%">日期</td>
          <td width="23%"><input name="signtime" readonly="" value="<%=getNull(so_obj.getSignTime())%>" type="text" size="9">
              <input type="button" name="timeselect" value="..." onClick="ShowCalendar('form1.signtime')">
          </td>
        </tr>
        <tr><td>
        <table id="trsubtract">
        <tr id="">
          <td>扣除余额</td>
          <td><input type="text" value="<%=so_obj.getTotal()%>" name="subtract"></td>
        </tr>
        <tr id="">
          <td>支付</td>
          <td><input type="text" value="0" name="cash"></td>
        </tr>
        <tr id="">
          <td>发票</td>
          <td>
<select name="invoice">
<%
for(int index=0;index<tea.entity.node.SOrder.INVOICE_TYPE.length;index++)
{
%>
<option value="<%=index%>"><%=tea.entity.node.SOrder.INVOICE_TYPE[index]%></option>
<%
}
%>
</select></td>
</tr>
      </table></td>
    </tr>
        <tr >
      <td colspan="4" style="display:none " id="tabwaiter">
	  <table >
	   <tr >
      <td>业务员编号</td>
      <td><%--input type="text" value="<%=getNull(so_obj.getWaiter())%>" name="waiter"--%>
        <table cellspacing="0" bordercolordark="#ffffff" cellpadding="0" align="left" bordercolorlight="#666666" border="1">
            <tr align="center">
              <td width="140" valing=middle>选定业务员</td>
              <td width="50"  valing=middle>&nbsp;</td>
              <td width="140"  valing=middle>备选业务员</td>
            </tr>
            <tr>
              <td width="140" height="182" valing=bottom>
                <select name="waiter"  size="15" multiple style="border-width:0px; WIDTH: 140px; HEIGHT: 180px"  ondblclick="func_delete(form1.fromareaList,this);" width="100%" >
                  <%
                                                //java.util.Enumeration ar_enumer=tea.entity.admin.AdminRole.findByCommunity(node.getCommunity());
						//while not rssr.EOF
                                                //if(member!=null)
                                                {
                                                  java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer( getNull(so_obj.getWaiter()),"/");
                                                while(tokenizer_obj.hasMoreTokens())
                                                {
                                                  int id=Integer.parseInt((String)tokenizer_obj.nextElement());
//                                                  tea.entity.admin.Area az_obj=tea.entity.admin.Area.find(id);
                                                  tea.entity.node.Node  az_obj=tea.entity.node.Node.find(id);
                                                  %>
                  <option value="<%=id%>"><%=az_obj.getSubject(teasession._nLanguage)%></option>
                  <%
                                                  //rssr.MoveNext
                                                  //wend
                                                }
                                              }
						%>
                </select></td>
              <td width="50" align="center"  valing=middle><input onClick="func_insert(form1.fromareaList,form1.waiter);" type="button" value=" ← " id=button1 name=button1>
                <br> <input onClick="func_delete(form1.fromareaList,form1.waiter);" type="button" value=" → " id=button2 name=button2>
                <br> <input onClick="func_up(form1.fromareaList,form1.waiter);" type="button" value=" ↑ " id=button3 name=button3>
                <br> <input onClick="func_down(form1.fromareaList,form1.waiter);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td  valing=middle width="140">
                <select ondblclick="func_insert(form1.fromareaList,form1.waiter);" width="100%" style="WIDTH: 140px; HEIGHT: 180px" size="15" name="fromareaList" >
                  <%
                  java.util.Enumeration waiter_enumer=tea.entity.node.Node.findByType(68,node.getCommunity());
                  while(waiter_enumer.hasMoreElements())
                  {
                    int ar_id=((Integer)waiter_enumer.nextElement()).intValue();
                    %>
                  <option value=<%=ar_id%>><%=tea.entity.node.Node.find(ar_id).getSubject(teasession._nLanguage)%></option>
                  <%}%>
                </select>
                <script type="">
                  for(index=0;index<form1.waiter.length;index++)
                  {
                    for(i=0;i<form1.fromareaList.length;i++)
                    {
                      if( form1.waiter[index].value==form1.fromareaList[i].value)
                      {
                        form1.fromareaList.remove(i);
                      }
                    }
                  }
                  function func_insert(select2,select1)
			{

			if(select2.selectedIndex!=-1)
			{
			option_text=select2.options(select2.selectedIndex).text;
			option_value=select2.options(select2.selectedIndex).value;

			found=0;

			if(found==0)
			{
				var my_option = document.createElement("OPTION");
				my_option.text=option_text;
				my_option.value=option_value;


				if(select1.selectedIndex==-1)
				{
                                  select1.add(my_option);
                                  new_index=select1.options.length-1;
				}else
				{
                                  new_index=select1.selectedIndex+1;
                                  select1.add(my_option,new_index);
				}

                                select1.selectedIndex=new_index;
                                select2.remove(select2.selectedIndex);
                              }
                            }
                          }

                          function func_delete(select2,select1)
                          {
                            //select2= eval('document.forms[0].fromList');
                            //select1= eval('document.forms[0].toList');
                            if(select1.selectedIndex!=-1)
                            {
                              option_text=select1.options(select1.selectedIndex).text;
                              option_value=select1.options(select1.selectedIndex).value;
                              var my_option = document.createElement("OPTION");
                              my_option.text=option_text;
                              my_option.value=option_value;
                              select2.add(my_option);

                              select1.remove(select1.selectedIndex);
                            }
                          }


                          function func_up(select2,select1)
                          {
                            //select2= eval('document.forms[0].fromList');
                            //select1= eval('document.forms[0].toList');
                            if(select1.selectedIndex!=-1 && select1.selectedIndex!=0)
                            {
                              option_text=select1.options(select1.selectedIndex).text;
                              option_value=select1.options(select1.selectedIndex).value;

                              var my_option = document.createElement("OPTION");
                              my_option.text=option_text;
                              my_option.value=option_value;

                              new_index=select1.selectedIndex-1;
                              select1.remove(select1.selectedIndex);
                              select1.add(my_option,new_index);
                              select1.selectedIndex=new_index;
                            }
                          }


			function func_down(select2,select1)
			{
                          //select2= eval('document.forms[0].fromList');
                          //select1= eval('document.forms[0].toList');
                          if(select1.selectedIndex!=-1 && select1.selectedIndex!=(select1.options.length-1))
                          {
                            option_text=select1.options(select1.selectedIndex).text;
                            option_value=select1.options(select1.selectedIndex).value;

                            var my_option = document.createElement("OPTION");
                            my_option.text=option_text;
                            my_option.value=option_value;

                            new_index=select1.selectedIndex+1;
                            select1.remove(select1.selectedIndex);
                            select1.add(my_option,new_index);
                            select1.selectedIndex=new_index;
                          }
                        }

			</SCRIPT></td>
            </tr>
          </table>


      </td></tr>
	  </table></td></tr>
    <tr  style="display:none " id="tabwaitersign">
    <td colspan="4">
	<table><tr><td>签字</td>
      <td colspan="5"><input type="text"  value="<%=getNull(so_obj.getWaiterSign())%>" name="waitersign"></td>
    </tr></table></td></tr></table>
    </td></tr>
    <tr>
      <td colspan="4" align="right" style="padding-right:50px;"><%
      if (edit)
      /*if(node.getCreator()._strR.equals(teasession._rv._strR))
      {
        switch (so_obj.getStatus())
        {
          case 0: // '\0'
          out.print(new Radio("Status", 0, true));
          out.print(new Text(r.getString(teasession._nLanguage, "NewOrder")));
          out.print(new Radio("Status", 1, false));
          out.print(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
          out.print("<input name=我叫小刘 class=tj type=submit value=提交>");
          break;
          default:
          out.print(new tea.html.Script("fdisabled();"));
        }
      } else//管理员查看*/
      {
        switch (so_obj.getStatus())
        {
          case 0: // 新订单
          tea.html.Radio start0_0= new Radio("Status",4, true);
          start0_0.setOnClick("ftabidea()");
          out.print(start0_0);
          out.print("接收新订单");

          tea.html.Radio start0_1= new Radio("Status",1, false);
          start0_1.setOnClick("ftabidea()");
          out.print(start0_1);
          out.print("取消订单");

          out.print("<input name=我叫小刘 class=tj type=submit value=提交>");
          break;

          case 1: // 取消订单
          tea.html.Radio start1_0= new Radio("Status",0, true);
          start1_0.setOnClick("ftabidea()");
          out.print(start1_0);
          out.print("新订单");

          tea.html.Radio start1_2= new Radio("Status",2, false);
          start1_2.setOnClick("ftabidea()");
          out.print(start1_2);
          out.print("确认订单");
          out.print("<script>ftabidea();</script><input name=我叫小刘 class=tj type=submit value=提交>");
          break;

          case 2: // 确认订单
          tea.html.Radio affirmradio=new Radio("Status",2, true);
          affirmradio.setOnClick("ftabidea()");
          out.print(affirmradio);
          out.print("确认订单");

          tea.html.Radio cancelradio= new Radio("Status",1, false);
          cancelradio.setOnClick("ftabidea()");
          out.print(cancelradio);
          out.print("取消订单");

          tea.html.Radio radio=new tea.html.Radio("Status",3, false);
          radio.setOnClick("ftabidea()");
          out.print(radio);
          out.print("订单完成");
          out.print("<script>ftabidea();</script><input name=我叫小刘 class=tj type=submit value=提交>");
          break;

          case 3: //订单完成
          out.print("<input  style=display:none  id=radio type=radio name=Status value=2 > <input  style=display:none CHECKED id=radio type=radio name=Status value=3> ");
          out.print(new tea.html.Script("ftabidea();fdisabled();"));
          break;
        }%>
    <%}else{  %>
    <input name=提交 type=submit value=提交>
    <%}%></td>
    </tr>

  </table>
</form>
<%--
  <script type="">
    function fonchange(selectobj)
    {
      while(form1.exwaiter.lengTD>1)
      {
        form1.exwaiter.options[1]=null;
      }
      if(selectobj.name=='address_father')
      {
        while(form1.address.lengTD>0)
        {
          form1.address.options[0]=null;
        }
        while(form1.address_secondly.lengTD>0)
        {
          form1.address_secondly.options[0]=null;
        }
        switch(selectobj.options[selectobj.selectedIndex].value)
        {
          <%=script_address.toString()%>
        }
      }else
      if(selectobj.name=='address_secondly')
      {
        while(form1.address.lengTD>0)
        {
          form1.address.options[0]=null;
        }
        switch(selectobj.options[selectobj.selectedIndex].value)
        {
          <%=address_secondly.toString()%>
        }
        fonchange(form1.address);
      }else
      if(selectobj.name=='address')
      {
        switch(selectobj.options[selectobj.selectedIndex].value)
        {
          <%=script_exwaiter.toString()%>
        }
      }
    }
    <%
       tea.entity.admin.Area a3_obj = tea.entity.admin.Area.find(so_obj.getArea());
       tea.entity.admin.Area address_secondly_obj=tea.entity.admin.Area.find(a3_obj.getFather());
       %>
       for(index=0;index<form1.address_father.length;index++)
       {
         if(form1.address_father.options[index].value=='<%=address_secondly_obj.getFather()%>')
         {
           form1.address_father.selectedIndex=index;
         }
       }
       fonchange(form1.address_father);

       for(index=0;index<form1.address_secondly.length;index++)
       {
         if(form1.address_secondly.options[index].value=='<%=address_secondly_obj.getId()%>')
         {
           form1.address_secondly.selectedIndex=index;
         }
       }
       fonchange(form1.address_secondly);

       for(index=0;index<form1.address.length;index++)
       {
         if(form1.address.options[index].value=='<%=so_obj.getArea()%>')
         {
           form1.address.selectedIndex=index;
         }
       }
       fonchange(form1.address);
       for(index=0;index<form1.exwaiter.length;index++)
       {
         if(form1.exwaiter.options[index].value=='<%=so_obj.getExwaiter()%>')
         {
           form1.exwaiter.selectedIndex=index;
         }
       }
    </script>--%>
    <br><br><div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

