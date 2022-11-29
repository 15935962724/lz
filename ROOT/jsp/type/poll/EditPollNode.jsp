<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%


r.add("/tea/resource/Poll");

%>
<script>

function faceChange(igd)
{
	 sendx("/jsp/type/poll/PollAJAX.jsp?act=EDITPOLLNODE&EDITPOIINODEID="+igd+"&Node="+formpollnode.Node.value,
			 function(data)
			 {  
			   if(data!=''&&data.trim().length>0&&data.trim()!='')//如果有这个用户  则写入Cookie
			   {

				 alert("投票成功!");
				 document.getElementById("showPOLLNODE").innerHTML=data;
			   }
			 } 
			 );
}
function faceOver(igd)
{
	document.getElementById("imgid"+igd).src='/tea/image/report/'+igd+'.gif';
}
function faceOut(igd)
{
	document.getElementById("imgid"+igd).src='/tea/image/report/i'+igd+'.gif';

	
}

</script>
  <form name="formpollnode" action="" method="POST">
     <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <span id="showPOLLNODE" >
  
  <%
  for(int index=1;index<NodePoll.POLL_TYPE.length;index++)
  {
%>
	 <img  id="imgid<%=index %>"  onmouseout="faceOut('<%=index %>');"   onmouseover="faceOver('<%=index %>');" onclick="faceChange('<%=index %>');" src=/tea/image/report/i<%=index %>.gif ><%=NodePoll.POLL_TYPE[index] %>

<%
  }
  %>

  </span>
  </form>

