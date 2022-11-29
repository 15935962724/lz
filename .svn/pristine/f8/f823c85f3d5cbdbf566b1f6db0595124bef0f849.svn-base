<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.service.SendEmaily"%>
<%
TeaSession teasession = new TeaSession(request);
request.setCharacterEncoding("UTF-8");

String delid = teasession.getParameter("del");
if(delid!=null){
String delProfile = teasession.getParameter("delProfile");
Bperson.delMember(delProfile);

//1个月后 删除该供应商的图片
}

StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity).append("&id=").append(request.getParameter("id"));
StringBuffer sql = new StringBuffer(" and regstyle=0");

String member= request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" and email like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}

String name= request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" and email in (select member from profilelayer where firstname like "+DbAdapter.cite("%"+name+"%")+")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count=Bperson.count(sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/jquery.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/zoomi.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <title>供应商管理</title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  .lzj_001{border:1px solid #7F9DB9;background:#fff;height:23px;line-height:20px;*line-height:16px;padding-bottom:5px;*padding-bottom:0;}
  </style>
</HEAD>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;供应商管理</div>
  <h1>供应商管理</h1>
  <form action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
  <td width="82">会员ID</td><td widaawth="150"><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
  <td width="112">姓名</td><td width="150"><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/></td>
<td><input type="submit" value="查询"/></td>
  </tr>
  </table>
  </form>
  <h2>列表（<%=count%>）</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="3%" nowrap="nowrap">序号</td><td width="10%">会员ID</td><td width="7%">姓名</td><td colspan="5" align="center">操作</td><td></td>
    </tr>
    <%

    java.util.Enumeration  enumers = Bperson.findByCommunity(sql.toString(),pos,10);
    if(!enumers.hasMoreElements())
    {
      %>   <tr><td colspan="10">暂无信息</td>
      </tr>
      <%
      }
      int index = 1;

      while(enumers.hasMoreElements())
      {
        int ee=((Integer) enumers.nextElement()).intValue();
        Bperson b = Bperson.find(ee);
        String firstnames="";
        String ename="";
        if(Profile.isExisted(b.getMember()))
        {
          Profile pro = Profile.find(b.getMember());
          firstnames = pro.getFirstName(teasession._nLanguage);
          ename = pro.getLastName(teasession._nLanguage);
        }
        %>
        <tr>
          <td><%=pos+index%></td>
          <td nowrap="nowrap"><%if(b.getMember()!=null){out.print("<a href='/jsp/bpicture/BpProfile.jsp?member="+b.getMember()+"'>"+b.getMember()+"</a>");}%></td>
          <td nowrap="nowrap"><%=firstnames%></td>
          <td width="80" nowrap="nowrap"><a href="/servlet/Folder?node=2198224&bp_keywords=<%=java.net.URLEncoder.encode(b.getMember(),"utf-8")%>" target=top>查看图片</a></td>
          <td width="80" nowrap="nowrap"><a href="/jsp/bpicture/buyer/ChangeContact.jsp?member=<%=b.getMember()%>&forword=1">编辑基本资料</a></td>
          <td width="80" nowrap="nowrap"><a href="/jsp/bpicture/saler/ChangePayDetail.jsp?member=<%=b.getMember()%>&forword=1">编辑汇款信息</a></td>
          <td width="80" nowrap="nowrap"><a href="/jsp/bpicture/saler/Saler_Summary_sold.jsp?member=<%=b.getMember()%>&forword=1">销售额统计</a></td>
          <td width="80" nowrap="nowrap"><a href="#">历史结算信息</a></td>
          <td nowrap="nowrap"><a href="/jsp/bpicture/saler/SalerManagement.jsp?delProfile=<%=b.getMember()%>&del=1" onclick="if(confirm('确定删除该供应商？')){return ture;}else{return false;}">删除</a></td>
        </tr>
        <%
        index++;
      }
      %>
      <tr>
        <td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
        </td>
      </tr>
  </table>
</div>
</body>
</html>
