<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");


String nexturl = teasession.getParameter("nexturl");


int subid = 0;
if(teasession.getParameter("subid")!=null && teasession.getParameter("subid").length()>0)
{
   subid  = Integer.parseInt(teasession.getParameter("subid"));
}

Subscribe sobj = Subscribe.find(subid);
ReadRight rrobj_1 = ReadRight.find(ReadRight.getRRid(teasession._nNode,subid,"Subscribe",1));


int rrcount = ReadRight.count(" and node="+teasession._nNode+" AND  father="+subid+" AND type= "+DbAdapter.cite("Subscribe"));


%>
<html>
<head>
<title>套餐管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body onLoad="f_load();">
<script>


function f_load()
{
	
	for(var i =1;i<form1.rnum2.value.split('/').length;i++)
	{
		var a = 0;
		if(form1.rnum2.value.split('/')!=''&&form1.rnum2.value.split('/').length>0)
		{
			a = form1.rnum2.value.split('/')[i];
		} else
		{
			 continue; 
		}
		f_suoyou(a);
	}  
}
 

function findObj(theObj, theDoc){  
	var p, i, foundObj;
	    if(!theDoc) theDoc = document;  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)  {    
		    theDoc = parent.frames[theObj.substring(p+1)].document;    theObj = theObj.substring(0,p);  }  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];  for (i=0; !foundObj && i < theDoc.forms.length; i++)     foundObj = theDoc.forms[i][theObj];  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++)     foundObj = findObj(theObj,theDoc.layers[i].document);  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);    return foundObj;
		    }



	function add()
	{
		var rnum2 = "/";
		var txtTRLastIndex = findObj("txtTRLastIndex",document);
		 var rowID = parseInt(txtTRLastIndex.value)+<%=rrcount%>;
		
	
		 var signFrame = findObj("tablecenter",document);
		 //添加行
		 var newTR = signFrame.insertRow(signFrame.rows.length-6);
		 newTR.id = "SignItem" + rowID; 
		  
		 //添加列:序号
		 var newNameTD=newTR.insertCell(0);
		 //添加列内容
		// newNameTD.innerHTML = newTR.rowIndex.toString();
		 
		 //添加列:姓名
		 var newNameTD=newTR.insertCell(1);
		 //添加列内容
		// newNameTD.innerHTML = "<input name='txtName" + rowID + "' id='txtName" + rowID + "' type='text' size='12' />";



		 rnum = rowID+<%=rrcount%>+1;//newTR.rowIndex.toString()

		 rnum2 = rnum2+rnum;
			var str_HTML = '<table>';
			 
			str_HTML += '<tr>';
			   str_HTML += '<td align="right" nowrap>版面：'+rnum+'</td>';
			  str_HTML += '<td><input type=checkbox  name="suoyou_'+rnum+'" value="0" id="suoyou_'+rnum+'" onclick="f_suoyou('+rnum+');" checked=true;>&nbsp;所有版面</td><td><a href="#" onclick=DeleteSignRow("SignItem'+rowID+'",'+rowID+');>删除</a></td>';
			str_HTML += '</tr>';

		////////--------------隐藏的版面信息---------------////////////////
			str_HTML += '<tr id="sybanci_'+rnum+'" style="display: none">';
				str_HTML += '<td>&nbsp;</td>';
				str_HTML += '<td>';
					str_HTML += '<span id="sy_banci_ajax_'+rnum+'"></span>';
				str_HTML += '</td>'; 
			str_HTML += '</tr>';
		
			  
			
	     ////////--------------//显示期次范围---------------////////////////
			str_HTML += '<tr>';
		   str_HTML += '<td align="right" nowrap>期次范围：</td>';
		  str_HTML += '<td>';
			  str_HTML +='<select name="qici_fanwei_'+rnum+'"  id="qici_fanwei_'+rnum+'" onchange="f_qici_fanwei('+rnum+');">';
			  
				  str_HTML +='<option value="1">绝对</option>';
				  str_HTML +='<option value="2">相对</option>';


				  
			  str_HTML +='</select>';
			  
			  str_HTML +='<span id="span_1_qc_time_'+rnum+'">';
				  str_HTML +='<input type="text" name="qc_timec_'+rnum+'" id="qc_timec_'+rnum+'"  size="7"  readonly>';
				  str_HTML +='<img style="margin-bottom:-8px;" style="cursor:pointer"  id="qc_img_timec_'+rnum+'"   src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show(form1.qc_timec_'+rnum+');" />';
				  str_HTML +='-';
				  str_HTML +='<input type="text"  name="qc_timed_'+rnum+'" id="qc_timed_'+rnum+'"  size="7"  readonly>';
				  str_HTML +='<img style="margin-bottom:-8px;" style="cursor:pointer"  id="qc_img_timed_'+rnum+'"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show(form1.qc_timed_'+rnum+');" />';
			  str_HTML +='</span>';
			
			  str_HTML +='<span id="span_2_qc_time_'+rnum+'" style="display:none">';
				  str_HTML +='<input type="text" name="qc_2_timec_'+rnum+'" id="qc_2_timec_'+rnum+'"   onchange=qc_2_timec("qc_2_timec","'+rnum+'");   size="7"  >';
				  str_HTML +='-';
				  str_HTML +='<input type="text"  name="qc_2_timed_'+rnum+'" id="qc_2_timed_'+rnum+'"  onchange=qc_2_timec("qc_2_timed","'+rnum+'");   size="7"  >';
			  str_HTML +='</span>';
		  str_HTML +='</td>';
		str_HTML += '</tr>';

	////////--------------//显示阅读有效期---------------////////////////

		

			str_HTML += '<tr>';
		   str_HTML += '<td align="right" nowrap>阅读有效期：</td>';
		  str_HTML += '<td>';

			  str_HTML += '<select name="yuedu_yxqi_'+rnum+'"  id="yuedu_yxqi_'+rnum+'" onchange="f_yuedu_yxqi('+rnum+');">';
				str_HTML += '<option value="1">绝对</option>';
				str_HTML += '<option value="2">相对</option>';
			str_HTML += '</select>';		
			
			str_HTML += '<span id="span_1_yd_time_'+rnum+'">';
				str_HTML += '<input type="text" name="yd_timec_'+rnum+'" id="yd_timec_'+rnum+'"  size="7"  readonly>';
				str_HTML += '<img style="margin-bottom:-8px;" style="cursor:pointer" id="yd_img_timec_'+rnum+'"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show(form1.yd_timec_'+rnum+');" />';
				str_HTML += '-';
				str_HTML += '<input type="text"  name="yd_timed_'+rnum+'" id="yd_timed_'+rnum+'"  size="7"  readonly>';
				str_HTML += '<img style="margin-bottom:-8px;" style="cursor:pointer"  id="yd_img_timed_'+rnum+'" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show(form1.yd_timed_'+rnum+');" />';
			str_HTML += '</span>';
		
			str_HTML += '<span id="span_2_yd_time_'+rnum+'" style="display:none">';
				str_HTML += '<input type="text" name="yd_2_timec_'+rnum+'" id="yd_2_timec_'+rnum+'" onchange=qc_2_timec("yd_2_timec","'+rnum+'");   size="7"  >';
				str_HTML += '-';
				str_HTML += '<input type="text"  name="yd_2_timed_'+rnum+'" id="yd_2_timed_'+rnum+'" onchange=qc_2_timec("yd_2_timed","'+rnum+'");   size="7"  >';
			str_HTML += '</span>';
		
		  
		  str_HTML +='</td>';
		str_HTML += '</tr>';
			
		 
			 str_HTML += '</table>';

			 newNameTD.innerHTML =str_HTML;
		 
		 //添加列内容
		// newDeleteTD.innerHTML = "<div align='center' style='width:40px'><a href='javascript:;' onclick=\"DeleteSignRow('SignItem" + rowID + "')\">删除</a></div>";
		 
		 //将行号推进下一行
		 txtTRLastIndex.value = (rowID + 1).toString();
		   form1.rnum.value=rowID + 1;
		   form1.rnum2.value=form1.rnum2.value+rnum2;
		   //alert(form1.rnum2.value);
	}


	//删除指定行
