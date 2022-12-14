<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%


TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);
String community=teasession._strCommunity;

Resume rsobj=Resume.find(teasession._nNode,teasession._nLanguage);
if(request.getParameter("NewNode")==null&&!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
} 

Resource r=new Resource();

r.add("tea/ui/node/type/Report/EditReport").add("tea/ui/util/SignUp1").add("/tea/resource/Job");

Profile profile =Profile.find(teasession._rv._strR);

String firstname=profile.getFirstName(teasession._nLanguage);
String lastname=profile.getLastName(teasession._nLanguage);
boolean sex=profile.isSex();
String email=profile.getEmail();
String mobile=profile.getMobile();
String telephone=profile.getTelephone(teasession._nLanguage);
java.util.Date birth=profile.getBirth();
String nationality =profile.getCountry(teasession._nLanguage);
String gblnd =profile.getGblnd(teasession._nLanguage);
String gbort=profile.getGbort(teasession._nLanguage);
int polity=profile.getPolity();
int famst=profile.getFamst();
java.util.Date famdt=profile.getFamdt();
int anzkd=profile.getAnzkd();
String zzhkszd=profile.getZzhkszd(teasession._nLanguage);
boolean zzgatwj=profile.isZzgatwj();
boolean zznyhk=profile.isZznyhk();
String zzpridn=profile.getZzpridn();
String zzfmbkg=profile.getZzfmbkg();
String address=profile.getAddress(teasession._nLanguage);
String zip=profile.getZip(teasession._nLanguage);
String degree=profile.getDegree(teasession._nLanguage);
String school=profile.getSchool(teasession._nLanguage);

long len=0;
String photopath=profile.getPhotopath(teasession._nLanguage);
if(photopath!=null)
{
  java.io.File file=new java.io.File(application.getRealPath(photopath));
  len=file.length();
}


    java.util.Date dd = new java.util.Date();
     java.text.SimpleDateFormat formatter  = new java.text.SimpleDateFormat("yyyyMMdd HH:mm");
    String formattedDate = formatter.format(dd);

%><HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/tea.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script language="javascript">

function regInput(obj, reg, inputStr)
{
  var docSel	= document.selection.createRange()
  if (docSel.parentElement().tagName != "INPUT")	return false
  oSel = docSel.duplicate()
  oSel.text = ""
  var srcRange	= obj.createTextRange()
  oSel.setEndPoint("StartToStart", srcRange)
  var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length)
  return reg.test(str)
}
function submitSelectLen(obj,text)
{
  if(obj.options.length<1)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}

