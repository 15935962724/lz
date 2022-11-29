<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="javax.mail.Folder" %>
<%@page import="tea.entity.*"%>
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

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";

if(request.getParameter("ajax")!=null)
{
  OnlineList o=OnlineList.find(session.getId());
  if(o.getTime()==null)
  OnlineList.create(session.getId(),teasession._strCommunity,request.getRemoteAddr());
  else
  o.set(teasession._strCommunity,request.getRemoteAddr());

  Enumeration e=OnlineList.findByCommunity(teasession._strCommunity," AND member IS NOT NULL");
  for(int j=1;j<=showcount&&e.hasMoreElements();j++)
  {
    String s=(String)e.nextElement();
    OnlineList obj=OnlineList.find(s);
    Profile profile=Profile.find(obj.getMember());
    if(profile!=null)
    {
      out.print("<div id=ftl_"+igd+"_"+j+"00 class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"00' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+"00)'></a>");
      out.print(obj.getMember()+"　( "+obj.getIP()+" )");
      out.print("<SPAN ID=igmembers_message ><A href=\"http://"+sn+"/jsp/message/NewMessage.jsp?URI=/servlet/NewMessage&community="+teasession._strCommunity+"&Receiver="+java.net.URLEncoder.encode(obj.getMember(),"UTF-8")+jsessionid+"\" target=_blank title=消息 ><img src=/tea/image/public/message.gif></a>");
      out.print(" <A href=\"http://"+sn+"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+profile.getMobile()+jsessionid+"\" target=_blank title=短信 ><img src=/tea/image/public/sms.gif></a>");
      out.print("</SPAN><br/>");

      out.print("  <div id=fb_"+igd+"_"+j+"00 class='fpad fb' style='display:none'>");
      out.print("地区: "+NodeAccessWhere.findByIp(obj.getIP()));
      //out.print("<br>会话: "+s);
      out.print("<br>时间: "+obj.getTimeToString());
      out.print("<br>在线: "+((System.currentTimeMillis()-obj.getTime().getTime())/(1000))+"秒");
      out.print("  </div>");
      out.print("</div>");
    }
  }
  return;
}



out.print(" <a href=javascript:f_igmembers(false)  >人员列表</a>");
out.print(" <a href=javascript:f_igmembers(true) >在线人员</a>");

out.print("<DIV id=im_memberlist>");


java.util.Enumeration enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
for(int j=1;j<=showcount&&enumer.hasMoreElements();j++)
{
  AdminUnit au_obj=(AdminUnit)enumer.nextElement();
  int unltid=au_obj.getId();
  //int count=AdminUsrRole.count(teasession._strCommunity," AND unit="+unltid);

	out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
	out.print("  <a target=_blank  >"+au_obj.getName()+"　( <span id=igmembers_count_"+j+">0</span> )</a><br>");
	out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");

	java.util.Enumeration enumer_pro=AdminUsrRole.findByUnit(unltid,teasession._strCommunity);
	if(!enumer_pro.hasMoreElements())
	{
		out.print("暂无信息...");
	}else
	{
		int count=0;
	    while(enumer_pro.hasMoreElements())
		{
	      String member=(String)enumer_pro.nextElement();
		  Profile profile=Profile.find(member);
	      if(profile!=null)
	      {
	        out.print(profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage));
	        out.print("<SPAN ID=igmembers_message ><A href=\"http://"+sn+"/jsp/message/NewMessage.jsp?URI=/servlet/NewMessage&community="+teasession._strCommunity+"&Receiver="+java.net.URLEncoder.encode(member,"UTF-8")+jsessionid+"\" target=_blank title=消息 ><img src=/tea/image/public/message.gif></a>");
	        out.print(" <A href=\"http://"+sn+"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+profile.getMobile()+jsessionid+"\" target=_blank title=短信 ><img src=/tea/image/public/sms.gif></a>");
	        out.print("</SPAN><br/>");
	        count++;
	      }
		}
	    out.print("<script>igmembers_count_"+j+".innerHTML="+count+";</script>");
	}
	out.print("  </div>");
	out.print("</div>");
}
out.print("</DIV>");


out.print("<DIV id=im_memberonline style=display:none >");
out.print("<img src=/tea/image/public/load.gif >正在加载...");
out.print("</DIV>");

%>

<script>
function f_igmembers(bool)
{
	var im=document.getElementById('im_memberlist');
	var ie=document.getElementById('im_memberonline');
	if(bool)
	{
		im.style.display='none';
		ie.style.display='';
		<%
		if(jsessionid==null||jsessionid.length()<1)
		out.print("sendx(\"/jsp/admin/ig/IgMembers.jsp?ajax=ON&community="+teasession._strCommunity+"&igd="+igd+"&showcount="+showcount+"\",function(data){ie.innerHTML=data;});");
		else
		out.print("sendx(\"/servlet/Ajax?act=sendx&url="+java.net.URLEncoder.encode("http://"+sn+"/jsp/admin/ig/IgMembers.jsp?ajax=ON&community="+teasession._strCommunity+"&igd="+igd+"&showcount="+showcount+jsessionid,"UTF-8")+"\",function(data){ie.innerHTML=data;});");
		%>
		//if(ie.innerHTML=='')
		{
		}
	}else
	{
		im.style.display='';
		ie.style.display='none';
	}
}
</script>



