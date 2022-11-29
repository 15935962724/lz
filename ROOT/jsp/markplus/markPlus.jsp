<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.tobacco.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%>
<%@page import="tea.entity.markplus.MarkPlus"%>

<%

Http h=new Http(request,response);
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append(" &community="+h.community);

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");

%>

<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.len{background:#000000;color:#FFFFFF;width:80px;margin-top:-3px;}
</style>
<form name="form2" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="markplus"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
<%
int sum=MarkPlus.count(sql.toString());
if(sum<1)
{
  out.print("暂无记录!");
}else
{
  sql.append(" ORDER BY sequence ASC");
  Iterator it=MarkPlus.find(sql.toString(),pos,Integer.MAX_VALUE).iterator();
  out.println("<div colspan='2' class='texleft'><ul>");
  for(int i=1+pos;it.hasNext();i++)
  {
	  MarkPlus t=(MarkPlus)it.next();
	  String imgStr = "";
	  if(t.getPath()>0){
		  Attch a=Attch.find(t.getPath());
	      if(a.path!=null)
	    	  imgStr = "<img src='"+a.path+"'/>"; 
	  }
	  out.println("<li><div class='left'><a href='###' onclick='mt.mark("+t.getId()+","+t.getId()+")'>"+imgStr+"</a></div>");
	  out.println("<div class='right'><a href='###' onclick='mt.mark("+t.getId()+","+t.getId()+")'><span>"+MT.f(t.getName())+"</span><span id='mark_"+t.getId()+"' class='num'>("+t.getClick()+MT.f(t.getUnit())+")</span></a></div></li>");
  }
  out.println("</ul></div>");
}%>
</form>

<script>
mt.mark=function(id,v)
{
	var markA = document.getElementById("mark_"+id);
	mt.up(markA,'+1',function()
	{
		mt.send("/EditMarkPlus.do?act=markplus&markplus="+v,function(d)
		{
			//alert(d);
			if(d=='true'){
				//alert(markA.innerHTML);
				var rs=/\d+/.exec(markA.innerHTML);
				//alert(rs);
				markA.innerHTML=markA.innerHTML.replace(rs[0],parseInt(rs[0])+1);
			}
		});
	});
};
</script>

