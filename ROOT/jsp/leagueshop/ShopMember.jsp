<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%@page import="tea.entity.league.*" %>

<%@page import="tea.entity.util.*" %>
<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();
  StringBuffer sql = new StringBuffer(" AND agent >0 ");
  StringBuffer param = new StringBuffer();
  param.append("?id=").append(request.getParameter("id"));



  //所属区域
int s1=0,s2=0,csarea=0;
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append(" and agent in (select id from LeagueShop where province ="+s1+")");
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append(" and agent in (select id from LeagueShop where city ="+s2+")");
  param.append("&s2=").append(s2);
}
if(teasession.getParameter("csarea")!=null && teasession.getParameter("csarea").length()>0)
{
  csarea=Integer.parseInt(teasession.getParameter("csarea"));
  if(csarea==0)
  {

  }
  else
  {
    sql.append(" and agent in (select id from LeagueShop where csarea ="+csarea+")");
    param.append("&csarea=").append(csarea);
  }
}
//分店名称
String lsname=teasession.getParameter("lsname");
if(lsname!=null&& lsname.length()>0)
{
  sql.append(" and agent in (select id from LeagueShop where  lsname like "+DbAdapter.cite("%"+lsname+"%")+")");
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
//分店类型
int lstype =0;
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype = Integer.parseInt(teasession.getParameter("lstype"));
  if(lstype>0)
  {
     sql.append(" and agent in (select id from LeagueShop where lstype =  "+lstype+")");
    param.append("&lstype=").append(lstype);
  }
}
//会员卡号
String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" and member like "+DbAdapter.cite("%"+member+"%")+" ");
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}
//会员姓名
String lfname = teasession.getParameter("lfname");
if(lfname!=null && lfname.length()>0)
{
  lfname = lfname.trim();
  sql.append(" and member in (select member from Profilelayer where firstname like "+DbAdapter.cite("%"+lfname+"%")+" or  lastname like "+DbAdapter.cite("%"+lfname+"%")+") ");
  param.append("&lfname=").append(java.net.URLEncoder.encode(lfname,"UTF-8"));
}
//入会时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Profile.count(teasession._strCommunity,sql.toString());
sql.append(" order by time desc");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>分店会员信息</title>
</head>
<body id="bodynone">
<script type="">
   function f_excel()
    {
      form1.action='/servlet/ExportExcel';
      form1.submit();
    }
</script>
  <h1>分店会员信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
   <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="分店会员信息表">
  <input type="hidden" name="act" value="ShopMember">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>所属区域:</td>

      <td>
       <script src="/tea/card.js" type=""></script>
        <script type="text/javascript">
        var delcct=new Array();
        function f_area(objcct)
        {
          var rscct=area[parseInt(objcct.value)][1];
          var op=form1.s1.options;
          for(var i=0;i<delcct.length;i++)
          {
            op[op.length]=new Option(delcct[i][0],delcct[i][1]);
          }
          delcct=new Array();
          for(var i=0;i<op.length;i++)
          {
            if(rscct.indexOf(op[i].value)==-1)
            {
              delcct[delcct.length]=new Array(op[i].text,op[i].value);
              op[i--]=null;
            }
          }
        }
        document.write("<select name='csarea' onchange=f_area(this)>");
        for(var i=0;i<area.length;i++)
        {
          document.write("<option value="+i+">"+area[i][0]+"</option>");
        }

        document.write("</select>　");
        selectcard("s1","s2",null,"<%=s2%>");
        if(<%=s1%>>0)
        {
          form1.s1.value='<%=s1%>';
        }
        form1.csarea.value="<%=csarea%>";
        form1.csarea.onchange();
        </script>
        </td>

        <td>分店名称:</td>
        <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>

        <td>分店类型:</td>
        <td><select  name="lstype" >
          <option  value="0">请选择分店类别</option>
          <%
          java.util.Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
          for(int i=0;eu.hasMoreElements();i++)
          {
            int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
            LeagueShopType objty = LeagueShopType.find(idtt);
            out.print("<option value="+idtt);
            if(lstype==idtt)
            {
              out.print(" selected ");
            }
            out.print(">"+objty.getLstypename()+"</option>");
          }
          %>
          </select>　
        </td>

  </tr>
  <tr>
    <td>会员卡号:</td>
    <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
    <td>会员姓名:</td>
    <td><input type="text" name="lfname" value="<%if(lfname!=null)out.print(lfname);%>"/> </td>
    <td>入会日期:</td>
     <td>
     从&nbsp;
        <input id="time_c" name="time_c" size="7" readonly="readonly"  value="<%if(time_c!=null)out.print(time_c);%>">
          <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7" readonly="readonly"  value="<%if(time_d!=null)out.print(time_d);%>">
         <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

     </td>

