<%@page import="tea.entity.Http"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.member.WomenOptions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
String url=h.get("url","/html/Home/folder/14050004.htm");
int wotype=h.getInt("wotype", 0);
%>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
body{font-family:\5B8B\4F53,Arial Narrow,arial,serif;background:#FFFFFF;color:#000;font-size:12px;line-height:20px;text-align:left;}
a{color:#444;text-decoration:none;}
a:hover{color:#f60;text-decoration:none;}

/* tjskl-sidebar */
.tjskl-sidebar{width:100%;margin:0px auto;}
.tjskl-sidebar #submain_hidden{border-top:0;display:none;}
.tjskl-sidebar .bsb{border-bottom:1px solid #c8d2e5;border-top:0;}
/* tj_submain */
.tj_submain .title{display:none;}

.tj_submain{border:1px solid #c8d2e5;border-bottom:0;width:auto;font-weight:normal;}
.tj_submain .title{background:url("images/bg_01.gif") repeat-x 0 -38px;height:24px;line-height:24px;font-size:12px;font-weight:bold;width:161px;padding-left:20px;}
.tj_submain li{width:auto;height:30px;border-bottom:1px solid #E7F3FF;position:relative;}
.tj_submain li a{display:block;padding:0px 0px 0px 20px;height:30px;line-height:30px;}
.tj_submain li a.on{border-top:1px solid #e6002d;border-bottom:1px solid #e6002d;border-left:none;border-right:1px solid #fff;background:#fff;width:137px;height:30px;line-height:30px;padding:0px 0px 0px 20px;position:relative;z-index:90;}
.tj_submain span{width:180px;position:absolute;top:0;left:157px;z-index:1;background:#fff;border:#e6002d solid 1px;display:none;padding:10px 0px 0px 0px;}
.tj_submain span a{display:inherit;float:left;width:auto;border-right:1px solid #d9d9d9;font-size:12px;height:auto !important;line-height:14px !important;padding:0px 10px !important;margin-bottom:10px;}
.tj_submain span a:hover{text-decoration:underline;}

.tj_submain ul li{float:left;margin-right:10px;display:inline;}
.tj_submain ul li span a{text-decoration:none;}

.tj_submain #more_submenu a{background:url("images/subh_bg.gif") no-repeat;text-align:right;display:block;width:125px;padding-right:19px;cursor:pointer;}
.tj_submain #more_submenu a.show{background-position:100% 2px;}
.tj_submain #more_submenu a.less{background-position:100% -25px;}
</style>

<script type="text/javascript">
function do_list_row_show(strid){
	strid.getElementsByTagName('a')[0].className='on';
	strid.getElementsByTagName('span')[0].style.display="block";
	strid.style.position="relative";
}
function do_list_row_unshow(strid){
	strid.getElementsByTagName('a')[0].className='';
	strid.getElementsByTagName('span')[0].style.display="";
	strid.style.position="";
}
submenu = function(box,div){
	var div_classname = document.getElementById(div).getElementsByTagName('a')[0];
	if(div_classname.className=='show'){
		with(document.getElementById(box).style){
			height='auto';display='block';
		}
		div_classname.className='less';div_classname.innerHTML='收缩';
	}else{
		with(document.getElementById(box).style){
			height='0';display='none';
		}
		div_classname.className='show';div_classname.innerHTML='展开';
	}
}
</script>
<div class="tjskl-sidebar">
<ul class="tj_submain">
<li class="title"><a href="">全部商户</a></li>			
<%
Enumeration e= WomenOptions.find(" and type=0 and wotype="+wotype, 0, Integer.MAX_VALUE);
while(e.hasMoreElements()){
	int id=(Integer)e.nextElement();
	WomenOptions w=WomenOptions.find(id, h.language);
	%>
	<li onmouseout="do_list_row_unshow(this);" onmouseover="do_list_row_show(this);" style="">
	<a href="<%=url %>?type=<%=id%>" class=""><%=w.getWoname() %></a>
	<span style="">
	<%
	Enumeration e2= WomenOptions.find(" and type="+id, 0, Integer.MAX_VALUE);
	while(e2.hasMoreElements()){
		int id2=(Integer)e2.nextElement();
		WomenOptions w2=WomenOptions.find(id2, h.language);
		%>
		<a href="<%=url %>?type=<%=id2%>" ><%=w2.getWoname() %></a>
		<%
	}
	out.print("</span></li>");
}
%>
</ul>
</div>