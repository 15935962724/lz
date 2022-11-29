<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.entity.*"%>

<%
Http h=new Http(request);
String pointAndZoom = h.get("pointAndZoom2");
String searchVal = h.get("searchVal");

%>

<!--
father:标点的父节点
-->
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{height:500px;width:100%;}
		#r-result{width:100%; font-size:14px;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jdlTvGgd7XbePz88gGY5dgoE"></script>
	<title>地图标注</title>
	<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type=""></SCRIPT>
	<script>var pmt=parent.mt;</script>
</head>
<body>
	<div id="allmap"></div>
	<div id="r-result">
		地址: <input id="searchValue" type="text" style="width:100px; margin-right:10px;" />
		<input type="hidden" id="map"/>
		<input type="hidden" id="province"/>
		<input type="hidden" id="city"/>
		<input type="hidden" id="address"/>
		<input type="button" value="查询" onclick="theLocation3('',document.getElementById('searchValue').value)" />
		<input type="button" value="确认" onclick="save()" />
	</div>
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(116.404, 39.915);
	map.centerAndZoom(point,16);
	
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮
	
	//添加控件和比例尺
	map.addControl(top_left_control);    
	map.addControl(top_left_navigation);
	
	map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
	
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.disable3DBuilding();
	
	/* var stCtrl = new BMap.PanoramaControl(); //构造全景控件
	stCtrl.setOffset(new BMap.Size(20, 40));
	map.addControl(stCtrl);//添加全景控件 */
	
	theLocation3('<%=MT.f(pointAndZoom)%>','<%=MT.f(searchVal)%>');
	function theLocation3(pointZoom,myAddress){
		var myGeo = new BMap.Geocoder();
		marker = new BMap.Marker(point);//创建一个标准
		if(pointZoom!=null&&pointZoom.length>0){
			var arr=pointZoom.split(",");
			var lng=parseFloat(arr[0]);
			var lat=parseFloat(arr[1]);
			var zoom=parseInt(arr[2]);
			//alert("lng:"+lng+",lat:"+lat+",zoom:"+zoom);
			point = new BMap.Point(lng,lat);
			map.centerAndZoom(point,zoom);
			marker = new BMap.Marker(point);//创建一个标准
			map.addOverlay(marker);
			marker.enableDragging();//设置标注可以移动
			myGeo.getLocation(point, function(rs){showLocationInfo(point, rs);});
		}else if(myAddress!=null&&myAddress.length>0){
			myGeo.getPoint(myAddress, function(point){ //我输入的是“知春路”，第一步getPoint是地址解析。
				if(point) {
					map.clearOverlays();
					map.centerAndZoom(point, 16);
					marker = new BMap.Marker(point);//创建一个标准
					map.addOverlay(marker);
					marker.enableDragging();//设置标注可以移动
					marker.setTitle(myAddress);
					myGeo.getLocation(point, function(rs){ //这里弹出“知春路”的详细地址信息，第二步getLocation是反地址解析。
						showLocationInfo(point, rs);
						//var addComp = rs.addressComponents;
						//alert(myAddress+'的具体位置是：'+addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
					});
					//添加标记拖拽监听
					marker.addEventListener("dragend", function(e){
					    //获取地址信息
					    myGeo.getLocation(e.point, function(rs){
					        showLocationInfo(e.point, rs);
					    });
					});
					//添加标记拖拽监听
					marker.addEventListener("click", function(e){
					    //获取地址信息
					    myGeo.getLocation(e.point, function(rs){
					        showLocationInfo(e.point, rs);
					    });
					});
				}
			}, ""); //必须设置城市
			
		}
	}
	
	//显示地址信息窗口
	function showLocationInfo(pt, rs){
	    var opts = {
	      width : 250,     //信息窗口宽度
	      height: 50,     //信息窗口高度
	      title : "",  //信息窗口标题
	      enableMessage: false //是否启用发送到手机
	    }
	      
	    var addComp = rs.addressComponents;
	    var province = addComp.province;
	    var city = addComp.city;
	    var district = addComp.district;
	    var street = addComp.street;
	    var streetNumber = addComp.streetNumber;
	    var pointAndZoom = pt.lng+","+pt.lat+","+map.getZoom();
	    var parentCity = null;
	    var address = null;
	    if(province==city){
	    	parentCity=district.substring(0,district.length-1);
	    	address=street+streetNumber;
	    }else{
	    	parentCity=city.substring(0,city.length-1)
	    	address=district+street+streetNumber;
	    }
	    var addr = "当前位置：" + province + (city==province?"":city) + district + street + streetNumber;
	    //addr += "纬度: " + pt.lat + ", " + "经度：" + pt.lng;
	    //alert(addr);
	      
	    var infoWindow = new BMap.InfoWindow(addr, opts);  //创建信息窗口对象
	    marker.openInfoWindow(infoWindow);
	    document.getElementById("map").value=pointAndZoom;
	    document.getElementById("province").value=province;
	    document.getElementById("city").value=parentCity;
	    document.getElementById("address").value=address;
	    document.getElementById("searchValue").value=address;
	    //alert(parentCity);
	    //pmt.remap(pointAndZoom,province,parentCity,address);
	}
	
	function save(){
		var pointAndZoom=document.getElementById("map").value;
		var province = document.getElementById("province").value;
		var parentCity = document.getElementById("city").value;
		var address = document.getElementById("address").value;
		pmt.remap(pointAndZoom,province,parentCity,address);
		pmt.close();
	}
</script>

