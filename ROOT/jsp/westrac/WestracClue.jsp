<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.westrac.WestracClue"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}




StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));

//联系人姓名
String contactname = teasession.getParameter("contactname");
if(contactname!=null && contactname.length()>0)
{
	contactname = contactname.trim();
	sql.append(" and contactname like ").append(DbAdapter.cite("%"+contactname+"%"));
	param.append("&contactname=").append(URLEncoder.encode(contactname,"UTF-8"));
}

//购买人所在地
String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{
		//province
	sql.append(" and city like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);


}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{
		//province
	sql.append(" and city like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;


}
//客户姓名
String clientname = teasession.getParameter("clientname");
if(clientname!=null && clientname.length()>0)
{
	clientname = clientname.trim();
	sql.append(" and clientname like ").append(DbAdapter.cite("%"+clientname+"%"));
	param.append("&clientname=").append(URLEncoder.encode(clientname,"UTF-8"));
}
//提交时间

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND times >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND times <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}

//用户姓名
String wcname = teasession.getParameter("wcname");
if(wcname!=null && wcname.length()>0)
{
	wcname = wcname.trim();
	sql.append(" and wcname like ").append(DbAdapter.cite("%"+wcname+"%"));
	param.append("&wcname=").append(URLEncoder.encode(wcname,"UTF-8"));
}
//状态
int wctype = -1;
if(teasession.getParameter("wctype")!=null && teasession.getParameter("wctype").length()>0)
{
	wctype = Integer.parseInt(teasession.getParameter("wctype"));
}
if(wctype>=0)
{
		sql.append(" and wctype = ").append(wctype);
		param.append("&wctype=").append(wctype);
}


int pos=0,size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = WestracClue.count(teasession._strCommunity,sql.toString());



sql.append(" order by times desc ");


%>
<html>
<HEAD>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
  <link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/Calendar.js" type="text/javascript"></script>
  <script src="/tea/city.js" type="text/javascript"></script>

</HEAD>
<body>
<script type="text/javascript">


//点击操作显示
function f_cz(igd)
{

	if(document.getElementById('trid'+igd).style.display=='')
	{
		document.getElementById('trid'+igd).style.display='none';
	}
	else if(document.getElementById('trid'+igd).style.display=='none')
	{
		document.getElementById('trid'+igd).style.display='';

	}
}
//线索是否真实
function f_xs(igd,igd2)
{
	var str = '<br><br>线索是否真实：<input type="hidden" name="igd" value='+igd+'><input type="radio" id="wctypeid" name="wctype" value="1" ';
	 if(igd2==1)
		{
			str = str+' checked ';
		}
	str = str+'>&nbsp;是&nbsp;&nbsp;';
	str = str+'<input type="radio" id="wctypeid" name="wctype" value="2"';
	if(igd2==2)
	{
		str = str+' checked ';
	}
	str = str+'>&nbsp;否&nbsp;&nbsp;';


	ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:str,title:'线索是否真实',height:150,handler:getInput,autoClose:false});
}
function getInput(tp){
	if(tp!='ok') return ymPrompt.close();

	var strNew = 0;
	var temp=document.getElementsByName("wctype");
	for (i=0;i<temp.length;i++){
		//遍历Radio
		if(temp[i].checked)
		{
			strNew = temp[i].value;
		}
	}


	var igd = $('igd').value;


	sendx("/jsp/admin/edn_ajax.jsp?act=WestracCluewctype&wcid="+igd+"&wctype="+strNew,
			 function(data)
			 {

			//  alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1 )//如果有这个用户  则写入Cookie .trim()
			   {
					data = data.trim();

					if(data=='true'){
						ymPrompt.close();
				       ymPrompt.win({message:'<br><center>是否真实线索操作成功</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});

					}

			   }
			 }
	);

}

//是否形成商机
function f_sj(igd,igd2)
{

	var str = '<br><br>商机判断：<input type="hidden" name="igd" value='+igd+'> ';

	str =str+'<input type="radio" id="wctypeid" name="wctype" value="0"';
	 if(igd2==0)
		{
			str = str+' checked ';
		}
	str = str+'>&nbsp;未判断商机&nbsp;&nbsp;';

	str =str+'<input type="radio" id="wctypeid" name="wctype" value="1"';
	 if(igd2==1)
		{
			str = str+' checked ';
		}
	str = str+'>&nbsp;新商机&nbsp;&nbsp;';
	str = str+'<input type="radio" id="wctypeid" name="wctype" value="2"';
	if(igd2==2)
	{
		str = str+' checked ';
	}
	str = str+'>&nbsp;旧商机&nbsp;&nbsp;';


	ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:str,title:'商机判断',width:350,height:150,handler:getInput2,autoClose:false});
}
function getInput2(tp){
	if(tp!='ok') return ymPrompt.close();

	var strNew = -1;
	var temp=document.getElementsByName("wctype");
	for (i=0;i<temp.length;i++){
		//遍历Radio
		if(temp[i].checked)
		{
			strNew = temp[i].value;
		}
	}

	if(strNew==-1)
		{

	       alert('请选中是否形成商机选项');
	       return false;
		}

	var igd = $('igd').value;


	sendx("/jsp/admin/edn_ajax.jsp?act=WestracCluewctype2&wcid="+igd+"&wctype="+strNew,
			 function(data)
			 {

			//  alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1 )//如果有这个用户  则写入Cookie .trim()
			   {
					data = data.trim();

					if(data=='true'){
						ymPrompt.close();
				       ymPrompt.win({message:'<br><center>商机判断操作成功</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});

					}

			   }
			 }
	);

}


function noTitlebar(){
	window.location.reload();
}

function f_delete(igd)
{
	if(confirm('您确定要删除这条线索吗？删除以后，数据不能恢复！'))
	  {
			sendx("/jsp/admin/edn_ajax.jsp?act=WestracCluewDelete&wcid="+igd,
					 function(data)
					 {


					   if(data!=''&&data.length>1 )//如果有这个用户  则写入Cookie .trim()
					   {
							data = data.trim();

							if(data=='true'){
								ymPrompt.close();
						       ymPrompt.win({message:'<br><center>线索删除成功</center>',width:200,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});

							}

					   }
					 }
			);
			  }
}

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("checkwcid");
	var lname="";
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){
	      fname[i].checked=true;
	  }
	}else{
	   for(var i=0; i<fname.length; i++){
	      fname[i].checked=false;
	   }
	}


	if(checkname[0].checked)
	{

		document.getElementById("checkall2").checked=true;
	}
	else
	{
		document.getElementById("checkall2").checked=false;
	}


}
function CheckAll2()
{
	var checkname=document.getElementsByName("checkall2");
	var fname=document.getElementsByName("checkwcid");
	var lname="";
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){
	      fname[i].checked=true;
	}
	}else{
	   for(var i=0; i<fname.length; i++){
	      fname[i].checked=false;
	   }
	}
	if(checkname[0].checked)
	{

		document.getElementById("checkall").checked=true;
	}
	else
	{
		document.getElementById("checkall").checked=false;
	}
}
//批量删除
function f_sub(igd,strigd)
{

  if(submitCheckbox(form1.checkwcid,strigd))
  {
		//删除

		if(igd=='delete')//
		{
			if(confirm('删除操作成功以后,数据不能恢复,您确定要删除吗？'))
			{
				form1.action='/servlet/EditWestracClue';
				form1.act.value='WestracClueDelete';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
		}
     }
}

function f_excel()
{
	if(confirm("您确定要导出数据吗?"))
    {
		form1.action='/servlet/EditWestracExcel';
		form1.act.value='WestracClueExcel';
		form1.submit();
	}
}


</script>
<h1>销售线索管理列表</h1>
<form name="form1" action="?" method="GET">
<input type="hidden" name="act" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="files" value="销售线索导出数据列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
	<tr>
		<td align="right">联系人姓名：</td><td><input type="text" name="contactname" value="<%=Entity.getNULL(contactname) %>"></td>
		<td align="right">购买人所在地：</td><td><script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
	</tr>
	<tr>
		<td align="right">客户姓名：</td><td><input type="text" name="clientname" value="<%=Entity.getNULL(clientname) %>"></td>
		<td align="right">提交时间：</td><td>
        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />

		</td>
	</tr>
	<tr>
		<td align="right">状态：</td><td>
		<select name="wctype">
			<option value="-1">-状态-</option>
			<%
				for(int i =0;i<WestracClue.WCTYPE_TYPE.length;i++)
				{
					out.print("<option value="+i);
					if(wctype==i)
					{
						out.print(" selected ");
					}
					out.print(">"+WestracClue.WCTYPE_TYPE[i]);
					out.print("</option>");
				}
			%>
		</select>
		</td>
		<td align="right">用户姓名：</td><td><input type="text" name="wcname" value="<%=Entity.getNULL(wcname) %>"></td>
	</tr>


    <tr>  <td colspan="20" align="center"><input type="submit" value="查询" /></td></tr>

</table>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;条销售线索&nbsp;)&nbsp;&nbsp;</h2>




