<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.admin.map.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %>
<%
TeaSession teasession = new TeaSession(request);
//if(teasession._rv == null)
//{
//  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//  return;
//}
Node node=Node.find(teasession._nNode);
String point="35,108,4";//request.getParameter("point");
String arr[]=point.split(",");
//
//String point="";
//if(field==null)
//{
//  GMap obj=GMap.find(teasession._nNode);
//  if(obj!=null)
//  {
//    point=obj.getLat()+","+obj.getLng()+","+obj.getZoom();
//  }
//}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
<title>地图标点</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
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

<body  onunload="GUnload()">
  <form action="#" onsubmit="showAddress(this.address.value); return false">
    <input type="text" size="60" name="address" value="天通苑1" /><input type="submit" value="Go!" />
  </form>

<div id="map_canvas" style="width:600px; height:500px"></div>
<div id="rs"></div>
<script type="text/javascript">
var map = new GMap2(document.getElementById("map_canvas"));
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());
map.enableDoubleClickZoom();
map.enableScrollWheelZoom();

var point=new GLatLng(<%=arr[0]%>, <%=arr[1]%>);
map.setCenter(point,<%=arr[2]%>);

var geocoder = new GClientGeocoder();
//function showAddress(address)
//{
//  geocoder.getLatLng(address,
//    function(point)
//    {
//      if (!point)
//      {
//        alert(address + " 没有找到!!!");
//      } else
//      {
//        map.setCenter(point, 13);
//      }
//    }
//  );
//}
var place,marker=new Array();
function showAddress(address)
{
  geocoder.getLocations(address,
    function addAddressToMap(response)
    {
      map.clearOverlays();
      if (!response || response.Status.code != 200)
      {
        alert("Sorry, we were unable to geocode that address");
      } else
      {
        var h="";
        place=response.Placemark;
        for(var i=0;i<place.length;i++)
        {
          point = new GLatLng(place[i].Point.coordinates[1],place[i].Point.coordinates[0]);
          marker[i]=new GMarker(point,{title:place[i].address});
          //marker[i].setImage("http://www.baidu.com/img/logo-yy.gif");
          map.addOverlay(marker[i]);
          GEvent.addListener(marker[i], 'click', openInfo);//place.address + '<br>' + '<b>Country code:</b> ' + place.AddressDetails.Country.CountryNameCode
          if(i==0)
          {
            map.setCenter(point,13);
          }
          h+="<a href='###' onclick='openInfo("+i+");'>"+place[i].address+"</a><br>";
        }
        rs.innerHTML=h;
      }
    }
  );
}

function openInfo(point)
{
  var j=0;
  if(typeof(point)=="number")
  {
    j=point;
    point=new GLatLng(place[j].Point.coordinates[1],place[j].Point.coordinates[0]);
  }else
  for(var i=0;i<place.length;i++)
  {
   if(point.equals(new GLatLng(place[i].Point.coordinates[1],place[i].Point.coordinates[0])))
   {
     j=i;
     break;
   }
  }
  map.openInfoWindowHtml(point,place[j].address);
}




</script>
</body>
</html>
