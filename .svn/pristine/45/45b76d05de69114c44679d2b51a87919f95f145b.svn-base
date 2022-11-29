<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page  import="java.util.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="java.net.URLEncoder"%><%@page import="tea.resource.*" %><%@page import="java.io.*" %>

<%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);



StringBuffer sql = new StringBuffer(" and community = ").append(DbAdapter.cite(teasession._strCommunity));
String name = teasession.getParameter("name");
sql.append(" and exists (select member from Volunteer v where v.member = p.member and v.membertype !=1 and  v.membertype!=0 ) ");
if(name!=null && name.length()>0)
{
	sql.append(" and  exists (select member from ProfileLayer pl where p.member = pl.member and pl.firstname = "+DbAdapter.cite(name)+" ) ");
}
String telephone = teasession.getParameter("telephone");
if(telephone!=null && telephone.length()>0)
{
	sql.append("  and ( mobile = "+DbAdapter.cite(telephone)+" or exists (select member from ProfileLayer pl where p.member = pl.member and pl.telephone = "+DbAdapter.cite(telephone)+" ) ) ");
}


Community community = Community.find(teasession._strCommunity);


%>





<!doctype html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css"/>
  <link href="/res/redribbon/cssjs/14090044L1.css" rel="stylesheet" type="text/css"/>
  <script src="/tea/tea.js" type="text/javascript"></script>
<style>
#bodyvl h1{width:1002px;margin-left:0px;}
body{border:none}
#bodyvl #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;}
#jstop_wz{padding:10px;border:1px solid #CCC;line-height:200%; font-size:12px;text-align:left;margin-top:100px;background:#fff}
#bodyvl h1{width:auto;margin-top:30px}
#bodyvl #tablecenter{width:960px !important;margin:0 0 30px 0}
</style>
  </HEAD>


  <script>
  	function f_sub()
  	{

  		if(form1.name.value=='')
  	    {
  			alert("请输入要查询的姓名");
  			form1.name.focus();
  			return false;
  	    }

  		if(form1.telephone.value=='')
  	    {
  			alert("请输入手机号或座机电话");
  			form1.telephone.focus();
  			return false;
  	    }else
  	    {
  	    	var str = document.form1.telephone.value;
  	        var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;

  	        if(!reg.test(str)&&isNaN(str)){
  	          alert("请输入正确的手机号或座机电话");
  	    	form1.telephone.focus();
  	          return false;
  	        }

  	    }

  		form1.submit();

  	}
  </script>

  <body id="bodyvl">
<div class="" id="Body">
<!--   <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
 --> 
 
<div id="Header"><script src="/res/js/jquery-1.11.1.min.js"></script>
<script>
function test(){
    $('.nav').children("li:has(ul)").hover(
        function(){
            //$(this).find("ul>li:last").addClass("li-last-s1");//给每个下拉菜单的最后一个li元素添加css样式，此处非必要
            $(this).children("ul").slideDown(300);//JQ的slideDown方法，显示下拉菜单
        },
        function(){
            $(this).children("ul").hide();//隐藏下拉菜单
        }
    );
}
</script>
<div class="jianf">主办单位：北京市防治艾滋病工作委员会办公室&nbsp;&nbsp;&nbsp;&nbsp;北京市卫生和计划生育委员会&nbsp;&nbsp;&nbsp;<a href="/servlet/SwitchLanguage?language=2">繁体中文版</a></div>
<div id="logo"><a href="http://www.bjrroc.org"><img src="/res/redribbon/structure/logo(1).jpg"></a></div>

