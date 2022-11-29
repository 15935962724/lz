<%@page import="tea.entity.Http"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");
    Http h=new Http(request);
    	
     int woid =h.getInt("woid",0);
     int wotype =h.getInt("wotype",0);
      WomenOptions wobj = WomenOptions.find(woid,h.language);
if("POST".equals(request.getMethod()))
{
   if("delete".equals(h.get("act")))
   {
        wobj.delete();
   }else{
        String woname = h.get("woname");
          int type= h.getInt("type",0);
        if(wobj.isExists())
        {
            wobj.set(woname,type);
            wobj=WomenOptions.find(woid,h.language);
        }else
        {
            WomenOptions.create(woname, type, h.community,h.getInt("wotype"),1);
        }
    }
    //response.sendRedirect("/jsp/user/WomenOptions.jsp?wotype="+h.getInt("wotype"));
    //return;
}

%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>注册选项管理</title>
</head>
<script>
    function f_sub(igd,igd2)
    {
        form1.woid.value=igd;
        form1.type.value=igd2;
        form1.submit();
    }
   function f_edit(igd)
   {
       form1.woid.value=igd;
       form1.submit();
   }
   function f_delete(igd)
   {
       form1.woid.value=igd;
       form1.act.value='delete';
       form1.submit();
   }

</script>
<body id="bodynone">
 <h1>注册选项管理</h1>

  <form action="?" name="form1" method="POST">
      <input type="hidden" name="woid" value="<%=woid%>">
      <input type="hidden" name="wotype" value="<%=wotype%>">
      <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
     <input type="hidden" name="type" value="<%=request.getParameter("type")%>">
     <input type="hidden" name="act">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
      <td>选项名称</td>
      <td>操作</td>
    </tr>
    <%
        java.util.Enumeration e = WomenOptions.find(" and type= 0 and wotype="+wotype,0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
       {
            int wid = ((Integer)e.nextElement()).intValue();
            WomenOptions obj = WomenOptions.find(wid,h.language);

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><b><%=obj.getWoname()%></b></td>
         <td><a href="?woid=<%=wid%>&type=<%=obj.getType()%>&id=<%=request.getParameter("id")%>&wotype=<%=wotype%>">编辑</a>&nbsp;
             <a href="###" onclick="f_delete('<%=wid%>');">删除</a></td>
     </tr>
      <%
        java.util.Enumeration e2 = WomenOptions.find(" and type = "+wid,0,Integer.MAX_VALUE);
        while(e2.hasMoreElements())
       {
            int wid2 = ((Integer)e2.nextElement()).intValue();
            WomenOptions obj2 = WomenOptions.find(wid2,h.language);

    %>

      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td>├<%=obj2.getWoname()%></td>
         <td><a href="?woid=<%=wid2%>&type=<%=obj2.getType()%>&id=<%=request.getParameter("id")%>&wotype=<%=wotype%>">编辑</a>&nbsp;
              <a href="###" onclick="f_delete('<%=wid2%>');">删除</a></td>
     </tr>
    <%}%>


     <%}%>
  </table>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
              <td>选项名称：<input type="text" name="woname" value="<%=wobj.getNULL(wobj.getWoname())%>"></td>
          </tr>
          <tr>
              <td>
                  <%if(woid==0){%>
                  <input type="button" value="添加" onclick="f_sub('0','0');">&nbsp;<%}%>
                  <%if(woid>0){%>
                  <%if(wobj.getType()==0){%>
                  <input type="button" value="添加子级" onclick="f_sub('0','<%=woid%>');">
                  <%}%>
                  &nbsp;
                  <input type="button" value="编辑" onclick="f_edit('<%=woid%>');">&nbsp;
                  <input type="button" value="删除" onclick="f_delete('<%=woid%>');"> &nbsp;
                  <input type="button" name="reset" value="返回" onClick="window.open('/jsp/user/WomenOptions.jsp?wotype=<%=wotype %>','_self');">
                  <%}%>

              </td>
          </tr>
          
      </table>

  </form>

</body>
</html>