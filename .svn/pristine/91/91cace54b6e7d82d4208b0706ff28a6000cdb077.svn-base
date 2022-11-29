
function im_refresh(flag)
{
  var to=form1.tmember.value;
  if(form1.tmember.length>0)
  {
    for(var i=0;i<form1.tmember.length;i++)
    {
      if(form1.tmember[i].checked)
      {
        to=form1.tmember[i].value;
      }
    }
  }
  var url=form1.action+"?act=ajax&community="+form1.community.value+"&tmember="+encodeURIComponent(to);
  if(flag)//发送内容
  {
    var v;
    try
    {
      v=editor.body.innerHTML;
      editor.body.innerHTML="";
    }catch(ex)
    {
      v=form1.content.value.replace("<","&lt;");
      form1.content.value="";
      form1.content.focus();
    }
    url=url+"&content="+encodeURIComponent(v);
  }
  sendx(url,im_rs);
  return false;
}
function im_rs(data)
{
  var len=data.length;
  if(len>0)
  {
    var i=data.indexOf("<script>");
    if(i!=-1)
    {
      eval(data.substring(i+8));
      data=data.substring(0,i);
    }
    var obj=document.getElementById("history");
    obj.innerHTML=obj.innerHTML+data;
    //self.scrollBy(0,10240);
    obj.scrollTop=obj.scrollHeight;
  }
}

function im_load()
{
  im_refresh();
  setInterval(im_refresh,2000);
  try
  {
    form1.content.focus();
  }catch(ex)
  {}
}

function im_open(url,width,height)
{
  window.open(url,'im_dialog','width='+width+',height='+height);
}
function im_swap(id,url)
{
  var obj=document.getElementById(id);
  obj.src=url;
}

function im_add(from,h)
{
  var ts=document.getElementsByName('tmember');
  if(ts.length>0&&ts[0].type!="hidden")
  {
    for(var i=0;i<ts.length;i++)
    {
      if(ts[i].value==from)
      return;
    }
    var p=ts[0].parentNode;
    p.innerHTML=p.innerHTML+h+"<br>";
  }
}

function im_save()
{
  var obj=document.getElementById("history");
  var code_win = window.open('about:blank','_blank','top=10000');
  try
  {
    code_win.document.open();
    code_win.document.write('<html><head><base target="_blank">'+'</head><body></body></html>');
    code_win.document.write(obj.innerHTML);
    code_win.document.close();
    code_win.document.execCommand('saveas','','edn.htm');
    code_win.close();
  }catch(e)
  {
    if(code_win!=null)code_win.close();
  }
}

function im_left(img)
{
  var obj=document.getElementById("LeftContent").style;
  if(obj.display=="none")
  {
    obj.display="";
  }else
  {
    obj.display="none";
  }
  var url=img.src;
  img.src=img.swap;
  img.swap=url;
}