<div id="caidan">
<ul id="nav" class="nav">
  <li><a href="http://www.bjrroc.org">首 页</a></li>
  <li class=""><a href="/html/redribbon/folder/27621-1.htm" title="新闻动态">新闻动态</a>
    <ul class="nav-son hidden" style="display: none;">
      <li class=""><a href="/html/redribbon/node/27629-1.htm">我市防艾动态</a></li>
      <li class=""><a href="/html/redribbon/node/27627-1.htm">国内防艾动态</a></li>
      <li class=""><a href="/html/redribbon/node/28051-1.htm">国际防艾动态</a></li>
    </ul>
  </li>
  <li class=""><a href="/html/redribbon/folder/30591-1.htm" target="_self" title="活动专题">活动专题</a>
    <ul class="nav-son hidden" style="display: none;">
      
      <li class=""><a href="/html/redribbon/node/14060028-1.htm" target="_self">“手心里的爱——2014年北京市红丝带手工艺品征集大赛”</a></li>
      <li class=""><a href="/html/redribbon/node/14070160-1.htm" target="_self">首都预防艾滋病宣传暖阳行动之 “A生活 爱动力”主题征文及交流活动</a></li>
      <li class=""><a href="/html/redribbon/node/29743-1.htm" target="_self">北京市“遏制艾滋 红丝带飘扬”主题海报征集大赛</a></li>
      <li class=""><a href="/html/redribbon/node/30593-1.htm" target="_self">首都预防艾滋病宣传志愿者“1+1”十进行动</a></li>
      <li class=""><a href="/html/redribbon/node/30678-1.htm" target="_self">视频专辑</a></li>
      <li class=""><a href="/html/redribbon/node/30708-1.htm" target="_self">第二十九届奥林匹克运动会与遏制艾滋</a></li>
      <li class=""><a href="/html/redribbon/node/30733-1.htm" target="_self">第21个世界艾滋病日专题</a></li>
      <li class=""><a href="/html/redribbon/node/31241-1.htm" target="_self">首都红丝带社团专区</a></li>
      
    </ul>
  </li>
  <li><a href="/html/redribbon/folder/27622-1.htm" target="_self" title="科普园地">科普园地</a>
    <ul class="nav-son hidden" style="display: none;">
      
      <li><a href="/html/redribbon/node/27630-1.htm" target="_self">认识艾滋</a></li>
      <li><a href="/html/redribbon/node/27631-1.htm" target="_self">医疗防治</a></li>
      <li><a href="/html/redribbon/node/34695-1.htm" target="_self">科研进展</a></li>
      
    </ul>
  </li>
  <li class=""><a href="/html/redribbon/folder/27624-1.htm" target="_self" title="政策法规">政策法规</a>
    <ul class="nav-son hidden" style="display: none;">
      
      <li class=""><a href="/html/redribbon/node/27633-1.htm" target="_self">资料下载</a></li>
      <li class=""><a href="/html/redribbon/node/27634-1.htm" target="_self">国家相关政策</a></li>
      <li><a href="/html/redribbon/node/27635-1.htm" target="_self">相关文章</a></li>
      
    </ul>
  </li>
  <li class=""><a href="/html/redribbon/folder/27625-1.htm" target="_self" title="志愿者中心">志愿者中心</a></li>
  <li><a href="/html/redribbon/folder/34673-1.htm" target="_self" title="禁毒专区">禁毒专区</a>
    <ul class="nav-son hidden">   
      <li><a href="/html/redribbon/node/34674-1.htm" target="_self">基础知识</a></li>
      <li><a href="/html/redribbon/node/34675-1.htm" target="_self">法制天地</a></li>
      <li><a href="/html/redribbon/node/34676-1.htm" target="_self">禁毒课堂</a></li>
      <li><a href="/html/redribbon/node/34677-1.htm" target="_self">服务指南</a></li>
      <li><a href="/html/redribbon/node/34719-1.htm" target="_self">我市禁毒动态</a></li>
      
    </ul>
  </li>
  <li><a href="/html/redribbon/folder/34726-1.htm" title="交流园地">交流园地</a>
    <ul class="nav-son hidden" style="display: none;">
      <li><a href="/html/redribbon/node/34727-1.htm">志愿者心声</a></li>
      <li><a href="/html/redribbon/node/34735-1.htm">活动专区</a></li>
      <li><a href="/html/redribbon/node/34741-1.htm">志愿者风采</a></li>
      <li><a href="/html/redribbon/node/34742-1.htm">志愿者课堂</a></li>
      
    </ul>
  </li>
    <li><a href="/html/redribbon/category/29763-1.htm" target="_self" title="在线咨询">在线咨询</a></li>
  </ul>

</div>
<div class="clear"></div>
<div class="centimg"><img src="/res/redribbon/structure/ghfhjfghg.png" usemap="#Map">
<map name="Map">
  <area shape="rect" coords="368,101,493,142" href="/html/redribbon/node/14070160-1.htm" target="_blank">
</map></div>
<script>
 test();