function DeleteSignRow(rowid,rowid2){
	
	 var signFrame = findObj("tablecenter",document);
	 var signItem = findObj(rowid,document);
	 
	 //获取将要删除的行的Index
	 var rowIndex = signItem.rowIndex;
	 
	 //删除指定Index的行
	 signFrame.deleteRow(rowIndex);
	 
	 //重新排列序号，如果没有序号，这一步省略
	// for(i=rowIndex;i<signFrame.rows.length;i++){
	//  signFrame.rows[i].cells[0].innerHTML = i.toString();
	// }
var as = rowid2+1;
form1.rnum2.value = form1.rnum2.value+"/";
		form1.rnum2.value = form1.rnum2.value.replace("/"+as+"/","/"); 
		//alert(form1.rnum2.value);
		

}//清空列表
	

	//删除一个表格
function GetRow(rowid,rowid2){

	 var signFrame = findObj("tablecenter",document);
	 var signItem = findObj(rowid,document);
	 
	 //获取将要删除的行的Index
	 var rowIndex = signItem.rowIndex;
	 
	
		 

	var str_url = "?act=rrdelete&node="+form1.node.value+"&community="+form1.community.value+"&tid=<%=subid%>&rnum="+rowid2+"&typestr=Subscribe"
    sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
   		 function(data)
   		 {
  		 
  		 
    	 //删除指定Index的行
		   	 signFrame.deleteRow(rowIndex);
		   	 
		   	 //重新排列序号，如果没有序号，这一步省略
		   	// for(i=rowIndex;i<signFrame.rows.length;i++){
		   	//  signFrame.rows[i].cells[0].innerHTML = i.toString();
		   	// }
		   var as = rowid2;
		   form1.rnum2.value = form1.rnum2.value+"/";
		   		form1.rnum2.value = form1.rnum2.value.replace("/"+as+"/","/"); 
		   		//alert(form1.rnum2.value);
   		 }  
   	);  

	
	 


}
//所有版面显示的字段
function f_suoyou(igd)
{
	if(igd>0){
			var sy =   document.getElementById("suoyou_"+igd);//点击所有版面时候
			var sy_bc =document.getElementById("sybanci_"+igd);//单个版面的
		
		
		
			if(sy.checked)//sy.checked
			{
				sy_bc.style.display="none";
			}else 
			{
				var str_url = "?act=f_suoyou&node="+form1.node.value+"&community="+form1.community.value+"&igd="+igd+"&tid=<%=subid%>&typestr=Subscribe"
		        sendx("/jsp/general/subscribe/subscribe_ajax.jsp"+str_url,
		       		 function(data)
		       		 {
		        	        document.getElementById("sy_banci_ajax_"+igd).innerHTML =data;
		        	        sy_bc.style.display="";
		       		 }
		       	);
				
			}
	}
}
//期次范围
function f_qici_fanwei(igd)
{
	var qici_fanwei    =document.getElementById("qici_fanwei_"+igd);//期次选中
	var span_1_qc_time =document.getElementById("span_1_qc_time_"+igd);//期次绝对时间id
	var span_2_qc_time =document.getElementById("span_2_qc_time_"+igd);//期次绝对时间id

	if(qici_fanwei.value==1)//绝对
	{
		span_1_qc_time.style.display="";
		span_2_qc_time.style.display="none";
	}
	if(qici_fanwei.value==2)//选中相对
	{
		span_1_qc_time.style.display="none";
		span_2_qc_time.style.display="";
	}
	
}
//阅读有效期
function f_yuedu_yxqi(igd)
{
	var yuedu_yxqi    =document.getElementById("yuedu_yxqi_"+igd);//阅读有效期
	var span_1_yd_time =document.getElementById("span_1_yd_time_"+igd);//期次绝对时间id
	var span_2_yd_time =document.getElementById("span_2_yd_time_"+igd);//期次绝对时间id
	
	if(yuedu_yxqi.value==1)//绝对
	{
		span_1_yd_time.style.display="";
		span_2_yd_time.style.display="none";
	}
	if(yuedu_yxqi.value==2)//选中相对
	{
		span_1_yd_time.style.display="none";
		span_2_yd_time.style.display="";
	}
	
}


