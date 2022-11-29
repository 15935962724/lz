<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.RV" %>
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
String community=teasession._strCommunity;



String delete = teasession.getParameter("DELETE");
if(delete!=null && delete.equals("DELETE"))//删除排班类型的
{
	int id = 0;
	if(teasession.getParameter("id")!=null){
		id= Integer.parseInt(teasession.getParameter("id"));
	}
	RankClass obj = RankClass.find(id);
	obj.delete();
	response.sendRedirect("/jsp/admin/manage/rankclass.jsp");
	return;
}


if(teasession.getParameter("leaid")!=null)//请假申请的
{
	int leaid = Integer.parseInt(teasession.getParameter("leaid"));
	Leavec.delete(leaid);
	response.sendRedirect("/jsp/admin/manage/leave.jsp");
	return ;
}
if(teasession.getParameter("type")!=null)//申请销假
{
	int typeid = Integer.parseInt(teasession.getParameter("type"));
	Leavec  leobj = Leavec.find(typeid);
	leobj.settype();
	response.sendRedirect("/jsp/admin/manage/leave.jsp");
	return;
}

if(teasession.getParameter("evetype")!=null)
{
	int eveid = Integer.parseInt(teasession.getParameter("evetype"));
	Evection eveobj = Evection.find(eveid);
	eveobj.seteve();
	response.sendRedirect("/jsp/admin/manage/evection.jsp");
	return;

}

if(teasession.getParameter("outid")!=null)
{
	int outid = Integer.parseInt(teasession.getParameter("outid"));
	int type = Integer.parseInt(teasession.getParameter("outtype"));
	Outs outobj = Outs.find(outid);
	outobj.settype(type);
	response.sendRedirect("/jsp/admin/manage/Inmanage.jsp");
	return;

}

if(teasession.getParameter("leatype")!=null)
{
	int leatype = Integer.parseInt(teasession.getParameter("leatype"));
	int leaid = Integer.parseInt(teasession.getParameter("leaids"));
	 Node node = Node.find(teasession._nNode);
	Leavec leaobj = Leavec.find(leaid);
	leaobj.settypes(leatype);
    //String lmember = null;
//   if(node.getCreator()._strR!=null && node.getCreator()._strR.length()>0)
//   {
//    lmember= node.getCreator()._strR;
//   }else
//   {
//     lmember = leaobj.getMember();
//   }
	 tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(leaobj.getMember());
     String s11 = leaobj.getMember();
     RV _rv=new RV(profile1.getMember());
    int ltype = Integer.parseInt(teasession.getParameter("leatype"));
    if(ltype==1){
      Message.create(teasession._strCommunity, _rv._strV,s11,teasession._nLanguage,"请假批准","您的请假领导已经批准");
    //	Message.create(teasession._strCommunity, _rv, null, 0, 0, 0, 0, teasession._nLanguage,"请假批准","您的请假领导已经批准", null, null, "", null,s11 , "", "", null, null, 0, 0);
    }else if(ltype==-1)
    {
      Message.create(teasession._strCommunity, _rv._strV,s11,teasession._nLanguage,"请假不批准","您的请假领导没有批准");
    	//Message.create(teasession._strCommunity, _rv, null, 0, 0, 0, 0, teasession._nLanguage,"请假不批准","您的请假领导没有批准", null, null, "", null,s11 , "", "", null, null, 0, 0);
	}
	response.sendRedirect("/jsp/admin/manage/Inmanage.jsp");
	return ;
}
if(teasession.getParameter("LEAid")!=null)
{
	String timek = teasession.getParameter("timek");
	String timej = teasession.getParameter("timej");
	int leaveid = Integer.parseInt(teasession.getParameter("LEAid"));
	Leavec lobj = Leavec.find(leaveid);
	lobj.delete();
	response.sendRedirect("/jsp/admin/manage/search.jsp?timek="+timek+"&timej="+timej+"");
	return;
}
if(teasession.getParameter("EVEid")!=null)
{
	String timek = teasession.getParameter("timek");
	String timej = teasession.getParameter("timej");
	int eid = Integer.parseInt(teasession.getParameter("EVEid"));
	Evection eobj = Evection.find(eid);
	eobj.delete();
	response.sendRedirect("/jsp/admin/manage/search.jsp?timek="+timek+"&timej="+timej+"");
	return;
	//人事管理 --》 考勤设置 里的删除
}
if(teasession.getParameter("delete1")!=null)
{
	DutyClass.deleteAll();
	response.sendRedirect("/jsp/admin/manage/delete.jsp?d1=d1");
	return;
}

if(teasession.getParameter("delete2")!=null)
{
	Outs.deleteAll();
	response.sendRedirect("/jsp/admin/manage/delete.jsp?d2=d2");
	return;
}
if(teasession.getParameter("delete3")!=null)
{
	Leavec.deletes();
	response.sendRedirect("/jsp/admin/manage/delete.jsp?d3=d3");
	return;
}
if(teasession.getParameter("delete4")!=null)
{
	Evection.deletes();
	response.sendRedirect("/jsp/admin/manage/delete.jsp?d4=d4");
	return;
}
if(teasession.getParameter("delete5")!=null)
{
	DutyClass.deleteAll();
	Outs.deleteAll();
	Leavec.deletes();
	Evection.deletes();
	response.sendRedirect("/jsp/admin/manage/delete.jsp?d5=d5");
	return;
}
%>




