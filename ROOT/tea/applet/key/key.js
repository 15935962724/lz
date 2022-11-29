
function Key()
{
  var key=document.createElement("object");
  key.id="key";
  key.classid="clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E";
  key.codebase="/tea/applet/key/HTActX.CAB#version=1,0,0,1";
  key.style.display="none";
  document.body.appendChild(key);

  //document.write("<OBJECT id=key classid=clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E codebase=/tea/applet/key/HTActX.CAB#version=1,0,0,1 style=display:none></OBJECT>");
  //var key=document.getElementById("key");

  this.getSerialNum=function(obj)
  {
    //var ver = key.GetLibVersion();
    //alert(ver);
    var sn=null;
    try
    {
      var hCard=key.OpenDevice(1);//打开设备
      sn=key.GetSerialNum(hCard);
      key.CloseDevice(hCard);
    }catch(e)
    {
    }
    if(obj)
    {
      if(sn)
      {
        obj.value=sn;
      }else
      {
        alert('出现错误: 没有找到Key.');
      }
    }
    return sn;
  }
  this.check=function(v)
  {
    if(v&&v!="null")
    {
      window.status="正在验Key...";
      try
      {
        var sn=this.getSerialNum();
        if(!sn)
        {
          alert('出现错误:请确认Key是否已插上.');
          return false;
        }
        if(sn!=v)
        {
          alert('请插入正确的Key');
          return false;
        }
      }catch(e)
      {
        alert('出现错误:请确认Key是否已插上.');
        return false;
      }finally
      {
        window.status="";
      }
    }
    return true;
  }
}
