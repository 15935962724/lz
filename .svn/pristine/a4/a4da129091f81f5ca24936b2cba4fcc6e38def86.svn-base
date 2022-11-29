<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.admin.*" %><%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Goods");
String community=teasession._strCommunity;

if("EditGoods".equals(teasession.getParameter("act")))
{
  String number = teasession.getParameter("number");
  String number2 = teasession.getParameter("number2");

  if("1".equals(number2))//表示是添加
  {
    if(Node.isNumber(number))
    {
      out.print("<font color=red>编号已经存在，请重新输入！</font>");
    }else
    {
    	out.println("true");
    }
  }else
  {
    if(!number.equals(String.valueOf(number2)))
    {
      if(Node.isNumber(number))
      {
        out.print("<font color=red>编号已经存在，请重新输入！</font>");
      }
    }else
    {
    	out.println("true");
    }
  }
  return;
}else if("EditGoods2".equals(teasession.getParameter("act")))
{
  String barcode = teasession.getParameter("barcode");
  String barcode2 = teasession.getParameter("barcode2");
  if("1".equals(barcode2))//表示是添加
  {
    if(Goods.isBarcode(barcode))
    {
      out.print("条形码已经存在");
    }else
    {
    	out.println("true");
    }
  }else
  {


    if(!barcode.equals(String.valueOf(barcode2)))
    {
      if(Goods.isBarcode(barcode))
      {
        out.print("条形码已经存在");
      }else
      {
      	out.println("true");
      }
    }else
    {
    	out.println("true");
    }
  }
  return;
}
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/layer.js" type="text/javascript"></script>
<script language="JavaScript">
<!--
function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
  window.showModalDialog("ProductSel.jsp?index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}


function fload()
{
form1.subject.focus();
}

function f_submit()
{

  if(form1.subject.value=='')
  {
    alert("产品名称不能为空，请先填写产品名称！");
    form1.subject.focus();
    return false;
  }
  if(form1.number.value=='')
  {
    alert("编号不能为空！");
    form1.number.focus();
    return false;
  }


if(form1.used.value==0)
{
   alert("请选择使用类型！");
    form1.used.focus();
    return false;
}
/*
  var n = form1.number2.value;
  if(form1.number2.value!=null || form1.number2.value.length()>0)
  {

  }else
  {
     n=1;
  }
  sendx("?act=EditGoods&number="+form1.number.value+"&number2="+n,
  function(data)
  {

    if(data!='' && data.length!=52)
    {
      alert("编号已经存在，请重新输入！");
      form1.number.value='';
      form1.number.focus();
      form1.submit.disabled=true;
     // form1.GoBack.disabled=true;
      form1.GoFinish.disabled=true;
      return false;
    }else
    {
      form1.submit.disabled=false;
     // form1.GoBack.disabled=false;
      form1.GoFinish.disabled=false;
    }
  }
  );
*/
  openNewDiv('newDiv');//打开层
}
function  f_submit2()
{

  var n = form1.barcode2.value;
  if(form1.barcode2.value=='' || form1.barcode2.value==null)
  {
	  n=1;
  }

  sendx("?act=EditGoods2&barcode="+form1.barcode.value+"&barcode2="+n,
  function(data)
  {
   
    if(data.trim()!='true' )
    {
    	 
      document.getElementById("show2").innerHTML='条形码已经存在，请重新输入入';
     
      form1.barcode.focus();
      return false;
    }
  }
  );
}
function f_submit12()
{
  var n = form1.number2.value;
  if(form1.number2.value==''|| form1.number2.value==null)
  {
	  n=1;
  }

    sendx("?act=EditGoods&number="+form1.number.value+"&number2="+n,
  function(data)
  {
    	  // alert(data..trim());
    if(data.trim()!='true' )
    {
      document.getElementById("show").innerHTML='编号已经存在，请重新输入';
      //form1.number.value='';
      form1.number.focus();
      form1.submit.disabled=true;
     // form1.GoBack.disabled=true;
      form1.GoFinish.disabled=true;
      return false;
    }else
    {
      form1.submit.disabled=false;
     // form1.GoBack.disabled=false;
      form1.GoFinish.disabled=false;
    }
  }
  );
}
//-->
</script>
</head>
<body onLoad="fload();" >

<h1><%=r.getString(teasession._nLanguage, "CBNewGoods")%></h1>

<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name=form1 action="/servlet/EditGoods" method="post" enctype="multipart/form-data" onSubmit="return f_submit();">
<%
String nodetype = teasession.getParameter("nodetype");

String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");

String subject="";
Date issueDate=null;
String text="";
long lensmaill=0,lenbig=0,lenrecommend=0;
int father=0;
int brand=0;
String goodstype="/",measure="",spec="",capability="";
boolean status=true;
int company=0;
int correspond=0,correspond2=0,correspond3=0,correspond4=0,correspond5=0,correspond6=0;
String smallpicture="",bigpicture="",recommendpicture="";
String number = "",barcode="";
int used=0;
boolean dtype=false;
float deduct=0F;
if(request.getParameter("NewNode")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  subject=node.getSubject(teasession._nLanguage);
  Goods goods=Goods.find(teasession._nNode);
  issueDate=node.getTime();
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));

  smallpicture=goods.getSmallpicture(teasession._nLanguage);
  if(smallpicture !=null && smallpicture.length()>0){

    lensmaill=new java.io.File( application.getRealPath(smallpicture)).length();
  }
  bigpicture=goods.getBigpicture(teasession._nLanguage);
  if(bigpicture !=null && bigpicture.length()>0)
  {
    lenbig=new java.io.File( application.getRealPath(bigpicture)).length();
  }
  recommendpicture=goods.getCommendpicture(teasession._nLanguage);
  if(recommendpicture !=null && recommendpicture.length()>0)
  {
    lenrecommend=new java.io.File( application.getRealPath(recommendpicture)).length();
  }
  father=node.getFather();
  company=goods.getCompany();
  goodstype=goods.getGoodstype();
  correspond=goods.getCorrespond();
  correspond2=goods.getCorrespond2();
  correspond3=goods.getCorrespond3();
  correspond4=goods.getCorrespond4();
  correspond5=goods.getCorrespond5();
  correspond6=goods.getCorrespond6();
  measure=goods.getMeasure(teasession._nLanguage);
  spec=goods.getSpec(teasession._nLanguage);
  status=goods.isStatus();
  capability=goods.getCapability(teasession._nLanguage);
  brand=goods.getBrand();
  used=goods.getUsed();
  dtype=goods.isDType();
  deduct=goods.getDeduct();
  //编号
  number = node.getNumber();
  barcode = goods.getBarcode();//条形码
}

