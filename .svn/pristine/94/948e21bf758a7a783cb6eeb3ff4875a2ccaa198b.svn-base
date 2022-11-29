<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="tea.entity.member.*" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer("");
int pos=0;
String member = null;
if(teasession.getParameter("member")!=null)
{
member = teasession.getParameter("member");
}
else
{
member=teasession._rv._strV;
}

int id = 0;
String shoppings = "";
int shopint = 0;
 String coding="";//商品编码
 String recomm="";//小编推荐
 String text="";//奖品介绍
 String explain="";//使用说明
 String spic=null,dpic=null;//小图和大图
 String rpic=null,statustype="";
 long len = 0,len2=0,len3=0;
 
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  id = Integer.parseInt(teasession.getParameter("id"));
  IntegralPrize obj = IntegralPrize.find(id);
  shoppings = obj.getShopping();
  shopint = obj.getShop_integral();
  
  
   coding=obj.getCoding();//商品编码
   recomm=obj.getRecomm();//小编推荐
   text=obj.getText();//奖品介绍
   explain=obj.getExplain();//使用说明
   spic=obj.getSpic();
   dpic=obj.getDpic(); 
   rpic=obj.getRpic();
   statustype=obj.getStatustype();
   
   if(spic!=null && spic.length()>0)
   {
   		len = new java.io.File(application.getRealPath(spic)).length();
   }
   if(dpic!=null && dpic.length()>0)
   {
   	   len2 = new java.io.File(application.getRealPath(dpic)).length();
   }
   if(rpic!=null && rpic.length()>0)
   {
	   len3 = new java.io.File(application.getRealPath(rpic)).length();
   }
} 
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>
	function f_sub()
	{
		if(form1.shopping.value=='')
		{
			alert('商品名称不能为空');
			form1.shopping.focus();
			return false;
		}
		if(form1.shop_integral.value=='')
		{
			alert('商品积分不能为空');
			form1.shop_integral.focus();
			return false;
		}
		if(form1.coding.value=='')
		{
			alert('商品编码不能为空');
			form1.coding.focus();
			return false;
		}
	
		
		
	}
</script>
<body bgcolor="#ffffff">
<h1>商品积分兑换率
</h1>
<form action="/servlet/EditIntegralManage" method="POST" enctype="multipart/form-data" name="form1" onsubmit="return f_sub();">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="integralprize"/>
<input type="hidden" name="id" value="<%=id%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr><td align="right"><font color=red>*</font>商品名称：</td><td><input type="text"  size="25" name="shopping" value="<%=shoppings%>"></td></tr>
<tr><td align="right"><font color=red>*</font>商品积分：</td><td><input type="text"  size="6"  name="shop_integral" value="<%=shopint%>"/></td></tr>
<tr><td align="right"><font color=red>*</font>商品编码：</td><td><input type="text"  size="6"  name="coding" value="<%=coding %>"/></td></tr>
<tr><td align="right"><font color=red>*</font>商品小图：</td><td><input type="file"   name="spic" value=""/>
 <%
      if(len> 0)
      {
        out.print("<a href='"+spic+"' target='_blank'>查看原图&nbsp;("+len + "字节)</a>");
        out.print("<input id='checkbox' type='checkbox' name='spiccheck' onclick='form1.spic.disabled=this.checked'>清空");
      }
      %>
</td></tr>
<tr><td align="right"><font color=red>*</font>商品大图：</td><td><input type="file"   name="dpic" value=""/>
<%
      if(len2> 0)
      {
        out.print("<a href='"+dpic+"' target='_blank'>查看原图&nbsp;("+len2 + "字节)</a>");
        out.print("<input id='checkbox' type='checkbox' name='dpiccheck' onclick='form1.dpic.disabled=this.checked'>清空");
      }
      %>
</td></tr>

<tr><td align="right"><font color=red>*</font>推荐图：</td><td><input type="file"   name="rpic" value=""/>
<%
      if(len3> 0)
      {
        out.print("<a href='"+rpic+"' target='_blank'>查看原图&nbsp;("+len3 + "字节)</a>");
        out.print("<input id='checkbox' type='checkbox' name='rpiccheck' onclick='form1.rpic.disabled=this.checked'>清空");
      }
      %>
</td></tr>
<tr><td align="right">显示位置：</td><td>
<input type="checkbox" name="statustype" value="1" <%if(statustype!=null && statustype.length()>0&& statustype.indexOf("/1/")!=-1){out.println(" checked");} %>>&nbsp;推荐礼品
<input type="checkbox" name="statustype" value="2" <%if(statustype!=null && statustype.length()>0&& statustype.indexOf("/2/")!=-1){out.println(" checked");} %>>&nbsp;热门礼品
<input type="checkbox" name="statustype" value="3" <%if(statustype!=null && statustype.length()>0&& statustype.indexOf("/3/")!=-1){out.println(" checked");} %>>&nbsp;特色商品
	
</td></tr>

<tr><td align="right">小编推荐：</td><td><textarea rows="3" cols="60" name="recomm"><%=recomm %></textarea> </td></tr>


 <tr>
<td align="right">奖品概述：</td> 
    <td nowrap >

      <textarea style="display:none" name="content" rows="12" cols="60" class="edit_input"><%=text %></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>

    </td>
  </tr>

<tr><td align="right">使用说明：</td><td><textarea rows="3" cols="60" name="explain"><%=explain %></textarea> </td></tr>

<tr><td colspan="2" align="center"><input type="submit" value="提交" /> <input type="button" name="Submit2" value="返回" onClick="window.history.back();"></td></tr>
</table>
</form>
</body>
</html>

