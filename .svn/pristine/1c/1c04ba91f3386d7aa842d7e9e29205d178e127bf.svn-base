<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
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

//场次id号
int psid = Integer.parseInt(teasession.getParameter("psid"));
//座位的编号
String numbers =teasession.getParameter("numbers");

PerformStreak psobj = PerformStreak.find(psid);
int prsubid2 = 0;
if(teasession.getParameter("prsubid2")!=null && teasession.getParameter("prsubid2").length()>0)
{
	prsubid2 = Integer.parseInt(teasession.getParameter("prsubid2"));
}

PriceSubarea prsubobj2 = PriceSubarea.find(prsubid2);

if("delete".equals(teasession.getParameter("act")))
{
	prsubobj2.delete();
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>价格设置管理</title>
</head>
<body id="bodynone2"  >
<div id="load" >
<img src="/tea/image/public/load.gif" align="top">正在加载...
</div>
<script>
//
function f_PSubarea()
{
   if(form1.subareaname.value=='')
	{
		alert('区域不能为空!');
		form1.subareaname.focus();
		return false;
	}
	if(form1.price.value==0)
	{
		alert('价格不能为空!');
		form1.price.focus();
		return false;
	}
	if(form1.picturepath.value==0)
	{
		alert('请选择示意图!');
		form1.picturepath.focus();
		return false;
	}

  sendx('/jsp/type/perform/price_ajax.jsp?prsubid2='+form1.prsubid2.value+'&act=form1.right_price&psid='+form1.psid.value+'&community='+form1.community.value+'&subareaname='+encodeURIComponent(form1.subareaname.value)+'&price='+form1.price.value+'&picturepath='+form1.picturepath.value,
  function(data)
  {
     // document.getElementById('show').innerHTML=data;
      alert(data.trim());
      window.open(location.href+"&psid=<%=psid%>&t="+new Date().getTime(),window.name);
  }
  );
}
function f_edit(igd)
{
	form1.prsubid2.value=igd;
	form1.submit();
}
//删除
function f_delete(igd)
{
	form1.act.value='delete';
	form1.prsubid2.value=igd;
	form1.submit();
}
//添加示意图
function f_picture()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:405px;';
  var url = '/jsp/type/perform/Price.jsp?psid='+form1.psid.value+'&community='+form1.community.value;
  var rs = window.showModalDialog(url,self,y);
  if(rs>0)
  {
  	  window.open(location.href+"&psid=<%=psid%>&t="+new Date().getTime(),window.name);
  }

}
//选中座位定义分区f_pricesubareaid
function f_pricesubareaid()
{
	if(form1.numbers.value=='')
	{
		alert('请选择座位.');
		form1.numbers.focus();
		return false;
	}

  sendx('/jsp/type/perform/price_ajax.jsp?act=f_pricesubareaid&psid='+form1.psid.value+'&community='+form1.community.value+'&pricesubareaid='+form1.pricesubareaid.value+'&numbers='+form1.numbers.value,
  function(data)
  {
     // document.getElementById('show').innerHTML=data;
      alert(data.trim());
      form1.numbers.value='';
      window.open(location.href+"&psid=<%=psid%>&t="+new Date().getTime(),window.name);
      window.open("/jsp/type/perform/left_price.jsp?psid=<%=psid%>","RightFrame");
  }
  );
}

</script>
<form name="form1" method="post" action="?" >
  <input type="hidden" name="act">
  <input type="hidden" name="psid" value="<%=psid%>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="prsubid2" value="<%=prsubid2 %>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
				<tr>
					<td align="center" colspan="2"><%=Node.find(psobj.getNode()).getSubject(teasession._nLanguage) %></td>
				</tr>
				<tr>
					<td align="right">演出场次：</td>
					<td><%=psobj.getPsname() %></td>
				</tr>
			
</table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
				<tr id="tableonetr">
					<td align="center" colspan="2">分区管理</td>
				</tr>
				<%
					Enumeration e = PriceSubarea.find(teasession._strCommunity," AND psid="+psid,0,Integer.MAX_VALUE);
					while(e.hasMoreElements())
					{
						int prsubid = ((Integer)e.nextElement()).intValue();
						PriceSubarea prsubobj = PriceSubarea.find(prsubid);
						SeatPic spssobj =SeatPic.find(prsubobj.getPicturepath());
				%>

				<tr>
					<td colspan="2">
						<%=prsubobj.getSubareaname() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  						<img src="<%=spssobj.getPicpath() %>" width="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=prsubobj.getPrice() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" onClick="f_edit('<%=prsubid %>');"><img src="/tea/image/public/icon_edit.gif" ></a>&nbsp;
 						<a href="#" onClick="f_delete('<%=prsubid %>');"><img src="/tea/image/public/del.gif" ></a>
					</td>
				</tr>
				<%} %>
				<tr>
					<td align="right">区域：</td>
					<td><input type="text" name="subareaname" value="<%if(prsubobj2.getSubareaname()!=null)out.print(prsubobj2.getSubareaname()); %>" size="6"></td>
				</tr>
				<tr>
					<td align="right">价格：</td>
					<td>
						<input type="text" name="price" value="<%if(prsubobj2.getPrice()!=null)out.print(prsubobj2.getPrice()); %>" size="6"   mask="float">
					</td>
				</tr>
				<tr>
					<td align="right">示意图：</td>
					<td>
						<select name="picturepath">
							<option value="0">--示意图--</option>
						 <%
						    java.util.Enumeration e2 = SeatPic.find(teasession._strCommunity," 	AND type = 2 AND  node = "+psid+" order by times desc  ",0,Integer.MAX_VALUE);
						    for(int i = 1;e2.hasMoreElements();i++)
						    {
						      int spid2 = ((Integer)e2.nextElement()).intValue();
						      SeatPic spobj2 = SeatPic.find(spid2);
						      out.print("<option value="+spid2);
						      if(prsubobj2.getPicturepath() == spid2)
						      {
						        out.print(" selected ");
						      }
						      out.print(">"+spobj2.getPicname());
						      out.print("</option>");
						    }
						    %>
						</select>&nbsp;<img src="/tea/image/other/img-globe.gif" title="点击添加示意图" style="cursor:pointer" onClick="f_picture();">
					</td>
				</tr>
				<tr>
					<td><input type="button" value="添加/修改" onClick="f_PSubarea();" ></td>

				</tr>
			</table>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>选中座位定义为： </td>
	<td>
		<select name="pricesubareaid" onChange="f_pricesubareaid();">
		<option value="0">--选择分区--</option>
			<%
				Enumeration e22 = PriceSubarea.find(teasession._strCommunity," AND psid="+psid,0,Integer.MAX_VALUE);
					while(e22.hasMoreElements())
					{
						int prsubid = ((Integer)e22.nextElement()).intValue();
						PriceSubarea prsubobj = PriceSubarea.find(prsubid);
						out.print("<option value="+prsubid);
						out.print(">"+prsubobj.getSubareaname());
						out.print("</option>>");
					}
			 %>
		</select>
	</td>
  </tr>
<input type="hidden" name="numbers" value="<%if(numbers!=null)out.print(numbers); %>">
  </table>
  </form>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2">

      <input type="button" value="完成价格设置"  onClick="javascript:window.parent.close(1);">
    </td>
  </tr>
  </table>
    <script>
var load=document.getElementById('load');
load.style.display='none';
</script>
</body>
</html>
