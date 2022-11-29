<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");



TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl = teasession.getParameter("nexturl");
int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype= Integer.parseInt(teasession.getParameter("membertype"));
}
MemberType obj = MemberType.find(membertype);
RegisterInstall riobj = RegisterInstall.find(membertype);
Describes dbobj = Describes.find(membertype);


%>
<html>
<head>
<link href="/res/<%=obj.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="f_load();" topmargin="0" >
<script type="text/javascript">
function f_load()
{
  f_related('<%=riobj.getRelated()%>');
  f_verify('<%=riobj.getVerify()%>');
  f_payment('<%=riobj.getPayment()%>');
  autoSetiframeSize();

}
function autoSetiframeSize()
{
  //var   f=parent.document.all["main"];
  var   f=document.all["main"];
  var   b=f.Document.body;
  f.height=b.scrollHeight;
}

function f_related(el)
{
  whichEl =document.getElementById("relatedid");
  if (el==1) {
    whichEl.style.display = '';
  }
  if(el==0) {
    whichEl.style.display = 'none';
  }
}
function f_verify(el)
{
  whichEl =document.getElementById("menuurlid");
  if (el==1) {
    whichEl.style.display = '';
  }
  if(el==0) {
    whichEl.style.display = 'none';
  }
}

function f_payment(el)
{

  whichEl =document.getElementById("paymentid");
  if (el==1) {
    whichEl.style.display = '';
  }
  if(el==0) {
    whichEl.style.display = 'none';
  }

  var   f=document.all["main"];
  var   b=f.Document.body;
  f.height=b.scrollHeight;

}
</script>
<h1>注册设置</h1>
<form action="/servlet/EditMemberType" name="form1" >
<input type="hidden" name="act" value="RegisterInstall"/>
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=obj.getCommunity()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>A.是否需要条款声明</td>
    <td colspan="20"><input type="radio" name="clause" value="0"  <%if(riobj.getClause()==0)out.print("checked=\"checked\"");%>/>否&nbsp;&nbsp;&nbsp;<input type="radio" value="1" name="clause" <%if(riobj.getClause()==1)out.print("checked=\"checked\"");%>/>是</td>
  </tr>

  <tr>
    <td rowspan="21">B.注册信息选项</td>
    <td colspan="20">
      用&nbsp;&nbsp;户&nbsp;&nbsp;名&nbsp;<input type="checkbox" name="register" value="member" disabled="true" checked="checked"/>&nbsp;&nbsp;
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="member"><%if(dbobj.getMember()!=null)out.print(dbobj.getMember());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;<input type="checkbox" name="register" value="password" disabled="true" checked="checked"/>&nbsp;&nbsp;
    &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="password"><%if(dbobj.getPassword()!=null)out.print(dbobj.getPassword());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      确认密码&nbsp;<input type="checkbox" name="register" value="ConfirmPassword" disabled="true" checked="checked"/>&nbsp;&nbsp;
    &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="confirmpassword" ><%if(dbobj.getConfirmpassword()!=null)out.print(dbobj.getConfirmpassword());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      电子邮箱&nbsp;<input type="checkbox" name="register" value="email" <%if(riobj.getRegister()!=null){if(riobj.getRegister().indexOf("email")!=-1)out.print("checked=checked");} %> />&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectemail" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectemail")!=-1)out.print("checked=checked"); %> />&nbsp;&nbsp;
      描述信息&nbsp;<textarea cols="40" rows="1" name="email"><%if(dbobj.getEmail()!=null)out.print(dbobj.getEmail());%></textarea>
    </td>
  </tr>
  <tr>
    <td  colspan="20">
      姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;<input type="checkbox" name="register" value="firstname" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("firstname")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectfirstname" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectfirstname")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="firstname"><%if(dbobj.getFirstname()!=null)out.print(dbobj.getFirstname());%></textarea>
    </td>
  </tr>
  <tr>

    <td colspan="20">
      性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别&nbsp;<input type="checkbox" name="register" value="sex" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("sex")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" disabled="true" value="inspectsex" checked="checked" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectsex")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="sex"><%if(dbobj.getSex()!=null)out.print(dbobj.getSex());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      身份证号&nbsp;<input type="checkbox" name="register" value="card" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("card")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectcard" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectcard")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="card" ><%if(dbobj.getCard()!=null)out.print(dbobj.getCard());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      出生日期&nbsp;<input type="checkbox" name="register" value="birthyear" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("birthyear")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" disabled="true" checked="checked" value="inspectbirthyear" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectbirthyear")!=-1)out.print("checked=checked"); %> />
    &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="birthyear"><%if(dbobj.getBirthyear()!=null)out.print(dbobj.getBirthyear());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      省&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份&nbsp;<input type="checkbox" name="register" value="state" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("state")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectstate" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectstate")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="state"><%if(dbobj.getState()!=null)out.print(dbobj.getState());%></textarea>
    </td>
  </tr>

  <tr>
    <td colspan="20">
      通信地址&nbsp;<input type="checkbox" name="register" value="address" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("address")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectaddress" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectaddress")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="address"><%if(dbobj.getAddress()!=null)out.print(dbobj.getAddress());%></textarea>
    </td>
  </tr>
  <tr>

    <td colspan="20">
      手&nbsp;&nbsp;机&nbsp;&nbsp;号&nbsp;<input type="checkbox" name="register" value="phonenumber" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("phonenumber")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectphonenumber" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectphonenumber")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="phonenumber"><%if(dbobj.getPhonenumber()!=null)out.print(dbobj.getPhonenumber());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编&nbsp;<input type="checkbox" name="register" value="zip" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("zip")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectzip" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectzip")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="zip"><%if(dbobj.getZip()!=null)out.print(dbobj.getZip());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话&nbsp;<input type="checkbox" name="register" value="telephone" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("telephone")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspecttelephone" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspecttelephone")!=-1)out.print("checked=checked"); %> />
  &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="telephone"><%if(dbobj.getTelephone()!=null)out.print(dbobj.getTelephone());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真&nbsp;<input type="checkbox" name="register" value="fax" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("fax")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectfax" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectfax")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="fax"><%if(dbobj.getFax()!=null)out.print(dbobj.getFax());%></textarea>
    </td>
  </tr>
   <tr>
    <td colspan="20">
      职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称&nbsp;<input type="checkbox" name="register" value="position" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("position")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectposition" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectposition")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="position"><%if(dbobj.getPosition()!=null)out.print(dbobj.getPosition());%></textarea>
    </td>
  </tr>
    <tr>
    <td colspan="20">
      单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位&nbsp;<input type="checkbox" name="register" value="organization" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("organization")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectorganization" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectorganization")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="organization"><%if(dbobj.getOrganization()!=null)out.print(dbobj.getOrganization());%></textarea>
    </td>
  </tr>
  <tr>
    <td colspan="20">
      科室(部门)&nbsp;<input type="checkbox" name="register" value="section" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("section")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectsection" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectsection")!=-1)out.print("checked=checked"); %> />
      &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="section"><%if(dbobj.getSection()!=null)out.print(dbobj.getSection());%></textarea>
    </td>
  </tr>
   <tr>
    <td colspan="20">
      学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历&nbsp;<input type="checkbox" name="register" value="degree" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("degree")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectdegree" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectdegree")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="degree"><%if(dbobj.getDegree()!=null)out.print(dbobj.getDegree());%></textarea>
    </td>
  </tr>
  

  <tr>
    <td colspan="20">
      验&nbsp;&nbsp;证&nbsp;&nbsp;码&nbsp;<input type="checkbox" name="register" value="vertify" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("vertify")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectvertify" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectvertify")!=-1)out.print("checked=checked"); %> />
    &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="vertify"><%if(dbobj.getVertify()!=null)out.print(dbobj.getVertify());%></textarea>
    </td>
  </tr>
  
  
   <tr>
    <td colspan="20">
      国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;籍&nbsp;<input type="checkbox" name=register value="Country" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("Country")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectCountry" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectCountry")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="Country"><%if(dbobj.getCountry()!=null)out.print(dbobj.getCountry());%></textarea>
    </td>
  </tr>
  
   <tr>
    <td colspan="20">
      目前身份&nbsp;<input type="checkbox" name=register value="identitys" <%if(riobj.getRegister()!=null)if(riobj.getRegister().indexOf("identitys")!=-1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      是否验证&nbsp;<input type="checkbox" name="inspect" value="inspectidentitys" <%if(riobj.getInspect()!=null)if(riobj.getInspect().indexOf("inspectidentitys")!=-1)out.print("checked=checked"); %> />
   &nbsp;&nbsp;描述信息&nbsp;<textarea cols="40" rows="1" name="identitys"><%if(dbobj.getIdentitys()!=null)out.print(dbobj.getIdentitys());%></textarea>
    </td>
  </tr>

  <tr>  
    <td>C.用户名限制</td>
    <td colspan="20">
      无限制&nbsp;<input type="radio" name="restrictions" value="0" <%if(riobj.getRestrictions()==0)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      必须是邮箱&nbsp;<input type="radio" name="restrictions" value="1" <%if(riobj.getRestrictions()==1)out.print("checked=checked"); %>/>&nbsp;&nbsp;
      必须是手机&nbsp;<input type="radio" name="restrictions" value="2" <%if(riobj.getRestrictions()==2)out.print("checked=checked"); %>/>
    </td>
  </tr>
  <tr>
    <td>D.是否关联填写类别信息</td>
    <td colspan="20">
      否&nbsp;<input type="radio" name="related" value="0" <%if(riobj.getRelated()==0)out.print("checked=checked"); %> onclick="f_related('0');"/>&nbsp;&nbsp;
      是&nbsp;<input type="radio" name="related" value="1" <%if(riobj.getRelated()==1)out.print("checked=checked"); %> onclick="f_related('1');"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <span id="relatedid" style="display:none">
        <select name="relatednews">
          <option value="0">-------------</option>
          <option value="21" <%if(riobj.getRelatednews()==21)out.print(" selected");%>>公司</option>
          <%
          Enumeration e=Dynamic.find(" and community="+DbAdapter.cite(obj.getCommunity()));
          while(e.hasMoreElements())
          {
            int id = ((Integer)e.nextElement()).intValue();
            Dynamic d = Dynamic.find(id);
            out.print("<option value="+id);
            if(riobj.getRelatednews()==id)
            out.print("  selected");
            out.print(">"+d.getName(teasession._nLanguage));
            out.print("</option>");
          }

          %>
          </span>



        </select>
        &nbsp;&nbsp;&nbsp;类别信息存放位置节点:&nbsp;&nbsp;<input type="text" name="fathernode" value="<%if(riobj.getFathernode()!=0)out.print(riobj.getFathernode());%>" />
    </td>
  </tr>

  <tr>
    <td>E.生成注册按钮路径</td>
    <td colspan="20"><input type="text" name="buttonurl"  value="/jsp/mov/Transfer.jsp?community=<%=obj.getCommunity()%>&membertype=<%=membertype%>" size="70" readonly/></td>
  </tr>

  <tr>
    <td>F.是否需要审核</td>
    <td colspan="20">
      否&nbsp;<input type="radio" name="verify" value="0" <%if(riobj.getVerify()==0)out.print("checked=checked"); %> onclick="f_verify('0');"/>&nbsp;&nbsp;
      是&nbsp;<input type="radio" name="verify" value="1" <%if(riobj.getVerify()==1)out.print("checked=checked"); %> onclick="f_verify('1');"/>&nbsp;&nbsp;
      <span id="menuurlid" style="display:none">
        审核菜单路径 <input type="text" name="menuurl" value="/jsp/mov/MemberVerify.jsp?community=<%=obj.getCommunity()%>&membertype=<%=membertype%>" size="50" readonly="readonly" />
      </span>
    </td>
  </tr>

  <tr>
    <td>G.是否缴费</td>
    <td colspan="20">
      否&nbsp;<input type="radio" name="payment" value="0" <%if(riobj.getPayment()==0)out.print("checked=checked"); %> onclick="f_payment('0');"/>&nbsp;&nbsp;
      是&nbsp;<input type="radio" name="payment" value="1" <%if(riobj.getPayment()==1)out.print("checked=checked"); %> onclick="f_payment('1');"/>&nbsp;&nbsp;
    </td>
  </tr>


  <tbody id="paymentid" style="display:none">

    <tr>
      <td colspan="20"><input type="button" value="添加缴费金额"  onclick="window.showModalDialog('/jsp/mov/EditPay.jsp?membertype=<%=membertype%>',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:600px;dialogHeight:300px;');";></td>
    </tr>
    <tr>
      <td colspan="20"><iframe   src="/jsp/mov/PayList.jsp?membertype=<%=membertype%>" name="main"   width="100%"  frameborder="0" scrolling=no ></iframe></td>
    </tr>


  </tbody>







</table>
<input type="submit" value="提交信息" />&nbsp;&nbsp;&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
</form>


</body>
</html>
