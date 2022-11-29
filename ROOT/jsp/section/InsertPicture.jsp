<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="java.util.*"%><%@ page import="tea.file.FileUtils"%><%@ page import="tea.entity.*"%><%@ page import="tea.resource.Resource" %><%@ page import="java.io.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("POST".equals(request.getMethod()))
{
  String file=request.getParameter("file");
  new File(application.getRealPath(file)).delete();
  teasession.getSession().setAttribute("sf",null);//////////////???????????????
}

Resource r=new Resource("/tea/ui/node/section/Sections").add("/tea/ui/node/section/EditPicture");
//String kk = "xxx";

int i4 = 0;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link href="/res/<%=teasession._strCommunity%>/cssjs/upload/style.css" rel="stylesheet" type="text/css">
<link href="/res/<%=teasession._strCommunity%>/cssjs/upload/uploadify.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/jquery-1.3.2.min.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/swfobject.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/jquery.uploadify.v2.1.0.min.js" type=""></SCRIPT>
<script>
$(document).ready( function() {//jquery上传
		$("#uploadify").uploadify( {

			'uploader' :'/tea/upload/uploadify.swf',
			'script' :'/servlet/InsertPicture',//后台处理的请求
			'cancelImg' :'/tea/upload/images/cancel.png',
			//'folder' :'uploads',//您想将文件保存到的路径
			'queueID' :'fileQueue',//与下面的id对应
			'queueSizeLimit' :20,
			'fileDesc' :'请选择jpg gif png bmp图片文件',
			'fileExt' :'*.jpg;*.gif;*.png;*.bmp', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc
            'buttonImg':'/tea/upload/images/br2.gif',
			'height':26,
			'width':86,
            'method':'GET',
            'scriptData':{'op':'ups','community':'<%=teasession._strCommunity%>','node':'<%=teasession._nNode%>','pictureName':'','changepic':'','flag':$('#ck').attr('checked')},

			'auto' :false,
			'multi' :true,
			'simUploadLimit' :1,
			//'buttonText' :'browse',
            'onComplete': function(event, queueID, fileObj,response,data) {
              var sp = data.speed;

              //sp = sp.substring(0,4);
              document.getElementById("msg").innerHTML+=("文件:&nbsp;<font style='font-weight:bold'>"+fileObj.name+"</font>&nbsp;&nbsp;上传成功!<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传速度:&nbsp;&nbsp;"+sp+" Kb/s<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传路径:&nbsp;&nbsp;<input style='width:300' type='text' value='"+response+"'><br><br>");
            },
            'onQueueFull':function(event,queueSizeLimit ) {
              alert("最多允许一次上传"+queueSizeLimit+"个文件");
            }
		});
});
function submitInteger(obj,text)
{
  if(obj.value.length>0&&isNaN(parseInt(obj.value)))
  {
    alert(text + "sss");
    obj.focus();
    return false;
  }

  return true;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<style>

#fileQueue {
	width: 400px;
	height: 220px;
	overflow: auto;
	border: 1px solid #E5E5E5;
	margin-bottom: 10px;
	background-color: #ffF;

}



/* --Uploadify -- */
.uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: 2px solid #E5E5E5;
	background-color: #F5F5F5;
	margin-top: 5px;
	padding: 10px;
	width: 350px;
}
.uploadifyError {
	border: 2px solid #FBCBBC !important;
	background-color: #FDE5DD !important;
}
.uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyProgress {
	background-color: #FFFFFF;
	border-top: 1px solid #808080;
	border-left: 1px solid #808080;
	border-right: 1px solid #C5C5C5;
	border-bottom: 1px solid #C5C5C5;
	margin-top: 10px;
	width: 100%;
}
.uploadifyProgressBar {
	background-color: #0099FF;
	width: 1px;
	height: 3px;
}
#fileQueue .uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: none;
	border-bottom: 1px solid #E5E5E5;
	background-color: #FFFFFF;
	padding: 5%;
	width: 90%;
}
#fileQueue .uploadifyError {
	background-color: #FDE5DD !important;
}
#fileQueue .uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: 2px solid #E5E5E5;
	background-color: #F5F5F5;
	margin-top: 5px;
	padding: 10px;
	width: 350px;
}
.uploadifyError {
	border: 2px solid #FBCBBC !important;
	background-color: #FDE5DD !important;
}
.uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyProgress {
	background-color: #FFFFFF;
	border-top: 1px solid #808080;
	border-left: 1px solid #808080;
	border-right: 1px solid #C5C5C5;
	border-bottom: 1px solid #C5C5C5;
	margin-top: 10px;
	width: 100%;
}
.uploadifyProgressBar {
	background-color: #0099FF;
	width: 1px;
	height: 3px;
}
</style>
<h1><%=r.getString(teasession._nLanguage, "CBNewPicture")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/InsertPicture" enctype=multipart/form-data onSubmit="foEdit.submit.disabled=true;$('#uploadTip').fadeIn(1000);">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="watermark" value="false">
<%
if(request.getParameter("bg")!=null)
out.println("<input type=hidden name=bg value=ON>");
%>

