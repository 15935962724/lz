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
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)

if(statics>0)
{
	if(statics==3)
	{
		sql.append(" and (statics=3 or statics=4) ");
	}else
	{
		sql.append(" and statics  = ").append(statics);
		
	}
	param.append("&statics=").append(statics);
}



String orderid = teasession.getParameter("orderid");
if(orderid!=null && orderid.length()>0)
{
	sql.append(" and orderid like ").append(DbAdapter.cite("%"+orderid+"%"));
	param.append("&orderid=").append(orderid);
}
String members = teasession.getParameter("members");
if(members!=null && members.length()>0)
{
	sql.append(" and applymember like ").append(DbAdapter.cite("%"+members+"%"));
	param.append("&members=").append(URLEncoder.encode(members,"UTF-8"));
}

String  firstname = teasession.getParameter("firstname");
if(firstname!=null && firstname.length()>0)
{
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=IntegralChange.applymember and firstname like "+DbAdapter.cite("%"+firstname+"%")+" ) ");	
	param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8"));
}





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

sql.append(" order by applydate asc ");


%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/js.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <script>
  
  </script>
  <body>

  <h1>用户兑换商品订单-<%=IntegralChange.STATIC_STRTYPE[statics] %></h1>

    <h2>查询</h2>
    <FORM name=form1 METHOD=get action="?" onSubmit="">
      <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
      <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>订单号：<input type="text" name="orderid" value="<%=Entity.getNULL(orderid) %>"></td>
          <td>兑换用户名：<input name="members" value="<%=Entity.getNULL(members) %>">
          </td>
          <td>兑换姓名：<input name="firstname" value="<%=Entity.getNULL(firstname) %>">
          </td>
          <td><input type="submit" value="查询"/>
</td>
        </tr>
      </table>

<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="id" value="<%=request.getParameter("id") %>"/>
<input type=hidden name="statics" value="<%=statics %>">
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
   
    <td nowrap>订单号</td>
    <td nowrap>兑换用户名</td>
    <td nowrap>兑换姓名</td>
    <TD nowrap>性别</TD>  
    <TD nowrap>联系方式</TD> 
    <TD nowrap>申请时间</TD> 
    <td nowrap>兑换积分</td>
     <td nowrap>会员总积分</td>
    <td nowrap>兑换商品</td>
   <td nowrap>订单类型</td>
    <td></td>
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
    
      <td><%=obj.getOrderid() %></td>
      <td nowrap><%=obj.getApplymember()%></td>
      <td nowrap><%=probj.getFirstName(teasession._nLanguage) %></td>
      <td nowrap><%if(probj.isSex()==true){out.print("女");} else if(probj.isSex()==false){out.print("男");} %></td>
      <td nowrap ><%=obj.getPhone() %></td> 
  <td nowrap ><%=Entity.sdf2.format(obj.getApplydate()) %></td> 
      <td><%=obj.getApplyintegral()%></td>
       <td><%=probj.getMyintegral() %></td>
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
            out.print(intprize.getShopping()+"&nbsp;");
            sumshop = sumshop+intprize.getShop_integral();
          }
        }
      }
      
      %>
      </td>
     
    
      <td><%=IntegralChange.ICTYPE_TTYPE[obj.getIctype()] %></td>
      <td nowrap="nowrap">
      <%if(obj.getStatics()==1 || obj.getStatics()==2 || obj.getStatics()==3) {%>
        <input type="button" onClick="location='/jsp/integral/IntegralChangeAdd.jsp?member=<%=URLEncoder.encode(obj.getApplymember(),"UTF-8")%>&icid=<%=ids%>&nexturl=<%=nexturl%>'" value="<%if(obj.getStatics()==1){out.print("审核");}else if(obj.getStatics()==2){out.print("发货处理");}else if(obj.getStatics()==3){out.print("收货确认");} %>"/>
       
       <%} 
      else 
      {
    	  out.print(IntegralChange.STATIC_STRTYPE[obj.getStatics()]);
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
  </body>
</html>



