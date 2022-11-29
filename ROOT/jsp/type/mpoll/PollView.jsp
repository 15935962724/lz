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


<form name="frmpoll" action="/MVotes.do" method="post" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="poll" value="<%=p.poll%>"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="nexturl"/>

<%=p.toString(1)%>

<br/>
<input type="submit" value="提交"/>

<div id="d_save" style="position: absolute; right: 100px; top: 100px;">
<input type="button" value="保存" onclick="mt.storage(form,true);mt.show('数据保存成功！');"/>
</div>
</form>

<script>
var submit=$$("d_save");setInterval('submit.style.top=document.body.scrollTop+100;',100);

mt.storage(frmpoll,false);//恢复数据

//填写表单
mt.fill=function(f)
{
  f=f.elements;
  for(var i=0,j=100,s=0;i<f.length;i++)
  {
    if(/hidden|submit|button/.test(f[i].type))continue;
	if(f[i].tagName=='SELECT')
	{
	  if(f[i].options.length<=++s)continue;
	  f[i].selectedIndex=s;
	  if(f[i].onchange)f[i].onchange();
	}else if(f[i].type=='radio')
    {
      //f[i].checked=true;
      f[i].click();
    }else
	  f[i].value=j++;
  }
};
if(mt.isD)document.write("<a href='javascript:mt.fill(frmpoll)'>write</a>");
</script>
