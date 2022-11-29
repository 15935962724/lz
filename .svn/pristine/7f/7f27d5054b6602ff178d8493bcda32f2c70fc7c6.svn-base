<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<title>日历</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
<style>
<!--
A:link    { color: #013567; TEXT-DECORATION: none;}
A:visited { COLOR: #013567; TEXT-DECORATION: none}
A:active  { COLOR: #3333ff; TEXT-DECORATION: none}
A:hover   { COLOR: #ff0000; TEXT-DECORATION: none}

table { font-size: 9pt;}
body { font-size: 9pt;}
.bodycolor { BACKGROUND: #ffffff}
.lantable {
	border: 1px solid #336699;
}
.td1[ width:100%;background-color: #EFEFEF;}
.huiditable {
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 1px;
	border-left-width: 0px;
	border-bottom-style: solid;
	border-top-color: #eeeeee;
	border-right-color: #eeeeee;
	border-bottom-color: #eeeeee;
	border-left-color: #eeeeee;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;font-size:9pt;
}

.landitable {
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 1px;
	border-left-width: 0px;
	border-bottom-style: solid;
	border-top-color: #eeeeee;
	border-right-color: #eeeeee;
	border-bottom-color: #336699;
	border-left-color: #eeeeee;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;
}

.small  { font-size: 9pt;}
.big    { font-size: 9pt;}
.big1   { font-size: 9pt;}
.big2   { font-size: 18pt}
.verybig{ font-size: 24pt}

.9p {  font-size: 9pt; line-height: 15pt;color: #000000}


.9phong {  font-size: 9pt; line-height: 12pt;color: #ff0000}


.9phui {  font-size: 9pt; line-height: 15pt;color: #666666}


.9pzong {  font-size: 9pt; line-height: 15pt;color: #663300}



.9pbai {  font-size: 9pt; line-height: 12pt;color: #ffffff}


.9pbai1 { font-size: 9pt;color: #ffffff; line-height: 12pt;}



.9plan {  font-size: 9pt; line-height: 20pt;color: #6ccdf2}


.9plv {  font-size: 9pt; line-height: 15pt;color: #00cc00}


.10p {  font-size: 10pt; line-height: 15pt;color: #000000}


.10phong {  font-size: 10pt; line-height: 15pt; color: #cc0000}


.10phui {  font-size: 10pt; line-height: 15pt;color: #666666}


.10pbai {  font-size: 10pt; line-height: 15pt;color: #ffffff}

A.9p:visited {text-decoration:none;color: #000000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9p:link {text-decoration:none;color: #000000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9p:hover {text-decoration:none;color: #000000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}


A.9phui:visited {text-decoration:none;color: #666666;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9phui:link {text-decoration:none;color: #666666;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9phui:hover {text-decoration:none;color: #666666;line-height: 12pt;font-size: 9pt;vertical-align:middle;}

A.9plan:visited {text-decoration:none;color: #6CCDF2;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9plan:link {text-decoration:none;color: #6CCDF2;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9plan:hover {text-decoration:none;color: #6CCDF2;line-height: 12pt;font-size: 9pt;vertical-align:middle;}

A.9pshenlan:visited {text-decoration:none;color: #022056;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9pshenlan:link {text-decoration:none;color: #022056;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9pshenlan:hover {text-decoration:none;color: #022056;line-height: 12pt;font-size: 9pt;vertical-align:middle;}

A.9phong:visited {text-decoration:none;color: #ff0000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9phong:link {text-decoration:none;color: #ff0000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}
A.9phong:hover {text-decoration:none;color: #ff0000;line-height: 12pt;font-size: 9pt;vertical-align:middle;}

A.10phong:visited {text-decoration:none;color: #ff0000;line-height: 15pt;font-size: 10pt;vertical-align:middle;}
A.10phong:link {text-decoration:none;color: #ff0000;line-height: 15pt;font-size: 10pt;vertical-align:middle;}
A.10phong:hover {text-decoration:none;color: #ff0000;line-height: 15pt;font-size: 10pt;vertical-align:middle;}


input.SmallButton{ font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}
input.BigButton  { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}


input.SmallInput { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}
input.SmallInput1{ font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}

input.BigInput   { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;}

input.BigInputMoney { text-align: RIGHT; font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}

input.SmallStatic{ font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}

input.BigStatic  { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}


select.BigSelect  { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;}
select.SmallSelect{ font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}
select.BigStatic  { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  CURSOR: hand;  TEXT-DECORATION: none}
select.SmallStatic{ FONT-FAMILY: ??ì?,MS SONG,SimSun,tahoma,sans-serif; COLOR: #000066; BACKGROUND: #E0E0E0; border:1 solid black; FONT-SIZE: 9pt; FONT-STYLE: normal; FONT-VARIANT: normal; FONT-WEIGHT: normal; HEIGHT: 18px; LINE-HEIGHT: normal}


textarea.BigInput { font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;resize:auto;overflow:autoscroll;height:90px}
textarea.BigStatic{ font-size: 9pt; background-color: #EFEFEF; border: 1 solid #336699;height:18px;  TEXT-DECORATION: none}


.TableControl{ BACKGROUND: #ffffff;}
.TableHeader { BACKGROUND: #ffffff;}
.TableContent{ BACKGROUND: #ffffff;}
.TableData   {BACKGROUND: #ffffff; }
.TableLine1  { BACKGROUND: #ffffff;border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 1px;
	border-left-width: 0px;
	border-bottom-style: solid;
	border-top-color: #eeeeee;
	border-right-color: #eeeeee;
	border-bottom-color: #eeeeee;
	border-left-color: #eeeeee;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;font-size:9pt;}
.TableLine2  { BACKGROUND: #FFFFFF;border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 1px;
	border-left-width: 0px;
	border-bottom-style: solid;
	border-top-color: #eeeeee;
	border-right-color: #eeeeee;
	border-bottom-color: #eeeeee;
	border-left-color: #eeeeee;
	border-top-style: solid;
	border-right-style: solid;
	border-left-style: solid;font-size:9pt;}
.TableContent1{ BACKGROUND: #efefef;}.bannertable {
	background-image: url(../images/logo2.gif);
	background-repeat: no-repeat;
	background-position: left top;
}

-->
</style>
<%
long l5 = System.currentTimeMillis();
Date date = new Date(l5);
Calendar calendar = Calendar.getInstance();
calendar.setTime(date);


int CUR_YEAR = calendar.get(1);
int CUR_MON  = calendar.get(2) + 1;
int CUR_DAY = calendar.get(5) ;

int YEAR=CUR_YEAR;
String tmp=request.getParameter("year");
if(tmp!=null)
{
  YEAR=Integer.parseInt(tmp);
}

int MONTH=CUR_MON;
tmp=request.getParameter("month");
if(tmp!=null)
{
  MONTH=Integer.parseInt(tmp);
}

String field=request.getParameter("FIELDNAME");


%>

<script language="JavaScript">

function doCal()
{
  n=new Date();
  cm="<%=MONTH%>";

  n.setFullYear("<%=YEAR%>");
  n.setMonth(cm-1);

  writeMonth(n);
}

function set_year(op)
{
  if(op==-1 && document.form1.YEAR.selectedIndex==0)
     return;
  if(op==1 && document.form1.YEAR.selectedIndex==(document.form1.YEAR.options.length-1))
     return;

  document.form1.YEAR.selectedIndex=document.form1.YEAR.selectedIndex+op;

  yr=document.form1.YEAR.value;
  cm=document.form1.MONTH.value;
  doOther(yr,cm);
}

function set_mon(op)
{
  if(op==-1 && document.form1.MONTH.selectedIndex==0)
     return;
  if(op==1 && document.form1.MONTH.selectedIndex==(document.form1.MONTH.options.length-1))
     return;

  document.form1.MONTH.selectedIndex=document.form1.MONTH.selectedIndex+op;

  yr=document.form1.YEAR.value;
  cm=document.form1.MONTH.value;
  doOther(yr,cm);
}

function doOther(yr,cm)
{
  n=new Date();
  n.setFullYear(yr);
  n.setMonth(cm-1);
  writeMonth(n);
}

function writeMonth(n)
{
  yr=document.form1.YEAR.value;
  cm=document.form1.MONTH.value;
  n.setDate(1);
  dow=n.getDay();
  moy=n.getMonth();
  var day=document.all("day");
  for (var i=0;i<41;i++)
  {
    if ((i<dow)||(moy!=n.getMonth()))
    {
      dt="&nbsp;";
      day[i].onclick=null;
    }else
    {
      dt=n.getDate();
      n.setDate(n.getDate()+1);

      eval("day[i].onclick=function(){        yr=document.form1.YEAR.value;        cm=document.form1.MONTH.value;        if(cm<10)cm='0'+cm;    var dt="+dt+";    if(dt<10)dt='0'+dt;        date_str=yr+'-'+cm+'-'+dt;      window.returnValue=date_str;         window.close();      };");

      if(dt==<%=CUR_DAY%>&&cm==<%=CUR_MON%>&&yr==<%=CUR_YEAR%>)
      {
        dt="<font color=red>"+dt+"</font>";
      }
    }
    day[i].innerHTML="<b>"+dt+"</b>";
  }
}

var parent_window = window.dialogArguments;

function setPointer(theRow, thePointerColor)
{
  if(theRow.innerHTML.indexOf("<")!=-1)
   theRow.bgColor = thePointerColor;
}

function thisMonth()
{
   document.form1.YEAR.selectedIndex=(<%=CUR_YEAR%>-1930);
   document.form1.MONTH.selectedIndex=(<%=CUR_MON%>-1);
   doCal();
}
</script>
</head>

<body class="bodycolor" onload="doCal();" topmargin="0" leftmargin="0" >
<form action="#"  method="post" name="form1">
<table width="100%" border="0" cellspacing="1" class="small" bgcolor="#000000" cellpadding="3" align="center">
  <tr align="center" class="bodycolor">
    <td colspan="7" class="big1">
      <!-------------- 年 ------------>
        <input type="button" value="&laquo;"  style="height:20;position: relative;top:-1;left:-1" class="SmallButton" title="上一年" onclick="set_year(-1);"><select name="YEAR" class="SmallSelect" onchange="set_year(0);">
<%
        for(int I=1930;I<=2050;I++)
        {
%>
          <option value="<%=I%>" <% if(I==YEAR)  out.print("selected");%>><%=I%></option>
<%
        }
%>
        </select>
        <input type="button" value="&raquo;" style="height:20;position: relative;top:-1;" class="SmallButton" title="下一年" onclick="set_year(1);"> <b>年</b>

<!-------------- 月 ------------>
        <input type="button" value="&laquo;"  style="height:20;position: relative;top:-1;left:-1" class="SmallButton" title="上一月" onclick="set_mon(-1);">
        <select name="MONTH" class="SmallSelect" onchange="set_mon(0);">
<%
        for(int I=1;I<=12;I++)
        {
%>
          <option value="<%=I%>" <% if(I==MONTH)  out.print("selected");%>><%=I%></option>
<%
        }
%>
        </select><input type="button" value="&raquo;" style="height:20;position: relative;top:-1;" class="SmallButton" title="下一月" onclick="set_mon(1);"> <b>月</b>

    </td>
  </tr>
  <tr align="center" class="TableHeader">
    <td width="14%" bgcolor="#FFCCFF"><b>日</b></td>
    <td width="14%"><b>一</b></td>
    <td width="14%"><b>二</b></td>
    <td width="14%"><b>三</b></td>
    <td width="14%"><b>四</b></td>
    <td width="14%"><b>五</b></td>
    <td width="14%" bgcolor="#CCFFCC"><b>六</b></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" ></td>
    <td width="14%" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')" onclick="thisMonth();"><b>本月</b></td>
  </tr>
</table>
</form>

</body>
</html>
