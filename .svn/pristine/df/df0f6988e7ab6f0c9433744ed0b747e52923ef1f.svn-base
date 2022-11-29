<%@page import="tea.entity.Attch"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
</head>
<%
Http h=new Http(request,response);

int product=h.getInt("product");
ShopProduct myp = ShopProduct.find(product);
List<ShopPackage> spl = ShopPackage.find(" AND product_id = "+product+" order by id ",0,100);
%>
<body style="margin:0px;">
<script src='/tea/jquery.js'></script>
<script type="text/javascript"> 
/* $(document).ready(function(){
  $(".tc_xx ul li").click(function(){
	  $(this).toggle(100);
      $(this).next().toggle(100);
  });
}); */
function showli1(obj){
	initli();
	$(obj).next().show();
	$(obj).hide();
	mt.fit();
}
function showli2(obj){
	$(obj).prev().show();
	$(obj).hide();
	mt.fit();
}
function initli(){
	var li1 = $(".li1");
	li1.each(function(){
		$(this).show();
	});
	var li2 = $(".li2");
	li2.each(function(){
		$(this).hide();
	});
}
</script>
<div class="tc_xx">
<ul>
<%
if(spl.size()>0){
		for(int i=0;i<spl.size();i++){
			ShopPackage sp = spl.get(i);
			out.print("<li class='li1' onclick='showli1(this)' ><span class='name'>"+sp.getPackageName()+"<strong>￥"+sp.getSetPrice());
			out.print("</strong></span><span class='pic'><table><tr><td value='middle' align='center'><img src='"+myp.getPicture('s')+"' /></td>");
			String [] sarr = sp.getProduct_link_id().split("\\|");
			for(int j=1;j<(sarr.length>5?5:sarr.length);j++){
				ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[j]));
				out.print("<td value='middle' align='center'><img src='"+s1.getPicture('s')+"' /></td>");
			}
			out.print("</tr></table></span></li>");
			out.print("<li class='li2' onclick='showli2(this)' style='display:none;' >");
			out.print("<span class='tit'>"+sp.getPackageName()+"</span>");
					out.print("<table class='tablecenter'>");
					//out.print("<tr><td>"+myp.name[1]+"</td></tr>");
					out.print("<tr><td>"+myp.getAnchorX('s')+myp.getAnchorX(1)+"</td></tr>");
				for(int j=1;j<sarr.length;j++){
					ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[j]));
					String[] arr1=s1.picture.split("[|]");
					//out.print("<img width='50' height='50' src="+s1.getPicture('s')+" /></li>");
	
					//out.print("<tr><td>"+s1.name[1]+"</td></tr>");
					out.print("<tr><td>"+s1.getAnchorX('s')+s1.getAnchorX(1)+"</td></tr>");
				}
				out.print("<tr><td style='border:none;'><font color='#000' style='font-size:14px;'>套装价：</font><font color='#FF7F27'><strong>￥"+MT.f(sp.getSetPrice(),2)+"</strong></font>　<font color='#999'>原价：￥"+MT.f(sp.getPrice(),2)+"</font></td></tr>");
				out.print("<tr><td style='border:none;' class='td_ls'><span>立省￥"+MT.f(sp.getPrice()-sp.getSetPrice(),2)+"</span></td></tr>");
				out.print("<tr><td><input type='button' value='加入购物车' onclick=car.add("+sp.getId()+",1,'/xhtml/folder/14110112-1.htm') /></td></tr>");
					out.print("</table>");
			out.print("</li>");
		}
}
%>
</ul>
<script type="text/javascript">
mt.fit();
</script>
</div>
</body>
</html>