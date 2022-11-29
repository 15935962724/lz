<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%


boolean newnode=request.getParameter("NewNode")!=null;

Date time=null;

int classes=0,classesc=0;
String subject=null,text=null;
String code=String.valueOf(System.currentTimeMillis());
String keyword = null;
String filesize = null;
int grade = 0;
int pointlimit = 0;
String namepath=null;
String author=null;
String linkurl = null;
String note=null;
String name=null;
int len=0;
int filecheckbox = 0;

if(newnode)
{

}else
{
  Files obj=Files.find(teasession._nNode,teasession._nLanguage);
  classes = obj.getClasses();

  classesc= obj.getClassesc();
  subject=node.getSubject(teasession._nLanguage);
  code=obj.getCode();
  keyword=obj.getKeyword();
  filesize=obj.getFilesize();
  grade = obj.getGrade();
  pointlimit =obj.getPointlimit();

  name=obj.getName();//"/res/"+teasession._strCommunity+"/files/"+teasession._nNode+"_"+teasession._nLanguage+".doc";
  namepath=obj.getNamepath();
  if(namepath!=null)
  {
    len=(int)new java.io.File(application.getRealPath(namepath)).length();
  }
  //File file2=new File(application.getRealPath(file));
 // len=(int)file2.length();
  author=obj.getAuthor();
  linkurl=obj.getLinkurl();
  text=node.getText(teasession._nLanguage);
  note=obj.getNote();
  filecheckbox=obj.getFilecheckbox();


}
String my=teasession.getParameter("my");
my=(my==null)?"":my;
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script type="">
var obj;
function f_sub(c,c2)
{
  obj = document.all('filecheckbox');
  f_filecheckbox(obj);
  f_ajax(c,c2);
}
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=report&value="+v,f_change);
}
function f_change(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "classesc":
    form1.classesc.value="<%=classesc%>";
    break;
  }
}
//上传选择
function f_filecheckbox(obj)
 {
   var fileid=document.getElementById("fileid");
   var fileid2 = document.getElementById("fileid2");


   if(obj.checked==true)
   {

     fileid.style.display='none';
     fileid2.style.display='block';


   }else
   {
     fileid.style.display='block';
     fileid2.style.display='none';
   }
 }
</script>
</head>
<body onload="f_sub('<%=classes%>','classesc');">
<h1><%=r.getString(teasession._nLanguage, "创建课件")%></h1>

