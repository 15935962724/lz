<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>日历</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
<%
  long l5 = System.currentTimeMillis();
  Date date = new Date(l5);
  Calendar calendar = Calendar.getInstance();
  calendar.setTime(date);
  int CUR_YEAR = calendar.get(1);
  int CUR_MON = calendar.get(2) + 1;
  int CUR_DAY = calendar.get(5);
  String SYEAR = request.getParameter("YEAR");
  String SMONTH = request.getParameter("MONTH");
  String FIELDNAME = request.getParameter("FIELDNAME");
  if (SYEAR == null)
    SYEAR = (new Integer(CUR_YEAR)).toString();
  if (SMONTH == null)
    SMONTH = (new Integer(CUR_MON)).toString();
  int YEAR = Integer.parseInt(SYEAR);
  int MONTH = Integer.parseInt(SMONTH);
%>
<script language="JavaScript">
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

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
  n.setDate(1);dow=n.getDay();moy=n.getMonth();

  for (i=0;i<41;i++)
  {
    if ((i<dow)||(moy!=n.getMonth()))
       dt="&nbsp;";
    else
    {
      dt=n.getDate();
      n.setDate(n.getDate()+1);

      if(dt==<%=CUR_DAY%>&&cm==<%=CUR_MON%>&&yr==<%=CUR_YEAR%>)
         dt="<a href='#' onclick='dateClick("+dt+")'><font color=red>"+dt+"</font></a>";
      else
         dt="<a href='#' onclick='dateClick("+dt+")'>"+dt+"</a>";
    }

    MM_findObj('day')[i].innerHTML="<b>"+dt+"</b>";
  }
}

function setPointer(theRow, thePointerColor)
{
   theRow.bgColor = thePointerColor;
}

var parent_window = window.dialogArguments;

function dateClick(theDate)
{
   yr=document.form1.YEAR.value;
   cm=document.form1.MONTH.value;

   date_str=yr+"-"+cm+"-"+theDate;
   parent_window.<%=FIELDNAME%>.value=date_str;
   window.close();
}

function thisMonth()
{
   document.form1.YEAR.selectedIndex=(<%=CUR_YEAR%>-1930);
   document.form1.MONTH.selectedIndex=(<%=CUR_MON%>-1);
   doCal();
}
</script>
</head>
<body class="bodycolor" onload="doCal();" topmargin="0" leftmargin="0">
<form action="#" method="post" name="form1">
<table width="100%" border="0" cellspacing="1" class="small" bgcolor="#000000" cellpadding="3" align="center">
  <tr align="center" class="bodycolor">
    <td colspan="7" class="big1">
<!--========================== 年 =================================================-->
<input type="button" value="&laquo;" style="height:20;position: relative;top:-1;left:-1" class="SmallButton" title="上一年" onclick="set_year(-1);">
      <select name="YEAR" class="SmallSelect" onchange="set_year(0);">
      <%for (int I = YEAR; I <= 2050; I++) {      %>
        <option value="<%=I%>"><%=I%>        </option>
      <%}      %>
      </select>
      <input type="button" value="&raquo;" style="height:20;position: relative;top:-1;" class="SmallButton" title="下一年" onclick="set_year(1);">
      <b>年</b>
<!--============================================月===================================-->
<input type="button" value="&laquo;" style="height:20;position: relative;top:-1;left:-1" class="SmallButton" title="上一月" onclick="set_mon(-1);">
      <select name="MONTH" class="SmallSelect" onchange="set_mon(0);">
      <%
        for (int I = 1; I <= 12; I++) {
          //if(I<10)
          //  $I="0".$I;
      %>
        <option value="<%=I%>"><%=I%>        </option>
      <%}      %>
      </select>
      <input type="button" value="&raquo;" style="height:20;position: relative;top:-1;" class="SmallButton" title="下一月" onclick="set_mon(1);">
      <b>月</b>
    </td>
  </tr>
  <tr align="center" class="TableHeader">
    <td width="14%" bgcolor="#FFCCFF">
      <b>日</b>
    </td>
    <td width="14%">
      <b>一</b>
    </td>
    <td width="14%">
      <b>二</b>
    </td>
    <td width="14%">
      <b>三</b>
    </td>
    <td width="14%">
      <b>四</b>
    </td>
    <td width="14%">
      <b>五</b>
    </td>
    <td width="14%" bgcolor="#CCFFCC">
      <b>六</b>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
  </tr>
  <tr bgcolor="#FFFFFF" align="center" style="cursor:hand">
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%" id="day" onmouseover="setPointer(this,'#E2E8FA')" onmouseout="setPointer(this,'')">    </td>
    <td width="14%">
      <a href="#" onclick="thisMonth();">
        <b>本月</b>
      </a>
    </td>
  </tr>
</table>
</form>
</body>
</html>
