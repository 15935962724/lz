<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>
	function sub()
	{
		if(form1.arrclass.value==0)
		{
			alert("请选择排班类型");
			return false;
		}
	}
</script>
<body>
<%

 String member = teasession._rv.toString();//当前用户

            AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);

            if(au_obj.isExists())
            {
            	AdminUnit unobj = AdminUnit.find(au_obj.getUnit());
            	String ustr = unobj.getName();


 %>
<h1>今日上下班 （ <%=ustr %> ）</h1>

<div id="head6"><img height="6" src="about:blank"></div>


  <form name ="form1" method = "post" action="/jsp/admin/manage/inquire.jsp" onsubmit="return sub(this);">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门:
    	 <select name="unit">
          <option value="0">-------------</option>
          <%
          AdminUsrRole aurobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

        // java.util.Enumeration au_enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");

        String Classes[] = aurobj.getClasses().split("/");
        for(int i =1;i<Classes.length;i++)
        {

        System.out.print(Classes[i]+"----");
            AdminUnit _au=AdminUnit.find(Integer.parseInt(Classes[i]));
        	  out.print("<option value="+Classes[i]);
        	   //if(adminunit==id)
            //out.print(" selected ");
            out.println(" >"+_au.getName());
        }
          %>
        </select>



         排班类型:
          <select name="arrclass">
          <%
          		java.util.Enumeration inen= RankClass.findByCommunity(teasession._strCommunity,"");//得到排班类型
          		  out.print("<option value=\"0\">-------------</option>");
          		while(inen.hasMoreElements())
          		{
          			int inid = ((Integer)inen.nextElement()).intValue();
          			RankClass inobj = RankClass.find(inid);
          			out.print("<option value="+inid+">");
          			out.print(inobj.getRankClass()+"</option>");
           		}
           		out.print("</select>");
           %>


        <input type="submit" value="查询"></td>

     </tr>
 </table>
 </form>
<div id="head6"><img height="6" src="about:blank"></div>
　
<h1> 今日外出（ <%=ustr %> ）</h1>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>外出原因</td>
         <td nowrap> 外出时间</td>
         <td nowrap>预计归来时间</td>

       </tr>
       <%
       		String dd = DutyClass.GetNowDate();

       		 java.util.Enumeration outen=Outs.findByCommunity(teasession._strCommunity," and days ='"+dd+"' and type=1 and name='"+member+"' ");
        		if(!outen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无外出人员!</b></font></td></tr>");}
        		while(outen.hasMoreElements()){
	        		int outid = ((Integer)outen.nextElement()).intValue();
	        		Outs outobj = Outs.find(outid);

        			//AdminUnit adobj = AdminUnit.find(outobj.getUn());
        				AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,outobj.getMember());
        			AdminUnit adobj = AdminUnit.find(adobj1.getUnit());
        			 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(outobj.getMember());

        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");}%></td>
       		<td nowrap><%= pf_obj.getLastName(1)+pf_obj.getFirstName(1)%></td>
       		<td nowrap><%=outobj.getCause() %></td>
       		<td nowrap><%=outobj.getTime_w() %> </td>
       		<td nowrap><%=outobj.getTime_h() %></td>

       	</tr>
       	<%
       		}
       	 %>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<h1> 请假人员 （ <%=ustr%> ）</h1>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>请假原因</td>
         <td nowrap> 开始日期</td>
         <td nowrap>结束日期</td>

       </tr>
       <%
       		java.util.Enumeration leaen=Leavec.findByCommunity(teasession._strCommunity," and l.days ='"+dd+"' and l.type=2 or l.type=1 and l.name='"+member+"' ");
        	if(!leaen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无请假人员</b></font></td></tr>");}
        	while(leaen.hasMoreElements())
        	{
        		int leaid = ((Integer)leaen.nextElement()).intValue();
        		Leavec leaobj = Leavec.find(leaid);

        			//AdminUnit adobj = AdminUnit.find(leaobj.getUn());
        			AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,leaobj.getMember());
        			AdminUnit adobj = AdminUnit.find(adobj1.getUnit());
        			 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(leaobj.getMember());

        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1)%></td>
       		<td nowrap><%=leaobj.getCause() %></td>
       		<td nowrap><%=leaobj.sdf2.format(leaobj.getTime_k()) %> </td>
       		<td nowrap><%=leaobj.sdf2.format(leaobj.getTime_j()) %></td>


       	</tr>
      <%
      		}
       %>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<h1> 出差人员 （ <%=ustr%> ）</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>出差地点</td>
         <td nowrap> 开始日期</td>
         <td nowrap>结束日期</td>
       </tr>
       <%
       		java.util.Enumeration eveen=Evection.findByCommunity(teasession._strCommunity," and l.times ='"+dd+"' and l.type=1  ");//and l.type=-1  and l.member='"+member+"'

        	if(!eveen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无出差人员</b></font></td></tr>");}
        	while(eveen.hasMoreElements())
        	{ 
        		int eveid = ((Integer)eveen.nextElement()).intValue();
        		Evection eveobj = Evection.find(eveid);
				//AdminUnit eveadobj = AdminUnit.find(eveobj.getUnid());
					AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,eveobj.getMember());
        			AdminUnit adobj = AdminUnit.find(adobj1.getUnit());
				tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(eveobj.getMember());
        %>

         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
       		<td nowrap><%=eveobj.getArea() %></td>
       		<td nowrap><%=eveobj.sdf.format(eveobj.getTime_k()) %> </td>
       		<td nowrap><%=eveobj.sdf.format(eveobj.getTime_j()) %></td>
       	</tr>
        <%} %>

</table>
<%
	}
 %>
 <input type="button" value="返回上一页" onClick="history.back();">
</body>
</html>