<h2><%=r.getString(teasession._nLanguage, "PictureBrowse")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "FileName")%>:</td>
    <td><input type="text" class="edit_input"  name="changepic"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td><input name="picture" type="file" class="edit_input" size="40"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
    <td><input name="flag" type="checkbox" value="0" />添加水印</td>
  </tr>
  <tr>
    <td><input type="submit" name="submit" onClick="return submitText(foEdit.picture, '<%=r.getString(teasession._nLanguage, "InvalidPicture")%>');"  class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
    <td><div style="margin-left:2;float:left;display:none" id="uploadTip">上传中....请您耐心等待</div></td>
  </tr>
  <%
  String filepath = teasession.getParameter("path");
  if(filepath!=null)
  {
    %>
    <tr>
      <td colspan="2"><hr size="1"/></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Path")%>:</td>
      <td><input type=TEXT class=edit_input name=Path SIZE=70 VALUE="<%=filepath%>">
        <script type="">
        foEdit.Path.focus();
        foEdit.Path.document.execCommand('selectall');
        </script>
        </tr>
        <%
        }
        %>
            </form>
        <tr>
        <script>
            function openClose(){
              if(document.getElementById('oc').value == "打开批量上传"){
                $('#ups1').fadeIn(0);
                $('#ups2').fadeIn(0);
                $('#ups3').fadeIn(0);
                $('#ups4').fadeIn(0);
                $('#upsTip').fadeIn(0);
                document.getElementById('oc').value = "关闭批量上传"
              }
              else{
                $('#ups1').fadeOut(0);
                $('#ups2').fadeOut(0);
                $('#ups3').fadeOut(0);
                $('#ups4').fadeOut(0);
                $('#upsTip').fadeOut(0);
                document.getElementById('oc').value = "打开批量上传"
              }
            }
        </script>
          <td><input id="oc" type="button" value="打开批量上传" onClick="openClose()"></td>
          <td><div id="upsTip" style="display:none;color:red">提示：为保证网站正常浏览，请注意上传文件的大小，<br />　　　尽可能不要传大于2M的文件，每次最多可允许上传20个文件。</div></td>
        </tr>
        <tr style="display:none" id="ups1">
           <td><%=r.getString(teasession._nLanguage, "上传文件列表")%>:</td>
           <td style="padding:5px"><div id="fileQueue"></div><div id="msg" style="font-size:14"></div></td>
        </tr>
         <tr style="display:none" id="ups4">
           <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
           <td>
             <iframe id="main" name="main" width="0%" height="0%"> </iframe>
             <form id="ckForm" action="/servlet/InsertPicture" target="main">
               <input type="hidden" id="isck" name="isck" value="1"/>
               <input id="ck" name="flag" type="checkbox" value="1" />添加水印
             </form>
             <script>
                 function sbCk(){
                   // setTimeout("document.getElementById('ckForm').submit();",1000);//
                   //document.getElementById('ckForm').submit();
                   //ckForm.submit();
                   document.getElementById("ckForm").submit();
                 }
               </script>
           </td>
         </tr>
        <tr style="display:none" id="ups2">
          <td><%=r.getString(teasession._nLanguage, "请选择上传文件")%>:</td>
          <td>
            <input type="file" name="picturess" id="uploadify" />
          </td>
        </tr>
        <tr style="display:none" id="ups3">
          <td></td>
          <td>
            <input type="button" onClick="javascript:$('#uploadify').uploadifySettings('scriptData',{'flag':$('#ck').attr('checked')});jQuery('#uploadify').uploadifyUpload();" value="开始上传">&nbsp;
            <input type="button" onClick="javascript:jQuery('#uploadify').uploadifyClearQueue();" value="取消所有上传">
          </td>
        </tr>
 </table>