//判断是否为空
function f_submit()
{
	if(form1.subject.value=='')
	{
		alert('套餐名称不能为空!');
		form1.subject.focus();
		return false;
	}
	var fs = false;

	for(var i =1;i<form1.rnum2.value.split('/').length;i++)
	{
		var a = 0;
		if(form1.rnum2.value.split('/')!=''&&form1.rnum2.value.split('/').length>0)
		{
			a = form1.rnum2.value.split('/')[i];
		} else
		{
			 continue; 
		}
	
		if(a>0)
		{
					var qc_timec =document.getElementById("qc_timec_"+a);//期次范围  开始时间
					var qc_timed =document.getElementById("qc_timed_"+a);//期次范围  结束时间
					var qc_2_timec =document.getElementById("qc_2_timec_"+a);
					var qc_2_timed =document.getElementById("qc_2_timed_"+a);


					
					var yd_timec =document.getElementById("yd_timec_"+a);//阅读有效期 开始时间
					var yd_timed =document.getElementById("yd_timed_"+a);//阅读有效期 开始时间
					var yd_2_timec =document.getElementById("yd_2_timec_"+a);
					var yd_2_timed =document.getElementById("yd_2_timed_"+a);
					
					
					var qici_fanwei = document.getElementById("qici_fanwei_"+a);
					var yuedu_yxqi = document.getElementById("yuedu_yxqi_"+a);
					

					if(qici_fanwei.value==1)
					{
						  if(qc_timec.value=='')
						  {
							  alert("期次范围的开始时间不能为空");
							  qc_timec.focus();
							  return false;
						  }
						  if(qc_timed.value=='')
						  {
							  alert("期次范围的结束时间不能为空");
							  qc_timed.focus();
							  return false;
						  }
					}else
					{
						 if(qc_2_timec.value=='')
						  {
							  alert("期次范围的开始时间不能为空");
							  qc_2_timec.focus();
							  return false;
						  }
						  if(qc_2_timed.value=='')
						  {
							  alert("期次范围的结束时间不能为空");
							  qc_2_timed.focus();
							  return false;
						  }
					}

					
					  if(yuedu_yxqi.value==1)
					  {
						  if(yd_timec.value=='')
						  {
							  alert("阅读有效期的开始时间不能为空");
							  yd_timec.focus();
							  return false;
						  }
						  if(yd_timed.value=='')
						  {
							  alert("阅读有效期的结束时间不能为空");
							  yd_timed.focus();
							  return false;
						  }
					  }else
					  {
						  if(yd_2_timec.value=='')
						  {
							  alert("阅读有效期的开始时间不能为空");
							  yd_2_timec.focus();
							  return false;
						  }
						  if(yd_2_timed.value=='')
						  {
							  alert("阅读有效期的结束时间不能为空");
							  yd_2_timed.focus();
							  return false;
						  }
					  }
					  
		}
		
	}

	if(form1.membertype.value==0)
	{
		alert("请选择要绑定的会员类型!");
		form1.membertype.focus();
		return false;
	}
	
	if(form1.marketprice.value=='')
	{
		alert('人民币价格不能为空!');
		form1.marketprice.focus();
		return false;
	}
	if(form1.promotionsprice.value=='')
	{
		alert('美元价格不能为空!');
		form1.promotionsprice.focus();
		return false;
	}
	if(form1.remarks.value=='')
	{
		alert('备注说明不能为空!');
		form1.remarks.focus();
		return false;
	}

}