<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form1" METHOD="POST" ACTION="/servlet/EditFile" enctype="multipart/form-data" onSubmit="return(<%if(newnode)out.print("submitText(this.file, '"+r.getString(teasession._nLanguage, "InvalidFile")+"')&&");%>submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.code, '<%=r.getString(teasession._nLanguage, "InvalidIndex")%>'));">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="repository" value="files">
<input type='hidden' name="my" value="<%=my %>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="act">
<%
String nexturl=teasession.getParameter("nexturl");
if(nexturl!=null)
{
  out.print("<input type='hidden' name=nexturl value="+nexturl+">");
}
if(newnode)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr  style="display:none">
    <td align="right"><%=r.getString(teasession._nLanguage, "所属分类")%>:</td>
    <td nowrap>
      <select  name="classes" onChange="f_ajax(value,'classesc')">
        <option  value="0">---------------</option>
        <%
        Enumeration eu = Classes.find(" and type = 41 and community="+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
        for(int i=0;eu.hasMoreElements();i++)
        {
          int idc= Integer.parseInt(String.valueOf(eu.nextElement()));
          Classes objty = Classes.find(idc);
          out.print("<option value="+idc);
          if(classes==idc)
          {
            out.print(" selected ");
          }
          out.print(">"+objty.getName()+"</option>");
        }
        %>
        </select>
        <select name="classesc" >
          <option value="0" >-------</option>
        </select>
        <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/classes/ClassesSel.jsp?community=<%=teasession._strCommunity%>&type=41',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs)form1.classes.value=rs;">
        <input type="button" class="edit_button" onClick="window.showModalDialog('/jsp/type/classes/Classes.jsp?node=<%=teasession._nNode%>&type=41',self,'status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:500px;');" value="<%=r.getString(teasession._nLanguage, "管理")%>">
    </td>
</tr>
<tr>
  <td align="right"><%=r.getString(teasession._nLanguage, "课件名称")%>:</td>
  <td><input type="TEXT" class="edit_input"  name=subject VALUE="<%if(subject!=null)out.print(subject);%>" SIZE=40 ></td>
</tr>
<tr  style="display:none">
  <td align="right"><%=r.getString(teasession._nLanguage, "课件编号")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="code" VALUE="<%=code%>" SIZE=40 readonly="readonly" ></td>
</tr>
<tr>
  <td align="right"><%=r.getString(teasession._nLanguage, "关键字")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="keyword" VALUE="<%if(keyword!=null)out.print(keyword); %>" SIZE=40 ></td>
</tr>
<tr  style="display:none">
  <td align="right"><%=r.getString(teasession._nLanguage, "课件大小")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="filesize" VALUE="<%if(filesize!=null)out.print(filesize);%>"  ></td>
</tr>
<tr  style="display:none">
<td align="right">课件评级:</td>
<td>
  <select name="grade" class="button" id="Grade">
  <%
      for(int i =0;i<Files.GRADE.length;i++)
      {
        out.print("<option value="+i);
        if(grade==i)
        {
          out.print(" selected ");
        }
        out.print(">"+Files.GRADE[i]);
        out.print("</option>");
      }
  %>

  </select>
</td>
</tr>
<tr  style="display:none">
  <td align="right"><%=r.getString(teasession._nLanguage, "积分限制")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="pointlimit" VALUE="<%=pointlimit%>" >&nbsp;分</td>
</tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "上传文件")%>:</td>
    <td>

      <span id="fileid">
        <input name="file" type="file" class="edit_input" size="40" >&nbsp;
        <%if(len>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+namepath+"&name=" + java.net.URLEncoder.encode(name, "UTF-8") + ">" +name + "</a>");%>&nbsp;
        <input id='checkbox' type='checkbox' name='clearpicture' onclick='form1.file.disabled=this.checked'>&nbsp;清空 <%} %>
      </span>
      <span id="fileid2" style="display:none">
      <input type="text" name="file2" size="40" value="<%=namepath%>"/>
       </span>&nbsp;<input type="checkbox"  name="filecheckbox" value="1"  <%if(filecheckbox>0)out.print(" checked=checked ");%> onclick="f_filecheckbox(this);">&nbsp;填写文件路径


  </td>
</tr>
<tr>
  <td align="right"><%=r.getString(teasession._nLanguage, "课件作者")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="author" VALUE="<%if(author!=null)out.print(author);%>" SIZE=40 ></td>
</tr>
<tr  style="display:none">
  <td align="right"><%=r.getString(teasession._nLanguage, "课件来源")%>:</td>
  <td><input type="TEXT" class="edit_input"  name="linkurl" VALUE="<%if(linkurl!=null)out.print(linkurl);%>" SIZE=40 ></td>
</tr>
<!--<tr>
  <td><%=r.getString(teasession._nLanguage, "class")%>:</td>
  <td>
    <select name="classes">

<%
Enumeration e=Classes.findByCommunity(teasession._strCommunity,teasession._nLanguage);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  Classes c=Classes.find(id);
  String str=c.getName();
  out.print("<option value="+id);
  if(id==classes)
  {
    out.print(" selected ");
  }
  out.print(">"+str);
}
%></select><input type=BUTTON class="edit_button" onClick="window.open('/servlet/NewClass?type=41', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "New")%>">
<input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageClasses?type=41', '_self');" VALUE="<%=r.getString(teasession._nLanguage, "All")%>">
</tr>
-->
 <tr  style="display:none">
    <td nowrap> </TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>
  <tr>
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "课件简介")%>:</TD>
    <td nowrap>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%if(text!=null)out.print(text); %></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>



<tr  style="display:none">
  <td align="right"><%=r.getString(teasession._nLanguage, "Memo")%>:</td>
  <td COLSPAN=5><TEXTAREA name="note" COLS=70 ROWS=4 class="edit_input"><%=HtmlElement.htmlToText(note)%></TEXTAREA></td>
</tr>
</table>

<%
//if(newnode)
{
  //out.print("<input type=SUBMIT name=newfilebutton id=edit_GoNext class=edit_button VALUE="+r.getString(teasession._nLanguage,"Newfile")+">");
}
%>
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
 <!--<input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">-->
</FORM>

<SCRIPT>document.form1.subject.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