function submitYynl(obj,text)
{
  if(obj.value == 0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}


function submitSelfFont(obj,text)
{
  if(obj.value.length > 200)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}

function  save_onclick()
{
  var value="/";
  for(var i=0;i<form1.expectcareer.options.length;i++)
  {
    value=value+form1.expectcareer.options[i].value+"/";
  }
  form1.expectcareer_value.value=value;

  value="/";
  for(var i=0;i<form1.expectcity.options.length;i++)
  {
    value=value+form1.expectcity.options[i].value+"/";
  }
  form1.expectcity_value.value=value;

  return submitText(form1.subject,"<%=r.getString(teasession._nLanguage,"1167472464640")%>")&&  //?????????????????????
  submitText(form1.firstname,"<%=r.getString(teasession._nLanguage,"???????????????")%>")&&//????????????
  submitText(form1.address,"<%=r.getString(teasession._nLanguage,"1167472739953")%>")&&//??????-???????????????/??????
  submitText(form1.school,"<%=r.getString(teasession._nLanguage,"1167472331375")%>")&&//??????-????????????
  submitContact(form1.mobile,"<%=r.getString(teasession._nLanguage,"??????-????????????")%>")&&//??????-????????????
  submitEmail(form1.email,"<%=r.getString(teasession._nLanguage,"InvalidEmail")%>")&&//??????-Email
  submitYynl(form1.sprsl,"<%=r.getString(teasession._nLanguage,"???????????????1")%>")&&
  submitYynl(form1.sprs2,"<%=r.getString(teasession._nLanguage,"???????????????2")%>")&&
  submitText(form1.selfvalue,"<%=r.getString(teasession._nLanguage,"?????????????????????")%>")&&
  submitSelfFont(form1.selfvalue,"<%=r.getString(teasession._nLanguage,"????????????????????????200???")%>")&&
  submitText(form1.nowcareerlevel,"<%=r.getString(teasession._nLanguage,"????????????????????????")%>")&&
  submitText(form1.expectcareer,"<%=r.getString(teasession._nLanguage,"???????????????????????????")%>")&&
  submitText(form1.expectcity,"<%=r.getString(teasession._nLanguage,"???????????????????????????")%>");
//  submitText(form1.telephone,"<%=r.getString(teasession._nLanguage,"InvalidTelephone")%>");
//  submitText(form1.gbort,"<%=r.getString(teasession._nLanguage,"1167472634203")%>")&&//??????-?????????
//  submitText(form1.zzhkszd,"<%=r.getString(teasession._nLanguage,"1167472674031")%>")&&//??????-???????????????
//  submitText(form1.zip,"<%=r.getString(teasession._nLanguage,"1167472767562")%>")&&//??????-????????????
//  submitText(form1.nowcareerlevel,"<%=r.getString(teasession._nLanguage,"1167472804812")%>")&&//??????-???????????????
//  submitInteger(form1.experience,"<%=r.getString(teasession._nLanguage,"1167472824937")%>")&&//??????-????????????
//  submitFloat(form1.salarysum,"<%=r.getString(teasession._nLanguage,"1167472852843")%>")&&//??????-????????????
//  submitSelectLen(form1.expectcareer,"<%=r.getString(teasession._nLanguage,"1167472880968")%>")&&//??????-??????????????????
//  submitSelectLen(form1.expectcity,"<%=r.getString(teasession._nLanguage,"1167472899796")%>")&&//??????-??????????????????
//  submitFloat(form1.expectsalarysum,"<%=r.getString(teasession._nLanguage,"1167472919984")%>");//??????-????????????
}
function move(obj1,obj2)
{
  var si1=obj1.selectedIndex;
  if(si1==-1)
  {
    obj1.selectedIndex=0;
    si1=obj1.selectedIndex;
  }
  if(si1!=-1)
  {
    obj2[obj2.length]=new Option(obj1.options[si1].text,obj1.value);
    obj1[si1]=null;
    if(si1>=obj1.length)
    si1=obj1.length-1;
    obj1.selectedIndex=si1;//==0?0:si1;
    obj2.selectedIndex=obj2.length-1;
  }
}

</script>
</HEAD>
<body onload="form1.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "Resume")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<%--  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div> --%>
  <FORM name="form1" enctype="multipart/form-data" METHOD=POST action="/servlet/EditResume" onsubmit="return save_onclick();" >
    <input type='hidden' name=node VALUE="<%=teasession._nNode%>">
    <input type='hidden' name=community VALUE="<%=community%>">
    <%
    String nexturl=teasession.getParameter("nexturl");
 //  System.out.println("nexturl="+nexturl);
    if(nexturl==null)
    {
      nexturl="/jsp/type/resume/Resume.jsp?";
      System.out.println("nexturl="+nexturl);
    }
    out.print("<input type='hidden' name=nexturl value="+nexturl+">");

    String preview="";
    String subject=null;
    String joinu=null,intr1=null,intr2=null,intr3=null;
    String nowmaincareer=null;
    String zxrgs=null;
    String nowcareerlevel=null;
    int experience=0;
    boolean has_abroad=false;
    java.math.BigDecimal salarysum=null;
    String zwaers_yx="CNY";
    int zqwgz=0;
    String expectcareer=null;
    String expectcity=null;
    java.math.BigDecimal expectsalarysum=null;
    String zwaers_qwyx="CNY";
    int joindatetype=0;
    java.util.Enumeration e = Lang.find(teasession._nNode,teasession._nLanguage);
    int lan [] = new int[2];
    for(int i =0;e.hasMoreElements();i++)
    {
      int l = ((Integer)e.nextElement()).intValue();
      lan[i] = l;
    }
    Lang l = Lang.find(lan[0]);
    Lang l2 = Lang.find(lan[1]);
    if(request.getParameter("NewNode")!=null)//??????
    {
      out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON >");
    }else//??????
    {
      //preview="<A href=/jsp/type/resume/Preview.jsp?resumes="+teasession._nNode+" style=color=#ffffff target=_blank >????????????</A>";
      subject=node.getSubject(teasession._nLanguage);

      Resume obj=Resume.find(teasession._nNode,teasession._nLanguage);
      joinu=obj.getJoinu();
      intr1=obj.getIntr1();
      intr2=obj.getIntr2();
      intr3=obj.getIntr3();
      nowmaincareer=obj.getNowmaincareer();
      zxrgs=obj.getZxrgs();
      nowcareerlevel=obj.getNowcareerlevel();
      experience=obj.getExperience();
      has_abroad=obj.isHasabroad();
      salarysum=obj.getSalarysum();
      zwaers_yx=obj.getZwaers_yx();
      zqwgz=obj.getZqwgz();
      expectcareer=obj.getExpectcareer();
      expectcity=obj.getExpectcity();
      expectsalarysum=obj.getExpectsalarysum();
      zwaers_qwyx=obj.getZwaers_qwyx();
      joindatetype=obj.getJoindatetype();
    }
%>
    <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
      <h2><%=r.getString(teasession._nLanguage, "1167468949281")%><!--????????????--></h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>* <%=r.getString(teasession._nLanguage, "1167468982843")%><!--????????????--></td>
        <td colspan="5"><input type="TEXT"  name=subject value="<%if(subject!=null)out.print(subject);else{out.print("??????"+formattedDate);}%>" size=30 maxlength=20> </td>
      </tr>
      <tr>
        <td>*   <%=r.getString(teasession._nLanguage, "??????")%></td>
        <td> <input type="TEXT"   name=firstname VALUE="<%if(firstname!=null)out.print(firstname);%>" SIZE=20 MAXLENGTH=20>
        </td>
        <td ><%=r.getString(teasession._nLanguage, "1167455197453")%><!-- ??????--></td>
        <td>
          <input id="sex_true" type="radio" name="sex" value="true"  <%if(sex)out.print(" checked ");%> /><label for="sex_true"><%=r.getString(teasession._nLanguage, "1167457951671")%><!--???--></label>
          <input id="sex_false" type="radio" name="sex" value="false" <%if(!sex)out.print(" checked ");%>/><label for="sex_false"><%=r.getString(teasession._nLanguage, "1167457972406")%><!--???--></label>
          </td>
        </tr>
         <tr>
        <td><%=r.getString(teasession._nLanguage, "????????????")%></td><!--????????????-->
	 <td><%out.print(new tea.htmlx.TimeSelection("birth",birth ));%></td>
         <td ><%=r.getString(teasession._nLanguage, "??????")%><!--????????????--></td>
        <td><%=new tea.htmlx.DegreeSelection("degree",degree)%></td>
      </tr>

         <tr>
        <td >* <%=r.getString(teasession._nLanguage, "1167469549906")%><!--???????????????/??????--></td>
        <td >
        <input type="text" name="address" value="<%if(address!=null)out.print(address);%>" size=40 /></td>
        <td>* <%=r.getString(teasession._nLanguage, "1167464377812")%><!--????????????--></td>
      <td><input  value="<%if(school!=null)out.print(school);%>" name="school" type="text" size="30" maxlength="50" />
        </td>
      </tr>

      <tr>
        <td>* <%=r.getString(teasession._nLanguage, "????????????")%><!--????????????--></td>
        <td><input type="TEXT"   name=mobile  VALUE="<%if(mobile!=null)out.print(mobile);%>" SIZE=40 MAXLENGTH=40>(?????????????????????????????????)</td>
          <td  >* <%=r.getString(teasession._nLanguage, "EmailAddress")%></td><!--????????????-->
        <td><input type="TEXT"   name=email VALUE="<%if(email!=null)out.print(email);%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
         <tr>
        <td><%=r.getString(teasession._nLanguage, "Photograph")%><!--??????--></td>
        <td colspan="3"><%--<iframe src="PhotoUp.jsp" frameborder="0" scrolling="no" width="400" height="40"></iframe> --%>
          <input type=file name="photo" size="40" >
          <%
          if(len>0)
          {//,'height=300,width=400,top=200,left=300'
            out.print("<a href=### onclick=\"window.open('about:blank','','width=90,height=120').document.write('<img src=" + photopath + " onload=window.resizeTo(this.width+30,this.height+50) >'); \">"+len+r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input id=CHECKBOX type=CHECKBOX onclick=form1.photo.disabled=this.checked name=clear>"+r.getString(teasession._nLanguage, "Clear"));
          }
          out.print("<br>"+r.getString(teasession._nLanguage, "1167469191265"));//<!--?????????90X120 pixels-->
          %>
          </td>
      </tr>

      <%--


           <!--td >*</strong>??????</td>
        <td><input  name=age type="TEXT"   VALUE="<%=profile.getAge()==0?"":String.valueOf(profile.getAge())%>" maxlength="2" >          ???
          </td-->

<!--        <tr>
        <td>*
          <%=r.getString(teasession._nLanguage, "LastName")%>: </td>
        <td> <input type="TEXT"   name=lastname value="<%if(lastname!=null)out.print(lastname);%>" size=20 maxlength=20></td>
      </tr>
-->

            <tr>
        <td  ><%=r.getString(teasession._nLanguage, "Telephone")%><!--??????--></td>
        <td><input type="TEXT"   name=telephone  VALUE="<%if(telephone!=null)out.print(telephone);%>" SIZE=40 MAXLENGTH=40></td>
      </tr>


      <tr>
        <td ><%=r.getString(teasession._nLanguage, "1167469217921")%><!--??????--></td>
        <td><%=new tea.htmlx.CountrySelection("nationality",teasession._nLanguage,nationality)%>
        </td></tr>
        <tr><td ><%=r.getString(teasession._nLanguage, "1167469238859")%><!--????????????--></td>
        <td><%=new tea.htmlx.CountrySelection("gblnd",teasession._nLanguage,gblnd)%>
        </td>
        </tr>
        <tr><td ><%=r.getString(teasession._nLanguage, "1167469260593")%><!--?????????--></td>
          <td>
            <select name="gbort">
              <option value="">-------------</option>
              <%
              for(int index=0;index<Common.PROVINCE.length;index++)
              {
                out.print("<option value="+Common.PROVINCE[index]);
                if(Common.PROVINCE[index].equals(gbort))
                out.print(" selected");
                out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]));
              }
              %>
            </select>
          </td>
