<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
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


Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String tel=(request.getParameter("tel"));
if(tel!=null&&tel.length()>0)
{
  sql.append(" AND tel LIKE ").append(DbAdapter.cite("%"+tel+"%"));
  param.append("&tel=").append(java.net.URLEncoder.encode(tel,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String fax=(request.getParameter("fax"));
if(fax!=null&&fax.length()>0)
{
  sql.append(" AND fax LIKE ").append(DbAdapter.cite("%"+fax+"%"));
  param.append("&fax=").append(java.net.URLEncoder.encode(fax,"UTF-8"));
}

String flowitemname=(request.getParameter("flowitemname"));
if(flowitemname!=null&&flowitemname.length()>0)
{

  DbAdapter db = new DbAdapter();
  DbAdapter db2 = new DbAdapter();
  try
  {
    db.executeQuery("SELECT workproject FROM Flowitem WHERE flowitem in (SELECT flowitem FROM  FlowitemLayer WHERE name LIKE "+db.cite("%"+flowitemname+"%")+" )");
    db2.executeQuery("SELECT COUNT(workproject) FROM Flowitem WHERE flowitem in (SELECT flowitem FROM  FlowitemLayer WHERE name LIKE "+db.cite("%"+flowitemname+"%")+" )");
    int cout2 = 0;
    if(db2.next())
    {
       cout2 = db2.getInt(1);
      if(cout2>0)
      {
        sql.append(" AND ( ");
      }
    }
    int j = 0;
    for(int i = 1;db.next();i++)
    {
      if(i == 1)
      {
        sql.append(" workproject = ").append(db.getInt(1));
      }else if(i>1)
      {
        sql.append(" or workproject = ").append(db.getInt(1));
      }
      j++;

    }
     if(j>0)
     {
       sql.append(" )");
     }else
     {
       sql.append(" AND workproject=0");
     }
  }finally
  {
    db.close();
    db2.close();
  }
  //sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+workproject+"%"));
  param.append("&flowitemname=").append(java.net.URLEncoder.encode(flowitemname,"UTF-8"));
 // System.out.println(sql.toString());
}
int pos=0,sizepage= 10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Workproject.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();


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
<!--客户或项目管理-->
<h1><%=r.getString(teasession._nLanguage,"1168574789140")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
<form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168575002906")%>：<!--名称--></td><td><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>客户项目：</td> <td> <input name="flowitemname" value="<%if(flowitemname!=null)out.print(flowitemname);%>"></td>
     </tr>
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168574945796")%>：<!--电话--></td><td><input name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"1168574969234")%>：<!--传真--></td><td><input name="fax" value="<%if(fax!=null)out.print(fax);%>">　　</td>
       <td><input name="submit" type="submit" value="GO"/></td>
     </tr>
   </table>
</form>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>

<form method="POST" action="/servlet/EditExportExcel" name="form2">
<input type="hidden" name="sql">
<input type="hidden" name="files" value="clientserver">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td>
         <%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+"</a>");
         }
         %></td>
         <td><%
         if("workproject".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"客户项目")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=workproject&"+param.toString()+" >"+r.getString(teasession._nLanguage,"客户项目")+"</a>");
         }
         %></td>
         <!--TD nowrap><%
         if("fax".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574969234")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=fax&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574969234")+"</a>");
         }
         %></TD-->
         <td><%
         if("email".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >联系人 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=email&"+param.toString()+" >联系人</a>");
         }
         %></td>
         <!--TD nowrap><邮编>
         <%
         if("postcode".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575152750")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=postcode&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575152750")+"</a>");
         }
         %></TD-->
         <td><!--时间-->
         <%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time&"+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+"</a>");
         }
         %></td>
         <td></td>
       </tr>
     <%
boolean falg = false;

