<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<%--<script language=vbscript src="normal.vbs"></script>--%>
<script language="JavaScript" src="normal.js"></script>
<SCRIPT language=javascript>
function  addtext(a,b)
{
	var objInput=eval("document.form1." + a);
	objInput.value=objInput.value+' '+b;
}
</SCRIPT>
<script language="vbscript">
function Lthan5K()
	if lenB(document.form1.ProRemark.value)>100000000 then
		Lthan5K = false
	else
		Lthan5K = true
	end if
end function
</script>
<script language="JavaScript">
<!--
var del = false;

function open_win(url2,title2,height2,width2)
{
	window.open(url2,title2,'height='+height2+',width='+width2+',left=50,top=50,resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');
}

function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
window.showModalDialog("ProductSel.jsp?index="+index,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}

function firtype_change()
{
	var str='';
	if (document.form1.select.value!="")
	{
		firtype = document.form1.firtype_str.value.split("`")
		sectype = document.form1.sectype_str.value.split("`");
		for (type in sectype)
		{
			tmp = sectype[type].split(";");
			if (tmp[0]==document.form1.select.value)
				str += '<option value="'+tmp[2]+'">'+tmp[1]+'</option>';
		}
	}
	if (str != "")
	{
		sec.innerHTML = '<select name="select2" onchange="javascript:sectype_change();"><option selected>请选择...</option>'+str+'</select>';

		thi.innerHTML = '<select name="select3" onchange="javascript:thitype_change();"><option selected>请选择...</option></select>';
	}
	else
	{
		sec.innerHTML = '<select name="select2" onchange="javascript:sectype_change();"><option selected>请选择...</option></select>'

		thi.innerHTML = '<select name="select3" onchange="javascript:thitype_change();"><option selected>请选择...</option></select>';
	}
}

function sectype_change()
{
	var str='';
	if (document.form1.select2.value!="")
	{
		sectype = document.form1.sectype_str.value.split("`");
		thitype = document.form1.thitype_str.value.split("`");
		for (type in thitype)
		{
			tmp = thitype[type].split(";");
			if (tmp[0]==document.form1.select2.value)
				str += '<option value="'+tmp[2]+'">'+tmp[1]+'</option>';
		}
	}

	if (str != "")
		thi.innerHTML = '<select name="select3" onchange="javascript:thitype_change();"><option selected>请选择...</option>'+str+'</select>';
	else
		thi.innerHTML = '<select name="select3" onchange="javascript:thitype_change();"><option selected>请选择...</option></select>'
}

function thitype_change()
{

}

function before_submit()
{
	if (del==true)
	{
		/*if (document.form1.ProTypeID.value=="")
		{
			alert('记得关联类哦!');
			return false;
		}*/
	}
	else
	{/*
		if (document.form1.ProTypeID.value=="")
		{
			alert('记得关联类哦!');
			return false;
		}*/
		if (document.form1.ProName.value=="")
		{
			alert('请填写产品名称!');
			document.form1.ProName.focus();
			return false;
		}
		if (document.form1.ProSay1.value=="")
		{
			alert('请填写价格1标题!');
			document.form1.ProSay1.focus();
			return false;
		}
		if (document.form1.ProPrice1.value!="")
		{
			if (isNaN(document.form1.ProPrice1.value))
			{
				alert('只能输入数字!');
				document.form1.ProPrice1.focus();
				return false;
			}
		}
		else
			document.form1.ProPrice1.value = 0;

		if (document.form1.ProPrice2.value!="")
		{
			if (isNaN(document.form1.ProPrice2.value))
			{
				alert('只能输入数字!');
				document.form1.ProPrice2.focus();
				return false;
			}
		}
		else
			document.form1.ProPrice2.value = 0;
		if (document.form1.ProPrice3.value!="")
		{
			if (isNaN(document.form1.ProPrice3.value))
			{
				alert('只能输入数字!');
				document.form1.ProPrice3.focus();
				return false;
			}
		}
		else
			document.form1.ProPrice3.value = 0;
		if (document.form1.ProPriceVIP.value!="")
		{
			if (isNaN(document.form1.ProPriceVIP.value))
			{
				alert('只能输入数字!');
				document.form1.ProPriceVIP.focus();
				return false;
			}
		}
		else
			document.form1.ProPriceVIP.value = 0;
		if (document.form1.ProPriceSVIP.value!="")
		{
			if (isNaN(document.form1.ProPriceSVIP.value))
			{
				alert('只能输入数字!');
				document.form1.ProPriceSVIP.focus();
				return false;
			}
		}
		else
			document.form1.ProPriceSVIP.value = 0;
		if (document.form1.ProInte.value!="")
		{
			if (isNaN(document.form1.ProInte.value))
			{
				alert('只能输入数字!');
				document.form1.ProInte.focus();
				return false;
			}
		}
		else
			document.form1.ProInte.value = 0;
		if (document.form1.ProRela.value!="")
		{
			if (isNaN(document.form1.ProRela.value))
			{
				alert('只能输入数字!');
				document.form1.ProRela.focus();
				return false;
			}
		}
		else
			document.form1.ProRela.value = 0;

		if (!Lthan5K())
		{
			alert('详细介绍过长，请减少输入量!');
			document.form1.ProRemark.focus();
			return false;
		}

		if (form1.ProHelp.value.lengtd>1000)
		{
			alert('帮助信息过长，请减少输入量!');
			document.form1.ProHelp.focus();
			return false;
		}

		for (i=0;i<document.form1.elements.length;i++)
		{
			if (document.form1.elements[i].value.indexOf("'")>=0)
			{
				alert("非法字符[ ' ]");
				document.form1.elements[i].focus();
				return false;
			}
			if (document.form1.elements[i].value.indexOf("`")>=0)
				if (document.form1.elements[i].type != "hidden")
				{
					alert("非法字符[ ` ]");
					document.form1.elements[i].focus();
					return false;
				}
		}
	}

	return true;
}

