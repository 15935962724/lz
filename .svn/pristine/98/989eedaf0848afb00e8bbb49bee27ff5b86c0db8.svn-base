<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%>
<%@page import="net.*"%><%

Http h=new Http(request);
TeaSession teasession = new TeaSession(request);

int node=h.getInt("node");
String subject=null,code=null,content=null;
Node n=Node.find(node);
if(n.getType()>1)
{
  subject=n.getSubject(teasession._nLanguage);
  content=n.getText(teasession._nLanguage);

  Stock t=Stock.find(node); 
  code=t.code;
}


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>股票 添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditStock" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="act" value="edit"/>
<table id="tablecenter">
  <tr>
    <td>股票名称</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" alt="名称" size="40"/></td>
  </tr>
  <tr>
    <td>股票代码</td>
    <td><input name="code" value="<%=MT.f(code)%>" alt="代码"/></td>
  </tr>
  <tr>
    <td>股票简介</td>
    <td>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/> <input name="list" type="submit" value="历史数据管理" />
</form>

<%--
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
      <tr id="tableonetr">
        <td colspan="20"><%=r.getString(teasession._nLanguage,"StockGraph")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,"GraphWeek")%></td>
        <td><input name="graphweek" ondblclick="" type="file" id="graphweek">
        <%
        if(graphweek!=null)
        {
          long len=new java.io.File(application.getRealPath(graphweek)).length();
          if(len>0)
          {
            out.print("<A HREF="+graphweek+" target=_blank >"+len+r.getString(teasession._nLanguage,"Bytes")+"</A>");
          }
        }
        %>
        </td>
      <tr>
        <td><%=r.getString(teasession._nLanguage,"GraphMonth")%></td>
        <td><input name="graphmonth" ondblclick="" type="file" id="graphmonth">
                <%
        if(graphmonth!=null)
        {
          long len=new java.io.File(application.getRealPath(graphmonth)).length();
          if(len>0)
          {
            out.print("<A HREF="+graphmonth+" target=_blank >"+len+r.getString(teasession._nLanguage,"Bytes")+"</A>");
          }
        }
        %>
        </td>
      <tr>
        <td><%=r.getString(teasession._nLanguage,"GraphYear")%></td>
        <td><input name="graphyear" ondblclick="" type="file" id="graphyear">
        <%
        if(graphyear!=null)
        {
          long len=new java.io.File(application.getRealPath(graphyear)).length();
          if(len>0)
          {
            out.print("<A HREF="+graphyear+" target=_blank >"+len+r.getString(teasession._nLanguage,"Bytes")+"</A>");
          }
        }
        %></td>
      <tr>
        <td><%=r.getString(teasession._nLanguage,"GraphYet")%></td>
        <td><input name="graphyet" ondblclick="" type="file" id="graphyet">
        <%
        if(graphyet!=null)
        {
          long len=new java.io.File(application.getRealPath(graphyet)).length();
          if(len>0)
          {
            out.print("<A HREF="+graphyet+" target=_blank >"+len+r.getString(teasession._nLanguage,"Bytes")+"</A>");
          }
        }
        %></td>
      </tr>
    </table>
    <input type="submit" name="graph" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    --%>

</body>
</html>
