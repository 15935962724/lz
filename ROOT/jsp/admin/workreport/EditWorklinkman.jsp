<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.member.*" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.entity.site.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page  import="tea.entity.*" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page  import="tea.htmlx.*" %>


<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport").add("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");




int client=0;// 客户
boolean clienttype=false;
String country=null;
String country2=null;




int worklinkman=0;
if(request.getParameter("worklinkman")!=null)
{
  worklinkman=Integer.parseInt(request.getParameter("worklinkman"));
}
String firstname=null,lastname=null;
String member=request.getParameter("member"),birthday=null,fpostcode=null,worktel  =null,ftel     =null,mobile   =null,email    =null,qicq     =null,msn      =null,blog     =null,name     =null,job      =null,love     =null,faddress =null,content  =null;

    String postcode=null;
    String state=null;
    String city=null;
    String street=null;
    // /////////其他地址

    String postcode2=null;
    String state2=null;
    String city2=null;
    String street2=null;

    String fax=null;
    int origin=0;
    String hometel=null;
    String othertel=null;
    String unit=null;
    String assistant=null;
    String assistanttel=null;
boolean sex=true;
int workproject=0;
if(member!=null&&member.length()>0)
{
  Profile profile=Profile.find(member);
  firstname=profile.getFirstName(teasession._nLanguage);
  lastname=profile.getLastName(teasession._nLanguage);
  sex=profile.isSex();
  birthday=profile.getBirthToString();
  fpostcode=profile.getZip(teasession._nLanguage);
  worktel=profile.getTelephone(teasession._nLanguage);
  mobile=profile.getMobile();
  email=profile.getEmail();

  Worklinkman obj=Worklinkman.find(community,member);
  if(obj.isExists())
  {
    workproject=obj.getWorkproject();
    ftel     =obj.getFtel();
    qicq     =obj.getQicq();
    msn      =obj.getMsn();
    blog     =obj.getBlog();
    job      =obj.getJob(teasession._nLanguage);
    love     =obj.getLove(teasession._nLanguage);
    faddress =obj.getFaddress(teasession._nLanguage);
    content  =obj.getContent(teasession._nLanguage);


    country=obj.getCountry();
    postcode=obj.getState();
    state=obj.getState();
    city=obj.getCity();
    street=obj.getStreet();
    country2=obj.getCountry2();
    postcode2=obj.getPostcode2();
    state2=obj.getState2();
    city2=obj.getCity2();
    street2=obj.getState2();
    fax=obj.getFax();
    origin=obj.getOrigin();
    hometel=obj.getHometel();
    othertel=obj.getOthertel();
    unit=obj.getUnit();
    assistant=obj.getAssistant();
    assistanttel=obj.getAssistanttel();
  }

}
String sun = teasession.getParameter("sun");

