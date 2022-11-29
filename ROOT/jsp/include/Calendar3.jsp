<%@page contentType="text/html;charset=UTF-8" %>
<style>
#date_all td{color:#1A627F;background:#DEF1F8;height:20px;text-align:center;}
#date_all th{font-weight:normal;color:#000000;background:#ffffff;height:20px;text-align:center;}
#date_all thead th{background:#66CCFF;}
#date_all thead th a{color:#ffffff;}
</style>
<script>
var c=document.getElementById('calendar_title');
var cfn;
function showCalendar(fieldname,t)
{
  cfn=fieldname;
  myleft=document.body.scrollLeft+event.clientX-event.offsetX+20;
  mytop=document.body.scrollTop+event.clientY-event.offsetY;
  if(t)mytop+=t;
  if(c==null)
  {
    c=document.createElement("DIV");
    c.style.cssText="display:none; position:absolute;";
    c.id="calendar";
    c.innerHTML=("<table cellspacing=0 cellpadding=0 id='date_all'>")+
    ("  <thead><tr><th class=calendar_title01 colspan=7><span id=calendar_lastmonth><a href='javascript:f_month(-2)'>&lt;--</a></span> <span id='calendar_title'></span>  <span id=calendar_lastmonth><a href='javascript:f_month(0)'>--&gt;</a></span></th></tr></thead>")+
    ("  <tbody>")+
    ("    <tr class=currentmonth01><th class=day0>日</th><th>一</th><th>二</th><th>三</th><th>四</th><th>五</th><th class=day6>六</th></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td><td id=day></td></tr>")+
    ("    <tr><td align='left' style='height:20px;background:#66CCFF;color:#fff;text-align:right;padding-right:3px;text-decoration:none;'><a style='color:#fff;' href='javascript:f_clear()'>清空</a></td><td colspan='6' align='right' style='height:20px;width:143px;background:#66CCFF;color:#fff;text-align:right;padding-right:3px;text-decoration:none;'><a style='color:#fff;' href='javascript:f_close()'>关闭窗口</a></td></tr>")+
    ("  </tbody>");
    ("</table>");
    document.body.appendChild(c);
    f_month(0);
  }
  c.style.display="";
  c.style.left=myleft;
  c.style.top=mytop;
}

var n=new Date();
function f_month(i)
{
  n.setMonth(n.getMonth()+i);
  var cm=n.getMonth();
  var cy=n.getYear();
  var m0=(cm<9)?'0':'';
  var ct=document.getElementById('calendar_title');
  ct.innerHTML=cy+'年'+m0+(cm+1)+'月';

  n.setDate(1);
  var dow=n.getDay();
  var day=document.all('day');
  var ccn=new Date().getTime();
  for (var i=0;i<41;i++)
  {
    var dt='&nbsp;';
    day[i].onclick=null;
    day[i].style.cssText="color:#A9A9A9;";
    day[i].onmouseover=null;
    day[i].onmouseout=null;
    if ((i<dow)||(cm!=n.getMonth()))
    {
    }else
    {
      dt=n.getDate();
      n.setDate(dt+1);
      day[i].date=cy+'-'+m0+(cm+1)+'-'+(dt<10?'0':'')+dt;

        day[i].style.cssText="color:#1A627F;cursor:hand";
        day[i].onmouseover=function(){this.bgColor='#BCD1E9';};
        day[i].onmouseout=function(){this.bgColor='';};
        day[i].onclick=function()
        {
          cfn.value=this.date;
          f_close();
        }

    }
    day[i].innerHTML='<b>'+dt+'</b>';
  }
    //n.setMonth(month);
}
function f_close()
{
  c.style.display="none";
}
function f_clear()
{
  cfn.value="";
}
</script>
