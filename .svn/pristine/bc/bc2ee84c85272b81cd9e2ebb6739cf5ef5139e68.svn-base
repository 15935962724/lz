<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and type is null and  audmamber="+DbAdapter.cite(teasession._rv.toString()));
String _strId=request.getParameter("id");

String manmember=request.getParameter("manmember");
if(manmember!=null&&(manmember=manmember.trim()).length()>0)
{
  sql.append(" AND manmember in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+manmember+"%")+" or firstname like "+DbAdapter.cite("%"+manmember+"%")+")");
  param.append("&manmember="+java.net.URLEncoder.encode(manmember,"UTF-8"));
}
String audmamber=request.getParameter("audmamber");
if(audmamber!=null&&(audmamber=audmamber.trim()).length()>0)
{
  sql.append(" AND audmamber in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+audmamber+"%")+" or firstname like "+DbAdapter.cite("%"+audmamber+"%")+")");
  param.append("&audmamber="+java.net.URLEncoder.encode(audmamber,"UTF-8"));
}

String mantime1=request.getParameter("mantime1");
if(mantime1!=null&&(mantime1=mantime1.trim()).length()>0)
{
  sql.append(" AND mantime >"+DbAdapter.cite(mantime1));
  param.append("&mantime1="+java.net.URLEncoder.encode(mantime1,"UTF-8"));
}
String mantime2=request.getParameter("mantime2");
if(mantime2!=null&&(mantime2=mantime2.trim()).length()>0)
{
  sql.append(" AND mantime <"+DbAdapter.cite(mantime2));
  param.append("&mantime2="+java.net.URLEncoder.encode(mantime2,"UTF-8"));
}
int count=Manoeuvre.count(teasession._strCommunity,sql.toString());
int size=10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
//param.append("&pos=").append(pos);

String o=request.getParameter("o");
if(o==null)
{
  o="manoeuvre";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);
//sql.append(" ORDER BY times desc  ");

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>

  <script >
  function editimd1(igd)
  {
     if(confirm('您确定要操作吗！'))
    {
      form1.manoeuvre.value=igd;
      form1.act.value="piz";
      form1.action='/servlet/EditManoeuvre';
      form1.submit();
    }
  }

   function editimd2(igd)
  {
    if(confirm('您确定不批准次项内容吗?'))
    {
      form1.manoeuvre.value=igd;
      form1.act.value="bupiz";
      form1.action='/servlet/EditManoeuvre';
      form1.submit();
    }
  }

    function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }
  </script>
  <body>

  <h1>人事调动审批</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <h2>查询</h2>
    <form name=form1 METHOD=get  action="?">
      <input type=hidden name="act" />
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
      <input type="hidden" name="manoeuvre" />
        <input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="aq" VALUE="<%=aq%>">
      <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>调动人员<input name="manmember" value="<%if(manmember!=null)out.print(manmember);%>"></td>
          <td>审核人员<input name="audmamber" value="<%if(audmamber!=null)out.print(audmamber);%>"></td>
          <td>调动时间<input name="mantime1" value="<%if(mantime1!=null)out.print(mantime1);%>"><A href="###"><img onClick="showCalendar('form1.mantime1');" src="/tea/image/public/Calendar2.gif" align="top"/></a>-
          <input name="mantime2" value="<%if(mantime2!=null)out.print(mantime2);%>"><A href="###"><img onClick="showCalendar('form1.mantime2');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

          </td>
          <td><input type="submit" value="查询"/></td>
        </tr>
      </table>
      <h2>列表(<%=count %>)</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id="tableonetr">
        <td nowrap="nowrap">序号</td>
        <td nowrap><a href="javascript:f_order('manmember');">调动人员</a> <%
          if(o.equals("manmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap><a href="javascript:f_order('content');">调动原因</a><%
          if(o.equals("content"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap><a href="javascript:f_order('audmamber');">审核人员</a><%
          if(o.equals("audmamber"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap><a href="javascript:f_order('mantime');">调动时间</a><%
          if(o.equals("mantime"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          <td nowrap >操作</td>

        </tr>
        <%
        int index =pos+1;

        java.util.Enumeration e = Manoeuvre.find(teasession._strCommunity,sql.toString(),pos,size);
        if(!e.hasMoreElements())
        {
          out.print("<tr><td>暂无记录</td></tr>");
        }
        while(e.hasMoreElements())
        {
          int manoeuvre = ((Integer)e.nextElement()).intValue();
          Manoeuvre mobj = Manoeuvre.find(manoeuvre);

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td width="20" align="center"><%=index %></td>
            <td align="center" >
            <%
                tea.entity.member.Profile p = tea.entity.member.Profile.find(mobj.getManmember());
                out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
            %>            </td>

            <td ><%if(mobj.getContent()!=null &&mobj.getContent().length()>0)
                    { %><a href="/jsp/admin/manoeuvre/show.jsp?manoeuvre=<%=manoeuvre%>"  target="_blank">
             <%

                         if(mobj.getContent().length()>10)
                         {
                             out.print(mobj.getContent().substring(0,10)+"...........");
                         }else{
                           out.print(mobj.getContent());
                         }

             %>
            </a><%  }else{
                     out.print("暂无原因");
                    }%></td>
            <td align="center" >
             <%
                tea.entity.member.Profile p2 = tea.entity.member.Profile.find(mobj.getAudmamber());
                out.print(p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
            %>            </td>
            <td align="center" ><%=mobj.getMantimeToString()%></td>
            <td align="center" ><input  type ="button"  value="批准" onClick="editimd1('<%=manoeuvre%>');">
              <input type=button value="不批准"  onClick="editimd2('<%=manoeuvre%>');">
            </td>
          </tr>
          <%
          index++;
          }if(count>size){
          %>
          <tr>
            <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
          </tr><%
          } %>
      </table>
</form>
<br>

  <div id="head6"><img height="6" src="about:blank"></div>

  </body>
</html>



