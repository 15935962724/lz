<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.node.NightShop"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.city.CityList"%>
<%@page import="tea.entity.Http"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.member.WomenOptions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
String city= h.getCook("city", "1101|北京市");
city=city.split("[|]")[0];
int woid=h.getInt("type", 1);
int cityid=h.getInt("cityid",0);
int cityid2=h.getInt("cityid2",0);//商圈
int cityid3=h.getInt("cityid3",0);//地标
String location=h.get("area","");
String area2=h.get("area2","");
String area3=h.get("area3","");
String nexturl =  request.getRequestURI()+"?"+request.getQueryString();
int pos=h.getInt("pos",0);
int size=50;
StringBuffer sql=new StringBuffer(" AND n.type =45 and hidden = 0  and community = ").append(DbAdapter.cite(h.community));
StringBuffer param=new StringBuffer();

WomenOptions wo=WomenOptions.find(woid, h.language);
if(wo.getType()==0){
	sql.append(" AND ns.nstype1="+woid);
}else{
	sql.append(" AND ns.nstype2="+woid);
}
if(location.length()>0){
	sql.append(" AND ns.location="+DbAdapter.cite(location));
}
if(area2.length()>0){
	sql.append(" AND ns.commericial="+DbAdapter.cite(area2));
}
if(area3.length()>0){
	sql.append(" AND ns.landmark="+DbAdapter.cite(area3));
}

sql.append(" AND ns.cityid="+Integer.parseInt(city));
param.append("?community="+h.community);

%>
<style>
.cur{color:red}
</style>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>

<form action="?" method="post" name="form1">
<input type="hidden" name="area" value="<%=location%>">
<input type="hidden" name="area2" value="<%=area2%>">
<input type="hidden" name="area3" value="<%=area3%>">
<input type="hidden" name="cityid" value="<%=cityid%>">
<input type="hidden" name="cityid2" value="<%=cityid2%>">
<input type="hidden" name="cityid3" value="<%=cityid3%>">
<input type="hidden" name="type" value="<%=woid%>">
<p class="p1">
<span class="title1">分类:</span>
<span class="fenlei">
<a href='###' class="<%=wo.getType()==0?"cur":"" %>" onclick=sub2(<%=wo.getType()==0?woid:wo.getType() %>)>全部</a>
<%
Enumeration e3=null;
if(wo.getType()==0){
	e3=WomenOptions.find(" and type="+woid, 0, Integer.MAX_VALUE);
}else{
	e3=WomenOptions.find(" and type="+wo.getType(), 0, Integer.MAX_VALUE);
}

for(int i=0;e3.hasMoreElements();i++){
	int woid2=(Integer)e3.nextElement();
	WomenOptions wo2=WomenOptions.find(woid2, h.language);
	out.print("<a href='###' class='"+(woid==woid2?"cur":"" )+"' onclick=sub2("+woid2+")>"+wo2.getWoname()+"</a>");
}
%>
</span>
</p>
<p class="p2">
<span class="title1">地区:</span>
<span class="fenlei">
<a href='###' class="<%=cityid==0?"cur":"" %>" onclick=sub(0)>全部</a>
<%
ArrayList citylist= CityList.find(" and areaType=0 and fatherId="+Integer.parseInt(city), 0, Integer.MAX_VALUE);
for(int i=0;i<citylist.size();i++){
	CityList c=(CityList)citylist.get(i);
	out.print("<a href='###' class='"+(cityid==c.cityid?"cur":"" )+"' onclick=sub("+c.cityid+",'"+(h.language==1?c.cityName_CN:c.cityName_EN)+"')>"+(h.language==1?c.cityName_CN:c.cityName_EN)+"</a>");
}
%>
</span>
</p>
<p class="p3">
<span class="title1">商圈:</span>
<span class="fenlei">
<a href='###' class="<%=cityid2==0?"cur":"" %>" onclick=sub0(0)>全部</a>
<%
ArrayList citylist1= CityList.find(" and areaType=1 and fatherId="+Integer.parseInt(city), 0, Integer.MAX_VALUE);
for(int i=0;i<citylist1.size();i++){
	CityList c=(CityList)citylist1.get(i);
	out.print("<a href='###' class='"+(cityid2==c.cityid?"cur":"" )+"' onclick=sub0("+c.cityid+",'"+(h.language==1?c.cityName_CN:c.cityName_EN)+"')>"+(h.language==1?c.cityName_CN:c.cityName_EN)+"</a>");
}
%>
</span>
</p>
<p class="p4">
<span class="title1">地标:</span>
<span class="fenlei">
<a href='###' class="<%=cityid3==0?"cur":"" %>" onclick=sub1(0)>全部</a>
<%
ArrayList citylist2= CityList.find(" and areaType=2 and fatherId="+Integer.parseInt(city), 0, Integer.MAX_VALUE);
for(int i=0;i<citylist2.size();i++){
	CityList c=(CityList)citylist2.get(i);
	out.print("<a href='###' class='"+(cityid3==c.cityid?"cur":"" )+"' onclick=sub1("+c.cityid+",'"+(h.language==1?c.cityName_CN:c.cityName_EN)+"')>"+(h.language==1?c.cityName_CN:c.cityName_EN)+"</a>");
}
%>
</span>
</p>
</form>
<div class="left_list">
<style>
.tab1 .Norecord{text-align:center;}
</style>
<table class="tab1">
<%
   Enumeration e= Node.find(sql.toString(), pos, size);
	if(!e.hasMoreElements())
	{
		out.print("<tr><td colspan='3' class=\"Norecord\" align=\"center\">暂无记录！</td></tr>");
	}
   for(int i=0;e.hasMoreElements();i++)
	{ 
	  int node=((Integer)e.nextElement()).intValue();
	  Node n=Node.find(node);
	  NightShop ns=NightShop.find(node, h.language);
	  %>
	  <tr class="lin"><td>
	  <table class="tab2">
	  <tr><td class="td1"><a href="/html/nightshop/<%=node%>-<%=h.language%>.htm" target="_blank"><%=n.getSubject(h.language) %></a></td></tr>
	  <tr><td class="td2">地址：<script>mt.city('<%=ns.getCityid()%>')</script><%=ns.getLocation() +ns.getAddress() %></td></tr>
	  <tr><td></td></tr>
	  </table>
	  </td>
       <!--    <td class="td3"><a href="#" class="order">预定</a></td> -->
      </tr>
	  <%
	}
%>

</table>

</div>
<script>
function sub(cityid,area){
	form1.cityid.value=cityid;
	if(cityid>0){
	 form1.area.value=area;
	}else{
	 form1.area.value="";
	}
	form1.submit();
}
function sub0(cityid,area){
	
	form1.cityid2.value=cityid;
	if(cityid>0){
	  form1.area2.value=area;
    }else{
	 form1.area2.value="";
	}
	form1.submit();
}
function sub1(cityid,area){
		form1.cityid3.value=cityid;
		if(cityid>0){
		  form1.area3.value=area;
        }else{
		 form1.area3.value="";
		}
	    form1.submit();
}
function sub2(woid){
	if(woid>0)
	  form1.type.value=woid;
	form1.submit();
}
</script>