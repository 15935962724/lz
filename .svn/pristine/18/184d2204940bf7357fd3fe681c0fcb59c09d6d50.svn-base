<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.html.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.site.*" %>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
int action=0,classmap=0;
int stops = 8;
if(request.getParameter("stops")!=null && request.getParameter("stops").length()>0)
{
	 stops = Integer.parseInt(request.getParameter("stops"));
}

try
{
  action=Node.getRoot(teasession._strCommunity);//Integer.parseInt(request.getParameter("action"));
  classmap=action;//Integer.parseInt(request.getParameter("classmap"));
}catch(NumberFormatException ex)
{
  out.print("action参数:点击\"对比选中商品\",转到的节点号.  必须有.<br>");
  out.print("classmap参数:点击\"分类\",转到的节点号.  必须有.<br>");
  return;
}
int goodstype=1;
//try
//{
  if(request.getParameter("goodstype")!=null && request.getParameter("goodstype").length()>0)
  {
     goodstype=Integer.parseInt(request.getParameter("goodstype"));
  }


	//if(goodstype==1)goodstype=175033;
//}catch(NumberFormatException ex)
//{
  //out.print("goodstype参数: 必须有.");
 // return;
//}

GoodsType gt=GoodsType.find(goodstype);


Community community=Community.find(teasession._strCommunity);

Node node=Node.find(classmap);


String brand=request.getParameter("brand");

//System.out.println("9000-GoodsTypeList2.jsp----teasession._nNode=="+teasession._nNode+gt.getPath()+"##"+request.getQueryString());

%>
<!-- 9000分类导航的二级页 -->
<html>
<head>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>





<jsp:include flush="true" page="/jsp/type/goods/newgoods/9000_GoodsList.jsp">
<jsp:param name="community" value="<%=teasession._strCommunity%>"/>
<jsp:param name="action" value="<%=action%>"/>
<jsp:param name="brand" value="<%=brand%>"/>
</jsp:include>

</body>
</html>
