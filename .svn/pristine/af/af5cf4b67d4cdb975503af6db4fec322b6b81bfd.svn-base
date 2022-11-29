<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int style=0;
String _strStyle=request.getParameter("style");
if(_strStyle!=null)
{
  style=Integer.parseInt(_strStyle);
}

java.util.Calendar c = java.util.Calendar.getInstance();
c.setTimeInMillis(System.currentTimeMillis());
int cyear=c.get(c.YEAR);
int cmonth=c.get(c.MONTH)+1;
int cday=c.get(c.DAY_OF_MONTH);
//c.set(c.HOUR_OF_DAY,0);
//c.set(c.MINUTE,0);
//c.set(c.MINUTE,0);
c.set(11, 0);
c.set(12, 0);
c.set(13, 0);
c.set(14, 0);
int year;
int month;
String _strMonth=request.getParameter("month");
if(_strMonth!=null)
{
  month=Integer.parseInt(_strMonth);
  c.set(c.MONTH,month-1);
}
String _strYear=request.getParameter("year");
if(_strYear!=null)
{
  year=Integer.parseInt(_strYear);
  c.set(c.YEAR,year);
}
month=c.get(c.MONTH) + 1;
year=c.get(c.YEAR);

if(style==0)//
{
%>
<FORM NAME="flagtimes_form1" ACTION="?">
<input type="hidden" name="Node" value="<%=teasession._nNode%>" >
<table width="100%" border="0" align="center" cellpadding="0" id="TableFlagtime">
      <tr align="center" bgcolor="#DE1310">
        <td colspan="7" >
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <TR>
              <td width="5%" align="left" valign="top"></td>
              <TD  width="90%" align="center" height="20px">
                <a href="javascript:gotoPage(-1);" ><font color=white>上一月份&gt;&gt;</font></a> &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp;
                <select name="year" id="year" onChange="flagtimes_form1.submit();">
                  <option value="<%=year%>"><%=year%></option>
                </select>
                <font color="#FFFFFF">年
                <select name="month" id="month" onChange="flagtimes_form1.submit();">
                <%
                for(int i=1;i<13;i++)
                {
                  out.print("<option value="+i);
                  if(i==month)
                  out.print(" selected ");
                  out.print(">"+i);
                }
                %>
                </select>
                月 </font> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <a href="javascript:gotoPage(1);"><font color=white>下一月份&gt;&gt;</font></a>
                <script language="javascript" type="">
                function gotoPage(value)
                {
                  var obj=flagtimes_form1.month;
                  var month=parseInt(obj.value);
                  if((month+value<1)||(month+value>12))
                  {
                    obj.options[obj.options.length]=new Option(month,month+value);
                  }
                  obj.value=month+value;
                  flagtimes_form1.submit();
                }
                </script>
        </TD>
        <td width="5%" align="right" valign="top"></td>
      </TR>
    </TABLE></TD>
</TR>
<TR VALIGN=middle ALIGN=CENTER BGCOLOR="#DE1310">
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期日</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期一</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期二</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期三</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期四</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期五</FONT></TD>
  <TD WIDTH="14%" height="20px"><FONT COLOR="#FFFFFF">星期六</FONT></TD>
</TR>
<tr align='center' bgcolor='#efefef'>
<%

int day=0;
c.set(c.DAY_OF_MONTH,1);

for(int i=c.get(c.DAY_OF_WEEK);i>1;i--,day++)
{
  out.print("<td >&nbsp;</TD>");
}
for(int i=1;c.get(c.MONTH)+1==month;++i,c.set(c.DAY_OF_MONTH,i),day++)
{
  Flagtime obj=Flagtime.find(c.getTime());
  if(day%7==0&&day!=0)
  out.println("</tr><tr align='center' bgcolor='#efefef'>");
  if(cyear==year&&cmonth==month&&i==cday)//ffff00背景为此色表示当天日期
  out.print("<td align='center' bgcolor='#ffff00' >"+i);
  else
  out.print("<td align='center' >"+i);
  if(i==1)//FF0000字体为此颜色表示有军乐队现场伴奏的大型升国旗仪式
  out.print("<font style='font-weight:bold; color:#FF0000'><br/>升　"+obj.getRaise()+"</font>");
  else
  out.print("<br/>升　"+obj.getRaise());
  out.println("<br/>降　"+obj.getLower()+"</TD>");
}
for(;day%7!=0;day++)
{
  out.print("<td align='center' >&nbsp;</TD>");
}
%>
 </TABLE>
 </form>
 <%
}else
if(style==1)
{
  c.set(c.DAY_OF_MONTH,cday+1);
  Flagtime obj=Flagtime.find(c.getTime());
  out.print(c.get(c.DAY_OF_MONTH)+"号升旗"+obj.getRaise()+" 降旗"+obj.getLower());
}
%>

