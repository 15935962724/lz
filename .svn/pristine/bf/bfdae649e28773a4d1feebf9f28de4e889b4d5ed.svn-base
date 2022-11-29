<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}



if("father".equals(h.get("act")))
{
  tree(out,h.getInt("father"));
  return;
}

ShopCategory r=ShopCategory.getRoot();

%>
<%!

private void tree(java.io.Writer jw,int fid)throws Exception
{
  Iterator e = ShopCategory.findByFather(fid).iterator();
  while(e.hasNext())
  {
    ShopCategory t=(ShopCategory)e.next();
    int sum=ShopCategory.count(" AND father="+t.category);
    if(t.hidden)t.name[1]="<strike>"+t.name[1]+"</strike>";
    jw.write("<span id='s"+t.category+"'><img src='/tea/image/tree/"+(sum>0?"plus":"minus")+".gif' onclick='"+(sum==0?"":"tree("+t.category+")")+"' align=absmiddle>");
    
    /* jw.write("&nbsp;<a href='"+(sum==0?"javascript:void(0);":"ShopCategoryList.jsp?category="+t.category+"")+"' title='子项："+sum+"'>"+t.name[1]+"</a><br/>"); */
    jw.write("&nbsp;<a href='ShopCategoryList.jsp?category="+t.category+"' title='子项："+sum+"'>"+t.name[1]+"</a><br/>");
    jw.write("<div class='tree' style='display:none'></div></span>\r\n");
  }
}

%>
<!DOCTYPE html><html>
<head>
<base target="category_edit"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function tree(id,t)
{
  var s=$('s'+id);
  if(!s)return;
  var i=s.firstChild,d=s.lastChild,ish=!t&&d.style.display=="";
  d.style.display=ish?"none":"";
  i.src="/tea/image/tree/"+(ish?"plus":"minus")+".gif";
  if(!t&&d.innerHTML!="")return;
  d.innerHTML="load...";
  mt.send("?act=father&father="+id,function(h){d.innerHTML=h||"无子项";});
}
</script>
<style type="text/css">
<!--
body {text-align:left;
	
	
	margin-right: 0px;
	margin-bottom: 0px;
}
.tree{margin-left:15px;}
img{border:0}
-->
</style>
</head>
<body style="height:100%;">
<style>
span{padding:5px 0px;width:100%;float:left;display:block;}
span img{float:left;margin-left:20px;margin-top:2px;}
span a{color:#333;}
</style>

<h1><a style="font-size:16px;color:#000;font-weight:bold;" href="ShopCategoryList.jsp?category=<%=r.category%>">分类管理</a></h1>
<%
tree(out,r.category);
%>

<script>
window.open('ShopCategoryList.jsp?category=<%=r.category%>','category_edit');
</script>
</body>
</html>
