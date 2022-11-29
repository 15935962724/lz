<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/site/MemberOverview");
String action=request.getParameter("action");
long l =0;
try
{
  l=Long.parseLong(request.getParameter("date"));
}catch(Exception e)
{}
java.util.Date startDate=new java.util.Date(l);
StringBuffer sbScript[]=new StringBuffer[list.length];
%>
<%!
static final String list[]={"Address","mobile1","Organization","City","State","Zip","Country","Telephone","Fax","Age","WebPage"};
%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, action)%> <%=java.text.DateFormat.getDateInstance().format(startDate)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr ID=tableonetr>
<TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Name")%></TD>
<TD><%=r.getString(teasession._nLanguage, "EmailAddress")%></TD>
<TD><select name="list" onchange="listalter(this.selectedIndex)"><%for(int index=0;index<list.length ;index++){out.print("<OPTION>"+r.getString(teasession._nLanguage,list[index]));sbScript[index]=new StringBuffer();}%></select></TD>
  <td>
  </td></tr>
<%
java.util.Enumeration enumer=null;
Calendar calendar = Calendar.getInstance();
calendar.setTime(startDate);
calendar.set(11, 23);
calendar.set(12, 59);
calendar.set(13, 59);
int pos=1,count=0;
if(action.equals("NewMembers"))
enumer=Profile.findByDate(startDate,calendar.getTime());
else
if(action.equals("Search"))
{
  java.util.Date form=null,to=null;
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd");
  try
  {
    form=  sdf.parse(request.getParameter("from"));
  }catch(Exception e)
  {}
  try
  {
    to=  sdf.parse(request.getParameter("to"));
  }catch(Exception e)
  {}
  pos=Integer.parseInt(request.getParameter("pos"));
  enumer=tea.entity.member.Profile.find(form,to,request.getParameter("member"),request.getParameter("name"),pos,20);
  count=tea.entity.member.Profile.count(form,to,request.getParameter("member"),request.getParameter("name"));
}else
enumer=Logs.findByDate(startDate,calendar.getTime());
for(int index=0;enumer.hasMoreElements();index++)
{
  String member=(String)enumer.nextElement();
  Profile profile=Profile.find(member);
  String email=profile.getEmail();
  sbScript[1].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getMobile()+"';");
  sbScript[2].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getOrganization(teasession._nLanguage)+"';");
  sbScript[0].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getAddress(teasession._nLanguage)+"';");
  sbScript[3].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getCity(teasession._nLanguage)+"';");
  sbScript[4].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getState(teasession._nLanguage)+"';");
  sbScript[5].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getZip(teasession._nLanguage)+"';");
  sbScript[6].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getCountry(teasession._nLanguage)+"';");
  sbScript[7].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getTelephone(teasession._nLanguage)+"';");
  sbScript[8].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getFax(teasession._nLanguage)+"';");
  sbScript[9].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getAge()+"';");
  sbScript[10].append("document.all['listvalue"+index+"'].innerHTML='"+profile.getWebPage(teasession._nLanguage)+"';");
  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=profile.getAnchor()%></td>
    <td><%=profile.getName(teasession._nLanguage)%></td>
    <td><a href="mailto:<%=email%>"><%=email%></a></td>
    <td>
      <span id="listvalue<%=index%>" ><%=profile.getAddress(teasession._nLanguage)%></span>
      </td><td>
    <input type="button" onclick="window.location='EditYellowPage.jsp?member=<%=new String(member.getBytes("ISO-8859-1"))%>'" value="<%=r.getString(teasession._nLanguage, "Manager")%>"/></td>
    </tr>
<%
}
if(count>20)
{
  out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,"?pos=",pos,count,20));
}
%>
</table>

<script>
function listalter(index)
{
  switch(index)
  {
    <%
    for(int index=0;index<sbScript.length;index++)
    out.println("case "+index+" : "+sbScript[index].toString()+"break;");
    %>
  }
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