<td><input type="submit" value="查询"/></td>
  </tr>

</table>

<h2><%
Card card11 = Card.find(s1);
Card card22 = Card.find(s2);
if(csarea>0)
{
  out.print("所在区域：&nbsp;");
  out.print(LeagueShop.CSAREA[csarea]+"&nbsp;");
}
if(s1>0)
{
  out.print(card11.getAddress()+"&nbsp;");
}
if(s2>0)
{
  out.print(card22.getAddress()+"&nbsp;&nbsp;");
}
if(lstype>0)
{
  out.print("分店类型：&nbsp;");
  LeagueShopType objty = LeagueShopType.find(lstype);
  if(objty.getLstypename()!=null)
  {
    out.print(objty.getLstypename()+"&nbsp;&nbsp;");
  }
}
if(lsname!=null && lsname.length()>0)
{
  out.print("分店名称：&nbsp;");
  out.print(lsname+"&nbsp;&nbsp;");
}
if(member!=null && member.length()>0)
{
  out.print("会员卡号：&nbsp;");
  out.print(member+"&nbsp;&nbsp;");
}
if(lfname!=null && lfname.length()>0)
{
  out.print("会员名称：&nbsp;");
  out.print(lfname+"&nbsp;&nbsp;");
}
if(time_c!=null)
{
  out.print("入会时间:&nbsp;");
  out.print("从&nbsp;"+time_c);

}
if(time_d!=null)
{
  out.print("到&nbsp;"+time_d);
}


  %>
（列表数量为：&nbsp;<%=count%>&nbsp; ）显示列表如下：</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
     <td nowrap>会员卡号</td>
      <td nowrap>会员名称</td>
      <td nowrap>性别</td>
      <td nowrap>分店名称</td>
      <td nowrap>手机号码</td>
      <td nowrap>入会日期</td>
      <td nowrap>积分</td>
      <td nowrap>余额</td>
       <td nowrap>状态</td>
      <td nowrap>操作</td>
    </tr>
    <%//AND agent=1

    java.util.Enumeration e = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    while(e.hasMoreElements())
    {
      String memberid = ((String)e.nextElement());
      Profile pobj = Profile.find(memberid);
      LeagueShop lsobj =LeagueShop.find(pobj.getAgent());
      ICard icard=ICard.find(memberid);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=memberid %></td>
      <td><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)%></td>
      <td align="center"><%if(pobj.isSex()){out.print("男");}else{out.print("女");}%></td>
      
      <td><%=lsobj.getLsname() %></td>
      <td><%=pobj.getMobile() %></td>
      <td align="center"><%=pobj.getTimeToString()%></td>
       <td><%=icard.getLjjf() %></td>
        <td><%=icard.getMoney() %></td>
         <td><%= ICard.STATE_TYPE[icard.getState()] %></td>
      <td>
        <input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/ShopMemberShow.jsp?memberid=<%=memberid%>&nexturl=<%=nexturl%>','_self');"/>&nbsp;
        <input type="button" value="查看消费统计" onclick="window.open('/jsp/leagueshop/ShopMemberConsume.jsp?memberid=<%=memberid%>&nexturl=<%=nexturl%>','_self');"/>
      </td>
    </tr>
    <%}%>
     <%
     if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
  <br>
<input type="button" value="导出Excel表" onclick="f_excel();">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
