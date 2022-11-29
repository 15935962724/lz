<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("delete")!=null)
{
  int itemoutlay=Integer.parseInt(request.getParameter("itemoutlay"));
  Itemoutlay obj=Itemoutlay.find(itemoutlay);
  obj.delete();
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+request.getParameter("nexturl"));
  return;
}
String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();

String code=(request.getParameter("code"));
if(code!=null&&code.length()>0)
{
  sql.append(" AND i.code LIKE "+DbAdapter.cite("%"+code+"%"));
  param.append("&code="+java.net.URLEncoder.encode(code,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND i.item IN (SELECT item FROM ItemLayer WHERE name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%")+")");
  param.append("&name="+java.net.URLEncoder.encode(name,"UTF-8"));
}

String outlay=(request.getParameter("outlay"));
if(outlay!=null&&outlay.length()>0)
{
  sql.append(" AND o.outlay="+outlay);
  param.append("&outlay="+java.net.URLEncoder.encode(outlay,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="io.poyear";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);

String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>经费划拨</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>项目计划号
         <input name="code" ></td>
       <td>项目名称
         <input name="name"></td>
         <td>经费类别<select name="outlay">
           <option value="">-----------------</option>
           <%/*
           for(int index=0;index<Item.ITEM_TYPE.length;index++)
           {
            out.print("<option value="+index);
            //if(index==type)
            //out.println(" SELECTED ");
            out.println(" >"+Item.ITEM_TYPE[index]);
           }*/
           java.util.Enumeration enumer2= Outlay.find(community,"",0,Integer.MAX_VALUE);
           while(enumer2.hasMoreElements())
           {
             int id=((Integer)enumer2.nextElement()).intValue();
             Outlay outlay_obj=Outlay.find(id);
             out.print("<option value="+id);
             if(String.valueOf(id).equals(outlay))
             {
               out.print(" SELECTED ");
             }
             out.println(" >"+outlay_obj.getType());
           }
           %></select></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>

<%
out.print("<h2>列表</h2>");
out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter> ");
java.util.Enumeration enumer=Itemoutlay.find(community,sql.toString(),0,Integer.MAX_VALUE);
if(!enumer.hasMoreElements())
{
  out.print("<tr><td><h3 style=\"color:red\">无记录.</h3></td></tr>");
}else
{
out.print("<tr id=tableonetr >");
out.print("<td nowrap>计划号</td>");
out.print("<TD nowrap>项目名称</TD>");
out.print("<TD nowrap>编制单位</TD>");
out.print("<TD nowrap>");
if("io.outlay".equals(order))
{
  out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >本经费来源 "+("desc".equals(desc)?"▼":"▲")+"</a>");
}else
{
  out.print("<A href="+request.getRequestURI()+"?order=io.outlay&"+param.toString()+" >本经费来源</a>");
}
out.print("</TD><TD nowrap>");
if("io.money".equals(order))
{
  out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >拨付经费 "+("desc".equals(desc)?"▼":"▲")+"</a>");
}else
{
  out.print("<A href="+request.getRequestURI()+"?order=io.money&"+param.toString()+" >拨付经费</a>");
}
out.print("</TD><TD nowrap>");
if("io.poyear".equals(order))
{
  out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >拨付年度 "+("desc".equals(desc)?"▼":"▲")+"</a>");
}else
{
  out.print("<A href="+request.getRequestURI()+"?order=io.poyear&"+param.toString()+" >拨付年度</a>");
}
out.print("</TD><TD nowrap>");
if("io.time".equals(order))
{
  out.print("<A href="+request.getRequestURI()+"?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >拨付日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
}else
{
  out.print("<A href="+request.getRequestURI()+"?order=io.time&"+param.toString()+" >拨付日期</a>");
}
out.print("</TD><TD></TD></tr>");

java.math.BigDecimal total = new java.math.BigDecimal("0.00");
for(int index=1;enumer.hasMoreElements();index++)
{
  int itemoutlay=((Integer)enumer.nextElement()).intValue();
  Itemoutlay obj=Itemoutlay.find(itemoutlay);

  Item item=Item.find(obj.getItem());
  Outlay outlay_obj=Outlay.find(obj.getOutlay());

  Itemmember im_obj=Itemmember.find(item.getSupermanager(),community);
  String au_name=tea.entity.admin.AdminUnit.find(im_obj.getOldunit()).getName();//item.getEditgroup()
  if(au_name==null)au_name="";

  total=total.add(obj.getMoney());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=item.getCode()%></td>
    <td nowrap><%=item.getName()%></td>
    <td><%=au_name%></td>
    <td><%=outlay_obj.getType()%></td>
    <td><%=obj.getMoney()%></td>
    <td><%=obj.getPoyear()%></td>
    <td nowrap><%=obj.getTimeToString()%>&nbsp;</td>
    <td>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.location='/jsp/criterion/EditItemoutlay.jsp?itemoutlay=<%=itemoutlay%>&community=<%=community%>&nexturl=<%=nexturl%>';"/>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='<%=request.getRequestURI()%>?itemoutlay=<%=itemoutlay%>&community=<%=community%>&delete=ON&nexturl=<%=nexturl%>';}"/>
    </td>
  </tr>
  <%
}
out.print("<tr><td colspan=5>总计:"+total+"</td></tr>");

out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBExport")+" onClick=\"window.open('/jsp/criterion/Export.jsp?act=Itemoutlays.jsp&community="+community+"&sql="+java.net.URLEncoder.encode(sql.toString(),"UTF-8")+"&name='+encodeURI('经费划拨'),'_self');\">");
}
out.print("</table>");
%>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.location='/jsp/criterion/EditItemoutlay.jsp?itemoutlay=0&community=<%=community%>&nexturl=<%=nexturl%>';"/>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

