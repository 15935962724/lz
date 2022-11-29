<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.node.Poll"%>
<%@page import="tea.html.*"%>
<%@page import="tea.htmlx.Go"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.TeaServlet"%>
<%@page import="tea.ui.TeaSession"%>
<%!private String getCheck(boolean i)  {
      if (i)
      {
		return "checked";
      }
	  else
	  { return "";}
       }
private String getNull(String Null)
{
return Null==null?"":Null;
}
%>
<%response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaServlet ts=new TeaServlet();
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{response.sendRedirect("/servlet/StartLogin");
return;
} Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            int i = node.getOptions1();
 Poll poll = Poll.find(teasession._nNode);


       %>


<html>
<head>
<LINK REL=StyleSheet HREF=/tea/tea.css TYPE=text/css MEDIA=screen>
<script src="/tea/tea.js" type="text/javascript"></script>
</head>



<DIV ID=HeaderDiv>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD COLSPAN=3></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD></TD>
      <TD></TD>
    </TR>
    <TR ID=Header2>
      <TD COLSPAN=3></TD>
    </TR>
  </TABLE>
</DIV>
<DIV ID=BodyDiv>
  <TABLE ID=BodyTable>
    <TR>
      <TD><%=node.getAncestor(teasession._nLanguage)%>

 <FORM NAME=foEdit METHOD=POST action="/servlet/EditPoll">
          <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
          <TABLE CELLSPACING=0 CELLPADDING=0>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Question")%>:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text"></TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>A:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>B:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>C:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>D:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>E:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
            <TR>
              <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Choice")%>F:</TD>
              <TD><input name=""  id="CHECKBOX" type="CHECKBOX" value=""><%=r.getString(teasession._nLanguage, "Show")%>
			  <%=r.getString(teasession._nLanguage, "BeforeItem")%><input name="" type="text">
			  <%=r.getString(teasession._nLanguage, "AfterItem")%><input name="" type="text">&nbsp;</TD>
            </TR>
          </TABLE>
          <P ALIGN=CENTER>
            <INPUT TYPE=SUBMIT NAME="GoBack" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
            <INPUT TYPE=SUBMIT NAME="GoFinish" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
          </P>
        </FORM>
        <SCRIPT>document.foEdit.Question.focus();</SCRIPT>
		<%=new Languages(teasession._nLanguage,request)%>
		</TD>
    </TR>
  </TABLE>
</DIV>
<FONT ID=FooterDiv> </html>


