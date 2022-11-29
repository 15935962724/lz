
function save_image()
{
  stat.save($$('chart').get_img_binary(),"chart.png");
}

var stat={};

//JSON转TABLE
stat.table=function(str)
{
  //eval("d="+data);
  var htm="<tr id=tableonetr><td>序号<td>时间",el=data.xAxis[0].data,la=data.series;
  for(var y=0;y<la.length;y++)
  {
    htm+="<td>"+la[y].name;
  }
  for(var x=0;x<el.length;x++)
  {
    htm+="<tr><td>"+(x+1)+"<td>"+el[x];
    for(var y=0;y<la.length;y++)
    {
      var val=la[y].data[x];
      htm+="<td>"+val;
    }
  }
  return htm;
};

stat.save=function(s,n)
{
  var t=n.substring(n.lastIndexOf('.')+1);
  if(t=='csv'&&navigator.msSaveBlob)//IE10+
    navigator.msSaveOrOpenBlob(new Blob([s]),n);//下载列表
  else if(mt.isIE)
  {
    mt.post("/Imgs.do?act=chart",s);
  }else
  {
    var a=document.createElement("A");
    if(t=='csv')
      a.href='data:text/csv,'+encodeURIComponent(s);
    else
      a.href='data:image/png;base64,'+s;
    a.download=n;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  }
};

//TABLE转CSV
stat.csv=function(tab)
{
  var csv="﻿",tr=tab.getElementsByTagName('TR');
  for(var i=0;i<tr.length;i++)
  {
    var td=tr[i].children;
    for(var j=0;j<td.length;j++)
    {
      csv+='"'+td[j].innerHTML.replace(/"/g,'""')+'",';
    }
    csv+="\r\n";
  }
  return csv;
};

Date.prototype.toLocaleDateString=function()
{
  return this.getFullYear()+"-"+mt.f2(this.getMonth()+1)+"-"+mt.f2(this.getDate());
};

var time=new Date().getTime();
mt.sel1=function(b)
{
  function f(a,m){t=new Date(a);if(m)t.setMonth(m);return t.toLocaleDateString()};
  var d0=f(time),d1=f(time-86400000),bb=f(time+86400000),m1=new Date(time),m=m1.getMonth();
  var htm="<select id=fast onchange=mt.fast(value) class=sele>";
  if(!b)htm+="<option value="+d0+"—"+bb+">今天<option value="+d1+"—"+d0+">昨天<option value="+f(time-86400000*2)+"—"+d1+">前天";
  htm+="<option value="+f(time-86400000*7)+"—"+bb+">近&nbsp;7天<option value="+f(time-86400000*30)+"—"+bb+">近30天";
  m1.setDate(1);time=m1.getTime();
  htm+="<option value="+f(time)+"—"+f(time,m+1)+">本月<option value="+f(time,m-1)+"—"+f(time)+">前一月";
  htm+="</select>";
  return htm;
};

mt.fast=function(v)
{
  arr=v.split('—');
  form1.st.value=arr[0];
  form1.et.value=arr[1];
  form1.submit();
};

if(window.echarts&&window.data&&!data.yAxis)
{
  data.tooltip={trigger:'axis'};
  data.xAxis[0].boundaryGap=false;
  data.yAxis=[{}];
	//data.dataZoom={show:true,start:1,end:200};
  //
  var leg=[];
  for(var i=0;i<data.series.length;i++)leg[i]=data.series[i].name;
  data.legend={data:leg};

  data.toolbox={feature:{magicType:{type:['line','bar']},saveAsImage:{}}};
  data.grid={left:45,top:30,right:10,bottom:30};
}
