<%@page import="tea.entity.site.Community"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="java.math.BigDecimal" %> <%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
String act =teasession.getParameter("act");
String medianame = teasession.getParameter("medianame");
if("cunzai".equals(act))
{
  if(Media.count(" AND ml.name="+DbAdapter.cite(medianame))>0)
  {
    out.print("true");
   // System.out.println(medianame+"--true");
  }else
  {
    out.print("false");

  }
  return;
}else if("f_subject".equals(act))
{
	String subject = teasession.getParameter("subject");
	//System.out.println(Entity.sdf.format(Entity.getDayTime2(new Date(),2)));
	String s = "";
	if(subject!=null && subject.length()>0)
	{
		subject = subject.trim();
		DbAdapter db = new DbAdapter();
		try
		{
			String sql = "";
			if(Community.find(teasession._strCommunity).getSubjectnode()>0)
			{
				sql = " and path not like "+DbAdapter.cite("%/"+Community.find(teasession._strCommunity).getSubjectnode()+"/%");
			}
			//36489 节点是限制民族报
			db.executeQuery("select * from Node where   time >="+db.cite(Entity.getSubDayTime(new Date(),365))+"  "+sql+" and type = 39 and node in (select node from NodeLayer where subject="+db.cite(subject)+" ) ");
			//System.out.println("select * from Node where time >="+db.cite(Entity.getSubDayTime(new Date(),30))+" and type = 39 and node in (select node from NodeLayer where subject="+db.cite(subject)+" ) ");

			if(db.next())
			{
				s = "系统已经出现过您添加的新闻主题！";
			}
		}finally
		{
			db.close();
		}
	}

	out.print(s);
	return;
}
if("searchAllM".equals(act))
{
  String cxxw = teasession.getParameter("cxxw").trim();
  if(cxxw!=null && cxxw.length()>0)
  {//如果医院不为空的时候才执行语句
    ArrayList al=Media.find(" AND m.community="+DbAdapter.cite(teasession._strCommunity)+" AND m.type=39 AND ml.name LIKE "+DbAdapter.cite("%"+cxxw+"%"),0,10);
    if(al.size()>0)//如果输入的医院查询有记录才执行
    {
      out.print("<div id=xilidiv>");
      out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable\" onMouseOut=\"f_yinyin()\" onMouseOver=\"f_showx()\" >" );
      for(int i=0;i<al.size();i++)
      {
        Media nobj = (Media)al.get(i);
        out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=\"f_trdw('"+nobj.getName(teasession._nLanguage)+"','"+nobj.media+"');\">");
        out.print("<td>");
        out.print(nobj.getName(teasession._nLanguage));
        out.print("<input type=hidden  name=mname"+i+"  value='"+nobj.getName(teasession._nLanguage)+"'><input type=hidden name=nid"+i+" value='"+nobj.media+"'>");
        out.print("</td>");
        out.print("</tr>");
      }
      out.print("</table>");
      out.print("</div>");
    }
  }
  return;
}
%>
