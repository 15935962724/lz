<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}







String act = teasession.getParameter("act");

if("EditScore2_ajax".equals(act))
{
	String tmp=request.getParameter("score");
	int score=tmp!=null?Integer.parseInt(tmp):0;

	tmp=request.getParameter("golf");
	int golf=tmp!=null?Integer.parseInt(tmp):0;

	String member;
	Score obj=Score.find(score);
	if(golf<1)
	{
	  golf=obj.getNode();
	  member=obj.member;
	}else
	{
	  member=request.getParameter("member");
	}

	Node node=Node.find(golf);
	Golf g=Golf.find(golf,teasession._nLanguage);
	String fieldid= teasession.getParameter("fieldid");
	String fieldid2= teasession.getParameter("fieldid2");

	GolfSite obj1 = GolfSite.find(GolfSite.getGSid(golf,fieldid));
	GolfSite obj2 = GolfSite.find(GolfSite.getGSid(golf,fieldid2));

%>

    
    <table cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width="39">Hole</td>
    <%
    for(int i=1;i<19;i++)
    {
      out.print("<td>"+i+"H");
    }
    %>
  <tr>
 
       <td height=20px>标准杆</td>
	<%

	   for(int index=0;index<9;index++)
	   {
	      out.print("<td>"+obj1.getStandard(index+1)+"</td>");
	      
	   }
	   for(int index=9;index<18;index++)
	   { 
	      out.print("<td>"+obj2.getStandard(index-8)+"</td>");
	   }
    %>
    
    </tr>
    
  <tr>
    <td>实际杆</td>
    <%
    for(int i=0;i<18;i++)
    {
      out.print("<td><input name='fact' onChange='setSums()' type='text' value='"+obj.getFact()[i]+"' size='1'  readonly='readonly' mask='int'></td>");
    }
    %>
    
    </tr>
    <%--
    <tr><td colspan="10" ><input onfocus="" name="particular_checkbox" onclick="setParticularShow();"  id="CHECKBOX" type="CHECKBOX" value="">输入详细实际杆</td>
    --%>
  </tr>
  
  
  
<!-- 详细实际杆/////////////////////// -->
<tbody id="particular" style="display:">
      <tr><td>上球道</td> <%
      for(int i=0;i<18;i++)
      {
        out.print("<td><input name='fairway"+i+"' type='checkbox' "+(obj.fairway[i]?" checked='' ":"")+"></td>");
      }
      %>
      </tr>
      <tr><td>上</td> <%
      for(int i=0;i<18;i++)
      {
        out.print("<td><input name='up' onChange='setFact("+i+")' onclick='select()' type='text' value='"+obj.getUp()[i]+"' size='1' maxlength='1' mask='int'></td>");
      }
    %>
      </tr>
	  <tr><td  >推</td> <%
      for(int i=0;i<18;i++)
      {
        out.print("<td><input name='bunt' onChange='setFact("+i+")' onclick='select()' type='text' value='"+obj.getBunt()[i]+"' size='1' maxlength='1' mask='int'></td>");
      }
    %>
      </tr>
      </tbody>
</table>
    

     

<%}else if("GolfHole".equals(act)){
	String fieldid = teasession.getParameter("fieldid");
	GolfSite obj1 = GolfSite.find(GolfSite.getGSid(teasession._nNode,fieldid));
	
%>

<div class="Holechart"><ul>
  <li class="ball">&nbsp;</li>
  <%
  StringBuffer sb=new StringBuffer();
  for(int i=0;i<9;i++)
  {
    String img=obj1.getHole(i+1);
    out.print("<li class='hole' "+(i==0?"id='hole_cur'":"")+">");
    if(img!=null&&img.length()>0)out.print("<a href=### onclick='hole_img(this,"+i+")' img=\""+img+"\">");
    out.print((i+1)+"H</a></li>");
  } 
  %>
  </ul>
  <div id="tdimg"><img src='<%=obj1.getHole(1)%>' /></div>
</div>
<%} %>
