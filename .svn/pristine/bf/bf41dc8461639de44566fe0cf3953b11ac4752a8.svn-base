<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

sn=request.getServerName()+":"+request.getServerPort();

jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";
out.print("<div id=modboxmenu><a target=_blank href='http://"+sn+"/jsp/admin/workreport/EditWorklog.jsp?community="+teasession._strCommunity+jsessionid+"' >写日志</a>");
out.print(" <a target=_blank href='http://"+sn+"/jsp/admin/workreport/Worklogs_2.jsp?community="+teasession._strCommunity+jsessionid+"' >看日志</a>");
out.print(" <a target=_blank href='http://"+sn+"/jsp/admin/workreport/Worktels.jsp?community="+teasession._strCommunity+jsessionid+"' >电话记录</a></div>");

out.print(ig(teasession,igd,teasession._rv._strV,1,""));

if(showcount>1)
{
	AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
	String classes=aur.getClasses();
	if(classes.length()>2)
	{
		DbAdapter db=new DbAdapter();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT DISTINCT wl.member FROM Worklog wl INNER JOIN ").append(DbAdapter.citeTab("AdminUsrRole")).append(" aur ON aur.member=wl.member AND aur.community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND wl.community=").append(DbAdapter.cite(teasession._strCommunity));
		sql.append(" WHERE DATEDIFF(dd,wl.time,GETDATE())=0");
		sql.append(" AND aur.unit IN(").append(classes.substring(1, classes.length() - 1).replace('/', ',')).append(")");
		try
		{
			db.executeQuery(sql.toString());
			for(int j=2;db.next();j++)
			{
				String member=db.getString(1);
                Profile obj = Profile.find(member);
				out.print(ig(teasession,igd,member,j,(obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage))));
			}
		}finally
		{
			db.close();
		}
	}
}
//

/*
  java.util.Enumeration enumer=Worklog.find(teasession._strCommunity," AND member="+DbAdapter.cite(teasession._rv._strV),0,mcount);
  for(int j=1;enumer.hasMoreElements();j++)
  {
    int worklog=((Integer)enumer.nextElement()).intValue();
    Worklog wl_obj=Worklog.find(worklog);
    String content=wl_obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
    String name;
    if(content.length()>20)
 	   name=content.substring(0,20)+"...";
    else
 	   name=content;
       out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
    out.print("  <a href=### onclick=\"var wo=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');wo.document.write(document.getElementById('fb_"+igd+"_"+worklog+"').innerHTML);\" >"+name+"</a><br>");
    out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
    out.print("    <div id=fb_"+igd+"_"+worklog+" >");
    out.print(content);
    out.print("    </div>");
    out.print("  </div>");
    out.print("</div>");
  }*/
%><%!
String sn,jsessionid;
private String ig(TeaSession teasession,int igd,String member,int j,String membername)throws Exception
//private String ig(TeaSession teasession,int igd,String member,int j)throws Exception
{
   StringBuffer html=new StringBuffer();

   int count=Worklog.count(teasession._strCommunity," AND DATEDIFF(dd,time,GETDATE())=0 AND member="+DbAdapter.cite(member));
   html.append("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
   html.append("  <a target=_blank href=http://"+sn+"/jsp/admin/workreport/Worklogs_2.jsp?community="+teasession._strCommunity+"&member="+member+jsessionid+" >"+(j==1?"我的工作记录":membername)+" ( "+count+" )</a><br>");
   html.append("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
   if(count<1)
   {
	   html.append("今天无工作日志....");
   }else
   {
	   java.util.Enumeration e2=Worklog.find(teasession._strCommunity," AND DATEDIFF(dd,time,GETDATE())=0 AND member="+DbAdapter.cite(member),0,20);
	   while(e2.hasMoreElements())
	   {
	   	  int wl_id=((Integer)e2.nextElement()).intValue();
	   	  Worklog wl_obj=Worklog.find(wl_id);
	   	  String content=wl_obj.getContent(teasession._nLanguage);
	      if(content.length()>30)
		     content=content.substring(0,30)+"...";
          html.append(content+"　"+wl_obj.getTimeToString2()+"<br>");
	   }
   }
   html.append("  </div>");
   html.append("</div>");
   return html.toString();
}
%>



