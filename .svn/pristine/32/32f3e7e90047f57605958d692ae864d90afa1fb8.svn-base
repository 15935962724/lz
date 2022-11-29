<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


String nexturl = request.getRequestURI()+"?"+request.getQueryString();


StringBuffer sql = new StringBuffer("");



%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/jsp/type/perform/eme.js" type="text/javascript"></script>
<title>废票管理</title>
</head>

<body id="bodynoneVotes">
<script>
function checkRate()//判断是否编号是数字
{ 
     var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
    var nubmer = document.getElementById("pjnumber").value;
    
     if (!re.test(nubmer))
    {
    	showTooltips(null,"只能输入数字。");
        document.getElementById("pjnumber").value = "";
        return false;
     }
} 
	function f_inquiry()//查询编号
	{
		if(form1.pjnumber.value=='')
		{
			alert('编号不能为空!');
			return false;
		}
		sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=BouncePiao_f_inquiry&pjnumber="+form1.pjnumber.value+"&community="+form1.community.value+"&type=1",
		  function(data)
		  {
		  		 document.getElementById("showpj").innerHTML=data.trim();

		  }
		  );
	}
	//点击废票按钮
	function f_submit_tp() 
	{
		var showqr = document.getElementById("showqr");
		if(showqr.x!="1")//选中以后
		{
		  showqr.style.display='';
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=BouncePiao_f_inquiry&pjnumber="+form1.pjnumber.value+"&community="+form1.community.value+"&type=2",
		  function(data)
		  {
		  		 document.getElementById("showqr").innerHTML=data.trim();
		  		 showqr.x="1";
		  }
		  );
	   }
	   else
	   {
		    showqr.style.display='none';
			showqr.x="0";
	   }
	}
	//点击 废票 时候的 废票确认 按钮
	function f_submit_qr()
	{
		if(confirm('您确认要废除这张票吗?'))
		{
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=BouncePiao_f_submit_qr&pjnumber="+form1.pjnumber.value+"&community="+form1.community.value+"&type=1",
		  function(data)
		  {
		  		 document.getElementById("showqr").innerHTML=data.trim();
		  }
		  ); 
		}
	}
	//废票---重新打印票
	function f_submit_cx()
	{
		 if(confirm('您确认要重新打印这张票吗?'))
		{
		  var printApplet = document.getElementById("printApplet");
			 var ip =form1.ip.value; 
			 var sp  ='?act=BouncePiao_f_submit_cx&pjnumber='+form1.pjnumber.value+'&community='+form1.community.value+'&type=1';
		  		openNewDiv('newDiv');
		           printApplet.openPrintApplet(ip,sp);
		       f_close('newDiv');  
		       window.open('/jsp/type/perform/AbolishPiao.jsp','_self');
		}

			
	}
</script>
<object    
     classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"    
     codebase = "http://ntcc.redcome.com/print/jre-6u17-windows-i586-iftw-rv.exe#Version=1,6,0,0"    
     WIDTH = 1 HEIGHT = 1 NAME = "printApplet"  >    
     <PARAM NAME = CODE VALUE = "PrintApplet.class" >
     <PARAM NAME = ID VALUE = "printApplet" >    	  
     <PARAM NAME = CODEBASE VALUE = "/jsp/type/perform" >    
     <PARAM NAME = ARCHIVE VALUE = "printApplet.jar" >    
     <PARAM NAME = NAME VALUE = "printApplet" >    
     <param name = "type" value = "application/x-java-applet;version=1.6"> 
     <param name = "scriptable" value = "true">    
 </object>  
<div class="content">
<h1>废票管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?" method="GET">
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >

  <table border="0" cellpadding="0" cellspacing="0" class="Search">
    <tr>
       <td class="tdp1">票据编号: </td>
       <td class="tdp2"><input type="text" id="pjnumber" name="pjnumber" value="" onKeyUp="checkRate();"></td>
       <td class="tdp3"><input type="button" value="" class="SearchInput" onClick="f_inquiry();"></td>
		</tr>
  </table>
<span id = "showpj">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>票据编号</TD>
      <TD nowrap>演出名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>座位</TD>
      <TD nowrap>时间</TD>
      <TD nowrap>价格</TD>
      <TD nowrap>操作</TD>
    </TR>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td colspan="7">在输入查询的票据编号,查询票据.</td>
      </tr>
      
  </table>
</span>
<span id ="showqr">&nbsp;</span>
  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
</div>
</body>
</html>
