<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%!
String getSelect(boolean i)
{
  return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{
  return strNull==null?"":String.valueOf(strNull);
}

%><%request.setCharacterEncoding("UTF-8");
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String community=request.getParameter("community");

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

if(community==null)
{
  community=node.getCommunity();
}

String member=request.getParameter("member");
String MemberId =null    , Email  =null      ,EnterPassword=null,PhoneNumber  =null,FirstName  =null  ,Organization =null,Address     =null ,zip    =null      ,Telephone   =null,Fax  =null, WebPage    =null  ;
int area   =0, Age  =0;
boolean add=false;
if(member!=null)
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}else
{
  tea.entity.admin.Conductor con_obj= tea.entity.admin.Conductor.find(teasession._rv._strR,community);
  add=tea.entity.site.License.getInstance().getInstance().getWebMaster().equals(teasession._rv._strR);
  boolean bool= add||teasession._rv._strR.equals(member);
  Profile profile=Profile.find(member);
  SClient sclient=SClient.find(community,member);
  if(con_obj.getZone()!=null&&!bool)
  {
    java.util.Enumeration enumer=  tea.entity.admin.AdminZone.findByArea(sclient.getArea());
    while(enumer.hasMoreElements())
    {
      if(con_obj.getZone().indexOf("/"+enumer.nextElement()+"/")!=-1)
      {
        add=bool=true;
        break;
      }
    }
  }
  if(!bool )
  {
    response.sendError(403);
    return;
  }
  MemberId=profile.getMember();
  Email=profile.getEmail();
  EnterPassword=profile.getPassword();
  area=sclient.getArea();
  PhoneNumber=profile.getMobile();
  FirstName=profile.getFirstName(teasession._nLanguage);
  Organization=profile.getOrganization(teasession._nLanguage);
  Address=profile.getAddress(teasession._nLanguage);
  zip=profile.getZip(teasession._nLanguage);
  Telephone=profile.getTelephone(teasession._nLanguage);
  Fax=profile.getFax(teasession._nLanguage);
  Age=profile.getAge();
  WebPage=profile.getWebPage(teasession._nLanguage);
}
if(request.getMethod().equals("POST"))
{
  if(teasession.getParameter("vertify").equals(session.getAttribute("sms.vertify")))
  {
    Profile profile;
    String email=teasession.getParameter("Email");
    if(member==null)//??????
    {
      member=teasession.getParameter("MemberId");
      if(Profile.isExisted(member))
      {
        out.print(new tea.html.Script("alert('??????????????????ID???????????????');history.back();"));
        return;
      }else
      {
        String password= request.getParameter("ConfirmPassword");
        String sn=request.getServerName()+":"+request.getServerPort();
        profile=Profile.create(member,password,community,email,sn);
        if(teasession._rv==null)
        {
          Community community_obj=Community.find(community);
          String webn=community_obj.getName(teasession._nLanguage);
          String conent=community_obj.getMailBefore(teasession._nLanguage)+"???????????????????????????????????????????????????????????????????????????????????????www.timade.com?????????????????????????????????????????????62358177????????????"+community_obj.getMailAfter(teasession._nLanguage);
          // conent=new String(conent.getBytes());

          String str="??????"+webn;

          int k = Message.create(community,null,email, teasession._nLanguage, str, conent);
          try
          {
            tea.service.Robot.activateRoboty(teasession._nNode,k);
          } catch (Exception _ex)
          {}
          out.print(new tea.html.Script("alert('??????????????????????????????');window.location='/servlet/Login?LoginType=0&LoginId="+member+"&Password="+password+"';"));
        }else
        {
          out.print(new tea.html.Script("alert('???????????????');history.back();"));
        }
      }
    }else//??????
    {
      profile=Profile.find(member);
      profile.setPassword(request.getParameter("ConfirmPassword"));
      if(!add)
      {
        out.print(new tea.html.Script("alert('???????????????');window.location='/servlet/Node?node="+tea.entity.site.Community.find(teasession._nNode).getWebName()+"';"));
      }
    }
    SClient sclient=SClient.find(community,member);
    sclient.set(Integer.parseInt(teasession.getParameter("address")));
    if(add)
    {
//      String price=request.getParameter("price");
//      sclient.setPrice(new java.math.BigDecimal(price));

      //out.print(new tea.html.Script("window.location='/jsp/user/EjMember.jsp';"));
      response.sendRedirect("/jsp/user/EjMember.jsp");
    }
      profile.setEmail(email);
      //profile.setArea(Integer.parseInt(teasession.getParameter("address")));
      profile.setMobile(teasession.getParameter("PhoneNumber"));
      profile.setFirstName(teasession.getParameter("FirstName"),teasession._nLanguage);
      profile.setOrganization(teasession.getParameter("Organization"),teasession._nLanguage);
      profile.setAddress(teasession.getParameter("Address"),teasession._nLanguage);
      profile.setZip(teasession.getParameter("Zip"),teasession._nLanguage);
      profile.setTelephone(teasession.getParameter("Telephone"),teasession._nLanguage);
      profile.setFax(teasession.getParameter("Fax"),teasession._nLanguage);
      //profile.setAge(Integer.parseInt(teasession.getParameter("Age")));
      profile.setWebPage(teasession.getParameter("WebPage") ,teasession._nLanguage);
     // response.sendRedirect("/jsp/user/regsuccess.jsp?node="+teasession._nNode);
     return;
  }else
  {
    out.print(new tea.html.Script("alert('??????????????????????????????');history.back();"));
    return;
  }
}


