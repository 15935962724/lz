<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
   request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");


  StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer();//(" and d.member ="+DbAdapter.cite(teasession._rv.toString()));

//  int nameid = 0;
//  if(request.getParameter("nameid")!=null && request.getParameter("nameid").length()>0)
//  {
//    nameid = Integer.parseInt(request.getParameter("nameid"));
//  }
//  if(nameid!=0)
//  {
//    sql.append(" and d.node= ").append(" ").append(nameid);
//    param.append("nameid=").append(nameid);
//  }

String memberid = request.getParameter("memberid");
if(memberid!=null && memberid.length()>0)
{
  sql.append(" and d.member like ").append(" ").append(DbAdapter.cite("%"+memberid+"%"));
  param.append("&memberid=").append(memberid);
}

  String timek = request.getParameter("timek");
  if(timek!=null && (timek=timek.trim()).length()>0)
  {
    sql.append(" and d.destinedate>=").append(" ").append(DbAdapter.cite(timek));
    param.append("&destinedate=").append(timek);
  }
  String timej = request.getParameter("timej");
  if(timej!=null &&(timej=timej.trim()).length()>0)
  {
    sql.append(" and d.destinedate<").append(" ").append(DbAdapter.cite(timej));
    param.append("&destinedate=").append(timej);
  }

  int state =-1;
  if(request.getParameter("state")!=null && request.getParameter("state").length()>0)
  {
      state  = Integer.parseInt(request.getParameter("state"));
  }
  if(state!=-1)
  {
    sql.append(" and d.state=").append(state);
    param.append("&state=").append(state);
  }

  int count=Destine.countBy(teasession._strCommunity,sql.toString());
  int pos=0;
  int pageSize=10;
  if(teasession.getParameter("Pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("Pos"));
  }
 sql.append(" ORDER BY destinedate desc  ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">

<script type="">
function f_deal(igd)
   {
     form1.destine.value=igd;
     form1.action='/jsp/registration/orderdeal.jsp';
     form1.submit();
   }

   function yn()
{
  if(confirm("确认是否撤销？"))
  {
    return true;
  }
  else
  {
    return false;
  }
}
</script>
<div id="tablebgnone" class="register">
  <h1>订单查询</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="">
  <input type="hidden" name="destine" value="">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
   <td>会员ID:<input type="text" name="memberid" value="<%if(memberid!=null)out.print(memberid);%>" >
  <%--酒店名称：<select name="nameid">
    <option value="0">--------</option>
    <%
              java.util.Enumeration jde = Hostel.find("  and member="+DbAdapter.cite(teasession._rv.toString()),0,Integer.MAX_VALUE);
              for(int i =0;jde.hasMoreElements();i++)
              {
                int id = ((Integer)jde.nextElement()).intValue();
                Hostel h = Hostel.find(id);
                Node n = Node.find(h.getNode());
               if(!n.isHidden()){
                  out.print("<option value="+id);
                  if(nameid==id)
                      out.print("  selected");
                  out.print(">"+n.getSubject(teasession._nLanguage));
                  out.print("</option>");
                }

              }
    %>
</select>--%>
    订单时间：从
     <input name="timek" size="7"  value="<%if(timek!=null)out.print(timek);%>"><A href="###"><img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      到：
      <input name="timej" size="7"  value="<%if(timej!=null)out.print(timej);%>"><A href="###"><img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     订单状态：<select name="state">
     <option value="-1">-------</option>
     <%
     for(int i =0;i<Destine.STATE.length;i++){
         out.print("<option value="+i);
         if(state==i)
            out.print("  selected");
         out.print(">"+Destine.STATE[i]);
         out.print("</option>");
     }

     %>
     </select>
   <input type="submit" value=" GO " />
    </td>

  </tr>
  </table>
 <h2>订单列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr  id="tableonetr">
      <td nowrap>订单号</td>
      <td nowrap>酒店</td>
      <td nowrap>订单时间</td>
      <td nowrap>订单状态</td>
    <td align="center">操作</td>
    </tr>
    <%
       java.util.Enumeration e = Destine.findBy(teasession._strCommunity,sql.toString(),pos,pageSize);
       if(!e.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
       }
       while(e.hasMoreElements())
       {
         int id = ((Integer)e.nextElement()).intValue();
         Destine d = Destine.find(id);
         Node n = Node.find(d.getNode());
         Hostel h = Hostel.find(d.getNode(),teasession._nLanguage);
       %>
       <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap>
          <a href="/jsp/registration/DestineView.jsp?node=<%=n._nNode%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>"><%=id%></a>
         </td>
         <td>
           <a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=n.getSubject(teasession._nLanguage) %></a>
         </td>
         <td><%=d.getDestinedateToString() %></td>

        <td>
         <%=Destine.STATE[d.getState()]%>
         </td>
         <td>
         <%
           if(d.getState()==0)
           {
             out.print("<input type=button value=通知 onclick=\"f_deal('"+id+"');\">");%>
            &nbsp; <a href="/jsp/registration/editorder.jsp?destine=<%=id%>&language=<%=teasession._nLanguage%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>">修改订单</a>
      &nbsp;
      <a href="/jsp/registration/deletedestine.jsp?destine=<%=id%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>" onClick="return yn();">撤销订单</a>
          <% }else{out.print("&nbsp;");}
         %></td>

       </tr><%
       }if(count>pageSize){
       %>
       <tr>
         <td>&nbsp;</td>
         <td align="center" colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
       </tr><%} %>

  </table>

  </FORM>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
</html>

