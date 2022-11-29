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

String type=request.getParameter("type");
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
<script language="javascript" src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript"> 
var doc=window.dialogArguments.document;
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
      sendx("?ajax=ON&community=<%=teasession._strCommunity%>&node="+j,function(data){div.innerHTML=data; });
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
    if(!ns[i].checked||!ns[i].ntype)continue;
    if(nt.indexOf(ns[i].ntype)==-1)
    {
      nt.push(ns[i].ntype);
      o2=o2||ns[i].ntype>1;
    }
    if(ns[i].ntype=="1"&&nc.indexOf(ns[i].ncategory)==-1)nc.push(ns[i].ncategory);
  }
}

function f_submit(obj)
{
  if(submitText(obj.name,'<%=r.getString(teasession._nLanguage, "InvalidSelect")%>'))
  {
    var h=form1.node.value+","+form1.name.value;    
    window.returnValue=h;
    window.close();
  }
  return false;
}

function f_clear()
{
  var h=",";    
  window.returnValue=h;
  window.close();
  return false;
}
</script>
<style type="text/css">
#nt_step_2{ padding-left:20px; }
#nt_step_3{ padding-left:40px; }
</style>
</head>
<body onload="nt_ex('<%=n._nNode%>')">

<form name="form1" method="post" action="?" onSubmit="return f_submit(this);">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
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
<%
if(type!=null&&type.equals("query"))
{
%>
<input type="button" class="edit_button" value="清空" onclick="f_clear();">
<%
}
%>
<input type="button" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBClose")%>" onclick="window.close()">
</form>

</body>
</html>
