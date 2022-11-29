<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.db.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int filecenter = Integer.parseInt(teasession.getParameter("bullid"));
FileCenter obj=FileCenter.find(filecenter);
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
String role = aur.getRole() ;
String rs[]=role.split("/");
//(rs.length>1?AdminRole.find(Integer.parseInt(rs[1])).getName():"注册会员");
%>
<html>
<head>
<title>
FileYNread
</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">
<h1>察看阅读情况</h1>
<table align="center" id="tablecenter" border="0" cellpadding="0" cellspacing="0">
  <tr>

    <td width="20%" align="center" colspan="2"><b>范围</b></td>

    <td align="center" width="40%"><b>已阅</b></td>
    <td align="center" width="40%"><b>未阅</b></td>
  </tr>
  <%
  Enumeration e=FileCenterSafety.findByFileCenter(filecenter,"");
  for(int j=1;e.hasMoreElements();j++)
  {
    int id=((Integer)e.nextElement()).intValue();
    FileCenterSafety s=FileCenterSafety.find(id);
    if(s.getPurview(obj.getPath())==1 ||s.getPurview(obj.getPath())==2){
      %>
      <tr>
        <td align="center" width="5%" bgcolor=#F5F5F5><b>角色</b></td>
        <%
        out.print("<td>");
        String[] role1 = s.getRole().split("/");
        int cc = 1, dd = 1;
        for(int i = 1; i < role1.length; i++){
          out.print(Bulletin.findRole(role1[i]) + " ");
        }
        out.print("　</td><td>");
        for(int i = 1; i < role1.length; i++){
          Enumeration roleName = Bulletin.findRoleName1(role1[i]);
          while(roleName.hasMoreElements()){
             String rrname = (String)roleName.nextElement();
             Profile p = Profile.find(rrname);
          if(Bulletin.showYreadPer(rrname,filecenter)){
            if(cc%2 == 0){
              out.print(p.getName(teasession._nLanguage)+Bulletin.readDate(rrname, filecenter)+"<br/>");
            }else{
              out.print(p.getName(teasession._nLanguage)+Bulletin.readDate(rrname, filecenter)+"　");
            }
            cc++;

          }
          }
        }
        if(cc == 1){
          out.print("　");
        }
        out.print("</td><td>");
        for(int i = 1; i < role1.length; i++){
          Enumeration rname = Bulletin.findRoleName1(role1[i]);
          while(rname.hasMoreElements()){
            String rrname = (String)rname.nextElement();
            Profile p = Profile.find(rrname);
            if(Bulletin.showNreadPer(rrname,filecenter)){
              if(dd%7 == 0){
                out.print(p.getName(teasession._nLanguage)+"<br/>");
              }else{
                out.print(p.getName(teasession._nLanguage)+"　");
              }
              dd++;
            }
          }
        }
        if(dd == 1){
          out.print("　");
        }
        out.print("</td>");
        %>
        </tr>
        <tr>
          <td align="center" bgcolor=#F5F5F5><b>会员</b></td>
          <td>　</td>

          <%
          String[] member = s.getMember().split("/");
          int aa=1,bb=1;
          out.print("<td>");
          for(int i = 1; i < member.length;i++){
            Profile p = Profile.find(member[i]);
            if(Bulletin.showYreadPer(member[i],filecenter)){
              if(bb%2 == 0){
                out.print(p.getName(teasession._nLanguage)+Bulletin.readDate(member[i], filecenter)+"<br/>");
              }else{
                out.print(p.getName(teasession._nLanguage)+Bulletin.readDate(member[i], filecenter)+"　");
              }
              bb++;
            }
          }
          if(aa == 1){
            out.print("　");
          }
          out.print("　</td><td>");

          for(int i = 1; i < member.length;i++){
              Profile p = Profile.find(member[i]);
            if(Bulletin.showNreadPer(member[i],filecenter)){
              if(aa%7 == 0){
                out.print(p.getName(teasession._nLanguage)+"<br/>");
              }else{
                out.print(p.getName(teasession._nLanguage)+"　");
              }
              aa++;
            }
          }
          if(aa == 1){
            out.print("　");
          }
          out.print("</td></tr>");

          String[] unit = s.getUnit().split("/");
          out.print("<tr ><td align=center rowspan="+(unit.length-1)+" valign=middle bgcolor=#F5F5F5><b>部门</b></td>");
          for(int i = 1; i < unit.length; i++)
          {
            Enumeration enumer =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(unit[i]),true);
            AdminUnit au=  AdminUnit.find(Integer.parseInt(unit[i]));
            if(!enumer.hasMoreElements())
            {
              out.print("<td colspan=3 align=left bgcolor=#F5F5F5>"+au.getName()+"</td></tr>");
            }else
            {
              //        out.print("<tr><td colspan=3 bgcolor=#F5F5F5>"+Bulletin.unitName(Integer.parseInt(unit[i]))+"</td></tr>");
              out.print("<td>"+au.getName()+"</td><td>");

              int p = 1;
              while(enumer.hasMoreElements())
              {
                String _member = (String)enumer.nextElement();
                Profile p1 = Profile.find(_member);
                if(Bulletin.showYreadPer(_member,filecenter))
                {
                  if(p%2 == 0)
                  {
                    out.print(p1.getName(teasession._nLanguage)+Bulletin.readDate(_member, filecenter)+"<br/>");
                  }else
                  {
                    out.print(p1.getName(teasession._nLanguage)+Bulletin.readDate(_member, filecenter)+"　");
                  }
                  p++;
                }
              }
              if(p == 1){
                out.print("　");
              }
              out.print("</td><td>"); Enumeration enumer1 =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(unit[i]),true);
              int q = 1;
              while(enumer1.hasMoreElements())
              {
                String _member = (String)enumer1.nextElement();
                Profile p1 = Profile.find(_member);
                if(Bulletin.showNreadPer(_member,filecenter)){
                  if(q%7 == 0){
                    out.print(p1.getName(teasession._nLanguage)+"<br/>");
                  }else{
                    out.print(p1.getName(teasession._nLanguage)+"　");
                  }
                  q++;
                }
              }
              if(q == 1){
                out.print(" ");
              }
              out.print("</td></tr>");
            }
          }
        }
      }
      %>

      <tr>
        <td colspan="4" align="center" bgcolor="#F5F5F5"><input type="button" value="返回" onclick="javascript:history.back();"/></td>
      </tr>
</table>
</body>
</html>
<script language="JavaScript">
anole('',1,'white','white','#BCD1E9','');
/*tr_tableid, // table id
num_header_offset,// 表头行数
str_odd_color, // 奇数行的颜色
str_even_color,// 偶数行的颜色
str_mover_color, // 鼠标经过行的颜色
str_onclick_color // 选中行的颜色
*/
</script>

