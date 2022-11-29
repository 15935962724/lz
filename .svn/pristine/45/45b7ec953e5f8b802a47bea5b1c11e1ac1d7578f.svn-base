<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.westrac.WestracIntegralLog"%>
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
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r=new Resource();


StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and member = ").append(DbAdapter.cite(teasession._rv.toString()));

  param.append("&id=").append(request.getParameter("id"));


int pos=0;
int size = 20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=WestracIntegralLog.Count(teasession._strCommunity,sql.toString());

 
sql.append(" ORDER BY times desc");
%>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>

<form method="POST" action="" name="form1">
<div class="title">我的积分</div>
<div class="AvailableInt">
时间：<%if(WestracIntegralLog.getTime_asc(teasession._rv.toString(),teasession._strCommunity)!=null)
	       {
	    	   out.print(Entity.sdf2.format(WestracIntegralLog.getTime_asc(teasession._rv.toString(),teasession._strCommunity)));
	    	   out.print("至今");
	       }else
	       {
	    	   out.print("暂无");
	       }
	    	   %>　　可用积分：<%=Profile.find(teasession._rv.toString()).getMyintegral() %></div>
	  
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter3">     
       
     <tr id="tableonetr">
      
       <td nowrap>用户名</td>
       <td nowrap>积分日期</td>
       <td nowrap>积分类型</td>
       <TD nowrap>内容</TD>

       <td nowrap>所获积分</td>
       <td nowrap>扣减积分</td>
       <td nowrap>说明</td>
       </tr>
     <%
    
     java.util.Enumeration enumer = WestracIntegralLog.find(teasession._strCommunity,sql.toString(),pos,size);
     if(!enumer.hasMoreElements())
     { 
       out.print("<tr><td colspan=7  align=center>暂无记录</td></tr>");
     }
     for(int index=1;enumer.hasMoreElements();index++)
     {

       int wlid =  Integer.parseInt(enumer.nextElement().toString());
       WestracIntegralLog wobj = WestracIntegralLog.find(wlid);
      
       %>
       <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
  
         <td><%=wobj.getMember()%></td>
         <td><%=Entity.sdf2.format(wobj.getTimes())%></td>
         <TD><%=WestracIntegralLog.WLOG_TYPE[wobj.getWlogtype()] %></TD>
      
         <td><%
         	if(wobj.getWname()!=null && wobj.getWname().length()>0)
         	{
         		out.print("<a href=\"/html/category/"+wobj.getNode()+"-1.htm\" target=_blank  >"+wobj.getWname()+"</a>");
         	}else
         	{
         		out.print(wobj.getNULL(wobj.getWname()));
         	}
         %></td>
          <td><%=wobj.getIntegral()%></td>
           <td><%=wobj.getCutintegral()%></td>
            <td><%=wobj.getNULL(wobj.getRemarks())%></td>
        
       </tr>
       <%
       }
       %>
       <%
       	if(count>size){
       %>
       <tr><td colspan="7" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
	<%} %>
</table>

</form>




