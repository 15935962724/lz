<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
Http h=new Http(request,response);

boolean newnode=request.getParameter("NewNode")!=null;

Date time=null;

int classes=0,classesc=0;
String subject=null,text=null,picture=null;
String code="";
String keyword = null;
int grade = 0;
int pointlimit = 0;
String namepath=null;
String author=null;
String unitname=null;
String linkurl = null;
String note=null;
String name=null;
int len=0;
int filecheckbox = 0;
int toolbar=3153915;
boolean pconv=false,outline=true,copy=true,prints=true;

if(newnode)
{

}else
{
  Files obj=Files.find(h.node,h.language);
  classes = obj.getClasses();

  classesc= obj.getClassesc();
  subject=node.getSubject(h.language);
  picture=node.getPicture(h.language);
  code=obj.getCode();
  keyword=obj.getKeyword();
  grade = obj.getGrade();
  pointlimit =obj.getPointlimit();

  name=obj.getName();//"/res/"+teasession._strCommunity+"/files/"+h.node+"_"+h.language+".doc";
  namepath=obj.getNamepath();
  if(namepath!=null)
  {
    len=(int)new java.io.File(application.getRealPath(namepath)).length();
  }
  //File file2=new File(application.getRealPath(file));
 // len=(int)file2.length();
  author=obj.getAuthor();
  unitname=obj.getUnitname();
  linkurl=obj.getLinkurl();
  text=node.getText(h.language);
  note=obj.getNote();
  filecheckbox=obj.getFilecheckbox();
  pconv=obj.pconv;
  outline=obj.outline;
  copy=obj.copy;
  prints=obj.prints;
  toolbar=obj.toolbar;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>

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
    form2.classesc.value="<%=classesc%>";
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
<h1><%=r.getString(h.language, "创建课件")%></h1>
<div id="pathdiv"><%=node.getAncestor(h.language)%></div>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name="form2" METHOD="POST" ACTION="/Filess.do" enctype="multipart/form-data" onSubmit="return mt.check(this)&&mt.show(null,0);">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="repository" value="files/<%=h.node/10000%>">
<input type='hidden' name="node" value="<%=h.node%>">
<input type='hidden' name="resize" value="600">
<input type='hidden' name="act" value="edit">
<%
String nexturl=teasession.getParameter("nexturl");
if(nexturl!=null)
{
  out.print("<input type='hidden' name=nexturl value="+URLDecoder.decode(nexturl)+">");
}
if(newnode)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
    <td align="right"><%=r.getString(h.language, "所属分类")%>:</td>
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
        <input type="button" value="..." onClick="var rs=window.showModalDialog('/jsp/type/classes/ClassesSel.jsp?community=<%=teasession._strCommunity%>&type=41',self,'dialogWidth:450px;dialogHeight:550px;help:0;');if(rs)form2.classes.value=rs;">
        <input type="button" class="edit_button" onClick="window.showModalDialog('/jsp/type/classes/Classes.jsp?node=<%=h.node%>&type=41',self,'status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:500px;');" value="<%=r.getString(h.language, "管理")%>">
    </td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language,"名称")%>:</td>
  <td><input class="edit_input"  name=subject VALUE="<%=MT.f(subject)%>" alt="<%=r.getString(h.language,"名称")%>" SIZE=40 ></td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "编号")%>:</td>
  <td><input class="edit_input"  name="code" VALUE="<%=code%>" SIZE=40 ></td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "关键字")%>:</td>
  <td><input class="edit_input"  name="keyword" VALUE="<%if(keyword!=null)out.print(keyword); %>" SIZE=40 ></td>
</tr>
<%--
<tr>
  <td align="right"><%=r.getString(h.language, "课件大小")%>:</td>
  <td><input class="edit_input"  name="filesize" VALUE="<%if(filesize!=null)out.print(filesize);%>"  ></td>
</tr>
--%>
<tr>
<td align="right">评级:</td>
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
<%--
<tr>
  <td align="right"><%=r.getString(h.language, "积分限制")%>:</td>
  <td><input class="edit_input"  name="pointlimit" VALUE="<%=pointlimit%>" >&nbsp;分</td>
