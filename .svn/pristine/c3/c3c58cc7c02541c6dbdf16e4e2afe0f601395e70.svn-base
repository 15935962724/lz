<%@page import="tea.entity.member.ProfileBBS"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Resource r = new Resource();
r.add("/tea/resource/fashiongolf");


TeaSession teasession = new TeaSession(request);


Node node=Node.find(teasession._nNode);



StringBuffer sql = new StringBuffer();
StringBuffer param=new StringBuffer();

param.append("?node=").append(teasession._nNode);
sql.append(" AND node=").append(teasession._nNode);

int comm = 0;
if(teasession.getParameter("comm")!=null && teasession.getParameter("comm").length()>0)
{
	comm = Integer.parseInt(teasession.getParameter("comm"));	
}
if(comm==1)//好评
{
	sql.append(" and (hint = 4 or hint = 5)");
	param.append("&comm=").append(comm);
}
if(comm==2)//中评
{
	sql.append(" and (hint = 2 or hint = 3)");
	param.append("&comm=").append(comm);
}
if(comm==3)//差评
{
	sql.append(" and hint = 1");
	param.append("&comm=").append(comm);
}

	

int pos=0,size=5;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

sql.append(" AND hidden = 1  ");//显示审核通过


int count = Talkback.count(sql.toString());

sql.append(" ORDER BY talkback DESC ");

%>
<script type="text/javascript">
	
		document.domain="fashiongolf.com";
		try{
			parent.document.domain;
		}catch(e){}
</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/res/westrac/cssjs/101L1.css" rel="stylesheet" type="text/css">
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">

<script>
	/*
	function f_addt(igd)
	{
		ymPrompt.win({message:'/jsp/type/nightshop/NightShopTalkback.jsp?node='+igd,width:550,height:380,title:'我要点评',handler:function(){},maxBtn:false,minBtn:false,iframe:true});	
	}
	

	function login()
	{

	 ymPrompt.win({message:'/jsp/user/userlogin.jsp',width:488,height:250,title:'用户登录',handler:function(){},maxBtn:false,minBtn:false,closeBtn:false,titleBar:false,iframe:true});

	} 
	*/
	function f_fcomm(igd)
	{
		formcomm.comm.value = igd;
		formcomm.action="?";
		formcomm.submit();
	}
	

</script> 

<form name="formcomm" method="POST" action="?">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="comm" value="<%=comm %>">
<div id ="main_box"> 
<div class="switchComments">
<div class="left"><a href="###" onclick="f_fcomm('0');" id="commentid<%if(comm==0){out.print("_id");}%>"><%=r.getString(teasession._nLanguage, "Allreviewers")%></a><a href="###" onclick="f_fcomm('1');" id="commentid<%if(comm==1){out.print("_id");}%>"><%=r.getString(teasession._nLanguage, "Praise")%></a><a href="###" onclick="f_fcomm('2');" id="commentid<%if(comm==2){out.print("_id");}%>"><%=r.getString(teasession._nLanguage, "Neutralfeedback")%></a><a href="###" onclick="f_fcomm('3');" id="commentid<%if(comm==3){out.print("_id");}%>"><%=r.getString(teasession._nLanguage, "Poor")%></a></div>
<div class="right">
 <%
  	 if(teasession._rv==null)
  	 {
  		 out.println("<a href=\"###\" onclick=\"window.parent.login();\">"+r.getString(teasession._nLanguage, "Writeareview")+"</a>");
  	 }else{ 
  		 
  %>
  <a href="###" onclick="window.parent.f_addt('<%=teasession._nNode%>');"><%=r.getString(teasession._nLanguage, "Writeareview")%></a>
  <%} %>
  
  </div>
  </div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecen1">
  <%


  java.util.Enumeration e = Talkback.find(sql.toString(), pos, size);
  if(!e.hasMoreElements())
  {
      out.print("<tr><td colspan=4 align=center>"+r.getString(teasession._nLanguage, "NO")+"</td></tr>");
  }
  for(int i=1;e.hasMoreElements();i++)
  {
    int tbid = ((Integer)e.nextElement()).intValue();
    Talkback obj = Talkback.find(tbid);
  
    RV rv = obj.getCreator();
    ProfileBBS pbobj   = ProfileBBS.find(teasession._strCommunity,rv._strR);
    


    String subject=obj.getSubject(teasession._nLanguage);//优点
    String conten=obj.getContent(teasession._nLanguage);//使用心得


    %>
    
    <tr  id=tableone1>
    <td rowspan="2" class="headImg"><img src="<%=pbobj.getPortrait(teasession._nLanguage)%>" width="50" height="50"/></td>
    <td class="name"><%=pbobj.getTitle(teasession._nLanguage) %></td>
    <td class="ScorePicTd"><div class="ScorePic"><div id="ScorePic<%=obj.getHint() %>"></div></div></td>
	<td class="time"><%=obj.getTimeToString() %></td>
    </tr> 
    <tr>
      <td colspan="3" class="ScoreCon">
      <table cellpadding="0" cellspacing="0">
      <tr><td class="Scoreleft"><%=r.getString(teasession._nLanguage, "Advantage")%>：</td><td><%=subject %></td></tr>
      <tr><td class="Scoreleft"><%=r.getString(teasession._nLanguage, "Inadequate")%>：</td><td><%=obj.getName(teasession._nLanguage) %></td></tr>
      <tr><td class="Scoreleft"><%=r.getString(teasession._nLanguage, "Usetheexperience")%></td><td><%=conten %></td></tr>
      </table>
      </td>      
    </tr>
    

    
    <%} %>

    <%if (count > size) {  %>
    <tr> <td colspan="4" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
    <%}  %>
</table>
</div>
</form>



<script>
function changeIframeHeight ()
{
//main_box 为子页面中最外层的div的ID
 var mainObj = document.body;
 var height = 480 ;
if (mainObj)
 {
  height = mainObj.scrollHeight;

  if( height<480)
	  {
   			height = 480;
	  }
 } 
 if (parent)
 {
  var docObj ;
  if (parent.document)
  {
   docObj = parent.document ;
  }
  else
  {
   docObj = parent.contentDocument ;
  }

  docObj.getElementById("mainFrame").style.height=mainObj.scrollHeight + 'px'; 
 }
 
}
changeIframeHeight () ;
</script>