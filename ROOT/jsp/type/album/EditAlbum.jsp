<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.pic.*"%><%response.setHeader("Cache-Control", "no-cache");

Http h=new Http(request);

String subject=null,content=null,picture=null,file="|",keywords=null,mark=null;
boolean mostly=false,mostly1=true,mostly2=true;

Node n=Node.find(h.node);
int tid=h.node,type=n.getType(),sequence=n.getSequence();
if(type==1)
{
  tid=(int)(Math.random()*-1000000);
  Category c = Category.find(h.node);
  type=c.getCategory();
  sequence=Node.getMaxSequence(h.node)+10;
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  keywords=n.getKeywords(h.language);
  picture=n.getPicture(h.language);
  file=n.getFile(h.language);
  mostly=n.isMostly();
  mostly1=n.isMostly1();
  mostly2=n.isMostly2();
  mark=n.getMark();
}
String nexturl=h.get("nexturl");

Album a=Album.find(h.node);
int eventid = h.getInt("eventid");
int meetingid = h.getInt("meetingid");
int animalid = h.getInt("animalid");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/tea/tea.js"></script>
<script type="text/javascript" src="/tea/mt.js"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<style>
img{cursor:pointer}
</style>
</head>
<body>
<h1>组图</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="/Albums.do?repository=album&attchdeleted=true&tid=<%=tid%>" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="attch"/>
<input type="hidden" name="resize" value="500"/>
<input type="hidden" name="animalid" value="<%=animalid%>" />
<input type="hidden" name="eventid" value="<%=eventid%>" />
<input type="hidden" name="meetingid" value="<%=meetingid%>" />
<input type="hidden" name="filedata" value="<%=file%>" />
<%
if(nexturl!=null)out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' />");
%>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>主题</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" alt="主题" size="50"/></td>
  </tr>
  <tr>
    <td>作者</td>
    <td><input name="author" value="<%=a.getAuthor(h.language)%>" size="50"/></td>
  </tr>
  <tr>
    <td>副标题</td>
    <td><input name="subtitle" value="<%=a.getSubtitle(h.language)%>" size="50"/></td>
  </tr>
  <tr>
    <td>新闻编辑</td>
    <td><input name="editor" value="<%=a.getEditor(h.language)%>" size="50"/></td>
  </tr>
  <tr>
    <td>关键词</td>
    <td><input name="keywords" value="<%=MT.f(keywords)%>" size="50"/></td>
  </tr>
  <tr>
    <td>来源</td>
    <td><input name="source" value="<%=a.getSource(h.language)%>" size="50"/></td>
  </tr>
  <tr>
    <td>预览图</td>
    <td><input type="file" name="picture"><%if(picture!=null)out.print(" <a href=javascript:; onclick=mt.img('"+picture+"')>查看</a>");%></td>
  </tr>
  <tr>
    <td>内容</td>
    <td>
      <textarea name="content" rows="12" cols="90"><%=MT.f(content)%></textarea>
      <script>if(mt.isIE6||location.hostname=='www.mzb.com.cn')document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
    </td>
  </tr>
  <%
  StringBuilder lid=new StringBuilder("/");
  //int cml=Listing.count(" AND type=3 AND node IN(SELECT node FROM node WHERE path LIKE '/"+c.getNode()+"/%' AND type<2 AND hidden=0) AND listing IN(SELECT listing FROM PickNode WHERE type IN(255,"+type+"))");
  //if(cml>0)//是否存在手动列举
  {
    out.print("<tr><td>"+Res.get(h.language, "一稿多投")+"</td><td nowrap><input name='listingname' size='40' readonly='true' value=\"");
    if(tid>0)
    {
      Enumeration e=Listed.findListing(h.node);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        Listing obj=Listing.find(id);
        if(!obj.isExisted())continue;
        out.println(obj.getName(h.language)+";　");
        lid.append(id).append("/");
      }
    }
    out.print("\" /> <input type='button' value='...' onclick='mt.list()' /></td></tr>");
  }
  out.print("<input type='hidden' name='listing' value='"+lid.toString()+"' />");
  %>
  <tr>
    <td>频道选项</td>
    <td>
      <span class="mostly"><input type="checkbox" name="mostly" <%if(mostly)out.print("checked");%> /><%=Res.get(h.language, "设为栏目关键")%></span>
      <span class="mostly1"><input type="checkbox" name="mostly1" <%if(mostly1)out.print("checked");%> /><%=Res.get(h.language, "设为内部")%></span>
      <span class="mostly2"><input type="checkbox" name="mostly2" <%if(mostly2)out.print("checked");%> /><%=Res.get(h.language, "设为外部")%></span>
      <%=Mark.toHtml(h.community,type,mark)%>
    </td>
  </tr>
  <tr>
    <td>顺序</td>
    <td><input name="nsequence" value="<%=sequence%>" mask="int"/></td>
  </tr>
</table>

<input type="checkbox" id="watermark" onclick="localStorage.setItem('fck.watermark',checked);"/><label for="watermark">添加水印</label>
<input type="button" id="file" value="上传图片"/>
<table id="tablecenter" cellspacing="0">
  <tr class="title">
    <td width="44"><input type="checkbox" onclick="mt.select(form1.attchs,checked)"/></td>
    <td>图片</td>
    <td>名称</td>
    <td>简介</td>
    <td>移动</td>
    <td>操作</td>
  </tr>
