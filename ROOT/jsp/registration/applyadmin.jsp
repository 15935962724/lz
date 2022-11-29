<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.*"%>
<%
  //在页面中设置不缓存
  response.setHeader("Pragma", "No-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
  response.setHeader("Pragma", "No-cache");
  response.setHeader("Cache-Control", "no-cache");
  TeaSession teasession = new TeaSession(request);
  if(teasession.getParameter("has")!=null)
  {
    out.println("<script>alert('用户名已存在!')</script>");
  }
  Community community = Community.find(teasession._strCommunity);
  String member = "";
  if (teasession._rv != null) {
    boolean back = AdminUsrRole.isExist(" AND member LIKE '%" + teasession._rv._strR + "%' AND role LIKE '%" + 2 + "%'");
    member = teasession._rv._strR;
    AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity, member);
    if (!back) {
      out.println("<script>alert('您不是酒店管理者!');</script>");
      return;
    }
  }
  String role = teasession.getParameter("role");
  int node = 12;
  String act = request.getParameter("act");
  if (act != null && act.length() > 0) {
    String value = request.getParameter("value");
    if (act.equals("member")) {
      try {
        out.print(!Profile.isExisted(value) && !Hotel_application.isExist(value) && !Hotel_application.isLayerExist(value));
      }
      catch (Exception ex) {
        System.out.println(ex.toString());
      }
    }
    return;
  }
  AdminUsrRole adminur = new AdminUsrRole();
  Profile pro = new Profile();
  Hotel_application ha = new Hotel_application();
  if (member != null && member.length() > 0) {
    adminur = AdminUsrRole.find(teasession._strCommunity, member);
    pro = Profile.find(member);
    ha = Hotel_application.find(member);
  }
%>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="text/javascript">
function check(form)
{if(
submitText(form.firstname,'无效-公司名称')
&&submitText(form.member,'无效-登陆ID')
&&submitText(form.password,'无效-密码')
&&submitText(form.password_1,'无效-确认密码')
&&submitEqual(form.password,form.password_1,'两次密码输入不一致')
&&submitText(form.linkmanname,'无效-联系人')
&&submitText(form.phone,'无效-电话')
&&submitText(form.fax,'无效-传真')
&&submitText(form.email,'无效-邮箱')
&&submitEmail(form.email,'无效-邮箱')
&&submitText(form.mobile,'无效-手机')
&&submitInteger(form.mobile,'无效-手机')
&&submitLength(11,12,form.mobile,'无效-手机')
&&submitText(form.cardtype,'无效-证件类型')
&&submitText(form.card,'无效-证件号码')
&&submitText(form.introduce,'无效-申请说明')
&&submitText(form.picture,'无效-资质证明文件')
&&submitText(form.manage_type,'无效-管理者类型')
&&submitCheckbox(form.acceptterm,'请阅读协议')
)
  {
      form.path.value=form.picture.value;
     if(document.getElementById("member").value!=null&&document.getElementById("member").value.length>0)
     {
      if(document.getElementById("oldpassword").value!=document.getElementById("opassword").value)
      {
        alert("您的旧密码输入错误,请重新输入!");
        return false;
      }
     }
    if(document.getElementById('cardtype').value=='0')
        {
          var len = document.getElementById('card').value.length;
          if(len==15||len==18){}else{
            alert('无效-身份证');
            return false;
          }
       }
  }else
  {
	return false;
  }
}
function f_ajax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  if(obj.value=="")
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  sendx("?act="+act+"&value="+obj.value,function(v)
  {
    if(v.indexOf('true')!=-1)
    {
      if(obj.name=="member")
      {
        sv.innerHTML="<img src=/tea/image/public/check_right.gif>用户名可用";
      }
    }else
    {
      if(obj.name=="member")
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>用户名已存在";
      }
      else if(obj.name=="firstname")
      {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>姓名已存在";
      }
      else
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>输入错误!请重新输入";
      }
    }
  }
  )
}
 </script>
