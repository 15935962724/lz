<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.math.BigDecimal"%>

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

int type = 0;//默认是预订票发放
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
	type = Integer.parseInt(teasession.getParameter("type"));	
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();//teasession.getParameter("nexturl");
StringBuffer sql = new StringBuffer();//
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&type=").append(type);
if(type>0)//已发放预订票显示
{
	sql.append(" and  type = 4 and  (frontreartype=0 or frontreartype=2) ");
}		
else
{
	sql.append(" and  (type=1 or type=3) and  (frontreartype=0 or frontreartype=2) ");
}

//订单号
String ordersid = teasession.getParameter("ordersid");
if(ordersid!=null && ordersid.length()>0)
{
	sql.append(" and ordersid=").append(DbAdapter.cite(ordersid));
	param.append("&ordersid=").append(ordersid);
}
//演出
String performname = teasession.getParameter("performname");
if(performname!=null && performname.length()>0)
{
	sql.append(" and ordersid in (select orderid from OrderDetails where performname like "+DbAdapter.cite("%"+performname+"%")+")");
	param.append("&performname=").append(URLEncoder.encode(performname,"UTF-8"));
}
//场次
String psname = teasession.getParameter("psname");
 if(psname!=null && psname.length()>0)
 {
	sql.append(" and ordersid in (select orderid from OrderDetails where psname like "+DbAdapter.cite("%"+psname+"%")+")");
	param.append("&psname=").append(URLEncoder.encode(psname,"UTF-8"));
 }
 //姓名
 String names = teasession.getParameter("names");
 if(names!=null && names.length()>0)
 {
	 sql.append(" and names like "+DbAdapter.cite("%"+names+"%"));
		param.append("&names=").append(URLEncoder.encode(names,"UTF-8"));
 }
 //证件号码
 String zjhm = teasession.getParameter("zjhm");
 if(zjhm!=null && zjhm.length()>0)
 {
	 sql.append(" and zjhm = ").append(DbAdapter.cite(zjhm));
	 param.append("&zjhm=").append(zjhm); 
 }
 //手机号码
 String yddh = teasession.getParameter("yddh");
 if(yddh!=null && yddh.length()>0)
 {
	 sql.append(" and yddh = ").append(yddh);
	 param.append("&yddh=").append(yddh);
 }

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = PerformOrders.count(teasession._strCommunity,sql.toString());

//sql.append(" order by times desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/jsp/type/perform/eme.js" type="text/javascript"></script>
<title>预订票发放</title>
</head>


