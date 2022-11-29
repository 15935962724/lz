<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="javax.servlet.ServletConfig" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.html.HtmlElement"%>
<%!
String getCheck(boolean bool)
{
  return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
  return value!=0?" CHECKED ":" ";
}
String getNull(String strNull)
{	return strNull==null?"":strNull;
}%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
Node   node=Node.find(teasession._nNode);

if(teasession._rv==null)
{
  out.print("<script>window.open('/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")+"','_self');</script>");
  return;
}
if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(73))
  {
    response.sendError(403);
    return;
  }
}


Resource r = new Resource("/tea/resource/Interlocution");

String urlnode = teasession.getParameter("urlnode");// 问题提交成功提示页面


String community = teasession._strCommunity;
%>
<body onLoad="document.foEdit.Subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "EditInterlocution")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <br>
  <FORM NAME=foEdit METHOD=POST action="/servlet/EditInterlocution"  onSubmit="return(submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
    <INPUT TYPE=HIDDEN NAME=Node VALUE="<%=teasession._nNode%>">
    <input type=hidden name="urlnode" value="<%=urlnode %>">
    <%
    String nexturl=request.getParameter("nexturl");
    if(nexturl!=null)
    out.println(new tea.html.HiddenField("nexturl",nexturl));


    String subject=null,text=null;
    int hint=0;

    String email=null,mobile=null,name=null,phone=null,member=null;
    float integral=0;
    int offerintegral=0 ;
    int types=0;
    if(request.getParameter("NewNode")!=null)
    {
      out.println(new tea.html.HiddenField("NewNode","ON"));
      if(teasession._rv!=null)
      {
        tea.entity.member.Profile obj=    tea.entity.member.Profile.find(teasession._rv._strV);
        member = teasession._rv.toString();
        email=obj.getEmail();
        mobile=obj.getMobile();
        name=obj.getFirstName(teasession._nLanguage);
        phone=obj.getTelephone(teasession._nLanguage);
        integral=obj.getIntegral();
      }
    }else
    {
      tea.entity.node.Interlocution obj=  tea.entity.node.Interlocution.find(teasession._nNode,teasession._nLanguage);
      member  = obj.getMember();
      tea.entity.member.Profile  pro = tea.entity.member.Profile.find(member);
      subject=node.getSubject(teasession._nLanguage);
      text=node.getText(teasession._nLanguage);
      hint=obj.getHint();
      email=obj.getEmail();
      mobile=obj.getMobile();
      name=  obj.getName();
      phone=obj.getPhone();
      types = obj.getTypes();
      offerintegral = obj.getOfferintegral();
      integral = pro.getIntegral();
    }
    %>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <input type="hidden" value="<%=member%>" name="member">
      <TR id="edittalikback2">
        <TD><%=r.getString(teasession._nLanguage, "CcMembers")%>:</TD>
        <TD><INPUT NAME=Cc TYPE=TEXT class="edit_input" VALUE="" SIZE=40 MAXLENGTH=255></TD>
      </TR>
      <TR id="edittalikback3">
        <TD><%=r.getString(teasession._nLanguage, "Bcc")%>:</TD>
        <TD><INPUT NAME=Bcc TYPE=TEXT class="edit_input" VALUE="" SIZE=40 MAXLENGTH=255></TD>
      </TR>
      <TR id="edittalikback4">
        <TD><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
        <TD>
          <INPUT  id=CHECKBOX type="CHECKBOX" NAME=MsgOSendEmail VALUE=null <%=getCheck(false)%>>
            <%=r.getString(teasession._nLanguage, "SameSendE-MAIL")%></TD>
      </TR>
      <tr id="edittalikback_name">
        <TD><%=r.getString(teasession._nLanguage, "Name")%> </TD>
        <td><input name="name" type="text" value="<%=getNull(name)%>">
        </td>
      </tr>
      <tr id="edittalikback_phone">
        <TD><%=r.getString(teasession._nLanguage, "phone")%> </TD>
        <td><input name="phone" type="text" value="<%=getNull(phone)%>">
        </td>
      </tr>
      <tr id="edittalikback_mobile">
        <TD><%=r.getString(teasession._nLanguage, "mobile")%> </TD>
        <td><input name="mobile" type="text" value="<%=getNull(mobile)%>">
        </td>
      </tr>
      <tr id="edittalikback_integral">
        <TD id="integral_007"><%=r.getString(teasession._nLanguage, "integral")%> </TD>
        <input type="hidden" name="integral" value="<%=integral%>">
        <td><%=integral%>
        </td>
      </tr>
      <tr id="edittalikback_offerintegral">
        <TD><%=r.getString(teasession._nLanguage, "offerintegral")%> </TD>
        <td>
        <%if(offerintegral!=0)
        {
          out.print("<input name=offerintegral type=hidden value="+offerintegral+">");
          out.print(offerintegral);
        }
        else
        {
          %>
          <input name="offerintegral" type="text" value="<%=offerintegral%>">
          <%
          }
          %>
          </td>
      </tr>
      <tr id="edittalikback_types">
        <td>类别：</td>
        <td><select  name="types"  >
        <%
        java.util.Enumeration enumers = InterlocutionType.findall();
        for(int index = 1 ; enumers.hasMoreElements();index++)
        {
          int  idnum = Integer.parseInt(enumers.nextElement().toString());
          InterlocutionType inttypes =  InterlocutionType .find(idnum);
          if(index==types)
          {
            out.print("<option value="+idnum+" selected >"+inttypes.getTypes()+"</option>");
          }
          else 
          {
            out.print("<option value="+idnum+">"+inttypes.getTypes()+"</option>");
          }
        }
        %>

</select>
<%
if(teasession._rv._strV.equals("webmaster")) 	 	
{
  %>

  <input type="button" name="createtype" value="创建类别"  onClick="window.open('/jsp/type/interlocution/InterlocutionType.jsp','_blank');"/>
  <%

}

%></td>
</tr>

<tr id="edittalikback_email">
  <TD>E-Mail </TD>
  <td><input name="email" type="text" value="<%=getNull(email)%>">
  </td>
</tr>
<TR id="edittalikback5">
  <TD><%=r.getString(teasession._nLanguage, "Hint")%>:</TD>
  <TD>
      <%
      for(int i=0;i<12;i++)
      {
        out.print("<input id='radio' type='radio' name='Hint' value='"+i+"' ");
        if(hint==i)out.print(" checked='true'");
        out.print("><img src='/tea/image/hint/"+i+".gif'>");
      }
      %>
  </TD>
</TR>
<tr id="edittalikback_qutext">
  <TD><%=r.getString(teasession._nLanguage, "qutext")%>:</TD>
  <TD><INPUT NAME=Subject TYPE=TEXT class="edit_input" VALUE="<%=getNull(subject)%>" SIZE=70 MAXLENGTH=255></TD>
</TR>
<tr id="edittalikback_qucontent">
  <TD><%=r.getString(teasession._nLanguage, "qucontent")%>:</TD>
  <TD><TEXTAREA NAME="Text" COLS=60 ROWS=8 class="edit_input"><%=HtmlElement.htmlToText(text)%></TEXTAREA></TD>
</TR>
</TABLE>
<INPUT TYPE=SUBMIT class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <div id="language"> <%=new Languages(teasession._nLanguage,request)%> </DIV>





