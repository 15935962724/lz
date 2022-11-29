<style>
p{margin:0px;padding:0px;padding-left:10px;}

h1{color: #CE0829;display: block;width: 100%;height:42px;padding-left: 40px;vertical-align: middle;line-height: 42px;text-align: left;margin-bottom: 0px;border-bottom: 1px solid #D7D7D7;background: #efefef;font-size: 9pt;}
.zy{font-size:12px;}
.zy p{display:block;padding-left:10px;vertical-align:middle;line-height:28px;text-align: left;width: 90%;clear:both;}

.put{font-size: 12px;padding-left: 10px;vertical-align: middle;line-height:20px;text-align: left;width: 90%;clear: both;}
.p3{padding:5px 0px;text-align:center;}
</style>

<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="zy">
<h1>导入物种图库说明</h1>
<p>第一步：准备好要导入的文件（包括accdb文件和相应图片文件），放在服务器D盘根目录</p>
<p>第二步：打开网址http://www.papc.cn/html/papc/category/13113988-1.htm在下面建好保护区生态图鉴节点并记录下节点号</p>
<p>第三步：在服务器下打开cmd命令窗口，输入如java -jar papcDataImport.jar 河北雾灵山 13110233 D:\\雾灵山昆虫生态图鉴\\雾灵山昆虫图鉴.accdb insects localhost 123 insert，其中河北雾灵山为要导入的保护区名称，13110233为建好节点的节点号 D:\\雾灵山昆虫生态图鉴\\雾灵山昆虫图鉴.accdb为数据文件路径，insects为accdb文件中的表名，123为链接导入库的密码，insert为导入数据，如果填update为更新数据</p>
<p>第4步：导完后会在导入数据的文件夹下生成JS文件夹，和在picture文件夹下生成album文件夹，将里面的数据全部复制到D:\Tomcat6\webapps_papc\ROOT\res\papc\album目录下</p>
<p>第5步：完成导入</p>
</div>