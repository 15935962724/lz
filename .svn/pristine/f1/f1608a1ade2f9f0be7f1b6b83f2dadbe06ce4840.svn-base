<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>
<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();
String memberid =request.getParameter("memberid");
StringBuffer param=new StringBuffer("community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)



int pos=0; 
int size = 10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String urlid = teasession.getParameter("urlid");

if(IntegralPrize.count(teasession._strCommunity,sql.toString()+" and cstype > 0")==0)
{
	sql.append(" ORDER BY times desc");
}else
{
	sql.append(" and cstype > 0 ");
	sql.append(" ORDER BY cstype desc");
}
%>
 
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>

<form method="GET" action="?" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    
     <%
   
     java.util.Enumeration enumer = IntegralPrize.findByIntegral(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     {
       out.print("<tr><td align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int ids =  Integer.parseInt(enumer.nextElement().toString());
       IntegralPrize integralobj = IntegralPrize.find(ids);
      
       %>
       <%if(index==1){ %>
       
        <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
        <td><table border="0" cellpadding="0" cellspacing="0"><tr><td class="td<%=index %>">&nbsp;</td><td><img src="<%=integralobj.getSpic()%>" width="100">&nbsp;</td><td><a href="/html/folder/<%=urlid %>-<%=teasession._nLanguage%>.htm?id=<%=ids%>"><%=integralobj.getShopping()%></a></td></tr></table></td>
        
  
       </tr>
       <%}else{ %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
        <td><table border="0" cellpadding="0" cellspacing="0"><tr><td class="td<%=index %>">&nbsp;</td><td><a href="/html/folder/<%=urlid %>-<%=teasession._nLanguage%>.htm?id=<%=ids%>"><%=integralobj.getShopping()%></a></td></tr></table></td>
    
  
       </tr>
       <%} %>
       <%
       }
       %>

</table>

</form>



