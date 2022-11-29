<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
     int  jid = 0;
     int id=0;
     String member="";
     if(teasession.getParameter("jid")!=null && teasession.getParameter("jid").length()>0)
     {
         jid = Integer.parseInt(teasession.getParameter("jid"));
    
     }
     if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
     {
         member = teasession.getParameter("member");
      }
     
     if("POST".equals(request.getMethod()))
     {
        if("delete".equals(teasession.getParameter("act")))
        {
     	   if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     	     {
     	    	 id = Integer.parseInt(teasession.getParameter("id"));
     	         LvyouJob.delete(id);
     	     }
        } 
     }
     
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>招聘信息管理</title>
</head>
<script>
  

   function f_delete(igd)
   { if(confirm('您确定要删除该信息吗？'))
	   {
       form1.id.value=igd;
       form1.act.value='delete';
       form1.submit();
	   }
   }
   
   function f_excel()
	{
		if(confirm("您确定要导出数据吗?"))
	    {
			form1.action='/servlet/LvyouExcel';
			form1.act.value='Jobs';
			form1.submit();
		}
  }
   
   function  multidelete()
   {
     if(submitCheckbox(form1.jid,"请选择招聘息信息"))
     {
		 if(confirm('删除操作系统会把会员信息清空\n您确定要删除吗？'))
   			{
   			 
   				form1.act.value='multidelete';
   			 
   	    		form1.submit();
   			}
   		  		
     }
   }
 
</script>
<body id="bodynone">
 <h1>招聘信息管理</h1>
  <form action="/jsp/type/lvyou/JobDetails.jsp" name="form1" method="POST">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="act">
    <input type="hidden" name="member" value="<%=member%>">
    <input type="hidden" name="jid" value="<%=jid%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
    <td colspan=7>
    <input type="button" name="name" value="公司基本信息"  onClick="window.open('/jsp/type/lvyou/Company.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
     <input type="button" name="name" value="职位列表"  onClick="window.open('/jsp/type/lvyou/JobDetails.jsp?jid=<%=jid%>&member=<%=member%>','_self');">
</td>
   </tr>
   <tr>
    <td colspan=6>列表</td>
    <td>   <input type="button" name="name" value="新建职位"  onClick="window.open('/jsp/type/lvyou/EditJob.jsp?jid=0&member=<%=member%>','_self');"></td>
   </tr>
     <tr id="tableonetr">
  
      <td><b>职位类别</b></td>
      <td><b>职位名称</b></td> 
      <td><b>工作地点</b></td> 
      <td><b>求职申请</b></td>
      <td><b>状态</b></td>  
      <td><b>发布时间</b></td> 
      <td><b>操作</b></td> 
    </tr>
    <%
             
        ArrayList<LvyouJob> jobs = LvyouJob.find(member);
      
       
       for(int i=0;i<jobs.size();i++)
       {
        	LvyouJob job=(LvyouJob)jobs.get(i);
        	ProfileLvyou plv=new ProfileLvyou();
        	plv=plv.find(job.getMember());
        	LvyouCity pro=LvyouCity.find(job.getProvince());
        	LvyouCity cit=LvyouCity.find(job.getCity());
        	LvyouJobCatagory cat=LvyouJobCatagory.find(job.getJobcatagory());
        	int count=LvyouApply.count(job.getId());
        
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        
         <td><%=cat.getName() %></td>
         <td><%=job.getName() %></td>
          <td><%=(pro.getName()+"-"+cit.getName()) %></td>
         <td><% if(count>0){ %>
          <a href="/jsp/type/lvyou/Findappusers.jsp?jobid=<%=job.getId()%>" ><%=count%></a>&nbsp;
         <%}
         else out.print("0");%>
         </td>
         <td><%=job.getState()==1?"发布":"未发布" %></td>
          <td><%=job.getIssueToString() %></td>
        <td> 
       
        <a href="/jsp/type/lvyou/EditJob.jsp?jid=<%=job.getId()%>&member=<%=member%>" >编辑</a>&nbsp;
        <a href="#"  onClick="f_delete(<%=job.getId()%>);">删除</a>
        </td>
     </tr>
     
     <%}%>
 
 </table>
  </form>

</body>
</html>