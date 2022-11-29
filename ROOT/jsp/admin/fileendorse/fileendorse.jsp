<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();
String _strId=request.getParameter("id");

String caption=request.getParameter("caption");
if(caption!=null&&(caption=caption.trim()).length()>0)
{
  sql.append(" AND caption like "+DbAdapter.cite("%"+caption+"%"));
  param.append("&caption="+java.net.URLEncoder.encode(caption,"UTF-8"));
}
String filename=request.getParameter("filename");
if(filename!=null&&(filename=filename.trim()).length()>0)
{
  sql.append(" AND filename like "+DbAdapter.cite("%"+filename+"%"));
  param.append("&filename="+java.net.URLEncoder.encode(filename,"UTF-8"));
}
String member=request.getParameter("member");
if(member!=null&&(member=member.trim()).length()>0)
{
  sql.append(" AND member in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+member+"%")+" or firstname like "+DbAdapter.cite("%"+member+"%")+")");
  param.append("&member="+java.net.URLEncoder.encode(member,"UTF-8"));
}
//String acceptmember=request.getParameter("acceptmember");
//if(acceptmember!=null&&(acceptmember=acceptmember.trim()).length()>0)
//{
//  sql.append(" AND acceptmember in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+acceptmember+"%")+" or firstname like "+DbAdapter.cite("%"+acceptmember+"%")+")");
//  param.append("&acceptmember="+java.net.URLEncoder.encode(acceptmember,"UTF-8"));
//}
int count=FileEndorse.count(teasession._strCommunity,sql.toString());
int size =10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
//param.append("&pos=").append(pos);


//sql.append(" ORDER BY times desc  ");

String o=request.getParameter("o");
if(o==null)
{
  o="fileendorse";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);
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

  <script >
  function editimd(igd)
  {
    form1.fileendorse.value=igd;
    form1.action='/jsp/admin/fileendorse/EditFileendorse.jsp';
    form1.submit();
  }
  function deleteimd(igd)
{
  if(confirm('您确认要删除！'))
  {
    form1.fileendorse.value=igd;
    form1.action='/servlet/EditFileEndorse';
    form1.submit();
  }
}


function LoadWindow(f,m)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
   window.showModalDialog("/jsp/admin/fileendorse/show.jsp?fileendorse="+f+"&member="+m,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}


function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}
  </script>
  <body>

  <h1>文件会签管理</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
   <h2>查询</h2>
<form name=form1 METHOD=get  action="?">
  <input type=hidden name="fileendorse">
  <input type=hidden name="act" value="delete"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
  <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
        <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>文件标题<input name="caption" value="<%if(caption!=null)out.print(caption);%>"></td>
        <td>附件名称<input name="filename" value="<%if(filename!=null)out.print(filename);%>"></td>
        <td>发布人<input name="member" value="<%if(member!=null)out.print(member);%>"></td>

        <td><input type="submit" value="查询"/></td>
      </tr>
    </table>
    <h2>列表(<%=count %>)</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr id="tableonetr">
        <td nowrap>序号</td>
        <td nowrap><a href="javascript:f_order('member');">发布人</a><%
          if(o.equals("member"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="javascript:f_order('caption');">文件标题</a><%
          if(o.equals("caption"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="javascript:f_order('filename');">附件文件</a><%
          if(o.equals("filename"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="javascript:f_order('acceptmember');">接收人员</a><%
          if(o.equals("acceptmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="javascript:f_order('acceptmember');">不同意人员</a><%
          if(o.equals("acceptmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap><a href="javascript:f_order('acceptmember');">同意人员</a><%
          if(o.equals("acceptmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
        <td nowrap >操作</td>

      </tr>
      <%
      java.util.Enumeration e = FileEndorse.find(teasession._strCommunity,sql.toString(),pos,size);
        if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=8 align=center>暂无记录</td></tr>");
   }
      int index=pos+1;
      while(e.hasMoreElements()){
        int fileenodrse = ((Integer)e.nextElement()).intValue();
        FileEndorse feobj = FileEndorse.find(fileenodrse);
        Profile pobj = Profile.find(feobj.getMember());
          String memstr[] = feobj.getAcceptmember().split("/");
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
		<td align="center"><%=index %>　</td>
          <td align="center"><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %></td>
             <td ><a href="/jsp/admin/fileendorse/showcontent.jsp?fileenodrse=<%=fileenodrse%>" target="_blank"> <%= feobj.getCaption()%></a></td>
           <%if(feobj.getFilename()!=null && feobj.getFilename().length()>0) {%>
              <td align="center"><a href="/jsp/include/DownFile.jsp?uri=<%=java.net.URLEncoder.encode(feobj.getFileurl(),"UTF-8")%>&name=<%=java.net.URLEncoder.encode(feobj.getFilename(),"UTF-8")%>"><%=feobj.getFilename() %></a></td>
              <%
            }else{
            out.print("<td>暂无附件</td>");
            }

              %>
          <td align="center"><%
          for(int i =0;i<memstr.length;i++)
          {
            Profile p = Profile.find(memstr[i]);
            out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"/");
          }
          %></td>
          <td align="center">
          <%

          for(int ii =0;ii<memstr.length;ii++)
          {
            FileEndorse f =  FileEndorse.find(fileenodrse,memstr[ii]);
            Profile p1 = Profile.find(f.getMember2());
            if(f.getType()==-1){
              out.print("/"+"<a href =\"#\" onclick=\"javascript:LoadWindow('"+fileenodrse+"','"+f.getMember2()+"');\">"+p1.getLastName(teasession._nLanguage)+p1.getFirstName(teasession._nLanguage)+"</a>");
            }

          }
          %>
          　</td>
          <td align="center">
           <%
          for(int iii =0;iii<memstr.length;iii++)
          {
            FileEndorse ff=  FileEndorse.find(fileenodrse,memstr[iii]);
            Profile p2= Profile.find(ff.getMember2());
            if(ff.getType()==1){
              out.print("/"+p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage));
            }
          }
          %>
          　</td>
          <td align="center"><input  type ="button"  value="编辑" onClick="editimd(<%= fileenodrse%>);">
            <input type=button value="删除"  onClick="deleteimd(<%=fileenodrse%>);">
          </td>
        </tr>
        <%
        index++;
        }if(count>size){
        %>

        <tr>
          <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
        </tr><%
        } %>
        </table>
</form>
<br>
 <input  type ="button" name="newbulletin" value="创建文件会签" onClick="editimd(0);">

<!--<input  type ="button" name="newbulletin" value="全部删除" onClick="if(confirm('确定删除?'))location='/jsp/admin/fileendorse/EditFileendorse.jsp';"  >-->

<div id="head6"><img height="6" src="about:blank"></div>
    </body>
  </html>



