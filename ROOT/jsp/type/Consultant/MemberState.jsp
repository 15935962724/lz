<%@page import="tea.entity.site.Community"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="java.util.*" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="tea.entity.bbs.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %><%

  Http h=new Http(request);

  if(h.member<1)
  {
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
  }
  int type=1;
  Profile pobj = Profile.find(h.member);
  if(pobj.getType()==2){
	  type=0;
  }
  if(pobj.getPMMJ()==1){
	  type=2;
	  if(!pobj.isValidate()){
		  type=3;
	  }
  }

  Community c = Community.find(Node.find(h.node).getCommunity());
  out.print("<span>"+pobj.getMember()+"</span><span>　欢迎您登录"+c.getName(h.language)+"！</span><span id='mtypeshow' style='display:none'>"+type+"</span>");
  
  AdminUsrRole aur = AdminUsrRole.find(h.community,h.member);
  if(aur.isExists()&&aur.getRole().length()>1){
	  out.print("　<a href='/jsp/admin/indextop.jsp' class='a1'>[后台管理]</a>");
  }else{
	  out.print("　<a href='/html/Home/folder/14090224-1.htm' class='a1'>[个人中心]</a>");
  }
  
  out.print("　 <a onclick=\"addToFavorite()\" style=\"cursor:pointer;\">加入收藏</a>　|　<a onclick=\"SetHome(this,'http://112.124.110.45/');\" href=\"javascript:void(0);\">设为首页</a>　<a href='/servlet/Logout?community="+h.community+"&nexturl=/'>[退出]</a>");
%>
<script type="text/javascript">
function addToFavorite(){
	var a="http://www.pmeer.com/";
	var b="<%=c.getName(h.language)%>";
	if(document.all){
		window.external.AddFavorite(a,b);
	}else if(window.sidebar){
		window.sidebar.addPanel(b,a,"");
	}else{
		alert("亲，您的浏览器不支持此操作\n请直接使用Ctrl+D收藏本站~");
	}
}

function SetHome(obj,url){
    try{
        obj.style.behavior='url(#default#homepage)';
       obj.setHomePage(url);
   }catch(e){
       if(window.netscape){
          try{
              netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
         }catch(e){
              alert("抱歉，此操作被浏览器拒绝！\n\n请在浏览器地址栏输入“about:config”并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
          }
       }else{
        alert("抱歉，您所使用的浏览器无法完成此操作。\n\n您需要手动将【"+url+"】设置为首页。");
       }
  }
}


</script>

