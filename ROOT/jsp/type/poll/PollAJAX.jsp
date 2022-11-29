<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%
TeaSession teasession=new TeaSession(request);

String act= teasession.getParameter("act");
if("EDITPOLLNODE".equals(act))
{
	//投票参数
	int answer  = 0;
	if(teasession.getParameter("EDITPOIINODEID")!=null && teasession.getParameter("EDITPOIINODEID").length()>0)
	{
		answer = Integer.parseInt(teasession.getParameter("EDITPOIINODEID"));
	}
	int npindex1=0,npindex2=0,npindex3=0,npindex4=0,npindex5=0,npindex6=0;
	
	switch(answer)
	{
	  case 1 :
		  npindex1=1;
		  break;
	  case 2 :
		  npindex2=1;
		  break;
	  case 3 :
		  npindex3=1;
		  break;
	  case 4 :
		  npindex4=1;
		  break;
	  case 5 :
		  npindex5=1;
		  break;
	  case 6 :
		  npindex6=1;
		  break;
	}
	NodePoll npobj = NodePoll.find(teasession._nNode);
	
	
	if(npobj.isExists())
	{
		npobj.set(npobj.getNpindex1()+npindex1,npobj.getNpindex2()+npindex2,npobj.getNpindex3()+npindex3,npobj.getNpindex4()+npindex4,npobj.getNpindex5()+npindex5,npobj.getNpindex6()+npindex6);
	}else
	{ 
		NodePoll.create(teasession._nNode,npindex1,npindex2,npindex3,npindex4,npindex5,npindex6); 
	}
%>
<table border="0" cellpadding="0" cellspacing="0" class="ExpVote">
  <tr>
  <%
  for(int index=1;index<NodePoll.POLL_TYPE.length;index++)
  {   
%>
	<td><table cellpadding="0" cellspacing="0" ><tr><td align=center>
	<div style="margin-bottom:2px;"><%=NodePoll.getNp(index,teasession._nNode)%></div>
	<div style="height:45px;background:url(/tea/image/report/face_plan.gif) repeat-y left top;border:1px solid #f60;width:13px;margin-bottom:3px;">
	<div style="height:<%=NodePoll.getNpconut(index,teasession._nNode)%>;background:url(/tea/image/report/face_bg03.gif) repeat-y left top;font-size:0px;"></div>
	</div>
	 <img src=/tea/image/report/i<%=index %>.gif></td><td valign="bottom"><%= NodePoll.POLL_TYPE[index]%></td></tr></table>
	 </td>
<%
//System.out.println(NodePoll.getNpconut(index,teasession._nNode));
  }
  %>
  </tr>
  </table>
<%}else if("EDITPOLLNODE2".equals(act)){


	
	
	
	
	//投票参数
	int answer  = 1;
	//if(teasession.getParameter("EDITPOIINODEID")!=null && teasession.getParameter("EDITPOIINODEID").length()>0)
	//{
		//answer = Integer.parseInt(teasession.getParameter("EDITPOIINODEID"));
	//}
	int npindex1=0,npindex2=0,npindex3=0,npindex4=0,npindex5=0,npindex6=0;
	
	switch(answer)
	{
	  case 1 :
		  npindex1=1;
		  break;
	  case 2 :
		  npindex2=1;
		  break;
	  case 3 :
		  npindex3=1;
		  break;
	  case 4 :
		  npindex4=1;
		  break;
	  case 5 :
		  npindex5=1;
		  break;
	  case 6 :
		  npindex6=1;
		  break;
	}
	String ip = session.getId();//request.getRemoteAddr();
	
	Date t = new Date();
	String cc = NodePoll.sdf.format(t);
	Date times  = NodePoll.sdf.parse(cc);
	
	
	
	int npid = NodePoll_2.getNpid(ip,teasession._nNode,times);
	
	NodePoll_2 npobj = NodePoll_2.find(npid);
	
	int cou = npobj.getNpindex1()+npobj.getNpindex2()+npobj.getNpindex3();
	//System.out.println(npid); 
	if(cou>=5){
		out.println("false");
		return;
	}else{ 
		if(npid>0)
		{
			npobj.set(npobj.getNpindex1()+npindex1,npobj.getNpindex2()+npindex2,npobj.getNpindex3()+npindex3,npobj.getNpindex4()+npindex4,npobj.getNpindex5()+npindex5,npobj.getNpindex6()+npindex6);
		}else 
		{ 
			NodePoll_2.create(teasession._nNode,npindex1,npindex2,npindex3,npindex4,npindex5,npindex6,times,ip); 
		}
		out.println("true");
		return;
	}
}%>