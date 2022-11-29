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
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)


String statustype = teasession.getParameter("statustype");

if(statustype!=null && statustype.length()>0)
{
	sql.append(" and statustype like ").append(DbAdapter.cite("%/"+statustype+"/%"));	
}

String urlid = teasession.getParameter("urlid");

int pos=0;
int size = 5;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=IntegralPrize.count(teasession._strCommunity,sql.toString());


sql.append(" ORDER BY times desc");
%>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<form method="GET" action="?" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     
         <tr>
     <%
   
     java.util.Enumeration enumer = IntegralPrize.findByIntegral(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     {
       out.print("<tr><td colspan=5 align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int ids =  Integer.parseInt(enumer.nextElement().toString());
       IntegralPrize integralobj = IntegralPrize.find(ids);
       
      
       %>
     
         <td><div class="CommodityList"><img src="<%=integralobj.getSpic()%>" width="200"><br> 
         <a href="/html/folder/<%=urlid %>-<%=teasession._nLanguage%>.htm?id=<%=ids%>"><%=integralobj.getShopping()%></a><br>
        所需<span class="integral"><%=integralobj.getShop_integral()%></span>积分</div>
        <span class="hot"></span>
        </td>
       
       
     
       <%
       }
       %>
       </tr>
</table>

</form>



