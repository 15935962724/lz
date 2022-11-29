<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%
TeaSession teasession = new TeaSession(request);
if(request.getParameter("cardtype")==null)
{}
else
{request.setCharacterEncoding("UTF-8");
  String member = request.getParameter("member");
  String password = request.getParameter("password");
  String password_1 = request.getParameter("password_1");
  String firstname = request.getParameter("firstname");
  boolean sex = Boolean.parseBoolean(request.getParameter("sex"));
  int sex_1 = Integer.parseInt(request.getParameter("sex"));
  String telephone = request.getParameter("telephone");
  String cardt = request.getParameter("cardtype");
  out.print(cardt);
  int cardtype = Integer.parseInt(cardt) ;
  System.out.print(cardtype);
  String card = request.getParameter("card");
  String email = request.getParameter("email");
  try
  {
    if(!Profile.isExisted(member))
    {
      Profile obj =Profile.create(member,teasession._strCommunity,password,sex_1,card,cardtype,firstname,telephone,email, teasession._nLanguage);
      obj.setFirstName(firstname,teasession._nLanguage);
      obj.setTelephone(telephone,teasession._nLanguage);
      obj.setSex(sex);
      obj.setTelephone(telephone,teasession._nLanguage);
      obj.setCardType(cardtype);
      obj.setCard(card);
      obj.setEmail(email);
      response.sendRedirect("/jsp/info/Succeed.jsp?info="+"Success!");
    }else
    {
      response.sendRedirect("/jsp/info/Succeed.jsp?info="+"This Name Has Exist!");
    }
    return;
  }
  catch(Exception ex)
  {
    out.print(ex.toString());
  }
}
//Resource r = new Resource("/tea/ui/util/SignUp");
%>