</tr>
<tr>
        <td ><%=r.getString(teasession._nLanguage, "1167469283875")%><!--????????????--></td>
        <td><select   name="famst">
        <%
        for(int index=0;index<Common.FAMST_TYPE.length;index++)
        {
          out.print("<option value="+index);
          if(famst==index)
          out.print(" SELECTED ");
          out.print(">"+Common.FAMST_TYPE[index]+"</option>");
        }
        %>
</select>
</td>
</tr>
<!--
<tr>
<td ><%=r.getString(teasession._nLanguage, "1167469309671")%>?????????????????????<BR>??????????????????</td>
<td>
<%
out.print(new tea.htmlx.TimeSelection("famdt", famdt));

%>
</td>
</tr>


<tr>
<td ><%=r.getString(teasession._nLanguage, "1167469332703")%>????????????</td>
<td>
<input type="text"   name="anzkd" value="<%=anzkd%>"/>
</td>
</tr>
-->
<tr>
  <td ><%=r.getString(teasession._nLanguage, "1167469359000")%><!--???????????????--></td>
  <td>
    <input type="text" name="zzhkszd"   value="<%if(zzhkszd!=null)out.print(zzhkszd);%>"/>
  </td>
</tr>
<tr>
  <td ><%=r.getString(teasession._nLanguage, "1167469386031")%><!--????????????????????????--></td>
  <td>
    <input name="zzgatwj" type="radio"  id="zzgatwj_true"  value="true"  <%if(zzgatwj)out.print(" checked ");%>><label for="zzgatwj_true"><%=r.getString(teasession._nLanguage, "1167469410921")%><!--???--></label>
      <input name="zzgatwj" type="radio" id="zzgatwj_false"   value="false" <%if(!zzgatwj)out.print(" checked ");%>><label for="zzgatwj_false"><%=r.getString(teasession._nLanguage, "1167469442484")%><!--???--></label>
  </td>
  </tr>
  <tr>