if(request.getParameter("goodstype")!=null)
goodstype=request.getParameter("goodstype");

%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<!--如果是修改-->
<input type="hidden" name="number2" value="<%=number%>">
<input type="hidden" name="barcode2" value="<%=barcode%>">
  <tr id="zhanshi">
    <td><%=r.getString(teasession._nLanguage,"Goods.location")%>：</td>
    <td>
        <%
        if(request.getParameter("NewNode")!=null)
        {
          if(!"null".equals(nodetype)&&nodetype!=null && nodetype.length()>0)
          {
            out.print(Node.find(Integer.parseInt(nodetype)).getSubject(teasession._nLanguage)+"<input type=hidden name=Node value="+nodetype+">");
          }else{
            out.print("<select name=Node >");

            DbAdapter dbadapter=new DbAdapter();
            try
            {
              dbadapter.executeQuery("SELECT n.node FROM Node n,Category c WHERE n.node=c.node AND c.category=34 AND community="+dbadapter.cite(community));
              while(dbadapter.next())
              {
                int id=dbadapter.getInt(1);
                tea.entity.node.Node obj=tea.entity.node.Node.find(id);
                out.print("<option value="+id);
                if(id==teasession._nNode)
                out.print(" SELECTED ");
                out.print(">"+Node.find(obj.getFather()).getSubject(teasession._nLanguage)+" > "+obj.getSubject(teasession._nLanguage)+"</option>");
              }
            }catch(Exception e)
            {
              e.printStackTrace();
            }finally
            {
              dbadapter.close();
            }
            out.print("</select>");
          }
        }else
        {
          out.print(Node.find(father).getSubject(teasession._nLanguage)+"<input type=hidden name=Node value="+teasession._nNode+">");
        }