Resource r = new Resource("/tea/ui/util/SignUp1");
/*String vertify=sms.password();
HttpSession httpsession = request.getSession(true);
httpsession.setAttribute("sms.vertify" ,vertify);*/
String s2 = request.getParameter("Node");




%>

<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function isMmeberId(s) {
  s=s.replace(' ','').replace('	','');
	if (s.length < 1)
		return false;
                illegal="\\/:*?\"<>|";
	for (var i = 0; i < s.length; i++) {
		var c = s.charAt(i);
                for(index=0;index<illegal.length;index++)
                if ((illegal.charAt(index) == c))
		{
                  return false;
              }
	}
	return true;
}
function submitMemberId(text, alerttext) {
	if(!isMmeberId(text.value)) {
		alert(alerttext);
		text.focus();
		return false;
	}

	return true;
}
function submitSelect(obj,alerttext)
{
  if(obj.selectedIndex==0)
  {
    alert(alerttext);
    obj.focus();
    return false;
  }
  return true;
}
</script>

<h1><%=r.getString(teasession._nLanguage, "????????????")%></h1>
<FORM name=foSignUp METHOD=POST ACTION="" onSubmit="return(submitMemberid(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(this.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'InvalidConfirm')&&submitText(foSignUp.Address,'??????????????????')&&submitText(foSignUp.Telephone,'????????????'));">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="zhuce">
    <tr>
      <td>?????????:</td>
      <td colspan="3"><%if(member!=null)out.print(new tea.html.HiddenField("member",member));%>
        <input type="TEXT"   <%if(member!=null)out.print("disabled");%> name=MemberId VALUE="<%=getNull(MemberId)%>" SIZE=20 MAXLENGTH=40>
        *
        <!--??????????????????-->
        ??????:????????????3???,??????????????? ???????????????????????????(_)?????????(-) </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "EnterPassword")%>:</td>
      <td><input type="password"   name=EnterPassword VALUE="<%=getNull(EnterPassword)%>" SIZE=20 MAXLENGTH=16>
        * ?????????3???</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</td>
      <td><input type="password"   name=ConfirmPassword VALUE="<%=getNull(EnterPassword)%>" SIZE=20 MAXLENGTH=16>
        *</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Validate")%>:</td>
      <td colspan="3"><input type="TEXT"   name=vertify VALUE="" SIZE=20 MAXLENGTH=20>
        <%=r.getString(teasession._nLanguage, "VerificationCode")%>: <img src="/jsp/user/validate.jsp">??????* </td>
    </tr>
    <tr>
      <td>????????????:</td>
      <td><input type="TEXT"   name=FirstName VALUE="<%=getNull(FirstName)%>" SIZE=20 MAXLENGTH=20>
        ??? ???????????????????????????????????????????????????</td>
    </tr>
    <tr>
      <td>??????: </td>
      <td><select name="address_father" onChange="fonchange(this)">
          <!-- onchange="fonchange()">address_father-->
          <%
        StringBuffer script_address=new StringBuffer();
        StringBuffer address_secondly=new StringBuffer();
        java.util.Enumeration az_enumer=tea.entity.admin.Area.findByFather(tea.entity.admin.Area.getRootId(node.getCommunity()));
        while(az_enumer.hasMoreElements())
        {
          int id=((Integer)az_enumer.nextElement()).intValue();
          tea.entity.admin.Area a_obj     =   tea.entity.admin.Area.find(id);
          script_address.append("\r\ncase '"+id+"':\r\n");
          java.util.Enumeration a2_enumer=tea.entity.admin.Area.findByFather(id);
          while(a2_enumer.hasMoreElements())
          {
            int id2=((Integer)a2_enumer.nextElement()).intValue();
            tea.entity.admin.Area a2_obj     =   tea.entity.admin.Area.find(id2);
            script_address.append("foSignUp.address_secondly.options[foSignUp.address_secondly.length]=(new Option('"+a2_obj.getName()+"','"+id2+"'));");

            address_secondly.append("\r\ncase '"+id2+"':\r\n");
            java.util.Enumeration a3_enumer=tea.entity.admin.Area.findByFather(id2);
            while(a3_enumer.hasMoreElements())
            {
              int id3=((Integer)a3_enumer.nextElement()).intValue();
              tea.entity.admin.Area a3_obj     =   tea.entity.admin.Area.find(id3);
              address_secondly.append("foSignUp.address.options[foSignUp.address.length]=(new Option('"+a3_obj.getName()+"','"+id3+"'));");
            }
            address_secondly.append("break;");
          }
          script_address.append("break;");
	%>
          <option value="<%=id%>" <%//=getSelect(id==so_obj.getAddress())%>><%= a_obj.getName()%></option>
          <%}%>
        </select>
        <select name="address_secondly" onChange="fonchange(this)">
          <option></option>
        </select>
        <select name="address" >
          <option></option>
        </select>
        *
    <tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td COLSPAN=3><TEXTAREA name=Address ROWS=2 COLS=60><%=getNull(Address)%></TEXTAREA>
        *</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
      <td><input type="TEXT"   name=Zip VALUE="<%=getNull(zip)%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "mobile1")%>:</td>
      <td><input type="TEXT"   name=PhoneNumber VALUE="<%=getNull(PhoneNumber)%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="TEXT"   name=Email value="<%=getNull(Email)%>" size=40 maxlength=40>
        ??????????????????E-mail</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
      <td COLSPAN=3><input type="TEXT"   name=Organization VALUE="<%=getNull(Organization)%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
      <td><input type="TEXT"   name=Telephone VALUE="<%=getNull(Telephone)%>"  >