<td ><%=r.getString(teasession._nLanguage, "1167469462734")%><!--??????????????????--></td>
<td>
<input name="zznyhk" type="radio"  id="zznyhk_true"   value="true" <%if(zznyhk)out.print(" checked ");%>><label for="zznyhk_true"><%=r.getString(teasession._nLanguage, "1167469410921")%><!--???--></label>
<input name="zznyhk" type="radio"  id="zznyhk_false"   value="false" <%if(!zznyhk)out.print(" checked ");%>><label for="zznyhk_false"><%=r.getString(teasession._nLanguage, "1167469442484")%><!--???--></label>
</td>
</tr>
<!--<tr><td ><%=r.getString(teasession._nLanguage, "1167469499125")%>????????????</td>
<td><select name="zzpridn">
<option value=""></option>
<%
for(int index=0;index<Common.ZZPRIDN.length;index++)
{
 out.print("<option value="+Common.ZZPRIDN[index][0]);
 if(Common.ZZPRIDN[index][0].equals(zzpridn))
 out.print(" selected");
 out.print(" >"+Common.ZZPRIDN[index][1]);
}
%>
</select>
</td></tr>
<tr>
<td ><%=r.getString(teasession._nLanguage, "1167469528031")%>????????????</td>
<td><select name="zzfmbkg">
<option value="">-</option>
<%
for(int index=0;index<Common.ZZFMBKG.length;index++)
{
 out.print("<option value="+Common.ZZFMBKG[index][0]);
 if(Common.ZZFMBKG[index][0].equals(zzfmbkg))
 out.print(" selected");
 out.print(" >"+Common.ZZFMBKG[index][1]);
}
%>
</select>
</td>
</tr>-->

      	              <tr>
        <td ><%=r.getString(teasession._nLanguage, "1167469569609")%><!--????????????--></td>
        <td><input  name="zip" type="text" value="<%if(zip!=null)out.print(zip);%>"></td>
      </tr>