<%
String[] arr=file.split("[|]");
//Iterator it=AlbumList.findByNode(h.node).iterator();
//while(it.hasNext())
for(int i=1;i<arr.length;i++)
{
  Attch at=Attch.find(Integer.parseInt(arr[i]));
%
  <tr id="tr_<%=at.attch%>">
  <td><input type="checkbox" name="attchs" value="<%=at.attch%>"/></td>
  <td><img onclick="mt.img('<%=at.path2%>')" id="img_<%=at.attch%>" src="<%=at.path3%>" />
  <td><input name="name_<%=at.attch%>" value="<%=MT.f(at.name)%>"/>
  <td><textarea name="content_<%=at.attch%>" cols="40" rows="3"><%=MT.f(at.content)%></textarea>
  <td><img name="sequence" src="/tea/image/public/move2.gif" />
  <td><input type="button" value="重新上传"/><input type="file" id="file_<%=at.attch%>" name="file" onchange="mt.act('upload',<%=at.attch%>,this)" size="1" style="margin-left:-68px;width:0;filter:alpha(opacity=0);opacity:0"/></td>
<%
}
%>
  <tbody id="tb"></tbody>
<tr>
<td colspan="6"><input type="button" name="multi" value="删除" onclick="mt.act('del',0)"/></tr>
</table>

<input type="submit" value="提交" onclick="mt.act('edit',0)"/> <input type="button" value="返回" onclick="history.back();"/>
</form>




<script>
$$('watermark').checked=localStorage.getItem('fck.watermark')!='false';
mt.list=function()
{
  var rs=window.showModalDialog('/jsp/listing/SelListing.jsp?community='+form1.community.value+'&type=<%=type%>&listing='+form1.listing.value,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:420px;');
  if(!rs)return;
  var i=rs.indexOf(':');
  form1.listing.value=rs.substring(0,i);
  form1.listingname.value=rs.substring(i+1);
};

var up=new Upload($('file'));
var i_count,i_ok=0;
up.fileDialogComplete=function(numFilesSelected,numFilesQueued,numFilesInQueue)
{
  if(numFilesQueued<1)return;
  i_count=numFilesQueued;
  up.set('postParams',{'watermark':$$('watermark').checked});
  mt.show(null,0);
  up.start();
};
up.uploadSuccess=function(file,serverData,responseReceived)
{
  eval(serverData);
};
up.uploadStart=function(file)
{
  if(window.UP_INTER)clearInterval(UP_INTER);
  $('dialog_header').innerHTML="正在上传("+(++i_ok)+"/"+i_count+")";
  this.call("ReturnUploadStart",[true]);
};
up.complete=function()
{
  mt.close();
  mt.sequence(form1.attchs);
};

mt.add=function(id,img,name)
{
  var tr=document.createElement('TR');
  tr.onmouseover=function(){this.bgColor='#FFFFCA'};
  tr.onmouseout=function(){this.bgColor=''};
  tr.id='tr_'+id;
  var td=document.createElement('TD');td.innerHTML="<input type='checkbox' name='attchs' value='"+id+"' >";tr.appendChild(td);
  td=document.createElement('TD');td.innerHTML="<img src='"+img+"' />";tr.appendChild(td);
  td=document.createElement('TD');td.innerHTML="<input name='name_"+id+"' value='"+name+"' />";tr.appendChild(td);
  td=document.createElement('TD');td.innerHTML="<textarea name='content_"+id+"' cols='40' rows='3' ></textarea>";tr.appendChild(td);
  td=document.createElement('TD');td.innerHTML="<img name='sequence' src='/tea/image/public/move2.gif' />";tr.appendChild(td);
  td=document.createElement('TD');td.innerHTML="&nbsp;";tr.appendChild(td);
  $('tb').appendChild(tr);
  form1.filedata.value+=id+"|";
};

mt.act=function(a,b,c)
{
  form1.act.value=a;
  form1.attch.value=b;
  form1.action=form1.action.replace(/attchdeleted=[^&]+/,"attchdeleted="+(a=='upload'));
  if(a=='del')
  {
    if(!mt.value(form1.attchs))
    {
      mt.show("至少要选中一个！");
      return;
    }
    mt.show("确认要删除所选？",2,"var arr=form1.attchs,fd=form1.filedata;if(!arr.length)arr=[arr];for(var i=0;i<arr.length;i++){if(!arr[i].checked)continue;fd.value=fd.value.replace('|'+arr[i].value+'|','|');tr=window.$$('tr_'+arr[i].value);tr.parentNode.removeChild(tr);}");
  }else if(a=='upload')
  {
    mt.show(null,0);
    form1.submit();
  }else if(a=='edit')
  {

  }
};

//重新上传完成
mt.edit=function(a)
{
  mt.close();
  $('img_'+a).src+='?t='+new Date().getTime();

  var p=$('file_'+a).parentNode;
  p.innerHTML=p.innerHTML;
};
mt.sequence(form1.attchs);
</script>

</body>
</html>