<div id="tablebgnone" class="register">
  <h1>酒店管理员注册信息</h1>
  <FORM name="foEdit" METHOD="POST" action="/servlet/ApplyAdmin" onsubmit="return check(this);" enctype="multipart/form-data">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <input type="hidden" name="role" value="<%=role%>"/>
  <%if (member != null && member.length() > 0) {  %>
  <input type="hidden" name="editadmin" value="editadmin"/>
  <%}  %>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr id="type_0">
      <td id="type_1">*公司名称：</td>
      <td>
        <input type="TEXT" class="edit_input" name="firstname" size="30" maxlength="40" value="<%if(member!=null&&member.length()>0){if(pro.getFirstName(teasession._nLanguage)!=null)out.println(pro.getFirstName(teasession._nLanguage));}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*登陆ID：</td>
      <td>
      <%if (member != null && member.length() > 0) {      %>
<%=member%>        <input type="hidden" name="member" value="<%=member%>"/>
      <%} else {      %>
        <input type="text" class="edit_input" name="member" size="30" onChange="f_ajax(this)" value="<%if(member!=null&&member.length()>0){if(pro.getMember()!=null)out.println(pro.getMember());}%>"/>
      <%}      %>
        <span id="span_member"></span>
      </td>
    </tr>
  <%if (member != null && member.length() > 0) {  %>
    <tr id="type_0">
      <td>*原密码</td>
      <td>
        <input type="password" class="edit_input" id="oldpassword" name="oldpassword" size="30" maxlength="20">
        <input type="hidden" id="opassword" class="edit_input" name="opassword" size="30" maxlength="20" value="<%if(member!=null&&member.length()>0)out.print(pro.getPassword().trim());%>"/>
      </td>
    </tr>
  <%}  %>
    <tr id="type_0">
      <td id="type_1">*密码：</td>
      <td>
        <input type="password" class="edit_input" name="password" size="30" maxlength="20">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*确认密码：</td>
      <td>
        <input type="password" class="edit_input" name="password_1" size="30" maxlength="20">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*联系人：</td>
      <td>
        <input type="text" class="edit_input" name="linkmanname" size="30" value="<%if(member!=null&&member.length()>0){if(ha.getLinkManName()!=null)out.print(ha.getLinkManName());}%>"/>
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*电话：</td>
      <td>
        <input type="TEXT" class="edit_input" name="phone" size=30 maxlength=40 value="<%if(member!=null&&member.length()>0){if(ha.getPhone()!=null)out.println(ha.getPhone());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*传真：</td>
      <td>
        <input type="TEXT" class="edit_input" name="fax" size=30 maxlength=40 value="<%if(member!=null&&member.length()>0){if(ha.getFax()!=null)out.println(ha.getFax());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*邮箱：</td>
      <td>
        <input type="TEXT" class="edit_input" name="email" size=30 maxlength=40 value="<%if(member!=null&&member.length()>0){if(pro.getEmail()!=null)out.println(pro.getEmail());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*手机：</td>
      <td>
        <input type="TEXT" class="edit_input" name="mobile" size=30 maxlength=40 value="<%if(member!=null&&member.length()>0){if(pro.getMobile()!=null)out.println(pro.getMobile());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">QQ：</td>
      <td>
        <input type="TEXT" class="edit_input" name="qq" size="30" maxlength="40" value="<%if(member!=null&&member.length()>0){if(ha.getQq()!=null)out.println(ha.getQq());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">MSN：</td>
      <td>
        <input type="TEXT" class="edit_input" name="msn" size="30" maxlength="40" value="<%if(member!=null&&member.length()>0){if(ha.getMsn()!=null)out.println(ha.getMsn());}%>">
      </td>
    </tr>
    <tr id="type_0">
    <%
      int type = 0;
      if (member != null && member.length() > 0) {
        type = pro.getCardType();
      }
    %>
      <td id="type_1">*证件类型:</td>
      <td>
        <select name="cardtype" id="cardtype">
        <%
          for (int i = 0; i < Common.CARDT_TYPE.length; i++) {
            out.println("<option value=" + (i));
            if (type == i)
              out.println("selected");
            out.println(">" + Common.CARDT_TYPE[i]);
            out.println("</option>");
          }
        %>
        </select>
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*证件号码:</td>
      <td>
        <input name="card" type="text" class="edit_input" size="30" id="card" value="<%if(member!=null&&member.length()>0){if(pro.getCard()!=null)out.println(pro.getCard());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*申请说明：</td>
      <td>
        <input type="TEXT" class="edit_input" name="introduce" size=30 maxlength=20 value="<%if(member!=null&&member.length()>0){if(ha.getIntroduce()!=null)out.println(ha.getIntroduce());}%>">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*资质证明文件：</td>
      <td>
        <input name="picture" type="file" class="edit_input2" size="30" value="">
      <%
        if (member != null && member.length() > 0) {
          if (ha.getDocuments() != null) {
      %>
        长度：
<%=ha.getDocuments().getBytes().length %>
        Bytes
        操作：
        <a href="/jsp/registration/doc.jsp?path=<%=ha.getDocuments()%>">下载</a>
      <%}}      %>
        <input type="hidden" name="path"/>
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*管理者类型：</td>
      <td>
      <%
        int mtype = 0;
        if (member != null && member.length() > 0) {
          mtype = ha.getManage_type();
        }
      %>
        <select name="manage_type">
          <option value="" <%if(mtype==0)out.println("selected");%>>---------</option>
          <option value="1" <%if(mtype==1)out.println("selected");%>>酒店直营</option>
          <option value="2" <%if(mtype==2)out.println("selected");%>>代理商</option>
        </select>
      </td>
    </tr>
    <tr>
      <td colspan="4" align="center" id="denglu_tk">
        <input name="acceptterm" type="checkbox" value="1" checked="checked">
        我已经阅读并接受
        <a href="/jsp/registration/SignUp.jsp" target="_blank" class="blue_xhx"><font color="red"><b>酒店管理员注册用户协议</b></font></a>
      </td>
    </tr>
    <tr>
      <td colspan="4" align="center" id="denglu_an">
      <%if (member != null && member.length() > 0) {      %>
        <input type="submit" name="edit" value="修改"/>
        <a href="#" onClick="javascript:history.back()">
          <img src="/res/jiudian/u/0803/080314081.jpg" alt="返回">
        </a>
      <%} else {      %>
        <input type="image" src="/res/jiudian/u/0802/080250264.jpg" class="edit_button" id="edit_submit" value=" 注册 ">
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" onClick="javascript:history.back()">
          <img src="/res/jiudian/u/0803/080314081.jpg" alt="返回">
        </a>
      <%}      %>
      </td>
    </tr>
  </table>
  </FORM>
</div>
