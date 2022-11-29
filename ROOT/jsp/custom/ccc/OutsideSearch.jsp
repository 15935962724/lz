<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);


StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?");
sql.append(" AND father="+h.node);

//NodeLayer
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM NodeLayer WHERE 1=1");
  sql.append(" AND subject LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
  sql.append(")");
}

//Outside
sql.append(" AND node IN(SELECT node FROM outside WHERE 1=1");
int prov=h.getInt("prov");
if(prov>0)
{
  sql.append(" AND city LIKE "+DbAdapter.cite(prov+"%"));
  par.append("&prov="+prov);
}
int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND city LIKE "+DbAdapter.cite(city+"%"));
  par.append("&city="+city);
}
sql.append(")");

int sum=Node.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");


%>
<form name="form1" action="?">
<input type="hidden" name="prov" value="<%=prov%>"/>
<input type="hidden" name="city" value="<%=city%>"/>
<div class="province">
<table cellspacing="0">
<tr class='trtop'>
  <td class="left">省级单位:</td><td><%
  out.print("<a href=javascript:mt.query('prov',0)");
  if(prov==0)out.print(" class='cur'");
  out.print(">全部</a> ");
  Enumeration e=Card.find(" AND card<100 AND card IN(SELECT SUBSTRING(CAST(city AS CHAR(6)),1,2) FROM Outside)",0,100);
  while(e.hasMoreElements())
  {
    Card c=(Card)e.nextElement();
    out.print("<a href=javascript:mt.query('prov',"+c.getCard()+")");
    if(prov==c.getCard())out.print(" class='cur'");
    out.print(">"+c.getAddress()+"</a> ");
  }
  %></td>
</tr>
<%
if(prov>0)
{
  out.print("<tr><td class='left'>地级以上城市:</td><td>");
  out.print("<a href=javascript:mt.query('city',0)");
  if(city==0)out.print(" class='cur'");
  out.print(">全部</a> ");
  if(prov==11||prov==12||prov==31||prov==50)prov=Integer.parseInt(prov+"01");
  e=Card.find(" AND card LIKE "+DbAdapter.cite(prov+"__")+" AND card IN(SELECT SUBSTRING(CAST(city AS CHAR(6)),1,"+(String.valueOf(prov).length()+2)+") FROM Outside)",0,100);
  while(e.hasMoreElements())
  {
    Card c=(Card)e.nextElement();
    out.print("<a href=javascript:mt.query('city',"+c.getCard()+")");
    if(city==c.getCard())out.print(" class='cur'");
    out.print(">"+c.getAddress()+"</a> ");
  }
  out.print("</td></tr>");
}
%>

</table>
</div>
<div class="quickQuery">
<table>
<tr>
<td>机构快速查询：</td>
<td><input name="name" value="<%=name%>"/></td>
<td><input type="submit" class="submit" value="查询"/></td>
</tr>
</table>
</div>

</form>
<div class="queryResults">
<h2>校外机构列表 <%=sum%></h2>
<div class="con">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  e=Node.find(sql.toString(),pos,20);
  out.print("</table><table cellspacing='0'><tr id='tableonetr'><td align=center class='tdleft'>序号</td><td class='tdright'>名称</td></tr>");
  for(int i=pos;e.hasMoreElements();)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    /*if(i%10==0)*/
	
    out.print("<tr class='td"+i%2+"'><td align=center class='tdleft'>"+(++i<10?"0":"")+i+"</td><td class='tdright'>"+n.getAnchor(h.language)+"</td></tr>");
  }
  out.print("</table></div>");
  if(sum>20)out.print("<div class=page>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20)+"</div>");
}
%>

</div>

<script>
mt.query=function(f,id)
{
  form1[f].value=id;
  form1.submit();
};
</script>
