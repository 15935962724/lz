<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.resource.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%


Http h=new Http(request,response);


Community community=Community.find(h.community);
h.node=community.getNode();

Node n=Node.find(h.node);

int tid=h.getInt("tid");
String act=h.get("act");
String name=h.get("name");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
body,td,th {font-size: 12px;}
.tree{padding-left:15px;}
</style>
</head>
<body>
<form name="form1" action="/STemplates.do" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="<%=act%>"/>
<input type="hidden" name="tid" value="<%=tid%>"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<div style="overflow-y:scroll;height:280px">
<img src='/tea/image/tree/tree_plus.gif' align=absmiddle onclick="f_c(this)" id="root" /><input type='checkbox' name="node" id='n0' value="<%=h.node%>" <%=tid==h.node?" disabled ":""%> onclick='mt.radio(this)' /><label for='n0'><%=n.getSubject(h.language)%><br/></label><div class='tree' style='display:none'></div>
</div>
<%=name%>：<input name="name" size="40" alt="名称"><br/>
<input type="submit" value=" 提 交 "/>
<input type="button" value=" 关 闭 " onclick="parent.mt.close()"/>
</form>
<script>
function f_c(a)
{
  var j=a.nextSibling,d=j.nextSibling.nextSibling;
  if(d.style.display=='')
  {
    d.style.display='none';
    a.src='/tea/image/tree/tree_plus.gif';
  }else
  {
    d.style.display="";
    a.src="/tea/image/tree/tree_minus.gif";
    if(d.innerHTML.length>0)return;
    d.innerHTML="<img src='/tea/image/public/load.gif'>load...";
    mt.send("/STemplates.do?act=tree&tid="+form1.tid.value+"&"+j.name+"="+j.value,function(h){d.innerHTML=h||"暂无";});
  }
}
mt.check=function(f)
{
  var n=mt.value(f.node);
  if(!n)
  {
    alert("至少要选择一项！");
    return false;
  }
  if(!f.name.value)
  {
    alert("“名称”不能为空！");
    f.name.focus();
    return false;
  }
}
$('root').click();
</script>
</body>
</html>
