<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


int category=h.getInt("category");

ShopCategory t=ShopCategory.find(category);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body style="border: none;padding-top:15px;background:none">

<form name="form2" action="/ShopCategorys.do" enctype="multipart/form-data" method="post" onsubmit="return mt.check(this)">
<input type="hidden" name="father" value="<%=h.getInt("father")%>"/>
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="act" value="edit"/>

<table id="tablecenter" cellspacing="0">
  <tr><td>分类名称</td><td><input name='name1' value="<%=MT.f(t.name[1])%>" size='30' alt='中文名称'/></td></tr>
  <%-- <tr><td>英文名称</td><td><input name='name0' value="<%=MT.f(t.name[0])%>" size='30'/></td></tr> --%>

  <%-- <tr><td>选项</td>
    <td>
      <input type='checkbox' name="pcolor" <%=t.pcolor?" checked":""%> id='_pcolor' ><label for='_pcolor'>颜色</label>
      <input type='checkbox' name="psize" <%=t.psize?" checked":""%> id='_psize' ><label for='_psize'>尺码</label>
    </td>
  </tr> 
  <tr>
  	<td>图片</td>
  	<td><input type="file" name="pic" /><%if(t.pic!=0)out.print(" <a href='###' onclick=mt.img('"+Attch.find(t.pic).path+"')>查看</a>");%></td>
  </tr>
  --%>
  <tr>
    <td>显示/隐藏</td>
    <td><input name='hidden' type='radio' value="0" id='hidden_0' checked="checked" /><label for='hidden_0'>显示</label> <input name='hidden' type='radio' value="1" id='hidden_1' <%=t.hidden?" checked":""%> /><label for='hidden_1'>隐藏</label></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交" />
<input type="button" value="关闭" onclick="parent.mt.close()"/>
</form>


</body>
</html>
