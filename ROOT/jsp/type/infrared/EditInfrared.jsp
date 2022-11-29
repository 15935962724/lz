<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int node=h.getInt("node");
Node n=Node.find(node);

Infrared t=null;
String subject=null,content=null;
if(n.getType()==1)
{
  t=new Infrared(0);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);

  t=Infrared.find(h.node);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——红外相机</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Infrareds.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">物种鉴定人：</td>
    <td><input name="wzjdr" value="<%=MT.f(t.wzjdr)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注说明：</td>
    <td><textarea name="remark" cols="50" rows="5"><%=MT.f(t.remark)%></textarea></td>
  </tr>
  <tr>
    <td class="th">照片名称：</td>
    <td><input name="pname" value="<%=MT.f(t.pname)%>"/></td>
  </tr>
  <tr>
    <td class="th">拍摄日期：</td>
    <td><input name="pstime" value="<%=MT.f(t.pstime,1)%>" onclick="mt.date(this,true)" class="date"/></td>
  </tr>
  <tr>
    <td class="th">对象类别：</td>
    <td><select name="type"><%=h.options(Infrared.INFRARED_TYPE,t.type)%></select></td>
  </tr>
  <tr>
    <td class="th">物种名称：</td>
    <td><input name="wzname" value="<%=MT.f(t.wzname)%>"/></td>
  </tr>
  <tr>
    <td class="th">动物数量：</td>
    <td><input name="num" value="<%=MT.f(t.num)%>"/></td>
  </tr>
  <tr>
    <td class="th">动物性别：</td>
    <td><select name="gender"><%=h.options(Infrared.GENDER_TYPE,t.gender)%></select></td>
  </tr>
  <tr>
    <td class="th">备注：</td>
    <td><textarea name="remark2" cols="50" rows="5"><%=MT.f(t.remark2)%></textarea></td>
  </tr>
  <tr>
    <td class="th">布设位点编号：</td>
    <td><input name="bswdnum" value="<%=MT.f(t.bswdnum)%>"/></td>
  </tr>
  <tr>
    <td class="th">相机编号：</td>
    <td><input name="camnum" value="<%=MT.f(t.camnum)%>"/></td>
  </tr>
  <tr>
    <td class="th">存储卡编号：</td>
    <td><input name="sdnum" value="<%=MT.f(t.sdnum)%>"/></td>
  </tr>
  <tr>
    <td class="th">日期：</td>
    <td><input name="thedate" value="<%=MT.f(t.thedate)%>"/></td>
  </tr>
  <tr>
    <td class="th">天气：</td>
    <td><input name="weather" value="<%=MT.f(t.weather)%>"/></td>
  </tr>
  <tr>
    <td class="th">放置时间：</td>
    <td><input name="storagetime" value="<%=MT.f(t.storagetime)%>"/></td>
  </tr>
  <tr>
    <td class="th">小地名：</td>
    <td><input name="placenames" value="<%=MT.f(t.placenames)%>"/></td>
  </tr>
  <tr>
    <td class="th">参加人员：</td>
    <td><input name="participants" value="<%=MT.f(t.participants)%>"/></td>
  </tr>
  <tr>
    <td class="th">填表人：</td>
    <td><input name="fillin" value="<%=MT.f(t.fillin)%>"/></td>
  </tr>
  <tr>
    <td class="th">东经：</td>
    <td><input name="eastlongitude" value="<%=MT.f(t.eastlongitude)%>"/></td>
  </tr>
  <tr>
    <td class="th">北纬：</td>
    <td><input name="northlatitude" value="<%=MT.f(t.northlatitude)%>"/></td>
  </tr>
  <tr>
    <td class="th">海拔：</td>
    <td><input name="poster" value="<%=t.poster==0F?"":String.valueOf(t.poster)%>" mask="float"/>米</td>
  </tr>
  <tr>
    <td class="th">坡度：</td>
    <td><input name="slope" value="<%=MT.f(t.slope)%>" mask="int"/></td>
  </tr>
  <tr>
    <td class="th">坡向：</td>
    <td><input name="slopedirection" value="<%=MT.f(t.slopedirection)%>"/></td>
  </tr>
  <tr>
    <td class="th">生境类型：</td>
    <td><input name="sjlx" value="<%=MT.f(t.sjlx)%>"/></td>
  </tr>
  <tr>
    <td class="th">森林起源：</td>
    <td><input name="slqy" value="<%=MT.f(t.slqy)%>"/></td>
  </tr>
  <tr>
    <td class="th">小生境：</td>
    <td><input name="xsj" value="<%=MT.f(t.xsj)%>"/></td>
  </tr>
  <tr>
    <td class="th">乔木高度：</td>
    <td><input name="qmgd" value="<%=MT.f(t.qmgd)%>"/>/米</td>
  </tr>
  <tr>
    <td class="th">郁闭度：</td>
    <td><input name="ybd" value="<%=MT.f(t.ybd)%>"/></td>
  </tr>
  <tr>
    <td class="th">胸径：</td>
    <td><input name="xj" value="<%=MT.f(t.xj)%>"/>/cm</td>
  </tr>
  <tr>
    <td class="th">优势树种：</td>
    <td><input name="yssz" value="<%=MT.f(t.yssz)%>"/></td>
  </tr>
  <tr>
    <td class="th">灌木高度：</td>
    <td><input name="gmgd" value="<%=MT.f(t.gmgd)%>"/>/米</td>
  </tr>
  <tr>
    <td class="th">灌木郁闭度：</td>
    <td><input name="gmymd" value="<%=MT.f(t.gmymd)%>"/></td>
  </tr>
  <tr>
    <td class="th">干扰类型：</td>
    <td><input name="grlx" value="<%=MT.f(t.grlx)%>"/></td>
  </tr>
  <tr>
    <td class="th">干扰强度：</td>
    <td><input name="grqd" value="<%=MT.f(t.grqd)%>"/></td>
  </tr>
  <tr>
    <td class="th">干扰频率：</td>
    <td><input name="grpl" value="<%=MT.f(t.grpl)%>"/></td>
  </tr>
