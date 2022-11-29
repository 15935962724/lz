<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r = new Resource();
r.add("/tea/ui/node/type/buy/EditBuyPrice");

String _strId=request.getParameter("id");


StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String supplier=request.getParameter("supplier");
if(supplier!=null&&supplier.length()>0)
{
	sql.append(" AND sb.supplier=").append(supplier);
	param.append("&supplier=").append(supplier);
}

String time_f=request.getParameter("time_f");
if(time_f!=null&&(time_f=time_f.trim()).length()>0)
{
	sql.append(" AND sb.time>").append(time_f);
	param.append("&time_f=").append(time_f);
}

String time_t=request.getParameter("time_t");
if(time_t!=null&&(time_t=time_t.trim()).length()>0)
{
	sql.append(" AND sb.time<").append(time_t);
	param.append("&time_t=").append(time_t);
}

String d_f=request.getParameter("d_f");
if(d_f!=null&&(d_f=d_f.trim()).length()>0)
{
	sql.append(" AND sb.discounts>").append(d_f);
	param.append("&d_f=").append(d_f);
}

String d_t=request.getParameter("d_t");
if(d_t!=null&&(d_t=d_t.trim()).length()>0)
{
	sql.append(" AND sb.discounts<").append(d_t);
	param.append("&d_t=").append(d_t);
}

%><html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function f_edit(v0,v1)
{
  form1.action="/jsp/type/brand/EditSupplierBrandDiscounts.jsp";
  if(v0==0)
  {
     form1.supplier.options[0]=new Option(form1.supplier.options[0].text,0);
  }
  form1.supplier.value=v0;
  form1.brand.value=v1;
  form1.nexturl.value=location;
  form1.submit();
}

function f_delete(v0,v1)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
	form1.action="/jsp/type/brand/EditSupplierBrandDiscounts.jsp";
	form1.method="POST";
	form1.supplier.value=v0;
	form1.brand.value=v1;
	form1.act.value="delete";
    form1.nexturl.value=location;
	form1.submit();
  }
}

function f_go()
{
return (form1.time_f.value==""||submitDate(form1.time_f,'日期格式错误.'))&&
(form1.time_t.value==""||submitDate(form1.time_t,'日期格式错误.'))&&
(form1.d_f.value==""||submitFloat(form1.d_f,'折扣格式错误.'))&&
(form1.d_t.value==""||submitFloat(form1.d_t,'折扣格式错误.'));
}
</script>
</head>
<body onLoad="form1.d_f.focus();" id="bodynone">
<h1><%=r.getString(teasession._nLanguage, "商品打折")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" >
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="id" value="<%=_strId%>">
<input type='hidden' name="brand">
<input type='hidden' name="act">
<input type='hidden' name="nexturl">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr><td>供应商</td>
    <td><select name="supplier" ><option value="" >------------</option>
        <%
        Enumeration e_s=Supplier.findByCommunity(teasession._strCommunity);
        while(e_s.hasMoreElements())
        {
          int id=((Integer)e_s.nextElement()).intValue();
          Supplier obj=Supplier.find(id);
          out.print("<option value="+id);
          if(String.valueOf(id).equals(supplier))
          out.print(" SELECTED ");
          out.print(" >"+obj.getName(teasession._nLanguage));
        }
        %>
        </select>
  </td>
    <td><%=r.getString(teasession._nLanguage, "开始日期")%><input name="time_f" value="<%if(time_f!=null)out.print(time_f);%>" size=10><a href="javascript:showCalendar('form1.time_f');"><img src=/tea/image/public/Calendar2.gif></a>
    <input name="time_t" value="<%if(time_t!=null)out.print(time_t);%>" size=10><a href="javascript:showCalendar('form1.time_t');"><img src=/tea/image/public/Calendar2.gif></a>
    </td>
    <td><%=r.getString(teasession._nLanguage, "折扣")%><input name=d_f size=6 value="<%if(d_f!=null)out.print(d_f);%>" onKeyPress="inputFloat();">-
    <input name=d_t size=6 value="<%if(d_t!=null)out.print(d_t);%>" onKeyPress="inputFloat();">
    </td>
    <td><input type="submit" value="<%=r.getString(teasession._nLanguage, "查询")%>" onClick="return f_go();"></td>
  </tr>
</table>
<br>

<h2>列表</h2>
<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter">
<tr id="tableonetr"><td width=1>&nbsp;</td><td>供应商</td><td>品牌</td><td>开始日期</td><td>截止日期</td><td>折扣</td><td>设置打折用户</td><td>&nbsp;</td></tr>
<%
Enumeration e=SupplierBrandDiscounts.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
 int id[]=(int[])e.nextElement();
 SupplierBrandDiscounts obj=SupplierBrandDiscounts.find(id[0],id[1]);

 Supplier s=Supplier.find(obj.getSupplier());
 Brand b=Brand.find(obj.getBrand());
 out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
 out.print("<td width=1>"+i);
 out.print("<td>"+s.getName(teasession._nLanguage));
 out.print("<td>"+b.getName(teasession._nLanguage));
 out.print("<td>"+obj.getStartTimeToString());
 out.print("<td>"+obj.getStopTimeToString());
 out.print("<td>"+obj.getDiscounts());
 out.print("<td>"+obj.getMember());
 out.print("<td><input type=button value=编辑 onclick=f_edit("+id[0]+","+id[1]+"); ><input type=button value=删除 onclick=f_delete("+id[0]+","+id[1]+"); >");
}
%>
</table>
<input type="button" value="新建" onClick="f_edit(0,0);" >
</form>

  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