</tr>
--%>
<tr>
  <td align="right">图片:</td>
  <td><input type="file" name="picture"/>
    <%
    if(picture!=null)
    {
      out.print("<input type='checkbox' name='clear' onclick='form2.picture.disabled=checked'>清空　<a href=javascript:mt.img('"+Http.enc(picture)+"')>查看</a>");
    }
    %>
  </td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language,"上传文件")%>:</td>
  <td><input type="file" name="file" alt="<%=namepath==null?"上传文件":""%>"/>
    <%
    if(namepath!=null)
    {
      out.print("<a href='/Utils.do?act=down&url="+Http.enc(namepath)+"'>查看</a>");
    }
    %>
  </td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "作者")%>:</td>
  <td><input class="edit_input"  name="author" VALUE="<%if(author!=null)out.print(author);%>" SIZE=40 ></td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "所属单位")%>:</td>
  <td><input class="edit_input"  name="unitname" VALUE="<%if(unitname!=null)out.print(unitname);%>" SIZE=40 ></td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "来源")%>:</td>
  <td><input class="edit_input" name="linkurl" VALUE="<%if(linkurl!=null)out.print(linkurl);%>" SIZE=40 ></td>
</tr>
<!--<tr>
  <td><%=r.getString(h.language, "class")%>:</td>
  <td>
    <select name="classes">

<%
Enumeration e=Classes.findByCommunity(teasession._strCommunity,h.language);
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
%></select><input type=BUTTON class="edit_button" onClick="window.open('/servlet/NewClass?type=41', '_self');" VALUE="<%=r.getString(h.language, "New")%>">
<input name="fff" type=BUTTON class="edit_button" onClick="window.open('/servlet/ManageClasses?type=41', '_self');" VALUE="<%=r.getString(h.language, "All")%>">
</tr>
-->
 <tr>
    <td nowrap> </TD>
    <td nowrap>
    <%--
      <input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(h.language, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(h.language, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=h.node%>', '_blank');">
    --%>
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(h.language, "NonuseEditor")%></label>
      <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>
  <tr>
    <td nowrap align="right"><%=r.getString(h.language, "简介")%>:</TD>
    <td nowrap>
      <textarea name="content" rows="12" cols="90" class="edit_input"><%=MT.f(text)%></textarea>
      <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>' width='740' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
    </td>
  </tr>



<tr>
  <td align="right"><%=r.getString(h.language, "Memo")%>:</td>
  <td COLSPAN=5><TEXTAREA name="note" COLS=70 ROWS=4 class="edit_input"><%=HtmlElement.htmlToText(note)%></TEXTAREA></td>
</tr>
<tr>
  <td align="right"><%=r.getString(h.language, "选项")%>:</td>
  <td>
    <input type="checkbox" name="pconv" value="1" onclick="$('tr_'+id).style.display=checked?'':'none'" <%=pconv?" checked":""%> id="pconv"><label for="pconv">在线浏览</label>
<!--
    <input type="checkbox" name="outline" value="1" <%=outline?" checked":""%> id="outline"><label for="outline">显示大纲</label>
    <input type="checkbox" name="copy" value="1" <%=copy?" checked":""%> id="copy"><label for="copy">支持复制</label>
    <input type="checkbox" name="prints" value="1" <%=prints?" checked":""%> id="prints"><label for="prints">支持打印</label>
-->
  </td>
</tr>
<tr id="tr_pconv" style="display:none">
  <td align="right"><%=r.getString(h.language,"工具栏")%>:</td>
  <td>
<%
String[] TOOLBARIMAGE={"","LOGO","拖曳页面","选择文本","放大/缩小","缩放","适合宽度","适合页面","前一页","页数/总页数","下一页","查询输入框","查询按钮","旋转","打印","全屏"};
for(int i=1,j=1;i<TOOLBARIMAGE.length;i++,j+=j)
{
  if(i==15)j=0x00300000;//全屏
  out.print("<input type='checkbox' name='toolbar' value='"+j+"' id='tb"+i+"'");
  if((toolbar&j)!=0)out.print(" checked");
  out.print(" /><label for='tb"+i+"'>"+TOOLBARIMAGE[i]+"</label>　");
}
%>
  </td>
</tr>
</table>

<%
if(newnode)
{
  out.print("<input type=SUBMIT name=newfilebutton id=edit_GoNext class=edit_button VALUE="+r.getString(h.language,"Newfile")+">");
}
%>
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(h.language, "Finish")%>">
<input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" onClick="act.value='back';" class="edit_button" value="<%=r.getString(h.language, "Super")%>">
</form>

<script>
document.form2.subject.focus();
form2.pconv.onclick();
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
