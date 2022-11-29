<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);
String nexturl =  request.getRequestURI()+"?node="+teasession._nNode;

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
par.append("&community="+teasession._strCommunity);
Profile pobj = Profile.find(teasession._rv._strR);
int type = 0;
par.append("&type=").append(type);
sql.append(" and type=").append(type);
sql.append(" and phone =").append(DbAdapter.cite(pobj.getMobile()));
String str = "+r.getString(teasession._nLanguage, \"Court\")+";
int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null && tmp.length()>0)
{
  pos=Integer.parseInt(tmp);
} 
int count=GolfOrder.count(teasession._strCommunity,sql.toString());

int count_n=GolfOrder.count(teasession._strCommunity," and ( ispay = 0 or ispay is null)"+sql.toString());
int count_y=GolfOrder.count(teasession._strCommunity," and ispay = 1 "+sql.toString());
sql.append(" order by ordertime desc "); 


//教练个人订单


StringBuffer sql2=new StringBuffer(),par2=new StringBuffer();

par2.append("?id="+menuid);
par2.append("&community="+teasession._strCommunity);



int type2 = 1;
par2.append("&type=").append(type2);
sql2.append(" and type=").append(type2);

sql2.append(" and phone =").append(DbAdapter.cite(pobj.getMobile()));

String str2 = "+r.getString(teasession._nLanguage, \"Coach\")+";




int pos2=0,pageSize2=10;
String tmp2=request.getParameter("pos2");
if(tmp2!=null && tmp2.length()>0)
{
  pos2=Integer.parseInt(tmp2);
}


int count2=GolfOrder.count(teasession._strCommunity,sql2.toString());

int count_n2=GolfOrder.count(teasession._strCommunity," and ( ispay = 0 or ispay is null)"+sql2.toString());
int count_y2=GolfOrder.count(teasession._strCommunity," and ispay = 1 "+sql2.toString());
sql2.append(" order by ordertime desc "); 


//活动个人订单

StringBuffer sql3=new StringBuffer("   and community = ").append(DbAdapter.cite(teasession._strCommunity));
StringBuffer param3=new StringBuffer();



param3.append("?community="+teasession._strCommunity);
param3.append("&id=").append(request.getParameter("id"));

int type3=3;
sql3.append(" and member =").append(DbAdapter.cite(teasession._rv.toString()));


int pos3=0,size3=10;
String tmp3=request.getParameter("pos3");
if(tmp3!=null&&tmp3.length()>0) 
{
  pos3=Integer.parseInt(tmp3);
}

int count3 = Eventregistration.Count(teasession._strCommunity,sql3.toString());

int count_n3=Eventregistration.Count(teasession._strCommunity," and ( patypeis = 0 or patypeis is null)"+sql3.toString());
int count_y3=Eventregistration.Count(teasession._strCommunity," and patypeis = 1 "+sql3.toString());

sql3.append(" order by times desc ");


