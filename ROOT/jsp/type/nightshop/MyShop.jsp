
<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.entity.Http"%><%@page import="java.util.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.Supply"%><%@page import="tea.entity.MT"%><%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

sql.append(" AND n.type=45 AND n.finished=1 AND vcreator="+DbAdapter.cite(h.username));
sql.append(" AND node IN(SELECT node FROM NightShop)");
int pos=h.getInt("pos");
par.append("&pos=");

String act=h.get("act");
if("del".equals(act))
{
    int node = 0;
    if(h.get("node") != null && h.get("node").length() > 0)
    {
        node = Integer.parseInt(h.get("node"));
    }
    Node ns = Node.find(node);
    ns.delete(h.language);
}
//System.out.print("---------------"+sql.toString());
int sum=Node.count(sql.toString());
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<h2>共 <%=sum%>条数据</h2>
<form name="form2" action="?" method="post">
<input type="hidden" name="NewNode" value="ON">
<input type="hidden" name="Type" value="45">
<input type="hidden" name="node">
<input type="hidden" name="act">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>标题</td>
  <td>类型</td>
  <td>区域</td>
  <td>商圈</td>
  <td>地标</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
	Enumeration e=Node.find(sql.toString(),0,20);
	  for(int i=1;e.hasMoreElements();i++)
	  {
	    int node=((Integer)e.nextElement()).intValue();
	    Node n=Node.find(node);
	   
	    NightShop s=NightShop.find(node,h.language);
	    
	    String url="/html/"+n.getCommunity()+"/service/"+node+"-"+h.language+".htm";
  %>
  <tr onMouseOver="bgColor='#FFFFCA';" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><a href='<%=url%>'><%=n.getSubject(h.language)%></a></td>
    <td></td>
    <td><%=MT.f(s.getLocation())%></td>
    <td><%=MT.f(s.getCommericial())%></td>
    <td><%=MT.f(s.getLandmark())%></td>
    <td>
      <a href="javascript:mt.act('edit',<%=node%>)">编辑</a>
      <a href="javascript:mt.act('del',<%=node%>)">删除</a>
    </td>
  </tr>
  <%
  }
  if(sum>10)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,10));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('add','14050004')"/>
</form>

<script>
mt.act=function(a,id,b)
{
  form2.node.value=id;
  if(a=='del')
  {
	form2.act.value=a;
    mt.show('你确定要删除吗？',2);
    mt.ok=function(){form2.submit();}; 
  }else
  {
    if(a=='edit'){
      location.href='/jsp/type/nightshop/EditNightShop.jsp?node='+id;
      return;
    }
    else if(a=='add'){
    	form2.action='/jsp/general/EditNode.jsp';
    }
    form2.submit();
  }
  
};
</script>