//相对时间说明提示
function f_sm()
{
	var smid =document.getElementById("smid");//期次范围  开始时间
	if(smid.style.display=='none')
	{
		smid.style.display="";
	}else
	{
		smid.style.display="none";
	}
	
}
//判断相对时间输入格式
function qc_2_timec(str,igd)
{
	var smid =document.getElementById(str+"_"+igd);
	if(smid.value!='')
	{
	
		if(smid.value.substring(0,1).indexOf("+")==-1 && smid.value.substring(0,1).indexOf("-")==-1)
		{
			alert("您输入的相对时间格式不正确，请重新输入");
			smid.value = '';
			return false;
		}
		
		if(smid.value.substring(smid.value.length-1,smid.value.length).indexOf("Y")==-1 && smid.value.substring(smid.value.length-1,smid.value.length).indexOf("M")==-1 && smid.value.substring(smid.value.length-1,smid.value.length).indexOf("D")==-1)
		{
			alert("您输入的相对时间格式不正确，请重新输入");
			smid.value = '';
			return false;
		}

 
		 var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
		    var nubmer = smid.value.substring(1,smid.value.length-1);
		   
		     if (isNaN(nubmer)) 
		    {
		    	 alert("您输入的相对时间格式不正确，请重新输入");
				smid.value = '';
		        return false;
		     }

 
		
	} 
		
		  
	 

	    
}
</script>
<%//String s;s.length();s.substring();s.indexOf() %>
<h1>套餐管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 method=POST action="/servlet/EditSubscribe" onsubmit="return f_submit();" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="subid" value="<%=subid%>">
<input type="hidden" name="act" value="EditSubscribe">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<input type='hidden' name="subid" value="<%=subid %>"> 
<input type="hidden" name="nexturl" value="<%=nexturl%>"/> 
<input type="hidden" name="rnum" value="<%if(rrcount>0){out.print(rrcount+1);}else{out.print("1");} %>"/>
<input type="hidden" name="rnum2" id ="rnum2" value="<%if(rrcount>0){out.print(ReadRight.getRnum(teasession._nNode,subid,"Subscribe"));}else{out.print("/1/");} %>" >
   <input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex' value="1" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "套餐名称")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=subject value="<%if(sobj.getSubject()!=null)out.print(sobj.getSubject()); %>" size=70 maxlength=255></td>
  </tr>

 
  <tr>
	<td align="right" nowrap><font color="red">*</font>&nbsp;阅读权限：</td>
	<td >
	<table >
			<tr>
				<td align="right" nowrap>版面：</td>
				<td ><input type=checkbox name="suoyou_1" value="0" id="suoyou_1" onClick="f_suoyou('1');" <%if(rrobj_1.getSuoyou()==0){out.print(" checked=true");} %> >&nbsp;所有版面</td>
			</tr>
			<tr id="sybanci_1"  style=display:none>
				<td>&nbsp;</td>
				<td style="word-break:break-all;">
					<span id="sy_banci_ajax_1"></span>
				</td>
			</tr>
			<tr>
				<td align="right" nowrap>期次范围：</td>
				<td>
				
					<select name="qici_fanwei_1" id="qici_fanwei_1" onChange="f_qici_fanwei(1);">
						<%
							for(int j = 1;j<ReadRight.FANWEI_TYPE.length;j++)
							{
								out.print("<option value="+j);
								if(rrobj_1.getQici_fanwei()==j)
								{
									out.print(" selected ");
								}
								out.print(">"+ReadRight.FANWEI_TYPE[j]);
								out.print("</option>");
							}
						%>
					
					</select> 
				
					<span id="span_1_qc_time_1" <%if(rrobj_1.getQici_fanwei()==2){out.print("style=display:none");} %>>
						<input type="text" name="qc_timec_1" id="qc_timec_1"  <%if(rrobj_1.getQici_suoyou()==1){out.print(" disabled=true ");} %> size="7" value="<%if(rrobj_1.getQc_timec()!=null)out.print(rrobj_1.getQc_timecToString() );%>"  readonly>
						<img style="margin-bottom:-8px;" style="cursor:pointer" id="qc_img_timec_1"  <%if(rrobj_1.getQici_suoyou()==1){out.print(" disabled=true ");} %> src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.qc_timec_1');" />
						-
						<input type="text"  name="qc_timed_1" id="qc_timed_1"  size="7"  <%if(rrobj_1.getQici_suoyou()==1){out.print(" disabled=true ");} %>  value="<%if(rrobj_1.getQc_timed()!=null)out.print(rrobj_1.getQc_timedToString()); %>"  readonly>	
						<img style="margin-bottom:-8px;" style="cursor:pointer"  id="qc_img_timed_1"  <%if(rrobj_1.getQici_suoyou()==1){out.print(" disabled=true ");} %> src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.qc_timed_1');" />
					</span>
					 
					<span id="span_2_qc_time_1" <%if(rrobj_1.getQici_fanwei()==1 || rrobj_1.getQici_fanwei()==0){out.print("style=display:none");} %>>
						<input type="text" name="qc_2_timec_1" id="qc_2_timec_1" onChange="qc_2_timec('qc_2_timec','1');"  size="7"  value="<%if(rrobj_1.getQc_2_timec()!=null)out.print(rrobj_1.getQc_2_timec()); %>">
						-
						<input type="text"  name="qc_2_timed_1" id="qc_2_timed_1"  onchange="qc_2_timec('qc_2_timed','1');"    size="7"  value="<%if(rrobj_1.getQc_2_timed()!=null)out.print(rrobj_1.getQc_2_timed()); %>">	
					</span>		
				</td> 
			</tr>
			<tr>
				<td align="right" nowrap>阅读有效期：</td>
				<td>
				 <select name="yuedu_yxqi_1" id="yuedu_yxqi_1"  onchange="f_yuedu_yxqi(1);">
						<%
							for(int j2 =1;j2<ReadRight.FANWEI_TYPE.length;j2++)
							{
								out.print("<option value="+j2);
								if(rrobj_1.getYuedu_yxqi()==j2)
								{
									out.print(" selected ");
								}
								out.print(">"+ReadRight.FANWEI_TYPE[j2]);
								out.print("</option>");
							}
						%>
					</select>	
			
					<span id="span_1_yd_time_1"  <%if(rrobj_1.getYuedu_yxqi()==2 ){out.print(" style=display:none");} %>>
						<input type="text" name="yd_timec_1" id="yd_timec_1"  size="7"  <%if(rrobj_1.getYd_sheweiyoujiu()==1){out.print(" disabled=true ");} %> value="<%if(rrobj_1.getYd_timec()!=null)out.print(rrobj_1.getYd_timecToString()); %>"  readonly>
						<img style="margin-bottom:-8px;" style="cursor:pointer" id="yd_img_timec_1" <%if(rrobj_1.getYd_sheweiyoujiu()==1){out.print(" disabled=true ");} %>  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.yd_timec_1');" />
						-
						<input type="text"  name="yd_timed_1" id="yd_timed_1"  size="7" <%if(rrobj_1.getYd_sheweiyoujiu()==1){out.print(" disabled=true ");} %>  value="<%if(rrobj_1.getYd_timed()!=null)out.print(rrobj_1.getYd_timedToString()); %>"  readonly>	
						<img style="margin-bottom:-8px;" style="cursor:pointer" id="yd_img_timed_1" <%if(rrobj_1.getYd_sheweiyoujiu()==1){out.print(" disabled=true ");} %> src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.yd_timed_1');" />
					</span>
					  
					<span id="span_2_yd_time_1"  <%if(rrobj_1.getYuedu_yxqi()==1 || rrobj_1.getYuedu_yxqi()==0){out.print(" style=display:none");} %>>
						<input type="text" name="yd_2_timec_1" id="yd_2_timec_1"   onchange="qc_2_timec('yd_2_timec','1');"     size="7" value="<%if(rrobj_1.getYd_2_timec()!=null)out.print(rrobj_1.getYd_2_timec()); %>" >
						-
						<input type="text"  name="yd_2_timed_1" id="yd_2_timed_1"   onchange="qc_2_timec('yd_2_timed','1');"  size="7" value="<%if(rrobj_1.getYd_2_timed()!=null)out.print(rrobj_1.getYd_2_timed()); %>" >	
					</span>		
					
				</td>
			</tr>
		</table>
		
	</td>

