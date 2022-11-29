<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.ProfileCondition"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
int pos = 0, count = 0, pagesize = 20;
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
int id = 0;
if (request.getParameter("id") != null && request.getParameter("id").length() > 0)
id = Integer.parseInt(teasession.getParameter("id"));
param.append("&id=").append(id);
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
String firstname = request.getParameter("firstname");
if (firstname != null && firstname.length() > 0) {
  sql.append(" AND t1.member IN(SELECT member FROM ProfileLayer WHERE firstname like " + DbAdapter.cite("%" + firstname + "%") + ")");
  param.append("&firstname=").append(java.net.URLEncoder.encode(firstname, "UTF-8"));
}
String member = request.getParameter("member");
if (member != null && member.length() > 0) {
  sql.append(" AND t1.member like " + DbAdapter.cite("%" + member + "%"));
  param.append("&member=").append(member);
}
String mobile = request.getParameter("mobile");
if (mobile != null && mobile.length() > 0) {
sql.append(" AND t1.member IN(SELECT member FROM Profile WHERE mobile like " + DbAdapter.cite("%" + mobile + "%") + ")");
  param.append("&mobile=").append(mobile);
}
String email = request.getParameter("email");
if (email != null && email.length() > 0) {
sql.append(" AND t1.member IN(SELECT member FROM Profile WHERE email like " + DbAdapter.cite("%" + email + "%") + ")");
  param.append("&email=").append(email);
}
count = ProfileCondition.count1(sql.toString());
teasession.getParameter("aa");
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script type="text/javascript" src="/tea/load.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script type="text/javascript">
      function del()
      {
        if(confirm("您确定要删除此会员吗？"))
        {    return true;  }
        else
        {    return false;  }
      }
      function c_jax(me)
      {
        currentPos = "show_"+me;
        send_request("/jsp/registration/EditCallers.jsp?valid="+me);
      }
function chp(me){
if(confirm("您确定要初始化该会员密码？"))
        {
          window.open('/jsp/registration/chp.jsp?member='+me,'anyname','width=300,height=200,top=300,left=300');
        }
        else
        {    return false;  }
}
      </script>
      </head>
      <body id="bodynone">
      <div id="tablebgnone" class="register">
        <h1>查询用户资料</h1>
        <div id="head6">
          <img height="6" src="about:blank" alt="">
        </div>
        <FORM name="form1" METHOD="POST" action="?">
          <input type="hidden" name="destine" value="">
          <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
          <input type="hidden" name="id" value="<%=id%>"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td>        用户姓名：
              <input type="text" name="firstname" value="<%if(firstname!=null)out.print(firstname);%>"/>
              &nbsp;&nbsp;&nbsp;
              会员ＩＤ：
              <input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/>
              &nbsp;&nbsp;&nbsp;&nbsp;<br>
                      手机号码：
              <input type="text" name="mobile" value="<%if(mobile!=null)out.print(mobile);%>"/>
              &nbsp;&nbsp;&nbsp;
              电子邮箱：
              <input type="text" name="email" value="<%if(email!=null)out.print(email);%>"/>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" value=" GO "/>
            </td>
          </tr>
          </table>
        </FORM>
        <h2>    用户列表(
        <%=count%>    )
        </h2>
        <form name="form2" action="">

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr id="tableonetr">
            <td nowrap>&nbsp;</td>
            <td nowrap>姓名</td>
            <td nowrap>会员ID</td>
            <td nowrap>登陆密码</td>
            <td nowrap>电话号码</td>
            <td nowrap>电子邮箱</td>
            <td colspan="3" align="center">操作</td>

          </tr>
          <%
          java.util.Enumeration e = ProfileCondition.findByCondition(sql.toString(),pos, pagesize);
          if (!e.hasMoreElements()) {
            out.print("<tr><td align=center colspan=7>经查询无此记录</td></tr>");
          }
          for (int i = 1; e.hasMoreElements(); i++) {
            String member1 = (String) e.nextElement();
            String valid = ProfileCondition.findValid(member1);
            Profile obj = Profile.find(member1);
            %>
            <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
              <td><%=i+pos %>
              </td>
              <td><%=obj.getFirstName(teasession._nLanguage)%>      </td>
              <td>
                <a href="/jsp/registration/ProfileView.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>"><%=obj.getMember()%>        </a>
              </td>
              <%
              StringBuffer sb = new StringBuffer();
              for(int p = 0; p < obj.getPassword().length(); p++){
                sb.append("*");
              }
              %>
              <td><%=sb.toString() %>      </td>
              <td><%=obj.getMobile()%>      </td>
              <td><%=obj.getEmail()%>

              </td>
               <td align="center" id="show_<%=member1%>">
               <%
                   if("0".equals(valid))
                   {
                     out.print(" <input type=\"button\" value=\"停用\" onclick=\"c_jax('"+member1+"')\"/>");
                   }else
                   {
                      out.print(" <input type=\"button\" value=\"启用\" onclick=\"c_jax('"+member1+"')\"/>");
                   }
               %>
                </td>
<td>
<input type="button" value="修改" onclick="window.open('/jsp/registration/edituser.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>','anyname','width=825,height=300');" >
</td>
<td>
<input type="button" value="初始化密码" onclick="return chp('<%=java.net.URLEncoder.encode(obj.getMember(), "UTF-8") %>');"/>
</td>
                <%--<td>
                  <!--<a href="/jsp/registration/edituser.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>&nexturl=<%=request.getRequestURL()%>">修改</a>-->
                  <a href="/jsp/registration/deleteprofile.jsp?member=<%=java.net.URLEncoder.encode(obj.getMember(),"UTF-8")%>" onclick="return del();">删除</a>
                </td>--%>

            </tr>
            <%}  %>
            <tr>
              <td colspan="10" align="center">
                <input id="aa" type="hidden" name="cjax"/>
                <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pagesize)%>      </td>
            </tr>
        </table>
        </form>
        <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
        <script language="JavaScript">
        anole('',1,'#F2F2F2','#DEEEDB','','');
        /*tr_tableid, // table id
        num_header_offset,// 表头行数
        str_odd_color, // 奇数行的颜色
        str_even_color,// 偶数行的颜色
        str_mover_color, // 鼠标经过行的颜色
        str_onclick_color // 选中行的颜色
        */
        </script>

      </body>
</html>
</html>
