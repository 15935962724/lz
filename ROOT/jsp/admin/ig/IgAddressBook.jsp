<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";

java.util.Enumeration enumer=SMSGroup.findByMember(teasession._rv.toString(),teasession._strCommunity);
for(int j=0;enumer.hasMoreElements()&&j<showcount;j++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  int count=SMSPhoneBook.countByGroup(id);
  SMSGroup smsg=SMSGroup.find(id);
  out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
  out.print("  <a target=_blank href=http://"+sn+"/jsp/sms/psmanagement/PhoneBookManage.jsp?community="+teasession._strCommunity+"&groupid="+id+jsessionid+" >"+smsg.getName()+" ( "+count+" )</a><br>");
  out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
  if(count<1)
  {
	  out.print("　　无联系人....");
  }else
  {
	  java.util.Enumeration e2=SMSPhoneBook.findByGroup(id);
	  while(e2.hasMoreElements())
	  {
		  int spb_id=((Integer)e2.nextElement()).intValue();
		  SMSPhoneBook spb_boj=SMSPhoneBook.find(spb_id);
		  out.print(spb_boj.getName()+"　"+spb_boj.getEmail()+"<br>");
	  }
  }
  out.print("  </div>");
  out.print("</div>");
}
%>



