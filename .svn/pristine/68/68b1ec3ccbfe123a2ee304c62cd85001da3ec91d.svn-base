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

int show = 0;
if(request.getParameter("show")!=null && request.getParameter("show").length()>0)
show =Integer.parseInt(request.getParameter("show"));
StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

int id = 0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
   id = Integer.parseInt(request.getParameter("id"));

//out.print(id);
//param.append("&id="+id);
String cardname=request.getParameter("cardname");
if(cardname!=null&&(cardname=cardname.trim()).length()>0)
{
  sql.append(" AND cardname like ").append(" ").append(DbAdapter.cite("%"+cardname+"%"));
  param.append("&cardname="+java.net.URLEncoder.encode(cardname,"UTF-8"));
}

String fztime1=request.getParameter("fztime1");
if(fztime1!=null&&(fztime1=fztime1.trim()).length()>0)
{
  sql.append(" AND fztime >= ").append(" ").append(DbAdapter.cite(fztime1));
  param.append("&fztime1="+java.net.URLEncoder.encode(fztime1,"UTF-8"));
}

String fztime2=request.getParameter("fztime2");
if(fztime2!=null&&(fztime2=fztime2.trim()).length()>0)
{
  sql.append(" AND fztime <= ").append(" ").append(DbAdapter.cite(fztime2));
  param.append("&fztime2="+java.net.URLEncoder.encode(fztime2,"UTF-8"));
}


String yxtime1=request.getParameter("yxtime1");
if(yxtime1!=null&&(yxtime1=yxtime1.trim()).length()>0)
{
  sql.append(" AND yxtime >= ").append(" ").append(DbAdapter.cite(yxtime1));
  param.append("&yxtime1="+java.net.URLEncoder.encode(yxtime1,"UTF-8"));
}

String yxtime2=request.getParameter("yxtime2");
if(yxtime2!=null&&(yxtime2=yxtime2.trim()).length()>0)
{
  sql.append(" AND yxtime <= ").append(" ").append(DbAdapter.cite(yxtime2));
  param.append("&yxtime2="+java.net.URLEncoder.encode(yxtime2,"UTF-8"));
}

int count=Certificate.count(teasession._strCommunity,sql.toString());
int size = 10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String o=request.getParameter("o");
if(o==null)
{
  o="certificate";
}
boolean a=Boolean.parseBoolean(request.getParameter("a"));
sql.append(" ORDER BY ").append(o).append(" ").append(a?"DESC":"ASC");
param.append("&o=").append(o).append("&a=").append(a);

