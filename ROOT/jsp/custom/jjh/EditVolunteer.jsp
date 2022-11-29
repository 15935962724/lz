<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.ui.*,tea.entity.custom.jjh.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %>
<%
	TeaSession tea=new TeaSession(request);
	if(tea._rv==null){
		  response.sendRedirect("/servlet/StartLogin?node="+tea._nNode);
		  return;
	}
	if(Category.find(tea._nNode).getCategory()!=96){
		List list=Category.find(tea._strCommunity, 96, 0, Integer.MAX_VALUE);
		Iterator it=list.iterator();
		while(it.hasNext()){
			int nodeid=(Integer)it.next();
			Node node=Node.find(nodeid);
			if(node.getCommunity().equals(tea._strCommunity)){
				tea._nNode=node._nNode;
				break;
			}
		}
	}
	String vids=tea.getParameter("vid");
	int vid=0;
	if(vids!=null&&vids.length()>0){
		vid=Integer.parseInt(vids);
	}
	String nextUrl=tea.getParameter("nextUrl");
	if(nextUrl==null||nextUrl.length()==0){
		nextUrl=request.getRequestURL().toString();
	}
	int vsex=0,vprovince=0,vtype=1,vnation=0;
	String vnum="",vuwork="",vname="",vtime="",vphone="";
	if(vid>0){
		Volunteer v=Volunteer.getVolunteer(vid);
		vname=v.getVname();
		vnum=v.getVnum();
		vuwork=v.getVuwork();
		vtime=MT.f(v.getVtime());
		vphone=v.getVphone();
		vsex=v.getVsex();
		vnation=v.getVnation();
		vprovince=v.getVprovince();
		vtype=v.getVtype();
	}
	if(vtype==0){
		vtype=1;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑志愿者信息</title>
<link href="/res/<%=tea._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/custom/jjh/djq.js" type="text/javascript"></script>
<link href="/jsp/custom/jjh/djq.css" rel="stylesheet" type="text/css">

<style type="text/css">
	#btid{color:red}
</style>
<script>
//媒体管理
function f_medias()
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:557px;';
	 var url = '/jsp/custom/jjh/Vtypes.jsp';
	 var rs = window.showModalDialog(url,self,y);
	 var rs1=rs.split("*");
	 if(rs1[0]!=null){
		var sphtml="";
		var rs2= rs1[1].split("|");
		for(var i=0;i<rs2.length;i++){
			if(rs2[i]!=null&&rs2[i]!=""&&rs2[i]!=''){
				var rs3=rs2[i].split(";");
				var cc="";
				if(rs3[0]==rs1[0]){
					cc="checked";
				}
				sphtml=sphtml+"<input type='radio' name='vtype' id='vtype"+rs3[0]+"' value='"+rs3[0]+"' "+cc+" ><label for='vtype"+rs3[0]+"'>"+rs3[1]+"</label>&nbsp;&nbsp;&nbsp;";
			}
		}
		document.getElementById("sptype").innerHTML="";
		document.getElementById("sptype").innerHTML=sphtml;
	 }
}
</script>
</head>
<body>
<h1>志愿者基本信息</h1>
<form  name="form1" action="/EditVolunteers.do" onSubmit="return mt.checkform(this)"  target="_ajax"> 
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nextUrl" value="<%=nextUrl%>"/>
<input type="hidden" name="vid" value="<%=vid %>" />
<input type="hidden" name="node" value="<%=tea._nNode %>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>姓名:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="vname" value="<%=vname %>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>性别:</TD>
    <td nowrap>
    	<input type="radio" name="vsex" id="sex1" value="0" <%=vsex==0?"checked":"" %> ><label for="sex1">男</label>
    	<input type="radio" name="vsex" id="sex2" value="1" <%=vsex==1?"checked":"" %> ><label for="sex2">女</label>
    </td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>民族:</TD>
    <td nowrap>
    	<select name="vnation">
	    		<option value="0">----请选择----</option>
	    		<%for(int i=1;i<Volunteer.nations.length+1;i++){%>
	    				<option value="<%=i%>" <%=vnation==i?"selected":"" %>><%=Volunteer.nations[i-1] %></option>
	    		<%}%>
	    </select>
    
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>省份:</TD>
    <td nowrap>
		<script>mt.city("vprovince",null,null,"<%=vprovince%>");</script>
	</td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>身份证号:</TD>
    <td nowrap>
       	<input class="edit_input" name="vnum"  onblur="mt.f_card(this)" alt="身份证" type="text"  value="<%=vnum%>">
       	<span class="tip" id="vnum_info" style="display:none " >身份证号不能为空。</span>
	</td>
  </tr>
  <tr id="">
    <td nowrap align="right" ><span id="btid">*</span>类型:</TD>
    <td nowrap>
    	<span id="sptype"><%
    		List list=Voltype.findVoltypes("", 0, Integer.MAX_VALUE);
    		Iterator it=list.iterator();
    		while(it.hasNext()){
    			Voltype vt=(Voltype)it.next();%>
    			<input type="radio" name="vtype" id="vtype<%=vt.getVtid() %>" value="<%=vt.getVtid() %>" <%=vtype==vt.getVtid()?"checked":"" %> ><label for="vtype<%=vt.getVtid() %>"><%=vt.getVtname() %></label>
    		<%}
    	%></span>
    	
    	 <input type=button value="管理" name="show" onClick="f_medias();">
    </td>
  </tr>  
  <tr id="">
    <td nowrap align="right">所在单位:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="vuwork" value="<%=vuwork %> "></td>
  </tr>
  <tr id="">
    <td nowrap align="right">联系电话:</TD>
    <td nowrap><input type="TEXT" class="edit_input"  name="vphone" value="<%=vphone %>"></td>
  </tr>
  <tr id="">
    <td nowrap align="right">注册时间:</TD>
    <td nowrap>
		<input id="datestime" name="vtime" size="7"  value="<%=vtime %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.vtime');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.vtime');" />
    
 	</td>
  </tr>
  
</table>

  
  <span id="submitshow">
  <input id="submit1" class="edit_button" value="保存" onclick="" type="submit">&nbsp;
  <input name="reset" value="返回" onclick="window.open('<%=nextUrl%>','_self');" type="button">
</span>

</form>
</body>
</html>