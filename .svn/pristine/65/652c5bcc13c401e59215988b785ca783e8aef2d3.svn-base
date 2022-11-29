<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.admin.map.*" %><%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %>
<%
TeaSession teasession = new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");
String field=request.getParameter("field");
Node nobj = Node.find(teasession._nNode);


String point="";
if(field==null)
{
  GMap obj=GMap.find(teasession._nNode);
  if(obj!=null)
  {
    point=obj.getLat()+","+obj.getLng()+","+obj.getZoom();
  }
}
int father=0;
String tmp=request.getParameter("father");
if(tmp!=null)
{
  father=Integer.parseInt(tmp);
}


%>
<!--
father:标点的父节点
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<title>地图标点</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
<!--
body
{
margin-left: 0px;
margin-top: 0px;
margin-right: 0px;
margin-bottom: 0px;
}
-->
</style>
<script src="http://ditu.google.cn/maps?file=api&amp;v=2.x&amp;key=<%=GMap.key(request.getServerName())%>&hl=zh-CN" type="text/javascript"></script>
</head>

<body onunload="GUnload()" style="background:none;">
<form name="form1" action="/servlet/EditGMap">
<input type="hidden" name="act" value="VenuesEdit" />
<input type="hidden" name="point" value="<%=point%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="alt" value="<%=nobj.getAlt(teasession._nLanguage)%>" >



</form>

<div id="map_canvas" style="width:800px; height:700px"></div>

<script type="text/javascript">

var field=<%=field==null?"form1.point":"opener."+field%>;
var rs=field.value;

var map = new GMap2(document.getElementById("map_canvas"));
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());
map.enableDoubleClickZoom();
map.enableScrollWheelZoom();
var arr=new Array(35,108,4);
if(rs)
{
  arr=rs.split(",");
  arr[0]=parseFloat(arr[0]);
  arr[1]=parseFloat(arr[1]);
  arr[2]=parseInt(arr[2]);
}
map.setCenter(new GLatLng(arr[0], arr[1]),arr[2]);

//地图坐标信息
var marker = new GMarker(new GLatLng(arr[0], arr[1]));
map.addOverlay(marker);

if(form1.alt.value!=null && form1.alt.value.length>0)
{
  map.openInfoWindow(map.getCenter(),document.createTextNode(form1.alt.value));
  GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(form1.alt.value);});
}




</script>
</body>
</html>