%>
<script>
function f_t(igd)
{
	ymPrompt.win({message:'/jsp/type/golf/GolfTalkback.jsp?node='+igd,width:610,height:380,title:'<%=r.getString(teasession._nLanguage, "UserReviews")%>',handler:function(){},maxBtn:false,minBtn:false,iframe:true});	
}
function f_show(igd,ing)
{
	
	ymPrompt.win({message:'/jsp/type/golf/GolfOrderShow.jsp?goid='+igd+'&type='+ing,width:600,height:450,title:'订单详细',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}

</script>

<div class="title"><%=r.getString(teasession._nLanguage, "Myreservationscourtorders")%></div>
<form name="formnm" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>


<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td><%=r.getString(teasession._nLanguage, "OrderNumber")%></td>
<td><%=r.getString(teasession._nLanguage, "Bookstadiumname")%></td>
<td><%=r.getString(teasession._nLanguage, "Teetime")%></td>
<!--<td>预订人数</td>-->
<td><%=r.getString(teasession._nLanguage, "amount")%></td>
<td><%=r.getString(teasession._nLanguage, "Status")%></td>
<td><%=r.getString(teasession._nLanguage, "Ordertime")%></td>
<td><%=r.getString(teasession._nLanguage, "Operating")%></td>
</tr>
<%

java.util.Enumeration e = GolfOrder.find(teasession._strCommunity,sql.toString(),pos,pageSize);
 if(!e.hasMoreElements())
 {
     out.print("<tr><td colspan=7 align=center>"+r.getString(teasession._nLanguage, "Norecords")+"</td></tr>");
 }
for(int i=1;e.hasMoreElements();i++)
{
	int goid =((Integer)e.nextElement()).intValue();
	GolfOrder  goobj = GolfOrder.find(goid);
	Node nobj = Node.find(goobj.getNode());
	

%>
 <tr onmouseover="bgColor='#BCD1E9'"; onmouseout="bgColor=''"; >
   
    <td><a href="###" onClick="f_show('<%=goid %>','<%=type %>');"  ><%=goobj.getOrderno() %></a></td>
    <td><%=nobj.getSubject(teasession._nLanguage) %></td>
    <td><%=Entity.capitalDateYMD(goobj.getUndertime()) %>&nbsp;<%=goobj.getUnderdata() %>&nbsp;点</td>
    <!--<td><%=goobj.getUndernumbers() %></td>-->
      <td><b>￥</b><%=goobj.getTotalprice() %> </td>
   <td><%
   out.println(goobj.PAY_TYPE[goobj.getPaytype()]);
   out.print("<br>");
   if(goobj.getPaytype()!=3){
		if(goobj.getIspay()!=1)
		{
			out.print("<font color =red >"+r.getString(teasession._nLanguage, "Unpaid")+"</font>");
		}else
		{
			out.print("<font color =Green >"+r.getString(teasession._nLanguage, "Hasbeenpaid")+"</font>");
		}
   }
   %> </td>
      <td><%=Entity.sdf2.format(goobj.getOrdertime())%></td>
      <td nowrap><a href="###" onClick="f_show('<%=goid %>','<%=type %>');"  ><%=r.getString(teasession._nLanguage, "View")%></a><br/><a   href="###" onClick="f_t('<%=goobj.getNode() %>');" ><%=r.getString(teasession._nLanguage, "Iwanttocomment")%></a></td></tr>
<%} %>
<tr>
	<td colspan="10" align="right"><%=r.getString(teasession._nLanguage, "Waitingforpaymentorders")%>：&nbsp;<font color="RED" size="3"><%=count_n%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Thenumberofordershavebeencompleted")%>：&nbsp;<font color="RED" size="3"><%=count_y%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Totalnumberoforders")%>：&nbsp;<font color="RED" size="3"><%=count%></font>&nbsp; </td>
</tr>

   <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+par.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
</table>


<script>

function f_t(igd)
{
	ymPrompt.win({message:'/jsp/type/golf/GolfCoachTalkback.jsp?gcid='+igd,width:610,height:380,title:'<%=r.getString(teasession._nLanguage, "UserReviews")%>',handler:function(){},maxBtn:false,minBtn:false,iframe:true});	
}
function f_show(igd,ing)
{
	
	ymPrompt.win({message:'/jsp/type/golf/GolfOrderShow.jsp?goid='+igd+'&type='+ing,width:600,height:450,title:'订单详细',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}
function f_name(igd)
{
	ymPrompt.win({message:'/jsp/type/golf/GolfCoachShow.jsp?gcid='+igd,width:600,height:450,title:'<%=r.getString(teasession._nLanguage, "Coachdetailedinformation")%>',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}

</script>
<div class="title"><%=r.getString(teasession._nLanguage, "Mybookingcoachorders")%></div>

<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td><%=r.getString(teasession._nLanguage, "OrderNumber")%></td>
<td><%=r.getString(teasession._nLanguage, "Bookcoachname")%></td>
<td><%=r.getString(teasession._nLanguage, "Appointment")%></td>
<!--<td>预约人数</td>-->
<td><%=r.getString(teasession._nLanguage, "amount")%></td>
<td><%=r.getString(teasession._nLanguage, "Status")%></td>
<td><%=r.getString(teasession._nLanguage, "Ordertime")%></td>
<td><%=r.getString(teasession._nLanguage, "Operating")%></td>
</tr>
<%

java.util.Enumeration e2 = GolfOrder.find(teasession._strCommunity,sql2.toString(),pos2,pageSize2);
 if(!e2.hasMoreElements())
 {
     out.print("<tr><td colspan=7 align=center>"+r.getString(teasession._nLanguage, "Norecords")+"</td></tr>");
 }
for(int i=1;e2.hasMoreElements();i++)
{
	int goid2 =((Integer)e2.nextElement()).intValue();
	GolfOrder  goobj2 = GolfOrder.find(goid2);
	GolfCoach gcobj2 = GolfCoach.find(goobj2.getNode());
	

%>
 <tr onmouseover="bgColor='#BCD1E9'"; onmouseout="bgColor=''"; >
   
    <td><a href="###" onClick="f_show('<%=goid2 %>','<%=type2 %>');"  ><%=goobj2.getOrderno() %></a></td>
    <td><a href="###" onClick="f_name('<%=goobj2.getNode()%>');"><%=gcobj2.getGcname() %></a></td>
    <td><%=Entity.capitalDateYMD(goobj2.getUndertime()) %>&nbsp;<%=goobj2.getUnderdata() %>&nbsp;<%=r.getString(teasession._nLanguage, "Point")%></td>
    <!--<td><%=goobj2.getUndernumbers() %></td>-->
      <td><b>￥</b><%=goobj2.getTotalprice() %> </td>
   <td><%
   out.println(goobj2.PAY_TYPE[goobj2.getPaytype()]);
   out.print("<br>");
   if(goobj2.getPaytype()!=3){
		if(goobj2.getIspay()!=1)
		{
			out.print("<font color =red >"+r.getString(teasession._nLanguage, "Unpaid")+"</font>");
		}else
		{
			out.print("<font color =Green >"+r.getString(teasession._nLanguage, "Hasbeenpaid")+"</font>");
		}
   }
   %> </td>
      <td><%=Entity.sdf2.format(goobj2.getOrdertime())%></td>
      <td nowrap><a href="###" onClick="f_show('<%=goid2 %>','<%=type2 %>');"  ><%=r.getString(teasession._nLanguage, "View")%></a><br/><a   href="###" onClick="f_t('<%=goobj2.getNode() %>');" ><%=r.getString(teasession._nLanguage, "Iwanttocomment")%></a></td></tr>
<%} %>
<tr>
	<td colspan="10" align="right"><%=r.getString(teasession._nLanguage, "Waitingforpaymentorders")%>：&nbsp;<font color="RED" size="3"><%=count_n2%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Thenumberofordershavebeencompleted")%>：&nbsp;<font color="RED" size="3"><%=count_y2%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Totalnumberoforders")%>：&nbsp;<font color="RED" size="3"><%=count2%></font>&nbsp; </td>
</tr>

   <%if (count2 > pageSize2) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+par2.toString()+"&pos2=",pos2,count2,pageSize2)%></td> </tr>
     
      <%}  %>
</table>



<input type="hidden" name="nexturl" value="<%=nexturl %>">





<div class="title"><%=r.getString(teasession._nLanguage, "Myactivitiesinorder")%></div>





<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
   <td nowrap><%=r.getString(teasession._nLanguage, "OrderNumber")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "Nameofactivity")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "EventDate")%></td>
      <!--<td nowrap>预订人数</td>-->
      <td nowrap><%=r.getString(teasession._nLanguage, "amount")%> </td>
      <td nowrap><%=r.getString(teasession._nLanguage, "Paymentstatus")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "ApprovalStatus")%></td> 
      <td nowrap><%=r.getString(teasession._nLanguage, "Ordertime")%></td>
      <td nowrap><%=r.getString(teasession._nLanguage, "Operating")%></td>     

