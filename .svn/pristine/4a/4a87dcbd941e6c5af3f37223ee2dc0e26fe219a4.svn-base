
mt.upload=function(but)
{
  var tmp=but.form.action;
  but.form.action='/Imgs.do?repository='+but.form.repository.value+'&flash=true';
  //儿童网 要求200m
  up=new Upload(but,{fileSizeLimit:'200 MB',fileTypes:'*.*'});
  but.form.action=tmp;
  up.submit=but.form.onsubmit;
  up.fileQueued=function(f)
  {
    var tb=this.but;
    while(tb.tagName!='TABLE')tb=tb.nextSibling;
    tb=tb.firstElementChild||tb.firstChild;

    var tr=document.createElement("TR");
    tb.appendChild(tr);

    var td=document.createElement("TD");
    td.innerHTML="<img src='/tea/image/netdisk/"+f.type.substring(1).toLowerCase()+".gif' width='16' align='top'>&nbsp;"+f.name;
    tr.appendChild(td);

    td=document.createElement("TD");
    td.innerHTML=mt.f(f.size/1024,2)+" K";
    td.align="right";
    tr.appendChild(td);

    td=document.createElement("TD");
    td.innerHTML="<div style='border:1px solid #B2B2B2;width:100px;'><div id='"+f.id+"' style='background-color:#00D328;width:0%;height:15px'></div></div>";
    tr.appendChild(td);

    td=document.createElement("TD");
    td.innerHTML="<a href=javascript:; onclick=up.del(this,'"+f.id+"')><img src='/tea/image/public/del2.gif' width='10' /></a>";
    tr.appendChild(td);
  };
  up.fileDialogComplete=function(a,b,c)
  {
    if(b!=c||b==0)return;
    this.but.form.onsubmit=function(){mt.show('附件上传中，暂不可提交！');return false;};
    this.start();
  };
  up.del=function(a,id)
  {
    if(id)up.cancel(id);
    a=a.parentNode.parentNode;
    a.parentNode.removeChild(a);
  };
  up.uploadProgress=function(f,b,t)
  {
    if(!t)return;
    $(f.id).style.width=b*100/f.size;
  };
  up.uploadSuccess=function(f,d,responseReceived)
  {
    $(f.id).parentNode.parentNode.innerHTML="<input type='hidden' name='attach' value='"+d.substring(d.indexOf('\n')+1)+"'><input type='hidden' name='attachName' value='"+f.name+"'>";
  };
  up.complete=function()
  {
    this.but.form.onsubmit=up.submit;
  };
};