</tr>


<%
if(rrcount>1)
{

	String str_HTML = "";
	Enumeration e = ReadRight.find(" and node ="+teasession._nNode+" and father ="+subid+"  and type ="+DbAdapter.cite("Subscribe")+" and rnum !=1 ",0,Integer.MAX_VALUE);
	while(e.hasMoreElements())
	{
		int rrid = ((Integer)e.nextElement()).intValue();
		
		ReadRight rrobj = ReadRight.find(rrid);
		int rnum = rrobj.getRnum();

		 str_HTML+="<tr id= SignItem"+rnum+">";
		 str_HTML+="<td>&nbsp;</td>";
		 str_HTML+="<td>";
		
		 str_HTML += "<table>";
		str_HTML += "<tr>";
		   str_HTML += "<td align=\"right\" nowrap>版面："+rnum+"</td>";
		  str_HTML += "<td><input type=checkbox  name=suoyou_"+rnum+" value=0 id=suoyou_"+rnum+" onclick=f_suoyou('"+rnum+"'); ";
		
		  if(rrobj.getSuoyou()==0)
		  {
			  str_HTML +="  checked=true ";
		   } 
		  str_HTML += " nowrap>&nbsp;所有版面</td><td><a href=# onclick=GetRow('SignItem"+rnum+"',"+rnum+");>删除</a></td>";
		str_HTML += "</tr>";
	
	////////--------------隐藏的版面信息---------------////////////////
		str_HTML += "<tr id=sybanci_"+rnum+"  style=display:none ";

	 
		str_HTML += ">";
			str_HTML += "<td>&nbsp;</td>";
			str_HTML += "<td>";
				str_HTML += "<span id=sy_banci_ajax_"+rnum+"></span>";
			str_HTML += "</td>"; 
		str_HTML += "</tr>";
		
	 ////////--------------//显示期次范围---------------////////////////
		str_HTML += "<tr>";
	   str_HTML += "<td align=right nowrap>期次范围：</td>";
	  str_HTML += "<td>";
	  
		  str_HTML += "<select name=qici_fanwei_"+rnum+"  id=qici_fanwei_"+rnum+" onchange=f_qici_fanwei('"+rnum+"');>";

		  for(int j = 1;j<ReadRight.FANWEI_TYPE.length;j++)
			{
			  str_HTML += "<option value="+j;
				if(rrobj.getQici_fanwei()==j)
				{
					 str_HTML += " selected ";
				}
				 str_HTML += ">"+ReadRight.FANWEI_TYPE[j];
				 str_HTML += "</option>";
			}
		  
		  str_HTML += "</select>";
		  
		  
		  str_HTML += "<span id=span_1_qc_time_"+rnum+"";
		  if(rrobj.getQici_fanwei()==2)
		  {
			  str_HTML +=" style=display:none ";
		  }
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text name=qc_timec_"+rnum+" id=qc_timec_"+rnum+" readonly size=7   value=";
			  if(rrobj.getQc_timec()!=null)
			  {
				  str_HTML += rrobj.getQc_timecToString();
			  }
			 if(rrobj.getQici_suoyou()==1)
			 {
				 out.print(" disabled=true ");
			 }
			  
			  str_HTML +=">";
			  
			  str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer id=qc_img_timec_"+rnum+"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timec_"+rnum+"');\"" ;
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
			  
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_timed_"+rnum+" id=qc_timed_"+rnum+"  size=7  readonly value=";
			  if(rrobj.getQc_timed()!=null)
			  {
				  str_HTML += rrobj.getQc_timedToString();
			  }
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
			  
			  
			  str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer id=qc_img_timed_"+rnum+"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.qc_timed_"+rnum+"');\" ";
			  if(rrobj.getQici_suoyou()==1)
				 {
					 out.print(" disabled=true ");
				 }
			  str_HTML +=">";
		  str_HTML += "</span>";
				
		  
		  str_HTML += "<span id=span_2_qc_time_"+rnum+" ";
		  if(rrobj.getQici_fanwei()==1 || rrobj.getQici_fanwei()==0)
		  {
			  str_HTML +="style=display:none";
		  } 
		  str_HTML +=">";
		  
			  str_HTML += "<input type=text  name=qc_2_timec_"+rnum+"    onchange=qc_2_timec('qc_2_timec',"+rnum+"); id=qc_2_timec_"+rnum+"  size=7  value=";
			  if(rrobj.getQc_2_timec()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timec();
			  }
			  str_HTML +=">";
			  
			  str_HTML += "-";
			  str_HTML += "<input type=text  name=qc_2_timed_"+rnum+" id=qc_2_timed_"+rnum+"   onchange=qc_2_timec('qc_2_timed',"+rnum+");   size=7  value=";
			  if(rrobj.getQc_2_timed()!=null)
			  {
				  str_HTML +=rrobj.getQc_2_timed();
			  }
			  str_HTML +=">";
		  str_HTML += "</span>";
		
		  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
	
	////////--------------//显示阅读有效期---------------////////////////
	
	
	
		str_HTML += "<tr>";
	   str_HTML += "<td align=right nowrap>阅读有效期：</td>";
	  str_HTML += "<td>";
	
		  str_HTML += "<select name=yuedu_yxqi_"+rnum+"  id=yuedu_yxqi_"+rnum+" onchange=f_yuedu_yxqi("+rnum+");>";
		  for(int j2 =1;j2<ReadRight.FANWEI_TYPE.length;j2++)
			{
			  str_HTML += "<option value="+j2;
				if(rrobj.getYuedu_yxqi()==j2)
				{
					 str_HTML += " selected ";
				}
				 str_HTML += ">"+ReadRight.FANWEI_TYPE[j2];
				 str_HTML += "</option>";
			}
		str_HTML += "</select>";		
		 
		 
		str_HTML += "<span id=span_1_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==2 )
		{
			str_HTML +=" style=display:none";
		}
		str_HTML +=">";
		
			str_HTML += "<input type=text name=yd_timec_"+rnum+" id=yd_timec_"+rnum+"  size=7  readonly value=";
			if(rrobj.getYd_timec()!=null)
			{
				str_HTML += rrobj.getYd_timecToString(); 
			}
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 

			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer  id=\"yd_img_timec_"+rnum+"\"  src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timec_"+rnum+"');\" ";
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			str_HTML += ">";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_timed_"+rnum+" id=yd_timed_"+rnum+"  size=7  readonly value=";
			if(rrobj.getYd_timed()!=null)
			{
				str_HTML += rrobj.getYd_timedToString(); 
			}
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			
			str_HTML += ">";
			str_HTML += "<img style=margin-bottom:-8px; style=cursor:pointer  id=\"yd_img_timed_"+rnum+"\"   src=/tea/image/bbs_edit/table.gif onclick=\"new Calendar().show('form1.yd_timed_"+rnum+"');\" ";
			if(rrobj.getYd_sheweiyoujiu()==1)
			{
				str_HTML += " disabled=true ";
			} 
			str_HTML += ">"; 
		str_HTML += "</span>";
	
		str_HTML += "<span id=span_2_yd_time_"+rnum+" ";
		if(rrobj.getYuedu_yxqi()==1 || rrobj.getYuedu_yxqi()==0)
		{
			str_HTML += " style=display:none";
		}
		str_HTML +=">";
			str_HTML += "<input type=text name=yd_2_timec_"+rnum+" id=yd_2_timec_"+rnum+"    onchange=qc_2_timec('yd_2_timec',"+rnum+");  size=7  value=";
			if(rrobj.getYd_2_timec()!=null)
			{
				str_HTML +=rrobj.getYd_2_timec();
				
			}
			str_HTML += ">";
			str_HTML += "-";
			str_HTML += "<input type=text  name=yd_2_timed_"+rnum+" id=yd_2_timed_"+rnum+"   onchange=qc_2_timec('yd_2_timed',"+rnum+");  size=7 value=";
			if(rrobj.getYd_2_timed()!=null)
			{
				str_HTML +=rrobj.getYd_2_timed();
			}
			str_HTML += ">";
		str_HTML += "</span>"; 
	
		
	  
	  str_HTML += "</td>";
	str_HTML += "</tr>";
		
	 
		 str_HTML += "</table>"; 
		 
		 str_HTML +="</td>";
		 str_HTML +="</tr>";
	} 
	out.print(str_HTML);
}
%>
  
			<tr>
			    <td>&nbsp;</td>
				<td nowrap><input type="button" value="添加权限" onClick="add();"/>&nbsp;<a href="#" onClick="f_sm();";>相对时间说明</a></td>
			</tr>
			<tr id="smid" style="display:none">
			    <td>&nbsp;</td>
				<td>相对时间格式：相对时间指相对于激活时间的偏移量，例如：激活时间为2009-10-01，则+1Y表示正偏移一年，即2010-10-01，-1M表示负偏移一个月，即2010-09-01
			  </br>时间单位可以为：日（D）、月（M）、年（Y）,但必须都是大写的字母。</td>
			</tr>
