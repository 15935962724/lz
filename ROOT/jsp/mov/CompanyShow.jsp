<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%!


String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}

%>
<%

TeaSession teasession = new TeaSession(request);
Resource r = new Resource();

boolean _bNew=request.getParameter("NewNode")!=null;
r.add("/tea/resource/Company");
  Node node=Node.find(teasession._nNode);
Company  obj=Company.find(teasession._nNode);
String name;
String text;
String license=null,logo=null,picture=null;
int sequence;
int len=0,logolen=0,picturelen=0;


  name=node.getSubject(teasession._nLanguage);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));

  license=obj.getLicense(teasession._nLanguage);
  if(license!=null)
  len=(int)new File(application.getRealPath(license)).length();

  logo=obj.getLogo(teasession._nLanguage);
  if(logo!=null)
  logolen=(int)new File(application.getRealPath(logo)).length();

  picture=obj.getPicture(teasession._nLanguage);
  if(picture!=null)
  picturelen=(int)new File(application.getRealPath(picture)).length();
  sequence=node.getSequence();

String community=node.getCommunity();
%><HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>

<div id="head6" style="clear:both;"><img height="6" src="about:blank"></div>
<div  id="pathdiv" style="clear:both;"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM  name="form1">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr >
      <td nowrap >*单位:</td>
      <td colspan="2"><%=(name)%></td>
    </tr>
    <tr>
      <td>logo:</td>
      <td colspan="2">
          <%
          if(logolen>0)
          {
           // out.print("<a href="+logo+" target=_blank>"+logolen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<img src='"+logo+"' width=100>");
          }
          %>
      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td colspan="2">

          <%
          if(picturelen>0)
          {
            //out.print("<a href="+picture+" target=_blank>"+picturelen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<img src='"+picture+"' width=100 >");
          }
          %>

      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "上级单位")%>:</td>
      <td colspan="2">
        <%
        Node n = Node.find(obj.getSuperior(teasession._nLanguage));
        out.print(getNull(n.getSubject(teasession._nLanguage)));
        %>
       </td>
    </tr>

          <tr>
        <td nowrap><%=r.getString(teasession._nLanguage, "公司简介")%>:</td>
        <td><%=text%> </td>
      </tr>

    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
      <td><%=getNull(obj.getContact(teasession._nLanguage))%></td>
    </tr>

    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><%=getNull(obj.getEmail(teasession._nLanguage))%></td>
    </tr>
      <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
      <td><%=getNull(obj.getTelephone(teasession._nLanguage))%></td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
      <td><%=getNull(obj.getFax(teasession._nLanguage))%></td>
    </tr>
      <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
      <td><%=getNull(obj.getZip(teasession._nLanguage))%></td>
    </tr>
       <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "省份")%>:</td>
      <td>

              <%
              if(obj.getState(teasession._nLanguage)!=null && obj.getState(teasession._nLanguage).length()>0)
              {
                Card co = Card.find(Integer.parseInt(obj.getState(teasession._nLanguage)));
                out.print(co.getAddress()+"--");
                Card co2 = Card.find(obj.getCity(teasession._nLanguage));
              	out.print(co2.getAddress());
              }
      %>
       </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td colspan="2"><%=HtmlElement.htmlToText(getNull(obj.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "公司网址")%>:</td>
      <td colspan="2"><%=getNull(obj.getWebPage(teasession._nLanguage))%></td>
    </tr>
  </table>
  <input type="button" value="关闭"  onClick="javascript:window.close();">
</form>
</body>
</HTML>
