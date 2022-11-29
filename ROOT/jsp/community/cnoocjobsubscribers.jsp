<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
  Purview purview = Purview.find(teasession._rv.toString(),teasession._strCommunity);
  if (!teasession._rv.toString().equalsIgnoreCase("cnooc") && !License.getInstance().getWebMaster().equals(teasession._rv.toString())) {
    ts.outText(response, 1, "你没有权限,访问本页.");
    return;
  }
%>
<%@include file="/jsp/type/job/cnoocjobheader.jsp"%>
<%
  StringBuffer scriptsb = new StringBuffer();
  r.add("/tea/ui/member/community/Subscribers");
  r.add("/tea/ui/member/community/Communities");
  byte pagesize = 20;
  String s = teasession._strCommunity;
  //Text text = new Text(String.valueOf(hrefGlance(teasession._rv)) + ">" + new Anchor("Communities", super.r.getString(teasession._nLanguage, "Communities")) + ">" + new Anchor("OrganizingCommunities", super.r.getString(teasession._nLanguage, "OrganizingCommunities")) + ">" + s + ":" + super.r.getString(teasession._nLanguage, "Subscribers"));
  String s1 = request.getParameter("Pos");
  int i = s1 == null ? 0 : Integer.parseInt(s1);
  int j = Purview.countByCommunity(teasession._strCommunity);
  int pagenum = j / pagesize;
  if (j % pagesize != 0)
    pagenum++;
  String nexturl = request.getParameter("nexturl");
  if (nexturl != null)
    nexturl = "&nexturl=" + nexturl;
  else
    nexturl = "";
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
  <!--
    #user td {padding-left:5px}
  -->
</style>
</head>
<body><div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">用户管理</h1>
<FORM name=foDelete METHOD=GET action="/servlet/DeleteSubscribers">
<table id=user border="1" cellpadding="0" cellspacing="0" width=98% style="border-collapse:collapse;margin-bottom:15px">
  <tr>
    <td COLSPAN=10>      已创建
<%=j%> <%=r.getString(teasession._nLanguage, "Subscribers")%>      <input type='hidden' name=Community VALUE="<%=s%>">
    </td>
  </tr>
<%
  if (j != 0) {
    boolean flag = true;
%>
  <tr bgcolor="#FFFBF0">
    <td nowrap>姓名</td>
    <td nowrap>用户ID</td>
    <td nowrap>邮箱</td>
    <td nowrap>电话</td>
    <td nowrap>操作</td>
  </tr>
<%
  int k = 0;
  DbAdapter dbadapter=new DbAdapter();
  dbadapter.executeQuery("SELECT username,company,job,resume,apply,comp FROM Purview ORDER BY username");
  for(int len=0;len<i&&dbadapter.next();len++);
  for(int len=0;len<pagesize&&dbadapter.next();len++)
  //for (Enumeration enumeration = Subscriber.find(s, i, pagesize); enumeration.hasMoreElements(); )
  {
    k++;
%>
<%
  String s2 = dbadapter.getString(1);
  Profile profile = Profile.find(s2);
  String email = profile.getEmail();
%>
  <tr ID>
    <td nowrap>      &nbsp;
<%=getNull(profile.getFirstName(1))+getNull(profile.getLastName(1))%>    </td>
    <td nowrap>
      <A href="/jsp/user/cnoocjobnewuser.jsp?Member=<%=s2%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>"><%=s2%>      </A>    </td>
    <td nowrap>
      <A HREF="mailto:<%=email%>"><%=getNull(email)%>      </A>    </td>
    <td nowrap><%=getNull(profile.getTelephone(1))%>    </td>
    <input type='hidden' name=Subscribers VALUE="<%=s2%>">
    <td nowrap>
      <A href="/jsp/user/cnoocjobnewuser.jsp?Member=<%=s2%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>">编辑</A>
<%if(s2.equalsIgnoreCase("cnooc"))out.print("删除") ;else{%>
<A  onClick="if(confirm('确认删除')){window.open('yjobdelmember.jsp?member=<%=s2%>', '_self')};" HREF="#">删除</a>
<%}%>
    </td>
  </tr>
<%
  flag ^= true;
  }
  dbadapter.close();
      }
%>
</table><LI ID="PageNum"><%
if(j>pagesize)
{
    if(i>0)
    out.print("<A HREF="+request.getRequestURI()+"?Community="+s+"&Pos="+(i-pagesize)+" >上一页</A> ");
int mm = 0;
for (; mm < pagenum; mm++)
  {
    int pag = mm * pagesize;
    if(i==pag)
    out.print("<span>"+(mm+1)+"</span>");
    else{
%> <A HREF="<%=request.getRequestURI()%>?Community=<%=s%>&Pos=<%=pag%>"><%=mm+1%>  </A>
<%}
}if(i<=pagenum)
    out.print("<A HREF="+request.getRequestURI()+"?Community="+s+"&Pos="+(i+pagesize)+" >下一页</A> ");
}%></Li>
<br>
<input class="in" type=BUTTON VALUE="创建用户" ID="CBNew" onClick="window.open('/jsp/user/cnoocjobnewuser.jsp?Community=<%=s%><%=nexturl%>', '_self');">
</form></div></div></div>
</body>
</html>
<%@include file="/jsp/type/job/cnoocjobfooter.jsp"%>


