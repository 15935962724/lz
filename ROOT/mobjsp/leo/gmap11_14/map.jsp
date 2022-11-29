<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.Card"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Http h = new Http(request, response);
int node=h.node;
%>

<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<div id="map3d" style="height: 500px; width: 760px;"></div>
<script type="text/javascript">
var ge;
google.load("earth", "1");

function initCB(instance)
{
  ge = instance;
  ge.getWindow().setVisibility(true);
  /*
  //ge.getOptions().setFlyToSpeed(ge.SPEED_TELEPORT);//移动速度

  //平移到绝对位置
  var lookAt = ge.getView().copyAsLookAt(ge.ALTITUDE_RELATIVE_TO_GROUND);

  // Set new latitude and longitude values.
  lookAt.setLatitude(25.458333333333336);//纬度
  lookAt.setLongitude(110.04166666666666);//经度
  lookAt.setRange(5000.0);//缩放镜头
  //lookAt.setTilt(lookAt.getTilt() + 15.0);//倾斜镜头

  // Update the view in Google Earth.
  ge.getView().setAbstractView(lookAt);


  //地标
  var placemark = ge.createPlacemark('');
  placemark.setName("名称");

  // Set the placemark's location.
  var point = ge.createPoint('');
  point.setLatitude(25.458333333333336);
  point.setLongitude(110.04166666666666);
  placemark.setGeometry(point);

  // Add the placemark to Earth.
  ge.getFeatures().appendChild(placemark);

  //图层
  ge.getLayerRoot().enableLayerById(ge.LAYER_ROADS, true);//道路和道路名称
  ge.getLayerRoot().enableLayerById(ge.LAYER_TERRAIN, true);//3D 地形
  ge.getLayerRoot().enableLayerById(ge.LAYER_BORDERS, true);//显示国家和地区边界
  ge.getLayerRoot().enableLayerById(ge.LAYER_BUILDINGS, true);//3D 建筑
  */
  //导航控件
  ge.getNavigationControl().setVisibility(ge.VISIBILITY_AUTO);


  //ge.getTime().setHistoricalImageryEnabled(true);//时间滑块

/*
  //查看星空
  ge.getOptions().setMapType(ge.MAP_TYPE_SKY);
  var lookAt = ge.createLookAt('');
  lookAt.set(41.28509187215, -169.2448684551622, 0, ge.ALTITUDE_RELATIVE_TO_GROUND, 262.87, 0, 162401);
  ge.getView().setAbstractView(lookAt);
*/

  var link=ge.createLink('');
  var u=location.href;
  var basepath = '<%=basePath%>';
  link.setHref(basepath +'res/papc/kmz/'+<%=node%>+'.kmz?t='+new Date().getTime());

  var networkLink = ge.createNetworkLink('');
  networkLink.set(link, true, true); // Sets the link, refreshVisibility, and flyToView

  ge.getFeatures().appendChild(networkLink);
}
function failureCB(err)
{
  //http://www.google.com/earth/plugin/error.html#error=ERR_NOT_INSTALLED
  var url="/res/papc/GoogleEarth-Win-Plugin-7.0.2.8415.exe";
  LANG['SUCCESS_RECENT_INSTALL_RESTART']=['The Google Earth Plugin is now installed!<br/>Restart the browser to see it in action.','Google 地球插件已成功安装！<br/>请重新启动浏览器，使其生效。'];
  LANG['ERR_INIT']=["There was a problem with the Google Earth Plugin. Please try reloading the page.<br/>If that doesn't help, you can <a href='"+url+"'><b>re-install the Google Earth Plugin using this link</b></a>.","Google 地球插件出现问题。请尝试重新载入此页面。<br/>如果不起作用，您可以<a href='"+url+"'><b>通过此链接重新安装 Google 地球插件</b></a>"];

  LANG['要查看 3D 地图，您需要安装 Google 地球插件']=['To view maps in 3D you need the Google Earth Plugin'];
  LANG['下载 Google 地球插件']=['Download the Google Earth Plugin'];
  LANG['浏览器中的 3D 地图']=['3D maps in your browser'];
  LANG['了解详情 »']=['Learn more »'];

  var t=document.getElementById('map3d');
  var htm="<table style='width:100%;height:100%;'>";
  htm+="  <tr>";
  htm+="    <td align='center' valign='middle'><div style='color:#FFFFFF;padding:10px;background-image:url(http://www.google.com/earth/plugin/images/black50.png)'>";
  if(err=='ERR_CREATE_PLUGIN')
  {
    if(google.earth.isInstalled())
    {
      failureCB('SUCCESS_RECENT_INSTALL_RESTART');
      return;
    }
    htm+=mt.res("要查看 3D 地图，您需要安装 Google 地球插件")+"</div><div style='width:300px; background:#CADEF4; padding:20px;'><a href='"+url+"' style='background:#365789; color:#FFFFFF; padding:10px;display:block'>"+mt.res("下载 Google 地球插件")+"</a><br/>"+mt.res("浏览器中的 3D 地图")+"</div><br/><a href='http://earth.google.com/intl/zh-CN/plugin/'>"+mt.res("了解详情 »")+"</a></td>";
    navigator.plugins.refresh(false);
    setTimeout("failureCB('"+err+"')",2000);
  }else
    htm+=mt.res(err);
  htm+="  </tr>";
  htm+="</table>";
  t.style.cssText+=";background:#000000 url(http://www.google.com/earth/plugin/images/globe_background.jpg) no-repeat center";
  t.innerHTML=htm;
}

google.setOnLoadCallback(function()
{
  google.earth.createInstance('map3d',initCB,failureCB);
});
</script>
