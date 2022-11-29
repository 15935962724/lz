<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.map.*" %><%@page import="tea.ui.*" %>
<%
Http h=new Http(request);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String q=h.get("q","");
String field=h.get("field");

String point="";
if(field==null)
{
  GMap obj=GMap.find(teasession._nNode);
  if(obj!=null)
  {
    point=obj.getLat()+","+obj.getLng()+","+obj.getZoom();
  }
}
int father=h.getInt("father");


%>
<!--
father:标点的父节点
-->
<!DOCTYPE html>
<html>
<head>
<title>地图标点</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
}
.terms-of-use-link {
	DISPLAY: none
}

#rs{float:left; border:1px solid #CCCCCC; width:200px}
-->
</style>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
</head>

<body>
<form name="form1" onsubmit="search(this.address.value);return false">
  <input name="address" value="<%=q%>" size="60" /><input type="submit" value="查询" />
</form>

<form name="form2" action="/servlet/EditGMap">
  <input type="hidden" name="act" value="edit" />
  <input type="hidden" name="point" value="<%=point%>"/>
  <input type="hidden" name="father" value="<%=father%>"/>
<%
if(field==null)
{
  if(point.length()>0)//管理员编辑标点
  {
    out.print("<input type='hidden' name='nodeid' value='"+teasession._nNode+"' />");
  }else//管理员添加标点_指定节点号
  {
    %>
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
      <table>
        <tr>
          <td>节点号:</td><td><input type="text" name="nodeid" mask="int" /></td>
        </tr>
        <tr>
          <td>主题:</td><td><input type="text" name="subject" /></td>
        </tr>
      </table>
    <%
  }
}
%>
<input type="button" value="保存" onclick="f_save()"/>
</form>

<div id="rs"></div>
<div id="gmap" style="width:580px; height:430px"></div>

<script type="text/javascript">

var map=new google.maps.Map(document.getElementById("gmap"),
{
  zoom:4,
  center:new google.maps.LatLng(35,108),
  mapTypeId:google.maps.MapTypeId.ROADMAP,
  streetViewControl:false
});

var marker;

//单击标点
google.maps.event.addListener(map,'click',function(event)
{
  if(marker)marker.setMap(null);//删除上次标点
  marker=new google.maps.Marker(
  {
    //icon:'http://maps.google.com/mapfiles/arrow.png',
    position:event.latLng,
    map:map
  });
});

var iw=new google.maps.InfoWindow();

//搜索
var layer=[];
function search(address)
{
  var geocoder=new google.maps.Geocoder();
  geocoder.geocode({'address':address},function(results,status)
  {
    var h="<table>";
    if(status=='ZERO_RESULTS')
    {
      h="未找到相关地点，抱歉。";
    }else if(status!=google.maps.GeocoderStatus.OK)
    {
      alert(status);
      return;
    }else
    {
      map.setCenter(results[0].geometry.location);
      map.setZoom(13);
      //删除上标查询的标点
      for(var i=0;i<layer.length;i++)layer[i].setMap(null);

      h+="<tr><td colspan='2'>共有"+results.length+"条结果";
      for(var i=0;i<results.length;i++)
      {
        var icon='http://www.google.com/mapfiles/marker'+String.fromCharCode(65+i)+'.png';
        h+="<tr onMouseOver=bgColor='#FFFFCA';map.setCenter(layer["+i+"].position); onMouseOut=bgColor=''><td valign='top'><img src='"+icon+"' /><td>"+results[i].formatted_address+"</td>";

        //标点
        layer[i]=new google.maps.Marker(
        {
          position:results[i].geometry.location,
          map:map,
          info:results[i].formatted_address,
          icon:icon
        });

        //消息框
        google.maps.event.addListener(layer[i],'click',function(event)
        {
          iw.setContent(this.info);
          iw.setPosition(event.latLng);
          iw.open(map);
        });
      }
    }
    document.getElementById("rs").innerHTML=h+"</table>";;
  });
}


//上次标点
var field=<%=field==null?"form2.point":"opener."+field%>;
var rs=field.value;
if(rs)
{
  var arr=rs.split(",");
  arr[0]=parseFloat(arr[0]);
  arr[1]=parseFloat(arr[1]);
  arr[2]=parseInt(arr[2]);
  map.setCenter(new google.maps.LatLng(arr[0],arr[1]));
  map.setZoom(arr[2]);

  marker=new google.maps.Marker({position:map.center,map:map});
}else if(form1.address.value)
{
  form1.onsubmit();
}

setInterval(function()
{
  document.title=map.getZoom();
},500);


function f_save()
{
  if(!marker)
  {
    alert('你还没有标点!');
    return false;
  }
  var ll=marker.position;
  field.value=ll.lat()+','+ll.lng()+','+map.getZoom();
  if(form2.point==field)
  {
    if(form2.father.value=="0")
    {
      if(!submitInteger(form2.nodeid,'无效-节点号'))
      {
        return false;
      }
    }else
    {
      if(!submitText(form2.subject,'无效-主题'))
      {
        return false;
      }
    }
    form2.submit();
  }
  //如果是窗口
  if(typeof(opener)=="object")
  {
    window.close();
  }
}
</script>
</body>
</html>
