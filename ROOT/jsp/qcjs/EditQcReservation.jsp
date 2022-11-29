<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");

String card = teasession.getParameter("card");
String archives =teasession.getParameter("archives");

int mid = QcMember.getMid(teasession._strCommunity,card,archives);

    

QcMember mobj = QcMember.find(mid);

int rid = 0;
if(teasession.getParameter("rid")!=null && teasession.getParameter("rid").length()>0){
	rid  = Integer.parseInt(teasession.getParameter("rid"));
}
 QcReservation robj = QcReservation.find(rid);
 if(rid>0){
		mid = robj.getMid();
 }

 if(card!=null && card.length()>0 && archives!=null && archives.length()>0&&mid==0){//说明没有
		out.print("<script>");
 		out.print("alert('对不起，您还没有登记,请与全程客服联系!');");
 		out.print("history.go(-1);");
		out.print("</script>");
 }
 

 if(card!=null && card.length()>0 && archives!=null && archives.length()>0&&mid>0&&robj.getMid()>0){//说明没有
		out.print("<script>");
 		out.print("alert('您已经预约过,不能再次预约!');");
 		out.print("history.go(-1);");
		out.print("</script>");
	}
%>

<html>
<head>
<title>在线预约</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
function f_sub()
{
	if(form1.name.value==''){    
		
		alert('姓名不能为空!');
		form1.name.focus();
		return false;
	} 
	if(form1.telephone.value==''){
		alert('电话不能为空!');
		form1.telephone.focus();
		return false; 
	}
	if(form1.card.value==''){
		alert('驾驶证号不能为空!');
		form1.card.focus();
		return false;
	}else{
		  var sID = form1.card.value;
	     if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
	     {
	       alert("请输入15位或18位驾驶证号");
	       form1.card.focus();
	      // document.form1.youxiaozhengjianhao.focus();
	      // form1.submitx.disabled=false;
	       return false;
	     }
	}

	if(form1.activity.value==-1){
		alert('请选择参加活动!');
		form1.activity.focus();
		return false;
	}

	if(!document.getElementById('manner1').checked && !document.getElementById('manner2').checked){
		alert('请选择接车方式!');
		return false;
	}else{
		if(document.getElementById('manner2').checked&&form1.mannerlocation.value==''){
			alert("接车地点不能为空!");
			form1.mannerlocation.focus();
			return false;
		}
	}
	
	if(form1.forms.value==-1){
		alert('请选择活动形式!');
		form1.forms.focus();
		return false;
	}

}

</script>

<div id="head6"><img height="6" src="about:blank"></div>
<form action="/servlet/EditQcReservation" name="form1" method="POST" onsubmit="return f_sub();" >
<input type="hidden" name="nexturl" value="<%=nexturl %>" >  
<input type="hidden" name="act" value="EditQcReservation"/>
<input type="hidden" name="mid" value="<%=mid %>"/>
<input type="hidden" name="rid" value="<%=rid %>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr >
	       <td nowrap align="right"><font color="red">*</font>&nbsp;姓名：</td>
	       <td nowrap><input type="text"  name="name" value="<%if(rid>0){out.print(Entity.getNULL(robj.getName()));}else{out.print(Entity.getNULL(mobj.getName()));} %>"/></td>
	       
    </tr>
       <tr >
    	 <td nowrap align="right"><font color="red">*</font>&nbsp;电话：</td>
	       <td nowrap><input type="text"  name="telephone" value="<%if(rid>0){out.print(Entity.getNULL(robj.getTelephone()));}else{out.print(Entity.getNULL(mobj.getTelephone())); }%>"/></td>
    </tr>
    <tr >
	       <td nowrap align="right"><font color="red">*</font>&nbsp;驾驶证号：</td>
	       <td nowrap><input type="text" name="card" value="<%if(rid>0){out.print(Entity.getNULL(robj.getCard()));}else{out.print(Entity.getNULL(mobj.getCard()));} %>"/></td>
    </tr>
     <tr >
	       <td nowrap align="right"><font color="red">*</font>&nbsp;参加活动：</td>
	       <td nowrap>
			<select name ="activity">
				<option value="-1">-参加活动-</option>
				<%
					Enumeration e = Node.find(" and  father =1255849 ",0,Integer.MAX_VALUE);
				
					for(int i=0;e.hasMoreElements();i++){
						int nid = ((Integer)e.nextElement()).intValue();
						Node nobj = Node.find(nid);
						out.print("<option value="+nid);
						if(robj.getActivity()==nid){
							out.print(" selected ");
						}
						out.print(">"+nobj.getSubject(teasession._nLanguage));
						out.print("</option>");
					}
				%>
			</select>
			</td>
    </tr>
    <tr >
	       <td nowrap align="right"><font color="red">*</font>&nbsp;接车方式：</td>
	       <td nowrap>
	       	<input type="radio" id="manner1" name ="manner" value="1"  onclick="document.getElementById('mannerlocation').style.display='none';form1.mannerlocation.value='';" <%if(robj.getManner()==1)out.print(" checked"); %>>&nbsp;驾校集合&nbsp;&nbsp;
	       	<input type="radio" id="manner2" name ="manner" value="2"  onclick="document.getElementById('mannerlocation').style.display=''"  <%if(robj.getManner()==2)out.print(" checked");%> >&nbsp;
	       	接车地点&nbsp;&nbsp;<input type="text" id="mannerlocation"  name="mannerlocation" value="<%=Entity.getNULL(robj.getMannerlocation()) %>" <%if(robj.getManner()==1 || robj.getManner()==0){out.print(" style=display:none" );} %>>
	       </td>
    </tr>
    
     <tr >
	       <td nowrap align="right"><font color="red">*</font>&nbsp;活动形式：</td>
	       <td nowrap>
			
			<input type="radio" id="forms1" name="forms" value="1" <%if(robj.getForms()==1 || robj.getForms()==0){out.println(" checked ");} %> onclick="document.getElementById('forms3').style.display='none';form1.mannerlocation.value='';">&nbsp;坐车&nbsp;
			<input type="radio" id="forms2" name="forms" value="2" <%if(robj.getForms()==2){out.println(" checked ");} %>  onclick="document.getElementById('forms3').style.display=''" >&nbsp;开车&nbsp;
			<select id="forms3" name ="forms3" <%if(robj.getForms()==1 || robj.getForms()==0){out.print(" style=display:none" );} %>>
				<%
					for(int i=0;i<QcReservation.FORMS_TYPE.length;i++){
						out.print("<option value="+i);
						if(robj.getForms3()==i)
							out.print(" selected "); 
						out.print(">"+QcReservation.FORMS_TYPE[i]);
						out.print("</option>");
					}
				%> 
			</select>
			</td>
    </tr>
        <tr >
	       <td nowrap align="right">备注：</td>
	       <td nowrap><textarea rows="4" cols="60" name="notes"><%=Entity.getNULL(robj.getNotes()) %></textarea></td>
    </tr>
    
    
    
  </table>
  <br/>
  <input type="submit" value="　提交　"/>&nbsp;<input type="reset" value="　清空　"> &nbsp;<input type="button" value="　返回　" onclick="history.go(-1);">&nbsp;
</form>
</body>
</html>
