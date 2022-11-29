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


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>搜索源</h1>
<div id="head6"><img height="6" alt=""></div>



<h2>字段</h2>
<form name="form2" action="/Lucenes.do" method="post" target="_ajax">
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="lucene"/>
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="create"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id=tableonetr>
    <td></td>
    <td><%=r.getString(h.language,"Subject")%></td>
    <td>类型</td>
    <td>字段</td>
    <td><%=r.getString(h.language,"Sequence")%></td>
    <td>操作</td>
  </tr>
<%
ArrayList al=Lucene.find(" AND lucenelist="+lucenelist,0,200);
for(int i=0;i<al.size();i++)
{
  Lucene obj=(Lucene)al.get(i);

  out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+(i+1)+"<input type='checkbox' name='lucenes' value="+obj.lucene+" style='display:none' />");
  out.print("<td>"+obj.getSubject(h.language)+"</td>");
  out.print("<td>"+r.getString(h.language,Lucene.INPUT_TYPE[obj.itype])+"</td>");
  out.print("<td>"+obj.field+"</td>");
  out.print("<td><img name='sequence' src='/tea/image/public/move2.gif' /></td>");
  out.println("<td><a href=javascript:mt.act('edit',"+obj.lucene+")>"+r.getString(h.language,"CBEdit")+"</a>");
  if(obj.isLayerExists(h.language))
  {
    out.println("<a href=javascript:mt.act('del',"+obj.lucene+")>"+r.getString(h.language,"CBDelete")+"</a>");
  }
  //选择对象
  if(obj.itype==1||obj.itype==2)
  {
    out.println("<a href=javascript:mt.act('cho',"+obj.lucene+")>"+r.getString(h.language,"1167881089765")+"</a>");
  }
}
%>
</table>
<input type="button" value="添加" onclick="mt.act('edit',0)"/>


<br/><br/>
<h2>索引文件</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
<td><%=r.getString(h.language, "Languages")%></td><td><%=r.getString(h.language, "Length")%></td><td><%=r.getString(h.language, "Time")%></td>
</tr>
<%
java.text.DecimalFormat df=new java.text.DecimalFormat("#,###");
for(int lang=0;lang<Common.LANGUAGE.length;lang++)
{
  java.io.File f=new java.io.File(application.getRealPath("/res/"+h.community+"/searchindex/"+lucenelist+"_"+lang));
  if(f.exists())
  {
    long size=0;
    java.util.Date time=null;
    java.io.File files[]=f.listFiles();
    for(int index=0;index<files.length;index++)
    {
      size=size+files[index].length();
      if("segments.gen".equals(files[index].getName()))
      {
        time=new java.util.Date(files[index].lastModified());
      }
    }
    if(time!=null)
    {
      out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" >");
      out.print("<td>"+r.getString(h.language, Common.LANGUAGE[lang]));
      out.print("<td align=right >"+df.format((size>1024)?size/1024:1)+" KB");
      out.print("<td>"+tea.entity.Entity.sdf2.format(time) );
    }
  }
}
%>
</table>
<!--生成索引-->
<%
out.println("<input name='index' type=button onclick=mt.act(name,0,1) value="+r.getString(h.language,"1167900055500")+">");
out.println("<input name='index' type=button onclick=mt.act(name,0,0) value="+r.getString(h.language,"differences")+">");
//out.println("<input type=button onclick=\"window.open('Lucenehours.jsp?lucenelist="+lucenelist+"&nexturl="+request.getParameter("nexturl")+"','_self'); \" value="+r.getString(h.language,"SetHours")+">");
%>
</form>


<br/><br/>
<h2>引用代码</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><textarea cols="80" rows="4">
&lt;include src="/jsp/util/Search.jsp?community=<%=h.community%>&lucenelist=<%=lucenelist%>"/>
</textarea>
</table>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.sequence(form2.lucenes);
mt.act=function(a,i,b)
{
  form2.act.value=a;
  form2.lucene.value=i;
  if(a=='del')
  {
    mt.show("您确定要删除吗？",2,"form2.submit();");
  }else
  {
    if(a=='index')
    {
      form2.create.value=b;
      mt.show(null,0);
    }else
    {
      if(a=='edit')
      form2.action='/jsp/util/LuceneEdit.jsp';
      else if(a=='cho')
      form2.action='/jsp/util/EditLucenechoice.jsp';
      form2.method=form2.target='';
    }
    form2.submit();
  }
};
</script>


<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
