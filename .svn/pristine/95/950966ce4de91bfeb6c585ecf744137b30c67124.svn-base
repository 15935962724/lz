<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);


int tab=h.getInt("tab",1);

%>

<form name="form1" action="?">
<input type="hidden" name="tab" value="<%=tab%>"/>
</form>

<form name="form2" action="/Smokes.do?repository=smoke/<%=Seq.SDF.format(new Date())%>" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check2(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="<%=tab%>"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl" value="location.reload()"/>

<%
out.print("<div class='switch'>");
for(int i=1;i<Smoke.SMOKE_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"' id='a"+i+"'>"+(i==1?"发表":"上传")+Smoke.SMOKE_TYPE[i]+"</a>");
}
out.print("</div>");
%>
<div class="upload">
	<span style="float:left;"><%=(tab==1?"发表":"上传")+Smoke.SMOKE_TYPE[tab]%></span><span style="float:right;"><input value="重填" type="reset" /></span>
</div>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="td01">姓名：</td>
    <td><input name="name" alt="姓名"/></td>
  </tr>
  <tr>
    <td class="td01">身份证号：</td>
    <td><input name="idcard" alt="身份证号"/><img src="/res/tobacco/structure/14050099.png" style="position:relative;top:8px;left:4px;" />  请填写您真实有效的身份证号</td>
  </tr>
  <tr>
    <td class="td01">地址：</td>
    <td><input name="address" size="50" alt="地址"/></td>
  </tr>
  <tr>
    <td class="td01">手机号：</td>
    <td><input name="mobile" alt="手机号"/><img src="/res/tobacco/structure/14050099.png" style="position:relative;top:8px;left:4px;" />  请填写您有效手机号，以便能及时联系到您</td>
  </tr>
<%
if(tab==1)
{
  for(int i=0;i<10;i++)
  {
  %>
<tbody style="<%=i==0?"":"display:none"%>">
  <tr>
    <td class="td01">发表文字：</td>
    <td><font color="#FF0000">注：如您有多个参赛作品，请逐个投稿。同一参赛作品不要重复投稿。</font><br /><textarea name="content" cols="50" rows="5" onpropertychange="onblur()" oninput="onblur()" onblur="mt.len(this,500)" alt="内容"></textarea><div><span>还能输入</span><b>500</b>字</div><%if(i>0)out.print("<a href='javascript:;' onclick='mt.tdel(this)' class='deletes'>删除</a>");%></td>
  </tr>
  <tr>
    <td class="td01">选择类型：</td>
    <td class="td_02" valign="middle"><%=h.radios(Smoke.MATTER_TYPE[1],"matter"+i,1)%></td>
  </tr>
</tbody>
<%
  }
  %>
  <tr>
    
    <td align="center" colspan="2"><a href="javascript:mt.tadd()"  style="font-size:14px;color:#d20000;"><img src="/res/tobacco/structure/14050098.png" style="position:relative;right:10px;top:5px;" />点击添加作品</a></td>
  </tr>
  <%
}else if(tab==2)
{%>
  <tr>
    <td class="td01" valign="top">上传图片：</td>
    <td><span style="line-height:27px;">可以涉及海报、照片、创意图画、动态图画等多种形式，作品格式为JPG、GIF、PNG，数据文件10M以内</span>
<table>
<%
for(int i=0;i<10;i++)
{
%>
<tbody style="<%=i==0?"":"visibility:hidden"%>">
  <tr>
    <td valign="top" width="130"><input type="hidden" name="attch" /><input readonly class="file0" alt="图片" /><input type="button" name="browse" class="file1" value="选择文件"/></td>
    <td><textarea name="content" cols="50" rows="5" onkeypress="onchange()" oninput="onchange()" onchange="mt.len(this,100)" placeholder="图片说明..."></textarea><div><span>还能输入</span><b>100</b>字</div><%if(i>0)out.print("<a href='javascript:;' onclick='mt.tdel(this)' class='deletes'>删除</a>");%></td>
  </tr>
  <tr>
    <td>选择类型：</td>
    <td class="td_03"><%=h.radios(Smoke.MATTER_TYPE[2],"matter"+i,1)%></td>
  </tr>
</tbody>
<%
}
%>
</table>
    <a href="javascript:mt.tadd()" style="position:relative;left:165px;font-size:14px;color:#d20000;"><img src="/res/tobacco/structure/14050098.png" style="position:relative;right:10px;top:5px;" />点击添加作品</a>
    </td>
  </tr>
<%
}else if(tab==3)
{%>
  <tr>
    <td class="td01" valign="top">上传视频：</td>
    <td> <span style="line-height:27px;">视频格式为MPEG、AVI、MOV、MP4、FLV等,数据文件大小在300M以内</span>
<table>
<%
for(int i=0;i<10;i++)
{
%>
<tbody style="<%=i==0?"":"visibility:hidden"%>">
  <tr>
    <td valign="top" width="130"><input type="hidden" name="attch" /><input readonly class="file0" alt="视频" /><input type="button" name="browse" class="file1" value="选择文件"/></td>
    <td><textarea name="content" cols="50" rows="5" onkeypress="onchange()" oninput="onchange()" onchange="mt.len(this,100)" placeholder="视频说明..."></textarea><div><span>还能输入</span><b>100</b>字</div><%if(i>0)out.print("<a href='javascript:;' onclick='mt.tdel(this)' class='deletes'>删除</a>");%></td>
  </tr>
  <tr>
    <td>选择类型：</td>
    <td class="td_03"><%=h.radios(Smoke.MATTER_TYPE[3],"matter"+i,1)%></td>
  </tr>
</tbody>
<%
}
%>
</table>
    <a href="javascript:mt.tadd()" style="position:relative;left:165px;font-size:14px;color:#d20000;"><img src="/res/tobacco/structure/14050098.png" style="position:relative;right:10px;top:5px;" />点击添加作品</a>
    </td>
  </tr>
<%}%>
</table>


