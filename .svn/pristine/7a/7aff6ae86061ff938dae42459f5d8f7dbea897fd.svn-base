<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.map.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%

Http h=new Http(request);
Node node=Node.find(h.node);

String point=h.get("point","");
String arr[]=point.split(",");
//
//String point="";
//if(field==null)
//{
//  GMap obj=GMap.find(h.node);
//  if(obj!=null)
//  {
//    point=obj.getLat()+","+obj.getLng()+","+obj.getZoom();
//  }
//}
%><html>
<head>
<title>地图标点</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<script language="javascript" src="/tea/mt.js"></script>
<style type="text/css">
body{margin:0;}
</style>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
</head>
<body scroll="no">


<div id="gmap" style="width:100%; height:100%"></div>

<script type="text/javascript">
var map=new google.maps.Map($("gmap"),
{
  zoom:4,
  center:new google.maps.LatLng(35,108),
  mapTypeId:google.maps.MapTypeId.ROADMAP,
  streetViewControl:false
});

map.setCenter(new google.maps.LatLng(<%=arr[0]%>,<%=arr[1]%>));
map.setZoom(<%=arr[2]%>);
new google.maps.Marker({position:map.center,map:map});

/*
var map = new GMap2(document.getElementById("gmap"));
if(document.body.clientWidth>400)map.addControl(new GLargeMapControl());
//map.addControl(new GMapTypeControl());
map.enableDoubleClickZoom();
map.enableScrollWheelZoom();


var point=new GLatLng(<%=arr[0]%>,<%=arr[1]%>);
map.setCenter(point,<%=arr[2]%>);

map.addOverlay(new GMarker(point));


//标点
//var im=mt.find('src','http://maps.gstatic.cn/intl/zh-CN_cn/mapfiles/marker.png','IMG');
//for(var i=0;i<im.length;i++)
//{
//  im[i].className='marker';
//}

var inter=setInterval(function()
{
  var t=document.links;
  if(t.length<2)return;
  clearInterval(inter);
  //隐藏Logo
  t=t[t.length-1];
  //t=$class('gmnoprint terms-of-use-link')[0];
  var p=t.parentNode;
  p.previousSibling.style.display=p.style.display='none';
},100);
*/
</script>
</body>
</html>
