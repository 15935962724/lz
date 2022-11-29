<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

String community = teasession._strCommunity;
String to = request.getParameter("to");
StringBuffer tmember=new StringBuffer("/");
StringBuffer name=new StringBuffer();
StringBuffer par=new StringBuffer();
int pos = 0;
String spos = request.getParameter("pos");
if(spos!=null){
  pos = Integer.parseInt(spos);
  par.append("?pos=");
}
if(to!=null)
{
  tmember.append(to).append("/");
  Profile p=Profile.find(to);
  name.append(p.getName(teasession._nLanguage)).append("; ");
}
%>
<HTML>
  <HEAD>
    <style type="text/css">
    div#abc { color: blue;display: inline }
    </style>

    <SCRIPT type="">
    function f_open()
    {
      window.open('/jsp/profile/attendance/SelMembers.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.attper','','width=450px,height=350px,top=300px,left=400px');
    }
    function f_type()
    {
      window.open('/jsp/profile/attendance/SelType.jsp','','width=500px,height=300px,top=200px,left=600px');
    }
    function f_clear()
    {
      form1.to.value="/";
      form1.tunit.value="/";
      form1.attper.value="";
    }

    function submitCheck(form1)
    {
      return (submitText(form1.timek,'请输入开始日期')
      &&submitDate(form1.timek,'无效-开始日期')
      &&submitText(form1.timej,'请输入结束日期')
      &&submitComDate()
      &&submitType(form1.type,'请选择值班类型')
      &&submitText(form1.attper,'请选择值班人员'));
    }

    function submitType(form1,text){
      var type = form1.value;
      if(type == -1){
        alert(text);
        form1.focus();
        return false;
      }
      return true;
    }

    function submitComDate(){
      var tk = form1.timek.value;
      var tj = form1.timej.value;
      return (compareDate(tj,tk));
    }

    function compareDate(DateOne,DateTwo)
    { ndate = new Date();
    date = ndate.getDate();
    month = ndate.getMonth()+1;
    year = ndate.getYear();
    var t3 = year+"-"+month+"-"+date;

    var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ("-"));
    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ("-")+1);
    var OneYear = DateOne.substring(0,DateOne.indexOf ("-"));

    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ("-"));
    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ("-")+1);
    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ("-"));

    if (Date.parse(OneMonth+"/"+OneDay+"/"+OneYear) >=
    Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear))
    {
      if(Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear)>=Date.parse(month+"/"+date+"/"+year)){
        return true;
      }else{
        alert('值班日期为今日往后');
        return false;
      }
    }
    else
    {
      alert('无效-结束日期');
      return false;
    }
  }

  function f_show(bool){
    document.all('abc').style.display=bool?"":"none";
  }
  </SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script type="text/javascript" src="/tea/applet/office/ocx.js"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  </HEAD>
  <body >

  <form name="form1" action="/servlet/AddAttPer" method="post" onSubmit="return submitCheck(this);">

  <h1>增设值班人员</h1>
  <table border="0" cellpadding="0" cellspacing="0" width="30%" align="center" id="tablecenter" >
    <tr><td align="center">值班日期：</td><td nowrap="nowrap">从&nbsp;&nbsp;<input name="timek" size="10" value="">
      <A href="###">
        <img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a>&nbsp;
至&nbsp;&nbsp;
<input name="timej" size="10" value="">
<A href="###">
  <img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a>　　　<input type="checkbox" name="yn" onclick="f_show(checked)"/>周期性排班　
　　<div id="abc" style="display:none"><select name="week">
  <option value="0">------</option>
  <option value="1">周一</option>
  <option value="2">周二</option>
  <option value="3">周三</option>
  <option value="4">周四</option>
  <option value="5">周五</option>
  <option value="6">周六</option>
  <option value="7">周日</option>
</select>
</div></td>
</tr>

