<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);
boolean isRole=request.getParameter("role")!=null;

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?id="+menuid);
par.append("&community="+teasession._strCommunity);

sql.append(" FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node INNER JOIN Golf g ON n.node=g.node WHERE n.type=62 AND n.community="+DbAdapter.cite(teasession._strCommunity));

if(isRole)
{
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  String role=aur.golf;
  if(role.length()<2)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("您无权管理球场!","utf-8"));
    return;
  }
  sql.append(" AND n.node IN("+ role.substring(1,role.length()-1).replace('/',',')+")");
}
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}
String c=h.get("c","");
if(c.length()>0)
{
  sql.append(" AND g.area="+DbAdapter.cite(c));
  par.append("&c="+c);
}

String tmp=request.getParameter("pos");
int pos=tmp!=null?Integer.parseInt(tmp):0;

int sum=DbAdapter.execute("SELECT COUNT(*)"+sql.toString());

String o=h.get("o","n.node"),b=h.get("b","asc");
sql.append(" ORDER BY "+o+" "+b);
par.append("&o="+o+"&b="+b);



par.append("&pos=");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(file,nid)
{
  form1.node.value=nid;
  form1.action="/jsp/type/golf/"+file+".jsp";
  form1.nexturl.value=location.pathname+location.search;
  form1.submit();
}
function f_del(nid)
{
  if(confirm('确认删除?'))
  {
    form1.node.value=nid;
    form1.method="post";
    form1.action="/servlet/EditGolf?act=del";
    form1.submit();
  }
}
</script>
</head>
<body>
<h1>球场管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="frm" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>球场名称:<input name="name" value="<%=name%>"></td>
  <td>区域:<select name="c"><option value="">-----------</option><%=Table.options(Table.CITY,h.community,c)%></select></td>
  <td>排序:<select name="o"><option value="n.node">创建时间</option><option value="nl.subject">球场名称</option><option value="g.hits">打球次数</option></select><select name="b"><option value="asc">升序</option><option value="desc">降序</option></select></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form1" action="?">
<input type="hidden" name="node" value=""/>
<input type="hidden" name="key" value="<%=MT.enc("admin")%>"/>
<%if(isRole)out.print("<input type='hidden' name='role'/>");%>
<input type="hidden" name="nexturl"/>
<script>form1.nexturl.value=location.pathname+location.search;frm.o.value="<%=o%>";frm.b.value="<%=b%>";</script>

<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td>序号<td>球场名称</td>
<td>区域</td>
<td>打球次数</td>
<td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='6' align='center'>暂无任何记录!</td></tr>");
}else
{
  Iterator it=DbAdapter.execute("SELECT n.node"+sql.toString(),pos,20).iterator();
  for(int i=pos+1;it.hasNext();i++)
  {
    int nid=((Integer)it.next()).intValue();
    Node n=Node.find(nid);
    Golf g=Golf.find(nid,teasession._nLanguage);
    int sc=Score.count(" AND node="+nid);
    if(g.hits!=sc)
    {
      Golf.setHits(nid,sc);
    }
    String area=g.getArea();
    try
    {
      area=Table.find(Table.CITY,Integer.parseInt(area)).name;
    }catch(Exception ex)
    {}
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>"+i);
    out.print("<td>"+n.getSubject(teasession._nLanguage)+"</td>");
    out.print("<td>"+MT.f(area)+"</td>");
    out.print("<td>"+(sc<1?"--":String.valueOf(sc))+"</td>");
    out.print("<td><input type='button' value='编辑' onclick=f_edit('EditGolf',"+nid+") />  ");
    out.print("<input type='button' value='球场场地' onclick=f_edit('GolfSite','"+nid+"');>");
    //out.print("<input type='button' value='发球台' onclick=f_edit('GolfTee',"+nid+") />");
    out.print("<input type='button' value='球场图片' onclick=f_edit('../TypePicture',"+nid+"); /> ");
    if(sc<1)out.print("<input type='button' value='删除' onclick=f_del("+nid+") /></td>");
  }
  if(sum>20)out.print("<tr><td colspan='6' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos, sum,20));
}
%>
</table>
<br/>
<%
if(!isRole)out.print("<input type='button' value='新建' onclick=f_edit('EditGolf',"+Category.find(teasession._strCommunity,62)+") />");
%>

</form>


</body>
</html>
