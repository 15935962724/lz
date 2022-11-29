<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.site.*" %><%@page  import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);


if(request.getParameter("ajax")!=null)
{
  Node n=Node.find(teasession._nNode);
  out.print(n.getTreeToHtml(teasession._nLanguage,0));
  return;
}

Resource r=new Resource("/tea/resource/Report");

Community c=Community.find(teasession._strCommunity);
Node n=Node.find(c.getNode());

String info=request.getParameter("info");

//ArrayList alt=new ArrayList();
//ArrayList alc=new ArrayList();
//int type=255,category=0;
//String ns=request.getParameter("nodes");
//if(ns!=null)
//{
//  String arr[]=ns.split("/");
//  for(int i=1;i<arr.length;i++)
//  {
//    int id=Integer.parseInt(arr[i]);
//    int t=Node.find(id).getType();
//    if(alt.indexOf(t)==-1)alt.add(t);
//    if(t==1)
//    {
//      t=Category.find(id).getCategory();
//      if(alc.indexOf(t)==-1)alc.add(t);
//    }
//  }
//}

%><html>
<head>
<title><%=c.getName(teasession._nLanguage)%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script type="text/javascript">
var doc=window.dialogArguments.document;
function tree(a)
{
  nt_ex(a.id.substring(1));
}
function nt_ex(j)
{
  var div=document.getElementById('ntd_'+j);
  var img=document.getElementById('nti_'+j);
  var flag=div.style.display=="none";
  div.style.display=flag?"":"none";
  if(img)img.src="/tea/image/tree/tree_"+(flag?"minus":"plus")+".gif";
  if(flag)
  {
    if(div.innerHTML=="")
    {
      div.innerHTML="<img src=/tea/image/public/load.gif>load...";
      sendx("?ajax=ON&community=<%=teasession._strCommunity%>&node="+j,function(data){div.innerHTML=data; f_hidden(); });
    }
  }
}

function nt_open(nid,obj)
{
  if(obj.parentNode.parentNode.ntype=="0")
  {
    for(var j=0;j<ntc.length;j++)
    {
      if(ntc[j]>1)
      {
        nt_ex(nid);
        return;
      }
    }
  }
  form1.node.value=nid;
  form1.name.value=obj.innerText;
}
var nt=new Array(),nc=new Array(),ntc=new Array(),o2=false;
var ns=doc.all("nodes");

if(ns)
{
  for(var i=0;i<ns.length;i++)
  {
    var ntype=ns[i].getAttribute('ntype');
    if(!ns[i].checked||!ntype)continue;
    if(nt.indexOf(ntype)==-1)
    {
      nt.push(ntype);
      o2=o2||ntype>1;
    }
    if(ntype=="1"&&nc.indexOf(ns[i].ncategory)==-1)nc.push(ns[i].ncategory);
  }
}
function f_hidden(flag)
{
  ntc=new Array().concat(nt);
  if(form1.options[2].checked)//子节点
  {
    for(var i=0;i<ntc.length;i++)
    {
      if(ntc[i]==1)
      {
        ntc.splice(i,1);
        break;
      }
    }
    ntc=ntc.concat(nc);
  }
  var ds=document.getElementsByTagName("DIV");
  if(flag)
  {
    for(var i=0;i<ds.length;i++)
    {
      if(ds[i].ntype)ds[i].style.display="";
    }
    form1.name.value="";
  }
  for(var i=0;i<ds.length;i++)
  {
    if(!ds[i].ntype||ds[i].ntype=="0")continue;
    for(var j=0;j<ntc.length;j++)
    {
      if(ntc[j]>1)
      {
        if(ds[i].ncategory!=ntc[j])ds[i].style.display="none";//类别不同
      }else
      {
        if(ds[i].ntype!="0")ds[i].style.display="none";//不是文件夹
      }
    }
  }
}
function f_submit(obj)
{
  if(submitText(obj.name,'<%=r.getString(teasession._nLanguage, "InvalidSelect")%>'))
  {
    var h=form1.node.value;
    if(form1.options)
    {
      for(var i=0;i<form1.options.length;i++)
      {
        if(form1.options[i].checked)
        {
          h+=","+form1.options[i].value;
          break;
        }
      }
    }
    window.returnValue=h;
    window.close();
  }
  return false;
}
</script>
<style type="text/css">
.nt_step{padding-left:18px;}
#nt_step_1{padding-left:0}
</style>
</head>
<body onload="nt_ex('<%=n._nNode%>')">

<form name="form1" method="post" action="?" onSubmit="return f_submit(this);">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <script>
  document.write("<tr><td>选项:</td><td>");
  document.write("<input name='options' type='radio' value='0' id='o0' checked='checked' onclick='f_hidden(true)' /><label for='o0'>选中的对象及子页面</label> ");
  document.write("<input name='options' type='radio' value='1' id='o1' onclick='f_hidden(true)' /><label for='o1'>选中的对象</label> ");
  document.write("<input name='options' type='radio' value='2' id='o2' onclick='f_hidden(true)'"+(o2?" disabled='true'":"")+" /><label for='o2'>子页面</label> ");
  </script>
  <tr>
    <td colspan="2">
      请选择目标:<br>
        <div style="overflow: scroll;width:100%;height:250px;">
          <div ntype="0">
            <span id ='std'><a href="###" onclick="nt_open(<%=n._nNode%>,this)"><%=n.getSubject(teasession._nLanguage)%></a></span>
            <div id="ntd_<%=n._nNode%>" style="display:none"></div>
        </div>
        </div>
    </td>
  </tr>
  <tr>
    <td><%=info%>:</td>
    <td><input name="name" readonly="readonly" size="50"/></td>
  </tr>
</table>

<input type="submit" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBSubmit")%>" >
<input type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onclick="window.close()">
</form>

</body>
</html>
