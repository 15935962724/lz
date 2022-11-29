<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.integral.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.net.URLEncoder"%>

<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
int membertype = 0;
//String nexturl =request.getRequestURI()+"?en=en"; //teasession.getParameter("nexturl");

%> 
<script type="text/javascript" src="/tea/ym/ymPrompt.js"></script>
<link rel="stylesheet" id='skin' type="text/css" href="/tea/ym/skin/bluebar/ymPrompt.css" />
<script>
 
	function f_gerad(igd,mtype){
		en();
		 
		var url = '/jsp/mov/EditWomenRegister.jsp?en=en&member='+encodeURIComponent(igd)+'&membertype='+mtype;
		 
		
		//ymPrompt.win({message:url,width:800,height:600,title:'Edit',handler:handler,maxBtn:true,minBtn:true,iframe:true});
		ymPrompt.win({title:'Edit',width:800,height:600,handler:noTitlebar,btn:[['Close']],fixPosition:true,maxBtn:true,minBtn:true,iframe:{id:'myId',name:'myName',src:url}})
	
	} 
	function noTitlebar() 
	{
		//alert('ddd'); 
		 //ymPrompt.close();
		  //window.location.reload(); 
	}
	function en(){

			ymPrompt.setDefaultCfg({title:'Default Title', message:"Default Message",okTxt:' OK ',cancelTxt:' Cancel ',closeTxt:'Close',minTxt:'Minimize',maxTxt:'Maximize'});
 
		}
	
	 
</script> 
<%
if("en".equals(teasession.getParameter("en"))){
	out.print("<script>alert('dddd');ymPrompt.close();</script>");
}
 
if(teasession._rv!=null)
{
	String member=teasession._rv._strV;
	Profile p=Profile.find(member);
	if(teasession.getParameter("membertype")!=null){
		membertype = Integer.parseInt(teasession.getParameter("membertype"));
	}else
	{
		membertype = tea.entity.admin.mov.MemberOrder.getMemberType(teasession._strCommunity,member);	
	}
	
	//个人中心  
//&nexturl=/jsp/mov/EditWomenRegister.jsp?member='+encodeURIComponent(igd)+'&membertype='+mtype+'
	//nexturl = "/jsp/mov/EditWomenRegister.jsp?"+nexturl +"&en=en&member="+java.net.URLEncoder.encode(member,"UTF-8");
	  tea.entity.admin.AdminUsrRole aur = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
	
	  if(aur.isExists()&&aur.getRole().split("/").length>=1){//如果有角色 
		 out.print("<span id =memberadmin>");
		 out.print("You have signed in successfully. <a href=\"/jsp/admin/indextop.jsp\" id=\"account\">Account Settings</a>&nbsp;<a type=\"button\" value=\"Logout\" onclick=\"window.open('/servlet/Logout', '_self');\" href=\"###\">Logout</a>");
		 out.print("</span>");
	  }else
	  { 
		 
			out.print("<span id =memberpersonal>");
			 out.print("You have signed in successfully. <a href=\"###\" onclick=f_gerad('"+member+"','"+membertype+"'); id=\"account\">Hello, "+p.getFirstName(teasession._nLanguage)+"</a>&nbsp;<a type=\"button\" value=\"Logout\" onclick=\"window.open('/servlet/Logout', '_self');\" href=\"###\">Logout</a>");
			out.print("</span>");
	  }
}

%>


