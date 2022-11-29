<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>

<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
String nexturl = request.getRequestURI()+"?type="+type+request.getContextPath();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&type=").append(type);

if(type==1)//显示审核
{
  sql.append(" AND type = 1");
}else if(type==2)//显示库房备货
{
  sql.append(" AND type = 2 ");
}else if(type==3)//显示库房发货
{
  sql.append(" AND type =3 ");
}else if(type==4)
{
  sql.append(" AND type = 4 ");
}
//查询赠送日期
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time_s >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time_s <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
//赠送单号
String dibidsssd = teasession.getParameter("dibidsssd");
if(dibidsssd!=null && dibidsssd.length()>0)
{
  sql.append(" AND dibid LIKE '%"+dibidsssd+"%' ");
  param.append("&dibidsssd=").append(dibidsssd);
}
//加盟店名称
String lsname = teasession.getParameter("lsname");
if(lsname!=null && lsname.length()>0)
{
  sql.append(" AND lsid IN (SELECT  id FROM LeagueShop WHERE lsname LIKE "+DbAdapter.cite("%"+lsname+"%")+") ");
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}

int waridname = 0;
if(teasession.getParameter("waridname")!=null && teasession.getParameter("waridname").length()>0)
{
  waridname = Integer.parseInt(teasession.getParameter("waridname"));
  if(waridname>0)
  {
    sql.append(" AND warid =").append(waridname);
    param.append("&waridname=").append(waridname);
  }
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Complimentary.count(teasession._strCommunity,sql.toString());

sql.append(" order by time_s desc ");


%>
<html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

<body>
<script>
function f_show(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:457px;dialogHeight:235px;';
  var url = '/jsp/erp/PurchaseShow.jsp?warid='+igd+'&act=cangku'
  window.showModalDialog(url,self,y);
}
function f_edit(igd)
{
  form1.dibid.value= igd;
  form1.action = "/jsp/erp/EditComplimentary.jsp";
  form1.submit();
}
function f_delete(igd)
{
  if(confirm('您确定要删除此内容吗？')){
    form1.purchase.value= igd;

    form1.act.value= 'delete';
    form1.action = "/servlet/EditComplimentary";
    form1.submit();
  }
}
//库房备货
function f_edit2(igd)
{
  form1.dibid.value= igd;
  form1.action = "/jsp/erp/ComDisButprepara.jsp";
  form1.submit();
}
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';
  var url = '/jsp/erp/ComplimentaryShow.jsp?dibid='+igd;
  window.showModalDialog(url,self,y);
}
</script>
<h1><%
if(type==1)
{out.print("审核赠送单");}
else if(type==0){out.print("添加赠送单");}
else if(type==2){out.print("赠送单库房备货");}
else if(type==3){out.print("赠送单库房发货");}
else if(type==4){out.print("赠送单完成发货");}
%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="?" method="POST">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="dibid">
<input type="hidden" name="purchase">
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="act" >
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>赠送日期:

        从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
      </td>

      <td>赠送单号:&nbsp;<input type="text" name="dibidsssd" value="<%if(dibidsssd!=null)out.print(dibidsssd);%>"/></td>
      </tr>
      <tr>
        <td>加盟店名称:&nbsp;<input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
        <td>赠送仓库:<select name="waridname">
          <option value="0">请选择仓库</option>
          <%
          java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          while (e2.hasMoreElements())
          {
            int warid = ((Integer)e2.nextElement()).intValue();
            Warehouse warobj = Warehouse.find(warid);
            out.print("<option value= "+warid);
            if(waridname==warid)
            {
              out.print(" selected");
            }
            out.print(">"+warobj.getWarname());
            out.print("</option>");
          }

          %>
          </select> </td>

          <td><input type="submit" value="查询"/></td>
    </tr>
  </table>
<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>赠送单号</td>
    <td nowrap>赠送日期</td>
    <td nowrap>赠送加盟店</td>
    <td nowrap>赠送仓库 </td>
    <td nowrap>赠送数量</td>
    <%
    if(type==0)
    {
      out.print(" <td nowrap>审核状态</td>");
    }
    %>
    <td nowrap>操作</td>
  </tr>
<%
java.util.Enumeration e = Complimentary.find(teasession._strCommunity,sql.toString(),pos,pageSize);
   if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }

while(e.hasMoreElements()){
  String dibids = ((String)e.nextElement());
  Complimentary diobj =Complimentary.find(dibids);
    LeagueShop lsobj = LeagueShop.find(diobj.getLsid());
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><a href="#" onclick="f_c('<%=dibids%>');"><%=dibids%></a></td>
    <td align="center"><%=diobj.getTime_sToString() %></td>
    <td ><%=lsobj.getLsname()%></td>
    <td><a href="#" onclick="f_show('<%=diobj.getWarid()%>');"><%=Warehouse.find(diobj.getWarid()).getWarname() %></a></td>
    <td align="center"><%=diobj.getQuantity() %></td>
       <%
    if(type==0)
    {
      out.print(" <td >");
      if(diobj.getType()==1)
      {
        out.print("等待审核赠送单");
      }else if(diobj.getType()==2)
      {
        out.print("赠送单审核通过,等待库房备货");
      }else if(diobj.getType()==3)
      {
        out.print("赠送单等待库房发货");
      }else if(diobj.getType()==4)
      {
        out.print("赠送单完成库房发货");
      }

      out.print("</td>");
    }
    %>
    <td>
    <%
    if(type==1)
    {
      out.print("<a href=\"#\" onclick=\"f_edit('"+dibids+"');\">审核赠送单</a>&nbsp; ");
    }else if(type==0)
    {
       if(diobj.getType()==2||diobj.getType()==3||diobj.getType()==4)
      {
        out.print("<input type=button disabled=disabled style=background:#666666 value=编辑>&nbsp;<input type=button disabled=disabled style=background:#666666 value=删除>");
      }
      else if(diobj.getType()==1)
      {
        out.print("<a href=\"#\" onclick=f_edit('"+dibids+"');>编辑</a>&nbsp;<a href=\"#\" onclick=f_delete('"+dibids+"');>删除</a>");
      }
     // out.print(" <a href=\"#\" onclick=\"f_edit('"+dibids+"');\">编辑</a>&nbsp;<a href=\"#\" onclick=\"f_delete('"+dibids+"');\">删除</a> ");
    }else if(type==2)//库房备货
    {
       out.print("<a href=\"#\" onclick=\"f_edit2('"+dibids+"');\">库房备货</a>&nbsp; ");
    }else if(type==3)
    {
        out.print("<a href=\"#\" onclick=\"f_edit2('"+dibids+"');\">库房发货</a>&nbsp; ");
    }else if(type==4)
    {
        out.print("<a href=\"#\" onclick=\"f_edit2('"+dibids+"');\">查看发货信息</a>&nbsp; ");
    }
    %>

    </td>
  </tr>
<%} %>

  <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
</table>
<br />
<%if(type==0){ %>
<input type="button" value="添加赠送单" onclick="window.open('/jsp/erp/EditComplimentary.jsp?nexturl=<%=nexturl%>','_self');"/>
<%} %>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>
