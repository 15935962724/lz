<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %>
<%
TeaSession teasession=new TeaSession(request);


Golf objcourt= Golf.find(teasession._nNode,teasession._nLanguage);


%>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function hole_img(a)
{
  var h_cur=document.getElementById("hole_cur");
  h_cur.id="";
  //
  var td=document.getElementById("tdimg");
  td.innerHTML="<img src='"+a.img+"' />";
  a.parentNode.id="hole_cur";
}

function f_sub()
{
	//if(confirm('您确定要更换场地吗？如果更换场地您所填写数据将重新填写!'))
	//{
		var f1;
		var a = document.getElementsByName("fieldid");
		for(i=0;i<a.length;i++)
		{
		if(a[i].checked)
			f1=a[i].value;
		} 
		
		  sendx("/jsp/type/score/EditScore2_ajax.jsp?act=GolfHole&node=<%=teasession._nNode%>&fieldid="+f1,
			 function(data)
			 {
	
			  //alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
			   {
	 
				 // alert(data);
				 document.getElementById("show").innerHTML=data;
				  
			   }
			 }
			 );
		//}
	
}
</script> 

<div id="golfSiteId">
	<%
	
			java.util.Enumeration e = GolfSite.find(teasession._strCommunity," and node = "+teasession._nNode,0,100);
  			while(e.hasMoreElements())
  			{
  				int gsid = ((Integer)e.nextElement()).intValue();
  				GolfSite gsobj = GolfSite.find(gsid);
  				out.print("<input type=\"radio\" name=\"fieldid\" value=\""+gsobj.getSeq()+"\"");
  			//	if(obj.getFieldid()!=null && obj.getFieldid().equals(gsobj.getSeq())){
  					//out.print("  checked ");
  				//}
  				out.print(" onclick=f_sub();");
  				out.print(">&nbsp;"+gsobj.getGsname()+"&nbsp;");
  			}
  		%>
  		 
	
</div>
<div id="show">&nbsp;</div>

