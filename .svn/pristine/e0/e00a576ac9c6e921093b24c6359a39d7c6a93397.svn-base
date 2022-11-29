<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.orthonline.*" %>
<%@page  import="tea.entity.member.*" %>
<%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.site.*" %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache"); 

TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/Report");
String members2= teasession.getParameter("members2");
String eid = teasession.getParameter("eid");

StringBuffer sp =new StringBuffer("&nbsp;");
StringBuffer sp2 =new StringBuffer("/");

String act = teasession.getParameter("act");
 
if(eid!=null && eid.length()>0)
{
	//威斯特 报名会员中的积分设置
	for(int i=1;i<eid.split("/").length;i++)
	{
		
		int e = Integer.parseInt(eid.split("/")[i]);
		Eventregistration eobj = Eventregistration.find(e);
		
		if(sp2.toString().indexOf("/"+eobj.getMember()+"/")==-1){
			sp2.append(eobj.getMember()).append("/"); 
			
		} 
	}
	members2= sp2.toString();
}

 

if(members2!=null&&members2.length()>0){
	for(int i=1;i<members2.split("/").length;i++)
	{
		
		Profile p = Profile.find(members2.split("/")[i]);
		
	
		sp.append(members2.split("/")[i]).append("&nbsp;"); 
	}
}
%>
<html>
<head>
<title>积分设置</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
var doc=dialogArguments.document;
function f_submit()
{
    var h=form1.integral.value;
    
    
	var fname=document.getElementsByName("issms");
    var lname="";  

    for(var i=0; i<fname.length; i++)
    { 
    	if( fname[i].checked==true){
       	   lname = lname + fname[i].value; 
       }
     }
    
    if(lname==1){
	    document.getElementById('buttonid').value='短信正在发送,请稍候...';
		document.getElementById('buttonid').disabled=true;
		document.getElementById('closeid').style.display='none';
		ymPrompt.win({message:'<br><center>短信正在发送,请稍候...</center>',title:'',width:'300',height:'50',titleBar:false});
    }
    
 
     sendx("/servlet/OrthSubscribers?lname="+lname+"&integral="+h+"&reasonstring="+encodeURIComponent(form1.reasonstring.value)+"&members="+encodeURIComponent(form1.members2.value)+"&act="+form1.act.value,
		 function(data)
		 {

		  //alert("4444->>>>."+data.length);
		 
				alert('操作成功');
			    window.returnValue=h;
    			window.close();
   				return false;
			  
		   
		 }
		 );
}
</script>
<style type="text/css">
#nt_step_2{ padding-left:20px; }
#nt_step_3{ padding-left:40px; }
</style>
</head>
<body >

<form name="form1" method="post" action="?" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node">
<input type="hidden" name="act" value="<%=act %>">
<input type='hidden' name="members2" value="<%=members2 %>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td align="right" nowrap><b>会员ID：</b></td>
    <tD><%=sp.toString() %></tD>
  </tr>
 <tr>
 <td align="right" nowrap ><b>加减积分：</b></td>
    <td><input type="text"  name="integral" value="" size="4"></td>
 </tr>
 <tr>
 <td align="right">注：</td>
 <td>&nbsp;如果加分直接填写数字，例如加10 就填写10；<br>
    &nbsp;如果加分则要加入“-”号，例如减10 就填写-10。</td>
    </tr>
  <td align="right" nowrap><b>加分原因：</b></td>
    <td><textarea rows="2" cols="50" name="reasonstring"></textarea></td>
 </tr>
  <td align="right" nowrap><b>是否发送短信：</b></td>
    <td><input type="checkbox" id ="issms" name="issms" value="1">&nbsp;</td>
 </tr>
<tr>


</table>
<br/>


<input type="button" id="buttonid" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" onclick="f_submit();" >


<input type="button" id="closeid" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onclick="window.close()">
</form>

</body>
</html>
