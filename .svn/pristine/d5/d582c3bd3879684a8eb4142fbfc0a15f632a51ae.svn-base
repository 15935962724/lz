
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int member=Profile.find(h.member).getProfile();

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

int node=h.getInt("node");
/* if(node>0)
{
  sql.append(" AND node LIKE "+DbAdapter.cite("%"+node+"%"));
  par.append("&node="+node);
} */

String title=h.get("title","");
if(title.length()>0)
{
  sql.append(" AND title LIKE "+DbAdapter.cite("%"+title+"%"));
  par.append("&title="+h.enc(title));
}

int score=h.getInt("score");
if(score>0)
{
  sql.append(" AND score LIKE "+DbAdapter.cite("%"+score+"%"));
  par.append("&score="+score);
}
int state=h.getInt("state");
if(state>0)
{
  sql.append(" AND state = "+state);
  par.append("&state="+state);
}

String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

String advantages=h.get("advantages","");
if(advantages.length()>0)
{
  sql.append(" AND advantages LIKE "+DbAdapter.cite("%"+advantages+"%"));
  par.append("&advantages="+h.enc(advantages));
}
String shortcomings=h.get("shortcomings","");
if(shortcomings.length()>0)
{
  sql.append(" AND shortcomings LIKE "+DbAdapter.cite("%"+shortcomings+"%"));
  par.append("&shortcomings="+h.enc(shortcomings));
}
Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(t1));
  par.append("&t1="+MT.f(t1));
}

int tab=h.getInt("tab");
String[] TAB={"全部","好评","中评","差评"};
String[] SQL={""," AND score IN(4,5)"," AND score IN(3)"," AND score IN(1,2)"};


int pos=h.getInt("pos");
par.append("&pos=");


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>图书评价</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<!-- <h2>查询</h2> -->
<form name="form1" action="?" style="display:none">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">评价：</td><td><input name="content" value="<%=content%>"/></td>
  <td class="th" >时间：</td><td colspan="3"><input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" class="date"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" class="date"/>　　<input type="submit" value="查询"/></td> 
</tr>
</table>
</form>
<script>
sup.hquery();
</script>
<!-- <h2>列表</h2> -->
<form name="form2" action="/NReviews.do" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="<%=menuid%>"/>
<input type="hidden" name="review"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="state"/>

<div class="switch">
<%
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' id='a_tab"+i+"'>"+TAB[i]+"（"+NReview.count(sql.toString()+SQL[i])+"）</a>");
}
%>
</div>
<script>$$("a_tab<%=tab%>").className="current";</script>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="1%"></td>
  <td width="2%">序号</td>
  <td>商品</td>
  <td>评价者</td>
  <td>评分</td>
  <td>操作</td>
</tr>
<%
sql.append(SQL[tab]);
int sum=NReview.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=NReview.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    NReview t=(NReview)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td align="center"><input type="checkbox" name="reviews" value="<%=t.review%>"/></td>
    <td><%=i%></td>
    <td><%=Node.find(t.node).getAnchor(h.language)%></td>
    <td><%=Profile.find(t.member).getMember()%></td>
    <td><div class='star' style='background-position:<%=t.score*13-65%>px;'></div></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('view',"+t.review+")>查看</a>");
    if(true)
    {
      /* out.println("<a href=javascript:mt.act('edit',"+t.review+")>编辑</a>"); */
      out.println("<a href=javascript:mt.act('del',"+t.review+")>删除</a>");
    }
    %>
    </td>
  </tr>
  <%
  }

}%>
 <tr>
  <td colspan="2">
    <input type="checkbox" onClick="mt.select(form2.reviews,checked)" id="sel"/><label for="sel">全选</label>
    
  </td>
  <td>
    <input name="alldel" type="button" value="批量删除" onClick="mt.act('alldel')"/></td>
  <td align="right" colspan="3"><%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)%></td>
</tr>
</table>
<br/>
<!-- <input type="button" value="添加" onclick="mt.act('edit','0')"/> -->
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
//审核
mt.naudit=function(b,id)
{   
	form2.act.value=b;
  mt.show("<form name='form4'><table><tr><td nowrap>状态：</td><td><input name='state' type='radio' value='2' id='state_2' onclick='mt.nreason(this)' /><label for='state_2'>批准</label>　<input name='state' type='radio' value='3' id='state_3' onclick='mt.nreason(this)' /><label for='state_3'>拒绝</label></td></tr></table></form>",2,"审核");
  $('state_'+(b==3?3:2)).click();
  mt.ok=function()
  {
    form2.state.value=mt.value(form4.state);
    form2.submit();
  };
};
mt.nreason=function(t,b)
{
  var tr=t.parentNode.parentNode.nextSibling;
  tr.style.display=t.value=='2'?"none":"";
};
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.review.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2);
    mt.ok=function(){
    	form2.submit();
    }
  }else if(a=='alldel'){
	  mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/jsp/book/NReviewView.jsp';
    else if(a=='edit')
      form2.action='/jsp/book/NReviewEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};

</script>
</body>
</html>
