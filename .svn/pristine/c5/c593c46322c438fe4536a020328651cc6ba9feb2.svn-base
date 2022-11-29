<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
     int  id = 10;
    
    String sql=" AND TYPE=99 ";
     StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
     int pos=0,pageSize=10;
     String name="";
     if(teasession.getParameter("name")!=null && teasession.getParameter("name").length()>0)
     {
         name = teasession.getParameter("name");
         param.append("&name=").append(name);
         sql+=" and vmember='"+name+"'";
     }
  
     String day1="";
     if(teasession.getParameter("day1")!=null && teasession.getParameter("day1").length()>0)
     {
    	 day1 = teasession.getParameter("day1");
    	 param.append("&day1=").append(day1);
    	  sql+=" and time>='"+day1+" 00:00:00'";
     }
     String day2="";
     if(teasession.getParameter("day2")!=null && teasession.getParameter("day2").length()>0)
     {
    	 day2 = teasession.getParameter("day2");
    	 param.append("&day2=").append(day2);
    	  sql+=" and time<='"+day2+" 23:59:59'";
     }
     
     String tmp=request.getParameter("pos");
     if(tmp!=null)
     {
       pos=Integer.parseInt(tmp);
     }   

ArrayList<LvyouCity> provinces = LvyouCity.find1();
ArrayList<LvyouJobCatagory> cats = LvyouJobCatagory.find();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>客户端登录</title>
</head>
<script>

</script>
<body id="bodynone">
 <h1>客户端登录管理</h1>
 
  <form action="/jsp/type/lvyou/LogDetails.jsp" name="form1" method="Get">
    <input type="hidden" name="name" value="<%=name%>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
    <td colspan=4>客户端登录</td>
   </tr>
    <tr>
   
    <td>登录时间 </td><td>
    <input type="text" name="day1" value="<%=day1 %>" size=10 style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.day1');">
   - <input type="text" name="day2" value="<%=day2 %>" size=10 style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.day2');">
    
    </td>
     
   </tr>
   <tr>
    <td colspan=4><input type="submit" name="name" value="搜索"></td>
   </tr>
   </table>

    
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
    <td colspan=9>列表</td>
   </tr>
     <tr id="tableonetr">
    
      <td><b>姓名</b></td>
      <td><b>登录id</b></td> 
      <td><b>登录时间</b></td> 
      
      
    </tr>
    <%
             
    Enumeration logs =Logs.find(sql, pos, pageSize);
    
       int count=Logs.countlogs(name, sql);
       
     while(logs.hasMoreElements())
       {   Logs log=(Logs)logs.nextElement();
    	    
            Profile profile=Profile.find(log.getVMember());
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       
         <td><%=profile.getName(1)  %></td>
         <td><%=profile.getMember()%></td>
     
         <td><%=Entity.sdf3.format(log.getTime()) %></td>
          
      
        
     </tr>
     
     <%}%>
<tr><td><a href='/jsp/type/lvyou/Logs.jsp'>返回</a></td>
  
<td colspan="4">
 <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>
      
</td>
</tr>
 </table>
  </form>

</body>
</html>