</table>

<h2>动物1</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">动物名称1：</td>
    <td><input name="animalnameone" value="<%=MT.f(t.animalnameone)%>"/></td>
  </tr>
  <tr>
    <td class="th">痕迹类型1：</td>
    <td><input name="hjlxone" value="<%=MT.f(t.hjlxone)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注1：</td>
    <td><textarea name="aremarkone" cols="50" rows="5"><%=MT.f(t.aremarkone)%></textarea></td>
  </tr>
</table>

<h2>动物2</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">动物名称2：</td>
    <td><input name="animalnametwo" value="<%=MT.f(t.animalnametwo)%>"/></td>
  </tr>
  <tr>
    <td class="th">痕迹类型2：</td>
    <td><input name="hjlxtwo" value="<%=MT.f(t.hjlxtwo)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注2：</td>
    <td><textarea name="aremarktwo" cols="50" rows="5"><%=MT.f(t.aremarktwo)%></textarea></td>
  </tr>
</table>

<h2>动物3</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">动物名称3：</td>
    <td><input name="animalnamethree" value="<%=MT.f(t.animalnamethree)%>"/></td>
  </tr>
  <tr>
    <td class="th">痕迹类型3：</td>
    <td><input name="hjlxthree" value="<%=MT.f(t.hjlxthree)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注3：</td>
    <td><textarea name="aremarkthree" cols="50" rows="5"><%=MT.f(t.aremarkthree)%></textarea></td>
  </tr>
</table>

<h2>动物4</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">动物名称4：</td>
    <td><input name="animalnamefour" value="<%=MT.f(t.animalnamefour)%>"/></td>
  </tr>
  <tr>
    <td class="th">痕迹类型4：</td>
    <td><input name="hjlxfour" value="<%=MT.f(t.hjlxfour)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注4：</td>
    <td><textarea name="aremarkfour" cols="50" rows="5"><%=MT.f(t.aremarkfour)%></textarea></td>
  </tr>
</table>

<h2>动物5</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">动物名称5：</td>
    <td><input name="animalnamefive" value="<%=MT.f(t.animalnamefive)%>"/></td>
  </tr>
  <tr>
    <td class="th">痕迹类型5：</td>
    <td><input name="hjlxfive" value="<%=MT.f(t.hjlxfive)%>"/></td>
  </tr>
  <tr>
    <td class="th">备注5：</td>
    <td><textarea name="aremarkfive" cols="50" rows="5"><%=MT.f(t.aremarkfive)%></textarea></td>
  </tr>
</table>


<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">备注：</td>
    <td><textarea name="remarkend" cols="50" rows="5"><%=MT.f(t.remarkend)%></textarea></td>
  </tr>
  <tr>
    <td class="th">自然保护区名称：</td>
    <td><input name="bhqname" value="<%=MT.f(t.bhqname)%>"/></td>
  </tr>
  <tr>
    <td class="th">自然保护区编号：</td>
    <td><input name="bhqnum" value="<%=MT.f(t.bhqnum)%>"/></td>
  </tr>
  <tr>
    <td class="th">图片：</td>
    <td><input name="picture" value="<%=MT.f(t.picture)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
