<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String code=(request.getParameter("code"));
if(code!=null&&code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  param.append("&code="+java.net.URLEncoder.encode(code,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
  param.append("&subject="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
  param.append("&type="+java.net.URLEncoder.encode(type,"UTF-8"));
}

String fromplanyear=(request.getParameter("fromplanyear"));
if(fromplanyear!=null&&fromplanyear.length()>0)
{
  sql.append(" AND planyear>="+fromplanyear);
  param.append("&fromplanyear="+java.net.URLEncoder.encode(fromplanyear,"UTF-8"));
}

String toplanyear=(request.getParameter("toplanyear"));
if(toplanyear!=null&&toplanyear.length()>0)
{
  sql.append(" AND planyear<"+toplanyear);
  param.append("&toplanyear="+java.net.URLEncoder.encode(toplanyear,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=Csvdogservice.count(teasession._strCommunity,sql.toString());



String order=request.getParameter("order");
if(order==null)
order="sequence";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);



%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <body>

  <h1>服务管理</h1>
  <br>
  <h2>查询</h2>
  <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
    <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
    <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
    <input type=hidden name="order" value="<%=order%>"/>
    <input type=hidden name="desc" value="<%=desc%>"/>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>名称
          <input name="name" value="<%if(name!=null)out.print(name);%>">
          <input type="submit" value="查询"/></td></tr>
    </table>
</form>

<FORM name=form2 METHOD=get action="?" onSubmit="">
  <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
  <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
  <input type=hidden name="csvdogservice" value="0"/>
  <input type=hidden name="act" value=""/>
  <input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

  <h2>列表(<%=count%>)</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap width="1"></td>
      <td nowrap>
      <%
      if("name".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=name&"+param.toString()+" >名称</a>");
      }
      %></td>
      <TD nowrap><%
      if("outlay".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >注册费用 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=outlay&"+param.toString()+" >注册费用</a>");
      }
      %></TD>
      <td>服务年费</td>
      <TD nowrap><%
      if("content".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >服务说明 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=content&"+param.toString()+" >服务说明</a>");
      }
      %></TD>
      <TD nowrap><%
      if("time".equals(order))
      {
        out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >时间 "+("desc".equals(desc)?"▼":"▲")+"</a>");
      }else
      {
        out.print("<A href="+request.getRequestURI()+"?order=time&"+param.toString()+" >时间</a>");
      }
      %></TD>
      <TD></td>
    </tr>
    <%

    java.util.Enumeration enumer=Csvdogservice.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    if(!enumer.hasMoreElements())
    {
      out.print("<tr><td colspan=7>暂无信息</td></tr>");
    }
    for(int index=1;enumer.hasMoreElements();index++)
    {
      int csvdogservice=((Integer)enumer.nextElement()).intValue();
      Csvdogservice obj=Csvdogservice.find(csvdogservice);
      Node noobj = Node.find(csvdogservice);


      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=index%></td>
        <td nowrap><%=Csvdogservice.FU_NAME[obj.getName()] %></td>
        <td><%=obj.getOutlay()%></td>
        <td><%=obj.getRegisteroutlay() %></td>

        <td>
        <%
        String log_content=noobj.getText(teasession._nLanguage).replaceAll("</","&lt;/");
        if(log_content.length()>25)
        out.print("<textarea style=display:none id=content_"+csvdogservice+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+csvdogservice+"').value);\" >"+log_content.substring(0,25)+"...</a>");//&#39;
        else
        out.print(log_content);
        %>&nbsp;</td>
        <td nowrap><%=obj.getTimeToString()%></td>




        <td nowrap>
          <a href="/jsp/type/csvservice/EditCsvdogservice.jsp?csvdogservice=<%=csvdogservice %>">编辑</a>
          <!--a href="/jsp/type/csvservice/EditCsvdogservice.jsp?csvdogservice=<%=csvdogservice %>&delete=delete" onClick="return window.confirm('您确定要删除此内容吗？');">删除</a-->
        </td>
      </tr>
      <%
      }
      %>
      <tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count)%></td></tr>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"添加")%>" onClick="location='/jsp/type/csvservice/EditCsvdogservice.jsp';">

</form>
<br>

  </body>
</html>



