<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.util.*" %><%@page import="java.math.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

Resource r=new Resource("/tea/resource/Lucene");


int lucenelist=Integer.parseInt(h.get("lucenelist"));
LuceneList ll=LuceneList.find(lucenelist);

Lucene t=Lucene.find(h.getInt("lucene"));
if(t.lucene<1)
t.ntype=ll.type;


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(h.language, "1167900055500")%></h1>
<div id="head6"><img height="6" alt=""></div>

<br>
<form name="form1" action="/Lucenes.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="lucene" value="<%=t.lucene%>"/>
<input type="hidden" name="act" value="edit">
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(h.language, "Subject")%></td>
    <td><input name="subject" value="<%=MT.f(t.getSubject(h.language))%>" alt="标题"></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "1167558807078")%><!--条件类型--></td>
    <td><select name="qtype"><%=h.options(Lucene.QUERY_TYPE,t.qtype)%></select></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "1167558993671")%><!--INPUT类型--></td>
    <td><select name="itype"><%=h.options(Lucene.INPUT_TYPE,t.itype)%></select></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Field")%></td>
    <td><%=new tea.htmlx.TypeSelection(h.community,h.language,ll.type,false)%>
      <select name="field"></select>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "Before")%></td>
    <td><textarea name="before" cols="50" rows="4"><%=MT.f(t.getBefore(h.language))%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "After")%></td>
    <td><textarea name="after" cols="50" rows="4"><%=MT.f(t.getAfter(h.language))%></textarea></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(h.language, "Submit")%>">
<input type="button" value="返回" onclick="history.back()"/>


<script>
form1.qtype.value="<%=t.qtype%>";
form1.type.value="<%=t.ntype%>";
form1.type.onchange=function()
{
  var op=form1.field.options;
  while(op.length>0)op[0]=null;
  if(this.value==255||single)
  {
    op[0]=new Option('所有','q');//全文(所有)
    op[1]=new Option('主题','subject');
    op[2]=new Option('关键词','keywords');
    op[3]=new Option('内容','content');
    op[4]=new Option('路径','path');
    op[5]=new Option('创建者','creator');
    //op[6]=new Option('发生时间','starttime');
    op[6]=new Option('时间','time');
    //field.options[4]=new Option('所有','q');
  }
  form1.field.value="<%=t.field%>";
  if(this.value!=255||single)
  {
    mt.send(form1.action+'?act=ntype&ntype='+this.value,function(d)
    {
      eval(d.substring(d.indexOf('\n')+1));
      form1.field.value="<%=t.field%>";
    });
  }
}

//如果是单类型搜索
var single=<%=ll.type!=255%>;
if(single)form1.type.style.display="none";

form1.type.onchange();
</script>

<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
