<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.util.*" %><%@page import="java.math.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

Resource r=new Resource("/tea/resource/Lucene");

if(h.get("ajax")!=null)
{
//  out.print("var field=document.getElementById('field');while(field.options.length>5){ field.options[5]=null; }");
  int ntype=Integer.parseInt(h.get("ntype"));
  if(ntype!=255)
  {
    String sql=null;
    if(ntype>65535)
    {
      ntype=TypeAlias.find(ntype).getType();
    }
    if(ntype<1024)
    {
      // r.add("/tea/resource/"+Node.NODE_TYPE[ntype]);

      String column="information_schema.COLUMNS",tab=DbAdapter.cite(Node.NODE_TYPE[ntype])+","+DbAdapter.cite(Node.NODE_TYPE[ntype]+"Layer");
      if(ConnectionPool._nType==2)//oracle
      {
        column="user_tab_columns";
        tab=tab.toUpperCase();
      }
      sql="SELECT COLUMN_NAME FROM "+column+" WHERE TABLE_NAME IN("+tab+") AND COLUMN_NAME NOT IN('language','picture') GROUP BY COLUMN_NAME";
    }else
    {
      sql="SELECT dynamictype FROM DynamicType WHERE dynamic="+ntype;
    }
    DbAdapter db=new DbAdapter();
    try
    {
      db.executeQuery(sql);
      while(db.next())
      {
        String label=db.getString(1);
        String name;
        if(ntype<1024)
        {
          name=r.getString(h.language,Node.NODE_TYPE[ntype]+"."+label.toLowerCase());
        }else
        {
          DynamicType dt=DynamicType.find(Integer.parseInt(label));
          name=dt.getName(h.language);
        }
        out.print("op[op.length]=new Option('"+name+"','"+label+"');");
      }
    }finally
    {
      db.close();
    }
  }
  return;
}

int lucenelist=Integer.parseInt(h.get("lucenelist"));
LuceneList ll=LuceneList.find(lucenelist);

if(request.getMethod().equals("POST"))
{
  String act=h.get("act");
  out.write("<script>var mt=parent.mt</script>");
  if("index".equals(act))
  {
    application.setAttribute("tea.Lucenelist"+lucenelist,Boolean.TRUE);
    for(int j = 0;j < 20;j++)out.write("// 显示进度条  \n");
    ll.index(h.language,out);
    application.removeAttribute("tea.Lucenelist"+lucenelist);
  }else if("diff".equals(act))
  {  application.setAttribute("tea.Lucenelist"+lucenelist,Boolean.TRUE);
   for(int j = 0;j < 20;j++)out.write("// 显示进度条  \n");
   //   out.flush();
    ll.index_diff(h.language,out);
     application.removeAttribute("tea.Lucenelist"+lucenelist);
  }

  int id=Integer.parseInt(h.get("lucene"));
  if("move".equals(act))
  {
    boolean seq="true".equals(h.get("sequence"));
    Vector v=Lucene.findByLucenelist(lucenelist);
    for(int i=0;i<v.size();i++)
    {
      int lid=((Integer)v.get(i)).intValue();
      Lucene obj=Lucene.find(lid);
      int j=(i+1)*2;
      if(id==lid)
      {
        j=seq?j-3:j+3;
      }
      obj.setSequence(j);
    }
  }else
  {
    if(h.get("delete")!=null)
    {
      Lucene obj=Lucene.find(id);
      obj.delete(h.language);
    }else if("edit".equals(act))
    {
      String subject=h.get("subject");
      int qtype=Integer.parseInt(h.get("qtype"));
      int itype=Integer.parseInt(h.get("itype"));
      int ntype=Integer.parseInt(h.get("type"));
      String field=h.get("field");
      String before=h.get("before");
      String after=h.get("after");
      if(id==0)
      {
        Lucene.create(lucenelist,qtype,itype,ntype,field,h.language,subject,before,after);
      }else
      {
        Lucene obj=Lucene.find(id);
        obj.set(qtype,itype,ntype,field,h.language,subject,before,after);
      }
    }
  }
  out.print("<script>mt.show('操作执行成功！',1,'"+h.get("nexturl")+"');</script>");
  return;
}

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
<form name="form1" method="POST" action="?" target="_ajax">
<input type="hidden" name="lucene" value="0"/>
<input type="hidden" name="act" value="edit">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type="hidden" name="sequence">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(h.language, "Subject")%></td>
    <td><input name="subject" type="text" value=""></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "1167558807078")%><!--条件类型--></td>
    <td>
    <select name="qtype">
    <%
    for(int i=0;i<Lucene.QUERY_TYPE.length;i++)
    {
      out.print("<option value="+i+" >"+r.getString(h.language,Lucene.QUERY_TYPE[i]));
    }
    %>
    </select>
    </td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "1167558993671")%><!--INPUT类型--></td>
    <td>
    <select name="itype">
    <%
    for(int i=0;i<Lucene.INPUT_TYPE.length;i++)
    {
      out.print("<option value="+i+" >"+r.getString(h.language,Lucene.INPUT_TYPE[i]));
    }
    %>
    </select>
    </td>
  </tr>
