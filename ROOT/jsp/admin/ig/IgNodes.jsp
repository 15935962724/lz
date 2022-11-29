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
<%@page import="tea.entity.site.*"%>
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


java.util.Enumeration e=Node.findByType(1,teasession._strCommunity);
for(int j=1;j<=showcount&&e.hasMoreElements();j++)
{
  int node=((Integer)e.nextElement()).intValue();
  AccessMember obj_am=AccessMember.find(node,teasession._rv._strV);
  Node obj=Node.find(node);
  boolean isc=obj.isCreator(teasession._rv);
  if(isc||obj_am.isCreate()||obj_am.isAuditing())
  {
	int count=Node.countSons(node,teasession._rv);

	out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
	out.print("  <a target=_blank href=http://"+sn+"/servlet/Node?node="+node+" >"+obj.getSubject(teasession._nLanguage)+"　( "+count+" )</a>");
	if(isc||obj_am.isAuditing())
	{
		int count_r= Node.countRequests(node);
		if(count_r>0)
		out.print(" <a target=_blank href=http://"+sn+"/jsp/request/NodeRequests.jsp?community="+teasession._strCommunity+"&node="+node+">( 待批准"+count_r+"条 )</a>");
	}
	if(isc||obj_am.isCreate())
	{
        Category category = Category.find(node);
        int j3 = category.getCategory();
        String url;
        if (j3 >= 1024)
        {
            url="/jsp/type/dynamicvalue/EditDynamicValue.jsp";
        } else
        if (j3 == 34)
        {
        	url="/jsp/type/goods/SelectGoodsType.jsp";
        } else
        if ((j3 == 4 || j3 == 21 || j3 == 28 || j3 >= 50 || j3 == 30 || j3 == 34 || j3 == 39 || j3 == 40 || j3 == 41 || j3 == 42 || j3 == 44) && j3 != 70 && j3 != 64) //34->��Ʒ
        {
        	url="/jsp/type/" + Node.NODE_TYPE[j3].toLowerCase() + "/Edit" + Node.NODE_TYPE[j3] + ".jsp";
        } else
        {
        	url="/servlet/NewNode";
        }
		out.print(" <a target=_blank href=http://"+sn+url+"?NewNode=ON&community="+teasession._strCommunity+"&node="+node+jsessionid+">创建</a>");
	}
	out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
	if(count>0)
	{
	    java.util.Enumeration enumer_pro=Node.findSons(node,teasession._rv,0,5);
	    while(enumer_pro.hasMoreElements())
	    {
	      int id=((Integer)enumer_pro.nextElement()).intValue();
	      obj=Node.find(node);
	      out.print("<A href=http://"+sn+"/servlet/Node?node="+id+"&Language="+teasession._nLanguage+jsessionid+" target=_blank >"+obj.getSubject(teasession._nLanguage)+"</a><br>");
	    }
        out.print("...");
	}else
	{
		out.print("暂无信息...");
	}
	out.print("  </div>");
	out.print("</div>");
  }
}




%>


