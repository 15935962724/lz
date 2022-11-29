<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");
    	TeaSession teasession = new TeaSession(request);
    	int lang = 1;
     int woid = 0;
     if(teasession.getParameter("woid")!=null && teasession.getParameter("woid").length()>0)
     {
        woid = Integer.parseInt(teasession.getParameter("woid"));
     }
     int wotype = 2;
      WomenOptions wobj = WomenOptions.find(woid,lang);
if("POST".equals(request.getMethod()))
{
   if("delete".equals(teasession.getParameter("act")))
   {
        wobj.delete();
   }else {
        String woname = teasession.getParameter("woname");
        String wonameen = teasession.getParameter("wonameen");
          int type = 0;
         if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
         {
            type = Integer.parseInt(teasession.getParameter("type"));
         }
        if(wobj.isExists())
        {
            wobj.set(woname,wonameen,type);
        }else
        {
            WomenOptions.create(woname,wonameen, type, teasession._strCommunity,wotype,lang);
        }
    }
    response.sendRedirect("/jsp/type/nightshop/NightShopModel.jsp");
    return;
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>夜店类型管理</title>
</head>
<script>
    function f_sub(igd,igd2)
    {
    	if(form1.woname.value=='')
    	{
    		alert("请填写名称");
    		return false;
    	}
        form1.woid.value=igd;
        form1.type.value=igd2;
        form1.submit();
    }
   function f_edit(igd)
   {
	   if(form1.woname.value=='')
   	{
   		alert("请填写名称");
   		return false;
   	}
       form1.woid.value=igd;
       form1.act.value='submit';
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
 <h1>夜店类型管理</h1>
 
  <form action="?" name="form1" method="POST">
    <input type="hidden" name="woid" value="<%=woid%>">
      <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
     <input type="hidden" name="type" value="<%=request.getParameter("type")%>">
     <input type="hidden" name="act">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
              <td>夜店类型（中文）：<input type="text" name="woname" value="<%=wobj.getNULL(wobj.getWoname())%>">&nbsp;
                
              </td>
              <td>夜店类型（英文）：<input type="text" name="wonameen" value="<%=wobj.getNULL(wobj.getWonameen())%>"></td>
          </tr>
          <tr>
              <td colspan = '2'>
                  <%if(woid==0){%>
                  <input type="button" value="添加类型" onClick="f_sub('0','0');">&nbsp;<%}%>
                  <%if(woid>0){%>
                  <%if(wobj.getType()==0){%>
                  <input type="button" value="添加类型二级" onClick="f_sub('0','<%=woid%>');">
                  <%}%>
                  &nbsp;
                  <input type="button" value="编辑" onClick="f_edit('<%=woid%>');">&nbsp;
                  <input type="button" value="删除" onClick="f_delete('<%=woid%>');"> &nbsp;
                  <input type="button" name="reset" value="返回" onClick="window.open('/jsp/type/nightshop/NightShopModel.jsp','_self');">
                  <%}%>

              </td>
          </tr>
          
      </table>

    
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
      <td>夜店类型（中文）</td>
      <td>夜店类型（英文）</td> 
    </tr>
    <%
         java.util.Enumeration e = WomenOptions.find(teasession._strCommunity, " and language ="+lang+" and wotype="+wotype+" and type= 0",0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
       {
            int wid = ((Integer)e.nextElement()).intValue();
            WomenOptions obj = WomenOptions.find(wid,lang);

    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><b><%=obj.getWoname()%></b></td>
         <td><b><%=obj.getWonameen()%></b></td>
         <td><a href="?woid=<%=wid%>&type=<%=obj.getType()%>&id=<%=request.getParameter("id")%>">编辑</a>&nbsp;
             <a href="###" onClick="f_delete('<%=wid%>');">删除</a></td>
     </tr>
      <%
        java.util.Enumeration e2 = WomenOptions.find(teasession._strCommunity, " and language ="+lang+"  and wotype="+wotype+" and type = "+wid,0,Integer.MAX_VALUE);
        while(e2.hasMoreElements())
       {
            int wid2 = ((Integer)e2.nextElement()).intValue();
            WomenOptions obj2 = WomenOptions.find(wid2,lang);

    %>

      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td>├<%=obj2.getWoname()%></td>
          <td><b><%=obj2.getWonameen()%></b></td>
         <td><a href="?woid=<%=wid2%>&type=<%=obj2.getType()%>&id=<%=request.getParameter("id")%>">编辑</a>&nbsp;
              <a href="###" onClick="f_delete('<%=wid2%>');">删除</a></td>
     </tr>
    <%}%>


     <%}%>
 
  </table>
  </form>

</body>
</html>