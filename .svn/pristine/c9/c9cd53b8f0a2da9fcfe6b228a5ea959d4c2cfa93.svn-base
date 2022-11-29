<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.entity.node.Meeting"%>
<%

if(!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return;
}
 r.add("/tea/resource/Meeting");

/*
long lp1len=0;
java.io.File file=new File(application.getRealPath(meeting.getLocalePicture()));
lp1len=file.length();

long lp2len=0;
file=new File(application.getRealPath(meeting.getLocalePicture2()));
lp2len=file.length();

long lp3len=0;
file=new File(application.getRealPath(meeting.getLocalePicture3()));
lp3len=file.length();
*/

long lp1len=0;
long iplen=0;

String subject="",content="";
String flyerdata="";

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
window.showModalDialog("/jsp/type/nightshop/NightShopList.jsp?node=<%=teasession._nNode%>&index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}
function checkint(obj)
{
  if(isNaN(parseInt(obj.value)))
  {
    alert('请输入正确的夜店节点号');
    obj.value=0;
  }
  else
  obj.value=parseInt(obj.value);
}
function f_load()
{
  f_editor();
  form1.subject.focus();
}
</script>
</head>
<body onload="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Meeting")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
<form name="form1" method="post" action="/servlet/EditMeeting"  ENCtype=multipart/form-data onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidName")%>'))">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="act" value="edit">

<%
Meeting meeting ;
String parameter=teasession.getParameter("nexturl");

boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
{
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
}
if(request.getParameter("NewNode")!=null)
{
  meeting = Meeting.find(0, teasession._nLanguage);
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  meeting = Meeting.find(teasession._nNode, teasession._nLanguage);
  if(meeting.getBigPicture()!=null)
  {
    java.io.File file=new File(application.getRealPath(meeting.getBigPicture()));
    lp1len=file.length();
  }
  if(meeting.getIntroPicture()!=null)
  {
    java.io.File file=new File(application.getRealPath(meeting.getIntroPicture()));
    iplen=file.length();
  }
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  content=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  flyerdata=HtmlElement.htmlToText(meeting.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>        :
</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subject" value="<%=subject%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Time")%>        :
</td>
      <td>
        <%=new TimeSelection("timeStart", meeting.getTimeStart())%><%-- <input type="text" name="timeStart" value="<%=meeting.getTimeStart()%>">--%>
       <%-- <%=new TimeSelection("timeStop", meeting.getTimeStop(),true,true)%><%-- <input type="text" name="timeStop" value="<%=meeting.getTimeStop()%>">--%>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "举行会议夜店名称")%>        :
</td>
      <td>
        <input type="text" class="edit_input" onKeyUp="checkint(this)" onChange="checkint(this)" name="nightShop" value="<%=meeting.getNightShop()%>"><input type="button" class="edit_input"  onclick="on_sel_rela('form1.nightShop')" value="浏览..."/>
      </td>
    </tr>    <tr>
      <td><%=r.getString(teasession._nLanguage, "分类")%>        :
</td>
      <td>
        <input type="text"  class="edit_input" name="sort" value="<%=meeting.getSort()%>">
      <select name="sort_select" onChange="form1.sort.value=this.options[this.selectedIndex].value" >
        <option value="">------</option>
        <option value="品牌推广">品牌推广</option>
        <option value="特别主题">特别主题</option>
        <option value="HIP-POP">HIP-POP</option>
        <option value="现场乐队">现场乐队</option>
        <option value="DJ 打碟">DJ 打碟</option>
        <option value="电子音乐">电子音乐</option>
        <option value="JAZZ">JAZZ</option>
        <option value="常规会议">常规会议</option>
        <option value="RAVE PARTY">RAVE PARTY</option>
        <option value="私人聚会">私人聚会</option>
        <option value="ROCK">ROCK</option>
        <option value="夜魔制造">夜魔制造</option>
      </select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "会议要求")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="request" value="<%=meeting.getRequest()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "特殊规定")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="prescribe" value="<%=meeting.getPrescribe()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "简介")%>        :
</td>
      <td>
        <TEXTAREA name=synopsis ROWS=5 COLS=60 class="edit_input"><%=HtmlElement.htmlToText(meeting.getSynopsis())%></TEXTAREA>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "介绍")%>        :
</td>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="nonuse"  id="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <br/>
          <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=content%></textarea>
          <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "组织人")%>        :
      </td>
      <td>
        <input type="text" name="organise"  class="edit_input" value="<%=meeting.getOrganise()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "组织者联系方式")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="linkman" value="<%=meeting.getLinkman()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "组织者所属公司")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="corp" value="<%=meeting.getCorp()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "门票价格")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="carfare" value="<%=meeting.getCarfare()%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "特色")%>        :
</td>
      <td>
        <input type="text" class="edit_input"  name="feature" value="<%=meeting.getFeature()%>">
      </td>
    </tr>
    <%--
      <tr>
      <td><%=r.getString(teasession._nLanguage, "IntroPicture")%>:</td>
      <td><input type="text" name="introPicture"></td>
      </tr>
    --%>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "介绍图片")%>:
</td>
      <td>
          <INPUT TYPE=FILE NAME=introPicture onDblClick="window.open('<%=meeting.getIntroPicture()%>');" class="edit_input"><%if(iplen != 0) out.print(iplen + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearIntroPicture VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>
     <tr>
      <td><%=r.getString(teasession._nLanguage, "BigPicture")%>:
</td>
      <td>
          <INPUT TYPE=FILE NAME=bigPicture onDblClick="window.open('<%=getNull(meeting.getBigPicture()).replaceAll("\\\\","/")%>');" class="edit_input"><%if(lp1len != 0) out.print(lp1len + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearBigPicture VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "flyer资料")%>:
</td>
      <td>
        <input type="text" name="flyerData"  class="edit_input"  value="<%=flyerdata%>">
      </td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "IssueTime")%>        :
</td>
      <td>
         <%=new TimeSelection("Issue", meeting.getDate())%>
      </td>
    </tr>
  <tr>
      <td><%=r.getString(teasession._nLanguage, "现场图片")%>        :
</td>
      <td>
           <input type="button"  class="edit_button" value="<%=r.getString(teasession._nLanguage, "New")%>" onClick="window.open('/jsp/type/TypePicture.jsp?node=<%=teasession._nNode%>')">
      </td>
    </tr>

<%--    <tr>
      <td><%=r.getString(teasession._nLanguage, "LocalePicture")%>1        :
</td>
      <td>
          <INPUT TYPE=FILE NAME=localePicture class="edit_input"><%if(lp1len != 0) out.print(lp1len + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearPicture VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "LocalePicture")%>2        :
</td>
      <td>
          <INPUT TYPE=FILE NAME=localePicture2 class="edit_input"><%if(lp2len != 0) out.print(lp2len + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearPicture2 VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>
        <tr>
      <td><%=r.getString(teasession._nLanguage, "LocalePicture")%>3        :
</td>
      <td>
          <INPUT TYPE=FILE NAME=localePicture3 class="edit_input"><%if(lp3len != 0) out.print(lp3len + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearPicture3 VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
    </tr>--%>
  </table><center>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "返回  ")%>">
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</center></form>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