*</tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
      <td><input type="TEXT"   name=Fax value="<%=getNull(Fax)%>" size=20 maxlength=20>
    </tr>
    <%--
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Age")%>:</td>
      <td><SELECT name=Age>
          <OPTION VALUE="0">?????????</OPTION>
          <OPTION VALUE="1" <%=getSelect(Age==1)%>>0-6</OPTION>
          <OPTION VALUE="2" <%=getSelect(Age==2)%>>7-12</OPTION>
          <OPTION VALUE="3" <%=getSelect(Age==3)%>>13-15</OPTION>
          <OPTION VALUE="4" <%=getSelect(Age==4)%>>16-18</OPTION>
          <OPTION VALUE="5" <%=getSelect(Age==5)%>>19-22</OPTION>
          <OPTION VALUE="6" <%=getSelect(Age==6)%>>23-25</OPTION>
          <OPTION VALUE="7" <%=getSelect(Age==7)%>>26-28</OPTION>
          <OPTION VALUE="8" <%=getSelect(Age==8)%>>29-35</OPTION>
          <OPTION VALUE="9" <%=getSelect(Age==9)%>>36-40</OPTION>
          <OPTION VALUE="10" <%=getSelect(Age==10)%>>41-45</OPTION>
          <OPTION VALUE="11" <%=getSelect(Age==11)%>>46-50</OPTION>
          <OPTION VALUE="12" <%=getSelect(Age==12)%>>51-55</OPTION>
          <OPTION VALUE="13" <%=getSelect(Age==13)%>>56-60</OPTION>
          <OPTION VALUE="14" <%=getSelect(Age==14)%>>60-</OPTION>
        </SELECT>
      </td>
    </tr>
    --%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
      <td><input type="TEXT"   name=WebPage value="<%=getNull(WebPage)%>" size="40" maxlength="255"></td>
    </tr>
    <%--
      if(add)
      {
      %>
    <tr>
      <td>??????</td>
      <td>+
        <input name="price" value="0">
      </td>
      <%        }--%>
  </table>
  <div class="zhuce-submit"><input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"></div>
</FORM>
<SCRIPT>
  //document.foSignUp.MemberId.focus();
    function fonchange(selectobj)
    {
      if(selectobj.name=='address_father')
      {
        while(foSignUp.address.length>0)
        {
          foSignUp.address.options[0]=null;
        }
        while(foSignUp.address_secondly.length>0)
        {
          foSignUp.address_secondly.options[0]=null;
        }
        switch(selectobj.options[selectobj.selectedIndex].value)
        {
          <%=script_address.toString()%>
        }
      }else
      if(selectobj.name=='address_secondly')
      {
        while(foSignUp.address.length>0)
        {
          foSignUp.address.options[0]=null;
        }
        switch(selectobj.options[selectobj.selectedIndex].value)
        {
          <%=address_secondly.toString()%>
        }
        fonchange(foSignUp.address);
      }
    }
    <%
       tea.entity.admin.Area a3_obj     =   tea.entity.admin.Area.find(area);
       tea.entity.admin.Area address_secondly_obj=tea.entity.admin.Area.find(a3_obj.getFather());
       %>
       for(index=0;index<foSignUp.address_father.length;index++)
       {
         if(foSignUp.address_father.options[index].value=='<%=address_secondly_obj.getFather()%>')
         {
           foSignUp.address_father.selectedIndex=index;
         }
       }
       fonchange(foSignUp.address_father);

       for(index=0;index<foSignUp.address_secondly.length;index++)
       {
         if(foSignUp.address_secondly.options[index].value=='<%=address_secondly_obj.getId()%>')
         {
           foSignUp.address_secondly.selectedIndex=index;
         }
       }
       fonchange(foSignUp.address_secondly);

       for(index=0;index<foSignUp.address.length;index++)
       {
         if(foSignUp.address.options[index].value=='<%=area%>')
         {
           foSignUp.address.selectedIndex=index;
         }
       }

  </SCRIPT>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

