<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);


Poll p=Poll.find(h.getInt("poll"));

if(!h.getBool("inc"))
{
  out.println("<html><head>");
  out.println("<link href='/res/"+h.community+"/cssjs/community.css' rel='stylesheet' type='text/css' />");
  out.println("<script src='/tea/mt.js' type='text/javascript'></script>");
  out.println("<style>#template{display:none}</style>");
  out.println("</head><body><h1>问卷设计</h1><div id='head6'><img height='6' src='about:blank'></div>");
}
%>


<form name="frmpoll" action="/MVotes.do" method="post" target="_ajax" onsubmit="return mt.check(this)&&(mt.show(null,0)||localStorage.removeItem(location.pathname))">
<input type="hidden" name="poll" value="<%=p.poll%>"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl" value="/html/<%=h.community%>/folder/<%=h.node%>-<%=h.language%>.htm"/>
<%=p.toString(1)%>

<br/>
<span style="width:102px;float:right;display:block;"><input class="pollbut" type="submit" value="提交"/></span>
<span style="font-weight:bold;color:#000;font-size:14px;float:right;line-height:29px;display:block;width:300px;">（注：您需要回答完所有问题方可提交。）</span>
<div id="polldiv" style="position: absolute; right: 100px; top: 100px;">
<input type="button" value="保存" onclick="mt.storage(form,true);mt.show('数据保存成功！');"/>
</div>
</form>


<script>
if(mt.isD)document.write("<a href='javascript:mt.fill(frmpoll)'>write</a>");

var submit=$$("polldiv");setInterval('submit.style.top=document.body.scrollTop+100;',100);

mt.storage(frmpoll,false);//恢复数据

</script>
