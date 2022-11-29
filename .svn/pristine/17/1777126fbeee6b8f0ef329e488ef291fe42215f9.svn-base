<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Http h=new Http(request);
int role=h.getInt("role");

if("POST".equals(request.getMethod()))
{
  String member=request.getParameter("newmember");
  String password=request.getParameter("password");
  String email=request.getParameter("email");
  if(member!=null)
  {
    if(Profile.isExisted(member))
    {
      out.print("<script>alert('用户名 已存在! 请更换用户名.');</script>");
      return;
    }
    Profile.create(member,password,teasession._strCommunity,email,request.getServerName());
  }else
  {
    member=request.getParameter("member");
  }
  String name=request.getParameter("name");
  boolean sex="true".equals(request.getParameter("sex"));
  int adminunit=Integer.parseInt(request.getParameter("adminunit"));
  String telephone=request.getParameter("telephone");
  String mobile=request.getParameter("mobile");
  String address=request.getParameter("address");
  Profile p=Profile.find(member);
  p.setEmail(email);
  if(!"********".equals(password))p.setPassword(password);
  p.setSex(sex);
  p.setTelephone(telephone,teasession._nLanguage);
  p.setMobile(mobile);
  p.setAddress(address,teasession._nLanguage);
  p.setFirstName(name,teasession._nLanguage);
  //
  String golf=request.getParameter("golf");
  AdminUsrRole ar=AdminUsrRole.find(teasession._strCommunity,member);
  ar.setUnit(adminunit);
  ar.setGolf(golf);
  ar.setRole("/"+role+"/");
  out.print("<script>parent.location.href='/jsp/type/golf/GolfRole.jsp?community="+teasession._strCommunity+"&role="+role+"';</script>");
  return;
}


Resource r=new Resource().add("/tea/resource/deptuser");

String nexturl=teasession.getParameter("nexturl");

String member=teasession.getParameter("member");
String firstname=null,password=null,lastname=null,email=null;
boolean sex=true;
String golf="/";
int raclass = 0,wagetype=0,polity=-1;
boolean option1=false;
String job,title,birth,fax,etime,telephone,mobile,functions,address,photopath2,degree;
long len=0L;
if(member!=null&&member.length()>0)
{
  Profile p=Profile.find(member);
  firstname=p.getName(teasession._nLanguage);
  email=p.getEmail();
  sex=p.isSex();
  password="********";
  raclass = p.getRclass();
  wagetype= p.getWagetype();
  job=p.getJob(teasession._nLanguage);
  birth=p.getBirthToString();
  fax=p.getFax(teasession._nLanguage);
  telephone=p.getTelephone(teasession._nLanguage);
  mobile=p.getMobile();
  address=p.getAddress(teasession._nLanguage);
  title=p.getTitle(teasession._nLanguage);
  etime=p.getETimeToString();
  functions=p.getFunctions(teasession._nLanguage);
  photopath2=p.getPhotopath2(teasession._nLanguage);
  if(photopath2!=null)
  {
    len=new File(application.getRealPath(photopath2)).length();
  }
  degree=p.getDegree(teasession._nLanguage);
  polity=p.getPolity();

  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
  golf=aur.golf;
}else
{
  password=firstname=lastname=email="";
  job=title=birth=fax=etime=telephone=mobile=functions=address=photopath2=degree="";
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  var v="/";
  var op=form1.role1.options;
  for(var j=0;j<op.length; j++)
  {
    v=v+op[j].value+"/";
  }
  form1.golf.value=v;

  return submitMemberid(form1.newmember,"用户名不正确,格式:长度最小3位,内容只能是 数字，字母，下划线(_)和减号(-)")
  &&submitText(form1.name,"<%=r.getString(teasession._nLanguage,"InvalidName")%>")
  &&submitOptions(form1.role1,"<%=r.getString(teasession._nLanguage,"无效-球场 (至少要选择一个)")%>");
}

function submitOptions(obj,text)
{
  if(obj.options.length==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
}

function f_clear(member)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmClearPassword")%>'))
  {
    form1.member.value=member;
    form1.act.value='clearpassword';
    form1.submit();
  }
}

function f_key(m)
{
  window.open("/jsp/admin/popedom/KeySerialNum.jsp?community=<%=teasession._strCommunity%>&member="+encodeURIComponent(m),"","top=300px,left=400px,height=170px,width=400px");
}

</script>
</head>
<BODY>
<h1>分球会授权</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage, "AddUser")%></h2>
<iframe style="display:none" name="ifr"></iframe>
<FORM name="form1" method="post" action="?" target="ifr">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="member" value="<%=member%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="role" value="<%=role%>">

<TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <TR>
    <td nowrap><%=r.getString(teasession._nLanguage, "ID")%>:</td>
    <TD><%=(member!=null&&member.length()>0)?member:"<input name=newmember maxlength=20 mask='exists' alt='minfo'><span id='minfo'></span>"%></TD>
    <td nowrap><%=r.getString(teasession._nLanguage, "Password")%>:</td>
    <TD><INPUT type="password" maxLength="20" name="password" value="<%=password%>"></TD>
  </TR>
  <TR>
    <td nowrap><%=r.getString(teasession._nLanguage, "Username")%>:</td>
    <TD><INPUT  name="name" value="<%=firstname%>"></TD>
      <TD nowrap><%=r.getString(teasession._nLanguage, "姓别")%>:</TD>
      <TD><select name="sex">
        <option value="true" selected><%=r.getString(teasession._nLanguage, "Man")%></option>
        <option value="false" <%if(!sex)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "Woman")%></option>
</select>      </TD>
</tr>
<tr>
  <td nowrap><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
  <td><input type="TEXT"  name=email VALUE="<%=email%>"  MAXLENGTH=40></td>
    <TD nowrap><%=r.getString(teasession._nLanguage, "Dept")%>:</TD>
    <TD><select name="adminunit">
      <option value="0">-------------</option>
      <%
      Enumeration au_enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
      while(au_enumer.hasMoreElements())
      {
        AdminUnit _au=(AdminUnit)au_enumer.nextElement();
        int id=_au.getId();
        out.print("<option value="+id);
        out.print(" selected ");
        out.println(" >"+_au.getPrefix()+_au.getName());
      }
      %>
      </select>
      <input type="button" value="..." onClick="window.showModalDialog('/jsp/admin/popedom/UnitSelect.jsp?community=<%=teasession._strCommunity%>&index=form1.adminunit',self,'edge:raised;status:0;help:0;resizable:1;dialogWidth:550px;dialogHeight:500px;dialogTop:100;dialogLeft:150');"/></TD>
  </TR>
  <tr>
    <td nowrap>办公电话:</td>
    <td><input name="telephone" type="text" value="<%=telephone%>" mask="tel"></td>
      <td nowrap>手机号码:</td>
      <td><input name="mobile" type="text" value="<%=mobile%>" mask="int"></td>
  </tr>
  <tr>
    <td nowrap>地址:</td>
    <td colspan="3"><input name="address" type="text" size="70" value="<%=address%>"></td>
  </tr>


  <!--ROLE-->
  <TR><td nowrap>球场:</td>
    <TD colspan="3">
      <table>
        <tr align="center">
          <td>选定</td>
          <td>&nbsp;</td>
          <td>备选</td>
        </tr>
        <tr><td>
          <input type="hidden" name="golf" >
          <select name="role1" size="8" multiple style="WIDTH:140px;"  ondblclick="move(form1.role1,form1.role2,true);">
          <%
          String rs[]=golf.split("/");
          for(int i=1;i<rs.length;i++)
          {
            if(rs[i]!=null && rs[i].length()>0)
            {
              int id=Integer.parseInt(rs[i]);
              if(Node.isExisted(id))out.print("<option value="+id+" >"+Node.find(id).getSubject(teasession._nLanguage));
            }
          }
      %>
    </select>
    </td>
    <td>
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">    </td>
    <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:140px;" size="8">
    <%
    Enumeration ar_enumer=Node.findByType(62,teasession._strCommunity);
    while(ar_enumer.hasMoreElements())
    {
      int ar_id=((Integer)ar_enumer.nextElement()).intValue();
      if(golf.indexOf("/"+ar_id+"/")==-1)out.print("<option value="+ar_id+" >"+Node.find(ar_id).getSubject(teasession._nLanguage)+"</option>");
    }
    %>
    </select>    </td>
    </tr>
  </table>
  <tr align="center">
    <td colSpan="6"  class="TableControl"><INPUT type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"CBRegEdit")%>" >
    <input type="button" value="返回" onclick="history.back()"/>
    </td>
  </tr>
</TABLE>


</FORM>

<%--
<div style="position:absolute;width:100%;height:100%;z-index:1;background-color:#CCCCCC;left:0px;top:0px;filter:Alpha(opacity=50);"><table height="100%"><tr><td valign="middle"><img src="/tea/image/public/load2.gif" /></td></tr></table></div>
--%>
</BODY></html>