</script>



 <div id="jstop_wz">　　亲爱的志愿者，您好！首先感谢您对于艾滋病防治事业的关注，我们热忱的欢迎您加入首都预防艾滋病宣传教育的志愿团队！在未来的日子里，我们将共同学习相关知识与技能，开展和参与相关活动，携手为首都防艾事业做贡献。<br />

     　　自2008年以来，首都预防艾滋病宣传志愿者的队伍不断扩大，受到社会各界的广泛关注。2009年，全市开展的“1+1”十进行动更是吸引了五湖四海、各行各业的朋友们，把热衷防艾事业的有志之士团结到了一起！<br />

     　　为更好地发挥首都预防艾滋病宣传教育志愿者的作用，全面协调发展我市防治艾滋病宣传教育工作，我们将充分利用网络平台，在携手老朋友的同时邀请更多的新朋友加入我们，共同成长，共同为防艾事业更好地奉献和服务。<br />

      　　您只需要在下面输入您的姓名和注册时的手机号码进行查询，如果您是我们的老朋友，只需补充相关信息后即可。如果在系统中无法查询到您的信息，请您再行注册。<br />
    　　我们期待着您的加入！
  </div>
  <h1>志愿者注册查询</h1>
  <form name="form1" action="?" method="POST"  >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
  <table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter" >

  <tr>
    		<td align="right">姓名：</td>
    		<td><input type="text" name="name" value="<%=MT.f(name)%>"></td>
    </tr>

    <tr>
    		<td align="right">手机号或座机电话：</td>
    		<td><input type="text" name="telephone" value="<%=MT.f(telephone)%>"></td>

    </tr>

       <tr>
    		<td></td>
    		<td align="left"><input type="button" value="查询" onClick="f_sub();"></td>

    </tr>
</table>
  </form>
  <%
  	if(name!=null && name.length()>0 && telephone!=null && telephone.length()>0)
  	{
  %>

 <table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
   <tr id="tableonetr">
  	<td  nowrap>会员名</td>
  	<td nowrap>姓名</td>
  	<td nowrap>性别</td>
  	<td nowrap>职业</td>
  	<td nowrap>出生日期</td>
  	<td nowrap>操作</td>
  </tr>

   <%

   	Enumeration e = Profile.find(sql.toString(),0,10);
   if(!e.hasMoreElements())
   {

       out.print("<tr><td colspan=10 align=center>您还没有注册,请注册新会员.<a href=/jsp/volunteer/Volunteer.jsp?membertypeact=zc&vrsname="+Http.enc(name)+"&vrstelephone="+Http.enc(telephone)+">注册新会员</a></td></tr>");
   }
   	while(e.hasMoreElements())
   	{
   		String member =((String)e.nextElement());
   		Profile pobj = Profile.find(member);
   		Volunteer vobj = Volunteer.find(member);

   %>


   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
   	<td><%=member %></td>
   	<td><%=pobj.getFirstName(teasession._nLanguage) %></td>
   	<td><%if(!pobj.isSex())out.print("女");else{out.print("男");} %></td>
   	<td><%=pobj.getNULL(vobj.getZhiye()) %></td>
   	<td><%=Entity.sdf.format(pobj.getBirth()) %></td>
   	<td><input type=button value="这是我已注册信息，补充信息" onClick="window.open('/jsp/volunteer/Volunteer.jsp?membertypeact=dj&members=<%=URLEncoder.encode(member,"UTF-8")%>','_self');"></td>
   </tr>

   <%} %>


</table>

  <%

  	}
  %>

<div class="yej-m">
<p><a href="/servlet/Folder?node=27831">关于我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/servlet/Folder?node=27826">网站地图</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.bjrroc.org/');">设为首页</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:void(O);" onclick="window.external.AddFavorite(location.href, document.title);">加入收藏</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/servlet/Folder?node=27891">联系我们</a></p>
<div class="copy">Copyright ⓒ 2009 bjrroc.org All rights reserved <a href="http://www.miibeian.gov.cn/" target="_blank" class="icp">京ICP备05056889号-3</a>　技术支持：北京怡康科技有限公司<a href="/servlet/Node?node=30804&amp;apos;em=0&amp;apos;language=1"><img alt="" src="/res/redribbon/1005/10059946.gif"></a></div></div>
<!--    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
 -->
 </div> </body>
</html>

