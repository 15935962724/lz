<%@page contentType="text/html;charset=UTF-8" %><%@page language="java" import="java.util.*"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Date datenew = new Date();
Calendar calendar = Calendar.getInstance();
calendar.setTime(datenew);


calendar.get(calendar.MONTH);
calendar.get(calendar.DATE);

String year = null;
if(teasession.getParameter("year")!=null && teasession.getParameter("year").length()>0)
{
  year = teasession.getParameter("year");
}
else
{
  year = String.valueOf(calendar.get(calendar.YEAR));
}
String month = null;
if(teasession.getParameter("month")!=null && teasession.getParameter("month").length()>0)
{
  month = teasession.getParameter("month");
}
else
{
  month = String.valueOf(calendar.get(calendar.MONTH)+1);
}
String date = null;
if(teasession.getParameter("date")!=null && teasession.getParameter("date").length()>0)
{
  date = teasession.getParameter("date");
}
else
{
    date = String.valueOf(calendar.get(calendar.DATE));
}









int aaid = 0;
int begintime=0,begintime1=0,endtime=0,endtime1=0,affairtype=0;
String affaircontent=null;
if(teasession.getParameter("aid")!=null)
	aaid = Integer.parseInt(teasession.getParameter("aid"));
tea.entity.admin.DayOrder obj = tea.entity.admin.DayOrder.find(aaid);
String DELETE = teasession.getParameter("DELETE");
if(DELETE!=null){
	if(DELETE.equals("DELETE"))
	{
		obj.delete();
		response.sendRedirect("/jsp/admin/flow/Affair.jsp?year="+year+"&month="+month+"&date="+date);
		return ;
	}
}
if(aaid>0)
{
	begintime = obj.getBegintime();
	begintime1 = obj.getBegintime1();
	endtime = obj.getEndtime();
	endtime1 = obj.getEndtime1();
	affairtype = obj.getAffairtype();
	affaircontent = obj.getAffaircontent();
}


%>


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<script type="">
   function sub()
   {
     if(form1.affairtype.value==0)
     {
       alert("请选择类型");
       return false;
     }
   }

  function f_open(y,m,d)
  {

    window.open("/jsp/admin/flow/Affair.jsp?community=<%=teasession._strCommunity%>&year="+y+"&month="+m+"&date="+d,"iFrame3");
  }
  </script>
<body>
<h2>新建事务&nbsp;(<%=year %>年<%=month %>月<%=date %>日)</h2>
   <form name=form1 METHOD=post  action="/servlet/EditDayOrder" onSubmit="return sub(this);">
   <span id="newschedule">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <input type="hidden" name="year" value="<%=year %>">
      <input type="hidden" name="month" value="<%=month %>">
         <input type="hidden" name="date" value="<%=date %>">
         <input type="hidden" name="ids" value="<%=aaid %>">
     <tr >
     	<td nowrap>开始时间</td>
     	<td nowrap="nowrap">
     	 <select name="begintime"  >
  <%
        for(int I=0;I<=23;I++)
        {
        	if(I<10)
        	{

%>
          <option value="<%=I%>" <%if(I==begintime)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
        :
        <select name="begintime1" >
  <%
        for(int I=0;I<=59;I++)
        {

         if(I<10)
        	{
  %>
          <option value="<%=I%>" <%if(I==begintime1)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime1)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
     	</td>

       <td nowrap>结束时间</td>
       <td nowrap="nowrap">
     	 <select name="endtime"  >
  <%
        for(int I=0;I<=23;I++)
        {
        	if(I<10)
        	{

%>
          <option value="0<%=I%>" <%if(I==endtime)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==endtime)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
        :
        <select name="endtime1" >
  <%
        for(int I=0;I<=59;I++)
        {

         if(I<10)
        	{
  %>
          <option value="0<%=I%>" <%if(I==endtime1)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==endtime1)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
     	</td>

       <td nowrap>事务类型</td>
     	<td><select name="affairtype">
     		 <option value="0">-------------</option>
           <%
           java.util.Enumeration e3=Worktype.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(e3.hasMoreElements())
           {
             int id=((Integer)e3.nextElement()).intValue();
             Worktype wobj=Worktype.find(id);
             out.print("<option value="+id);
             if(id==affairtype)
             out.print(" SELECTED ");
             out.print(" >"+wobj.getName(teasession._nLanguage));
           }
           %>
     	</select></td>
    </tr>
     <tr >
       <td nowrap>事务内容</td>
     	<td colspan="5"><textarea name="affaircontent" scrolling="no" class="BigInput" rows="9" cols="40"><%if(affaircontent!=null)out.print(affaircontent); %></textarea></td>
    </tr>
    <tr >
    	<td nowrap  colspan="2">
    		<input name ="" type="submit" value="提交">
    		<input type="button" value="返回" onClick="history.back();">
    	</td>
    </tr>

</table>
</span>
</form>
</body>
</HTML>




