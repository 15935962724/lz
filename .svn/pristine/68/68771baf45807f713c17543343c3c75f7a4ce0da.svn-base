<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
Node node=Node.find(teasession._nNode);
if((node.getOptions1()& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
  }
  if (!"admin".equals(h.key)&&!node.isCreator(teasession._rv)&&AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview()<2)
  {
    response.sendError(403);
    return;
  }
}

Resource r=new Resource("/tea/resource/TypePicture");

int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt( request.getParameter("id"));

String picname=null,picture=null,picture2=null;
int w=0,ph=0;
long len=0,len2=0;
if(id!=0)
{
  TypePicture tp=TypePicture.findByPrimaryKey(id);
  picname=tp.getPicname();
  picture=tp.getPicture();
  picture2=tp.getPicture2();
  w=tp.getWidth();
  ph=tp.getHeight();

  if(picture!=null)
  len=new java.io.File(application.getRealPath(picture)).length();
  if(picture2!=null)
  len2=new java.io.File(application.getRealPath(picture2)).length();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(id)
{
  form1.method="get";
  form1.action="?";
  form1.id.value=id;
  form1.submit();
}
function f_del(id)
{
  if(!confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>'))return;
  form1.method="get";
  form1.act.value="del";
  form1.id.value=id;
  form1.submit();
}
function f_name(value)
{
  var i=value.lastIndexOf('\\');
  if(i!=-1&&form1.picname.value=='')
  {
    value=value.substring(i+1);
    i=value.lastIndexOf('.');
    if(i!=-1)value=value.substring(0,i);
    form1.picname.value=value;
  }
}
</script>
</head>
<body onLoad="form1.picture.focus();">

<h1><%=r.getString(teasession._nLanguage, "Pictureview")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"> <%=node.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "Pictureview")%></h2>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%></td>
    <td><%=r.getString(teasession._nLanguage, "Path")%></td>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%></td>
    <td>&nbsp;</td>
  </tr>
  <%
  java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
  while (enumer.hasMoreElements())
  {
    int temp_id = ((Integer) enumer.nextElement()).intValue();
    TypePicture tp = TypePicture.findByPrimaryKey(temp_id);

    String p2=tp.getPicture2();
    /*
    StringBuffer bigpicture = new StringBuffer(tp.getPicture());
    bigpicture.insert(tp.getPicture().lastIndexOf("."), "big");
    */

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
    <td>
    <%
    if(p2!=null&&p2.length()>0)
    {
      out.print("<A href=### onclick=\"javascript:window.open('"+p2+"','_blank','height="+(tp.getHeight()+27)+",width="+(tp.getWidth()+20)+",left=220,top=200,toolbar=no,status=no,menubar=no,location=no,resizable=yes');\" >");
    }
    out.print("<img src=\""+tp.getPicture()+"\" "+(tp.getWidth()>tp.getHeight()?" width=100":" height=100")+"></a>");
    %>
    </td>
    <td><%if(temp_id==id)out.print("<font color=\"#FF0000\">");out.print(tp.getPicture()+"</font>");%></td>
    <td><%=tp.getPicname()%></td>
    <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" onClick="f_edit(<%=temp_id%>)"  CLASS="CB" >
      <input type="button" onClick="f_del(<%=temp_id%>)" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" CLASS="CB" ></td>
  </tr>
  <% }%>

</table>

<form name="form1" method="post" action="/servlet/TypePicture"  ENCtype="multipart/form-data" >
<input type="hidden" value="<%=teasession._strCommunity%>" name="community"/>
<input type="hidden" value="<%=teasession._nNode%>" name="node"/>
<input type="hidden" value="<%=id%>" name="id"/>
<input type="hidden" name="key" value="<%=MT.enc(h.key)%>"/>
<input type="hidden" name="act"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td><input name="picture" size="40"  class="edit_input" type="file" onChange="f_name(value)" ><%if(len>0)out.print(len+r.getString(teasession._nLanguage,"Bytes"));%></td>
    </tr>
    <tr>
      <td>大<%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td><input type="file" name="bigpicture" size="40" class="edit_input" onChange="image.src=this.value;form1.width.value=image.width;form1.height.value=image.height;"><%if(len2>0)out.print(len2+r.getString(teasession._nLanguage,"Bytes"));%>
        <input name="width" type="hidden" value="<%=w%>">
        <input name="height" type="hidden" value="<%=ph%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PictureName")%>:</td>
      <td><input type="text" name="picname"  size="40"  class="edit_input" value="<%=MT.f(picname)%>"></td>
    </tr>
  </table>
  <input name="Input" type="submit"  CLASS="CB"  value="<%=r.getString(teasession._nLanguage,"Submit")%>" onclick="return form1.id!=0||submitText(form1.picture,'图片路径无效.');">


</form>

</body>
</html>
