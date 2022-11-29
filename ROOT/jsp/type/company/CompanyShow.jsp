<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.util.*" %>
<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
//  if (teasession._rv == null) {
//    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//    return;
//  }

StringBuffer sql = new StringBuffer(" AND n.hidden = 0 AND n.type = 21 ");
StringBuffer param = new StringBuffer("?community="+teasession._strCommunity);

//
//int id = 0;
//if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
//{
//    id = Integer.parseInt(request.getParameter("id"));
//}
String subject = teasession.getParameter("subject");
if(!"请输入企业名称".equals(subject)){
  if(subject!=null&&subject.length()>0)
  {
    subject = subject.trim();
    sql.append(" AND n.node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
    param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
  }
}
int father1 = 0;
if(teasession.getParameter("father1")!=null && teasession.getParameter("father1").length()>0)
{
  father1 = Integer.parseInt(teasession.getParameter("father1"));
}
if(father1>0)
{
  sql.append(" AND path LIKE "+DbAdapter.cite("%/"+father1+"/%"));
  param.append("&father1=").append(father1);
}
int father2 = 0;
if(teasession.getParameter("father2")!=null && teasession.getParameter("father2").length()>0)
{
  father2 = Integer.parseInt(teasession.getParameter("father2"));
}
if(father2>0)
{
  sql.append(" AND n.father = ").append(father2);
  param.append("&father2=").append(father2);
}
int  City = 0;
if(teasession.getParameter("City")!=null && teasession.getParameter("City").length()>0)
{
  City = Integer.parseInt(teasession.getParameter("City"));
}
if(City>0)
{
  sql.append(" AND n.node IN(SELECT node FROM Company WHERE city ="+City+") ");
  param.append("&City=").append(City);
}

int count = Node.countCompany(sql.toString());


 int pos = 0, pageSize = 5;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }


%>

  <%
  if(City>0 || father1>0 || father2>0 ){

   out.print("<div class=Searchcon> 您的搜索条件是：");
    if(City>0)
    {
      out.print(Card.find(City).getAddress()+"地区&nbsp;&nbsp;");
    }
    if(father1>0)
    {
      out.print(Node.find(father1).getSubject(teasession._nLanguage)+"类别&nbsp;&nbsp;");
    }
    if(father2>0)
    {
      out.print("&nbsp;>&nbsp;"+Node.find(father2).getSubject(teasession._nLanguage));
    }
    out.print("</div>");
  }

    %>

  <table border="0" cellpadding="0" cellspacing="0" id="Ent_tablecenter">

    <%
   // sql.append(" AND node IN (select node from AuditingMember order by moneys desc )");
   // System.out.println(sql.toString());
       java.util.Enumeration e = Node.findCompany(sql.toString(),pos,pageSize," order by c.moneys desc ");
       if(!e.hasMoreElements())
       {
         out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
       }
       while(e.hasMoreElements())
       {
         int nodeid = ((Integer)e.nextElement()).intValue();
         Node nobj = Node.find(nodeid);
         Company cobj = Company.find(nodeid);

    %>
    <tr>
       <td rowspan="4" class="Ent_img">
          <div>
            <img src="<%if(cobj.getLogo(teasession._nLanguage)!=null)out.print(cobj.getLogo(teasession._nLanguage));else out.print("/tea/image/no_picture.jpg");%>">
          </div>
      </td>
      <td class="Ent_name"><a href="/servlet/Company?node=<%=nodeid %>&language=<%=teasession._nLanguage%>"><%=nobj.getSubject(teasession._nLanguage)%></a>
            &nbsp;&nbsp;<%
            if(cobj.getMoneys()!=null)
            {
                out.print("<img src =/jsp/type/company/vip.gif>");
            }
            %>
</td> </tr>
<tr>
      <td class="Ent_con"><%
       if(Lucene.htmlToText(nobj.getText(teasession._nLanguage)).length()>60)
       {
          out.print(Lucene.htmlToText(nobj.getText(teasession._nLanguage)).substring(0,60)+".....");
       }else
       {
         out.print(Lucene.htmlToText(nobj.getText(teasession._nLanguage)));
       }
      %></td> </tr> <tr>
     <td class="Ent_Products"><span>主要产品：</span><%
     out.print(Goods.getGoods(nodeid,teasession._nLanguage));
     %></td> </tr> <tr>
      <td class="Ent_Website">
      <%
         if(cobj.getWebPage(teasession._nLanguage).indexOf("www.")!=-1)
         {
           out.print(cobj.getWebPage(teasession._nLanguage));
         }else
         {
           out.print("&nbsp;&nbsp;");
         }
      %></td>
    </tr>
    <%} %>

  <%if (count > pageSize) {  %>
    <tr> <td colspan="2" class="Ent_page"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>

  </table>

