<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
             String s = request.getParameter("URI");//request.getRequestURI();
            int i = 0;
            //if(s.endsWith("BookTranslator"))
              //  i = 1;
            String s1 = request.getParameter("Author");
            boolean flag = s1 == null;
            int j = teasession._nNode;
            if(!flag)
                j = Author.find(Integer.parseInt(s1)).getNode();
            Node node = Node.find(j);
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
			String s2 = "";
                int k = 0;
                if(!flag)
                {
                    tea.entity.node. Author author = tea.entity.node.Author.find(Integer.parseInt(s1));
                    s2 = author.getName(teasession._nLanguage);
                    k = author.getSequence();
                }

 %>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewAuthor")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=foNew METHOD=POST ACTION="/servlet/NewBookAuthor" onSubmit="return(submitText(this.Name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&submitInteger(this.Sequence,'<%=r.getString(teasession._nLanguage, "InvalidSequence")%>'));">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");

            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");

            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }
            %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><A href="/servlet/Search?type=<%=26%>" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Author")%>:</A> </td>
      <td><input type="TEXT" class="edit_input"  name=Name VALUE="<%=s2%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Sequence VALUE="<%=Integer.toString(k)%>"></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

