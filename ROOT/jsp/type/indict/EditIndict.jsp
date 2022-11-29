<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Indict");
%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
  <script type="">
  function fsubmit(form1)
  {
    if(!submitText(form1.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))
    {
      return false;
    }
    if(!submitText(form1.appellee, '被投诉人 无效'))
    {
        return false;
    }
    if(form1.sorder.selectedIndex==0)
    {
      alert('投诉发生订单 无效');
      form1.sorder.focus();
      return false;
    }
    return true;
  }
  </script>
  </head>
  <body><h1><%=r.getString(teasession._nLanguage, "EditIndict")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" METHOD="post" ACTION="/servlet/EditIndict" onsubmit="return fsubmit(this)">
     <%
          String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String text="",subject="",appellee="";
    int sorder=0;
            if(request.getParameter("NewNode")!=null)
            {
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
              }else
              {
                text=node.getText(teasession._nLanguage);
                subject=node.getSubject(teasession._nLanguage);
                tea.entity.node.Indict indict= tea.entity.node.Indict .find(teasession._nNode,teasession._nLanguage);
                appellee=indict.getAppellee();
                sorder=indict.getSorder();
              }
            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Subject")%></TD>
      <TD><INPUT NAME="subject" TYPE="text" value="<%=HtmlElement.htmlToText(subject)%>" SIZE="70">
        *</TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Appellee")%></TD>
      <TD> <INPUT NAME="appellee" TYPE="text" value="<%=appellee%>" SIZE="70" MAXLENGTH="100">
        * </TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "SOrder")%></TD>
      <TD><SELECT NAME="sorder">
          <OPTION VALUE="0" SELECTED>----请选择----</OPTION>
          <%
for(int index=tea.entity.node.SOrder.TRADE_STATUS.length-1;index>=0;index--)
{
  java.util.Enumeration enumer=tea.entity.node.SOrder.find(teasession._rv,index,0,100);
  while(enumer.hasMoreElements())
  {
    int enumer_sorder=((Integer)enumer.nextElement()).intValue();
    out.print ("<OPTION ");
    if(sorder==enumer_sorder)
    out.print("SELECTED");
    out.print(">"+enumer_sorder+"</OPTION>");
  }
}%>
        </SELECT>
        *</TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage, "Text")%></TD>
      <TD><TEXTAREA NAME="text" COLS="60" ROWS="6"><%=HtmlElement.htmlToText(text)%></TEXTAREA></TD>
    </TR>
  </TABLE>
  <INPUT TYPE="submit" NAME="Submit" VALUE="Submit">
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script>form1.subject.focus();</script>

</body>
</html>