<tr>
<td><%=r.getString(h.language, "Field")%></td>
<td><%=new tea.htmlx.TypeSelection(h.community,h.language, ll.type, false)%>
<select name="field" id="field">
</select>
</td></tr>
  <tr>
    <td><%=r.getString(h.language, "Before")%></td>
    <td><textarea name="before" cols="50" rows="4"></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(h.language, "After")%></td>
    <td><textarea name="after" cols="50" rows="4"></textarea></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(h.language, "Submit")%>" onClick="return(submitText(document.form1.subject,'<%=r.getString(h.language, "InvalidSubject")%>'));">
<script type="text/javascript">
form1.type.onchange=function(defaultvalue)
{
  var field=document.getElementById('field');
  var op=field.options;
  while(op.length>0)
  {
    op[0]=null;
  }
  if(this.value==255||single)
  {
    op[0]=new Option('<%=r.getString(h.language,"1167904108626")%>','q');//全文(所有)
    op[1]=new Option('<%=r.getString(h.language,"Subject")%>','subject');
    op[2]=new Option('<%=r.getString(h.language,"Keywords")%>','keywords');
    op[3]=new Option('<%=r.getString(h.language,"Text")%>','content');
    op[4]=new Option('<%=r.getString(h.language,"Path")%>','path');
    op[5]=new Option('<%=r.getString(h.language,"创建者")%>','creator');
    //field.options[4]=new Option('<%=r.getString(h.language,"1167904108626")%>','q');

    if(defaultvalue)field.value=defaultvalue;
  }
  if(this.value!=255||single)
  {
    sendx('?ajax=ON&ntype='+this.value,function(d){ eval(d); if(defaultvalue)field.value=defaultvalue; });
  }
}
//如果是单类型搜索
var single=form1.type.value!="255";
if(single)
{
  form1.type.style.display="none";
}
form1.type.onchange(); //change_ntype();


function f_move(id,seq)
{
  form1.lucene.value=id;
  form1.sequence.value=seq;
  form1.act.value="move";
  form1.submit();
}
</script>




<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(h.language, "Subject")%></td>
    <td><%=r.getString(h.language, "1167558993671")%><!--INPUT类型--></td>
    <td><%=r.getString(h.language, "Sequence")%></td>
    <td>&nbsp;</td>
  </tr>