///联系人信息管理
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
            <script type="">
            function f_copy()
            {
              form1.country2.value=form1.country.value;
              form1.postcode2.value=form1.postcode.value;
              form1.state2.value=form1.state.value;
              form1.city2.value=form1.city.value;
              form1.street2.value=form1.street.value;
            }

            function sk()
            {
              if(form1.password.value!=form1.confirmpassword.value)
              {
                alert("密码错误，请重新填写。");
                return false;
              }else if(form1.password.value==null || form1.password.value=="")
              {
                alert("密码不能为空！");
                return false;
              }else if(form1.confirmpassword.value==null || form1.confirmpassword.value=="")
              {
                alert("密码不能为空！");
                return false;
              }else if(form1.member.value==null || form1.member.value=="")
              {
                alert("会员不能为空！");
                return false;
              }else if(form1.lastname.value==null || form1.lastname.value=="")
              {
                alert("姓名不能为空！");
                return false;
              }else if(form1.worktel.value==null || form1.worktel.value=="")
              {
                alert("工作电话不能为空！");
                return false;
              }
            }
            function f_ck()
            {
              var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:550px;';
              var url = '/jsp/admin/workreport/wquery.jsp'
              var rs=  window.showModalDialog(url,self,y);
              if(rs!=null){
                form1.workproject.value = rs;
              }
            }
            </script>

  </head>
  <body onLoad="try{ form1.member.focus(); }catch(e){}">
  <!--联系人信息管理-->
  <h1><%=r.getString(teasession._nLanguage,"1168584403265")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br>
    <form name=form1 METHOD=post action="/servlet/EditWorkreport" onSubmit="return  (form1.member.type!='text'||(submitMemberid(form1.member,'<%=r.getString(teasession._nLanguage,"InvalidMemberId")%>')&&submitIdentifier(form1.password,'<%=r.getString(teasession._nLanguage,"InvalidPassword")%>')&&submitEqual(form1.password,form1.confirmpassword,'<%=r.getString(teasession._nLanguage,"InvalidConfirmPassword")%>')))&&submitText(this.lastname,'<%=r.getString(teasession._nLanguage,"InvalidLastName")%>')&&submitText(this.workproject,'<%=r.getString(teasession._nLanguage,"1168584443703")%>')">
      <input type=hidden name="community" value="<%=community%>"/>
      <input type=hidden name="worklinkman" value="<%=worklinkman%>"/>
      <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
      <input type=hidden name="action" value="editworklinkman"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
      if(member==null||member.length()<1)
      {
        out.print("<input type=hidden name=newmember >");
        %>
        <tr><td><%=r.getString(teasession._nLanguage,"1168932110937")%><!--选择已经存在的会员--></td>
          <td><select onChange="window.open('?worklinkman=<%=worklinkman%>&member='+this.value+'&nexturl='+encodeURIComponent(form1.nexturl.value),'_self');">
            <option value="">-------------</option>
            <%
            java.util.Enumeration e_profile=Subscriber.find(teasession._strCommunity,"",0,1000);
            while(e_profile.hasMoreElements())
            {
              RV e_member=((RV)e_profile.nextElement());
              out.print("<option value=\""+e_member+"\" >"+e_member);
            }
            %>
            </select>
          </td></tr>
          <tr><td><%=r.getString(teasession._nLanguage,"MemberId")%><!--会员ID--></td><td><input name="member" size="30" value="<%if(member!=null)out.print(member);%>"></td></tr>
            <tr><td><%=r.getString(teasession._nLanguage,"Password")%></td><td><input type="password" name="password" size="30" value="<%//if(password!=null)out.print(password);%>"></td></tr>
              <tr><td><%=r.getString(teasession._nLanguage,"ConfirmPassword")%></td><td><input type="password" name="confirmpassword" size="30" value="<%//if(password!=null)out.print(password);%>"></td></tr>
                <tr><td colspan="2"><hr size="1"/></td></tr>
                <%
                }else
                {
                  out.print("<tr><td>"+r.getString(teasession._nLanguage,"MemberId")+"</td><td><input size=40 disabled value=\"");
                  out.print(member);
                  out.println("\"><input type=hidden name=member value=\""+member+"\" ></td></tr>");
                }
                %>
                <tr><td><%=r.getString(teasession._nLanguage,"LastName")%><%=r.getString(teasession._nLanguage,"FirstName")%></td><td><input name="lastname" size="40"  value="<%if(lastname!=null)out.print(lastname+firstname);%>"></td></tr>

                    <!--tr>
                    <td>客户</td>
                    <td>
                      <input type=hidden name=clienttype value="<%=clienttype%>" >
                      <select name="client" onChange="f_client(this.selectedIndex);">
                        <option value="0">
                        <%
                        int len=0;
                        java.util.Enumeration e= Latency.findByCommunity(teasession._strCommunity,"");
                        while(e.hasMoreElements())
                        {
                          int id=((Integer)e.nextElement()).intValue();
                          Latency l=Latency.find(id);
                          out.print("<option value="+id);
                          if(!clienttype&&client==id)
                          out.print(" SELECTED ");
                          out.print(" >"+l.getFamily()+l.getFirsts());
                          len++;
                        }
                        e= Workproject.find(teasession._strCommunity,"",0,200);
                        while(e.hasMoreElements())
                        {
                          int id=((Integer)e.nextElement()).intValue();
                          Workproject wp=Workproject.find(id);
                          out.print("<option value="+id);
                          if(clienttype&&client==id)
                          out.print(" SELECTED ");
                          out.print(" >"+wp.getName(teasession._nLanguage));
                        }
                        %>
                        </select><input type="button" value="..." onclick="window.open('/jsp/admin/sales/clientserver.jsp?community=<%=teasession._strCommunity%>&client=form1.client&clienttype=form1.clienttype','','width=550,height=400,top='+(screen.height-400)/2+',left='+(screen.width-550)/2+',scrollbars=0,resizable=0,status=0');" >
                          <script type="text/javascript">
                          function f_client(v)
                          {
                          form1.clienttype.value=v><%=len%>;
                          }
                          </script>
                    </td>
