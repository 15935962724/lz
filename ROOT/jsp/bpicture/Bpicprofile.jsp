<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.bpicture.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.member.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;
int pos=0;
if(teasession.getParameter("pos")!=null && teasession.getParameter("pos").length()>0)
{
  pos = Integer.parseInt(teasession.getParameter("pos"));
}
int count=0;
count=Profile.countByCommunity(teasession._strCommunity,"");

StringBuffer param=new StringBuffer("&community="+community);



%>




<html>
<head>
<base target="me"/>
<script type="">
window.name="me";
function add_mode(mode_name)
{
  window.returnValue = mode_name;
  window.close();
}
</script>
</head>
<body bgcolor="#ffffff">
<h1>
会员信息
</h1>
  <FORM name=form1 METHOD=POST action="" onSubmit="">
  <table>
  <tr>
  <td>会员ID</td><td>会员姓名</td>
  </tr>
  <%
  Enumeration en = Profile.findByCommunity(teasession._strCommunity,"",pos,10);
  if(!en.hasMoreElements())
  {
    %>
    <tr><td colspan="2">暂无信息</td>
    </tr>
    <%
  }
  for(int i=0;en.hasMoreElements();i++)
  {
    String member =String.valueOf(en.nextElement());
    Profile pro = Profile.find(member);
    %>
    <tr><td><%=pro.getFirstName(teasession._nLanguage)%></td>
      <td nowrap=nowrap ><a href=# onclick="add_mode('<%=member%>');"><%=member%></a></td>
    </tr>

    <%
  }
  %>


   <tr><td colspan="2" align="right" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>



  </table>

  </form>
</body>
</html>
