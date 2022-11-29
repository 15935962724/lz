<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.entity.*"%><%@ page import="tea.entity.node.*"%><%@ page import="tea.ui.TeaSession"%><%

Http h=new Http(request);
int node=h.getInt("node");
Stock s=Stock.find(node);


boolean hk=s.prefix.equals("hk");
String q=(hk?"r_":"")+s.prefix+s.code;

%>
//<script>
document.write("<scr"+"ipt id='rqt' src='http://qt.gtimg.cn/r=1400011324071132&q=<%=q%>'></scr"+"ipt>");
function f_ref_<%=node%>()
{
  if(typeof(v_<%=q%>)=='undefined')
  {
    setTimeout("f_ref_<%=node%>()",200);
    return;
  }
  var arr=v_<%=q%>.split('~');
  var f=new Array();
  f[3]="price";//当前价
  f[32]="change";//涨跌幅
  f[30]="date";
  f[4]="closing";//昨 收
  f[5]="opening";//今 开
  f[33]="high";//最 高
  f[34]="low";//最 低
  f[36]="volume";//成交量//以前是6
  f[44]="market";//市 值
  f[43]="amplitude";//幅
  f[39]="pe";//市盈率
  f[37]="turnover";//成交额
  arr[30]=arr[30].replace(/[-/ :]/g,"");

  if("<%=q%>".indexOf("hk"))
  {
    f[47]='dividend';//周息率(%)
    f[48]='h52w';//52周最高
    f[49]='l52w';//52周最低
  }else
  {
    f[47]="daily";//涨停价
    f[48]="down";//跌停价
    f[38]="handover";//换手率
  }

//  for(var i=0;i<arr.length;i++)
//  {
//    document.write("<!--"+i+"、"+arr[i]+" -->\n");
//  }
  <%
  if(q.startsWith("r_"))q=q.substring(2);
  %>
  for(var i=0;i<f.length;i++)
  {
    var tmp=document.getElementById('<%=q%>_'+f[i]);
    if(!tmp)continue;
    if(i==3)arr[i]="<font color='#"+(parseFloat(arr[32])>=0?"FF0000":"00FF00")+"'>"+arr[i]+"</font>"
    else if(i==44)arr[i]+="亿";
    else if(i==36)
    {
      arr[i]=(parseInt(arr[i])/10000).toFixed(2);
      arr[i]+="<%=q%>".indexOf("hk")==0?"万股":"万手";
    }else if(i==37)
    {
      if("<%=q%>".indexOf("hk")==0)arr[i]=(parseInt(arr[i])/10000).toFixed(2);
      arr[i]+="万";
    }else if(i==38||i==43||i==32)arr[i]+="%";
    else if(i==30)arr[i]=arr[i].substring(0,4)+"-"+arr[i].substring(4,6)+"-"+arr[i].substring(6,8)+" "+arr[i].substring(8,10)+":"+arr[i].substring(10,12)<%=s.prefix.equals("hk")?"":"+':'+arr[i].substring(12)"%>;//H股，没有秒
    tmp.innerHTML=arr[i];
  }
  var tmp=document.getElementById('<%=q%>_handicap');
  if(tmp)
  {
    tmp=tmp.firstChild.getElementsByTagName("TD");
    var i=0;
    for(var j=0;j<10;i++)
    {
      if(i%3==0)continue;
      tmp[i].innerHTML="　"+arr[29-j-(j%2==0?2:0)];
      j++;
    }
    i+=3;
    tmp[i-2].innerHTML="　"+arr[3];
    for(var j=0;j<10;i++)
    {
      if(i%3==0)continue;
      tmp[i].innerHTML="　"+arr[9+j];
      j++;
    }
  }
  var rqt=document.getElementById('rqt');
  rqt.src=rqt.src.replace(/r=\d+&/,"r="+new Date().getTime()+"&");
}
f_ref_<%=node%>();
setInterval("f_ref_<%=node%>()",10000);

//</script>

<%--
<script src="http://hq.sinajs.cn/list=sh601818"></script>
<table>
<script>
var arr=hq_str_sh601818.split(',');
var h="";
h+="<tr><td>名称<td>"+arr[0];
h+="<tr><td>今日开盘价<td>"+arr[1];
h+="<tr><td>昨日收盘价<td>"+arr[2];
h+="<tr><td>当前价格<td>"+arr[3];
h+="<tr><td>今日最高价<td>"+arr[4];
h+="<tr><td>今日最低价<td>"+arr[5];
h+="<tr><td>买一<td>"+arr[6];
h+="<tr><td>卖一<td>"+arr[7];
h+="<tr><td>成交的股票数<td>"+arr[8];
h+="<tr><td>成交金额<td>"+arr[9];
h+="<tr><td>买1<td>"+arr[10];
h+="<tr><td>买1<td>"+arr[11];
h+="<tr><td>买2<td>"+arr[12];
h+="<tr><td>买2<td>"+arr[13];
h+="<tr><td>卖1<td>"+arr[20];
h+="<tr><td>卖1<td>"+arr[21];
h+="<tr><td>卖2<td>"+arr[22];
h+="<tr><td>卖2<td>"+arr[23];
h+="<tr><td>日期<td>"+arr[30]+" "+arr[31];
document.write(h);
</script>
</table>
--%>
