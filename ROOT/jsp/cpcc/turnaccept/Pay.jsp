<%@page contentType="text/html;charset=UTF-8" %>




<html>
<head>
<link href="/res/cpcc/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">

</div>

<div id="tablebgnone">
<h1>已分配稿酬信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=form1 METHOD=get action="?">
<input type="hidden" name="community" value=""/>
<input type="hidden" name="id" value=""/>

<h2>查询</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
<tr>
  <td>作者编号：
    <input type="text" name="trade" value=""/></td>
  <td> 作者姓名：
    <input type="text" name="price_from" value=""/></td>
</tr>
<tr>
<td>笔　　名：
     <input type="text" name="price_from" value=""/>        　　</td>
<td>身份证号：
  <input type="text" name="price_from2" value=""/></td>
<td><input type="submit" value="查询" onClick=""/></td>
</tr>
</table>
</form>

<FORM name=form2 METHOD=POST action="/servlet/EditTrade">

<input type="hidden" name="community" value=""/>
<input type="hidden" name="act" value="saleneworder"/>
<input type="hidden" name="trade" value=""/>

<h2>作者列表 </h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr id="tableonetr">
    <td>作者编号</td>
	<td>作者姓名</td>
    <td>联系电话</td>
    <td>身份证号</td>
    <td>处理</td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>刘强</td>
    <td>01065898525</td>
    <td>589652414784589658</td>
    <td><input name="button53" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>王家卫</td>
    <td>01065898525</td>
    <td>589689658541236598</td>
    <td><input name="button53" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>369552367</td>
	<td>吴宇森</td>
    <td>01065898525</td>
    <td>365789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>张艺谋</td>
    <td>01065898525</td>
    <td>986789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>冯小刚</td>
    <td>01065898525</td>
    <td>254789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>王家卫</td>
    <td>01065898525</td>
    <td>589689658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>369552367</td>
	<td>吴宇森</td>
    <td>01065898525</td>
    <td>365789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>张艺谋</td>
    <td>01065898525</td>
    <td>986789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>冯小刚</td>
    <td>01065898525</td>
    <td>254789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>王家卫</td>
    <td>01065898525</td>
    <td>589689658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>369552367</td>
	<td>吴宇森</td>
    <td>01065898525</td>
    <td>365789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>张艺谋</td>
    <td>01065898525</td>
    <td>986789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>冯小刚</td>
    <td>01065898525</td>
    <td>254789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>王家卫</td>
    <td>01065898525</td>
    <td>589689658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>369552367</td>
	<td>吴宇森</td>
    <td>01065898525</td>
    <td>365789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>张艺谋</td>
    <td>01065898525</td>
    <td>986789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    
    <td>569852367</td>
	<td>张艺谋</td>
    <td>01065898525</td>
    <td>986789658541236598</td>
    <td><input name="button5" type=button value="查看详细" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_1.jsp', '_blank','width=750,height=600,scrollbars=yes');"><input type="button" value="编辑" onClick="window.open('/jsp/cpcc/turnaccept/Pay_Edit.jsp','_self')"><input type="button" value="删除"></td>
  </tr>
</table>
<div style="text-align:left;width:80%"> 1 <A HREF="#">2</A> <A HREF="#">3</A> <A HREF="#">4</A> <A HREF="#">5</A> <A HREF="#">6</A> <A HREF="#">7</A> <A HREF="#">8</A> <A HREF="#">9</A> <A HREF="#">10</A> <A HREF="#">下一页</A> <A HREF="#" ID=CBLast>最后</A> </div>

</FORM>

<div><input type="button" name="adds" value="添加" onClick="window.open('/jsp/cpcc/turnaccept/AuthorInfo_Add.jsp','_self')"><input type="button" name="leadins" value="导入" onClick="window.open('/jsp/cpcc/turnaccept/ArticaInfo_leadin.jsp','_self')"></div>
<div id="head6"><img height="6" src="about:blank"></div>

</div>


</body>
</html>


