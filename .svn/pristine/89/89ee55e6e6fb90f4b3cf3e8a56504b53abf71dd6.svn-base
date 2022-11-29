<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.bpicture.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>

<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;
StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer("");
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);



String memberx= "";
if(teasession.getParameter("memberx")!=null && teasession.getParameter("memberx").length()>0)
{
  memberx = teasession.getParameter("memberx");
  sql.append(" and  member like ").append(DbAdapter.cite("%"+memberx+"%"));
  param.append("&member=").append(DbAdapter.cite(memberx));
}
String firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname = teasession.getParameter("firstname");
  sql.append(" and member in (select member from profilelayer where firstname like "+DbAdapter.cite("%"+firstname+"%")+")");
  param.append("&firstname=").append(java.net.URLEncoder.encode(firstname,"UTF-8"));
}

int tongguo =0;
if(teasession.getParameter("tongguo")!=null && teasession.getParameter("tongguo").length()>0)
{

  String members = teasession.getParameter("memberss");
  tongguo =Integer.parseInt( teasession.getParameter("tongguo"));
  if(tongguo==1)
  {
    ProfileBBS bbs = ProfileBBS.find(teasession._strCommunity,members);
    bbs.setValidate(true);
  }
}
int count=0;
count=Profile.countByCommunity(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<script>
function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:520px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/bpicture/saler/dialogbox.jsp";
  var aio ="";
  document.all.memberpic.value =window.showModalDialog(url,aio,sFeatures);
}
</script>
<style>
#table005{width:1002px;margin-top:15px;}
#table005 td{background:#eee;padding:5px 10px;}
.lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
</style>
</head>
<body bgcolor="#ffffff" >
<h1 style="width:1002px;margin-left:0px;">
会员信息（<%=count%>）
</h1>
<FORM name=form1 METHOD=POST action="/jsp/volunteer/VolunteerMember.jsp" >
 <table border="0" cellpadding="0" cellspacing="2" id="table005">
 <tr>
      <td>会员ID</td><td><input type="text"  name="memberx" size="27" value="<%=memberx%>"/></td><td>姓名</td><td><input type="text"  name="firstname" size="16" value="<%=firstname%>"/></td>
     <td><input type="submit" value="查询"/></td>
    </tr>

 </table>
</form>

<FORM name=form1 METHOD=POST action="" onSubmit="">
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <input type='hidden' name=memberpic VALUE="<%=2198116%>"/>
    <tr>
      <td>会员姓名</td><td>会员ID</td><td>联系电话</td><td>状态</td><td></td>
    </tr>
    <%
    Enumeration en = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
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
  ProfileBBS bbs = ProfileBBS.find(teasession._strCommunity,member);

  %>
  <tr><td><%=pro.getName(teasession._nLanguage)%></td>
    <td nowrap=nowrap ><a href="/jsp/bpicture/AuditPicture.jsp?member=<%=member%>"><%=member%></a></td>
    <td nowrap=nowrap ><%=pro.getMobile()%></td>

    <td nowrap=nowrap >
    <%
    if(bbs.isValidate())
    {
      out.print("审核通过");
    }
    else
    {
      out.print("未审核");
    }
    %>
    </td>
    <td>
      <input type="button" value="审核通过" onClick="if(confirm('确认审核通过！')){window.open('/jsp/volunteer/VolunteerMember.jsp?tongguo=1&memberss=<%=member%>', '_self');this.disabled=true;};" >


    </td>
</tr>

<%
}
%>
<tr><td colspan="5"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
  </table>
</form>
</body>
</html>
