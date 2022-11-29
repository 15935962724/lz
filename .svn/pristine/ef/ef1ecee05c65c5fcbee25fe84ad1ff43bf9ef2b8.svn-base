<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.sup.*"%><%@page import="tea.ui.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}


SupQualification obj=SupQualification.getRoot();

String qualifications=h.get("qualifications");
int qualification=h.getInt("qualification");
SupQualification t=SupQualification.find(qualification);


StringBuffer sql=new StringBuffer(),par=new StringBuffer();
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}
if(sql.length()>0)
{
  Iterator it=SupQualification.find(sql.toString(),0,200).iterator();
  sql.setLength(0);
  sql.append(" AND qualification IN(");
  while(it.hasNext())
  {
    SupQualification sq=(SupQualification) it.next();
    sql.append(sq.path.substring(1).replace('|',','));
  }
  sql.append("0)");
}


%><html><head>
<base target="qualification_edit"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
body{text-align:left;border-right:none;}
.tree{margin-left:15px;}
.current{background-color:#FFFFFF}
</style>
</head>
<body>
<h1>图书分类</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?" target="_self">
<input type="hidden" name="qualifications" value="<%=qualifications%>"/>
<input type="hidden" name="qualification" value="<%=qualification%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td><input name="name" value="<%=name%>" size="12" style="float:left;width:67% !important;"/> <input type="submit" value="查询" style="float:right !important;" /></td>
</tr>
</table>
</form>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>
<span oncontextmenu='return mt.menu(event,cm(<%=obj.qualification%>))'><a href="SupQualificationList.jsp?qualification=<%=obj.qualification%>"><%=obj.name%></a></span><br/>
<%=obj.toTree(qualifications,0,sql.toString())%>
  </td>
</tr>
</table>

<script>
mt.mouse=function(a,b)
{
  var len=a.childNodes.length;
  if(len>2)a.lastChild.style.display=b?"":"none";
};
mt.tree=function(a)
{
  var p=a.parentNode;
  var d=p.nextSibling;
  var ish=d.style.display=="";
  d.style.display=ish?"none":"";
  a.src="/tea/image/tree/"+(ish?"plus":"minus")+".gif";
  //
  form1.qualifications.value=form1.qualifications.value.replace('|'+p.id+'|','|')+(ish?"":p.id+"|");
  //
  if(d.innerHTML!="")return;
  d.innerHTML="load...";
  mt.send("/SupQualifications.do?act=ajax&father="+p.id+'&key=<%=MT.enc(sql.toString())%>',function(h){d.innerHTML=h||"无子项";mt.red();});
}
var CUR=$$(<%=qualification%>);
if(CUR)CUR.className='current';
mt.click=function(a)
{
  if(CUR)CUR.className='';
  (CUR=a.parentNode).className='current';
  eval('d='+CUR.getAttribute('data'));
  form1.qualification.value=d.id;
  a.href="SupQualificationList.jsp?qualification="+d.id;
};
mt.red=function()
{
  var v=form1.name.value;
  if(v=='')return;
  var arr=document.getElementsByTagName('A');
  for(var i=0;i<arr.length;i++)
  {
    arr[i].innerHTML=arr[i].innerHTML.replace(v,'<font color=red>'+v+'</font>');
  }
};
mt.red();
function cm(i)
{
  return "<a href='SupQualificationEdit.jsp?father="+i+"'>添加</a><a href='SupQualificationEdit.jsp?qualification="+i+"'>编辑</a><a href='/SupQualifications.do?act=del&qualification="+i+"' onclick=\"return confirm('您确认要删除？')\" target='_ajax'>删除</a>";
}
</script>
</body>
</html>
