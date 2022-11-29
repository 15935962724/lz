<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>

<%
Resource r = new Resource();
r.add("/tea/resource/Download");

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Download")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form action="/servlet/EditDownload" method="POST" enctype="multipart/form-data" name="foNew" onSubmit="return submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>');" >
  <%
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
            tea.entity.node.Download download=Download.find(0,1);
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String subject="",text="",Keywords="";
            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {
          subject=node.getSubject(teasession._nLanguage);
          text=node.getText(teasession._nLanguage);
         download=Download.find(teasession._nNode,teasession._nLanguage);
          Keywords=node.getKeywords(teasession._nLanguage);
        }
            %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <h2><%=r.getString(teasession._nLanguage, "Download")%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:&nbsp;</td>
      <td colspan="20"><input type="TEXT" class="edit_input"  name=Subject value="<%=HtmlElement.htmlToText(subject)%>" size=70 maxlength=255>
        <font color=#ff0000>(*)</font></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Keywords")%>:</td>
      <td colspan="20"><input type="TEXT" class="edit_input"  name="Keywords" value="<%=Keywords%>" size="70" maxlength="255">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Languages")%>:&nbsp;</td>
      <td colspan="20"><select name="language" >
          <option value=-1>未知
          <%
        for(int index=0;index<tea.resource.Common.LANGUAGE.length;index++)
        {
          out.print("<OPTION value="+index+" "+(index==download.getLanguage()?" SELECTED ":"")+" >"+r.getString(teasession._nLanguage,tea.resource.Common.LANGUAGE[index])+"</OPTION>");
        }
        %>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Commend")%>:&nbsp;</td>
      <td colspan="20"><select name=commend>
          <%
            for(int index=0;index<=5;index++)
            {
              StringBuffer sbcommend=new StringBuffer();
              for(int commend=index;commend>0;commend--)
              {
                sbcommend.append("★");//★☆
              }
              out.print("<OPTION value="+index+" "+(index==download.getCommend()?" SELECTED ":"")+">"+sbcommend.toString()+"</OPTION>");
            }%>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Developer")%>:&nbsp;</td>
      <td colspan="20"><input type="text"  class="edit_input"  maxlength="50" size="50" name="developer" value="<%=getNull(download.getDeveloper())%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:&nbsp;</td>
      <td colspan="20"><input type="file" onDblClick="showModalDialog('<%=download.getPicture()%>');"  class="edit_input"  maxlength="50" name="picture" >
        <%if(download.getPicture()!=null&&download.getPicture().length()>0)out.print(new java.io.File(application.getRealPath(download.getPicture())).length());%>
        <%=r.getString(teasession._nLanguage, "Bytes")%>
        <input name="pictureurl" type="text" class="edit_input"   value="<%=getNull(download.getPicture())%>" size="50" maxlength="80"/>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Small")%>:&nbsp;</td>
      <td colspan="20"><input type="file" onDblClick="showModalDialog('<%=download.getSmall()%>');"  class="edit_input"  maxlength="50" name="small" >
        <%if(download.getSmall()!=null&&download.getSmall().length()>0)out.print(new java.io.File(application.getRealPath(download.getSmall())).length());%>
        <%=r.getString(teasession._nLanguage, "Bytes")%>
        <input name="smallurl" type="text" class="edit_input"   value="<%=getNull(download.getSmall())%>" size="50" maxlength="80"/>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:&nbsp;</td>
      <td colspan="20"><textarea  class="edit_input"  rows="8" cols="70"  name="text" ><%=HtmlElement.htmlToText(text)%></textarea>
      </td>
    </tr>
    <%--
      <tr>
      <td>URL:</td>
      <td><input type="text"  class="edit_input" size="80"  name="url" value="<%=HtmlElement.htmlToText(download.getUrl())%>"></td>
    </tr>--%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Size")%>:</td>
      <td colspan="20"><input type="text"  class="edit_input" name="size" value="<%=download.getSize()%>">
        K </td>
    </tr>
    <tr>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>1:</td>
      <td><input name="software1" type="text"  class="edit_input" value="<%=download.getSoftware()[0]%>" size="8">
      </td>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>2:</td>
      <td><input name="software2" type="text"  class="edit_input" value="<%=download.getSoftware()[1]%>" size="8">
      </td>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>3:</td>
      <td><input name="software3" type="text"  class="edit_input" value="<%=download.getSoftware()[2]%>" size="8">
      </td>
    </tr>
    <tr>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>4:</td>
      <td><input name="software4" type="text"  class="edit_input" value="<%=download.getSoftware()[3]%>" size="8">
      </td>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>5:</td>
      <td><input name="software5" type="text"  class="edit_input" value="<%=download.getSoftware()[4]%>" size="8">
      </td>
      <td>相关<%=r.getString(teasession._nLanguage, "Software")%>6:</td>
      <td><input name="software6" type="text"  class="edit_input" value="<%=download.getSoftware()[5]%>" size="8">
      </td>
    </tr>
    <tr>
      <td colspan="20"><hr size="1"></td>
    </tr>
    <tr>
      <td>相关<%=r.getString(teasession._nLanguage, "Article")%>1:</td>
      <td colspan="3"><input name="article1" type="text"  class="edit_input" value="<%if(download.getArticle()[0]!=null)out.print(download.getArticle()[0]);%>" size="30" >
<input name="article2" type="text"  class="edit_input" value="<%if(download.getArticle()[1]!=null)out.print(download.getArticle()[1]);%>" >
      </td>
          </tr>
    <tr>
      <td>相关<%=r.getString(teasession._nLanguage, "Article")%>2:</td>
      <td colspan="3"><input name="article3" type="text"  class="edit_input" value="<%if(download.getArticle()[2]!=null)out.print(download.getArticle()[2]);%>" size="30">
        <input name="article4" type="text"  class="edit_input" value="<%if(download.getArticle()[3]!=null)out.print(download.getArticle()[3]);%>" >
      </td>
    </tr>
    <tr>
      <td>相关<%=r.getString(teasession._nLanguage, "Article")%>3:</td>
      <td colspan="3"><input name="article5" type="text"  class="edit_input" value="<%if(download.getArticle()[4]!=null)out.print(download.getArticle()[4]);%>" size="30">
        <input name="article6" type="text"  class="edit_input" value="<%if(download.getArticle()[5]!=null)out.print(download.getArticle()[5]);%>" >
      </td>
    </tr>
  </table>
  <center>
    <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
    <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input type=SUBMIT name="urladdress" id="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  </center>
</form>
<script>document.foNew.Subject.focus();</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

