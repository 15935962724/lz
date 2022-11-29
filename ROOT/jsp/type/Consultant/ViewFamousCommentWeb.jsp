<%@page import="tea.entity.pm.PoFamousComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.pm.PoFamousComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Attch"%>
<%
	Http h=new Http(request); 
	/* if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	} */
	/*
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	*/
	String nexturl = h.get("nexturl");
	
	int pfcid = h.getInt("pfcid");
	PoFamousComment pfc = PoFamousComment.find(pfcid);
	Profile p=Profile.find(pfc.getMember());
	
	String name = (MT.f(p.getName(h.language))!=null&&MT.f(p.getName(h.language)).length()>0?MT.f(p.getName(h.language)+"："):"");
	
	//Resource res=new Resource().add("/tea/resource/Consultant");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<style>
#tablecenter td table td{border:0}
#tablecenter td.td_title{padding:15px 0px;text-align:center; line-height:200%;font-size: 30px;font-family: '微软雅黑';color: #333;}
#tablecenter td.td_time{padding:0px 0px;border-bottom:1px #ccc solid;color:#999;height:25px;text-align:left;line-height:25px;}
#tablecenter td.td_cont{padding-top:20px !important;font-size: 12px;color: #333;line-height: 180%;}
#tablecenter td.td_cont img{max-width:620px;}
</style>

</head>
<body style="border:none;">
<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<form name="form1" method="post" action="/EditFamousComment.do" target="_ajax" onSubmit="return mt.check(this);">

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="pfcid" value="<%=pfcid %>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">

	<tr >
		<td align="center" class="td_title"><%out.print(name+MT.f(pfc.getTitle()));%></td>
	</tr>
	<tr >
		<td align="left" class="td_time"><span style="padding-right:170px;"><%out.print(MT.f(p.getName(h.language))!=null&&MT.f(p.getName(h.language)).length()>0?"名家"+"："+MT.f(p.getName(h.language)):""); %></span>&nbsp;&nbsp;<span>发布时间：<%=MT.f(pfc.getApplyTime()) %></span><div class="fx" id="fxiang" style="float:right;">

<div class="bdsharebuttonbox" style="width:140px;float:right;"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
<script>
window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
<span class="span1" style="float:right;color:#bbb;line-height:28px;display:block;">分享到：</span>
</div>

</div>
</td>
	</tr>
	<tr>
	    <td align="center" class="td_cont"><%=pfc.getContent().replaceAll("\r\n","")%></td>
	</tr>
	<tr>
	    <td style="text-align:center;padding-top:20px !important;padding-bottom:20px !important;"><input type="button" value="返回" onClick="window.history.back();" style="width: 85px;height: 25px;border: none;cursor: pointer;background: #418ED6;border-radius: 3px;color: #fff;"/></td>
	</tr>
	
</table>
</form>

<iframe src="/jsp/commentreview/CommentReview.jsp?fkeyid=<%=pfcid%>" width="100%" id='win' name='win' onload='Javascript:SetWinHeight(this)' frameborder='0' scrolling='no'></iframe>


<script type="text/javascript">
//form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form1.act.value = a;
  	form1.pfcid.value = t;
  	if(a=='edit'){
  		form1.action="?";
    	form1.target=form1.method='';
    	form1.submit();
  	}else if(a == 'del'){
  		mt.show("确认删除？资料也会被删除。",2,"form1.submit()");
	}
};
</script>
</body>
</html>