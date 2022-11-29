<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.*" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Lucene");

int clickhistory=Integer.parseInt(request.getParameter("clickhistory"));
int chd=Integer.parseInt(request.getParameter("clickhistorydetail"));

if(request.getMethod().equals("POST"))
{
  if(request.getParameter("delete")!=null)
  {
    ClickHistoryDetail obj=ClickHistoryDetail.find(chd);
    obj.delete(teasession._nLanguage);
  }else
  {
    int quantity=Integer.parseInt(request.getParameter("quantity"));
    int sequence=Integer.parseInt(request.getParameter("sequence"));
    int anchor=Integer.parseInt(request.getParameter("anchor"));

    String subject=(request.getParameter("subject"));
    String field=request.getParameter("field");
    String before=request.getParameter("before");
    String after=request.getParameter("after");
    if(chd<1)
    {
      ClickHistoryDetail.create(clickhistory,field,quantity,sequence,anchor,teasession._nLanguage,subject,before,after);
    }else
    {
      ClickHistoryDetail obj=ClickHistoryDetail.find(chd);
      obj.set(field,quantity,sequence,anchor,teasession._nLanguage,subject,before,after);
    }
  }
  response.sendRedirect("/jsp/util/clickhistory/EditClickHistoryDetail.jsp?community="+teasession._strCommunity+"&clickhistory="+clickhistory+"&clickhistorydetail=0");
  return;
}

String id=request.getParameter("id");

ClickHistory obj_ch=ClickHistory.find(clickhistory);
String field=null,subject=null,beforeitem=null,afteritem=null;
int quantity=0,sequence=0,anchor=0;
if(chd>0)
{
  ClickHistoryDetail obj_chd=ClickHistoryDetail.find(chd);
  field=obj_chd.getField();
  quantity=obj_chd.getQuantity();
  anchor=obj_chd.getAnchor();
  subject=obj_chd.getSubject(teasession._nLanguage);
  beforeitem=obj_chd.getBefore(teasession._nLanguage);
  afteritem=obj_chd.getAfter(teasession._nLanguage);
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "浏览历史细节")%></h1>
<div id="head6"><img height="6" alt=""></div>

<br>
<FORM name=form1 METHOD=POST action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="clickhistory" value="<%=clickhistory%>"/>
<input type="hidden" name="clickhistorydetail" value="<%=chd%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%></td><td><input name="subject" type="text" value="<%if(subject!=null)out.print(subject);%>">
    </td>
  </tr>
<tr>
<td><%=r.getString(teasession._nLanguage, "Field")%></td>
<td>
<select name="field">
<option value="" >-----------------------------
<%
out.print("<option value=subject ");
if("subject".equals(field))
out.print(" SELECTED ");
out.print(">"+r.getString(teasession._nLanguage,"Subject"));

out.print("<option value=content ");
if("content".equals(field))
out.print(" SELECTED ");
out.print(">"+r.getString(teasession._nLanguage,"Text"));

Enumeration e=Field.findByType(obj_ch.getType());
while(e.hasMoreElements())
{
  Field f=((Field)e.nextElement());
  String name=f.getName();
  out.print("<option value="+name);
  if(name.equals(field))
  out.print(" SELECTED ");
  out.print(">"+r.getString(teasession._nLanguage,f.getCapital()));
}
%>
</select>
</td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Quantity")%></td><td><input name="quantity" type="text"  value="<%=quantity%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;">
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Sequence")%></td><td><input name="sequence" type="text" value="<%=sequence%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;">
    </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Anchor")%></td><td><input name="anchor" type="radio" value="1" checked>有<input name="anchor" type="radio" value="0" <%if(anchor==0)out.print(" checked ");%>>无
    </td>
  </tr>
  <tr>
      <td><%=r.getString(teasession._nLanguage, "Before")%></td><td><textarea name="before" cols="50" rows="4"><%if(beforeitem!=null)out.print(beforeitem);%></textarea>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "After")%></td><td><textarea name="after" cols="50" rows="4"><%if(afteritem!=null)out.print(afteritem);%></textarea>
    </td>
  </tr>
  </table>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return(submitText(form1.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(form1.field,'<%=r.getString(teasession._nLanguage, "InvalidField")%>')&&submitInteger(form1.quantity,'<%=r.getString(teasession._nLanguage, "InvalidQuantity")%>')&&submitInteger(form1.sequence,'<%=r.getString(teasession._nLanguage, "InvalidSequence")%>'));">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td><%=r.getString(teasession._nLanguage, "Subject")%></td>
<td><%=r.getString(teasession._nLanguage, "Field")%></td>
<td><%=r.getString(teasession._nLanguage, "Sequence")%></td>
<td></td>
</tr>
<%
e=ClickHistoryDetail.findByClickHistory(clickhistory);
while(e.hasMoreElements())
{
  chd=((Integer)e.nextElement()).intValue();
  ClickHistoryDetail obj=ClickHistoryDetail.find(chd);

  %><tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td><%=obj.getSubject(teasession._nLanguage)%></td>
    <td><%=r.getString(teasession._nLanguage,obj.getField())%></td>
    <td><%=obj.getSequence()%></td>
    <td>
      <input type="button" onclick="window.open('?community=<%=teasession._strCommunity%>&id=<%=id%>&clickhistory=<%=clickhistory%>&clickhistorydetail=<%=chd%>','_self');" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>"/>
      <%
      if(obj.isLayerExists(teasession._nLanguage))
      {
        out.println("<input type=submit name=delete onclick=\"return confirm('"+r.getString(teasession._nLanguage, "ConfirmDeleteTree")+"');\" value="+r.getString(teasession._nLanguage,"CBDelete")+" />");
      }
      %>
</td>
</tr>
  <%
}
%></table>

</form>

<!--调用代码-->
<h2><%=r.getString(teasession._nLanguage, "调用代码")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><textarea cols="80" rows="5"><script src="/jsp/util/clickhistory/ViewClickHistory.jsp?community=<%=teasession._strCommunity%>&clickhistory=<%=clickhistory%>"></script></textarea></td></tr>
</table>

<br>
<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

