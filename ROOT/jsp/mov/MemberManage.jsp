<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer param=new StringBuffer("community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();

if("sh".equals(teasession.getParameter("act")))
{
  MemberOrder morobj = MemberOrder.find(teasession.getParameter("memberorder"));
  morobj.setVerifg(0);
}

int id = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  id = Integer.parseInt(teasession.getParameter("id"));
}
param.append("&id=").append(id);



String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
  member = member.trim();
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}

int membertypes =0;
if(teasession.getParameter("membertypes")!=null && teasession.getParameter("membertypes").length()>0)
{
  membertypes = Integer.parseInt(teasession.getParameter("membertypes"));
}
if(membertypes>0)
{
   sql.append(" AND membertype = ").append(membertypes);
   param.append("&membertypeid=").append(membertypes);
}

String time_k = teasession.getParameter("time_k");
if(time_k!=null && time_k.length()>0)
{
  sql.append(" AND member in (select member from Profile where time>="+DbAdapter.cite(time_k)+") ");
  param.append("&time_k=").append(time_k);
}
String time_j = teasession.getParameter("time_j");
if(time_j!=null && time_j.length()>0)
{
  sql.append(" AND member in (select member from Profile where time<="+DbAdapter.cite(time_j)+") ");
  param.append("&time_j=").append(time_j);
}

int verifg =-1;
if(teasession.getParameter("verifg")!=null && teasession.getParameter("verifg").length()>0)
{
  verifg = Integer.parseInt(teasession.getParameter("verifg"));
}
if(verifg!=-1)
{
  sql.append(" AND verifg =").append(verifg);
  param.append("&verifg=").append(verifg);
}

int servicetype =-1;
if(teasession.getParameter("servicetype")!=null && teasession.getParameter("servicetype").length()>0)
{
  servicetype = Integer.parseInt(teasession.getParameter("servicetype"));
}
if(servicetype!=-1)
{
  sql.append(" AND verifg=1 AND  servicetype =").append(servicetype);
  param.append("&servicetype=").append(servicetype);
}
sql.append(" AND member != ").append(DbAdapter.cite("webmaster"));
int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



int count=MemberOrder.count(teasession._strCommunity,sql.toString());


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body bgcolor="#ffffff">
<script type="text/javascript">
   function f_delete(igd)
   {
     if(confirm('确实要彻底删除吗？')){
       form1.memberorder.value=igd;
       form1.act.value='delete';
       form1.action='/jsp/mov/MemberDecide.jsp';
       form1.submit();
     }
   }
   function f_Servicetype(igd,sgd)
   {
     form1.memberorder.value=igd;
     form1.servicetype.value=sgd;
     form1.act.value='servicetype';
     form1.action='/jsp/mov/MemberDecide.jsp';
     form1.submit();
   }
   function f_sh(igd,id)
   {
         form1.memberorder.value=igd;
         form1.id.value=id;
         form1.act.value ='sh';
         form1.action ='/jsp/mov/MemberManage.jsp';
         form1.submit();
   }
</script>
<h1>会员审核管理</h1>
<h2>会员审核查询</h2>
<form action="?" name="form2" method="POST">
<input TYPE="hidden" name="id" value="<%=id%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr >
    <td>用户名：&nbsp;&nbsp;<input type="text" name="member" value="<%if(member!=null)out.print(member);%>" /></td>
    <td>会员类型：&nbsp;&nbsp;<select name="membertypes">
    <option value="0">------------</option>
    <%
       java.util.Enumeration ey = MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);

       while(ey.hasMoreElements())
       {
         int membertypeid =((Integer)ey.nextElement()).intValue();
         MemberType mty =MemberType.find(membertypeid);
         out.print("<option value="+membertypeid);
         if(membertypes==membertypeid)
            out.print(" selected");
         out.print(">"+mty.getMembername());
         out.print("</option>");
       }
    %>
    </select>
    </td>
    <td>注册时间：&nbsp;&nbsp;
       从&nbsp;
        <input id="time_c" name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"  style="cursor:pointer"  readonly="readonly"  onclick="new Calendar().show('form2.time_k');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form2.time_k');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"  style="cursor:pointer"  readonly="readonly" onclick="new Calendar().show('form2.time_j');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form2.time_j');" />    
    </td>
    </tr>
    <tr >
      <td>审核状态：&nbsp;&nbsp;
        <select name="verifg">
          <option value="">---------</option>
          <option value="0" <%if(verifg==0)out.print(" selected");%> >暂没有审核</option>
          <option value="1" <%if(verifg==1)out.print(" selected");%> >审核通过</option>
          <option value="2" <%if(verifg==2)out.print(" selected");%> >审核没有通过</option>
          <option value="3" <%if(verifg==3)out.print(" selected");%> >不需要审核</option>
        </select>
      </td>
    <td>服务状态：&nbsp;&nbsp;
      <select name="servicetype">
        <option value="">-------</option>
        <option value="0" <%if(servicetype==0)out.print(" selected");%> >启动的服务</option>
        <option value="1" <%if(servicetype==1 )out.print(" selected");%>>暂停的服务</option>
      </select>
    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>
 <h2>会员审核列表&nbsp;(&nbsp;目前会员共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位&nbsp;)&nbsp;</h2>
