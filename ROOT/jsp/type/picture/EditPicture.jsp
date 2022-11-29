<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.math.BigDecimal" %>
<%@include file="/jsp/include/Header.jsp"%>
<%@page import="tea.html.*"%>
<%
Node node = Node.find(teasession._nNode);
if ((node.getOptions1() & 1) == 0)
{
  if (teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
  }
  if (!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode, teasession._rv._strV).isProvider(40))
  {
    response.sendError(403);
    return;
  }
} else
{
  if (teasession._rv == null)
  {
    teasession._rv = new tea.entity.RV("ANONYMITY", "Home");
  }
}

int type=node.getType();
boolean _bNew =request.getParameter("NewNode")!=null;

int j1 = 0;
Date date = null;
String subject="",keywords="",text="";
String s2="" ;
int s4=0 ;
String s5="" ;
String s6="" ; 
String s7="" ;
String picture="",small="";
String s8="" ;
String mark="";
BigDecimal price = new BigDecimal(0);
long lenpic=0,lentbn=0;
int width=0,height=0;
boolean mostly=false,mostly1=true,mostly2=true,meboole=false;
if(!_bNew)
{
  Picture p=Picture.find(teasession._nNode);
  keywords=node.getKeywords(teasession._nLanguage);
  subject=node.getSubject(teasession._nLanguage);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  s2=p.getAuthor(teasession._nLanguage);
  date=p.getDate(teasession._nLanguage);
  s4=p.getClass(teasession._nLanguage);
  s5=p.getAddress(teasession._nLanguage);
  s6=p.getNote(teasession._nLanguage);
  s7=p.getSave(teasession._nLanguage);
  s8=p.getCode(teasession._nLanguage);
  width=p.getWidth(teasession._nLanguage);
  height=p.getHeight(teasession._nLanguage);
  price=p.getPrice(teasession._nLanguage);
  picture="/res/"+node.getCommunity()+"/picture/"+teasession._nNode+".jpg";
  small="/res/"+node.getCommunity()+"/picture/small/"+teasession._nNode+".jpg";
  lenpic=new File(application.getRealPath(picture)).length();
  lentbn=new File(application.getRealPath(small)).length();
  mostly=node.isMostly();
  mostly1=node.isMostly1();
  mostly2=node.isMostly2();
  mark=node.getMark();
}else
{
  subject=keywords=text = "";
  s2 = "";
  s5 = "";
  s6 = "";
  s7 = "";
  s8 = String.valueOf(System.currentTimeMillis());
  picture=small="";
}

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "Picture")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name=form1 METHOD=POST action="/servlet/EditPicture" enctype="multipart/form-data" onSubmit="return(submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<%
if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}
%>
<input type='hidden' name=node VALUE="<%=teasession._nNode%>"/>
  <input type='hidden' name=Type VALUE="<%=request.getParameter("Type")%>"/>
    <input type='hidden' name=TypeAlias VALUE="<%=request.getParameter("TypeAlias")%>"/>
      <input type='hidden' name="width" value=""/>
      <input type='hidden' name="height" value=""/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
          <td><input type="TEXT" class="edit_input" name="subject" VALUE="<%=subject%>" SIZE=70 MAXLENGTH=255 ></td>
        </tr>
        <tr>
          <td><%=r.getString(teasession._nLanguage, "Keywords")%>:</td>
          <td COLSPAN=5><input type="TEXT" class="edit_input"  name="keywords" value="<%=keywords%>" size="30" maxlength="255"></td>
        </tr>

        <tr>
          <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
          <td COLSPAN=6><input type="file" name="picture" class="edit_input" />
          <%
          if(lenpic>0)
          {
            out.print("<a target='_blank' href="+picture+" >"+lenpic+r.getString(teasession._nLanguage,"Bytes")+"</a>");
            out.print("<input type='CHECKBOX' name='clearpicture' onClick='form1.picture.disabled=checked' />"+r.getString(teasession._nLanguage, "Clear"));
          }
          %> <input name="flag" type="checkbox" value="0" />添加水印
  </tr>
          </td>
        </tr>
        <tr>
          <td><%=r.getString(teasession._nLanguage, "缩略图")%>:</td>
          <td COLSPAN=6><input type="file" name="small" class="edit_input" />
          <%
          if(lentbn>0)
          {
            out.print("<a target='_blank' href="+small+" >"+lentbn+r.getString(teasession._nLanguage,"Bytes")+"</a>");
            out.print("<input type='CHECKBOX' name='clearsmall' onClick='form1.small.disabled=checked' />"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
          </td>
        </tr>

        <!--TD><%=r.getString(teasession._nLanguage, "index")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=index VALUE="<%=s8%>" SIZE=20 MAXLENGTH=20></td-->

          <tr>
            <td><%=r.getString(teasession._nLanguage, "Author")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Author VALUE="<%=tea.entity.Entity.getNULL(s2)%>" SIZE=30 MAXLENGTH=20></td>
          </tr>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Address VALUE="<%=tea.entity.Entity.getNULL(s5)%>" SIZE=30 MAXLENGTH=20></td>
          </tr>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "save")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Save VALUE="<%=tea.entity.Entity.getNULL(s7)%>" SIZE=30 MAXLENGTH=20></td>
            </tr>
            <tr>
            <td><%=r.getString(teasession._nLanguage, "价格")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=price VALUE="<%if(price!=null)out.print(price);%>" SIZE=30 MAXLENGTH=20></td>
            </tr>

            <tr>
              <td><%=r.getString(teasession._nLanguage, "class")%>:</td>
              <td colspan="3">
              <%
tea.html.DropDown dropdown1 = new tea.html.DropDown("Class",s4);
dropdown1.addOption(0,"-------------");
java.util.Enumeration enumer=tea.entity.node.Classes.findByCommunity(node.getCommunity(),teasession._nLanguage);
while(enumer.hasMoreElements())
{
  tea.entity.node.Classes class_obj=  tea.entity.node.Classes.find(((Integer)enumer.nextElement()).intValue());
  dropdown1.addOption(class_obj.getId(),class_obj.getName());
}
out.print(dropdown1.toString());

%>
<input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/NewClass?node=<%=teasession._nNode%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
<input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageClasses?node=<%=teasession._nNode%>', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
  <td COLSPAN=5>
    <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=text%></textarea>
    <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
  </td>
</tr>

<tr><td><%=r.getString(teasession._nLanguage, "Memo")%>:</td>
  <td COLSPAN=5><TEXTAREA name=Note COLS=70 ROWS=5 class="edit_input"><%=HtmlElement.htmlToText(s6)%></TEXTAREA></td>
</tr>

 <tr id="EditReport_13">
    <td align="right"><%=r.getString(teasession._nLanguage, "选项")%>:</td>
    <td  rowspan="" >
      <input type="checkbox" name="mostly" id="mostly" <%if(mostly)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "设为栏目关键")%>
      <input type="checkbox" name="mostly1" id="mostly1" <%if(mostly1)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170373281")%>
      <input type="checkbox" name="mostly2" id="mostly2" <%if(mostly2)out.print("checked");%> /><%=r.getString(teasession._nLanguage, "1204170388968")%>
      <%=Mark.toHtml(teasession._strCommunity,type,mark)%>
    </td>
  </tr>


<tr>
  <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
  <td><%=new TimeSelection("Issue", date)%>
  </td>
</tr>
      </table>

 <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
     
        <%  if(_bNew)
        {
          out.print("<input type=SUBMIT name=CBContinue  VALUE="+r.getString(teasession._nLanguage,"CBContinue")+" >");
        }
        %>
        <input type=SUBMIT name="GoSuper" id="edit_GoSuper" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage,"Super")%>">
</FORM>
<br>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