--%>



    </table>

    <h2><%=r.getString(teasession._nLanguage,"????????????")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width="140" align="right" valign="baseline"><span class="alert"><strong></strong></span><strong><%=r.getString(teasession._nLanguage,"??????1")%><!--??????--></strong></td>
    <td>
      <select name="sprsl" >
      <option value="0">--------</option>
      <%
      for(int index=0;index<Lang.SPRSL_TYPE.length;index++)
      {
        out.print("<option value="+Lang.SPRSL_TYPE[index][0]);
          if(Lang.SPRSL_TYPE[index][0].equals(l.getSprsl()))
         out.print(" SELECTED");
        out.print(" >"+Lang.SPRSL_TYPE[index][1]);
      }
      %>
      </select>
    </td>
    <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"??????")%><!--????????????--></strong></td>
    <td><font size="2">
      <select name="ztlnl">
       <option value="0">--------</option>
      <%
      for(int index=0;index<Lang.TYPE.length;index++)
      {
        out.print("<option value="+Lang.TYPE[index][0]);
        if(Lang.TYPE[index][0].equals(l.getZtlnl()))
          out.print(" SELECTED");
        out.print(" >"+Lang.TYPE[index][1]);
      }
      %>
      </select>
</font>
    </td>
     </tr>
              <tr>
    <td width="140" align="right"><span class="alert"><strong></strong></span><strong><%=r.getString(teasession._nLanguage,"??????2")%><!--??????--></strong></td>
    <td>
      <select name="sprs2" >
       <option value="0">--------</option>
      <%
      for(int index=0;index<Lang.SPRSL_TYPE.length;index++)
      {
        out.print("<option value="+Lang.SPRSL_TYPE[index][0]);
          if(Lang.SPRSL_TYPE[index][0].equals(l2.getSprsl()))
         out.print(" SELECTED");
        out.print(" >"+Lang.SPRSL_TYPE[index][1]);
      }
      %>
      </select>
    </td>
    <td align="right" ><strong><%=r.getString(teasession._nLanguage,"??????")%><!--????????????--></strong></td>
    <td><font size="2">
      <select name="ztln2">
       <option value="0">--------</option>
      <%
      for(int index=0;index<Lang.TYPE.length;index++)
      {
        out.print("<option value="+Lang.TYPE[index][0]);
        if(Lang.TYPE[index][0].equals(l2.getZtlnl()))
         out.print(" SELECTED");
        out.print(" >"+Lang.TYPE[index][1]);
      }
      %>
      </select>
</font>
    </td>
     </tr>
</table>






      <h2><%=r.getString(teasession._nLanguage, "????????????")%><!----></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td  >*&nbsp;<%=r.getString(teasession._nLanguage,"1167464711468")%><!--????????????--></td>
        <td><textarea  name="selfvalue" rows="4" cols="60" id="selfvalue"><%if(rsobj.getSelfvalue()!=null)out.print(rsobj.getSelfvalue());%></textarea>
          <br>
          <%=r.getString(teasession._nLanguage,"1167530983984")%><!--?????????????????????????????????200?????? <a href="javascript:alert(&quot;???????????????&quot;+document.all['selfvalue'].value.length+&quot;?????????&quot;);">????????????</a>???-->
          <br>
      </tr>
     </table>
     <h2><%=r.getString(teasession._nLanguage, "????????????")%><!----></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td >&nbsp;&nbsp;&nbsp;<%=r.getString(teasession._nLanguage,"1167464750687")%><!--????????????--></td>
        <td>
          <textarea  name="selfaim" rows="7" cols="60" id="selfaim"><%if(rsobj.getSelfaim()!=null)out.print(rsobj.getSelfaim());%></textarea>
          <br>
          <%=r.getString(teasession._nLanguage,"1167531049843")%><!--????????????????????????????????????????????????500??????<a id="linkObjectCN" href="javascript:alert(&quot;???????????????&quot;+document.all['selfaim'].value.length+&quot;?????????&quot;);">????????????</a>???-->
          <br>
        </td>
      </tr>
     </table>
    <h2><%=r.getString(teasession._nLanguage, "1167469640031")%><!--????????????--></h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <!-- <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469656937")%>????????????</td>
        <td><input type="text" name="joinu" value="<%if(joinu!=null)out.print(joinu);%>"/>
        </td></tr>
              <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469680718")%>????????? 1</td>
        <td><input type="text" name="intr1" value="<%if(intr1!=null)out.print(intr1);%>"/>
        </td></tr>
        <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469680718")%>????????? 2</td>
        <td><input type="text" name="intr2" value="<%if(intr2!=null)out.print(intr2);%>"/>
        </td></tr>
<tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469680718")%>????????? 3</td>
        <td><input type="text" name="intr3" value="<%if(intr3!=null)out.print(intr3);%>"/>
        </td></tr>
      <tr>
      -->
        <td  ><%=r.getString(teasession._nLanguage, "???????????????")%><!--???????????????--></td>
        <td>
           <SELECT name="nowmaincareer" >
               <%
               for(int index=0;index<Common.ZCSZY.length;index++)
               {
                 out.print("<option value="+Common.ZCSZY[index][0]);
                 if(Common.ZCSZY[index][0].equals(nowmaincareer))
                 out.print(" SELECTED ");
                 out.print(">"+Common.ZCSZY[index][1]+"</option>");
               }
               %>
           </SELECT>
</td>
      </tr>
      <%--
      <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469724250")%><!--?????????????????????--></td>
        <td><input type="text" name="zxrgs" value="<%if(zxrgs!=null)out.print(zxrgs);%>"/>
        </td>
      </tr>
      --%>
      <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469749625")%><!--???????????????--></td>
        <td noWrap><select  name="nowcareerlevel" >
        <option value="">----------------</option>
        <%
        for(int index=0;index<Common.ZZWJB.length;index++)
        {
          out.print("<option value="+Common.ZZWJB[index][0]);
          if(Common.ZZWJB[index][0].equals(nowcareerlevel))
          out.print(" SELECTED");
          out.print(" >"+Common.ZZWJB[index][1]);
        }
        %>
          </select> <%=r.getString(teasession._nLanguage, "???????????????????????????")%><!--???????????????????????????-->
        </td>
      </tr>
      <tr>
        <td  >* <%=r.getString(teasession._nLanguage, "1167457783859")%><!--????????????--></td>
        <td><input  onKeyUp="" name="experience" type="text" maxlength="2" onKeyPress= "return regInput(this,	/^\d*\.?\d{0,2}$/,		String.fromCharCode(event.keyCode))"
		onpaste		= "return regInput(this,/^\d*\.?\d{0,2}$/,		window.clipboardData.getData('Text'))"
		ondrop		= "return regInput(this,/^\d*\.?\d{0,2}$/,	event.dataTransfer.getData('Text'))" size="2" value="<%=experience%>" /><%=r.getString(teasession._nLanguage, "1167448647531")%><!--???-->
         <%=r.getString(teasession._nLanguage, "1167469828781")%><!--?????????????????????????????????????????????0???-->
        </td>
      </tr>
      <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469873421")%><!--???????????????????????????--></td>
        <td><input id="Has_Abroad_0" type="radio" name="has_abroad" value="true" <%if(has_abroad)out.print("checked");%> /><label for="Has_Abroad_0"><%=r.getString(teasession._nLanguage, "1167469410921")%><!--???--></label>
             <input id="Has_Abroad_1" type="radio" name="has_abroad" value="false"  <%if(!has_abroad)out.print("checked");%>/><label for="Has_Abroad_1"><%=r.getString(teasession._nLanguage, "1167469442484")%><!--???--></label>
</td>
      </tr>
     <%--  <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167465192609")%><!--????????????????????????--></td>
        <td>
          ???<input  name="salarysum" type="text" maxlength="7" size="8" value="<%if(salarysum!=null)out.print(salarysum);else out.print("0.00");%>" /><%=r.getString(teasession._nLanguage, "1167470009906")%><!--??? --><br>
        </td>
      </tr>
           <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167469987031")%>????????????????????????</td>
        <td>
          <select  name="zwaers_yx" >
            <option value="CNY"><%=r.getString(teasession._nLanguage, "1167470028781")%>?????????
              <option value="USD" <%if("USD".equals(zwaers_yx))out.print(" SELECTED");%>><%=r.getString(teasession._nLanguage, "1167470049078")%>??????
          </select>
        </td>
      </tr>--%>

    </table>