<br/>
<p style="width:717px;text-align:center;padding-bottom:15px;height:42px;float:left;display:block;"><input type="submit" value="提交" style="background:url(/res/tobacco/structure/14050100.png) center no-repeat;color:#fff;font-size:25px;cursor:pointer;border:none;width:240px;height:42px;p"/></p>
</form>

<script>
form2.ups=[];
var arr=form2.browse||[];
for(var i=0;i<arr.length;i++)
{
//  arr[i].onmouseover=function()
//  {
//    console.log(123);
//  };
  var up=new Upload(arr[i],{buttonAction:-100,fileTypes:"<%=tab==2?"*.jpg;*.gif;*.png":"*.wmv;*.avi;*.dat;*.asf;*.mpeg;*.mpg;*.flv;*.mp4;*.3gp;*.mov;*.divx;*.dv;*.vob;*.mkv;*.qt;*.cpk;"%>",fileSizeLimit:"<%=tab==2?10:300%> MB"});
  up.uploadSuccess=function(file,d,responseReceived)
  {
    var t=this.but.previousSibling.previousSibling;
    eval('d='+d.substring(d.indexOf('\n')+1));
    t.value=d.attch;
  };
  up.complete=function()
  {
    for(var i=0;i<form2.ups.length;i++)
    {
      if(mt.ftr(form2.ups[i].but).parentNode.style.display=='none')continue;
      var file=form2.ups[i].getFile();
      if(file)
      {
        form2.ups[i].start();
        $$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB';
        $$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
        return;
      }
    }
    $$('dialog_content').innerHTML="数据提交中,请稍等...";
    form2.submit();
  };
  form2.ups.push(up);
}
if(arr.length>0)
{
  var tb=form2.getElementsByTagName('TBODY');
  for(var i=2;i<tb.length;i++)
  {
    tb[i].style.display='none';
  }
}
mt.len=function(fc,v)
{
  var len=v-fc.value.length,info=fc.nextSibling;
  var arr=info.childNodes;
  arr[0].innerHTML=len<0?"已经超过":"还能输入";
  arr[1].innerHTML=Math.abs(len);
  arr[1].style.color=len<0?"red":"";
  fc.info=len<0?info.innerHTML:null;
};
var seq=2;
mt.tadd=function()
{
//  var te=$$('template'),ran=Math.random();
//  var es=te.cloneNode(true);
//  var arr=es.getElementsByTagName("*");
//  for(var i=0;i<arr.length;i++)
//  {
//    if(arr[i].type=='textarea')arr[i].value='';
//    if(arr[i].type=='radio')arr[i].id=arr[i].id.replace('matter',ran);
//    if(arr[i].tagName=='LABEL')arr[i].setAttribute('for',arr[i].getAttribute('for').replace('matter',ran));
//  }
//  te.parentNode.appendChild(es);
  var tb=form2.getElementsByTagName('TBODY');
  tb[seq++].style.cssText='';
};

mt.tdel=function(a)
{
  a=mt.ftr(a).parentNode;
  a.style.display='none';
  //a.parentNode.removeChild(a);
  var arr=a.getElementsByTagName("*");
  for(var i=0;i<arr.length;i++)arr[i].value='';
};

if(mt.isIE)
{
  var fc=form2.elements;
  for(var i=0;i<fc.length;i++)
  {
    if(!fc[i].placeholder)continue;
    fc[i].title=fc[i].placeholder
    mt.title(fc[i]);
  }
}

mt.check2=function(f)
{
  if(!mt.check(f))return false;
  var arr=f.content;
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].info)
    {
      mt.show("抱歉，"+arr[i].info+"！");
      return false;
    }
  }
  mt.show(null,0);
  if(form2.ups.length>0)
    form2.ups[0].complete();
  else
    form2.submit();
  return false;
};
</script>
