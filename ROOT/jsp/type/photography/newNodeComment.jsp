<%@page import="tea.entity.site.Community"%>
<%@page import="tea.ui.TeaSession"%>
<%@page contentType="text/html;charset=UTF-8"  %>

<%

TeaSession teasession = new TeaSession(request);
Community obj = Community.find(teasession._strCommunity);
%>


<script>	
function iframeResize()
{
 obj = document.getElementById("mainFrame");
 if (obj == undefined)
  return ;
 
 var iframeDocObj ;
 if (obj.document)
 {
  docHeight = mainFrame.document.body.scrollHeight; //iframeDocObj.body.scrollHeight ;
 }
 else
 {
  iframeDocObj = obj.contentDocument ;
  if (iframeDocObj.getElementById("main_box"))
   docHeight = iframeDocObj.getElementById("main_box").scrollHeight+50 ;
  else
   docHeight = 786 ;
 }
 
// docHeight = mainFrame.contentDocument.body.scrollHeight ;
 obj.style.height = (docHeight)+ 'px' ;
}



function f_addt(igd)
	{
	    mt.show('/jsp/type/nightshop/NightShopTalkback.jsp?node='+igd,2,'我要点评',550,380);
		//ymPrompt.win({message:'/jsp/type/nightshop/NightShopTalkback.jsp?node='+igd,width:550,height:380,title:'我要点评',handler:function(){},maxBtn:false,minBtn:false,iframe:true});	
	}
	

	function login()
	{
      location.href='<%="/"+(teasession._nStatus==0?"html":"xhtml")+"/" + teasession._strCommunity + "/folder/" + obj.getLogin() + "-" + teasession._nLanguage + ".htm"%>';
	 //ymPrompt.win({message:'/jsp/user/userlogin.jsp',width:488,height:250,title:'用户登录',handler:function(){},maxBtn:false,minBtn:false,closeBtn:false,titleBar:false,iframe:true});

	} 
</script>

<iframe src="/jsp/type/photography/newNodeComment2.jsp?node=<%=teasession._nNode %>"  id="mainFrame" name="mainFrame" scrolling="no" onload="iframeResize()" onload="javascript:{dyniframesize('mainFrame');}"  frameborder="0"  width="710"></iframe>


