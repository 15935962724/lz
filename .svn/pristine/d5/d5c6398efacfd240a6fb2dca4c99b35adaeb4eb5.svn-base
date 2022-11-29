<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);



String[] buys = (String[])session.getAttribute("buys");

String vertify=(String)session.getAttribute("sms.vertify");
String vertify1 = request.getParameter("vertify").trim();
String nexturl = teasession.getParameter("nexturl");

String act = teasession.getParameter("act");
String member = null;
if("log".equals(act))//登陆
{
  String s2 = request.getParameter("member");
  String epassword=request.getParameter("epassword");
  if(!Profile.isExisted(s2))//用户不存在，请您注册后登陆！
  {

     out.println("<script>alert('用户不存在，请您注册后登陆！'); parent.document.formlog1.member.select(); var obj=parent.document.all('logname'); obj.disabled=false; obj.value='登录';</script>");
     return;
  }
  if (!Profile.isPassword(s2, epassword)) // lt,密码不正确，请您确认后登录
  {
     out.println("<script>alert('密码不正确，请您确认后登录！'); parent.document.formlog1.epassword.select(); var obj=parent.document.all('logname'); obj.disabled=false; obj.value='登录';</script>");
     return;
  }
   member=s2;
}
else if("edit".equals(act))//注册用户
{
  if (!vertify1.equals(vertify)&&!vertify1.equals("vertify"))//验证码 判断
  {
    out.println("<script>alert('验证码不正确，请重新添加！'); parent.document.formlog1.vertify.select(); var obj=parent.document.all('editname'); obj.disabled=false; obj.value='快速提交';</script>");
    return;
  }

  String s1 = request.getParameter("MemberId").trim().toLowerCase();

  if(Profile.isExisted(s1))//如果有重复用户名，不让注册，跳转提示！
  {
    out.println("<script>alert('用户名已经存在，请您重新填写用户名！'); parent.document.formlog1.MemberId.select(); var obj=parent.document.all('editname'); obj.disabled=false; obj.value='快速提交';</script>");
    return;
  }

  String password = request.getParameter("ConfirmPassword").trim();//密码
  String email = request.getParameter("Email").trim();//Email电子邮箱
  Profile.create(s1,password,teasession._strCommunity,email, null,0, teasession._nLanguage, null, null, null, null, null, null, null, null, null,null, null,null);

  member=s1;
}

RV rv=new RV(member);
Log.create(teasession._strCommunity, rv, 1, teasession._nNode, request.getRemoteAddr());//登录历史
OnlineList ol_obj = OnlineList.find(session.getId());
ol_obj.setMember(member);
session.setAttribute("tea.RV", rv);//登录 session

String[] buys2 = new String[buys.length];
for(int i = 0;i<buys.length;i++)
{
  int scid = Integer.parseInt(buys[i]);
  ShoppingCarts scobj = ShoppingCarts.find(scid);
  int buy = Buy.find(rv,scobj.getNode(),scobj.getCommodity(),scobj.getCurrency());

  if(buy > 0) // 如果购物车中已经存在,则 只修改数量
  {
    Buy obj = Buy.find(buy);
    obj.set(obj.getQuantity() + scobj.getQuantity());
  } else
  {
    Buy.create(teasession._strCommunity,rv,scobj.getNode(),scobj.getCommodity(),scobj.getCurrency(),scobj.getPrice(),scobj.getQuantity());
  }
    int b = Buy.find(rv,scobj.getNode());
   buys2[i]=String.valueOf(b);
  scobj.delete();
}
session.setAttribute("buys2",buys2);

out.print("<script   language='javascript' >alert('登录成功');parent.location='/jsp/offer/CheckoutCart1.jsp?currency=1&act=buys2&nexturl="+nexturl+"';</script>");
//response.sendRedirect("/jsp/offer/CheckoutCart1.jsp");
//return;

%>

