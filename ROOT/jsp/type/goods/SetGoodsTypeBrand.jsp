<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.node.*"%><%@ page import="tea.entity.site.*" %><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
int gt_id=Integer.parseInt(teasession.getParameter("goodstype"));
tea.entity.admin.GoodsType gt_obj=tea.entity.admin.GoodsType.find(gt_id);
String brand=gt_obj.getBrand();
if(brand==null||(brand=brand.trim()).length()<1)
{
  brand="/";
}

if(request.getMethod().equals("POST"))
{
  String param_brand=request.getParameter("brand")+"/";
  if(request.getParameter("delete")!=null)
  {
    brand=brand.replaceFirst("/"+param_brand,"/");
  }else
  {
    brand+=param_brand;
  }
  gt_obj.setBrand(brand);
  response.sendRedirect(request.getParameter("nexturl"));
  return;
}

Community communitys=Community.find(teasession._strCommunity);
tea.resource.Resource r=new tea.resource.Resource();
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function fonchange()
{
  var brands_array=form1.brands.value.split("/");
  for(var i=1;i<brands_array.length;i++)
  {
    if(brands_array[i]==form1.brand.value)
    {
      form1.submit.disabled=true;
      form1.submit.value='此品牌已存在,不能重复提交.';
      return;
    }
  }
  form1.submit.disabled=false;
  form1.submit.value='提交';
}
</script>
</head>
<body>



<h1>品牌管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=gt_obj.getAncestor(teasession._nLanguage)%></div>

<form name="form1" action="<%=request.getRequestURI()%>" method="POST">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="goodstype" value="<%=gt_id%>"/>
<input type="hidden" name="brands" value="<%=brand%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String brands[]=brand.split("/");
for(int i=1;i<brands.length;i++)
{
  Brand b_obj=Brand.find(Integer.parseInt(brands[i]));
  if(b_obj.isExists())
  {
    out.println("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ><td>");
    out.println(b_obj.getName(teasession._nLanguage));
    out.println("<td><input type=submit name=delete onclick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){form1.brand.style.display='none';form1.brand.value="+b_obj.getBrand()+";}else return false;\" value="+r.getString(teasession._nLanguage,"CBDelete")+" >");
  }
}
%>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><%=r.getString(teasession._nLanguage,"Brand")%>:</td>
<td>
<select name="brand" onChange="fonchange();">
<option value="">-------------</option>
<%
java.util.Enumeration enumer=Brand.findByCommunity(community,"",0,Integer.MAX_VALUE);
while(enumer.hasMoreElements())
{
  int b_id=((Integer)enumer.nextElement()).intValue();
  Brand b_obj=Brand.find(b_id);
  out.print("<option value="+b_id);

  out.print(" >");
  out.print(b_obj.getName(teasession._nLanguage));
}
%>
</select>
</td>
</tr>
</table>
<input type="submit" name="submit" onClick="return submitText(form1.brand,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-<%=r.getString(teasession._nLanguage,"Brand")%>');" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>

