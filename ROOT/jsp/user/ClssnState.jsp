<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.integral.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>

<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String show[]=request.getParameterValues("show");
if(show==null)
	show=new String[]{"username"};
if(teasession._rv!=null)
{
	String member=teasession._rv._strV;
	Profile p=Profile.find(member);
	for(int i=0;i<show.length;i++)
	{
		out.print("<SPAN ID="+show[i]+" >");
		if("member".equals(show[i]))
			out.print(member);
		else if("username".equals(show[i])){
                  if(teasession._strCommunity.equals("china-corea")||teasession._strCommunity.equals("ycserver")){
                    tea.entity.admin.AdminUsrRole aur = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,member);

                if(aur.getRole().length()<2){
                  ProfileZh pz = ProfileZh.find(member);
                  out.print(pz.getName());
                }else{out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));}
                  }else{
                    out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
                  }
                }
		else if("email".equals(show[i]))
			out.print(p.getEmail());
		else if("jifen".equals(show[i]))
			{out.print("　积分:");
			out.print(p.getIntegral());
			}
		else if("photo".equals(show[i]))
			out.print("<IMG SRC="+p.getPhotopath(teasession._nLanguage)+" >");
		out.print("</SPAN>");
	}
	
	//个人中心

	
	  tea.entity.admin.AdminUsrRole aur = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
	
	//判断权限
	  boolean bool = false;
	  	AdminUsrRole aurobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
	  
	  	if(aurobj.getRole()!=null && aurobj.getRole().length()>0&&!"/0/".equals(aurobj.getRole()))
	  	{
	  		for(int i=1;i<aurobj.getRole().split("/").length;i++)
	  		{
	  			AdminRole adminrole = AdminRole.find(Integer.parseInt(aurobj.getRole().split("/")[i]));
	  			
	  				if(aurobj.getRole().split("/").length<=2){
	  					
			  			if(adminrole.getName()!=null && ( adminrole.getName().indexOf("理事会")!=-1 || adminrole.getName().indexOf("金牌")!=-1))
			  			{
			  			 
			  				bool = true; 
			  				 
			  				continue;
			  			}
	  				}
	  			
	  		}
	  	}else
	  	{
	  		
	  		bool = true; 
	  	}
	  	
	  

	  	
	  
	
	
	 
	
	  if(aur.isExists()&&aur.getRole().split("/").length>=1&&!bool){//如果有角色 
		 out.print("<span id =memberadmin>");
		 out.print("<a href=\"/jsp/admin/clssnindextop.jsp\" target=\"_parent\" class=\"login1\">管理中心</a>");
		 out.print("</span>");
	  }else
	  { 
			out.print("<span id =memberpersonal>");
			out.print("<a href=\"/jsp/admin/indexmember.jsp\" target=\"_parent\" class=\"login1\">个人中心</a>");
			out.print("</span>");
	  }
}

%>

<%
 Profile profile=Profile.find(teasession._rv._strV);
 CommunityPoints cp= CommunityPoints.find(CommunityPoints.getIgid(teasession._strCommunity));
 ProfileOrth po=ProfileOrth.find(profile.getMember());

if(po.getMember().equals("")&&profile.getIntegral()>=cp.getSjhyjf()&&cp.getSjhyjf()>0)
 {
 %>

 <div id="update">
 恭喜您！您的积分已经超过<%= cp.getSjhyjf()%>分，可以升级为本站高级会员了。
 <div><a href="/jsp/orth/agreement.jsp">现在就升级</a>　　　　<a href="#" onclick="update.style.display='none';">关闭</a></div>
  </div>
 <%
 } %>

<!--
使用说明:
显示当前会员姓名:<include src="/jsp/user/State.jsp"/>  或 <include src="/jsp/user/State.jsp?show=username"/>
显示当前会员Id: <include src="/jsp/user/State.jsp?show=member"/>
show的参数可以任意组合,显示的顺序就是按参数写的顺序
如下:
显示当前会员Email和头像:<include src="/jsp/user/State.jsp?show=email&show=photo"/>
-->
