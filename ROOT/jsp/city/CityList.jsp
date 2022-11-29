<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.site.Community"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.city.CityList"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
Community c=Community.find(h.community);
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<div class="recity">
<span id="hotCity">热门城市：</span>
<%
ArrayList list= CityList.find(" and hotcity=1 and Len(cityid)=4 and isopen=1", 0, 100);
for(int i=0;i<list.size();i++){
	CityList cl=(CityList)list.get(i);
	out.print(h.language==1?"<a href='###' onclick=goCity("+cl.cityid+",'"+cl.cityName_CN+"') >"+cl.cityName_CN+"</a>":"<a href='###' onclick=goCity("+cl.cityid+") >"+cl.cityName_EN+"</a>");
}
%>
</div>

<span id="CityList">按首字母查找：</span>
<%!String word[]=new String[]{"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"}; %>
<ul>
<%
for(int i=0;i<word.length;i++){
	ArrayList list2= CityList.find(" and isopen=1 and Len(cityid)=4 and (cityName_EN like "+DbAdapter.cite(word[i]+"%")+" or cityName_EN like "+DbAdapter.cite(word[i].toLowerCase()+"%")+")", 0, Integer.MAX_VALUE);
	%>
    <div class="line">
	<strong class="tit"><%=word[i] %></strong>
	<div class="cityes">
           <ul>
           <%
           for(int j=0;j<list2.size();j++){
        	   CityList cl=(CityList)list2.get(j);
        	   out.print(h.language==1?"<li><a href='###' onclick=goCity("+cl.cityid+",'"+cl.cityName_CN+"') >"+cl.cityName_CN+"</a></li>":"<li><b><a href='###' onclick=goCity("+cl.cityid+") >"+cl.cityName_EN+"</a></li>");
           }
           %>    
           </ul>
    </div>
    </div>
	<%
}
%>
</ul>
<script>

function goCity(city,cityname){
	cookie.set('city',city+"|"+cityname);
	//alert(cookie.get('city'));
	location.href='/html/<%=h.community%>/floder/<%=c.getNode()%>-1.htm';
}
</script>