function sel_type()
{
	sel_sel.style.display = '';
}

function sup_sel()
{
	if (document.form1.select4.value!="")
	{
		document.form1.ProRela.value = document.form1.select4.value;
		if (document.form1.select5.value!="")
			document.form1.ProRela.value = document.form1.select5.value;
		if (document.form1.select6.value!="")
			document.form1.ProRela.value = document.form1.select6.value;
	}
	else
		document.form1.ProRela.value = "";
	sel_sel.style.display = 'none';
}

function sel_cel()
{
	sel_sel.style.display = 'none';
}
//-->
</script>
<script language="JavaScript">
<!--


<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
//-->
</script>
<link href="../css/css.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--body{background-color:#ffffff}.style1 {color: #FFFFFF}
-->
</style>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<h1><%=r.getString(teasession._nLanguage, "Weblog")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name=form1 action="/servlet/EditGoods" method="post" enctype=multipart/form-data onSubmit="javascript:return before_submit();">
  <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
            Goods goods=Goods.find(0,teasession._nLanguage);
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="";
   Date issueDate=null;
   String text="";
   long lensmaill=0,lenbig=0,lenrecommend=0;
            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {subject=node.getSubject(teasession._nLanguage);
         goods=Goods.find(teasession._nNode);
         issueDate=node.getTime();
         text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
lensmaill=new java.io.File( application.getRealPath(goods.getSmallpicture())).length();
lenbig=new java.io.File( application.getRealPath(goods.getBigpicture())).length();
lenrecommend=new java.io.File( application.getRealPath(goods.getCommendpicture())).length();
        }
            %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap class=huititable>品牌：</td>
      <td nowrap class=huititable><select name="brand">
          <option value="0" >请选择...</option>
          <%
java.util.Enumeration enumer=Brand.findByLanguage(teasession._nLanguage);
while(enumer.hasMoreElements())
{
  Brand obj=Brand.find(((Integer)enumer.nextElement()).intValue());
%>
          <option value="<%=obj.getBrand()%>" <%=getSelect(goods.getBrand()==obj.getBrand())%> ><%=obj.getName()%></option>
          <%}%>
        </select>
        <input type="button"  class="edit_button" value="<%=r.getString(teasession._nLanguage,"New")%>" onClick="javascript:open_win('/jsp/type/brand/EditBrand.jsp','',400,800);">
        <input name="fff" type=BUTTON class="edit_button" onClick="javascript:window.open('/jsp/type/brand/ManageBrand.jsp?node=<%=teasession._nNode%>');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
        <%--              <input type="button" name="pinpai" value="查询品牌" onclick="javascript:open_win('brand_que.asp','',500,620);">--%>
      </td>
      <td nowrap class=huititable></td>
    </tr>
    <tr>
      <td nowrap class=huititable>&nbsp;&nbsp; 产品编号：</td>
      <td nowrap class=huititable><!--<input name="ProNum" type="text" value="A" size="25" maxlength="50">
         *  -->
        产品编号自动生成 </td>
      <!--
      <td class=huititable  width="19%">价格标题：</td>
      <td class=huititable> <input name="ProSay1" class="edit_input"  type="text" value="<%=(goods.getName()==null||goods.getName().length()==0?"成本价":goods.getName())%>" size="25" maxlength="50"></td>
