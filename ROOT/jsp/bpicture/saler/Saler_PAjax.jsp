<%@page contentType="text/html;charset=UTF-8"%><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.criterion.Item"%><%@ page import="tea.ui.TeaSession"%><%@ page import="tea.resource.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.bpicture.*"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
String falg;

String member = request.getParameter("member");
String community = request.getParameter("community");
String name = request.getParameter("name");
int ltype=0;
if(request.getParameter("ltype")!=null &&request.getParameter("ltype").length()>0 )
{
  ltype=Integer.parseInt(teasession.getParameter("ltype"));

}
int typenum=0;

if(request.getParameter("typenum")!=null && request.getParameter("typenum").length()>0)
{
  typenum=Integer.parseInt( request.getParameter("typenum"));
}// 0  默认类型修改，1创建用户名，2选择默认笔名  3删除用户名
int id =0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
{
  id = Integer.parseInt(request.getParameter("id"));
}
//out.print(id+"/");

try {

  if(typenum==1)
  {
    Bpseudonym.set(0,member,community,name,0,0);
  }
  if(typenum==0)
  {
    Bpseudonym.setltype(id,ltype,member);
  }
  if(typenum==2)
  {
    Bpseudonym.setltype(id,ltype,member);
  }
  if(typenum==3)
  {
    Bpseudonym.delete(id);
  }
} catch (Exception e)
{
  e.printStackTrace();
}

%>