<form action="?" name="form1" >
<input type="hidden" name="memberorder"/>
<input type="hidden" name="servicetype"/>
<input type="hidden" name="act" value=""/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr">

 <td nowrap>序号</td>
   <td>用户名</td>
   <td>申请会员类型</td>
   <td>会员角色</td>
   <td>注册时间</td>
   <td>审核状态</td>
   <td>操作</td>
  </tr>
  <%

    java.util.Enumeration e = MemberOrder.find(teasession._strCommunity,sql.toString(),pos,size);
      if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
   String url = null;

    for(int i =1;e.hasMoreElements();i++)
    {
      String memberorder =((String)e.nextElement());
      String ro [] =null;
      StringBuffer sp = new StringBuffer();
      MemberOrder  moobj = MemberOrder.find(memberorder);
      MemberType mtobj = MemberType.find(moobj.getMembertype());
      Profile p = Profile.find(moobj.getMember());
      RegisterInstall riobj = RegisterInstall.find(moobj.getMembertype());

      if(moobj.getRole()!=null && moobj.getRole().length()>0)
      {
        ro = moobj.getRole().split("/");
        for(int j=1;j<ro.length;j++)
        {

          sp.append(AdminRole.find(Integer.parseInt(ro[j])).getName()).append(",");
        }
      }
  %>

<tr>
   <td><%=i %></td>
   <td><%=moobj.getMember() %></td>
   <td><%=teasession.isNULL(mtobj.getMembername())%></td>
 <td><%=sp.toString() %></td>
   <td><%=moobj.getTimesToString()%></td>
    <td><%if(moobj.getVerifg()==0)out.print("暂没有审核");else if(moobj.getVerifg()==1)out.print("审核通过"); else if(moobj.getVerifg()==2)out.print("审核没有通过"); else if(moobj.getVerifg()==3)out.print("不需要审核"); %></td>
   <td>
   <%
   //如果有关联信息则显示

       if(riobj.getPayment()==0){
          url = "MemberDecide2.jsp";
       }else
       {
         url = "MemberDecide.jsp";
       }
   %>
   <%if(moobj.getVerifg()!=0){%>
     <input type="button" id="button1"  value="恢复审核" onclick="f_sh('<%=memberorder%>','<%=id%>');" >&nbsp;
   <%} else{%>
     <input type="button" id="button1"  value="审核" onclick="window.open('/jsp/mov/<%=url%>?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>&memberorder=<%=memberorder%>','_self');" >&nbsp;
    <%} %>
     <input type="button" value="<%if(moobj.getVerifg()==1 && moobj.getServicetype()==0)out.print("暂停服务");else if(moobj.getVerifg()==1 && moobj.getServicetype()==1)out.print("启动服务");else out.print("暂无功能");%>" <%if(moobj.getVerifg()!=1)out.print("disabled=\"disabled\"  style=\"background:#666666\"");%> onclick="f_Servicetype('<%=memberorder%>','<%=moobj.getServicetype()%>');">&nbsp;
     <input type="button" value="彻底删除" onclick="f_delete('<%=memberorder%>');"/>
   </td>
 </tr>

<%}if(count>size){ %>
<tr>
  <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
</tr>
<%} %>


</table>

</form>

</body>
</html>
