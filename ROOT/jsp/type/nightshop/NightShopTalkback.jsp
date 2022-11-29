<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@ page  import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  //response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  response.sendRedirect("/jsp/user/userlogin.jsp");
  return;
}

Http h=new Http(request);
int tkid =h.getInt("tkid");
Talkback obj = Talkback.find(tkid);
int count = Talkback.count(" and node = "+teasession._nNode+" and rmember ="+DbAdapter.cite(teasession._rv.toString()));
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");


%><html>
<head>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/res/westrac/cssjs/101L1.css" rel="stylesheet" type="text/css">
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<%
if(count > 0)
{
	   out.print("<script>");
       
       out.print("alert('"+r.getString(teasession._nLanguage, "Youhavealreadycommentedon")+"');");
       out.print("parent.ymPrompt.close();");
       out.print("parent.window.location.reload();");
       out.print("</script>");
}

%>
</head>

<script>
	function f_submit()
	{
		
		  
	
		  if(form1.content.value=='')
		  {
		  
		    document.getElementById("contentid").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Experiencetheexperiencecannotbeempty")%></font>';
		    form1.content.focus();
		       return false;
		  }
		  
		  document.getElementById("contentid").innerHTML='';
		  
			if(form1.subject.value=='')
			  {
			    
			    document.getElementById("subjectid").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Advantagescannotbeempty")%></font>';
			    form1.subject.focus();
			    return false;
			  }
			document.getElementById("subjectid").innerHTML='';
			
			  
			if(form1.name.value=='')
			  {
			    
			    document.getElementById("nameid").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Notenoughisempty")%></font>';
			    form1.name.focus();
			    return false;
			  }
			document.getElementById("nameid").innerHTML='';
			
		  ymPrompt.win({message:'<br><center><%=r.getString(teasession._nLanguage, "informationbeingsubmittedpleasewait")%>...</center>',title:'',width:'300',height:'50',titleBar:false});
		  
		  
		
	
							form1.action="/servlet/EditTalkback";
							form1.submit();
				
	
	}
	
	 function countChar(textareaName,spanName)//统计剩余字数
     {

       if(document.getElementById(textareaName).value.length > 6000){
         alert("<%=r.getString(teasession._nLanguage, "Sorryyourwordshavemorethan")%>");
         document.getElementById(spanName).innerHTML = 0;
       }else{
         document.getElementById(spanName).innerHTML = 6000 - document.getElementById(textareaName).value.length;
       }
     }
	
</script>
<body>
<h2><%=r.getString(teasession._nLanguage, "Myreviews")%></h2>
    <FORM NAME="form1" METHOD=POST action="?" >
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
	<input type="hidden" name="act" value="GolfTalkback">
   
    

    
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td class="left"><%=r.getString(teasession._nLanguage, "Rate")%>：</td>
      <td class="right">
      <%
      for(int i=5;i>0;i--)
      {
        out.print("<input id=radio"+i+" type=\"radio\" name=\"hint\" value="+i);
        if(5==i)
        {
          out.print(" checked ");
        }

        out.print(">");
        out.print("<div class=\"ScorePic\"><div id=ScorePic"+i);
        out.print(" style=cursor:pointer  onclick=document.getElementById('radio"+i+"').checked=true");
        out.print("></div></div>");
      }
      %></td>
         <tr>
        <td class="left"><%=r.getString(teasession._nLanguage, "Experienceexperience")%>：</td>
        <td class="right"><TEXTAREA id="status"   NAME="content" COLS=53 ROWS=8 class="edit_input" onkeydown='countChar("status","counter");' onkeyup='countChar("status","counter");'><%=Entity.getNULL(obj.getContent(teasession._nLanguage)) %></TEXTAREA>
        <span id="contentid"></span>
        </td>
      </tr>
        <tr>
        <td colspan="2" align="right"><%=r.getString(teasession._nLanguage, "Youcanalsoenter")%><span id="counter">6000</span><%=r.getString(teasession._nLanguage, "Words")%></td>
      </tr>
      <tr>
        <td class="left"><%=r.getString(teasession._nLanguage, "Advantage")%>：</td>
        <td class="right"><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="<%=Entity.getNULL(obj.getSubject(teasession._nLanguage)) %>" SIZE=60 MAXLENGTH=50><span id="subjectid"></span></td>
      </tr>
        <tr>
        <td class="left"><%=r.getString(teasession._nLanguage, "Inadequate")%>：</td>
        <td class="right"><INPUT NAME="name" TYPE=TEXT class="edit_input" VALUE="" SIZE=60 MAXLENGTH=50><span id="nameid"></span></td>
      </tr>
   
      <tr>
        <td class="center" colspan="2"><input type="button" value="<%=r.getString(teasession._nLanguage, "submitcomments")%>" onClick="f_submit();"></td>

      </tr>
       </table>
      </form>
 


</body>
</html>
