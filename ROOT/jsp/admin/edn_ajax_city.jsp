<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Http h=new Http(request);

String act=h.get("act","");
if(act.equals("impcity")){
	String name = h.get("name");
	String id = h.get("id");
	String sql="insert into country(id,name)values("+DbAdapter.cite(id)+","+DbAdapter.cite(name)+")";
	DbAdapter db =new DbAdapter();
	db.executeUpdate(sql);
	db.close();
}
/* else if(act.equals("impcity")){
	String cityName_CN = h.get("namecn");//中文省份
	String cityName_EN = h.get("nameen");//英文省份
	int cityid = h.getInt("cityid");
	int areaType = 0;
	int hotcity = 0;//是否热门城市
	int isOpen = 0;//城市是否开放
	int fatherId=0;
	if(String.valueOf(cityid).length()==2){
		fatherId=0;
		System.out.println(cityid+"-------"+fatherId+"---------"+cityName_CN+"--------"+cityName_EN);
	}else if(String.valueOf(cityid).length()==4){
		fatherId=Integer.parseInt(String.valueOf(cityid).substring(0, 2));
		System.out.println(cityid+"-------"+fatherId+"---------"+cityName_CN+"--------"+cityName_EN);
	}else if(String.valueOf(cityid).length()==6){
		fatherId=Integer.parseInt(String.valueOf(cityid).substring(0, 4));
		System.out.println(cityid+"-------"+fatherId+"---------"+cityName_CN+"--------"+cityName_EN);
	}
	CityList c=new CityList(cityid);
	c.cityName_CN=cityName_CN;
	c.cityName_EN=cityName_EN;
	c.hotcity=hotcity;
	c.areaType=areaType;
	c.fatherId=fatherId;
	c.isOpen=isOpen;
	c.set();
	
} */
%>