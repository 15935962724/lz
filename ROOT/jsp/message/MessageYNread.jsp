<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");



TeaSession teasession=new TeaSession(request);
Enumeration enume1 = null;
Enumeration enume2 = null;
Enumeration e1 = null;
Enumeration e2 = null;
int newid = Integer.parseInt(teasession.getParameter("newid"));
int o=0, p=0, q=0,r=0, a=1,b=1,c=1,d=1;
String[] name = null;
%>
<html>
<head>
<title>察看阅读情况</title>
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
    <td align="center" width="50%"><b>已阅</b></td>
    <td align="center" width="50%"><b>未阅</b></td>
  </tr>
  <tr>
    <td align="left" colspan="2" bgcolor="#F5F5F5"><b>人员</b></td>
  </tr>
  <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
    <!--已读-->
    <td>
    <%
    enume1 = Bulletin.nreadMessagePer(newid);

    while(enume1.hasMoreElements())
    {
      name = enume1.nextElement().toString().split("/");
      for(int i=1; i<name.length; i++)
      {
        Profile pro = Profile.find(name[i]);
        if(Bulletin.showYreadPer(name[i],newid))
        {
          if(a%3==0)
          {
            out.print(pro.getName(1)+Bulletin.readDate(name[i],newid)+"</br>");
          }else
          {
            out.print(pro.getName(1)+Bulletin.readDate(name[i], newid)+"　");
          }
          a++;
        }
      }
    }
    if(a==1)
    {
      out.print("　");
    }
    %>
    </td>
    <!--未读-->
    <td>
    <%
    enume2 = Bulletin.nreadMessagePer(newid);

    while(enume2.hasMoreElements())
    {
      name = enume2.nextElement().toString().split("/");
      for(int i=1; i<name.length; i++)
      {
         Profile pro = Profile.find(name[i]);
        if(Bulletin.showNreadPer(name[i],newid))
        {
          if(b%7 == 0){
            out.print(pro.getName(1)+"</br>");
          }else{
          out.print(pro.getName(1)+"　");
          }
          b++;
        }

      }

    }
    if(b==1){
      out.print("　");
    }
    %>
    </td>
  </tr>
  <tr><td align="left" colspan="2" bgcolor="#F5F5F5"><b>部门</b></td></tr>
  <%
  Message m=Message.find(newid);
  name = m.getTUnit().split("/");
  for(int i = 1; i < name.length; i++)
  {
    e2 =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(name[i]),true);
    if(e2.hasMoreElements())
    {
      AdminUnit au=  AdminUnit.find(Integer.parseInt(name[i]));
        %>
        <tr>
          <td align="left" colspan="2"><%=au.getName()%></td>
        </tr>
        <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
          <!--已读-->
          <td >
          <%


          while(e2.hasMoreElements()){
            String _member = (String)e2.nextElement();
             Profile pro = Profile.find(_member);
            if(Bulletin.showYreadPer(_member,newid)){
              if(c%3==0){
                out.print(pro.getName(1)+Bulletin.readDate(_member, newid)+"</br>" );
              }else{
              out.print(pro.getName(1)+Bulletin.readDate(_member, newid)+"　" );
              }
              c++;
            }

          }
          if(c==1){
            out.print("　");
          }
          %>
          </td>

          <!--未读-->
          <td >
          <%
          e1 =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(name[i]),true);

          while(e1.hasMoreElements()){
            String _member = (String)e1.nextElement();
             Profile pro = Profile.find(_member);
            if(Bulletin.showNreadPer(_member,newid)){
              if(d%7==0){
                out.print(pro.getName(1)+"</br>");
              }else{
              out.print(pro.getName(1)+"　");
              }
              d++;
            }

          }
          if(d==1){
            out.print("　");
          }
          %>
          </td>
        </tr>
        <%
        }
      }
    %>
    <tr>
      <td colspan="2" align="center" bgcolor="#F5F5F5"><input type="button" value="返回" onclick="javascript:history.back();"/></td>
    </tr>
</table>
</body>
</html>
