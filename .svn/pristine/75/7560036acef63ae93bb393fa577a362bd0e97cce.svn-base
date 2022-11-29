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
  <td align="right"><%=r.getString(h.language,"名称")%>:</td>
  <td><input class="edit_input"  name=subject VALUE="<%=MT.f(subject)%>" alt="<%=r.getString(h.language,"名称")%>" SIZE=40 ></td>
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

</table>

<%
if(newnode)
{
  out.print("<input type=SUBMIT name=newfilebutton id=edit_GoNext class=edit_button VALUE="+r.getString(h.language,"Newfile")+">");
}
%>
<input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(h.language, "Finish")%>">
</form>

<script>
document.form2.subject.focus();
form2.pconv.onclick();
</script>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
