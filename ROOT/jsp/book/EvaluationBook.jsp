<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>parent.mt.close();</script>");
  out.print("<script>parent.mt.show('请您先登录!',1,'/servlet/StartLogin?node="+h.node+"');</script>");
  //response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int review=h.getInt("review");
NReview t=NReview.find(review);

Node n=Node.find(h.node);



%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<form name="form1" action="/NReviews.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="review" value="<%=review%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" style="margin-top:40px;">
  <tr>
    <td class="th" width="45px">商品：</td>
    <td><%=n.getSubject(h.language)%></td>
  </tr>
  <tr>
    <td class="th">评分：</td>
    <td><%for(int i=5;i>0;i--)out.print("<div class='scoreDiv'><input type='radio' name='score' value='"+i+"' id='score_"+i+"' "+(t.score==i?" checked":"")+" /><label for='score_"+i+"'><div class='star' style='background-position:"+(i*13-65)+"px;'></div></label></div>");%></td>
  </tr>
  <tr>
    <td class="th">评价：</td>
    <td>
      <textarea name="content" cols="45" rows="5" alt="评价" onChange="$$('num').innerHTML=6000-value.length;" onKeyUp="onchange()"><%=MT.f(t.content)%></textarea>
      <div style="text-align:right">您还可以输入<span id="num"></span>字</div>
    </td>
  </tr>
  <tr>
    <td class="th">优点：</td>
    <td><input name="advantages" value="<%=MT.f(t.advantages)%>" alt="优点" size="50"/></td>
  </tr>
  <tr>
    <td class="th">缺点：</td>
    <td><input name="shortcomings" value="<%=MT.f(t.shortcomings,"暂时还没发现缺点哦！")%>" alt="缺点" size="50"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onClick="parent.mt.close();"/>
</form>

<script>
mt.focus();
form1.content.onchange();
</script>
