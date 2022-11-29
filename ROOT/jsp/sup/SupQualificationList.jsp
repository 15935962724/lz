<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

sql.append(" AND deleted=0");

int qualification=h.getInt("qualification");
if(qualification<1)qualification=SupQualification.getRoot().qualification;
sql.append(" AND father="+qualification);
par.append("?qualification="+qualification);


int pos=h.getInt("pos");
par.append("&pos=");

SupQualification sq=SupQualification.find(qualification);

int sum=SupQualification.count(sql.toString());

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>图书分类</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div><%=sq.getAnchor()%></div>

<form name="form2" action="/SupQualifications.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="qualification"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter">
<tr id="tableonetr">
  <td></td>
  <td>名称</td>
  <td>编码</td>
  <td>规格</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=SupQualification.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    SupQualification t=(SupQualification)it.next();
    out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.print("<td align='center'><input name='qualifications' type='checkbox' value='"+t.qualification+"' />");
    out.print("<td align='center'><a href='?qualification="+t.qualification+"'>"+MT.f(t.name)+"</a>");
    out.print("<td align='center'>"+MT.f(t.code));
    out.print("<td align='center'>"+MT.f(t.spec));
    out.println("<td><a href=javascript:mt.act('edit',"+t.qualification+")>编辑</a>");
    out.println("<a href=javascript:mt.act('brand',"+t.qualification+")>品牌("+(t.brand.length()<2?0:t.brand.split("[|]").length-1)+")</a>");
    //out.println("<a href=javascript:mt.act('attrib',"+t.qualification+")>属性("+SupAttrib.count(" AND qualification="+t.qualification+" AND deleted=0")+")</a>");
    out.println("<a href=javascript:mt.act('del',"+t.qualification+")>删除</a>");
  }
%>
<tr>
  <td colspan="2">
    <input type="checkbox" onClick="mt.select(form2.qualifications,checked)" id="sel"/><label for="sel">全选</label>
    <input name="multi" type="button" value="批量删除" onClick="mt.act('del')"/>
  </td>
  <td align="right" colspan="20"><%=new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20)%></td>
</tr>
<%
}%>
</table>

<input type="button" onClick="mt.act('add',<%=qualification%>)" value="添加"/>
</form>


<script>
form2.nexturl.value=location.pathname+location.search;
mt.disabled(form2.qualifications);
mt.act=function(a,b)
{
  form2.act.value=a;
  form2.qualification.value=b;
  if(a=='del')
  {
    mt.show("确认删除此分类?",2,"form2.submit()");
  }else
  {
    if(a=='add')
      form2.qualification.name="father";
    if(a=='add'||a=='edit')
      form2.action='/jsp/sup/SupQualificationEdit.jsp';
    else if(a=='brand')
      form2.action='/jsp/sup/SupQualificationBrand.jsp';
    else if(a=='attrib')
      form2.action='/jsp/sup/SupAttribs.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
setFreeze(document.getElementsByTagName('TABLE')[0],0,1);
</script>
</body>
</html>
