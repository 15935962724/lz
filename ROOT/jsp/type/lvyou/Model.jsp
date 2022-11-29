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
     int  id = 0;
     if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
     {
         id = Integer.parseInt(teasession.getParameter("id"));
     }
     LvyouModels model= LvyouModels.find(id);
     
if("POST".equals(request.getMethod()))
{
   if("delete".equals(teasession.getParameter("act")))
   {
	   LvyouModels.delete(id);
   }else if("edit".equals(teasession.getParameter("act"))){
        String name = teasession.getParameter("name");
        model.set(id, name);
    }
    response.sendRedirect("/jsp/type/lvyou/Model.jsp");
    return;
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>操作机种管理</title>
</head>
<script>
  
   function f_edit(igd)
   {
       form1.id.value=igd;
       form1.act.value='edit';
       form1.submit();
   }
   function f_delete(igd)
   {   
       form1.id.value=igd;
       form1.act.value='delete';
       form1.submit();
   }

</script>
<body id="bodynone">
 <h1>操作机型管理</h1>
 
  <form action="/jsp/type/lvyou/Model.jsp" name="form1" method="POST">
    <input type="hidden" name="id" value="<%=id%>">
     <input type="hidden" name="act">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td>机种：<input type="text" name="name" value="<%=model.getName()%>"></td>
   </tr>
   <tr>
   <td>
   <input type="button" value="编辑" onclick="f_edit('<%=id%>');">&nbsp;
   <input type="button" value="删除" onclick="f_delete('<%=id%>');"> &nbsp;
   </td>
   </tr>
   </table>

    
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
      <td>机型品牌</td>
      <td>操作</td> 
    </tr>
    <%
        ArrayList<LvyouModels> models = LvyouModels.find();
        for(int i=0;i<models.size();i++)
       {
        	  model=(LvyouModels)models.get(i);
        	  
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><b><%=model.getName()%></b></td>
         <td><a href="/jsp/type/lvyou/Model.jsp?id=<%=model.getId()%>">编辑</a>&nbsp;
             <a href="###" onclick="f_delete('<%=model.getId()%>');">删除</a></td>
     </tr>
     
     <%}%>

 </table>
  </form>

</body>
</html>