///param.append("&pos=").append(pos);


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
  function editimd(igd)
  {
    form1.certificate.value=igd;
    form1.action='/jsp/admin/certificate/EditCertificate.jsp';
    form1.submit();
  }
  function deleteimd(igd)
  {
    if(confirm('您确认要删除！'))
    {
      form1.certificate.value=igd;
      form1.act.value="delete";
      form1.action='/servlet/EditCertificate';
      form1.submit();
    }
  }
  function kind()
  {

    form1.act.value="kind";
    form1.action='/servlet/EditCertificate';
    form1.submit();
  }

  function f_order(v)
  {
    var a=form1.a.value=="true";
    if(form1.o.value==v)
    {
      form1.a.value=!a;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }

  </script>
  <body>

  <h1>公司证照管理</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <h2>查询</h2>
    <form name=form1 METHOD=post  action="?">
      <input type=hidden name="act" />
      <input type="hidden" name="nexturl" value="/jsp/admin/certificate/certificate.jsp">
      <input type="hidden" name="certificate" />
      <input type="hidden" name="sql" value="<%=sql.toString()%>" />
      <input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="a" VALUE="<%=a%>">
      <input type="hidden" name="id" value="<%=id%>">

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>证照名称<input type="text" name="cardname" value="<%if(cardname!=null)out.print(cardname);%>"></td>
            <td>发证日期<input name="fztime1" size="7"  value="<%if(fztime1!=null)out.print(fztime1);%>"><A href="###"><img onclick="showCalendar('form1.fztime1');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
              -<input name="fztime2" size="7"  value="<%if(fztime2!=null)out.print(fztime2);%>"><A href="###"><img onclick="showCalendar('form1.fztime2');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
          </td>
          <td>有效日期<input name="yxtime1" size="7"  value="<%if(yxtime1!=null)out.print(yxtime1);%>"><A href="###"><img onclick="showCalendar('form1.yxtime1');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
            <input name="yxtime2" size="7"  value="<%if(yxtime2!=null)out.print(yxtime2);%>"><A href="###"><img onclick="showCalendar('form1.yxtime2');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
</td>
<td><input type="submit" value="查询"/></td>
        </tr>
      </table>

      <h2>列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id="tableonetr">
          <td nowrap>序号</td>
          <td nowrap><a href="javascript:f_order('cardname');">证照名称</a>
          <%
          if(o.equals("cardname"))
          {
            if(a)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          </td>
          <td nowrap><a href="javascript:f_order('originalname');">正本原件</a>
          <%
          if(o.equals("originalname"))
          {
            if(a)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          </td>
          <td nowrap><a href="javascript:f_order('copyname');">副本原件</a>
          <%
          if(o.equals("copyname"))
          {
            if(a)
            out.print("↓");
            else
            out.print("↑");
          }
          %>     </td>
          <td nowrap><a href="javascript:f_order('fztime');">发证日期</a><%
          if(o.equals("fztime"))
          {
            if(a)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap><a href="javascript:f_order('yxtime');">有效日期</a><%
          if(o.equals("yxtime"))
          {
            if(a)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <%if(show>=0){ %>
          <td nowrap >操作</td>
          <%
          }
          %>
          </tr>
          <%
          java.util.Enumeration e = Certificate.find(teasession._strCommunity,sql.toString(),pos,10);
          int index = pos+1;
          while(e.hasMoreElements())
          {
            int certificate =((Integer)e.nextElement()).intValue();
            Certificate obj = Certificate.find(certificate);

            %>

            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td align="center"><%=index %></td>
              <td ><a href="/jsp/admin/certificate/CertificateShow.jsp?certificate=<%=certificate%>" target="_blank"><%=obj.getCardname()%></a></td>
              <td align="center" >
              <%
              if(obj.getOriginalname()!=null && obj.getOriginalname().length()>0){
                %>
                <a href="/jsp/include/DownFile.jsp?uri=<%=java.net.URLEncoder.encode(obj.getOriginalurl(),"UTF-8")%>&name=<%=java.net.URLEncoder.encode(obj.getOriginalname(),"UTF-8")%>"><%=obj.getOriginalname() %></a>　
                <%
                }else{out.print("暂无正本原件");}
                %>
                </td>
                <td align="center" >
                <%
                if(obj.getCopyname()!=null && obj.getCopyname().length()>0){
                  %>
                  <a href="/jsp/include/DownFile.jsp?uri=<%=java.net.URLEncoder.encode(obj.getCopyurl(),"UTF-8")%>&name=<%=java.net.URLEncoder.encode(obj.getCopyname(),"UTF-8")%>"><%=obj.getCopyname() %></a>　
                  <%
                  }else{out.print("暂无副本原件");}
                  %>
                  </td>
                  <td align="center"> <%=obj.getFztimeToString()%></td>
                  <td align="center" ><%=obj.getYxtimeToString()%>  </td>
                  <%
                  if(show>=0){
                    %>
                    <td align="center" ><input  type ="button"  value="编辑" onClick="editimd('<%=certificate%>');">
                      <input type=button value="删除"  onClick="deleteimd('<%=certificate%>');">            </td>
            </tr>
            <%
            }
            index++;
          }
          if(count>size){
            %>
            <tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

            <%}%>
      </table>

      <br>
      <% if(show>=0){ %>
      <input  type ="button" name="" value="添加公司证照" onClick="editimd(0);">
      <input  type ="button" name="" value="导出Excel表" onClick="kind(0);">
      <%}%>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <script language="JavaScript">
  anole('',1,'','','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
  </body>
</html>
