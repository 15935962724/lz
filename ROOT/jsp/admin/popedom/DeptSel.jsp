<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

//AdminUnit.getRootId(h.community);
//AdminUnit obj=AdminUnit.getRoot(h.community);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

String itype=h.get("itype","checkbox");
int type="checkbox".equals(itype)?1:2;
par.append("&itype="+itype);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}
if(sql.length()>0)
{
  Iterator it=AdminUnit.find(sql.toString(),0,200).iterator();
  sql.setLength(0);
  sql.append(" AND dept IN(");
  while(it.hasNext())
  {
    AdminUnit t=(AdminUnit) it.next();
    sql.append(t.path.substring(1).replace('/',','));
  }
  sql.append("0)");
}


String depts=h.get("depts","");//"|";
int subcontractor=h.getInt("subcontractor");
//if(subcontractor>0)
//{
//  depts=SubContractor.find(subcontractor).depts;
//}

//默认展开
StringBuilder paths=new StringBuilder("|");
if(depts.length()>1)
{
  Iterator it=AdminUnit.find(" AND id IN("+depts.substring(1).replace('|',',')+"0)",0,Integer.MAX_VALUE).iterator();
  while(it.hasNext())
  {
    AdminUnit d=(AdminUnit)it.next();
    String path=d.path.substring(1,d.path.lastIndexOf('/',d.path.length()-2)+1);
    paths.append(path.replace('/','|'));
  }
}


%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.list{border:1px solid #0A95F1;height:280px;overflow:auto;text-align:left;width:95%;padding:5px;margin-bottom:10px}
.tree{padding-left:20px;}
</style>
</head>
<body class="iframe">

<form name="form1" action="?">
<input type="hidden" name="subcontractor" value="<%=subcontractor%>"/>
<input type="hidden" name="itype" value="<%=itype%>"/>
<input type="hidden" name="depts" value="<%=depts%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称：</td>
  <td><input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>

<form name="form2" action="?">
<div class="list">
<%
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
String[] arr=aur.classes.split("/");
for(int i=1;i<arr.length;i++)
{
  AdminUnit d=AdminUnit.find(Integer.parseInt(arr[i]));
  out.print("<div id='Departmentlist'><input type='radio' name='depts' value='"+d.id+"' id='d_"+d.id+"'><label for='d_"+d.id+"'>"+d.name+"</label></div><div class='tree'>"+d.toTree(type,sql.toString(),paths.toString())+"</div>");
}
%>
</div>

<input type="button" name="multi" value="确 定" onclick="mt.act()"/>
<input type="button" value="取 消" onclick="pmt.close()"/>
</form>

<script>
//默认选中
var arr="<%=depts%>".split("|");
for(var i=1;i<arr.length-1;i++)
{
  var t=$('d_'+arr[i]);
  if(t)t.checked=true;
}

//
mt.disabled(form2.depts);
var pmt=parent.mt;
mt.tree=function(img)
{
  var p=img.parentNode,d=p.nextSibling,ish=d.style.display=="";
  ish=d.style.display=="";
  d.style.display=ish?"none":"";
  img.src="/tea/image/tree/"+(ish?"plus":"minus")+".gif";
  if(d.innerHTML!="")return;
  d.innerHTML="load...";
  mt.send("/Depts.do?act=ajax&dept="+p.id+"&type=<%=type%>&key=<%=MT.enc(sql.toString())%>&depts=|",function(h){d.innerHTML=h.substring(h.indexOf('\n')+1)||"无子项";mt.disabled(form2.depts);mt.red('LABEL',form1.name.value);});
};
mt.act=function()
{
  var arr=form2.depts,a='|',b='',h='';
  if(!arr.length)arr=new Array(arr);
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    var n=t.nextSibling.innerText;
    a+=t.value+'|';
    b+=n+'；';
    h+="<span><input type='hidden' name='"+t.name+"' value='"+t.value+"'/>"+n+"<img src='/tea/image/d7.gif' onclick='mt.del(this)' /></span>";
  }
  pmt.receive(a,b,h);
  pmt.close();
};

//if("<%=itype%>"=="radio")
//{
//  var arr=form2.depts;
//  for(var i=0;i<arr.length;i++)
//  {
//    arr[i].onclick=function(){mt.radio(this)};
//  }
//}

//标红
mt.red('LABEL',form1.name.value);

mt.fit();
</script>
</body>
</html>