<body id="bodynoneVotes">
<script>
	function f_xx(igd)//点击详细查看信息功能
	{
		var showid = document.getElementById("show"+igd);
		var showwid = document.getElementById("showw"+igd);
		if(showid.x!="1")//选中以后
		{
		  showid.style.display='';
		  showwid.style.display='';
		  sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=xiangxi&ordersid="+igd+"&type="+form1.type.value,
		  function(data)
		  {
		
		  		 document.getElementById("show"+igd).innerHTML=data;
		  		 showid.x="1";
		  }
		  );
		}else
		{
			showid.style.display='none';
			 showwid.style.display='none';
			 showid.x="0";
		}
	}
	//确认出票
	function f_qrcp(igd)//预订单出票
	{
		 if(confirm('确认出票?')){
     
			  var printApplet = document.getElementById("printApplet");
			  var lingpiao = document.getElementById("lingpiao"+igd).value;      
		   	 
		   	  var ip = form1.ip.value;
		       var sp;//'?act=AdminDrawabill&dingdan='+igd+'&lingpiao'+igd+'='+lingpiao+'&lpname'+igd+'='+lpname+'&lpzjhm'+igd+'='+lpzjhm;
		       if(lingpiao==3)//有运费的打印
		       {
			       sp = '?act=AdminDrawabill&dingdan='+igd+'&lingpiao'+igd+'='+lingpiao;
			   }else//没有运费打印
			   {
				   var lpname = document.getElementById("lpname"+igd).value;
				   var lpzjhm = document.getElementById("lpzjhm"+igd).value;
				   sp='?act=AdminDrawabill&dingdan='+igd+'&lingpiao'+igd+'='+lingpiao+'&lpname'+igd+'='+lpname+'&lpzjhm'+igd+'='+lpzjhm;
			   }
		        openNewDiv('newDiv');
		           printApplet.openPrintApplet(ip,sp);
		       f_close('newDiv'); 
		}
		 window.open(form1.nexturl.value,window.name);
		
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
<h1><div class="leftp"><a href ="?id=<%=teasession.getParameter("id") %>">预订票发放</a></div><div class="rightp"><a href="?id=<%=teasession.getParameter("id") %>&type=1">已发放预订票</a></div></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 


<form name="form1" action="?" method="post">
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">
<input type="hidden" name="act" value="AdminDrawabill">
<input type="hidden" name="dingdan" >
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=teasession.getParameter("id") %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="type" value="<%=type %>">

<table border="0" cellpadding="0" cellspacing="0" class="Search">
  <tr class="tr1">
    <td>　订单号：</td><td><input type="text" name="ordersid" value="<%if(ordersid!=null)out.print(ordersid); %>"></td>
     <td>演出：</td><td><input type="text" name="performname" value="<%if(performname!=null)out.print(performname); %>"></td>
      <td>演出场馆：</td>
    <td class="td02">
        <select name=psname>
           <option value="">--演出场馆--</option>
           <%

              java.util.Enumeration en = Node.find(" and community="+DbAdapter.cite(teasession._strCommunity)+" and type=92 and hidden = 0",0,100);
              while(en.hasMoreElements())
              {
                int nid = ((Integer)en.nextElement()).intValue();
                Node nobj = Node.find(nid);
                out.print("<option value="+nobj.getSubject(teasession._nLanguage));
                if(nobj.getSubject(teasession._nLanguage).equals(psname))
                {
                      out.print(" selected ");
                }
                out.print(">"+nobj.getSubject(teasession._nLanguage));
                out.print("</option>");
              }

           %>
        </select>
    </td>
  </tr>   
   <tr class="tr2">
    <td>　姓名：</td><td><input type="text" name="names" value="<%if(names!=null)out.print(names); %>"></td>
     <td>证件号：</td><td><input type="text" name="zjhm" value="<%if(zjhm!=null)out.print(zjhm); %>"></td>
     <td>手机：</td><td><input type="text" name="yddh" value="<%if(yddh!=null)out.print(yddh); %>"></td>
  </tr>
  <tr class="tr3"><td colspan="6"><input type="submit" value=""></td></tr>
</table>  

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>订单号</td>
      <TD nowrap>姓名</TD>
      <TD nowrap>手机</TD>
      <TD nowrap>电话</TD>
      <TD nowrap>证件</TD>
      <TD nowrap>证件号码</TD>
      <TD nowrap>数量</TD>
      <TD nowrap>总价</TD>
      <TD nowrap>操作</TD>
    </tr>
   <%
   			Enumeration e = PerformOrders.find(teasession._strCommunity,sql.toString(),pos,pageSize);
		   if(!e.hasMoreElements())
		   {
		       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		   }
   			while(e.hasMoreElements())
   			{
   				String pfoid = ((String)e.nextElement());
   				PerformOrders  pfoobj = PerformOrders.find(pfoid);
   				//添加运费
   				BigDecimal tp = pfoobj.getTotalprice();
   				if(pfoobj.getFare()>0)
   				{
   					tp = tp.add(new BigDecimal(pfoobj.getFare()));
   				}
   				
   %>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td nowrap><%=pfoid %></td>
   <td nowrap><%=pfoobj.getNames() %></td>
   <td nowrap><%=pfoobj.getYddh() %></td>
    <td nowrap><%=pfoobj.getGddh() %></td>
   <td nowrap><%=PerformOrders.ZJLX_TYPE[pfoobj.getZjlx()]%></td>
   <td nowrap><%=pfoobj.getZjhm() %></td>
   <td nowrap><%=pfoobj.getQuantity() %></td>
   <td nowrap><%=tp %>&nbsp;元</td>
   <td nowrap style="padding:5px 0px;text-align:center"><a href=# onClick="f_xx('<%=pfoid %>')"><img src="/res/REDCOME/0911/0911992.gif"></a></td>
   </tr>
   
  <tr style="display:none;" id="showw<%=pfoid%>">
  	<td colspan="10"> <span id ="show<%=pfoid%>">&nbsp;</span></td>
  </tr>
     
    <%
   			}
    %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  </div>

</body>

</html>
