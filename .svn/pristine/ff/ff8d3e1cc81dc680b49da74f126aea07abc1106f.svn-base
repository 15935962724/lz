<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.pm.Transactions" %>
<%@ page import="java.util.Date" %>
<%@ page import="tea.entity.Entity" %>

<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	
	
	String key=h.get("tid")==null?"":h.get("tid");
	int tid = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	
	String varieties="",direction="",content="";
	Date ttime=new Date();
	int quantity=0;
	float tmoney=0f;
	if(tid>0){
		Transactions t=Transactions.find(tid);
		varieties=t.getVarieties();
		direction=t.getDirection();
		content=t.getContent();
		ttime=t.getTtime();
		quantity=t.getQuantity();
		tmoney=t.getTmoney();
	}
	


%>

<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script/md5.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}

.date {
background-image: url(/tea/image/date.gif);
background-repeat: no-repeat;
background-position: right;
/* width: 100px; */
cursor: pointer;
}
</style>
<script type="text/javascript">
 
</script>


<form name="form1" method="post" action="/EditTransactionRecord.do"  target="_ajax" onSubmit="return mt.submit(this)">

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="tid" value="<%=key%>">
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th">交易品种:</td>
		<td class="td01"><input name="varieties" type="text" value="<%=varieties%>" size="50"></td>
	</tr>
	<tr >
		<td class="th">交易方向:</td>
		<td class="td01"><input name="direction" type="text" value="<%=direction%>" size="50"></td>
	</tr>
	<tr >
		<td class="th">成交数量:</td>
		<td class="td01"><input name="quantity" type="text" value="<%=quantity%>" size="30"></td>
	</tr>
	<tr >
		<td class="th">成交金额:</td>
		<td class="td01"><input name="tmoney" type="text" value="<%=tmoney%>" size="30"></td>
	</tr>
	<tr >
		<td class="th">交易时间:</td>
		<td class="td01">
		<input name="ttime" class="date" onClick="mt.date(this,true,null)" value="<%=Entity.sdf2.format(ttime) %>" size="30" style="background:#f9f9f9 url(/res/Home/structure/list10.png) right center no-repeat;" >
		</td>
	</tr>
	<tr >
		<td class="th" valign="top" style="line-height:41px;">阐述理由:</td>
		<td>
			<textarea name="content" rows="5" cols="60" style="border-top:1px #999 solid;padding:0px 6px;line-height:30px;font-size:14px;color:#bababa;border-left:1px #999 solid;border-bottom:1px #e5e5e5 solid;border-right:1px #e5e5e5 solid;background:#f9f9f9;width:451px !important;"><%=content %></textarea>
		</td>
	</tr>
    <tr>
    	<td></td>
        <td><div align="left"><input type="submit" value="提交" style="background:url(/res/Home/structure/bg11.gif) center no-repeat;cursor:pointer;width:276px;height:43px;color:#fff;font-size:16px;font-weight:bold;border:none;"/></div></td>
    </tr>
</table>

</form>
