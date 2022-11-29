<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.Date" %>
<%@ page import="tea.entity.Entity" %>

<%@ page import="tea.entity.integral.*"%>

<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Resource r=new Resource();
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
int statics = 0;
if( teasession.getParameter("statics")!=null &&  teasession.getParameter("statics").length()>0)
{
	statics = Integer.parseInt( teasession.getParameter("statics"));
}
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();


sql.append(" and applymember=").append(DbAdapter.cite(teasession._rv.toString()));



String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
int size =10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}



int count=IntegralChange.count(teasession._strCommunity,sql.toString());

sql.append(" order by applydate desc ");



%>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/js.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
    
  <script>

  
  
	function f_ymig(igd,igd2) 
	{
		ymPrompt.win('/jsp/integral/IntegralMyMemberShow.jsp?t='+new Date().getTime()+'&icid='+igd+'&q='+igd2,600,400,'订单详细',null,null,null,true);
	} 
	
	function f_Score(igd)
	{
		
		 ymPrompt.win('/jsp/integral/IntegralMyScore.jsp?t='+new Date().getTime()+'&icid='+igd,400,260,'我要评价',null,null,null,true);

	}
	//重新兑换
	
	function f_ymig2(igd) 
	{
		ymPrompt.win('/jsp/integral/IntegralExchange2.jsp?t='+new Date().getTime()+'&igid='+igd,600,300,'礼品兑换',null,null,null,true);
	} 

	
	
  </script>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=request.getParameter("id") %>"/>
<input type=hidden name="statics" value="<%=statics %>">
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<div class="title">我的兑换</div>
<div class="AvailableInt">您的当前积分是：<%=Profile.find(teasession._rv.toString()).getMyintegral() %></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter3">
  <tr id="tableonetr">
   
    <td nowrap>订单号</td>
    
     <td nowrap>兑换日期</td>
     <td nowrap>兑换礼品</td>
     <td nowrap>兑换积分</td>
      <TD nowrap>兑换方式</TD> 
    <TD nowrap>状态</TD>  
   

    <td nowrap>说明</td>
    
  
  </tr>
  <%
  java.util.Enumeration enumer = IntegralChange.findByIntegral(teasession._strCommunity,sql.toString(),pos,size);
  if(!enumer.hasMoreElements())
  {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int ids =  Integer.parseInt(enumer.nextElement().toString());
    IntegralChange obj = IntegralChange.find(ids);
    Profile probj = Profile.find(obj.getApplymember());
    %>
    <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
       <td><a href="###" onClick="f_ymig('<%=ids%>','0');"><%=obj.getOrderid() %></a></td>
      <td nowrap><%=Entity.sdf2.format(obj.getApplydate())%></td>
     
      <td>
      <%
      if(obj.getPresent()!=null && obj.getPresent()!="/")
      {
        String pp = obj.getPresent();
        if(pp.indexOf("/")!=-1)
        {
         int  sumshop = 0;
          String pps[] = pp.split("/");
          for(int i =1;i<pps.length;i++)
          {
            int j = Integer.parseInt(pps[i]);
            IntegralPrize intprize = IntegralPrize.find(j);
            out.print("<a href =\"/html/folder/79-1.htm?id="+j+"\" target=_blank> ");
            out.print(intprize.getShopping()+"</a>&nbsp;");
            sumshop = sumshop+intprize.getShop_integral();
          }
        }
      }
      
      %>
      </td>
      
		<td><%=obj.getApplyintegral()%></td>
		   <td><%=IntegralChange.ICTYPE_TTYPE[obj.getIctype()] %></td>

		<td><%=IntegralChange.MY_STATIC[obj.getStatics()] %></td>
      
      <td nowrap="nowrap">
      <%
      if(obj.getStatics()==3) 
      {
            out.print("<a href=\"###\" onClick=\"f_ymig('"+ids+"','1');\">确认收货</a>&nbsp;");
     
	       		out.print("<a href=\"###\" onClick=\"f_Score('"+ids+"');\">我要评价</a>&nbsp;");
	       	
       }else if(obj.getStatics()==5)
       {
    	   out.print("<a href=\"###\" onClick=\"f_ymig2('"+ids+"');\">重新兑换</a>&nbsp;");
       }else
       {
    	   out.print(IntegralChange.MY_STATIC2[obj.getStatics()] );
    	  
    	   if(obj.getStatics()==4)
    	   {
    		   out.print("<a href=\"###\" onClick=\"f_Score('"+ids+"');\">我要评价</a>&nbsp;");
    	   }
       }
     
       %>
       
       
        </td>
    </tr>
    <%
    }
    %>
     <%if (count > size) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
      <%}  %>
    </table>
</form>