java.util.Enumeration enumer=Workproject.find(community,sql.toString(),pos,sizepage);
if(!enumer.hasMoreElements())
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
for(int index=1;enumer.hasMoreElements();index++)
{
  int workproject=((Integer)enumer.nextElement()).intValue();
  Workproject obj=Workproject.find(workproject);

  falg=Flowitem.getflag(workproject);
  %>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1" align="center"><%=index%></td>
    <td><a href="/jsp/admin/workreport/ViewWorkproject.jsp?community=<%=teasession._strCommunity%>&workproject=<%=workproject%>"><%=obj.getName(teasession._nLanguage)%></a></td>
    <td ><%
    java.util.Enumeration fe = Flowitem.find(teasession._strCommunity," AND type = 0 AND workproject="+workproject,0,Integer.MAX_VALUE);
    for(int i =1;fe.hasMoreElements();i++)
    {
      int flid = ((Integer)fe.nextElement()).intValue();
      Flowitem flobj = Flowitem.find(flid);
     if(i<4){
       out.print("<a href =\"/jsp/admin/workreport/EditFlowitem.jsp?act=edit&community="+teasession._strCommunity+"&flowitem="+flid+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&workproject="+workproject+" \" target=\"_self\" >");
       out.print(flobj.getName(teasession._nLanguage));
       out.print("</a>&nbsp;&nbsp;");
     }
      //      if(i<=1)
      //      {
        //         out.print("，");
        //      }
        if(i==4)
        {
          out.print("&nbsp;(<a href=\"/jsp/admin/workreport/Flowitem.jsp?workproject="+workproject+" \" >更多...</a>)");
        }

      }
    %></td>
    <!--td nowrap>&nbsp;<%=obj.getFax()%></td-->
    <td >&nbsp;
    <%
    java.util.Enumeration  e = Worklinkman.find(teasession._strCommunity," AND workproject ="+workproject,0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      String wlmember=((String)e.nextElement());
      tea.entity.member.Profile profile=tea.entity.member.Profile.find(wlmember);
      out.print("<a href =\"#\" onClick=window.open('/jsp/admin/workreport/EditWorklinkman.jsp?community="+teasession._strCommunity+"&member="+wlmember+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); > ");
      out.print(profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage));
      out.print("</a>&nbsp;，&nbsp;");
    }

    %>
    </td>
    <!--td>&nbsp;<%=obj.getPostcode()%></td-->
    <td align="center"><%=obj.getTimeToString()%></td>

    <td align="center">
    <a href="/jsp/admin/workreport/WorkprojectGoods.jsp?workproject=<%=workproject%>"><img alt="" src="/tea/image/public/eye.gif" title="查看销售记录"></a>&nbsp;
    <a  href="/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=<%=workproject%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>" target="_self"  >
    <img alt="" src="/tea/image/public/icon_edit.gif" title="编辑" />
    </a>
      <!--input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=<%=workproject%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"-->
      <%
      if(falg)
      {
        %>

        <a  href="#"  onclick="alert('该客户下有项目,请删除项目后再删客户！');" >
          <img alt="" src="/tea/image/public/del.gif" />
        </a>
        <!--input type="button" name="delete" value="删除"  onclick="alert('该客户下有项目,请删除项目后再删客户！');"/-->
        <%
        }
        else
        {
          %>
            <a  href="#"  onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/EditWorkreport?community=<%=community%>&workproject=<%=workproject%>&action=deleteworkproject&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self'); this.disabled=true;}">
          <img alt="" src="/tea/image/public/del.gif" title="删除" />
        </a>

          <!--input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/EditWorkreport?community=<%=community%>&workproject=<%=workproject%>&action=deleteworkproject&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self'); this.disabled=true;}"-->
          <%
          }
          %>
    </td>
 </tr>
  <%
}
     %>
     <%if(count>sizepage){ %>
<tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,sizepage)%></td></tr>
<%} %>
</table>
<br>
<input type="button" value="<%=r.getString(teasession._nLanguage,"添加客户或项目")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
&nbsp;<input type="submit" name="exportall" value="导出Excel表" >
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


