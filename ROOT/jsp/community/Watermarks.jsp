<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();

Watermark obj = Watermark.find(teasession._strCommunity);
int location=obj.getLocation();
String logo=obj.getLogo();
int alpha=obj.getAlpha();
String ext=obj.getExt();
int zoom = obj.getZoom();

int[] TYPE={95};

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js"></script>
<script type="">
function f_click(obj)
{
  var view=document.getElementById("view");
  view.src=obj.value;
}
function f_load()
{
  form1.nexturl.value=location.pathname+location.search;
  form1.alpha.focus();
}
function f_ext(flag)
{
  var op=form1.ext2.options;
  if(flag)
  {
    var v=form1.add.value;
    if(v=="")return;
    form1.add.value="";
    for(var i=0;i<op.length;i++)
    {
      if(op[i].value==v)
      {
        return;
      }
    }
    op[op.length]=new Option(v,v);
  }else
  {
    for(var i=0;i<op.length;i++)
    {
      if(op[i].selected)
      {
        op[i]=null;
        i--;
      }
    }
  }
}
function f_submit()
{
  var ext="/";
  var op=form1.ext2.options;
  for(var i=0;i<op.length;i++)
  {
    ext=ext+op[i].value+"/";
  }
  form1.ext.value=ext;
  return(submitInteger(form1.alpha, '<%=r.getString(teasession._nLanguage,"透明度")%>'));
}
</script>
</head>
<body onload="f_load()">

<h1>水印管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditWatermark" method="POST" enctype="multipart/form-data" target="_ajax" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type='hidden' name="watermark" value="false">
<input type="hidden" name="ext" value="<%=ext%>">
<input type="hidden" name="nexturl">

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"位置")%>:</td>
    <td>
    <%
    for(int i=0;i<Watermark.LOCA_TYPE.length;i++)
    {
      out.print("<input type=radio name=location value="+i);
      if(i==location)
      {
        out.print(" checked ");
      }
      out.print(" >"+Watermark.LOCA_TYPE[i]);
    }
    %>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"水印")%>:</td>
    <td><input type="file" name="logo" onchange="f_click(this)" size="40"><br><img id="view" src="<%=logo%>" /></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"透明度")%>:</td>
    <td><input type="text" name="alpha" value="<%=alpha%>" mask="int" size="5">% 1-100</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"水印缩放比例")%>:</td>
    <td><input type="text" name="zoom" value="<%=zoom%>" mask="int" size="5">% 1-100</td>
  </tr>
  <tr>
    <td>类型:</td>
    <td>
      <%
      for(int i=0;i<TYPE.length;i++)
      {
        out.print("<input type='checkbox' name='type' value='"+TYPE[i]+"' id='t"+TYPE[i]+"'");
        if(obj.type.indexOf("|"+TYPE[i]+"|")!=-1)out.print(" checked");
        out.print("><label for='t"+TYPE[i]+"'>"+r.getString(teasession._nLanguage,Node.NODE_TYPE[TYPE[i]])+"</label>　");
      }
      %>
      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"水印的文件格式")%>:</td>
    <td><select name="ext2" size="5" style="width:150px">
    <%
    if(ext!=null)
    {
      String arr[]=ext.split("/");
      for(int i=1;i<arr.length;i++)
      {
        out.print("<option value='"+arr[i]+"'>"+arr[i]);
      }
    }
    %>
        </select><br>
    <input type="text" name="add" size="12"/><input type="button" onclick="f_ext(true);" value=" ＋ "/><input type="button" onclick="f_ext(false);" value=" － "/>
    </td>
  </tr>
  <tr>
    <td></td>
    <td><input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
  </tr>
</table>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td>注: 上传透明PNG图片,可获得最佳效果.</td></tr>
</table>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
