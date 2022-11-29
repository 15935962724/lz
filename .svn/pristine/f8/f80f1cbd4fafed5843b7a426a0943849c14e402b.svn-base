<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%


TeaSession teasession=new TeaSession(request);

Http h=new Http(request,response);



AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);

Resource r=new Resource("/tea/ui/node/section/EditSection").add("/tea/ui/node/general/NodeServlet");

Section obj=null;
int status=0;
int realnode=teasession._nNode;
int section = Integer.parseInt(teasession.getParameter("section"));
if(section!=0)
{
  obj=Section.find(section);
  realnode = obj.getNode();
  status=obj.getStatus();
}else
{
  status=Integer.parseInt(request.getParameter("status"));
}

if(realnode>0&&!Node.find(realnode).isCreator(teasession._rv)&&am.getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}



Node node = Node.find(teasession._nNode);

String themename ="";
String s1 = node.getCommunity();
int style = 0,styletype=0,stylecategory=0;
int position = 6;
int j1 = 0;
int l1 = 0;
String text;
int k2 = 0;
String s4 = "";
String s5 = "";
int l2 = 0;
int i3 = 0;
int k3 = 0;
int l3 = 0;
java.util.Date date_s=null;
int hidden=3;
if(section!=0)
{
  style = obj.getStyle();
  styletype=obj.getStyleType();
  stylecategory=obj.getStyleCategory();
  position = obj.getPosition();
  j1 = obj.getSequence();
  l1 = obj.getVisible();
  l3 = obj.getOptions();
  text = HtmlElement.htmlToText(obj.getText(teasession._nLanguage));

  String picture=obj.getPicture(teasession._nLanguage);
  if(picture!=null&&picture.length()>0)
  k2 = (int)new java.io.File(application.getRealPath(picture)).length();

  s4 = obj.getClickUrl(teasession._nLanguage);
  s5 = obj.getAlt(teasession._nLanguage);
  l2 = obj.getAlign(teasession._nLanguage);

  String voice=obj.getVoice(teasession._nLanguage);
  if(voice!=null&&voice.length()>0)
  i3 = (int)new java.io.File(application.getRealPath(voice)).length();

  String file=obj.getFileData(teasession._nLanguage);
  if(file!=null&&file.length()>0)
  k3 = (int)new java.io.File(application.getRealPath(file)).length();

  date_s=obj.getTime();
  themename=obj.getThemename(teasession._nLanguage);
  Sectionhide ch=Sectionhide.find(section,teasession._nNode);
  hidden=ch.getHiden();
} else
{
  text="";
  j1 = Section.getMaxSequence(teasession._nNode) + 1;
}

String title=r.getString(teasession._nLanguage, "Section")+" ( "+section+" )";

