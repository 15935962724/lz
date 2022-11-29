<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %><%@page import="java.util.*"%><% request.setCharacterEncoding("UTF-8");

int goodstype=Integer.parseInt(request.getParameter("goodstype"));

TeaSession teasession=new TeaSession(request);

///////9000: 分类导航在各类别下要能滑出该类下面的品牌，滑出的那个只要列出该类别下关联的品牌名称就行了

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>

<div id=load >
<br>
<img src=/tea/image/public/load.gif >正在加载...
</div>
<div id=content style="display:none">
<%
out.flush();

GoodsType obj=GoodsType.find(goodstype);
String b=obj.getBrandlist();

StringBuffer sb=new StringBuffer("/");

  String str[]=b.split("/");
  for (int i = 1; i < str.length; i++)
  {
      int brand=Integer.parseInt(str[i]);
      if(sb.indexOf("/"+brand+"/")==-1)
      {
    	  sb.append(brand).append("/");
	      Brand brand_obj=Brand.find(brand);
	      if(brand_obj.isExists())
	      {
		      String name=brand_obj.getName(teasession._nLanguage);

	          out.print("<SPAN ID=brand_name>");
	          
			  int n=brand_obj.getNode();
		      if(n>0)
		      {
		          out.print("<a href=/servlet/Node?node="+n+"&Language="+teasession._nLanguage+" target=_top>");
		      }
		      out.print(name+"</A></SPAN>");
	      }
      }
  }

%>
</div>
<script>
document.getElementById('load').style.display='none';
document.getElementById('content').style.display='';
</script>
</body>
</html>
