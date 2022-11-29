
function f_reading()
{
  if(!confirm('是否确定阅闭？'))return;
  window.open("/servlet/EditFlowdynamicvalue?act=reading&nexturl="+encodeURI(form1.nexturl.value)+"&flowview="+form1.flowview.value,'_self');
}

//切换
function f_swap(i)
{
  var a=$name('a_swap'),t=$name('t_swap');
  for(var j=0;j<a.length;j++)
  {
    a[j].className='';
    t[j].style.display='none';
  }
  a[i].className='swap';
  t[i].style.display='';
}


//xny
var xny=new Object()
xny.code=function(i)
{
window.showModalDialog('/jsp/admin/xny/SetFlowbusinessSN.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+i+'&code='+encodeURIComponent(eval('form1.dynamictype'+i).value)+'&t='+new Date().getTime(),self,'dialogWidth:350px;dialogHeight:105px;resizable:1;help:0;status:0;');
}
