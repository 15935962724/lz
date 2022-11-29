<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

/*if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
*/



int psid = Integer.parseInt(teasession.getParameter("psid"));

PerformStreak psobj = PerformStreak.find(psid);
//演出名称
Node nobj1= Node.find(psobj.getNode());
//演出场馆
Node nobj2 = Node.find(psobj.getVenues());

Seat sobj = Seat.find(psobj.getVenues());


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>在线选座(无座位图)</title>
</head>

<body id="bodynone" >
<script>
//添加行
  function   myImgs(vname,vtimes,vp)   
  {   
   document.getElementById('show').innerHTML = '总共:&nbsp;<input type=text id=zg name = zg>&nbsp;元';
	var inputid = document.getElementById('as'+vp);
	if(inputid==null)//没有这个id的tr
	{
	    var   myTable   =   document.getElementById("aa");  
	    var   newRow   =   aa.insertRow(aa.rows.length);
	   // newRow.bgColor = 'red';
	   //newRow.onMouseOver='javascript:this.bgColor=#BCD1E9';
	  // newRow.onMouseOut='javascript:this.bgColor=''';
	    //newRow.onMouseOver="javascript:this.bgColor='#BCD1E9'";
	  //  newRow.onMouseOver = function newonMouseOver(){
	    	//newRow.innerHTML="javascript:this.bgColor=#BCD1E9";
	    	
	    //}
	    
	    //演出场馆 
	    var   newTd1   =   newRow.insertCell(0); 
	    newTd1.innerText= vname;
	     //演出时间
	     var   newTd2   =   newRow.insertCell(1); 
	     newTd2.innerText=vtimes;  
	    //单价  
	     var   newTd3   =   newRow.insertCell(2);   
	     newTd3.innerText=vp;
	    //数量 
	     var   newTd4  =   newRow.insertCell(3);   
	     newTd4.innerHTML="<input type=text id=as"+vp+" name=as"+vp+" value=1 size=3  onkeyup=checkRate(this.id,'"+vp+"'); > ";  
	    
	    //小计
		 var   newTd5  =   newRow.insertCell(4);   
		 newTd5.innerHTML="<input type=text id=vps"+vp+" name=vps"+vp+" value="+vp+" size=4 readonly style=background:#cccccc>";  
	    
	    var   newTd6  =   newRow.insertCell(5);   
	    newTd6.innerHTML="<a href=# onclick=del();>删除</a>";
	   	//alert(document.getElementById('zg').value);
	    document.getElementById('zg').value= document.getElementById('zg').value+vp;
    }else
    {
    	inputid.value=parseInt(inputid.value)+1;
    	//alert(document.getElementById('vps'+vp).value);
    	document.getElementById('vps'+vp).value=(inputid.value*vp).toFixed(2);
    	document.getElementById('zg').value= document.getElementById('zg').value+document.getElementById('vps'+vp).value;
    	
    }
   
  }
  //删除行
  function   del(){   
 	 document.all.aa.deleteRow(window.event.srcElement.parentElement.parentElement.rowIndex);   
  }
  //修改数量
  function checkRate(input,vp)
{
     var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
    var nubmer = document.getElementById(input).value;
    
    if (!re.test(nubmer))
    {
    	showTooltips(null,"只能输入数字。");
        document.getElementById(input).value = "1";
        return false;
     }else
     {
     	var vps = document.getElementById('vps'+vp);
     	vps.value = (vp*document.getElementById(input).value).toFixed(2);
     }
}  
</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<form name="form1" action="/jsp/type/perform/PerformOrders1.jsp" method="post">
<input type="hidden" name="act" value="OnlineReservations">

<input type="hidden" name="psid" value="<%=psid %>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td ><%=nobj1.getSubject(teasession._nLanguage) %></td>
        <td>演出时间：<%=psobj.getPftimeToString() %></td>
        <td>演出场馆：<%=nobj2.getSubject(teasession._nLanguage) %></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
	Enumeration e = PriceSubarea.find(teasession._strCommunity," AND psid="+psid,0,Integer.MAX_VALUE);
	out.print("<tr>");
	while(e.hasMoreElements())
	{
		int prsubid = ((Integer)e.nextElement()).intValue();
		PriceSubarea prsubobj = PriceSubarea.find(prsubid);
		SeatPic spssobj =SeatPic.find(prsubobj.getPicturepath());
		
		out.print("<td>");
			out.print("<img src="+spssobj.getPicpath()+">");
			out.print("&nbsp;&nbsp;");
			out.print("<a href=#  onclick=\"myImgs('"+nobj2.getSubject(teasession._nLanguage)+"','"+psobj.getPftimeToString()+"','"+prsubobj.getPrice()+"');\"  style=cursor:pointer >");
			//out.print(">");
				out.print(prsubobj.getSubareaname());
				out.print("&nbsp;");
				out.print(prsubobj.getPrice()+"&nbsp;元");
			out.print("</a>");
			
			
		out.print("</td>");
		
	} 
	out.print("</tr>");
%> 
</table>
<table   id="aa"   border="1"   bordercolor="black"   style="border-collapse:   collapse"   width="80%">   
	<tr id="tableonetr">
	
		<td >演出场馆</td>		
 		<td >演出时间</td>
		<td >单价(元)</td>
        <td >数量</td>	
        <td >小计(元)</td>	
 		<td >操作</td>	
	</tr>

</table>

<span id="show"></span>
<br>
</form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
