<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Node n=Node.find(h.node);
Video t;

Date starttime=null;
int sequence,picture=0;
String subject=null,content=null,keywords=null,mark=null;
boolean mostly=false,mostly1=true,mostly2=true;
int type=n.getType();
if(type==1)
{
  t=new Video(0,h.language);
  sequence=Node.getMaxSequence(h.node)+10;
  type=113;
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  picture=n.getPicture2(h.language);
  sequence=n.getSequence();
  starttime=n.getStartTime();
  mostly=n.isMostly();
  mostly1=n.isMostly1();
  mostly2=n.isMostly2();
  mark=n.getMark();

  t=Video.find(h.node,h.language);
}
Attch a=Attch.find(t.video);
Attch pic=Attch.find(picture);

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
</head>
<body>
<h1>添加/编辑——视频</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/Videos.do?repository=video/upload&attchpath3=548x322" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="if(mt.check(this)){addIsshowlayer();mt.show(null,0);ups[0].complete();}return false;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<%
String nexturl=h.get("nexturl");
if(nexturl!=null)out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' />");
%>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>标题</th>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="50" alt="标题"/></td>
  </tr>
  <tr>
    <th>视频</th>
    <td>
      <input type="hidden" name="video" value="<%=t.video%>" /><input readonly value="<%=MT.f(a.name)%>"class="file0" alt="视频" /><input type="button" id="_video" class="file1" value="浏览..."/>
      <%if(t.video>0)out.print("<a href='"+Video.HOST+a.path+"' target='_blank'>查看</a>");%>
    </td>
  </tr>
  <tr>
    <th>图片</th>
    <td>
      <input type="hidden" name="picture" value="<%=pic.attch%>" /><input readonly value="<%=MT.f(pic.name)%>" class="file0" /><input type="button" id="_picture" class="file1" value="浏览..."/>
<!--
      <input type="checkbox" id="_resize" onclick="up.setResize(checked)"/><label for="_resize">自动缩小图片</label>
-->
      <%if(pic.attch>0)out.print("<a href='"+Video.HOST+pic.path+"' target='_blank'>查看</a>");%>
    </td>
  </tr>
<!--
  <tr>
    <th>视频</th>
    <td>
      <input type="file" name="video"/>
      <%=t.video<1?"":Attch.f(t.video)%>
    </td>
  </tr>
  <tr>
    <th>图片</th>
    <td>
      <input type="file" name="picture"/>
      <%
      if(MT.f(picture).length()>0)
      {
        out.print("<a href='###' onclick=mt.img('"+picture+"')>查看</a>");
        out.print("<input type='checkbox' name='clearpicture' onclick='form1.picture.disabled=this.checked'>清空");
      }
      %>
    </td>
  </tr>
