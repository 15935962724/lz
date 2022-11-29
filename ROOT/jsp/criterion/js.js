function fview(obj)
{
  var a=document.getElementById("a_"+obj.name);
  if(obj.value.length>0)
  {
    a.style.display="";
    a.onclick=function faonclick(){try{window.open(obj.value);}catch(e){alert('拒绝访问.请设置‘安全级别’,把本站的加入到‘本地Intranet’.');return false;}};
    var img=document.getElementById("img_"+obj.name);
    var i=obj.value.lastIndexOf(".");
    img.src="/tea/image/other/"+obj.value.substring(i+1,obj.value.length)+".gif";
    i=obj.value.lastIndexOf("\\");
    var span=document.getElementById("span_"+obj.name);
    span.innerText=obj.value.substring(i+1,obj.value.length);
  }else
  {
    a.style.display="none";
  }
}

function f_force_grant(obj)
{
  if(!obj.checked&&confirm('文件还未上报，不能审核，需要强制批准吗？'))
  {
    obj.checked=true;
  }else
  {

  }
  try
  {
    obj.onclick();
  }catch(e)
  {}
  return obj.checked;
}
function f_force_deny(obj)
{
  if(!obj.checked&&confirm('文件已批准，不能拒绝，需要强制拒绝吗？'))
  {
    obj.checked=true;
  }else
  {

  }
  try
  {
    obj.onclick();
  }catch(e)
  {}
  return obj.checked;
}