-->
    </tr>
    <tr>
      <td nowrap class=huititable >&nbsp;&nbsp; 产品名称：</td>
      <td nowrap class=huititable ><input name="ProName" class="edit_input"  type="text" value="<%=subject%>" size="25" maxlength="100">
        * </td>
      <!--   <td class=huititable >价格1：</td>
      <td class=huititable > <input class="edit_input"  type="text" name="ProPrice1" size="25" value="<%=getNull(goods.getPrice())%>"></td>
    -->
    </tr>
    <tr>
      <td nowrap class=huititable >&nbsp;&nbsp; 计量单位：</td>
      <td nowrap class=huititable ><input name="ProUnit" class="edit_input"  type="text" value="<%=goods.getMeasure()%>" size="25" maxlength="50">
      </td>
      <!--      <td class=huititable >价格2标题：</td>
      <td class=huititable > <input name="ProSay2" class="edit_input"  type="text" value="市场价" size="25" maxlength="50">
      </td>-->
    </tr>
    <tr>
      <td nowrap class=huititable >&nbsp;&nbsp; 产品规格：</td>
      <td nowrap class=huititable ><input name="ProSpec" class="edit_input"  type="text" value="<%=goods.getSpec()%>" size="25" maxlength="50">
      </td>
      <!--      <td class=huititable >价格2：</td>
      <td class=huititable > <input class="edit_input"  type="text" name="ProPrice2" size="25" value="<%=goods.getPrice2()%>">
      </td>-->
    </tr>
    <tr>
      <td nowrap class=huititable >&nbsp;&nbsp; 功能描述：</td>
      <td nowrap class=huititable ><input name="ProFunc" class="edit_input"  type="text" value="<%= goods.getCapability()%>" size="25" maxlength="250">
      </td>
      <!--
      <td class=huititable >价格3标题：</td>
      <td class=huititable > <input name="ProSay3" class="edit_input"  type="text" value="玫瑰坊价" size="25" maxlength="50">
      </td>
    </tr>
    <tr>
      <td class=huititable >&nbsp;&nbsp; VIP价格标题：</td>
      <td class=huititable ><input name="ProSayVIP" class="edit_input"  type="text" value="VIP价" size="25" maxlength="50">
      </td>
      <td class=huititable >价格3：</td>
      <td class=huititable ><input class="edit_input"  type="text" name="ProPrice3" size="25" value="<%=goods.getPrice3()%>">
      </td>
    </tr>
    <tr>
      <td class=huititable >&nbsp;&nbsp; VIP价格：</td>
      <td class=huititable > <input class="edit_input"  type="text" name="ProPriceVIP" size="25" value="<%=goods.getPrice4()%>"></td>
      <td class=huititable >SuperVIP价格标题：</td>
      <td class=huititable ><input name="ProSaySVIP" class="edit_input"  type="text" value="超级VIP价" size="25" maxlength="50">
      </td>
    </tr>-->
    <tr>
      <td nowrap class=huititable ><!--&nbsp;&nbsp; 购买积分：--></td>
      <td nowrap class=huititable ><!-- <input class="edit_input"  type="text" name="ProInte" size="25" value="">-->
      </td>
      <!--      <td class=huititable >SuperVIP价格：</td>
      <td class=huititable > <input class="edit_input"  type="text" name="ProPriceSVIP" size="25" value="<%=goods.getPrice5()%>">
      </td>-->
    </tr>
    <tr>
      <td nowrap class=huititable>&nbsp;&nbsp; 小图片文件： </td>
      <td valign="top" nowrap class=huititable><%-- <iframe style="top:2px" ID="UploadFiles" src="upload_Photo.asp?PhotoUrlID=0" frameborder=0 scrolling=no width="250" height="25"></iframe>
      尺寸: 99X118
      <input name="ProSPic" type="hidden" id="ProSPic" value="">--%>
        <input name="smallpicture" type="file"  class="edit_input" size="15"  />
        <%if(lensmaill>0)out.print(lensmaill);%>
        <input  id="CHECKBOX" type="CHECKBOX" name="clearsmallpicture"/>
        清空 </td>
      <td nowrap class=huititable>大图片文件：</td>
      <td valign="top" nowrap class=huititable><%--<iframe style="top:2px" ID="UploadFiles" src="upload_Photo.asp?PhotoUrlID=1" frameborder=0 scrolling=no width="250" height="25"></iframe>
        <input name="ProBPic" type="hidden" id="ProBPic" value="">尺寸：300X250--%>
        <input name="bigpicture" type="file"  class="edit_input" size="15"  />
        <%if(lenbig>0)out.print(lenbig);%>
        <input  id="CHECKBOX" type="CHECKBOX" name="clearbigpicture"/>
        清空 </td>
    </tr>
    <tr>
      <td align="center" valign="middle" nowrap class=huititable><div align="left">　 推荐图片： </div></td>
      <td align="center" valign="middle" nowrap class=huititable><div align="left">
          <%-- %>      <iframe style="top:2px" ID="UploadFiles" src="upload_Photo.asp?PhotoUrlID=2" frameborder=0 scrolling=no width="250" height="25">
      <input name="ProXPic" type="hidden" id="ProXPic" value="">
      </iframe>--%>
          <input name="recommendpicture" type="file"  class="edit_input" size="15"  />
          <%if(lenrecommend>0)out.print(lenrecommend);%>
          <input  id="CHECKBOX" type="CHECKBOX" name="clearrecommendpicture"/>
          清空 </div></td>
      <td rowspan="2" nowrap class=huititable>产品状态：</td>
      <td rowspan="2" valign="top" nowrap class=huititable><select name="ProState">
          <option value="1" selected >有货</option>
          <option value="0" <%=getSelect(!goods.isStatus())%>>缺货</option>
        </select></td>
    </tr>
    <tr>
      <td colspan="2" align="center" valign="middle" nowrap class=huititable><p> </p>
        <p> </p></td>
    </tr>
    <%--
    <tr>
      <td class=huititable > &nbsp;&nbsp;
        <!--相关产品类别：-->
        热销产品：</td>
      <td class=huititable > <input type="hidden" name="ProRela" value="" onFocus="javascript:sel_type();">
        <input  id="radio" type="radio" name="ProHot1" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot1" value="0" checked>
        否 </td>
      <td class=huititable >是否上榜：</td>
      <td class=huititable ><input  id="radio" type="radio" name="ProHot2" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot2" value="0" checked>
        否 </td>
    </tr>
    <tr>
      <td class=huititable > &nbsp;&nbsp; 首页精品热卖</td>

      <td class=huititable ><input  id="radio" type="radio" name="ProHot3" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot3" value="0" checked>
        否 </td>
      <td class=huititable >是否显示：</td>
      <td class=huititable ><input name="ProHot4"  id="radio" type="radio" value="1" checked >
        是
        <input  id="radio" type="radio" name="ProHot4" value="0" checked>
        否 </td>
    </tr>
    <tr>
      <td class=huititable >&nbsp;&nbsp; 本月特价：</td>
      <td class=huititable ><input  id="radio" type="radio" name="ProHot5" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot5" value="0" checked>
        否 </td>
      <td class=huititable >此类推荐商品：</td>
      <td class=huititable ><input  id="radio" type="radio" name="ProHot6" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot6" value="0" checked>
        否 </td>
    </tr>
    <tr>
      <td class=huititable >&nbsp;&nbsp; 畅销区新品推荐</td>
      <td class=huititable ><input  id="radio" type="radio" name="ProHot7" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot7" value="0" checked>
        否 </td>
      <td class=huititable >是否精品：</td>
      <td class=huititable ><input  id="radio" type="radio" name="ProHot8" value="1" >
        是
        <input  id="radio" type="radio" name="ProHot8" value="0" checked>
        否 </td>
    </tr>
    <tr>
      <td class=huititable >&nbsp;&nbsp; 特价：</td>
      <td class=huititable ><input  id="radio" type="radio" name="SpecPrice" value="1" >
        是
        <input  id="radio" type="radio" name="SpecPrice" value="0" checked>
        否 </td>
      <td class=huititable >&nbsp;</td>
      <td class=huititable >&nbsp;</td>
    </tr>--%>
    <tr>
      <td  colspan="2" nowrap class=huititable>&nbsp;&nbsp; 配套产品1编号：
        <input name="ProRela1" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond())%>" size="15">
        <input type="button"  class="edit_input" name="Button" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela1');"></td>
      <td  colspan="2" nowrap class=huititable>配套产品4编号：
        <input name="ProRela4" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond4())%>" size="15">
        <input type="button"  class="edit_input" name="Submit4" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela4');"></td>
    </tr>
    <tr>
      <td  colspan="2" nowrap class=huititable>&nbsp;&nbsp; 配套产品2编号：
        <input name="ProRela2" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond2())%>" size="15">
        <input type="button" class="edit_input"  name="Submit3" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela2');"></td>
      <td  colspan="2" nowrap class=huititable>配套产品5编号：
        <input name="ProRela5" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond5())%>" size="15">
        <input type="button" class="edit_input"  name="Submit5" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela5');"></td>
    </tr>
    <tr>
      <td  colspan="2" nowrap class=huititable>&nbsp;&nbsp; 配套产品3编号：
        <input name="ProRela3" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond3())%>" size="15">
        <input type="button" class="edit_input"  name="Submit2" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela3');">
      </td>
      <td  colspan="2" nowrap class=huititable>配套产品6编号：
        <input name="ProRela6" class="edit_input"  type="text" value="<%=getNull(goods.getCorrespond6())%>" size="15">
        <input type="button" class="edit_input"  name="Submit6" value="选择..." onClick="javascript:on_sel_rela('form1.ProRela6');"></td>
    </tr>
    <tr>
      <td colspan="5" valign="top" nowrap class=huititable>&nbsp;&nbsp; 详细介绍：&nbsp; </td>
    </tr>
    <tr>
      <td colspan="50" valign="top" nowrap class=huititable>&nbsp;&nbsp;
        <textarea name="ProRemark"  class="edit_input" cols="80" rows="10" wrap="VIRTUAL"><%=text%></textarea>
      </td>
    </tr>
    <%java.util.Enumeration enumeration=Attribute.find(community,teasession._nLanguage);
        int id=0;
     while(enumeration.hasMoreElements())
     {
     id=((Integer)enumeration.nextElement()).intValue();
       tea.entity.member.AttributeValue objAttributeValue = tea.entity.member.AttributeValue.find(teasession._nNode, id);
       String value;
       if(objAttributeValue.isExists())
       {value=objAttributeValue.getAttrvalue();
       }else
       value="";
     Attribute obj=Attribute.find(id);%>
    <tr>
      <td ><%=obj.getName()%>:</td>
      <td><input  type="text"  value="<%=value%>" class="edit_input" name="attribute<%=id%>" />
        <%=obj.getText("select"+id,"form1.attribute"+id+".value+=form1.select"+id+".options[form1.select"+id+".selectedIndex].value+' ';")%></td>
    </tr>
    <%   }%>
  </table>
  <div align="center">
    <INPUT TYPE=SUBMIT name="submit" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input type="reset" name="reset" value="重新填写" class="edit_button"  >
    <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoFinish")%>">
    <%--    <input type="submit" name="submit" value="删除该产品" onclick="javascript:del=true;">--%>
    <input type="hidden" name="firtype_str" value="1043;A`1044;C`1045;D`1046;E`1047;F`1048;G`1049;H`1050;I`1051;J`1052;B">
    <input type="hidden" name="sectype_str" value="1052;卡通;1059;B001`1052;3D;1060;B002`1045;大陆流行;1063;D001`1045;港台流行;1066;D002`1046;中国动画;1069;E001`1047;戏剧;1070;F001`1047;小品;1071;F002`1048;饮食/烹饪;1074;G001`1049;传记名人;1076;H001`1050;小说;1078;I001`1051;报纸;1080;J001`1052;杀毒类;1084;B003`1050;生活;1086;I003`1050;文化;1087;I002`1049;历史地理;1090;H002`1049;人文探索;1091;H003`1048;历史/地理;1094;G002`1048;军事/战争;1095;G003`1047;相声;1098;F003`1046;日本动画;1099;E002`1046;西方动画;1100;E003`1045;欧美流行;1103;D003`1051;刊物;1107;J002`1051;文件;1108;J003`1043;大陆电影;1116;A001`1043;港台电影;1117;A002`1044;大陆电视剧;1121;C001`1043;欧美电影;1122;A005`1043;日韩电影;1123;A003`1043;其它地区电影;1124;A006`1044;港台电视剧;1125;C002`1044;韩国电视剧;1127;C003`1044;日本电视剧;1128;C005`1044;其它地区电视剧;1129;C006`1045;古典音乐;1130;D005`1045;轻音乐;1131;D006`1045;音乐会;1132;D007`1045;民族音乐;1133;D008`1045;儿童音乐;1134;D009`1045;宗教音乐 ;1135;D010`1045;影视音乐;1136;D011`1047;其它曲艺;1137;F005`1048;中华武术;1138;G005`1048;医疗保健;1139;G006`1048;舞蹈;1140;G007`1048;其它;1141;G008">
    <input type="hidden" name="thitype_str" value="1059;人物;1061;B1-0`1059;动物;1062;B1-2`1078;国内;1079;I0011`1080;国内;1081;J0011`1059;游戏;1085;B0013`1078;国际;1088;I0012`1078;港台;1089;I0013`1080;国际;1109;J0012`1080;港台;1110;J0013">
    <input type="hidden" name="ProID" value="">
    <input type="hidden" name="TypeNum" value="1043">
  </div>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

