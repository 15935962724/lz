<%@page import="tea.entity.util.Lucene"%>
<%@page import="tea.entity.sup.SupQualification"%>
<%@page import="com.sun.swing.internal.plaf.basic.resources.basic"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.resource.Resource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>


</script>
<style>
table.review{width:100%;float:left;font-size:12px;}
table.review td{}
table.review td.td01{font-weight:bold;}
</style>
<%
Http h=new Http(request);
int node=h.getInt("node", 0);
if(node==0){node=h.node;}
Node n=Node.find(node);
if(n!=null){
	Book b=Book.find(node);
	n.click();
	String name=MT.f(n.getSubject(h.language));%>
<form action="" method="post" name="form1">
<div class="title"><%=name %></div>

<table border="0" cellspacing="0" cellpadding="0" id="book_detailed">
  <tr>
    <td width="24%" rowspan="11" valign="top"><div class="pic"><img src="<%=b.getSmallPicture(h.language) %>"></div></td>
	<td colspan="3" align="left">定价：<span style="color:#D80000;font-size:18px;font-weight:bold;">￥<%=MT.f(b.getPrice().doubleValue(),2)%></span></td>
  </tr>
  
  <tr>
    <td colspan="3" align="left" class="ds">从书名：<%=b.getCollection(h.language) %></td>
  </tr>
  <tr>
    <td colspan="3" align="left">作者：<%=b.getSubTitle(h.language) %></td>
  </tr>
  <tr>
    <td colspan="3" align="left">出版时间：<%=MT.f(b.getPublishDate(),2) %><%=MT.f(b.getEdition(h.language))%></td>
	
  </tr>
  <tr>
    <td width="30%" align="left">ISBN:<%=b.getISBN() %></td>
    <%
    if(b.getAmountPage()>0){
    	%>
    	<td colspan="2" class="ds">页数：<%=b.getAmountPage() %></td>
    	<%
    }else{
    	out.print("<td colspan='2'></td>");
    }
    %>
    
  </tr>
  <tr>
    <td align="left">开本：<%=Book.BOOK_SFC[b.getSpecifications()] %></td>
    <%
    if(b.getAmountWord()>0){
    	%>
    	<td colspan="2">字数：<%=b.getAmountWord() %>&nbsp;千字</td>
    	<%
    }else{
    	out.print("<td colspan='2'></td>");
    }
    %>
    
  </tr>
  <tr>
    <td align="left">装帧：<%= new Resource().getString(h.language,Book.BOOK_BINDING[b.getBinding()]) %></td>
    <td colspan="2" class="ds">印张：<%=b.getTransfer(h.language) %></td>
  </tr>
  <tr>
    <td colspan="3" align="left">所属分类：<font color="#D80000"><%=SupQualification.find(b.getType()).getName(1) %></font></td>
  </tr>
  <tr>
    <td colspan="3" align="left">关键字：<font color="#D80000"><%=b.getKeyword(h.language) %></font></td>
  </tr>
  <tr>
    <td align="left" style="color:#5e5d5d;"><span style="float:left;line-height:16px;">我要买：</span><a href="#" class="jian" onclick="reduct()"></a><input type="text" value="1" onkeyup="this.value=this.value.replace(/\D/g,'')" name="count" size=3 class="manber"><a class="jia" onclick="add()"></a></td>
    <td colspan="2" align="left">
      <input type="button" name="button" value=" " onClick="car.add(<%=n._nNode%>,form1.count.value,'<%=request.getRequestURI()%>?node=<%=node %>')" style="border:none;background:url(/res/jskxcbs/structure/201401231648.jpg) center no-repeat;cursor:pointer;width:105px;height:30px;" />
      <input type="button" name="b" value="  " onClick="zx(<%=b.getDocnode()%>)" style="border:none;background:url(/res/jskxcbs/structure/201401231649.jpg) center no-repeat;cursor:pointer;width:105px;height:30px;" />
    </td>
  </tr>
  
</table>
</form>

<div id="tab">
 <div class=tab1><a href="#" onclick="tab1()">商品详情</a></div>
 <div class="tab2"><a href="#" onclick="tab2()">写书评</a></div>
</div>
<div id="content4">
<span class="tip">内容简介</span>
<span class="con"><%=n.getText(1)==null?"":n.getText(1) %></span>
<span class="tip">作者简介</span>
<span class="con"><%=b.getAuthorMsg(h.language)==null?"":b.getAuthorMsg(h.language) %></span>
<span class="tip">章节目录</span>
<span class="con" id="mulu" style="height:310px;overflow:hidden;float:left"><%=Lucene.t(b.getChapterMsg(h.language)).length()>0?b.getChapterMsg(h.language):""%></span>
<%-- <span class="con" id="mulu"><%=Lucene.t(b.getChapterMsg(h.language)).length()>500?b.getChapterMsg(h.language).substring(0, 500)+"....<a href='###' onclick=zhankai() id='zk' >展开</a>":b.getChapterMsg(h.language) %></span>
<span class="con" id="mulu2" style="display:none"><%=b.getChapterMsg(h.language)+"....<a href='###' onclick=hebing() id='hb' >合并</a>" %></span> --%>
<a href="###" onclick=zhankai() id="zk" style="<%=Lucene.t(b.getChapterMsg(h.language)).length()>0?"":"display:none"%>">显示全部</a>
<a href="###" onclick=hebing() id="hb" style="display:none">收起全部</a>
<script>
function zhankai(){
	document.getElementById("mulu").style.height="auto";
	document.getElementById("mulu").style.overflow="";
	document.getElementById("zk").style.display="none";
	document.getElementById("hb").style.display="";
}
function hebing(){
	document.getElementById("mulu").style.height="300px";
	document.getElementById("mulu").style.overflow="hidden";
	document.getElementById("zk").style.display="";
	document.getElementById("hb").style.display="none";
}
</script>
</div>
<!--<div id="content5" style="display: none;">
</div>-->
<%	  
}
%>
<script>
var tab1=function(){
	$('content4').style.display="";
	$('content5').style.display="none";
	document.getElementById('tab').className="tabone";
}
var tab2=function(){
	$('content4').style.display="none";
	$('content5').style.display="";
	document.getElementById('tab').className="tabtwo";
}
var reduct=function(){
	var num=form1.count.value;
	if(Number(num)>1)form1.count.value=Number(num)-1;
}
var add=function(){
	form1.count.value=Number(form1.count.value)+1;
}
var zx=function(a){
		if(a>0){
			location='/html/jskxcbs/files/'+a+'-1.htm';
		}else{
			mt.show("此书目前还没上传在线阅读文档！");
		}
}
</script>

