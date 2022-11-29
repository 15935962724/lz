<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.map.*"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");


Http h=new Http(request);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" AND type=62 AND community="+DbAdapter.cite(h.community));
String t=MT.f(h.get("t"));
String c=MT.f(h.get("c"));
String n=MT.f(h.get("n"));
if(t.length()>0||c.length()>0)
{
  sql.append(" AND EXISTS(SELECT node FROM Golf g WHERE g.node=n.node ");
  if(c.length()>0)
  {
    sql.append(" AND g.area="+DbAdapter.cite(c));
    par.append("&c="+c);
  }
  if(t.length()>0)
  {
    sql.append(" AND g.type="+DbAdapter.cite(t));
    par.append("&t="+t);
  }
  sql.append(")");
}
if(n.length()>0)
{
  sql.append(" AND EXISTS(SELECT node FROM NodeLayer nl WHERE n.node=nl.node ");
  sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+n+"%"));
  sql.append(")");
  par.append("&n="+Http.enc(n));
}
par.append("&p=");
int p=h.getInt("p");
int sum=Node.count(sql.toString());
%>
<div id="seche">
<form name="fgolf" action="?">
<input type="hidden" name="node" value="<%=h.node%>"/>
<table border="0" cellpadding="0" cellspacing="0" class="CourseSearch">
  <tr><td  align="left" valign="middle" id="searchmenu">
    按球场类型搜索：<select name="t"><option value="">-----------</option><%=Table.options(Table.GTYPE,h.community,t)%></select>
  城市：<select name="c"><option value="">-----------</option><%=Table.options(Table.CITY,h.community,c)%></select>
球场名称：<input class="CourseName" type="text" name="n" value="<%=n%>" /></td><td><input class="CourseSub" type="submit" value="" /></td>
  </tr>
</table>
</form>
</div>
<div class="qiuchang">
<div id="qiuchang_left">
<div class="title"><div class="left"><img src="/res/Home/1005/10059980.gif"></div></div>
<ul>
<%
if(sum<1)
{
  out.print("<li class=Special>没有找到相关球场!</li>");
}else
{
  java.util.Enumeration e=Node.find(sql.toString(),p,20);
  while(e.hasMoreElements())
  {
    int nid=((Integer)e.nextElement()).intValue();
    Node obj=Node.find(nid);
    Golf g=Golf.find(nid,h.language);
    GMap gm = GMap.find(nid);
    String syn=g.getSynopsis();
    if(syn.length()>24)syn=syn.substring(0,24)+"...";
    %>
    <li><span id="CourtIDLogo"><a href="/html/golf/<%=nid%>-<%=h.language%>.htm"><img src="<%=g.getLogo()%>"/></a></span>
     <span id="CourtIDName"><a href="/html/golf/<%=nid%>-<%=h.language%>.htm"><%=obj.getSubject(h.language)%></a></span>
     <div style="height:30px;float:right;">

       <%if(gm != null && !gm.isHidden())out.print("<input type='button' value='地图' onclick=\"window.open('/jsp/admin/map/ViewGMap.jsp?node=" + nid + "&amp;point=" + gm.getLat() + "," + gm.getLng() + "," + gm.getZoom() + "','_blank','width=600,height=500');\" />");%>
      <input type="button" value="预定" onclick="window.open('/html/folder/12-1.htm','_self');"/>
      </div>

	  <div style="height:30px;line-height:30px;width:300px;"><span id="CourtIDPrice"><%=g.getPrice()%></span></div>
     <div style="height:25px;line-height:25px;"><span id="CourtIDSynopsis"><%=syn%></span></div>
<div style="height:25px;line-height:25px;">地址：<span id="CourtIDAddress"><%=g.getAddress()%></span></div>
    </li>
    <%
    }
  }
%>
<li id="PageNum"><%=new tea.htmlx.FPNL(h.language,par.toString(), p,sum ,20)%></li>
</ul>
</div>
<div id="qiuchang_right" style="float:right;width:223px;padding-top:20px;">
<div class="tongji">
<div id="tou">球场统计</div>
<ul id="paih">
<script>function f_submit(tid){window.open("?node=<%=h.node%>&c="+tid,'_self');}</script>
<%
Iterator it=Table.find(Table.CITY,h.community,"",0,200).iterator();
while(it.hasNext())
{
  Table obj=(Table)it.next();
  sum=Node.count(" AND type=62 AND community="+DbAdapter.cite(h.community)+" AND EXISTS (SELECT node FROM Golf g WHERE g.node=n.node AND g.area="+DbAdapter.cite(String.valueOf(obj.tid))+" )");
  out.print("<li><a href=\"javascript:f_submit('"+obj.tid+"');\" >"+obj.name+" "+sum+"</a></li>");
}
%>
</ul></div>
