<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.entity.*"%>
<%
Http h=new Http(request,response);

//status{"活动状态","未开始","已结束","进行中"}
//type{"微活动类型","刮刮卡","幸运水果机","幸运大转盘","砸金蛋"}
int status = h.getInt("status");
int type = h.getInt("type");
int nochance = h.getInt("nochance");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="description" content="微信">
<title>
<%
if(status==1){//未开始
	out.print("活动未开始");
}else if(status==2){//已结束
	out.print("活动结束");
}else{//进行中
	if(nochance>0){//机会已用完
		out.print("今日抽奖次数已用完");
	}
}
%>
</title>
<script src="/tea/jquery.js" type="text/javascript"></script>

<link type="text/css" rel="stylesheet" href="/tea/weixin/css/activity-abnormal.css">
</head>

<body class="activity-scratch-end">
    <div class="main">
	    <div class="banner">
	    	<%
	    	if(status==1){//未开始
	    		out.print("<img src='/tea/weixin/image/abnormal/activity-not-scratch.png'>");
	    	}else if(status==2){//已结束
	    		if(type==1){
	    			out.print("<img src='/tea/weixin/image/abnormal/activity-endggk.jpg'>");
	    		}else if(type==2){
	    			out.print("<img src='/tea/weixin/image/abnormal/activity-endxyj.jpg'>");
		    	}else if(type==3){
	    			out.print("<img src='/tea/weixin/image/abnormal/activity-endxydzp.jpg'>");
		    	}else if(type==4){
	    			out.print("<img src='/tea/weixin/image/abnormal/activity-endegg.jpg'>");
		    	}
	    	}else{//进行中
	    		if(nochance>0){//机会已用完
	    			if(type==1){
		    			out.print("<img src='/tea/weixin/image/abnormal/chance-endggk.jpg'>");
		    		}else if(type==2){
		    			out.print("<img src='/tea/weixin/image/abnormal/chance-endxyj.jpg'>");
			    	}else if(type==3){
		    			out.print("<img src='/tea/weixin/image/abnormal/chance-endxydzp.jpg'>");
			    	}else if(type==4){
		    			out.print("<img src='/tea/weixin/image/abnormal/chance-endegg.jpg'>");
			    	}
	    		}
	    	}
	    	%>
        </div>
        <div class="content" style=" margin-top:10px">
            <div class="boxcontent">
                <div class="box">
                    <div class="title-red">
                    	<%
                    	if(status==1){//未开始
            	    		out.print("活动未开始");
            	    	}else if(status==2){//已结束
            	    		out.print("活动结束");
            	    	}else{//进行中
            	    		if(nochance>0){//机会已用完
            	    			out.print("机会已用完");
            	    		}		
            	    	}
                    	out.print("说明：");
                    	%>
                    	</div>
                    <div class="Detail">
                        <p> 
                        <%
                    	if(status==1){//未开始
            	    		out.print("亲，此活动还未开始，请耐心等待。");
            	    	}else if(status==2){//已结束
            	    		out.print("亲，活动已经结束，请继续关注我们的后续活动哦。");
            	    	}else{//进行中
            	    		if(nochance>0){//机会已用完
            	    			out.print("亲，您今日的机会用完了，明天再来吧。");
            	    		}	
            	    	}
                    	%>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body></html>