%>

        <%--input type="button"  class="edit_button" value="<%=r.getString(teasession._nLanguage,"New")%>" onclick="javascript:open_win('/jsp/type/brand/EditBrand.jsp','',400,800);">
               <input name="fff" type=BUTTON class="edit_button" onClick="javascript:window.open('/jsp/type/brand/ManageBrand.jsp?node=<%=teasession._nNode%>');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>"--%>
        <%--              <input type="button" name="pinpai" value="查询品牌" onclick="javascript:open_win('brand_que.asp','',500,620);">--%>      </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,"Brand")%>：</td>
        <td>
        <%
        DropDown dd=new DropDown("brand",brand);
        dd.addOption(0,"-------------");
        AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
        String brands=aur.getBrand();
        if(brands!=null)
        {
          String bs[]=brands.split("/");
          for(int i=1;i<bs.length;i++)
          {
            int id=Integer.parseInt(bs[i]);
            Brand obj=Brand.find(id);
            if(obj.isExists())
            {
              dd.addOption(id,obj.getName(teasession._nLanguage));
            }
          }
        }
        dd.sort();
        out.print(dd.toString());
        %></td>
    </tr>
   <%
   StringBuffer brand_sb=new StringBuffer("/");
   if(goodstype==null)
       goodstype="/";
   String gts[]=goodstype.split("/");
   int root=GoodsType.getRootId(community);
   GoodsType gt_obj=GoodsType.find(root);
   brand_sb.append(gt_obj.getBrand()).append("/");
   int count=GoodsType.countByFather(root);
   if(count>0)//判断是否有类别
   {
      out.println("<tr><td>"+r.getString(teasession._nLanguage, "Type")+":</td><td>");
      for(int index=2;index<gts.length;index++)
      {
        try
        {
          gt_obj=GoodsType.find(Integer.parseInt(gts[index]));
          if(gt_obj.isExists())
          {
            brand_sb.append(gt_obj.getBrand()).append("/");
            out.print(" >"+gt_obj.getName(teasession._nLanguage));
          }
        }catch(Exception e)
        {
          gts[index]="0";
        }
      }
      out.println("<INPUT TYPE=submit name=GoodsType  VALUE="+r.getString(teasession._nLanguage, "CBEdit")+"></td></tr>");
    }
    out.print("<input type=hidden name=goodstype value="+goodstype+" />");
    %>

    <tr>
      <td><%=r.getString(teasession._nLanguage,"商品名称")%>：</td>
      <td nowrap class=huititable ><input name="subject" class="edit_input"  type="text" value="<%=subject%>" size="40" maxlength="100">* </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"编号")%>：</td>
      <td nowrap class=huititable ><input name="number" class="edit_input"  type="text" value="<%if(number!=null)out.print(number);%>" size="25" maxlength="100" onkeyup="f_submit12();" >*<span id="show">&nbsp;</span> </td>
    </tr>
       <tr>
      <td><%=r.getString(teasession._nLanguage,"条形码")%>：</td>
      <td nowrap class=huititable ><input name="barcode" class="edit_input"  type="text" value="<%if(barcode!=null)out.print(barcode);%>" size="25" maxlength="100" onkeyup="f_submit2();" ><span id="show2">&nbsp;</span>  </td>
    </tr>
    <tr>
        <td><%=r.getString(teasession._nLanguage,"Goods.measure")%>：</td>
        <td><input name="measure" class="edit_input"  type="text" value="<%=measure%>" size="25" maxlength="50">      </td>
    </tr>
    <tr>
      <td> <%=r.getString(teasession._nLanguage,"Goods.spec")%>：</td>
      <td ><input name="spec" class="edit_input"  type="text" value="<%=spec%>" size="25" maxlength="50">      </td>
      </tr>

      <tr id="stateid">
        <td><%=r.getString(teasession._nLanguage,"Goods.status")%>：</td>
      <td  ><select name="state">
          <option value="true" selected ><%=r.getString(teasession._nLanguage,"Goods.have")%></option>
          <option value="false" <%if(!status)out.print(" SELECTED ");%>><%=r.getString(teasession._nLanguage,"Goods.oos")%></option>
        </select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Goods.smallpicture")%>：</td>
      <td  colspan="2"><input name="smallpicture" type="file" class="edit_input"  />
        <%if(lensmaill>0){out.print("<a href="+smallpicture+" target=_blank>"+lensmaill+r.getString(teasession._nLanguage,"Bytes")+"</a>");%>
        <input  id="CHECKBOX" type="CHECKBOX" onClick="form1.smallpicture.disabled=this.checked"  name="clearsmallpicture"/><%=r.getString(teasession._nLanguage,"Clear")%> <%} %>

        <span class="huititable">*</span>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Goods.bigpicture")%>：</td>
      <td colspan="2"><input name="bigpicture" type="file" class="edit_input"  />
        <%if(lenbig>0){out.print("<a href="+bigpicture+" target=_blank>"+lenbig+r.getString(teasession._nLanguage,"Bytes")+"</a>");%>
        <input  id="CHECKBOX" type="CHECKBOX" onClick="form1.bigpicture.disabled=this.checked" name="clearbigpicture"/><%=r.getString(teasession._nLanguage,"Clear")%><%} %>

        <span class="huititable">*</span></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Goods.commendpicture")%>：</td>
      <td  colspan="2">
        <input name="recommendpicture" type="file" class="edit_input"   />
        <%if(lenrecommend>0){out.print("<a href="+recommendpicture+" target=_blank>"+lenrecommend+r.getString(teasession._nLanguage,"Bytes")+"</a>");%>
        <input  id="CHECKBOX" type="CHECKBOX" onClick="form1.recommendpicture.disabled=this.checked"  name="clearrecommendpicture"/><%=r.getString(teasession._nLanguage,"Clear")%>
        <%} %>
        <span class="huititable">*</span></td>
    </tr>
    <tr id="companyid">
      <td><%=r.getString(teasession._nLanguage,"Goods.manufacturer")%>：</td>
      <td>
        <select name="company">
        <option value="0" >------------</option>
        <%
        Enumeration enumer=Node.find(" AND type=21 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND rcreator="+DbAdapter.cite(teasession._rv._strR),0,100);
        for(int i=0;enumer.hasMoreElements();i++)
        {
          int node_id=((Integer)enumer.nextElement()).intValue();
          out.print("<option value="+node_id);
          if(company==node_id)
          out.print(" SELECTED ");
          out.print(" >"+Node.find(node_id).getSubject(teasession._nLanguage));
        }
        %>
        </select>	  </td>
    </tr>
    <tr id="prorela1id">
      <td><%=r.getString(teasession._nLanguage,"Goods.correspond")%>：</td>
      <td>
        <select name="prorela1">
        <option value="0">------------</option>
        <%
        enumer=Node.find(" AND type=34 AND community="+DbAdapter.cite(node.getCommunity())+" AND rcreator="+DbAdapter.cite(teasession._rv._strR),0,100);
        for(int i=0;enumer.hasMoreElements();i++)
        {
          int node_id=((Integer)enumer.nextElement()).intValue();
          out.print("<option value="+node_id);
          if(correspond==node_id)
          out.print(" SELECTED ");
          out.print(" >"+Node.find(node_id).getSubject(teasession._nLanguage));
        }
        %>
        </select>
        <input type="button"  class="edit_input" name="Button" value="..." onClick="javascript:on_sel_rela('form1.prorela1');"></td>
    </tr>

    <tr id="prorela2id">
      <td><%=r.getString(teasession._nLanguage,"Goods.correspond2")%>：</td>
      <td>
      <select name="prorela2">
      </select>
        <input type="button" class="edit_input"  name="Submit3" value="..." onClick="javascript:on_sel_rela('form1.prorela2');"></td>
    </tr>

    <tr id="prorela3id">
      <td><%=r.getString(teasession._nLanguage,"Goods.correspond3")%>：</td>
      <td>
        <select name="prorela3">
      </select>
        <input type="button" class="edit_input"  name="Submit2" value="..." onClick="javascript:on_sel_rela('form1.prorela3');">      </td>
    </tr>

    <tr id="prorela4id">
      <td><%=r.getString(teasession._nLanguage,"Goods.correspond4")%>：</td>
      <td>        <select name="prorela4">
      </select>
        <input type="button"  class="edit_input" name="Submit4" value="..." onClick="javascript:on_sel_rela('form1.prorela4');"></td>
    </tr>


    <tr id="prorela5id">
        <td><%=r.getString(teasession._nLanguage,"Goods.correspond5")%>：</td>
      <td><select name="prorela5">
      </select>
        <input type="button" class="edit_input"  name="Submit5" value="..." onClick="javascript:on_sel_rela('form1.prorela5');"></td>
    </tr>


    <tr id="prorela6id">
      <td><%=r.getString(teasession._nLanguage,"Goods.correspond6")%>：</td>
      <td><select name="prorela6">
      </select>
        <input type="button" class="edit_input"  name="Submit6" value="..." onClick="javascript:on_sel_rela('form1.prorela6');"></td>
    </tr>
    <tr>
      <td>使用类型:</td>
      <td>
        <select name="used">
          <option value="0">------------</option>
          <option value="1" >前台展示</option>
          <option value="2" >卡管理使用</option>
        </select>
        <script type="">form1.used.value="<%=used%>";</script>
      </td>
    </tr>
    <tr>
      <td>提成类型:</td>
      <td>
        <input name="dtype" type="radio" value="false" checked="checked" id="dtype0"  /><label for="dtype0">基于系数</label>
        <input name="dtype" type="radio" value="true" id="dtype1" <%if(dtype)out.print(" checked='true'");%> /><label for="dtype1">基于数量</label>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      提成量:<input name="deduct" type="text" value="<%=deduct%>" mask="float"></td>
    </tr>



   <!-- <tr>
      <td><%=r.getString(teasession._nLanguage,"Goods.Capability")%>：</td>
      <td colspan="3"><input name="capability" class="edit_input"  type="text" value="<%=capability%>" size="50" maxlength="250">      </td>
    </tr>-->
   <%--<tr>
      <td><%=r.getString(teasession._nLanguage,"Text")%>：</td>
      <td colspan="3" ><textarea name="content"  class="edit_input" cols="70" rows="8" ><%=text%></textarea>*
