<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(teasession._nNode);
String community=request.getParameter("community");
if(community==null)
{
    Node node=  tea.entity.node.Node.find(teasession._nNode);
    community=node.getCommunity();
}
String type=teasession.getParameter("type");
String brand=teasession.getParameter("brand");
String price1=teasession.getParameter("price1");
String price2=teasession.getParameter("price2");
String keyword=teasession.getParameter("keyword");
int nodex=22167;
try
{
nodex=Integer.parseInt(request.getParameter("Nodex"));
}catch(Exception e)
{
  //e.printStackTrace();
}
%>
<table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999" id="chanpinlist" style="padding:5px">
<form action="/servlet/Category" method="get" target="_top">
<input type=hidden name="Node" value="<%=nodex%>"><tr bgcolor="#FFFFFF">
  <td>类别
    <select name="type">
          <option value="" >----------</option>
          <%
java.util.Enumeration enumer_form111=tea.entity.node.Node.findAllSons(teasession._nNode);
while(enumer_form111.hasMoreElements())
{
  int id=((Integer)enumer_form111.nextElement()).intValue();
  tea.entity.node.Category c=  tea.entity.node.Category.find(id);
  if(c.getCategory()!=34)
  {
    continue ;
  }
  tea.entity.node.Node obj=tea.entity.node.Node.find(id);
  out.print("<option value="+id+" >"+obj.getSubject(teasession._nLanguage)+"</option>");
}%>
      </select></td><td>品牌
        <select name="brand">
          <option value="" >----------</option>
          <%
java.util.Enumeration enumer54313=Brand.findByCommunity(community,"",0,200);
while(enumer54313.hasMoreElements())
{
  int id=((Integer)enumer54313.nextElement()).intValue();
  tea.entity.node.Brand obj=tea.entity.node.Brand.find(id);
  out.print("<option value="+obj.getBrand()+" >"+obj.getName(teasession._nLanguage)+"</option>");
}%>
        </select></td><td>价格
          <input name="price1" type="text" size="5">
          -
          <input name="price2" type="text" size="5"></td><td>关键字
            <input name="keyword" type="text"></td><td><input type="submit" value="搜索"></td></tr>
</form></table>




