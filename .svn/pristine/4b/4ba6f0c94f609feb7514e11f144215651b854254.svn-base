<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);
Resource r = new Resource();
r.add("/tea/resource/Golf");

String nexturl = teasession.getParameter("nexturl");

int gsid = 0;
if(teasession.getParameter("gsid")!=null && teasession.getParameter("gsid").length()>0)
{
	gsid = Integer.parseInt(teasession.getParameter("gsid"));
}
GolfSite obj = GolfSite.find(gsid);


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<h1>球场场地管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<script>
function f_lat(igd) 
{

	document.getElementById('latlongid').innerHTML="<font color=red>果岭经纬度：</font>"+igd;
}
</script>
<h2> &nbsp;<%=Node.find(teasession._nNode).getSubject(teasession._nLanguage) %>添加场地&nbsp;</h2>
<form name="form1" method="post" action="/servlet/EidtGolfSite"  ENCtype="multipart/form-data">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="act" value="EidtGolfSite"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="gsid" value="<%=gsid %>"/>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
	 	<td colspan="10">
	 	场地名称：<input type="text" name="gsname" value="<%=Entity.getNULL(obj.getGsname()) %>"/>&nbsp;&nbsp;&nbsp;&nbsp;
	 	场地序号： 
	 	<%
	 	
	        out.print("<select name='seq'>"); 
	        for(char i='A';i<='Z';i++)
	        {
	        	
	          out.print("<option value="+i); 
	          if(obj.getSeq()!=null && obj.getSeq().equals(String.valueOf(i)))
        	  {
        	  	out.print(" selected='true'");
        	  }
	          out.print(">"+i);
	        }
	         out.print("</select></td></tr>");
	     
      %>
	 	
	 	</td>
 </tr>
    <%
    out.print("<tr><td  nowrap>洞号：</td>");
    for(int i=0;i<9;i++){
    	out.print("<td>"+(i+1)+"H ");
    }
    	int x = 1;
    %>
    </tr> 
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Standard")%>：</td>
<%
	   for(int index=x;index<9+x;index++)
	   {
	      out.print("<td><input type=text  class=edit_input name='standard"+index+"' value='"+obj.getStandard(index)+"' onclick='select()' size=1 mask='int'   ></td>");
	   }
      %>
      </tr>
       <tr>
      <td nowrap>码数：</td>
      <%
      for(int index=x;index<9+x;index++)
    	  
      out.print("<td><input type=text  class=edit_input name='yardage"+index+"' value='"+obj.getYardage(index)+"' onclick='select()' size=1 mask='int'   >");
      %>
      </tr>
      <tr>
        <td nowrap>球洞图：</td>
        <%
        for(int index=x;index<9+x;index++)
        {
          String hole=obj.getHole(index);
          out.print("<td><input type='button' style='position:absolute' value='上传' style=margin-bottom:4px /><input type='file' name='hole"+index+"' style='position:absolute;width:8px;cursor:hand;filter:Alpha(opacity=0)' onChange=\"this.previousSibling.value='已 浏 览';\" style=margin-bottom:4px/>　　　　　　　");
          if(hole!=null&&hole.length()>0)
          {
            out.println("<br><input  id=CHECKBOX type=CHECKBOX name=clearhole"+index+" onclick='form1.hole"+index+".disabled=checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
        }  %>
      </tr>
      
      <tr>
      <td nowrap>果岭经纬度：</td>
      <%
      for(int index=1;index<=9;index++)
      {  
    	  out.println("<td>");
    	  out.print("<input type=text  class=edit_input name='latlong"+index+"' value='"+Entity.getNULL(obj.getLatlong(index))+"'   style=cursor:pointer  size=1 onClick=f_lat('"+Entity.getNULL(obj.getLatlong(index))+"'); >");
    	  out.println("<br>");
    	  out.println("  <input type=\"button\" value=\"标点\" onClick=\"window.open('/jsp/admin/map/EditGMap.jsp?field=form1.latlong"+index+"','_blank','width=600,height=500');\"/>");
    	  out.println("</td>");
      } 
      %>
      
      </tr> 
      <span id="latlongid">&nbsp;</span>

<%     //}%>
<tr>
	<td colspan="10" align="center">
		<input type="submit" value="提交"/>&nbsp;
		<input type="button" value="重置" onclick="clearFrom(document.form1)">&nbsp;
		<input type="button" value="返回" onclick="window.close();">
	</td>
</tr>
    </table>

</form>


</body>
</html>
