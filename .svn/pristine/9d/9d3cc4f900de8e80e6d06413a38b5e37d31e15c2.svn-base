<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
int id = 0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
  id = Integer.parseInt(request.getParameter("id"));


String member=teasession._rv.toString();

AdminUsrRole adobj = AdminUsrRole.find(teasession._strCommunity,member);

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
param.append("&id=").append(id);
StringBuffer sql=new StringBuffer(" AND type=1 ");
sql.append(" AND (( tmember='/' and tunit='/'  ) or");
//
sql.append("(");
sql.append(" tmember LIKE '%/"+member+"/%'");
sql.append(" OR tunit LIKE '%/"+adobj.getUnit()+"/%'))");

int count=Bulletin.count(teasession._strCommunity,sql.toString());
int size =10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

sql.append(" ORDER BY issuetime DESC");
//System.out.println(sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>查看公告通知</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>公告通知</h2>
<form action="?" method="POST" name="form1">
<input type="hidden" name="id" value="<%=id%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="40" nowrap>序号</td>
    <td nowrap>标题</td>
    <td width="80" nowrap>发件人</td>
    <td width="100" align="center" nowrap>发布时间</td>
  </tr>
  <%

  java.util.Enumeration enumer =  Bulletin.find(teasession._strCommunity,sql.toString(),pos,size);
  if(!enumer.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center><font color=red><b>暂无部门公告</b></font></td></tr>");
  }else
  {
    int index=pos+1;
    while(enumer.hasMoreElements())
    {
      int ids = ((Integer)enumer.nextElement()).intValue();
      Bulletin obj = Bulletin.find(ids);
      Profile p = Profile.find(obj.getMember());
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td align="center"><%= index%></td>
        <td nowrap ><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>&bulletin=<%=ids %>"  target="_blank">
        <%
        if(obj.getNotread()==0)
        {
          out.print("<B>");
          out.print(obj.getCaption());
          out.print("</B>");
        }else
        {
          out.print(obj.getCaption());
        }
        %>
        </a></td>
        <td nowrap align="center"><%=p.getName(teasession._nLanguage) %></td>
        <td nowrap align="center"><%=obj.getIssuetimeToString()%></td>
      </tr>
      <%
      index++;
    }//while循环
  }
          if(count>size)
          {
 %>
    <tr>
      <td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
    </tr>
    <%
            }
            %>
  </table>
</form>

</body>
</HTML>



