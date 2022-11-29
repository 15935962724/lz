<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?nexturl=" + Http.enc(request.getRequestURI() + "?" + request.getQueryString()));
  return;
}

int poll=h.getInt("poll");
int question=h.getInt("question");


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#template{display:none}
</style>
</head>
<body>
<h1>问卷设计</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<div id="tool" style="position:fixed; background:#F7F6DF; border:1px solid #EFE8AB; padding:10px; text-align:center">
<a href="javascript:mt.act('add',0,0)"><img src="/tea/image/poll/radio.gif"/></a>
<a href="javascript:mt.act('add',0,1)"><img src="/tea/image/poll/check.gif"/></a>
<a href="javascript:mt.act('add',0,2)"><img src="/tea/image/poll/select.gif"/></a>
<a href="javascript:mt.act('add',0,3)"><img src="/tea/image/poll/text.gif"/></a>
<a href="javascript:mt.act('add',0,4)"><img src="/tea/image/poll/textarea.gif"/></a>
<a href="javascript:mt.act('add',0,10)"><img src="/tea/image/poll/separator.gif"/></a>
<a href="javascript:mt.act('fast')"><img src="/tea/image/poll/fast.gif"/></a>
</div>

<form name="form1" action="?">
<input type="hidden" name="poll" value="<%=poll%>"/>
<input type="hidden" name="question" value="<%=question%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
</form>

<form name="form2" action="/MQuestions.do" method="post" target="_ajax" style="padding-top:80px;">
<input type="hidden" name="poll" value="<%=poll%>"/>
<input type="hidden" name="question" value="<%=question%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="type"/>
<input type="hidden" name="choice"/>
<input type="hidden" name="top"/>