</tr> 
<%


 
java.util.Enumeration eu3 = Eventregistration.find(teasession._strCommunity,sql3.toString(),pos3,size3);
if(!eu3.hasMoreElements())
{
	out.print("<tr><td colspan=8 align=center>"+r.getString(teasession._nLanguage, "Norecords")+"</td></tr>");
}
for(int i=0;eu3.hasMoreElements();i++)
{
	
 	int eid3 = ((Integer)eu3.nextElement()).intValue();
 	Eventregistration eobj3 = Eventregistration.find(eid3);
 	Node nobj3 = Node.find(eobj3.getNode());
 	Event evobj3 = Event.find(nobj3._nNode, teasession._nLanguage);
 	Profile p3 = Profile.find(eobj3.getMember());

 	
	tea.entity.util.Card cobj3 = tea.entity.util.Card.find(p3.getProvince(teasession._nLanguage));
	
	String cname3 = cobj3.toString2();

  %>  
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
	<td><a href="###" onClick="f_show('<%=eid3 %>','<%=type3%>');"><%=eobj3.getOrdering() %></a></td>
    <td><a href="/html/event/<%=eobj3.getNode()%>-<%=teasession._nLanguage%>.htm" target=_blank ><%=nobj3.getSubject(teasession._nLanguage)%></a></td>
    <td><%=r.getString(teasession._nLanguage, "From")%>&nbsp;<%=evobj3.getTimeHoldStart()!=null?Entity.capitalDateYMD(evobj3.getTimeHoldStart()):"" %>&nbsp;<%=r.getString(teasession._nLanguage, "To")%>&nbsp;<%=evobj3.getTimeHoldStop()!=null?Entity.capitalDateYMD(evobj3.getTimeHoldStop()):""%></td>
    <!--<td><%=eobj3.getNumbers()%></td>-->
   <td><b>￥</b><%=eobj3.getTotalprices() %> </td>

    <td><%
    
    out.println(eobj3.PAY_TYPE[eobj3.getPaytype()]);
    out.print("&nbsp;&nbsp;");
    if(eobj3.getPaytype()!=2){
		if(eobj3.getPatypeis()!=1)
		{
			out.print("<font color =red >"+r.getString(teasession._nLanguage, "Unpaid")+"</font>");
		}else
		{
			out.print("<font color =Green >"+r.getString(teasession._nLanguage, "Hasbeenpaid")+"</font>");
		}
    }
   %> </td>
   <td><%=eobj3.VE_TYPE[eobj3.getVerifg()] %></td>
   
     <td><%=Entity.sdf2.format(eobj3.getTimes())%></td>
       <td nowrap><a href="###" onClick="f_show('<%=eid3 %>','<%=type3%>');" ><%=r.getString(teasession._nLanguage, "View")%></a>
       <%
       	   if(eobj3.getVerifg()==3){//已经参加了，才能评论
       %>
       <br/><a href="###" onClick="f_t('<%=eobj3.getNode() %>');" ><%=r.getString(teasession._nLanguage, "Iwanttocomment")%></a>
       	<%} %>
       
       </td>

 	
  </tr>  
  

 
  <%
  }
if(count3>size3){
  %>
  
     <tr><td>
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param3.toString()+"&pos3=",pos3,count3,size3)%>   
      </td></tr> 
  <%} %>   
   	
 <tr>
	<td colspan="10" align="right"><%=r.getString(teasession._nLanguage, "Waitingforpaymentorders")%>：&nbsp;<font color="RED" size="3"><%=count_n3%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Thenumberofordershavebeencompleted")%>：&nbsp;<font color="RED" size="3"><%=count_y3%></font>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "Totalnumberoforders")%>：&nbsp;<font color="RED" size="3"><%=count3%></font>&nbsp; </td>
</tr>
  </table>


</form>