<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.htmlx.*" %>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return; 
}  

tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{
  
  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);


String community = teasession._strCommunity;

Resource r=new Resource("/tea/htmlx/HtmlX");
r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");

String s1 = request.getParameter("pos");
int pos = s1 == null ? 0 : Integer.parseInt(s1);

//StringBuffer sql=new StringBuffer(" AND s.vmember NOT IN(SELECT member FROM AdminUsrRole WHERE role!='/' AND community="+DbAdapter.cite(community)+")");
StringBuffer sql=new StringBuffer("");
StringBuffer param=new StringBuffer();

String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append("AND time >=").append(DbAdapter.cite(Profile.sdf.parse(time_c)));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append("AND time <=").append(DbAdapter.cite(Profile.sdf.parse(time_d)));
  param.append("&time_d=").append(time_d);
}
if(request.getParameter("act")!=null){
if(request.getParameter("act").equals("del")){
  String cb []  = teasession.getParameterValues("members");
  if(cb!=null){
    for(int i = 0;i < cb.length;i++){
      String m = cb[i];
      Profile.delete(m,teasession._nLanguage,community);
      AdminUsrRole a = AdminUsrRole.find(community,m);
      a.delete();
      //System.out.println(cb[i]);
    }
  }
}
}
int count=Profile.count(community,sql.toString());

sql.append(" ORDER BY time DESC");

%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
//点击发送按钮
function f_memberemail()
{
  form1.action ='/jsp/community/MemberEmail.jsp';
  form1.submit();
}
function f_memberedel()
{
  var rs=window.confirm('<%=r.getString(teasession._nLanguage, "您确定删除吗？")%>');
  if(rs){
        var el = form1.elements;
        var count = el.length;
        var flag = 0;
        for(i=0;i<count;i++)
        {
          if(el[i].type=="checkbox")
          {
            if(el[i].checked == true){
              flag = 1;
            }
          }
        }
        if(flag == 0){
          alert("至少选择一项");
          return;
        }

         form1.act.value = "del";
         form1.action ="?";
         form1.submit();
      }
}
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "用户管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
  <FORM id="form1" name=form1 METHOD=post  action="<%=request.getRequestURI()%>">
  <input type="hidden" name="community" value="<%=community%>">
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
      <input type="hidden" name="sql" value="<%=sql%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  <td><%=r.getString(teasession._nLanguage, "会员ID")%>:</td>
  <td><input type=text name="member" value="<%if(member!=null)out.print(member);%>" ></td>
  <td><%=r.getString(teasession._nLanguage, "注册日期")%>:</td>
  <td>
        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" /></td>


    <td><input type=submit value="<%=r.getString(teasession._nLanguage, "查询")%>" ></td>
  </tr>
  </table>


    <h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)</h2>



    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id=tableonetr>
        <td width="1"><input type="CHECKBOX" onClick="selectAll(form1.members ,this.checked)"/> </td>
        <td><%=r.getString(teasession._nLanguage, "MemberId")%> </td>
        <td><%=r.getString(teasession._nLanguage, "姓名")%> </td>
        <td><%=r.getString(teasession._nLanguage, "手机")%></td>
        <td><%=r.getString(teasession._nLanguage, "邮箱")%></td>
        <td><%=r.getString(teasession._nLanguage, "注册日期")%></td>
      </tr>
<%

Enumeration e=Profile.find(community,sql.toString(),pos,25);
   if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
while(e.hasMoreElements())
{
  RV rv = (RV)e.nextElement();
  String s2=rv._strV;
  Profile p=Profile.find(s2);

  Subscriber s = Subscriber.find(teasession._strCommunity, rv);
  java.util.Date term=s.getTerm();

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

  <td width="1"><input type="CHECKBOX"  name="members" value="<%=p.getMember()%>" <%if("webmaster".equals(s2))out.print(" disabled ");%> ></td>
  <td><a target="_blank" href="/jsp/access/Glance.jsp?Member=<%=s2%>" ><%=s2%></A> </td>
   <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
  <td><%=p.getMobile()%></td>
  <td><%=p.getEmail()%></td>
   <td><%=p.getTimeToString()%></td>
</tr>
<%
 }
 if(count>25){
%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+"?community="+community+"&node=" + teasession._nNode+param.toString() + "&pos=", pos, count )%> </td>
    </tr>
    <%} %>
  </table>
<br>
    <!--<input type="button"  value="发送电子邮件" onclick="f_memberemail();">-->
    <input type="hidden" name="act" value="">
    <input type="button" value="删除选中" onclick="f_memberedel()">

  </FORM>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