<h2><%=r.getString(teasession._nLanguage, "1167464788390")%><!--????????????--></h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td ><%=r.getString(teasession._nLanguage, "1167470089703")%><!--??????????????????--></td>
        <td >
             <input name="zqwgz" type="radio" value="1" checked  /><%=r.getString(teasession._nLanguage, "1167447115546")%><!--??????-->
             <input type="radio" name="zqwgz" value="2" <%if(2==zqwgz)out.print(" checked ");%>/><%=r.getString(teasession._nLanguage, "1167447133937")%><!--??????-->
             <input type="radio" name="zqwgz" value="3" <%if(3==zqwgz)out.print(" checked ");%>/><%=r.getString(teasession._nLanguage, "1167447161953")%><!--??????-->
             <input type="radio" name="zqwgz" value="4" <%if(4==zqwgz)out.print(" checked ");%>/><%=r.getString(teasession._nLanguage, "1167447180562")%><!--??????-->
             </td></tr>
             <TR>
        <TD >* <%=r.getString(teasession._nLanguage, "1167460620765")%><!--??????????????????--><br>
          <%=r.getString(teasession._nLanguage, "1167470204875")%><!--?????????5??????--></TD>
        <td vAlign="top">
          <select style="WIDTH: 160px" size="5" name="srcexpectcareer" ondblclick="form1.expectcareer_add.onclick();">
          <%
          java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(community));

          for(int index=0;bigOcc.hasMoreElements();index++)
          {
            int occupation=((Integer)bigOcc.nextElement()).intValue();
            Occupation occ_obj=Occupation.find(occupation);
            out.print("<option value="+occ_obj.getCode()+" >"+occ_obj.getSubject()+"</option>");

            java.util.Enumeration smallOcc=Occupation.findByFather(occupation);
            for(int smallindex=0;smallOcc.hasMoreElements();smallindex++)
            {
              occupation=((Integer)smallOcc.nextElement()).intValue();
              occ_obj=Occupation.find(occupation);
              out.print("<option value="+occ_obj.getCode()+">-- "+occ_obj.getSubject()+"</option>");
            }
          }
          /*
          for(int index=0;index<Common.ZGZ.length;index++)
          {
            out.print("<option value="+Common.ZGZ[index][0]+" >"+Common.ZGZ[index][1]);
          }*/
          %>
          </select>
        </td>
        <td>
        <!--??????&gt;&gt;-->
<input   style="WIDTH: 60px" type="button" name="expectcareer_add" value="<%=r.getString(teasession._nLanguage, "1167446148625")%>" onClick="if(document.form1.expectcareer.options.length>4){alert('<%=r.getString(teasession._nLanguage, "1167470204875")%>');return;}move(document.form1.srcexpectcareer,document.form1.expectcareer);" >
          <br>
          <!--&lt;&lt;??????-->
          <input   style="WIDTH: 60px" type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"  onclick="move(form1.expectcareer,form1.srcexpectcareer);">
</td>
        <td vAlign="top" width="33%">
          <input type="hidden" name="expectcareer_value" value=""/>
          <select style="WIDTH: 160px" size="5" name="expectcareer" ondblclick="move(form1.expectcareer,form1.srcexpectcareer);">
            <%
            if(expectcareer!=null)
            {
              String arr[]=expectcareer.split("/");
              for(int i=1;i<arr.length;i++)
              {
                Occupation o=Occupation.find(teasession._strCommunity,arr[i]);
                if(o.isExists())
                {
                  if(i == 1){
                    out.print("<option value="+arr[i]+" selected>"+o.getSubject());
                  }else{
                    out.print("<option value="+arr[i]+" >"+o.getSubject());
                  }
                }
              }
            }%>
          </select>
         </td>
      </tr>
      <tr>
        <td   rowSpan="2">* <%=r.getString(teasession._nLanguage, "1167461717421")%><!--??????????????????--><br>
         <%=r.getString(teasession._nLanguage, "1167470204875")%><!-- ?????????5??????--></td>
      </tr>
      <tr>
        <td vAlign="top">
          <select style="WIDTH: 160px" size="5" name="srcexpectcity" ondblclick="form1.expectcity_add.onclick();">
          <%
          java.util.Enumeration bigjobcity=Jobcity.findByFather(Jobcity.getRootId(community));
          for(int index=0;bigjobcity.hasMoreElements();index++)
          {
            int occupation=((Integer)bigjobcity.nextElement()).intValue();
            Jobcity occ_obj=Jobcity.find(occupation);
            out.print("<option value="+occ_obj.getCode()+" >"+occ_obj.getSubject()+"</option>");

            java.util.Enumeration smallOcc=Jobcity.findByFather(occupation);
            for(int smallindex=0;smallOcc.hasMoreElements();smallindex++)
            {
              occupation=((Integer)smallOcc.nextElement()).intValue();
              occ_obj=Jobcity.find(occupation);
              out.print("<option value="+occ_obj.getCode()+">-- "+occ_obj.getSubject()+"</option>");
            }
          }
          /*
          for(int index=0;index<Common.PROVINCE.length;index++)
          {
            out.print("<option value="+Common.PROVINCE[index]);
            out.print(">"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]));
          }*/
          %>
          </select>
