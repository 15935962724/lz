<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/SOrder");
String community=node.getCommunity();
tea.entity.member.Profile profile=tea.entity.member.Profile.find(teasession._rv.toString());
tea.entity.member.SClient sclient=tea.entity.member.SClient.find(node.getCommunity(),teasession._rv.toString());
java.util.Enumeration enumer=tea.entity.node.Node.findByType(65,node.getCommunity());
StringBuffer sb=new StringBuffer("<option value=\"0\">---请选择---");
StringBuffer script_minimum=new StringBuffer("function fminimum(obj1,obj2){\r\nswitch(obj1.value){");
StringBuffer script=new StringBuffer("function fprice(select,count,price,sum,input_unit,unitprice){\r\n  switch(select.options[select.selectedIndex].value){");
script.append("case '0':unitprice.value='0'; price.value=0*parseFloat(count.value);input_unit.value='';break;\r\n");
while(enumer.hasMoreElements())
{
  int i=((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Service ser=tea.entity.node.Service.find(i,teasession._nLanguage);
  if(ser.isExists())
  {
    sb.append("<option value="+i);
    sb.append(">"+tea.entity.node.Node.find(i).getSubject(teasession._nLanguage)+"</option>");
    script.append("case '"+i+"':unitprice.value='"+ser.getPrice().toString()+"'; price.value="+ser.getPrice().toString()+"*parseFloat(count.value);input_unit.value='"+ser.getUnit()+"';break;\r\n");
    script_minimum.append("case '"+i+"':if(obj2.value<"+ser.getMinimum()+"){alert('值不能小于"+ser.getMinimum()+".');obj2.focus();}break;");
  }
}
script_minimum.append("}}");
script.append("}form1.sum.value='0';for(index=0;index<form1.price.length;index++)if(!isNaN(parseFloat(form1.price[index].value)))form1.sum.value=parseFloat(form1.sum.value)+parseFloat(form1.price[index].value);\r\n;form1.balance1.value=form1.balance.value-form1.sum.value;}");


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
%>


<SCRIPT language=JavaScript >
<!--
function checkform(theform){
  if(form1.Status=='[object]')
  for(index=0;index<form1.Status.length;index++)
  {
    if(form1.Status[index].checked)
    switch(form1.Status[index].value)
    {
      case '1'://取消订单
      if(form1.signtime.value.length<=0)
      {
        alert('如果取消订单,取消日期必须填写.');
        form1.timeselect.focus();
        return false;
      }
      break;


      case '2':
      if(form1.waiter.value.length<=0||isNaN(parseInt(form1.waiter.value)))
      {
        alert('如果确认订单,业务员编号必须填写.');
        form1.waiter.focus();
        return false;
      }else
      form1.waiter.value=     parseInt(form1.waiter.value);
      break;

      case '3':
      if(form1.waiter.value.length<=0||isNaN(parseInt(form1.waiter.value)))
      {
        alert('如果完成订单,业务员编号必须填写.');
        form1.waiter.focus();
        return false;
      }else
      form1.waiter.value=parseInt(form1.waiter.value);
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
    {
      bool=true;
      if(theform.service[index].selectedIndex==0)
      {
        alert('请选择服务项目');
        theform.service[index].focus();
        return false;
      }
     // return true;
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
<%=script_minimum.toString()%>
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
        case '0'://新订单
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
        document.all('tabidea').style.display='';
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
  document.write("<input name= type=submit value=提交>");
}
//-->
</SCRIPT><style type="text/css">
<!--
body,td,th {
	font-size: 9pt;
}
-->
</style>

<form name="form1" method="post"  action="/servlet/EditSOrder" onsubmit="return checkform(this)">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>" >
  <%
    tea.entity.node.SOrder so_obj=  tea.entity.node.SOrder.find(0,teasession._nLanguage);

    String parameter=teasession.getParameter("nexturl");
    String Preview="";
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    String    educateParam="";
    boolean edit=true;
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String subject=null,phone=null,detailaddress="";
    int address=0;
    java.math.BigDecimal balance=tea.entity.member.SClient.find(community,teasession._rv._strV).getPrice();
    if(NewNode)
    {
      out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
      edit=false;
      subject=profile.getFirstName(teasession._nLanguage);
      phone=profile.getTelephone(teasession._nLanguage);
      address=sclient.getArea();
      detailaddress=profile.getAddress(teasession._nLanguage);
    }else
    if(request.getParameter("NewBrother")!=null)
    {
      out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
      edit=false;
      subject=profile.getFirstName(teasession._nLanguage);
      phone=profile.getTelephone(teasession._nLanguage);
      address=sclient.getArea();
      detailaddress=profile.getAddress(teasession._nLanguage);
    }else
    {
      Preview="<A href=/jsp/type/resume/Preview.jsp?node="+teasession._nNode+" style=color=#ffffff target=_blank >预览简历</A>";
      educateParam="Node="+teasession._nNode;
      so_obj=  tea.entity.node.SOrder.find(teasession._nNode,teasession._nLanguage);
      subject=node.getSubject(teasession._nLanguage);
      phone=so_obj.getPhone();
      address=so_obj.getArea();
      detailaddress=so_obj.getAddress();

      balance=balance.add(so_obj.getTotal());
    }
%>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <table cellpadding="5" cellspacing="0" border="1" bgcolor="#ffffff" bordercolor="#cccccc" style="border-collapse:collapse ;">
    <tr>
      <td>客户姓名</td>
      <td><input type="text" value="<%=subject%>"  name="Subject"></td>
      <td>电话</td>
      <td><input type="text" name="phone" value="<%=phone%>"></td>
    </tr>
    <tr>
      <td>服务地址</td>
      <td colspan="3"><%--
        <select name="address_father" onchange="fonchange(this)"><!-- onchange="fonchange()">address_father-->
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
                script_exwaiter.append("form1.exwaiter.add(new Option('"+waiter_node+"','"+waiter_node+"'));");
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
        <select name="address_secondly" onchange="fonchange(this)">
          <option></option>
        </select>
        <select name="address" onchange="fonchange(this)">
          <option></option>
        </select>--%>
        <input type="hidden" name="address" value="<%=address%>"/>
        <%=tea.entity.admin.Area.find(address).getAncestor()%>      </td>
    </tr><tr>
      <td>详细地址</td>
      <td colspan="3"><textarea  name="detailaddress" cols="50" rows=""><%=detailaddress%></textarea></td>
    </tr>
    <tr>
      <td>预约时间</td>
      <td colspan="3">
	  <%=new tea.htmlx.TimeSelection("bespeak",so_obj.getTime(),true,true)%>
        (年-月-日-时-分)</td>
    </tr>
    <tr align="center" bgcolor="#FEFFD7">
      <td>预约项目编号名称</td>
      <td>作业数量</td>
      <td>&nbsp;</td>
      <td>收费金额</td>
    </tr>
    <tr>
      <td><select name="service"  onChange="fprice(this,form1.amount[0],form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);" >
          <%=sb.toString()%>
        </select>      </td>
      <td><input name="amount" type="text" onblur="fminimum(form1.service[0],this);" onChange="fprice(form1.service[0],this,form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);"   onKeyUp="fprice(form1.service[0],this,form1.price[0],form1.sum,form1.unit[0],form1.unitprice[0]);" value="<%=so_obj.getAmount()[0]%>" SIZE="10">
        <input readonly=""  name="unit" id="unit"  size="5"  style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="price" readonly="readonly"  style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[1],form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input  name="amount" type="text" onblur="fminimum(form1.service[1],this);"  onChange="fprice(form1.service[1],this,form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);"  onKeyUp="fprice(form1.service[1],this,form1.price[1],form1.sum,form1.unit[1],form1.unitprice[1]);" value="<%=so_obj.getAmount()[1]%>" SIZE="10">
        <input readonly=""  name="unit" id="unit" size="5"  style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="price" readonly="readonly"  style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[2],form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input name="amount" type="text" onblur="fminimum(form1.service[2],this);"  onChange="fprice(form1.service[2],this,form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);"   onKeyUp="fprice(form1.service[2],this,form1.price[2],form1.sum,form1.unit[2],form1.unitprice[2]);" value="<%=so_obj.getAmount()[2]%>" SIZE="10">
        <input readonly=""  name="unit" id="unit" size="5"  style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice"  style=" border:#FFFFFF"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="price" readonly="readonly"  style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td><select name="service" onChange="fprice(this,form1.amount[3],form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);" >
          <%=sb.toString()%>
        </select></td>
      <td><input  name="amount" type="text" onblur="fminimum(form1.service[3],this);"  onChange="fprice(form1.service[3],this,form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);"    onKeyUp="fprice(form1.service[3],this,form1.price[3],form1.sum,form1.unit[3],form1.unitprice[3]);" value="<%=so_obj.getAmount()[3]%>" SIZE="10">
        <input readonly=""  name="unit" id="unit"  size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice" style=" border:#FFFFFF"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="price" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr style="display:none">
      <td><select name="service" onChange="fprice(this,form1.amount[4],form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);">
          <%=sb.toString()%>
        </select></td>
      <td><input  name="amount" type="text"  onblur="fminimum(form1.service[4],this);"  onChange="fprice(form1.service[4],this,form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);"  onKeyUp="fprice(form1.service[4],this,form1.price[4],form1.sum,form1.unit[4],form1.unitprice[4]);" value="<%=so_obj.getAmount()[4]%>" SIZE="10">
        <input readonly=""  name="unit" id="unit"  size="5" style=" border:#FFFFFF">
      <input type="text"  readonly  size="5" name="unitprice" style=" border:#FFFFFF"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="price" readonly="readonly" style=" border:#FFFFFF">
        元</td>
    </tr>
    <tr>
      <td>收费金额合计</td>
      <td>￥
        <input type="text" name="sum" readonly style=" border:#FFFFFF">
        元</td>
      <td colspan="2">账户余额&nbsp;&nbsp;
	  <input type="hidden" name="balance" value="<%=balance%>" />
	  ¥<input type="text"  readonly="readonly"  size="14" name="balance1" style=" border:#FFFFFF"/>
      元</td>
    </tr>
    <%--
    <tr align="center" bgcolor="#FEFFD7">
      <td>附加项目编号名称</td>
      <td>作业数量</td>
      <td>&nbsp;</td>
      <td>收费金额</td>
    </tr>
    <tr>
      <td><select name="aservice" onChange="fprice(this,form1.aamount[0],form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);">
          <%=sb.toString()%>
        </select></td>
      <td><input name="aamount" type="text" onChange="fprice(form1.service[0],this,form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);"   onKeyUp="fprice(form1.service[0],this,form1.aprice[0],form1.asum,form1.aunit[0],form1.aunitprice[0]);"  value="<%=so_obj.getAamount()[0]%>" SIZE="10">
        <input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5">
      <input type="text"  readonly  size="5" name="aunitprice"/> </td>
      <td align="right">￥</td>
      <td><input type="text" name="aprice"  readonly="readonly">
        元</td>
    </tr>
    <tr>
      <td><select name="aservice" onChange="fprice(this,form1.aamount[1],form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);">
          <%=sb.toString()%>
        </select></td>
      <td><input  name="aamount" type="text" onChange="fprice(form1.aservice[1],this,form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);"   onKeyUp="fprice(form1.aservice[1],this,form1.aprice[1],form1.asum,form1.aunit[1],form1.aunitprice[1]);"    value="<%=so_obj.getAamount()[1]%>" SIZE="10">
        <input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5">
      <input type="text"  readonly  size="5" name="aunitprice"/></td>
      <td align="right">￥</td>
      <td><input type="text" name="aprice" readonly="readonly">
        元</td>
    </tr>
    <tr>
      <td><select name="aservice" onChange="fprice(this,form1.aamount[2],form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);">
          <%=sb.toString()%>
        </select></td>
      <td><input  name="aamount" type="text" onChange="fprice(form1.aservice[2],this,form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);"    onKeyUp="fprice(form1.aservice[2],this,form1.aprice[2],form1.asum,form1.aunit[2],form1.aunitprice[2]);"    value="<%=so_obj.getAamount()[2]%>" SIZE="10">
        <input readonly=""  name="aunit" id="aunit" style="background-color:#e6e6e6;  " size="5">
      <input type="text"  readonly  size="5" name="aunitprice"/></td>
      <td align="right">￥</td>
      <td><input type="text" name="aprice" readonly="readonly">
        元</td>
    </tr>
    <tr>
      <td>附加项收费金额</td>
      <td>￥
        <input type="text" name="asum" readonly>
        元</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>--%>
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
  <%--
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
  --%>
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
   <tr>
      <td colspan="4" align="right" style="padding-right:50px;">
         <input  type="hidden" name="idea" value="0"/>
      <input  type="hidden" name="Status" value="<%=so_obj.getStatus()%>"/>  <input name=提交 type=submit class=tj id="提交" value=提交>    </td>
    </tr>
  </table>
</form><%--
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

       tea.entity.admin.Area a3_obj     =   tea.entity.admin.Area.find(address);
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
         if(form1.address.options[index].value=='<%=address%>')
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
    </script>
--%>