<tr>

  <tr>
  	<td align="right" nowrap><font color="red">*</font>&nbsp;绑定会员类型：</td>
  	<td>
  		<select name="membertype">
  			<option value="0">--请选择会员类型--</option>
  				<%
  				 java.util.Enumeration e = tea.entity.admin.mov.MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
  		    while(e.hasMoreElements())
  		    {
  		      int membertype = ((Integer)e.nextElement()).intValue();
  		    tea.entity.admin.mov.MemberType  myobj = tea.entity.admin.mov.MemberType.find(membertype);
  		   
  		      out.print("<option value="+membertype);
  		      if(sobj.getMembertype()==membertype)
  		      {
  		    	  out.print(" selected ");
  		      }
  		      out.print(">");
  		      out.print(myobj.getMembername());
  		      out.print("</option>");
  		      
  		    }
  				%>
  			</select>
  	</td>
  </tr>
   <tr>
    <td align="right" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "人民币价格")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=marketprice value="<%if(sobj.getMarketprice()!=null)out.print(sobj.getMarketprice()); %>"  maxlength=255>&nbsp;元</td>
  </tr>
  <tr>
    <td align="right" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "美元价格")%>:</td>
    <td><input type="TEXT" class="edit_input"  name=promotionsprice value="<%if(sobj.getPromotionsprice()!=null)out.print(sobj.getPromotionsprice()); %>" maxlength=255>&nbsp;元</td>
  </tr>
 

  <tr>
    <td align="right" nowrap><font color="red">*</font>&nbsp;<%=r.getString(teasession._nLanguage, "备注说明")%>:</td>
    <td><textarea rows="4" cols="45" name="remarks"><%if(sobj.getRemarks()!=null)out.print(sobj.getRemarks()); %></textarea></td>
  </tr>
</table>

<br> 
<input type="submit" value="提交" >&nbsp;<input type=button value="返回" onClick="window.open('<%=nexturl%>','_self');">
</body>
</html>
