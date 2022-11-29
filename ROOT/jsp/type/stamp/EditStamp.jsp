<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);


Node n=Node.find(h.node);
Stamp t;

int sequence;
String subject=null,content=null,keywords=null;
if(n.getType()==1)
{
  t=new Stamp(0,h.language);
  sequence=Node.getMaxSequence(h.node)+10;
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  sequence=n.getSequence();

  t=Stamp.find(h.node,h.language);
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑——邮票</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=n.getAncestor(h.language)%></div>

<form name="form1" action="/Stamps.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<%
String nexturl=h.get("nexturl");
if(nexturl!=null)out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' />");
%>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td align="right">邮票名称</td>
    <td><input name="subject" value="<%=MT.f(subject)%>" size="50" alt="邮票名称"/></td>
  </tr>
  <tr>
    <td align="right">编号</td>
    <td><input name="code" value="<%=MT.f(t.code)%>" alt="编号"/></td>
  </tr>
  <tr>
    <td align="right">邮票照片</td>
    <td>
      <input type="file" name="picture"/>
      <%
      if(MT.f(t.picture).length()>0)
      {
        out.print("<a href='###' onclick=mt.img('"+t.picture+"')>查看</a>");
        out.print("<input type='checkbox' name='clearpicture' onclick='form1.picture.disabled=this.checked'>清空");
      }
      %>
      <input type="checkbox" name="tbn" checked="checked" id="tbn"/><label for="tbn">自动缩小图片</label>
    </td>
  </tr>
  <tr>
    <td align="right">推荐图片</td>
    <td>
      <input type="file" name="recommend"/>
      <%
      if(MT.f(t.recommend).length()>0)
      {
        out.print("<a href='###' onclick=mt.img('"+t.recommend+"')>查看</a>");
        out.print("<input type='checkbox' name='clearrecommend' onclick='form1.recommend.disabled=this.checked'>清空");
      }
      %>
    </td>
  </tr>
  <tr>
    <td align="right">全套枚数</td>
    <td><input name="inumber" value="<%=MT.f(t.inumber)%>" size="10"/>张</td>
  </tr>
  <tr>
    <td align="right">面额</td>
    <td><input name="denomination" value="<%=MT.f(t.denomination)%>" size="10" mask="float"/>元</td>
  </tr>
  <tr>
    <td align="right">设计师</td>
    <td><input name="designer" value="<%=MT.f(t.designer)%>"/></td>
  </tr>
  <tr>
    <td align="right">尺寸</td>
    <td><input name="dimension" value="<%=MT.f(t.dimension)%>"/></td>
  </tr>
  <tr>
    <td align="right">齿孔</td>
    <td><input name="perforation" value="<%=MT.f(t.perforation)%>"/></td>
  </tr>
  <tr>
    <td align="right">邮票组成</td>
    <td><input name="part" value="<%=MT.f(t.part)%>" size="50"/></td>
  </tr>
  <tr>
    <td align="right">印刷商</td>
    <td><input name="printers" value="<%=MT.f(t.printers)%>" size="50"/></td>
  </tr>
  <tr>
    <td align="right">印刷工艺</td>
    <td><input name="printing" value="<%=MT.f(t.printing)%>" size="50"/></td>
  </tr>
  <tr>
    <td align="right">顺序</td>
    <td><input name="sequence" value="<%=sequence%>" mask="int"/></td>
  </tr>
  <tr>
    <td align="right">邮票简介</td>
    <td>
      <input id="html_0" type="radio" name="html" value=0 checked="checked"><label for="html_0">文本</label>
      <input id="html_1" type="radio" name="html" value=1 <%if((n.getOptions() & 0x40) != 0)out.print(" checked ");%> ><label for="html_1">HTML</label>
      <input id="nonuse" type="checkbox" name="nonuse" onClick="f_editor(this)"><label for="nonuse">不使用多媒体编辑器</label><br/>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=MT.f(content)%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <tr>
    <td align="right">发行日期</td>
    <td><%=h.selects("rtime",t.rtime)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
