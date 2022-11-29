<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.node.Node"%>
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


String statustype = teasession.getParameter("statustype");

String goodsname = teasession.getParameter("gname");
if(goodsname!=null && goodsname.length()>0)
{
	sql.append(" and shopping like ").append(DbAdapter.cite("%"+goodsname+"%"));
	param.append("&goodsname=").append(URLEncoder.encode(goodsname,"UTF-8"));
}

String urlid= teasession.getParameter("urlid");

if(statustype!=null && statustype.length()>0)
{
	sql.append(" and statustype like ").append(DbAdapter.cite("%/"+statustype+"/%"));	
	param.append("&statustype=").append(statustype);
}

int pos=0; 
int size = 10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=IntegralPrize.count(teasession._strCommunity,sql.toString());


sql.append(" ORDER BY times desc");
%>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script>

	function f_ymig(igd) 
	{
		ymPrompt.win('/jsp/integral/IntegralExchange.jsp?t='+new Date().getTime()+'&igid='+igd,600,300,'礼品兑换',null,null,null,true);
	} 
	
</script>
<form method="GET" action="?" name="form1">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>



     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
<td colspan="2">列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个兑换商品&nbsp;)</td>
    </tr>
     <%
   
     java.util.Enumeration enumer = IntegralPrize.findByIntegral(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     {
       out.print("<tr><td colspan=2 align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int ids =  Integer.parseInt(enumer.nextElement().toString());
       IntegralPrize integralobj = IntegralPrize.find(ids);
      
       %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
         <td align="center" class="left"><img src="<%=integralobj.getSpic()%>" width="200"></td>
         <td class="right"><div class="title"><a href="/html/folder/<%=urlid %>-<%=teasession._nLanguage%>.htm?id=<%=ids%>"><%=integralobj.getShopping()%></a></div>
<div class="bianma"><span class="left">商品编码：<span><%=integralobj.getShop_integral()%></span></span><span class="right">所需积分：<span><%=integralobj.getCoding()%></span></span>
<span class="duihuanBtn"><input type="button" value="立即兑换" onclick="f_ymig('<%=ids%>');"></span>
</div><div class="gaishu">礼品概述：
<span>
<%
          	String text = Node.Html2Text(integralobj.getText());

				
          if(text!=null && text.length()>50)
          {
        	  out.print(text.substring(0,50)+"...");
          }else
          {
        	  out.print(text);
          }
        
          %></span></div>  
          </td>
       </tr>
       <%
       }
       %>
       <%
       	if(count>size){
       %>
       <tr><td colspan="2" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
	<%} %>
</table>

</form>