<%
StringBuffer sb=new StringBuffer();
Vector v=Lucene.findByLucenelist(lucenelist);
for(int i=0;i<v.size();i++)
{
  int id=((Integer)v.get(i)).intValue();
  Lucene obj=Lucene.find(id);

  String subject=obj.getSubject(h.language);
  if(subject!=null)subject=subject.replaceAll("\"","&quot;");

  String before=obj.getBefore(h.language);
  if(before!=null)before=before.replaceAll("</","&lt;/");

  String after=obj.getAfter(h.language);
  if(after!=null)after=after.replaceAll("</","&lt;/");

  out.print("<tr onmouseover=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td>"+subject+"</td>");
  out.print("<td>"+r.getString(h.language,Lucene.INPUT_TYPE[obj.getItype()])+"</td><td>");
  if(i>0)
  out.print("<a href=javascript:f_move('"+id+"',true)><img src=/tea/image/public/arrow_up.gif></a>");
  else
  out.print("　&nbsp;");
  if(i+1<v.size())
  out.print("<a href=javascript:f_move('"+id+"',false)><img src=/tea/image/public/arrow_down.gif></a>");

  out.print("<textarea name=before_"+id+" style=display:none>"+before+"</textarea><textarea name=after_"+id+" style=display:none>"+after+"</textarea>");
  sb.append("case ").append(id).append(":");
  sb.append("form1.qtype.value=\""+obj.getQtype()+"\";");
  sb.append("form1.itype.value=\""+obj.getItype()+"\";");
  sb.append("form1.subject.value=\""+subject+"\";");
  sb.append("form1.before.value=form1.before_"+id+".value;");
  sb.append("form1.after.value=form1.after_"+id+".value;");
  sb.append("form1.lucene.value=\""+obj.getLucene()+"\";");
  sb.append("form1.sequence.value=\""+obj.getSequence()+"\";");
  sb.append("form1.type.value=\""+obj.getNtype()+"\"; form1.type.onchange(\""+obj.getField()+"\");");
  sb.append("form1.subject.focus();");
  sb.append("break;\r\n");

  out.println("<td><input type=button onclick=f_click("+id+"); value="+r.getString(h.language,"CBEdit")+">");
  if(obj.isLayerExists(h.language))
  {
    out.println("<input type=submit name=delete onclick=\"if(confirm('"+r.getString(h.language, "ConfirmDeleteTree")+"')){form1.lucene.value='"+id+"'; }else return false;\" value="+r.getString(h.language,"CBDelete")+" />");
  }
  //选择对象
  if(obj.getItype()==1||obj.getItype()==2)
  {
    out.println("<input type=button onclick=\"window.open('/jsp/util/EditLucenechoice.jsp?lucene="+id+"','_self');\" value="+r.getString(h.language,"1167881089765")+" />");
  }
}
%></table>
<script>
function f_click(id)
{
  switch(id)
  {
    <%=sb.toString()%>
  }
}
</script>


<!--生成索引-->
<%
if(application.getAttribute("tea.Lucenelist"+lucenelist)!=null)
  out.println("<input type=button disabled value="+r.getString(h.language,"1199330079125")+">");
else
  out.println("<input type=button onclick=mt.act('index') value="+r.getString(h.language,"1167900055500")+">");

out.println("<input type=button onclick=mt.act('diff') value="+r.getString(h.language,"differences")+">");
out.println("<input type=button onclick=\"window.open('Lucenehours.jsp?lucenelist="+lucenelist+"&nexturl="+request.getParameter("nexturl")+"','_self'); \" value="+r.getString(h.language,"SetHours")+">");
%>
</form>

<!--索引文件-->
<h2><%=r.getString(h.language, "1169088518156")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
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

<br>
<h2>CODE</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><textarea cols="80" rows="4">
&lt;include src="/jsp/util/Search.jsp?community=<%=h.community%>&lucenelist=<%=lucenelist%>"/>
</textarea>
</table>

<script>
mt.act=function(a)
{
  form1.act.value=a;
  mt.show(null,0);
  form1.submit();
}
</script>


<div id="head6"><img height="6" alt=""></div>
<div id="language"><%=new tea.htmlx.Languages(h.language,request)%></div>
</body>
</html>
