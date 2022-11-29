<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.Properties" %>
<%@page import="java.io.File" %><%@page import="tea.resource.Resource" %><%@page import="java.io.FileInputStream" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String vertify=(String)session.getAttribute("sms.vertify");
String vertify1 = request.getParameter("vertify").trim();

Resource r = new Resource("/tea/ui/node/type/sms/EditUser");


String act = request.getParameter("act");

String member =null;
if("edit".equals(act))//注册用
{
  if (!vertify1.equals(vertify)&&!vertify1.equals("vertify"))//验证码 判断
  {
    out.println("<script>alert('验证码不正确，请重新添加！'); parent.document.form1.vertify.select(); var obj=parent.document.all('editname'); obj.disabled=false; obj.value='快速提交';</script>");
    return;
  }

  String s1 = request.getParameter("MemberId").trim().toLowerCase();

  if(Profile.isExisted(s1))//如果有重复用户名，不让注册，跳转提示！
  {
     out.println("<script>alert('用户名已经存在，请您重新填写用户名！'); parent.document.form1.MemberId.select(); var obj=parent.document.all('editname'); obj.disabled=false; obj.value='快速提交';</script>");
     return;
  }

  String password = request.getParameter("ConfirmPassword").trim();//密码
  String email = request.getParameter("Email").trim();//Email电子邮箱
  Profile.create(s1,password,teasession._strCommunity,email, null,0, teasession._nLanguage, null, null, null, null, null, null, null, null, null,null, null,null);

  member=s1;
} else if("log".equals(act))//登陆
{
  String s2 = request.getParameter("member");
  String epassword=request.getParameter("epassword");
  if(!Profile.isExisted(s2))//用户不存在，请您注册后登陆！
  {

     out.println("<script>alert('用户不存在，请您注册后登陆！'); parent.document.form1.member.select(); var obj=parent.document.all('logname'); obj.disabled=false; obj.value='登录';</script>");
     return;
  }
  if (!Profile.isPassword(s2, epassword)) // lt,密码不正确，请您确认后登录
  {
     out.println("<script>alert('密码不正确，请您确认后登录！'); parent.document.form1.epassword.select(); var obj=parent.document.all('logname'); obj.disabled=false; obj.value='登录';</script>");
     return;
  }
   member=s2;
}
            RV rv=new RV(member);
            Log.create(teasession._strCommunity, rv, 1, teasession._nNode, request.getRemoteAddr());//登录历史
            OnlineList ol_obj = OnlineList.find(session.getId());
            ol_obj.setMember(member);
            session.setAttribute("tea.RV", rv);//登录 session
            String acts = request.getParameter("acts");
            if("g".equals(acts))//加入购物车
            {
               out.print("<script   language='javascript' >alert('登录成功');window.dialogArguments.showDialog('加入购物车','/servlet/OfferBuy?node=" + request.getParameter("Node") + "&commodity=" + request.getParameter("commodity") + "&currency=" + request.getParameter("currency") + "&quantity=1');window.close(); </script>");
            }else if("s".equals(acts))//加入收藏
            {
              out.print("<script   language='javascript' >alert('登录成功'); window.dialogArguments.showDialog('加入收藏','/servlet/OfferCollect?node="+ request.getParameter("Node") +"');window.close(); </script>");
            }

%>

