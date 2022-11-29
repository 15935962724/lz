<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.admin.*" %>
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
StringBuffer sql = new StringBuffer();

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
  <title>会员管理</title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  .lzj_001{border:1px solid #7F9DB9;background:#fff;height:23px;line-height:20px;*line-height:16px;padding-bottom:5px;*padding-bottom:0;}
  </style>
</HEAD>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;会员管理</div>
  <h1>会员管理</h1>
  <form action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
  <td width="70">会员ID</td><td width="150"><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
  <td width="70">姓名</td><td width="150"><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/></td>

<td><input type="submit" value="查询"/></td>
  </tr>
  </table>
  </form>
  <h2>列表（<%=count%>）</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="3%" nowrap="nowrap">序号</td><td width="15%" nowrap="nowrap">会员ID</td><td width="10%" nowrap="nowrap">姓名</td><td width="10%" nowrap="nowrap">身份</td><td colspan="3">操作</td>
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
        AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,b.getMember());
        String role = aur.getRole();
        String rs[]=role.split("/");
        if(Profile.isExisted(b.getMember()))
        {
          Profile pro =Profile.find(b.getMember());
          firstnames = pro.getFirstName(teasession._nLanguage);
          ename = pro.getLastName(teasession._nLanguage);
        }
        %>
        <tr>
          <td><%=pos+index%></td>
          <td nowrap="nowrap"><%if(b.getMember()!=null){out.print("<a href='/jsp/bpicture/BpProfile.jsp?member="+b.getMember()+"'>"+b.getMember()+"</a>");}%></td>
          <td nowrap="nowrap"><%=firstnames%></td>
          <td nowrap="nowrap"><%=rs.length>1?AdminRole.find(Integer.parseInt(rs[1])).getName():"买家"%></td>
          <td width="80" nowrap="nowrap"><a href="/jsp/bpicture/buyer/ChangeContact.jsp?member=<%=b.getMember()%>&forword=1">编辑基本资料</a></td>
          <td nowrap="nowrap"><a href="/jsp/bpicture/saler/SalerManagement.jsp?delProfile=<%=b.getMember()%>&del=1" onclick="if(confirm('确定删除该会员？')){return ture;}else{return false;}">删除</a></td>
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
<script type="">
function zoom(obj)
{
  $('#'+obj+'').zoomi();
}
</script>
</body>
</html>