<tr>
  <td align="center" bgcolor=#F5F5F5>值班类型：</td>
  <td bgcolor=#F5F5F5>　&nbsp;&nbsp;<select name="type">
    <option value="-1">------------------</option>
    <%
    DbAdapter db = new DbAdapter();
    db.executeQuery("select tid,typename from atttype where community="+db.cite(community));
    while(db.next()){
      %>
      <option value="<%=db.getInt(1)%>"><%=db.getString(2) %></option>

      <%}db.close(); %>
</select>　　&nbsp;&nbsp;<input type="button" value="自定义类型" onclick="f_type();"/></td>
</tr>
<tr>
  <td align="center" bgcolor=#F5F5F5>值班人员：</td><td bgcolor=#F5F5F5>　&nbsp;&nbsp;<textarea name="attper" readonly cols="50" rows="2"><%=name.toString()%></textarea>　
    <input type="button" value="选择" onClick="f_open();" >
    <input type="button" value="清空" onClick="f_clear();" >
    <input type="hidden" name="to" value="<%=tmember.toString()%>"/>
    <input type="hidden" name="community" value="<%=community%>"/>
    <input type="hidden" name="tunit"/></td>
</tr>
<tr>
  <td align="center" colspan="2" bgcolor=#F5F5F5>
    <input type="submit" value="添加"/>
    <input type="reset" value="重置"/>
  </td>
</tr>
  </table>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <h1>值班信息</h1>
  <table border="0" cellpadding="0" cellspacing="0" width="30%" align="center" id="tablecenter">

    <tr id="tableonetr">
      <td align="center" width="10%">序号</td>
      <td align="center" width="30%">值班日期</td>
      <td align="center" width="15%">值班类型</td>
      <td align="center" width="30%">值班人员</td>
      <td align="center" width="15%">操作</td>
    </tr>
    <%
    int index = pos + 1;
    int size = 10;
    int count = Attenddance.countAtt(community);
    Enumeration e = Attenddance.selAttend(community,pos,size);
    while(e.hasMoreElements()){
      int id = ((Integer)e.nextElement()).intValue();
      Attenddance ad = Attenddance.find(id);
      String timek = Attenddance.dateFormat(ad.getTimek());
      String timej = Attenddance.dateFormat(ad.getTimej());
      int wk = ad.getWeek();
      String wek = "";
      if(wk == 1){
        wek = "周一";
      }
      if(wk == 2){
        wek = "周二";
      }
      if(wk == 3){
        wek = "周三";
      }
      if(wk == 4){
        wek = "周四";
      }
      if(wk == 5){
        wek = "周五";
      }
      if(wk == 6){
        wek = "周六";
      }
      if(wk == 7){
        wek = "周日";
      }
      %>
      <tr>
        <td align="center"><%=index%></td>
        <%if(timek.equals(timej)){out.print("<td align=center>"+timek+"　　"+wek+"</td>");}else{out.print("<td align=center>"+timek+"　至　"+timej+"　　"+wek+"</td>");} %>
        <td align="center"><%=Attenddance.findTname(ad.getType(),community) %></td>
        <td align="center"><%=ad.getAttPer() %></td>
        <td align="center">
          <input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"  onClick="window.location.href='/jsp/profile/attendance/EditAttend.jsp?id=<%=id%>'">
          <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"  onClick="if(confirm('确定删除此类型？')){window.location.href='/jsp/profile/attendance/DeleteAttend.jsp?id=<%=id%>';}">
        </td>
      </tr>

      <%
      index++;}if(count>size){
        %>
        <tr>

          <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+ "?pos=", pos, count,size)%></td>
        </tr><%} %>
  </table>
  </form>

  </body>
</html>
<script language="JavaScript">
anole('',1,'white','','#BCD1E9','');
/*tr_tableid, // table id
num_header_offset,// 表头行数
str_odd_color, // 奇数行的颜色
str_even_color,// 偶数行的颜色
str_mover_color, // 鼠标经过行的颜色
str_onclick_color // 选中行的颜色
*/
</script>