</td>
    </tr>
    --%>
    <tr>
    <td colspan="2"><%=r.getString(teasession._nLanguage, "详细内容")%>:</td>
    </tr>
    <tr>
        <td colspan="2">
          <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=text%></textarea>
          <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
        </td>
      </tr>
    <%
    for(int index=1;index<gts.length;index++)
    {
      int gt_id=Integer.parseInt(gts[index]);
      if(gt_id>0)
      {
        java.util.Enumeration enumeration=Attribute.findByGoodstype(gt_id);
        int id=0;
        while(enumeration.hasMoreElements())
        {
          id=((Integer)enumeration.nextElement()).intValue();
          tea.entity.node.Attribute obj=tea.entity.node.Attribute.find(id);

          %>
          <tr>
            <td><%=obj.getName(teasession._nLanguage)%>:</td>
            <td colspan="4"><%=obj.getText(teasession._nNode,application,r,teasession._nLanguage)%>
            <%--
            if("file".equals(obj.getTypes())||"img".equals(obj.getTypes()))
            {
            %>
            <input type="file"  value="<%=value%>" class="edit_input" name="attribute<%=id%>" />
            <input  id="CHECKBOX" type="CHECKBOX" onclick="form1.attribute<%=id%>.disabled=this.checked" name="clearattribute<%=id%>"/><%=r.getString(teasession._nLanguage,"Clear")%>
            <%
            }else
            {
            %>
            <input  type="text"  value="<%=value%>" class="edit_input" name="attribute<%=id%>" />

            <%}--%>            <span class="huititable">*</span></td>
          </tr>
          <%
          }
        }
    }
    %>
  </table>

