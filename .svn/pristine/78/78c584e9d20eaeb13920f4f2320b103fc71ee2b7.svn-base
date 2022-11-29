<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=request.getParameter("community");
String member = teasession._rv.toString();//当前用户

AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
if(au_obj.isExists())
{
  String classes=au_obj.getClasses();
  if(classes.length()<2 && au_obj.getUnit()==0)
  {
   // response.sendRedirect("/jsp/info/Alert.jsp");
   // return;
  }

 int id = 0;
 if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
    id = Integer.parseInt(request.getParameter("id"));
  StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
  StringBuffer sql=new StringBuffer();
  int count=Bulletin.count(teasession._strCommunity,sql.toString());

  param.append("&id=").append(id);
  int pos=0;
  if(request.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(request.getParameter("pos"));
  }
  param.append("&pos=").append(pos);


  sql.append(" ORDER BY issuetime desc  ");
  int size = 10;


%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>公告通知管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

  <h2>列表</h2>
  <form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
    <input type="hidden" name ="id" value="<%=request.getParameter("id")%>" />
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>序号</td>
        <td nowrap>发布人</td>
        <td nowrap>发布范围</td>
        <td nowrap>标题</td>
        <td nowrap>附件文件</td>
        <td nowrap>创建时间</td>
        <td  nowrap>当前状态</td>
        <td colspan="2" nowrap >操作</td>
      </tr>
      <%
      Enumeration enumer = Bulletin.find(teasession._strCommunity,sql.toString(),pos,size);
      if(!enumer.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center><font color=red><b>暂无公告通知</b></font></td></tr>");
      }

      int index = pos+1;
      while(enumer.hasMoreElements())
      {
        int bullid=((Integer)enumer.nextElement()).intValue();
        Bulletin obj =  Bulletin.find(bullid);
        Profile p = Profile.find(obj.getMember());
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><%=index %></td>
          <td ><%=p.getName(teasession._nLanguage)%></td>
          <td ><%=obj.getTo(teasession._nLanguage) %></td>
          <td ><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>&bulletin=<%=bullid %>" target="_blank"><%
          if(obj.getNotread()==0)
          {
            out.print("<b>");
          }
          out.print(obj.getCaption()+"</b>");
          %></a></td>
          <td><%
          java.util.Enumeration e=obj.findFile();
          while(e.hasMoreElements())
          {
            Object os[]=(Object[])e.nextElement();
            out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode((String)os[1],"UTF-8")+"&name="+java.net.URLEncoder.encode((String)os[2],"UTF-8")+">"+os[2]+"</a><br/>");
          }
          %></td>
          <td><%=obj.getIssuetimeToString() %></td>
          <td> <%
            switch(obj.getType())
            {
              case 0:
              out.print("<font color='#FF0000'> 终止</font>");
              break;
              case 1:
              out.print("<font color='#00AA00'> 生效</font>");
              break;
            }
            %>
             </td>
             <td nowrap="nowrap"><a style="width:16;text-align:center" title="编辑" href ="/jsp/admin/flow/NewBulletin.jsp?community=<%=community %>&bulletin=<%=bullid %>"><img src="/tea/image/public/icon_edit.gif"/></a>
               <a style="width:16;text-align:center" title="删除" href ="/servlet/EditBulletin?community=<%=community%>&bulletin=<%=bullid %>&act=delete" onClick="return window.confirm('您确定要删除此内容吗？');"><img src="/tea/image/public/del.gif" /></a><br />
               <a style="width:16;text-align:center" title="查看阅读情况" href ="/jsp/netdisk/FileYNread.jsp?community=<%=community %>&bullid=<%=bullid %>"><img src="/tea/image/public/eye.gif"/></a>
             <%
             if(obj.getType()==0){
               %>
               <a style="width:16;text-align:center" title="立即生效" href ="/servlet/EditBulletin?community=<%=community%>&bulletin=<%=bullid%>&act=type&type=1" ><img src="/tea/image/public/nowstart.gif"/></a>
               <%
             }else{
               %>
               <a style="width:16;text-align:center" title="立即终止" href ="/servlet/EditBulletin?community=<%=community%>&bulletin=<%=bullid%>&act=type&type=0" ><img src="/tea/image/public/nowstop.gif"/></a>
               <%} %></td>
        </tr>
        <%
        index++;
      }


      if(count>size)
      {
        %>
        <tr>
          <td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
        </tr>
        <%
            }
          }
        %>
          </table>
</form>
<br>
  <input  type ="button" name="newbulletin" value="新建公告通知" onClick="location='/jsp/admin/flow/NewBulletin.jsp?community=<%=community %>';">

<!--<input  type ="button" name="newbulletin" value="全部删除" onClick="if(confirm('确定删除?'))location='/jsp/admin/flow/NewBulletin.jsp?community=<%=community %>&endelete=endelete';"  >-->

<div id="head6"><img height="6" src="about:blank"></div>
    </body>
  </HTML>



