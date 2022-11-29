<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
p{margin:0px;padding:0px;}

h1{color: #CE0829;display: block;width: 100%;height:42px;padding-left: 40px;vertical-align: middle;line-height: 42px;text-align: left;margin-bottom: 0px;border-bottom: 1px solid #D7D7D7;background: #efefef;font-size: 9pt;}
.yf,.zy{font-size:12px;}
.gn{color: #CE0829;font-size: 12px;font-weight:bold;margin: 5px 0px 5px 0px;background: #F2F2F2;}
.gnmsg{font-size: 12px;margin: 0px 0px 0px 0px;font-weight:bold;}
.yongfa{margin: 0px 0px 0px 0px;font-weight:bold;}
.yongfa{}
.yf span,.zy span{display: block;padding-left: 10px;vertical-align: middle;line-height:28px;text-align: left;width: 90%;clear: both;}

.put{font-size: 12px;padding-left: 10px;vertical-align: middle;line-height:20px;text-align: left;width: 90%;clear: both;}
.p3{padding:5px 0px;text-align:center;}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据导入</title>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<form action="/ImpDatas.do" name="form1" target="_ajax" method="post">
<h1>标本库数据导入：</h1>
<div class="yf">
    <span class="gn">功能描述</span>
    <span class="gnmsg">此导入功能将导入标本数据，并对对应图片批处理</span>
    <span class="yongfa">用法如下</span>
    <span class="msg">首先将要导入数据库的access文件和匹配的图片放置服务器上，然后检查mdb文件中表Picture中Mulname字段中格式为D:\TestData\2014\2\n29\580960Multimedia1.jpg，TestData前不要加文件夹，图片存放路径为D盘根目录下的“2014（即TestData后的文件夹），最后进入后台导入菜单按要求输入信息，导入成功</span>
</div>
<div class="zy">
    <span class="tishi">为了避免导入出错，请务必遵守以下注意事项</span>
    <span class="zhuyi">导前注意事项</span>
    <span class="sp1">1.保证填写路径正确无误</span>
    <span class="sp2">2.保证导入的mdb文件中表字段顺序无误</span>
    <span class="sp3">3.mdb文件中表Picture中Mulname字段中格式为D:\TestData\2014\2\n29\580960Multimedia1.jpg，TestData前不要加文件夹，图片存放路径为D盘根目录下的“2014（即TestData后的文件夹）”</span>
</div>
<div class="put">
    <p class="p1"><input type="hidden" name="act" value="impspecimen" >
    请输入数据文件路径<input type="text" name="namepath"  >例如：D://20140405/InfopathData.mdb</p>
    <p class="p2">请输入图片目录<input type="text" name="picpath" >例如：D://2014/</p>
    <p class="p3"><button type="button" onClick="mt.show(null,0);form1.submit()" class="button">提交</button></p>
</div>
</form>
<form action="/ImpDatas.do" name="form2" target="_ajax" method="post">
<input name="act" type="hidden" value="biaobenurl">
<h1>标本库数据路径导出：</h1>
<div class="yf">
    <span class="gn">功能描述</span>
    <span class="gnmsg">此功能将导入的标本数据对应网站的url地址进行导出</span>
    <span class="yongfa">用法如下</span>
    <span class="msg">首先将要导入数据库的access文件放置服务器上，然后检查mdb文件中表名，不能为中文，最后进入后台导入菜单按要求输入信息，导入成功</span>
</div>
<div class="zy">
    <span class="tishi">为了避免导入出错，请务必遵守以下注意事项</span>
    <span class="zhuyi">导前注意事项</span>
    <span class="sp1">1.保证填写路径正确无误</span>
    <span class="sp2">2.保证导入的mdb文件中表字段顺序无误</span>
    <span class="sp3">3.保证mdb文件中表名不能为中文</span>
</div>
<div class="put">
    <p class="p1">请输入数据文件路径<input type="text" name="datapath" >例如：D://20140408/20140408.mdb</p>
    <p class="p2">请输入数据文件表名表名<input type="text" name="tablename" >例如：plant</p>
    <p class="p3"><button type="button" onClick="mt.show(null,0);form2.submit()" class="button">提交</button></p>
</div>
</form>

<form action="/ImpDatas.do" name="form3" target="_ajax" method="post">
<input name="act" type="hidden" value="impKmz">
<h1>kmz文件导入：</h1>
<div class="yf">
<span class="gn">功能描述</span>
<span class="gnmsg">此功能将保护区的地图文件（kmz）导入库中</span>
<span class="yongfa">用法如下</span>
<span class="msg">首先将要导入数据库的kmz文件放置服务器上，注意kmz文件的文件名一定要和保护区名称对应，最后进入后台导入菜单按要求输入信息，导入成功</span>
</div>
<div class="zy">
    <span class="tishi">为了避免导入出错，请务必遵守以下注意事项</span>
    <span class="zhuyi">导前注意事项</span>
    <span class="sp1">1.保证填写路径正确无误</span>
    <span class="sp2">2.保证导入的kmz文件名为保护区名</span>
</div>
<div class="put">
    <p class="p1">请输入kmz文件夹路径<input type="text" name="kmzpath" >例如：D://20140408/</p>
    <p class="p3"><button type="button" onClick="mt.show(null,0);form3.submit()" class="button">提交</button></p>
</div>
</form>

</body>
</html>