</tr-->

<tr><td><%=r.getString(teasession._nLanguage,"1168584443703")%><!--客户或项目--></td>
  <td><select name="workproject">
    <option value="">-------------</option>
    <%
    java.util.Enumeration ed=Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    while(ed.hasMoreElements())
    {
      int id=((Integer)ed.nextElement()).intValue();
      Workproject obj=Workproject.find(id);
      out.print("<option value="+id);
      if(id==workproject)
      out.print(" SELECTED ");
      out.print(" >"+obj.getName(teasession._nLanguage));
    }
    %>
    </select>
    <input type="button" value="..."  onclick="f_ck();">
    <input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=0&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")%>','_self');">
  </td></tr>
  <tr><td><%=r.getString(teasession._nLanguage,"Sex")%></td>
    <td><input name="sex" type="radio" size="30" value="true" checked="checked" ><%=r.getString(teasession._nLanguage,"Man")%> <input name="sex" type="radio" size="30" value="false" <%if(!sex)out.print(" checked ");%>><%=r.getString(teasession._nLanguage,"Woman")%></td></tr>
      <tr><td><%=r.getString(teasession._nLanguage,"1168585707250")%><!--出生日期--></td>
        <td><input name="birthday" onFocus="if(this.value=='yyyy-MM-dd')this.value='';" onBlur="if(this.value=='')this.value='yyyy-MM-dd';"  value="<%if(birthday!=null)out.print(birthday);else{out.print("yyyy-MM-dd");}%>"><A href="###"><img src="/tea/image/public/Calendar2.gif" onClick="showCalendar('form1.birthday');" align="top"/></a> </td></tr>
        <tr><td><%=r.getString(teasession._nLanguage,"1168585799359")%><!--家庭邮编--></td>
          <td><input name="fpostcode" size="40" value="<%if(fpostcode!=null)out.print(fpostcode);%>"></td></tr>
          <tr><td><%=r.getString(teasession._nLanguage,"1168584722562")%><!--工作电话--></td>
            <td><input name="worktel" size="40" value="<%if(worktel!=null)out.print(worktel);%>"></td></tr>
            <tr><td><%=r.getString(teasession._nLanguage,"1168585870750")%><!--家庭电话--></td>
              <td><input name="ftel" size="40" value="<%if(ftel!=null)out.print(ftel);%>"></td></tr>
              <tr><td><%=r.getString(teasession._nLanguage,"1168584761843")%><!--手机--></td>
                <td><input name="mobile" size="40" value="<%if(mobile!=null)out.print(mobile);%>"></td></tr>
                <tr><td>E-Mail</td>
                  <td><input name="email" size="40"  value="<%if(email!=null)out.print(email);%>"></td></tr>
                  <tr><td>QQ</td>
                    <td><input name="qicq" size="40" value="<%if(qicq!=null)out.print(qicq);%>"></td></tr>
                    <tr><td>MSN</td>
                      <td><input name="msn" size="40" value="<%if(msn!=null)out.print(msn);%>"></td></tr>
                      <tr><td><%=r.getString(teasession._nLanguage,"1168586007609")%><!--博客网址--></td>
                        <td><input name="blog" size="40" value="<%if(blog!=null)out.print(blog);%>"></td></tr>
                        <tr><td><%=r.getString(teasession._nLanguage,"1168586069359")%><!--职位--></td>
                          <td><input name="job" size="40" value="<%if(job!=null)out.print(job);%>"></td></tr>
                          <tr><td><%=r.getString(teasession._nLanguage,"Hobbies")%><!--爱好--></td><td><input name="love" size="40" value="<%if(love!=null)out.print(love);%>"></td></tr>
                            <tr><td><%=r.getString(teasession._nLanguage,"1168586146015")%><!--家庭住址--></td><td><input name="faddress" size="40" value="<%if(faddress!=null)out.print(faddress);%>"></td></tr>
                              <tr><td><%=r.getString(teasession._nLanguage,"Text")%><!--内容--></td><td><textarea name="content" rows="4" cols="40"><%if(content!=null)out.print(content);%></textarea></td></tr>
      </table>
      <h2>地址信息<a href="javascript:f_copy();">将邮寄地址复制到其他地址</a></h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>邮寄地址 - 国家/地区</td>
          <td ><%=new CountrySelection("country",teasession._nLanguage,country)%></td>
          <td> 其他地址 - 国家/地区 </td>
          <td ><%=new CountrySelection("country2",teasession._nLanguage,country2)%></td>
        </tr>
        <tr>
          <td> 邮寄地址 - 邮政编码 </td>
          <td><input name="postcode" maxlength="6" size="10" value="<%if(postcode!=null)out.print(postcode);%>"></td>
            <td> 其他地址 - 邮政编码 </td>
            <td><input name="postcode2" maxlength="6" size="10" value="<%if(postcode2!=null)out.print(postcode2);%>"/></td>
        </tr>
        <tr>
          <td> 邮寄地址 - 州/省 </td>
          <td ><input  id="state" maxlength="20" name="state" size="20" tabindex="13" type="text"  value="<%if(state!=null)out.print(state);%>"/></td>
          <td> 其他地址 - 州/省 </td>
          <td><input  id="state2" maxlength="20" name="state2" size="20" tabindex="18" type="text" value="<%if(state2!=null)out.print(state2);%>" /></td>
        </tr>
        <tr>
          <td> 邮寄地址 - 城市 </td>
          <td><input  id="city" maxlength="40" name="city" size="20" tabindex="14" type="text"  value="<%if(city!=null)out.print(city);%>"/></td>
          <td> 其他地址 - 城市 </td>
          <td><input  id="city2" maxlength="40" name="city2" size="20" tabindex="19" type="text"  value="<%if(city2!=null)out.print(city2);%>"/></td>
        </tr>
        <tr>
          <td>邮寄地址 - 街道</td>
          <td><textarea  cols="27" id="street" maxlength="255" name="street" rows="2" tabindex="15" ><%if(street!=null)out.print(street);%></textarea></td>
          <td> 其他地址 - 街道 </td>
          <td><textarea  cols="27" id="street2" maxlength="255" name="street2" rows="2" tabindex="20" ><%if(street2!=null)out.print(street2);%></textarea></td>
        </tr>
      </table>
      <h2>其他信息</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>传真</td>
          <td ><input maxlength="40" name="fax" size="20" tabindex="14" type="text"  value="<%if(fax!=null)out.print(fax);%>"/></td>
          <td>潜在客户来源</td>
          <td><select name="origin" >
          <%
          for(int i=0;i<Latency.ORIGIN.length;i++)
          {
            out.print("<option value="+i);
            if(origin==i)
            out.print("  selected");
            out.print(" >"+r.getString(teasession._nLanguage,Latency.ORIGIN[i]));
          }
          %>
          </select></td>
        </tr>
        <tr>
          <td>其他电话</td>
          <td><input  maxlength="40" name="othertel" size="20" tabindex="14" type="text"  value="<%if(othertel!=null)out.print(othertel);%>"/></td>
        </tr>
        <tr>
          <td>助理</td>
          <td><input   maxlength="40" name="assistant" size="20" tabindex="14" type="text"  value="<%if(assistant!=null)out.print(assistant);%>"/></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>助理电话</td>
          <td><input   maxlength="40" name="assistanttel" size="20" tabindex="14" type="text"  value="<%if(postcode!=null)out.print(postcode);%>"/></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" name="submitWork" >
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
  </body>
</html>



