
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;



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

int count=Archives.count(teasession._strCommunity,sql.toString());
int size = 10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
//param.append("&pos=").append(pos);



AdminUsrRole adobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());

sql.append("  and (");
String aa[] = adobj.getRole().split("/");//当然用户的角色
for(int i=0;i<aa.length;i++)
{
	sql.append("  role  like '%/"+aa[i]+"%' or ");
}
sql.append("   adminunit like '%/"+adobj.getUnit()+"%')");
//sql.append(" ORDER BY times desc  ");

String o=request.getParameter("o");
if(o==null)
{
  o="archives";
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
<script>

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

<h1>查看文件</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
    <form name=form1 METHOD=post  action="?">
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

<h2>文件登记</h2>

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
          <td nowrap><a href="javascript:f_order('caption');">标题</a><%
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

         <td nowrap><a href="javascript:f_order('times');">发布时间</a><%
          if(o.equals("times"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
       </tr>
<%



int index=pos+1;

java.util.Enumeration enumer = Archives.find(teasession._strCommunity,sql.toString(),pos,size);
if(!enumer.hasMoreElements())
{
      out.print("<tr><td colspan=5 align=center><font color=red><b>暂无记录</b></font></td></tr>");
}else
       		while(enumer.hasMoreElements())
       		{
       			int archives = ((Integer)enumer.nextElement()).intValue();
       			Archives obj = Archives.find(archives);
       			//String bu[] = obj.getBulletin().split(",");
                        tea.entity.member.Profile p = tea.entity.member.Profile.find(obj.getMember());
        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	   <td align="center" ><%=index %>　</td>
		    <td align="center" nowrap><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></td>
		     <td nowrap><a href="/jsp/admin/archives/show.jsp?archives=<%=archives%>"  target="_blank"><%

            out.print(obj.getCaption());
             %></a></td>
		    <td align="center" nowrap>
				<%

				out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getFileurl(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getFilename(),"UTF-8")+"\">"+obj.getFilename()+"</a><br>");

   			 %> 　
				</td>
		     <td align="center" nowrap><%=obj.getTimes()%></td>
    </tr>
    <%
    index++;
    	}//while循环
              if(count>size){
             %>
             <tr>
               <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
             </tr><%
             }%>
</table>
</form>
</body>
</html>