%><html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<script>
function f_load()
{
  f_change();
  form1.type.onchange=f_change;
}
function f_change()
{
  var o1=form1.type.options;
  var sc=form1.stylecategory;
  var o2=form1.stylecategory.options;
  if(form1.type.value=="1")
  {
    sc.style.display="";
  }else
  {
    sc.style.display="none";
  }
  if(o2.length==0)
  {
    for(var i=0;i<o1.length;i++)
    {
      var v=o1[i].value;
      if(v!="255"&&v!="0"&&v!="1")
      {
        o2[o2.length]=new Option(o1[i].text,v);
      }
    }
    if(<%=stylecategory%>!=0)
    sc.value="<%=stylecategory%>";
  }
}
</script>
</head>
<body onLoad="f_load()">
<%=NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" METHOD="POST" action="/servlet/EditSection" ENCTYPE="multipart/form-data" onSubmit="mt.storage(this,true);mt.enc(this.content);return mt.check(this)&&mt.show(null,0);">
<input type='hidden' NAME="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' NAME="status" VALUE="<%=status%>">
<input type='hidden' NAME="section" VALUE="<%=section%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "主题名称")%>:</td>
      <td><input type="TEXT" class="edit_input"  NAME="themename" VALUE="<%=themename%>" size="80"></td>
    </tr>
    <tr>
      <td></td>
      <td>
        <input id="radio" type="radio" NAME="textorhtml" VALUE="0" <%if(l3==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "TEXT")%>
        <input id="radio" type="radio" NAME="textorhtml" VALUE="1" <%if(l3==1)out.print(" checked ");%>>HTML
        <input id="CHECKBOX" type="CHECKBOX" name="nonuse" onClick="f_editor(this)"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td>
        <textarea name="content" rows="16" cols="97" class="edit_input"><%=text%></textarea>
        <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=s1%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
        <br/><a href="javascript:mt.storage(form1,true)">保存数据</a> <a href="javascript:mt.storage(form1,false)">恢复数据</a>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Position")%>:</td>
      <td><span>
        <input id="radio" type="radio" name="position" VALUE=0 <%if(0 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.SECTION_TYPE[0])%></span>
        <%--span>
          <input  id="radio" type="radio" name="position" VALUE=1 <%if(1 == l)out.print(" checked ");%>>
          <%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[1])%></span><span>
          <input  id="radio" type="radio" name="position" VALUE=2 <%if(2 == l)out.print(" checked ");%>>
          <%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[2])%></span><span>
          <input  id="radio" type="radio" name="position" VALUE=3 <%if(3 == l)out.print(" checked ");%>>
          <%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[3])%></span>
          <span><input  id="radio" type="radio" name="position" VALUE=4 <%if(4 == l)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[4])%></span--%>
        <span><input  id="radio" type="radio" name="position" VALUE=5 <%if(5 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Body")%>1</span>
        <span><input  id="radio" type="radio" name="position" VALUE=6 <%if(6 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Body")%>2</span>
        <span><input  id="radio" type="radio" name="position" VALUE=7 <%if(7 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Body")%>3</span>
        <span><input  id="radio" type="radio" name="position" VALUE=8 <%if(8 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[8])%></span>
        <span><input  id="radio" type="radio" name="position" VALUE=9 <%if(9 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[9])%></span>
        <span><input  id="radio" type="radio" name="position" VALUE=10 <%if(10 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[10])%></span>
        <span><input  id="radio" type="radio" name="position" VALUE=11 <%if(11 == position)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_TYPE[11])%> </span></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input type="TEXT" class="edit_input"  NAME="sequence" VALUE="<%=j1%>" mask="int"></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage,"Style")%>:</td>
      <td>
        <input id="radio" type="radio" name="style" value="0" <%if(style==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "ThisNode")%>
        <input id="radio" type="radio" name="style" value="2" <%if(style==2)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "1206432316359")%>
        <%=new tea.htmlx.TypeSelection(teasession._strCommunity,teasession._nLanguage, styletype)%>
        <select name="stylecategory" style="display:none"></select>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Access")%>:</td>
      <td>
        <input id="radio" type="radio" name="visible" VALUE=0 <%if(0 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.USER_STATUS[0])%>
        <input id="radio" type="radio" name="visible" VALUE=1 <%if(1 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[1])%>
        <input id="radio" type="radio" name="visible" VALUE=2 <%if(2 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[2])%>
        <input id="radio" type="radio" name="visible" VALUE=3 <%if(3 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[3])%>
        <input id="radio" type="radio" name="visible" VALUE=4 <%if(4 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[4])%>
        <input id="radio" type="radio" name="visible" VALUE=5 <%if(5 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[5])%>
        <input id="radio" type="radio" name="visible" VALUE=6 <%if(6 == l1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, tea.entity.node.Section.USER_STATUS[6])%>
      </td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "File")%>:</td>
      <td COLSPAN=6><input type="file" name="File" class="edit_input"/>
        <%if(k3>0){%>
        <%=k3%><%=r.getString(teasession._nLanguage, "Bytes")%>
        <%}%>
        <input  id="CHECKBOX" type="CHECKBOX" NAME=ClearFile value="null">
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Voice")%>:</td>
      <td COLSPAN=6><input type="file" name="Voice" class="edit_input"/>
        <%if(i3>0){out.print(i3+r.getString(teasession._nLanguage, "Bytes"));}%>
        <input id="EC"  id="CHECKBOX" type="CHECKBOX" name="ClearVoice" value="null">
        <%=r.getString(teasession._nLanguage, "Clear")%> <A href="/tea/html/0/recorder.html" TARGET="_blank"><%=r.getString(teasession._nLanguage,"Record")%> </A></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td COLSPAN=6><input type="File" name="Picture" class="edit_input"/>
        <%if(k2 > 0)out.print(k2 +r.getString(teasession._nLanguage, "Bytes"));%>
        <input id="EC"  id="CHECKBOX" type="CHECKBOX" NAME=ClearPicture value="null">
        <%=r.getString(teasession._nLanguage, "Clear")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "ClickUrl")%>:</td>
      <td><input TYPE="TEXT" NAME="ClickUrl" VALUE="<%=s4%>" SIZE="40" MAXLENGTH="255" class="edit_input"></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Alt")%>:</td>
      <td><input TYPE=TEXT NAME=Alt VALUE="<%=s5%>" SIZE=40 MAXLENGTH=255 class="edit_input"></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Align")%>:</td>
      <td>
        <input  id="radio" type="radio" NAME=Align VALUE=0 <%if(l2==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Default")%>
        <input  id="radio" type="radio" NAME=Align VALUE=1 <%if(l2==1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Left")%>
        <input  id="radio" type="radio" NAME=Align VALUE=2 <%if(l2==2)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Center")%>
        <input  id="radio" type="radio" NAME=Align VALUE=3 <%if(l2==3)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Right")%>
        <input  id="radio" type="radio" NAME=Align VALUE=4 <%if(l2==4)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Top")%>
        <input  id="radio" type="radio" NAME=Align VALUE=5 <%if(l2==5)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "Bottom")%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "IssueTime")%>:</td>
      <td><%=new tea.htmlx.TimeSelection("Issue", date_s)%></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "HidenStyle")%>:</td>
      <td>
        <input  id="radio" type="radio" NAME=hiden VALUE=0 <%if(hidden==0)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[0])%>
        <input  id="radio" type="radio" NAME=hiden VALUE=1 <%if(hidden==1)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[1])%>
        <input  id="radio" type="radio" NAME=hiden VALUE=2 <%if(hidden==2)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[2])%>
        <input  id="radio" type="radio" NAME=hiden VALUE=3 <%if(hidden==3)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, Section.SECTION_HideStyle[3])%></td>
    </tr>
    <tr>
      <td></td>
      <td>
        <input name="submit" type="SUBMIT" id="edit_submit" class="edit_button"  VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
        <%
        if(realnode>0)
        {
          out.print("<input name='example' type='submit' id='edit_submit' class='edit_button'  VALUE="+r.getString(teasession._nLanguage, "同时存为模板")+" />");
        }
        %>
      </td>
    </tr>
</table>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