</td>
        <td> <!--??????&gt;&gt;-->
          <input   style="WIDTH: 60px" name="expectcity_add" type="button" value="<%=r.getString(teasession._nLanguage, "1167446148625")%>"  onclick="if(document.form1.expectcity.options.length>4){alert('<%=r.getString(teasession._nLanguage, "1167470204875")%>');return;}move(document.form1.srcexpectcity,document.form1.expectcity);" >
          <br>
          <!--&lt;&lt;??????-->
          <input   style="WIDTH: 60px" type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onClick="move(form1.expectcity,form1.srcexpectcity);"  >
          </td>
        <td vAlign="top" width="33%">
          <input type="hidden" name="expectcity_value" value=""/>
          <select  style="WIDTH: 160px" size="5" name="expectcity" ondblclick="move(form1.expectcity,form1.srcexpectcity);">
            <%
            if(expectcity!=null)
            {
              String arr[]=expectcity.split("/");
              for(int i=1;i<arr.length;i++)
              {
                String text="";
                for(int index=0;index<Common.PROVINCE.length;index++)
                if(Common.PROVINCE[index].equals(arr[i]))
                {
                  text=r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]);
                  break;
                }
                if(i == 1){
                  out.print("<option value="+arr[i]+" selected>"+text);
                }else{
                  out.print("<option value="+arr[i]+">"+text);
                }
              }
            }%>
          </select>
        <script type="">
        for(var index=0;index<document.form1.expectcareer.options.length;index++)
        {
          for(var j=0;j<document.form1.srcexpectcareer.options.length;j++)
          {
            if(document.form1.srcexpectcareer.options[j].value==document.form1.expectcareer[index].value)
            {
              document.form1.srcexpectcareer.options[j]=null;
            }
          }
        }
        for(var index=0;index<document.form1.expectcity.options.length;index++)
        {
          for(var j=0;j<document.form1.srcexpectcity.options.length;j++)
          {
            if(document.form1.srcexpectcity.options[j].value==document.form1.expectcity.options[index].value)
            {
              document.form1.srcexpectcity.options[j]=null;
            }
          }
        }
        </script>
        </td>
      </tr>
      <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167464827921")%><!--????????????????????????--></td>
        <td colSpan="3">
          <input  name="expectsalarysum" type="text" maxlength="7" size="8"  value="<%if(expectsalarysum!=null)out.print(expectsalarysum);else out.print("0.00");%>" />??? ??????????????????
      </tr>
     <%--  <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167470468515")%><!--????????????????????????--></td>
        <td colSpan="3">
          <select name="zwaers_qwyx">
          <option value="CNY"><%=r.getString(teasession._nLanguage, "1167470028781")%><!--?????????--></option>
          <option value="USD"<%if("USD".equals(zwaers_qwyx))out.print(" SELECTED");%>><%=r.getString(teasession._nLanguage, "1167470049078")%><!--??????--></option>
      </td></tr>--%>
      <tr>
        <td  ><%=r.getString(teasession._nLanguage, "1167465105562")%><!--????????????--></td>
        <td colSpan="3"><select name="joindatetype">
            <option value="1" selected><%=r.getString(teasession._nLanguage, "1167470553578")%><!--??????--></option>
            <option value="2"<%if(joindatetype==2)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "1167470574390")%><!--??????--></option>
            <option value="3"<%if(joindatetype==3)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "????????????")%><!--1?????????--></option>
            <option value="4"<%if(joindatetype==4)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "????????????")%><!--1?????????--></option>
            <option value="5"<%if(joindatetype==5)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "1~3??????")%><!--1???3??????--></option>
            <option value="6"<%if(joindatetype==6)out.print(" selected ");%>><%=r.getString(teasession._nLanguage, "????????????")%><!--3?????????--></option>
          </select>
</td>
      </tr>
    </table>
    <br>


    <P ALIGN=CENTER>
     <input   name="educate" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>" type="submit" >
     <%--
     <input type=SUBMIT name="GoFinish" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">

          <%if(tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString())){%>
          <input type="submit" name="GoBack" id="edit_GoBack"  value="<%=r.getString(teasession._nLanguage, "Super")%>"  onClick="return save_onclick();">
<%}%

></P>
--%>

  </FORM>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

<br>
</body>
</HTML>

