<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*"%><%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);

String act = teasession.getParameter("act");

if("reportact".equals(act))
{
  String cxxw = teasession.getParameter("cxxw");


 // cxxw= new String(cxxw.getBytes("iso8859-1"),"UTF-8");
  if(cxxw!=null && cxxw.length()>0)
  {//如果来源不为空的时候才执行语句
    cxxw = cxxw.trim();
    ArrayList al=Media.find(" AND m.community="+DbAdapter.cite(teasession._strCommunity)+" AND m.type=39 AND ml.name LIKE "+DbAdapter.cite("%"+cxxw+"%"),0,10);
    if(al.size()>0)//如果输入的来源查询有记录才执行
    {
      out.print("<div id=xilidiv>");
      out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable\" onMouseOut=\"f_yinyin()\" onMouseOver=\"f_showx()\" >" );
      for(int i=0;i<al.size();i++)
      {
        Media nobj = (Media)al.get(i);
        out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=\"f_trdw('"+nobj.getName(teasession._nLanguage)+"','"+nobj.media+"');\">");
        out.print("<td>"+nobj.getName(teasession._nLanguage));
        out.print("<input type=hidden  name=mname"+i+"  value='"+nobj.getName(teasession._nLanguage)+"'><input type=hidden name=nid"+i+" value='"+nobj.media+"'>");
        out.print("</td>");
        out.print("</tr>");
      }
      out.print("</table>");
      out.print("</div>");
    }
  }
  return;
}else if("reportstatistics".equals(act))
{
	String cxxw = teasession.getParameter("cxxw");

	  if(cxxw!=null && cxxw.length()>0)
	  {//如果来源不为空的时候才执行语句
		  cxxw = cxxw.trim();
	    int count = Node.count("  and type=1 and hidden =0 and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+cxxw+"%")+"  ) ");
	//  System.out.println("  and type=1 and hidden =0 and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+cxxw+"%")+"  ) ");
	    if(count>0)//如果输入的来源查询有记录才执行
	    {

	      out.print("<div id=xilidiv>");

	      out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable\"  >" );
	      java.util.Enumeration e = Node.find("and type=1 and hidden =0 and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+cxxw+"%")+"  )",0,10);
	      int i=1;
	      while(e.hasMoreElements())
	      {
	        int nid = ((Integer)e.nextElement()).intValue();
	        Node nobj = Node.find(nid);
	        out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=\"f_trdw('"+nobj.getSubject(teasession._nLanguage)+"');\">");
	        out.print("<td>");
	        out.print(nobj.getSubject(teasession._nLanguage));
	        out.print("<input type=hidden  name=mname"+i+"  value='"+nobj.getSubject(teasession._nLanguage)+"'><input type=hidden name=nid"+i+" value='"+nid+"'>");
	        out.print("</td>");
	        out.print("</tr>");
	        i++;
	      }
	      out.print("</table>");
	      out.print("</div>");
	    }
	  }
	  return;
}

%>
