<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");


Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String field=h.get("field");
boolean act="true".equals(h.get("act"));//true:管理 false:查看
String info=h.get("info");
if(info==null)info="上传附件";

int count=h.getInt("count",50);

if("POST".equals(request.getMethod()))
{
  String arr[]=h.getValues("file");
  String dts=h.get("dts");
//  if(arr!=null)
//  {
//    String str[]=new String[dts.length+arr.length];
//    System.arraycopy(dts,0,str,0,dts.length);
//    System.arraycopy(arr,0,str,dts.length,arr.length);
//    dts=str;
//  }
  if(arr!=null)
  {
    StringBuffer sb=new StringBuffer(dts);
    for(int i=0;i<arr.length;i++)
    {
      sb.append(":").append(arr[i]);
    }
    dts=sb.toString();
  }
  out.println("<script>");
  out.println("//var opener=opener?opener:dialogArguments; var dts=opener.document.all('"+field+"'); if(dts){ if(!dts.length)dts=new Array(dts); for(var i=0;i<dts.length;i++)dts[i].disabled=true;  }");
  out.println("window.returnValue=\""+dts+"\"; window.close();</script>");
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");


%><html>
<head>
<title><%=info%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>
var opener=opener?opener:dialogArguments;
var dts=opener.document.all("<%=field%>");
if(!dts)
{
  dts=new Array();
}else if(!dts.length)
{
  dts=new Array(dts);
}
function f_name(path)
{
  var j=path.lastIndexOf('/');
  if(j==-1)j=path.lastIndexOf('\\');
  return path.substring(j+1,path.lastIndexOf('.'));
}
</script>
</head>
<body>
<form name="form1" action="?" method="post" enctype="multipart/form-data" onSubmit="f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="dts" value="/">
<input type="hidden" name="field" value="<%=field%>"/>


<table border='0' cellpadding='0' cellspacing='0' id="TableAnnex" >
  <tr><td class="TableAnnextitle">请选择附件:
<tr>
<td>
<select id='sel' size='15' style='width:300px' ondblclick='f_view()'>
<script>
for(var i=0;i<dts.length;i++)
{
  if(dts[i].value.length>1)
  {
    document.write("<option value='"+dts[i].value+"'");
    if(i==0)document.write(" selected='true'");
    document.write(">"+f_name(dts[i].value));
  }
}
</script>
</select></td>
<td valign='top' id="inputbutton">
  <input type='button' name="view" onclick='f_view();' value=' 查 看 '/><br/>
  <%
  if(act)
  {
    out.print("<input type='button' name='del' onclick='f_del();' value=' 删 除 '/><br/><div>");
    for(int i=0;i<50;i++)
    {
      out.print("<input type='file' name='file' style='position:absolute;width:20px;filter:alpha(opacity=0);' onclick='return f_check()' onchange='f_add(this)'>");
    }
    out.print("<input type='button' value=' 添 加 '/></div>");
  }
  %><br/><br/>
  <input type='submit' value=' 确 定 '/><br/>
  <input type='button' onclick='window.close();' value=' 取 消 '/>
</td>
</tr>
</table>
</form>

<script>
var sel=document.getElementById("sel");
var op=sel.options;
var max=<%=count%>;
function f_submit()
{
  var dts="";
  for(var i=0;i<op.length;i++)
  {
    var v=op[i].value;
    if(v.indexOf('\\')==-1)
    {
      dts=dts+":"+v;
    }
  }
  form1.dts.value=dts;
}
function f_check()
{
  if(op.length>=max)
  {
    if(max==1)
    {
      op[0]=null;
    }else
    {
      alert("最多只能上传 "+max+" 个文件!!!");
      return false;
    }
  }
  return true;
}
function f_add(obj)
{
  obj.style.display="none";
  var v=obj.value;
  op[op.length]=new Option(f_name(v),v);
}
function f_del()
{
  if(confirm("确认删除?"))
  {
    for(var i=0;i<op.length;i++)
    {
      if(op[i].selected)
      {
        var v=op[i].value;
        if(v.indexOf('\\')!=-1)
        {
          var fs=form1.file;
          for(var j=0;j<fs.length;j++)
          {
            if(fs[j].value==v&&!fs[j].disabled)
            {
              fs[j].disabled=true;
              break;
            }
          }
        }
        op[i--]=null;
      }
    }
  }
}
function f_view()
{
  if(sel.value=="")return;
  window.open("/jsp/include/DownFile.jsp?uri="+encodeURIComponent(sel.value),"_ajax");
}
function f_dis()
{
  if(form1.del)
  {
    form1.del.disabled=(sel.value=="");
  }
  form1.view.disabled=(sel.value=="");
}
setInterval(f_dis,200);
</script>

</body>
</html>