<%
if(request.getParameter("bg")!=null)
{
  teasession.getSession().setAttribute("sf",null);////////////////////////
  StringBuffer par=new StringBuffer();
  String menuid=request.getParameter("id");
  int pos=0;
  String tmp=request.getParameter("pos");
  if(tmp!=null)pos=Integer.parseInt(tmp);

  String type=request.getParameter("type");

  StringBuffer sb=new StringBuffer();
  File fs[]=new File(application.getRealPath("/res/"+teasession._strCommunity)).listFiles(new FilenameFilter()
  {
    public boolean accept(File dir, String name)
    {
      return name.length()==4&&name.replaceAll("\\d","").length()==0;
    }
  });
  if(type==null)type=fs[0].getName();
  for(int i=0;i<fs.length;i++)
  {
    String name=fs[i].getName();
    sb.append("<option value="+name);
    if(name.equals(type))sb.append(" selected='true'");
    sb.append(">"+name+" ("+fs[i].list().length+")");
  }
//fs=new File(application.getRealPath("/res/"+teasession._strCommunity+"/u/")).listFiles();
//if(fs!=null)
//{
//  for(int i=0;i<fs.length;i++)
//  {
//    String name="u/"+fs[i].getName();
//    sb.append("<option value="+name);
//    if(name.equals(type))sb.append(" selected='true'");
//    sb.append(">"+name.substring(2)+" ("+fs[i].list().length+")");
//  }
//}
    par.append("?community=").append(teasession._strCommunity);
    par.append("&id=").append(menuid);
    par.append("&type=").append(type);
    par.append("&bg=on");
    par.append("&pos=");
    type="/res/"+teasession._strCommunity+"/"+type+"/";
    fs=new File(application.getRealPath(type)).listFiles();
    Arrays.sort(fs,new FileUtils.CompratorByLastModified());
    List list = Arrays.asList(fs);
    Collections.reverse(list);
    fs = (File[])list.toArray();

    //String act = request.getParameter("act");
    if(request.getParameter("act") != null){
      if(request.getParameter("act").equals("searchF")){
        String sfname = request.getParameter("sfname");
        int flag = 0;
        List list2 = new ArrayList();//查询到的LIST
        for(int i = 0 ; i < fs.length;i++){
          String tname=fs[i].getName();
          //System.out.print(tname);
          int o = tname.lastIndexOf(".");
          if(o == -1){
            if(tname.contains(sfname)){///////////////?????????substring(0,o)为-1？？？？
                flag = 1;
                teasession.getSession().setAttribute("sf","oo");
                list2.add(fs[i]);
            }
          }else{
            if(tname.substring(0,o).contains(sfname) || tname.contains(sfname)){///////////////?????????substring(0,o)为-1？？？？
                flag = 1;
                teasession.getSession().setAttribute("sf","oo");
                list2.add(fs[i]);

            }
          }

        }
        teasession.getSession().setAttribute("sfList",list2);
        if(flag == 0){
          out.print("<script>alert('没有找到');</script>");
          teasession.getSession().setAttribute("sfList",null);
          teasession.getSession().setAttribute("sf",null);
        }
      }
    }
%>
<h2><%=r.getString(teasession._nLanguage, "PictureManage")%></h2>
<form name="form2" action="?">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="id" value="<%=menuid%>">
<input type='hidden' name="bg" value="on">
<input type='hidden' name="file">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>分类：<select name="type"><%=sb.toString()%></select> <input type="submit" value="GO"/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    请输入文件名：<input type="text" id="sfname" name="sfname">&nbsp;<input type="button" value="GO" title="搜索位置在当前文件夹下" onClick="searchFileByName()"><input type="hidden" name="act" value="">
    <%
//    if(teasession.getSession().getAttribute("sf")!=null){
//      String pichref = (String)teasession.getSession().getAttribute("sf");
//      out.print("&nbsp;&nbsp;为您查询到的图片是： <a href="+pichref+" target='_blank' title='点击查看'>"+pichref+"</a>");
//    }
    %>
  </td>
    <script type="">
    function searchFileByName(){
      if(document.getElementById("sfname").value==null || document.getElementById("sfname").value==""){
        alert("请填写文件名称");
      }
      else{
        if(document.getElementById("sfname").value.length < 6){
          alert("输入名称太短");
          return false;
        }
        document.getElementById("act").value = "searchF";
        form2.submit();
      }
    }
    function shouqi(){
        if(document.getElementById("sqTip").value=="收   起"){
          $("#sfl").slideUp(500);
          setTimeout("document.getElementById('sqTip').value='展   开';",500);
        }
        else{
           $("#sfl").slideDown(500);
          setTimeout("document.getElementById('sqTip').value='收   起';",500);
        }
      }
    </script>
</tr>
</table>
<%
if(teasession.getSession().getAttribute("sf")!=null){
      //File sfile = (File)teasession.getSession().getAttribute("sfile");
      %>
      <div style="margin-top:5">下面是您按照文件名搜索到的图片：</div><input type="button" id="sqTip" onclick="shouqi()" value="收   起"/>
      <div id="sfl">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id=tableonetr>
          <td nowrap="nowrap">序号</td>
          <td id="miniature"><%=r.getString(teasession._nLanguage, "Breviary")%></td>
          <td><%=r.getString(teasession._nLanguage, "Name")%></td>
          <td><%=r.getString(teasession._nLanguage, "Size")%></td>
          <td><%=r.getString(teasession._nLanguage, "Time")%></td>
          <td><%=r.getString(teasession._nLanguage, "operation")%></td>
        </tr>
        <%
        List list3 = (List)teasession.getSession().getAttribute("sfList");
        for(int j = 0;j < list3.size();j++){
          File sfile = (File)list3.get(j);
          int i=sfile.getName().lastIndexOf(".");
          String id=i!=-1?sfile.getName().substring(0,i):sfile.getName();//编辑用

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td width="1" nowrap><%=j+1%></td>
            <td nowrap id="miniature" style="border:1px solid #CCCCCC; width:100px; height:100px;">
              <img onerror="this.style.display='none';"  onload="if(this.width>100||this.height>100)if(this.width>this.height)this.width=100;else this.height=100;" alt="<%=sfile.getName()%>"  src="<%=type+sfile.getName()%>">
            </td>
            <td><a href="<%=type+sfile.getName()%>" target='_blank'><%=type+sfile.getName()%></a></td>
            <td><%=(int)(sfile.length()/10.24F)/100F%>K</td>
            <td><%=Entity.sdf2.format(new java.util.Date(sfile.lastModified()))%></td>
            <td>
              <input type="button" onClick="foEdit.changepic.value='<%=id%>';foEdit.changepic.focus();"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"/>
              <input type="button" class="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form2.file.value='<%=type+sfile.getName()%>'; form2.method='post'; form2.submit();}" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/>
            </td>
          </tr>
          <% }%>
        </table>
        </div>
        <%
      }
      %>
<div style="margin-top:10">下面是您按照文件夹搜索到的图片：</div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%if(fs.length>10)out.print("<tr><td colspan=5 align=left>"+new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos,fs.length,10));%>
 <tr id=tableonetr>
  <td nowrap="nowrap">序号</td>
    <td id="miniature"><%=r.getString(teasession._nLanguage, "Breviary")%></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Size")%></td>
    <td><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