-->
  <tr>
    <th>顺序</th>
    <td><input name="sequence" value="<%=sequence%>" mask="int"/></td>
  </tr>
  <tr>
    <th>内容</th>
    <td>
      <input id="nonuse" type="checkbox" name="nonuse" onClick="f_editor(this)"><label for="nonuse">不使用多媒体编辑器</label><br/>
      <textarea name="content" rows="12" cols="90" class="edit_input"><%=MT.f(content)%></textarea>
      <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
    </td>
  </tr>
  <tr>
    <th>发生日期</th>
    <td><%=h.selects("starttime",starttime)%></td>
  </tr>
  <tr>
    <th>一稿多投:</th>
    <td>
  <%
  StringBuilder lid=new StringBuilder("/");
  out.print("<input name='listingname' size='40' readonly='true' value=\"");
  if(n.getType()>1)
  {
    Enumeration e=Listed.findListing(h.node);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      Listing obj=Listing.find(id);
      if(!obj.isExisted())continue;
      if(obj.getIsshowlayer(h.language)!=1){
        out.println(obj.getName(h.language)+";　");
      }
      lid.append(id).append("/");
    }
  }
  out.print("\" /> <input type='button' value='...' onclick='f_list()' />");
  out.print("<input type='hidden' name='listing' value='"+lid.toString()+"' />");
  %>
    </td>
  </tr>
  <tr>
    <th>频道选项:</th>
    <td>
      <span class="mostly"><input type="checkbox" name="mostly" id="mostly" <%if(mostly)out.print("checked");%> />设为栏目关键</span>
      <span class="mostly1"><input type="checkbox" name="mostly1" id="mostly1" <%if(mostly1)out.print("checked");%> />设为内部</span>
      <span class="mostly2"><input type="checkbox" name="mostly2" id="mostly2" <%if(mostly2)out.print("checked");%> />设为外部</span>
      <%=Mark.toHtml(h.community,type,mark)%>
    </td>
  </tr>
   <tr>
    <th>快捷显示:</th>
    <td>
    <%
    Enumeration e=Listing.find(" AND ll.isshowlayer=1 AND n.community="+DbAdapter.cite(h.community),0,100);
    while(e.hasMoreElements()){
      int i=((Integer)e.nextElement()).intValue();
      Listing listobj=Listing.find(i);%>
      <input type="checkbox" name="isshowlayer" value="<%=i %>" <%if(lid.indexOf("/"+i+"/")>=0){out.print(" checked='true' "); lid.replace(lid.indexOf("/"+i+"/"),lid.indexOf("/"+i+"/")+("/"+i+"/").length()-1 , "");}%> ><label for="isshowlayer"><%=listobj.getName(h.language) %></label>
   <%}%>
     <script type="text/javascript">
     form1.listing.value="<%=lid.toString()%>";
     </script>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>
<script>
mt.focus();
function addIsshowlayer()
{
  form1.listing.value+=mt.value(form1.isshowlayer,'|').replace(/[|]/g,'/').substring(1);
}
function f_list()
{
  var d=window.showModalDialog('/jsp/listing/SelListing.jsp?community=<%=h.community%>&type=<%=type%>&listing='+form1.listing.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:420px;');
  if(!d)return;
  eval("d="+d);
  form1.listing.value=d.listing;
  form1.listingname.value=d.name;
}
HTTP_HOST="<%=Video.HOST%>"||"http://"+location.host;
//HTTP_HOST="http://127.0.0.1";
var arr=["_video","_picture"],ups=[];
for(var i=0;i<arr.length;i++)
{
  var up=new Upload($$(arr[i]),{buttonAction:-100,fileTypes:i==0?"*.wmv;*.avi;*.dat;*.asf;*.mpeg;*.mpg;*.flv;*.f4v;*.mp4;*.3gp;*.mov;*.divx;*.dv;*.vob;*.mkv;*.qt;*.cpk;":"*.jpg;*.gif;*.png"});
  up.uploadSuccess=function(file,d,responseReceived)
  {
    var t=this.but.previousSibling.previousSibling;
    eval('d='+d.substring(d.indexOf('\n')+1));
    t.value=d.attch;
  };
  up.setResize=function(b)
  {
    this.resize=b?600:0;
    this.uploadURL=this.uploadURL.replace(/&(resize|watermark)=[^&]+/g,'')+'&resize='+this.resize;//+'&watermark='+watermark;
    this.set('uploadURL',this.uploadURL);
  };
  up.complete=function()
  {
    for(var i=0;i<ups.length;i++)
    {
      var file=ups[i].getFile();
      if(file)
      {
        ups[i].start();
        $$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB' + "　正在压缩中...";
        $$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
        return;
      }
    }
    $$('dialog_content').innerHTML="数据提交中,请稍等...";
    form1.submit();
  };
  var val=up.but.previousSibling.value;
  if(val)up.fileQueued({name:val.substring(val.lastIndexOf('/')+1)});
  ups[i]=up;
}
</script>
</body>
</html>
