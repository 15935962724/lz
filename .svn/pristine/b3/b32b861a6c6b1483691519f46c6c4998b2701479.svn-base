<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

String member=teasession._rv._strV;
tea.entity.node.Blog blog=tea.entity.node.Blog.find(node.getCommunity(),member);
teasession._nNode=blog.getHome();
r.add("/tea/ui/node/section/EditSection").add("/tea/ui/node/general/NodeServlet");
String s = teasession.getParameter("Section");
boolean flag = s == null;
int i = teasession._nNode;
if(!flag)
i = Section.find(Integer.parseInt(s)).getNode();
Node node = Node.find(i);
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}
String s1 = node.getCommunity();

int j = 0;
int l = 6;
int j1 = 0;
int l1 = 0;
String s2 = "";
int k2 = 0;
String s4 = "";
String s5 = "";
int l2 = 0;
int i3 = 0;
int k3 = 0;
int l3 = 0;
java.util.Date date_s=null;
int hidden=3;
int root=0;
if(!flag)
{
  int i4 = Integer.parseInt(s);
  tea.entity.node.Section section = tea.entity.node.Section.find(i4);
  i = section.getNode();

  l = section.getPosition();
  if(l==1||l==2||l==3||l==4)//1 2 3 4 已被删除
  l=0;
  j1 = section.getSequence();
  l1 = section.getVisible();
  l3 = section.getOptions();
  s2 = section.getText(teasession._nLanguage);

  String picture=section.getPicture(teasession._nLanguage);
  if(picture!=null&&picture.length()>0)
  k2 = (int)new java.io.File(picture).length();

  s4 = section.getClickUrl(teasession._nLanguage);
  s5 = section.getAlt(teasession._nLanguage);
  l2 = section.getAlign(teasession._nLanguage);

  String voice=section.getVoice(teasession._nLanguage);
  if(voice!=null&&voice.length()>0)
  i3 = (int)new java.io.File(voice).length();

  String file=section.getFileData(teasession._nLanguage);
  if(file!=null&&file.length()>0)
  k3 = (int)new java.io.File(file).length();

  date_s=section.getTime();
  if (teasession.getParameter("hide")!=null)
  hidden=section.getHiden(teasession._nNode);//Integer.parseInt(request.getParameter("hide")));
} else
{
  j1 = Section.getMaxSequence(i) + 1;
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Section")%></h1>
<div id="head6"><img height="6" alt=""></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td style="text-align:center"><%=r.getString(teasession._nLanguage, "Section")%></td>
    <td style="text-align:center"><%=r.getString(teasession._nLanguage, "Sequence")%></td>
    <td style="text-align:center"><%=r.getString(teasession._nLanguage, "Time")%></td>
    <td></td>
  </tr>
  <%
  ArrayList list = Section.find(Node.find(teasession._nNode),0, 5, false);
//for(Enumeration enumeration = Section.find(teasession._nNode,0, 5, 5 == 6); enumeration.hasMoreElements(); )
for(int k=0;k<list.size();k++)
{
  //int section_id = ((Integer)enumeration.nextElement()).intValue();
  //Section section = Section.find(section_id);
  Section section = (Section)list.get(k);
  if( section.getNode()==teasession._nNode)
  {
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td style="text-align:center"><%=Integer.toString(section.getSequence())%></td>
    <td style="text-align:center"><%=section.getSequence()%></td>
    <td style="text-align:center"><%=section.getTime()%></td>
    <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/section/WeblogEditSection.jsp?node=<%=teasession._nNode%>&Section=<%=section.getSequence()%>&hide=1&nexturl=<%=request.getRequestURI()%>', '_self');">
      <%//l == teasession._nNode &&
if( section.isLayerExisted(teasession._nLanguage))
{%>
      <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteSection?node=<%=teasession._nNode%>&Section=<%=section.getSequence()%>&nexturl=<%=request.getRequestURI()%>', '_self');}">
      <%}


                }
}
            %> </td>
  </tr>
</table>
  <FORM NAME="foEdit" METHOD="POST" action="/servlet/EditSection"  onSubmit="return(submitInteger(this.Sequence,'<%=r.getString(teasession._nLanguage, "InvalidSequence")%>'))">
    <input type='hidden' NAME=Node VALUE="<%=teasession._nNode%>">
    <input type='hidden' NAME=nexturl VALUE="<%=request.getRequestURI()%>">
    <%if(!flag)
  {%>
    <input type='hidden' NAME=Section VALUE="<%=s%>">
    <%}%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td> </td>
      <td><input  id="radio" type="radio" NAME=TextOrHtml onclick="changeEditorEx(0);" VALUE=0 checked <%=getCheck(l3==0)%>>
        <%=r.getString(teasession._nLanguage, "TEXT")%>
        <input  id="radio" type="radio" NAME=TextOrHtml onclick="changeEditorEx(1);"  VALUE=1  <%=getCheck(l3==1)%><%--=getCheck((l3 & 1) != 0)--%>>
        HTML </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td> <TEXTAREA name="Text" style=""  ROWS="10" COLS="75" <%//=getDisplay(l3==0)%> class="edit_input"><%=HtmlElement.htmlToText(s2)%></TEXTAREA> </td>
    </tr>
    <tr>
      <td> </td>
      <td><input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture', '_blank');"></td>
    </tr>
    <input type="hidden" name="Position" VALUE=5 >
    <input type="hidden" name="Style" VALUE=2 >
    <input type="hidden" name="root" VALUE=0 >
    <input type="hidden" name="Access" VALUE=0 >
    <input TYPE="hidden" NAME="ClickUrl" VALUE="" SIZE="40" MAXLENGTH="255" class="edit_input">
    <input TYPE="hidden" NAME="Alt" VALUE="" SIZE="40" MAXLENGTH="255" class="edit_input">
    <input TYPE="hidden" NAME="Align" VALUE="0" SIZE="40" MAXLENGTH="255" class="edit_input">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input type="TEXT" class="edit_input"  NAME=Sequence VALUE="<%=j1%>"></td>
    </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Time")%>:</td>
      <td><%=new TimeSelection("Issue", null)%></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="SUBMIT" id="edit_submit" class="edit_button"  VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
    </tr>
</table>
  </FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