if(fs!=null)
{
  for (int l = pos; l<fs.length && l<pos+10; l++)
  //for (int l = fs.length - pos; l > 0 && l<pos+10; l++)
  {
      if(fs[l].isDirectory())continue;
      String name=fs[l].getName();
      int i=name.lastIndexOf(".");
      String id=i!=-1?name.substring(0,i):name;
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td width="1" nowrap><%=l+1%></td>
        <td nowrap id="miniature" style="border:1px solid #CCCCCC; width:100px; height:100px;">
          <img onerror="this.style.display='none';"  onload="if(this.width>100||this.height>100)if(this.width>this.height)this.width=100;else this.height=100;" alt="<%=name%>"  src="<%=type+name%>">
        </td>
        <td nowrap><a href="<%=type+name%>" target="_blank" ><%=type+name%></a></td>
        <td nowrap><%=(int)(fs[l].length()/10.24F)/100F%> K</td>
        <td nowrap><%=Entity.sdf2.format(new java.util.Date(fs[l].lastModified()))%></td>
        <td nowrap><input type="button" onClick="foEdit.changepic.value='<%=id%>';foEdit.changepic.focus();"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"/>
          <input type="button" class="edit_button" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form2.file.value='<%=type+name%>'; form2.method='post'; form2.submit();}" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"/></td>
      </tr>
      <%
    }
    if(fs.length>10)out.print("<tr><td colspan=5 align=left>"+new tea.htmlx.FPNL(teasession._nLanguage, par.toString(), pos,fs.length,10));
}
%>
</table>

<script type="">
var imgs=document.getElementsByTagName("img");
if(imgs)
for(var i=1;i<imgs.length;i++)
{
  if(imgs[i].width>100||imgs[i].height>100)
  if(imgs[i].width>imgs[i].height)
  imgs[i].width=100;
  else
  imgs[i].height=100;
}
</script>
</form>
<%}%>


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