<br>
    <INPUT TYPE=SUBMIT name="Gosubmit" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "下一步 设置价格")%>">
  <!--  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">  -->
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoFinish")%>">

</form>
<script >

  var obj=form1.prorela1;
  for(var index=0;index<obj.options.length;index++)
  {
    form1.prorela2.options[form1.prorela2.length]=new Option(obj.options[index].text,obj.options[index].value);
    form1.prorela3.options[form1.prorela3.length]=new Option(obj.options[index].text,obj.options[index].value);
    form1.prorela4.options[form1.prorela4.length]=new Option(obj.options[index].text,obj.options[index].value);
    form1.prorela5.options[form1.prorela5.length]=new Option(obj.options[index].text,obj.options[index].value);
    form1.prorela6.options[form1.prorela6.length]=new Option(obj.options[index].text,obj.options[index].value);
    if(obj.options[index].value=='<%=correspond2%>')
    {
      form1.prorela2.options[form1.prorela2.length-1].selected=true;
    }
    if(obj.options[index].value=='<%=correspond3%>')
    {
      form1.prorela3.options[form1.prorela3.length-1].selected=true;
    }
    if(obj.options[index].value=='<%=correspond4%>')
    {
      form1.prorela4.options[form1.prorela4.length-1].selected=true;
    }
    if(obj.options[index].value=='<%=correspond5%>')
    {
      form1.prorela5.options[form1.prorela5.length-1].selected=true;
    }
    if(obj.options[index].value=='<%=correspond6%>')
    {
      form1.prorela6.options[form1.prorela6.length-1].selected=true;
    }
  }

  //删除,类别没有设置的品牌
  for(var index=1;index<form1.brand.options.length;index++)
  {
    if("<%=brand_sb.toString()%>".indexOf("/"+form1.brand.options[index].value+"/")==-1)
    {
      form1.brand.options[index]=null;
      index--;
    }
  }
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

