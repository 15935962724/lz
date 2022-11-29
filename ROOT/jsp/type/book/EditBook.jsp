<%@page import="tea.entity.sup.SupQualification"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
String community=node.getCommunity();

//权限
Category cat = Category.find(teasession._nNode);
int type = node.getType();
if(type == 1)
{
  type = cat.getCategory();
}
if(!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode,teasession._rv._strV).isProvider(type))
{
  response.sendError(403);
  return;
}

Book book = Book.find(teasession._nNode);

String subject=null,content=null,authorMsg=null,chapterMsg=null;
String smallpicture=null,bigpicture=null;
int len_sp=0,len_bp=0,format=0,binding=0,inventory;
if(node.getType()>1)
{
  subject=node.getSubject(teasession._nLanguage);
  content=node.getText(teasession._nLanguage);
  authorMsg=book.getAuthorMsg(teasession._nLanguage);
  chapterMsg=book.getChapterMsg(teasession._nLanguage);
  //
  format=book.getFormat();
  binding=book.getBinding();
  smallpicture=book.getSmallPicture(teasession._nLanguage);
  bigpicture=book.getBigPicture(teasession._nLanguage);

  if(smallpicture!=null&&smallpicture.length()>0)
  {
    len_sp=(int)new File(application.getRealPath(smallpicture)).length();
  }
  if(bigpicture!=null&&bigpicture.length()>0)
  {
    len_bp=(int)new File(application.getRealPath(bigpicture)).length();
  }
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onLoad="form1.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "CBEditBook")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name="form1" action="/servlet/EditBook" METHOD=POST ENCTYPE="multipart/form-data" onSubmit="
  return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')
  &&submitText(this.isbn, '<%=r.getString(teasession._nLanguage, "InvalidISBN")%>')
  &&submitInteger(this.amountword, '<%=r.getString(teasession._nLanguage, "InvalidAmountWord")%>')
  &&submitInteger(this.amountpage, '<%=r.getString(teasession._nLanguage, "InvalidAmountPage")%>')
  &&submitFloat(this.price, '<%=r.getString(teasession._nLanguage, "InvalidPrice")%>')
  &&submitInteger(this.reprint, '<%=r.getString(teasession._nLanguage, "InvalidReprint")%>')
  &&submitText(this.publisher, '<%=r.getString(teasession._nLanguage, "InvalidPublisher")%>');">
  <input type='hidden' name='community' value="<%=teasession._strCommunity%>">
  <input type='hidden' name='node' value="<%=teasession._nNode%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td nowrap>*<%=r.getString(teasession._nLanguage, "Subject")%>:</TD>
    <td colspan="4" nowrap><input name="subject" size=70 maxlength=255 class="edit_input" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"/></td>
	</tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ISBN")%>:</td>
      <td><input class="edit_input"  name="isbn" SIZE=40 MAXLENGTH=40 value="<%=getNull(book.getISBN())%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "分类")%>:</td>
      <TD ><select name="booktype">
      <%=
       SupQualification.options(14011146, book.getType())
      %>
      </select></TD>
      <td><%=r.getString(teasession._nLanguage, "商品毛重")%>:</td>
      <td><input class="edit_input"  name=weight value="<%=book.getWeight()==null?"0":book.getWeight() %>" mask="int"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Format")%>:</td>
      <td><select name="specifications">
      <%
      for(int i=0;i<Book.BOOK_SFC.length;i++)
      {
        out.print("<option value="+i);
        if(book.getSpecifications()==i)out.print(" selected='true'");
        out.print(">"+r.getString(teasession._nLanguage, Book.BOOK_SFC[i]));
      }
      %>
        </select></td>
      <td><%=r.getString(teasession._nLanguage, "Binding")%>:</td>
      <td><select name="binding">
       <%
      for(int i=0;i<Book.BOOK_BINDING.length;i++)
      {
        out.print("<option value="+i);
        if(binding==i)out.print(" selected='true'");
        out.print(">"+r.getString(teasession._nLanguage, Book.BOOK_BINDING[i]));
      }
      %>
      </select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AmountWord")%>:</td>
      <td><input class="edit_input"  name=amountword value="<%=book.getAmountWord()%>" mask="int"></td>
      <td><%=r.getString(teasession._nLanguage, "AmountPage")%>:</td>
      <td><input class="edit_input"  name=amountpage value="<%=book.getAmountPage()%>" mask="int"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
      <td><input class="edit_input"  name=price value="<%=getNull(book.getPrice())%>" mask="int"></td>
      <td><%=r.getString(teasession._nLanguage, "Reprint")%>:</td>
      <td><input class="edit_input"  name=reprint VALUE="<%=book.getReprint()%>"></td>
    </tr>
    <tr>
      <td>作者
        <%//=r.getString(teasession._nLanguage, "SubTitle")%>
        :</td>
      <td ><input class="edit_input"  name=subtitle SIZE=60 MAXLENGTH=255 value="<%=getNull(book.getSubTitle(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "库存")%>:</td>
      <td><input class="edit_input"  name=inventory value="<%=book.getInventory() %>" mask="int"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Publisher")%>:</td>
      <td><input class="edit_input"  name=publisher SIZE=40 MAXLENGTH=40 value="<%=getNull(book.getPublisher(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "PublishDate")%>:</td>
      <td><%=new TimeSelection("publish", book.getPublishDate(), false, false)%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "版次")%>:</td>
      <td><input class="edit_input"  name=edition SIZE=40 MAXLENGTH=40 value="<%=getNull(book.getEdition(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "印张")%>:</td>
      <td><input class="edit_input"  name=transfer value="<%=book.getTransfer(teasession._nLanguage) %>" mask="int"></td>
    </tr>
    
    <tr>
      <td><%=r.getString(teasession._nLanguage, "CIPI")%>:</td>
      <td><input class="edit_input"  name=cipi SIZE=40 MAXLENGTH=40 value="<%=getNull(book.getCIPI(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "CIPII")%>:</td>
      <td><input class="edit_input"  name=cipii SIZE=40 MAXLENGTH=40 value="<%=getNull(book.getCIPII(teasession._nLanguage))%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "CIPIII")%>:</td>
      <td><input class="edit_input"  name=cipiii SIZE=40 MAXLENGTH=255 value="<%=getNull(book.getCIPIII(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "CIPIV")%>:</td>
      <td><input class="edit_input"  name=cipiv SIZE=40 MAXLENGTH=255 value="<%=getNull(book.getCIPIV(teasession._nLanguage))%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Reader")%>:</td>
      <td><input class="edit_input"  name=reader SIZE=40 MAXLENGTH=255 value="<%=getNull(book.getReader(teasession._nLanguage))%>"></td>
      <td><%=r.getString(teasession._nLanguage, "Collection")%>:</td>
      <td><input class="edit_input"  name=collection SIZE=40 MAXLENGTH=255 value="<%=getNull(book.getCollection(teasession._nLanguage))%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Annotation")%>:</td>
      <TD colspan="4" ><input NAME=annotation  class="edit_input"  SIZE=60 MAXLENGTH=255 value="<%=getNull(book.getAnnotation(teasession._nLanguage))%>"></TD>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "SmallPicture")%></td>
      <TD><input TYPE="FILE" NAME="smallpicture">
      <%
      if(len_sp>0)
      {
        out.print("<a target=_blank href="+smallpicture+">"+len_sp+r.getString(teasession._nLanguage,"Bytes")+"</a><input name=clearsmallpicture id=CHECKBOX type=CHECKBOX onclick='form1.smallpicture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %></TD>
      <td><%=r.getString(teasession._nLanguage, "BigPicture")%></td>
      <TD><input TYPE="FILE" NAME="bigpicture">
        <%
        if(len_bp>0)
        {
          out.print("<a target=_blank href="+bigpicture+">"+len_bp+r.getString(teasession._nLanguage,"Bytes")+"</a><input name=clearbigpicture id=CHECKBOX type=CHECKBOX onclick='form1.bigpicture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
        }
       %>       </td>
    </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "Text")%>:</TD>
    <td colspan="4" nowrap>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%if(content!=null)out.print(content.replaceAll("<","&lt;"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "作者简介")%>:</TD>
    <td colspan="4" nowrap>
      <textarea style="display:none" name="authorMsg" rows="12" cols="90" class="edit_input"><%if(authorMsg!=null)out.print(authorMsg.replaceAll("<","&lt;"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=authorMsg&Toolbar=<%=community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "章节目录")%>:</TD>
    <td colspan="4" nowrap>
      <textarea style="display:none" name="chapterMsg" rows="12" cols="90" class="edit_input"><%if(chapterMsg!=null)out.print(chapterMsg.replaceAll("<","&lt;"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=chapterMsg&Toolbar=<%=community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>    </td>
  </tr>
  </table>
  <P ALIGN=CENTER>
    <input type="submit" name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
  </P>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