<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 	  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>购买人名称</td>
      <td nowrap>联系人名称</td>
      <td nowrap>移动电话</td>
      <td nowrap>购买人所在地 </td>
      <td nowrap>提交时间</td>
      <td nowrap>用户类型</td>
      <td nowrap>用户姓名</td>
      <td nowrap>用户手机</td>
      <td nowrap>线索状态</td>
      <td nowrap>商机状态</td>
      <td nowrap>所属销售员</td>
      <td nowrap>负责人</td>
      <td nowrap>是否导出</td>
      <td nowrap>操作</td>

</tr>
<%

java.util.Enumeration eu = WestracClue.find(teasession._strCommunity,sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{

 	int wcid = ((Integer)eu.nextElement()).intValue();
 	WestracClue wcobj = WestracClue.find(wcid);


	String cname = "";
	if(wcobj.getCity()!=null && wcobj.getCity().length()>0)
	{
		cname = Card.find(Integer.parseInt(wcobj.getCity())).toString();
	}

	String membertypename = "非注册用户";
	String belsell ="无";//所属销售员
	if(wcobj.getMember()!=null && wcobj.getMember().length()>0)
	{
		Profile pobj = Profile.find(wcobj.getMember());

		if(pobj.getMembertype()==0)
		{
			membertypename = "普通会员";
		}else if(pobj.getMembertype()==1)
		{
			membertypename ="履友";
			belsell = pobj.getBelsell();
		}
	}





  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">
   <td width=1><input type=checkbox name="checkwcid" id="checkwcid" value="<%=wcid%>" style="cursor:pointer"></td>
    <td nowrap><%=wcobj.getClientname() %></td>
    <td nowrap><%=wcobj.getContactname() %></td>
    <td nowrap><%=wcobj.getClientmobile() %></td>
    <td nowrap><%=cname %></td>
    <td nowrap><%=Entity.sdf.format(wcobj.getTimes()) %></td>
    <td nowrap><%=membertypename %></td>
    <td nowrap><%=wcobj.getWcname() %></td>
    <td nowrap><%=wcobj.getMobile() %></td>
    <td nowrap><%=wcobj.WCTYPE_TYPE[wcobj.getWctype()] %></td>
      <td nowrap><%=wcobj.WCTYPE_TYPE2[wcobj.getWctype2()] %></td>
    <td nowrap><%if(belsell!=null && belsell.length()>0){out.println(belsell);}else{out.println("无");}%></td>

     <td nowrap><%if(wcobj.getWcmember()!=null && wcobj.getWcmember().length()>0 && !"null".equals(wcobj.getWcmember())){out.print(wcobj.getWcmember());}else{out.print("无");} %></td>
      <td nowrap><%if(wcobj.getExporttype()==0){out.print("否");}else{out.print("是");} %></td>

    <td nowrap>  <a href="###" onclick="f_cz('<%=wcid%>');" >操作</a></td>
  </tr>
  <tr id="trid<%=wcid %>" style="display:none">
  	<td align="right" colspan="20">

  		<a href="###" onclick="window.open('/jsp/westrac/EditWestracClue.jsp?wcid=<%=wcid%>&nexturl=<%=nexturl%>','_self');">线索详细</a>&nbsp;


  		<a href="###" onclick="f_xs('<%=wcid%>','<%=wcobj.getWctype()%>');">线索是否真实</a>&nbsp;
  		<%

  		//if(wcobj.getWctype()==1 || wcobj.getWctype()>=3){

  		%>
  		<a href="###" onclick="f_sj('<%=wcid%>','<%=wcobj.getWctype2()%>');">商机判断</a>&nbsp;
  		<%//} %>
  		<a href="###" onclick="f_delete('<%=wcid%>');" >删除</a>&nbsp;
  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	</td>
  </tr>

  <%
  }
  %>
  <tr>

    <td colspan="4">
    <input type='checkbox' name="checkall2" id="checkall2" onclick='CheckAll2()' title="全选" style="cursor:pointer">&nbsp;全选/反选&nbsp;&nbsp;

<input type="button" value="删除" onClick="f_sub('delete','请选择您要删除的销售线索!');">&nbsp;
<input type="button" value="导出Excel" onClick="f_excel();">&nbsp;
<input type="button" value="创建线索" onclick="window.open('/jsp/westrac/EditWestracClueAdmin.jsp?nexturl=<%=nexturl%>','_self');"

    </td>

  <td colspan="20"  align="right" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>

</tr>
  </table>
</form>
</body>
</html>
