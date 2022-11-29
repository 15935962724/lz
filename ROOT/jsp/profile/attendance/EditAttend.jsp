<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
String to = request.getParameter("to");
StringBuffer tmember=new StringBuffer("/");
StringBuffer name=new StringBuffer();
if(to!=null)
{
  tmember.append(to).append("/");
  Profile p=Profile.find(to);
  name.append(p.getName(teasession._nLanguage)).append("; ");
}
int id=Integer.parseInt(request.getParameter("id"));

Attenddance ad = Attenddance.find(id);
String timek = Attenddance.dateFormat(ad.getTimek());
String timej = Attenddance.dateFormat(ad.getTimej());
int wk = ad.getWeek();
%><HTML>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="">
    function f_open()
    {
      window.open('/jsp/profile/attendance/SelMembers.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.attper','','width=450px,height=350px,top=300px,left=400px');
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
    {
      ndate = new Date();
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
    </script>
    </HEAD>
    <body>

    <h1>编辑值班信息</h1>
    <div id="head6"><img height="6" src="about:blank"></div>
      <br>

      <FORM name="form1" action="/servlet/EditAttend" method="POST" onSubmit="return submitCheck(this);">
        <input type="hidden" name="id" value="<%=id%>"/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr><td align="center">值班日期：</td><td>从&nbsp;&nbsp;<input name="timek" size="10" value="<%=timek%>">
            <A href="###">
              <img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a>&nbsp;
至&nbsp;&nbsp;
<input name="timej" size="10" value="<%=timej%>">
<A href="###">
  <img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/>
</a>　　　
<%
if(wk != 0)
{
  %>
  <select name="week">
  <option value="0">------</option>
  <option value="1" <%if(wk == 1)out.print("selected");%>>周一</option>
  <option value="2" <%if(wk == 2)out.print("selected");%>>周二</option>
  <option value="3" <%if(wk == 3)out.print("selected");%>>周三</option>
  <option value="4" <%if(wk == 4)out.print("selected");%>>周四</option>
  <option value="5" <%if(wk == 5)out.print("selected");%>>周五</option>
  <option value="6" <%if(wk == 6)out.print("selected");%>>周六</option>
  <option value="7" <%if(wk == 7)out.print("selected");%>>周日</option>
</select>
  <%
}
%>
</td>
</tr>
<tr>
  <td align="center">值班类型：</td>
  <td>　&nbsp;&nbsp;<select name="type">
    <option value="-1">------------------</option>
    <%
    DbAdapter db = new DbAdapter();
    db.executeQuery("select tid,typename from atttype where community="+db.cite(teasession._strCommunity));
    while(db.next()){
      %>
      <option value="<%=db.getInt(1)%>" <%if(db.getInt(1)==ad.getType())out.print("selected");%>><%=db.getString(2) %></option>

      <%}db.close(); %>
</select>　</td>
</tr>
<tr>
  <td align="center">值班人员：</td><td>　&nbsp;&nbsp;<textarea name="attper" readonly cols="50" rows="2"><%=ad.getAttPer()%></textarea>　
    <input type="button" value="选择" onClick="f_open();" >
    <input type="button" value="清空" onClick="f_clear();" >
    <input type="hidden" name="to" value="<%=tmember.toString()%>"/>
    <input type="hidden" name="tunit"/></td>
</tr>
        </table>

        <input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
        <input type="button" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
    </body>
</HTML>
