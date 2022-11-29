<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.*" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=request.getParameter("community");
if(community==null)
{
  Node node=Node.find(teasession._nNode);
  community=node.getCommunity();
}
tea.resource.Resource r=new tea.resource.Resource();
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "ListingONodeDetail")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br><br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td>预约项目编号名称</td>
  <td>作业数量</td>
  <td>&nbsp;</td>
  <td>收费金额</td>
</tr>
<%
  SOrder so_obj=  SOrder.find(teasession._nNode,teasession._nLanguage);
  int service[]= so_obj.getService();
  for(int index=0;index<service.length;index++)
  {
    if(service[index]!=0&&so_obj.getAmount()[index]!=0)
    {
      BigDecimal price[]= so_obj.getPrice();
      %>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
       <td><%=Node.find(service[index]).getSubject(teasession._nLanguage)%> </td>
       <td><%=so_obj.getAmount()[index]%></td>
       <td>￥</td>
       <td><%=SOrder.df.format(price[index])%> 元</td>
     </tr>
     <%  }
      }
      int aservice[]=so_obj.getAservice();
      for(int index=0;index<aservice.length;index++)
      {
        if(aservice[index]!=0&&so_obj.getAmount()[index]!=0)
        {
          BigDecimal price[]= so_obj.getAPrice();
      %>
     <tr>
       <td><%=Node.find(aservice[index]).getSubject(teasession._nLanguage)%> </td>
       <td><%=so_obj.getAmount()[index]%></td>
       <td>￥</td>
       <td><%=SOrder.df.format(price[index])%> 元</td>
     </tr>
     <%  }
    }%>
   </table><br><br>
   <div id="head6"><img height="6" alt=""></div>
</body>
</html>
