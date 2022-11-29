<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer("");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

int shenheids=0;
if(teasession.getParameter("shenheids")!=null && teasession.getParameter("shenheids").length()>0)
{
  shenheids = Integer.parseInt(teasession.getParameter("shenheids"));
  CaseCollection.setType(shenheids,0);
  response.sendRedirect("/jsp/admin/orthonline/CaseCollection.jsp?type=1");
  return;
}

int deleteid=0;
if(teasession.getParameter("deleteid")!=null && teasession.getParameter("deleteid").length()>0)
{
  deleteid = Integer.parseInt(teasession.getParameter("deleteid"));
  CaseCollection.delete(deleteid);
  response.sendRedirect("/jsp/admin/orthonline/CaseCollection.jsp?type=0");
  return;
}
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
  if(type==0)
  {
    sql.append(" and type=0");
  }
  else if(type==1)
  {
    sql.append(" and type=1");
  }
  param.append("&type=").append(type);
}

String casename = "",time_k="",time_j="",tel="";
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  regtime>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);

}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  regtime<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);

}
if(teasession.getParameter("casename")!=null && teasession.getParameter("casename").length()>0)
{
  casename = teasession.getParameter("casename");
  sql.append(" and casename  like "+DbAdapter.cite("%"+casename+"%"));
  param.append("&casename=").append(casename);
}

if(teasession.getParameter("tel")!=null && teasession.getParameter("tel").length()>0)
{
  tel = teasession.getParameter("tel");
  sql.append(" and mobilephone="+DbAdapter.cite(tel));
  param.append("&tel=").append(tel);
}

int pos = 0, pageSize = 30, count = 0;

count = CaseCollection.count(teasession._strCommunity,sql.toString());

if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

String o=request.getParameter("o");
if(o==null)
{
  o="id";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="">
function f_order(v)
{
  var aq=form2.aq.value=="true";
  if(form2.o.value==v)
  {
    form2.aq.value=!aq;
  }else
  {
    form2.o.value=v;
  }
  form2.action="?";
  form2.submit();
}

</script>
<title>骨科医生登记表</title>
</head>
<body id="bodynone">
<h1>
<%if(type==0)
{
  %>
  芬必得骨科病例征集审核
  <%
  }
  else if(type==1)
  {
    %>
    芬必得骨科病例征集管理
    <%
    }
    %>
    </h1>
    <form action="?" name="form2"  method="POST">
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">

    <input type="hidden" name="act">
    <input type="hidden" name="type" value="<%=type%>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td>病例名称</td><td><input name="casename"  value="<%if(casename!=null)out.print(casename);%>"/></td><td>联系电话</td><td><input name="tel"  value="<%if(tel!=null)out.print(tel);%>"/></td></tr>
        <tr><td>病例提交时间</td> <td colspan="2">&nbsp;从&nbsp;
          <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
            <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      </td><td><input  type="submit" value=查询 /></td></tr>
    </table>
    </form>
    <h2>列表(<%=count%>)</h2>
    <form action="/servlet/EditCaseCollectionExcel" name="form1"  method="POST">
    <input type="hidden" name="action" value="CaseCollection">
    <input type="hidden" name="sql" value="<%=sql.toString()%>">
    <input type="hidden" name="files" value="CaseCollection">
    <input type="hidden" name="count" value="<%=count%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr  id="tableonetr" ><td nowrap><a href="javascript:f_order('id');">序号</a>
  <%
  if(o.equals("id"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td>病例名称</td><td>姓名</td>
  <td>联系电话</td>
  <td nowrap><a href="javascript:f_order('regtime');">病例提交时间</a>
  <%
  if(o.equals("regtime"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td nowrap><a href="javascript:f_order('diannum');">点击率</a>
  <%
  if(o.equals("diannum"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td><td>操作</td></tr>
      <%
      Enumeration eu = CaseCollection.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
      if(!eu.hasMoreElements())
      {
        %><tr><td colspan="5">暂无消息</td></tr><%
      }
      for(int i=0;eu.hasMoreElements();i++)
      {
        int ccid = Integer.parseInt(String.valueOf(eu.nextElement()));
        CaseCollection ccobj = CaseCollection.find(ccid);
        String firstname = "";
        if(Profile.isExisted(ccobj.getMember()))
        {
          firstname = ccobj.getFirstname();
        }
        %>
        <tr>
          <td><%=ccid%></td>
          <td><a href="/jsp/admin/orthonline/CaseCollectionInfo.jsp?ids=<%=ccid%>&community=<%=teasession._strCommunity%>"><%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%></a></td>
          <td><%=firstname%></td>
          <td><a href="/jsp/admin/orthonline/CaseCollectionInfo.jsp?ids=<%=ccid%>&community=<%=teasession._strCommunity%>"><%if(ccobj.getMobilephone()!=null)out.print(ccobj.getMobilephone());%></a></td>
          <td><a href="/jsp/admin/orthonline/CaseCollectionInfo.jsp?ids=<%=ccid%>&community=<%=teasession._strCommunity%>"><%if(ccobj.getRegtimetoString()!=null)out.print(ccobj.getRegtimetoString());%></a></td>
          <td><%=ccobj.getDiannum()%></td>
          <td><%if(type==0){ %>
            <input name="编辑" type="button" value="编辑" onClick="window.open('/jsp/admin/orthonline/EditCaseCollection.jsp?bianji=1&ids=<%=ccid%>', '_self');" >　
            <input name="删除" type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/admin/orthonline/CaseCollection.jsp?deleteid=<%=ccid%>', '_self');this.disabled=true;};" >
            <%
            }
            else if(type==1){
            %>
            <input name="编辑" type="button" value="编辑" onClick="window.open('/jsp/admin/orthonline/EditCaseCollection.jsp?bianji=1&type==1&ids=<%=ccid%>', '_self');" >
            <input name="删除" type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/admin/orthonline/CaseCollection.jsp?deleteid=<%=ccid%>&type==1', '_self');this.disabled=true;};" >　
            <input name="修改病历状态" type="button" value="修改病历状态" onClick="if(confirm('确认修改病历状态！')){window.open('/jsp/admin/orthonline/CaseCollection.jsp?shenheids=<%=ccid%>&type==1', '_self');this.disabled=true;};" >　
            <%
          }
            %>
            </td>
        </tr>
        <%
        }
        if(count>10)
        {
          %>
          <tr><td colspan="5"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
          <%
          }if(type!=0)
          {
            %><tr><td colspan="5" align="center"><input type="submit" value="导出Excel"  /></td></tr><%}%>

    </table>
    </form>
</body>
</html>
