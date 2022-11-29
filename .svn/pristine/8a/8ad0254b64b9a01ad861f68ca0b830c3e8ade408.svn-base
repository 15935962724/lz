<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.admin.map.*" %><%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String nexturl = teasession.getParameter("nexturl");
String field=request.getParameter("field");
Node nobj = Node.find(teasession._nNode);

System.out.println(nobj.getText2(teasession._nLanguage));

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

<body onunload="GUnload()">
<h1>地图标点</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form action="#" onsubmit="showAddress(this.address.value); return false">


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right">搜索你要标点的地址:</td>
      <td><input type="text" size="60" name="address" />&nbsp;<input type="submit" value="检索" /></td>
    </tr>
  </table>
  </form>

<form name="form1" action="/servlet/EditGMap">
  <input type="hidden" name="act" value="VenuesEdit" />
  <input type="hidden" name="point" value="<%=point%>"/>
  <input type="hidden" name="father" value="<%=father%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(field==null)
{
//  if(point.length()>0)//管理员编辑标点
//  {
//    out.print("<input type='hidden' name='nodeid' value='"+teasession._nNode+"' />");
//    Node nobj = Node.find(teasession._nNode);
//    Node nobj2 = Node.find(nobj.getFather());
//    out.print("<tr>");
//    out.print("<td>");
//    out.print("<input type=text name = subject value="+nobj2.getSubject(teasession._nLanguage)+">");
//    out.print("</td>");
//    out.print("</tr>");
//
//  }else//管理员添加标点_指定节点号
//  {

    %>
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
    <input type="hidden" name="nodeid" value="<%=teasession._nNode%>"/>

    <tr>
      <td align="right">请填写对标点的介绍信息:</td>
      <td>
        <input type="text" name="alt" value="<%=nobj.getAlt(teasession._nLanguage)%>" size="60" />&nbsp;
        <input type="button" value="保存" onclick="f_save()"/>&nbsp;
        <input type=button value="返回" onClick="javascript:history.back()">
      </td>
    </tr>

    <%
  //}
}
%>

</table>
</form>

<div id="map_canvas" style="width:600px; height:500px"></div>

<script type="text/javascript">
var map = new GMap2(document.getElementById("map_canvas"));
map.addControl(new GLargeMapControl());
map.addControl(new GMapTypeControl());
map.enableDoubleClickZoom();
map.enableScrollWheelZoom();

var geocoder = new GClientGeocoder();
function showAddress(address)
{
  geocoder.getLatLng(address,
    function(point)
    {
      if (!point)
      {
        alert(address + " 没有找到!!!");
      } else
      {
        map.setCenter(point, 13);
      }
    }
  );
}

var field=<%=field==null?"form1.point":"opener."+field%>;
var rs=field.value;
function f_save()
{
  if(!rs)
  {
    alert('你还没有标点!');
    return false;
  }else
  {
    field.value=rs;

    if(form1.point==field)
    {
      if(form1.father.value=="0")
      {
        if(!submitInteger(form1.nodeid,'无效-节点号'))
        {
          return false;
        }
        if(!submitText(form1.alt,'请填写对标点的介绍信息'))
        {
          form1.alt.focus();
          return false;
        }
      }
      form1.submit();
    }
  }
  //如果是窗口
  if(typeof(opener)=="object")
  {
    window.close();
  }
}
var marker;
function f_add(overlay,point)
{
  rs=point.y+","+point.x+","+map.getZoom();
  if(marker)map.removeOverlay(marker);
  marker = new GMarker(point);
  map.addOverlay(marker);
  //显示信息
   if(overlay!=null&&overlay.length>0){
     GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(overlay);});
     map.openInfoWindow(map.getCenter(),document.createTextNode(overlay));
   }
}

GEvent.addListener(map,"click",f_add);

var arr=new Array(35,108,4);
if(rs)
{
  arr=rs.split(",");
  arr[0]=parseFloat(arr[0]);
  arr[1]=parseFloat(arr[1]);
  arr[2]=parseInt(arr[2]);
}
map.setCenter(new GLatLng(arr[0], arr[1]),arr[2]);
if(rs)
{
  f_add('<%=nobj.getAlt(teasession._nLanguage)%>',new GLatLng(arr[0],arr[1]));
}
</script>
</body>
</html>