<%
Iterator it=Question.find(" AND poll=" + poll,0,Integer.MAX_VALUE).iterator();
for(int i=1;it.hasNext();i++)
{
  Question t=(Question)it.next();
  out.print("<input type='hidden' name='questions' value='"+t.question+"' />");

  out.println("<div class='question'>"+t.name[1]+"</div>");
  out.print("<div class='but'><a href=javascript:mt.act('editor',"+t.question+")>编辑</a> ");
  out.print("<a href=javascript:mt.act('clone',"+t.question+")>复制</a> ");
  out.print("<a href=javascript:mt.act('del',"+t.question+")>删除</a> ");
  //out.print("<a href='###' name='sequence'>移动</a> ");
  out.print("</div>");
  if(t.type==10)
  {
    out.print(t.content[1]);
  }else
  {
    if(MT.f(t.content[1]).length()>0)out.println("<div class='subtitle'>"+t.content[1]+"</div>");
    out.print("<div class='choice'>");
    if(t.type==3)
    {
      out.print("<input name='"+t.question+"'");
      if(t.width>0)out.print(" style='width:"+t.width+"px'");
      out.print(" >");
    }else if(t.type==4)
    {
      out.print("<textarea name='"+t.question+"' cols='40' rows='3'");
      if(t.width>0)out.print(" style='width:"+t.width+"px'");
      out.print(" ></textarea>");
    }else
    {
      if(t.type==2)out.print("<select name='"+t.question+"'><option value='0'>--");
      Iterator ic=Choice.findByQuestion(t.question).iterator();
      while(ic.hasNext())
      {
        Choice c=(Choice)ic.next();
        if(t.type==2)
        out.print("<option value='"+c.choice+"'>"+c.name[1]);
        else
        out.print("<input type='"+(t.type==0?"radio":"checkbox")+"' name='"+t.question+"' value='"+c.choice+"' id='C"+c.choice+"' /><label for='C"+c.choice+"'>"+MT.f(c.name[1])+"</label>　");
      }
      if(t.type==2)out.print("</select>");
    }
    out.print("</div>");
  }
  if(t.question==question)
  {
  %>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td rowspan="2">标题</td>
    <td>中文</td>
    <td><input name="name1" value="<%=MT.f(t.name[1])%>" size="40" alt="标题"/></td>
    <td rowspan="4" valign="top">
    <%
    if(t.type<3)
    {
      Iterator ic=Choice.find(" AND question="+t.question,0,Integer.MAX_VALUE).iterator();
      while(ic.hasNext())
      {
        Choice c=(Choice)ic.next();
        out.print("<div><input type='hidden' name='choices' value='"+c.choice+"' />");
        out.print("中文<input name='cname1_"+c.choice+"' value='"+MT.f(c.name[1])+"' />");
        out.print("　英文<input name='cname0_"+c.choice+"' value='"+MT.f(c.name[0])+"' />");
        out.print("<a href='###' onclick=c.act('del',this)><img src='/tea/image/poll/del.gif'></a></div>");
      }
      out.print("<div id='template'>中文<input name='cname1' />　英文<input name='cname0' /><a href='###' onclick=c.act('del',this)><img src='/tea/image/poll/del.gif'></a></div>");
      out.print("<a href=javascript:c.act('add',0)><img src='/tea/image/poll/add.gif'/></a>");
    }
    %>
    </td>
    <td><input type="button" value="保存" onclick="mt.act('edit')"></td>
  </tr>
  <tr>
    <td>英文</td>
    <td><input name="name0" value="<%=MT.f(t.name[0])%>" size="40"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2">说明</td>
    <td>中文</td>
    <td><textarea name="content1" cols="40" rows="3"><%=MT.f(t.content[1])%></textarea></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>英文</td>
    <td><textarea name="content0" cols="40" rows="3"><%=MT.f(t.content[0])%></textarea></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td></td>
    <td>必选</td>
    <td><input name="required" type="radio" value="1" id="required_1" checked="checked"/><label for="required_1">是</label>　<input name="required" type="radio" value="0" id="required_0" <%if(!t.required)out.print(" checked='checked' ");%>/><label for="required_0">否</label></td>
  </tr>
<%
if(t.type==3||t.type==4)
{
%>
  <tr>
    <td></td>
    <td>宽度</td>
    <td><input name="width" value="<%=MT.f(t.width)%>" size="10" mask="int"/>像素</td>
  </tr>
<%
}
%>  <tr>
    <td></td>
    <td>顺序</td>
    <td><input name="sequence" value="<%=t.sequence%>" mask="int"/></td>
    <td>答案<select name="answer"><option value="0">--</option>
      <%
      if(t.type<3)
      {
        Iterator ic=Choice.find(" AND question="+t.question,0,Integer.MAX_VALUE).iterator();
        while(ic.hasNext())
        {
          Choice c=(Choice)ic.next();
          out.print("<option value='"+c.choice+"'");
          if(c.choice==t.answer)out.print(" selected");
          out.print(">"+MT.f(c.name[1]));
        }
      }
      %>
      </select>
    </td>
  </tr>
</table>
  <%
  }
}
%>

<br/>
<input type="button" value="返回" onClick="location='/jsp/type/mpoll/Polls.jsp'"/>
</form>




<script>
if(mt.isIE)
{
  var tool=document.getElementById('tool').style;
  tool.position='absolute';
  setInterval('tool.top=document.body.scrollTop+14;',200);
}

//mt.sequence(form2.questions);

var c={};
c.act=function(a,o)
{
  var t=$('template');
  if(a=='del')
  {
    o=o.parentNode;
    o.parentNode.removeChild(o);
  }else if(a=='add')
  {
    var p=t.parentNode;
    var n=t.cloneNode(true);
    n.removeAttribute("id");
    p.insertBefore(n,t);
  }
//  form2.action='/Choices.do';
//  form2.act.value=a;
//  form2.choice.value=i;
//  form2.submit();
};
//form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.top.value=document.body.scrollTop;
  if(a=='fast')
  {
    mt.show('/jsp/type/mpoll/QuestionSel.jsp',1,'题库',400,300);
    return;
  }else if(a=='edit')
  {
    if(!mt.check(form2))return;
  }else
  {
    form2.question.value=id;
    if(a=='add')
    {
      form2.type.value=b;
    }else if(a=='del')
    {
      mt.show('你确定要删除吗？',2,'form2.submit()');
      return;
    }else
    {
      form1.question.value=id;
      form1.submit();
      return;
    }
  }
  form2.submit();
};

window.onload=function()
{
  document.body.scrollTop="<%=h.getInt("top")%>";
};
</script>
</body>
</html>
