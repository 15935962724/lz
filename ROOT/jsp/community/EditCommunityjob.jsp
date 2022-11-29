<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/Job");

String community=teasession._strCommunity;


int occ=0;
if(request.getParameter("bigList")!=null)
occ = Integer.parseInt(request.getParameter("bigList"));

Communityjob obj = Communityjob.find(teasession._strCommunity);

long logolen=0,a0len=0,a1len=0,a2len=0,a3len=0;
if(obj.isExists())
{
  if(obj.getLogo()!=null)
  logolen=new java.io.File(application.getRealPath(obj.getLogo())).length();

  if(obj.getApplytable()!=null)
  a0len=new java.io.File(application.getRealPath(obj.getApplytable())).length();

  if(obj.getApplytable2()!=null)
  a1len=new java.io.File(application.getRealPath(obj.getApplytable2())).length();

  if(obj.getApplytable3()!=null)
  a2len=new java.io.File(application.getRealPath(obj.getApplytable3())).length();

  if(obj.getApplytable4()!=null)
  a3len=new java.io.File(application.getRealPath(obj.getApplytable4())).length();
}
%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function submitSelect(select, alerttext)
{
  if( select.selectedIndex==-1)
  {
    alert(alerttext);
    select.focus();
    return false;
  }
  return true;
}
function fload()
{
  for(var i=0;i<form1.rolejob.options.length;i++)
  {
    var value=form1.rolejob.options[i].value;
    form1.rolecom.options[i]=new Option(form1.rolejob.options[i].text,value);
    form1.roleapp.options[i]=new Option(form1.rolejob.options[i].text,value);
    form1.roleresume.options[i]=new Option(form1.rolejob.options[i].text,value);
    if(value=="<%=obj.getRolejob()%>")
    {
      form1.rolejob.options[i].selected=true;
    }
    if(value=="<%=obj.getRoleresume()%>")
    {
      form1.roleresume.options[i].selected=true;
    }
    if(value=="<%=obj.getRoleapp()%>")
    {
      form1.roleapp.options[i].selected=true;
    }
    if(value=="<%=obj.getRolecom()%>")
    {
      form1.rolecom.options[i].selected=true;
    }
  }
  form1.jobsystem.disabled=false;
}
</script>
</HEAD>
<body onLoad="fload();" >
<h1><%=r.getString(teasession._nLanguage,"1167991129000")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityjob" method="POST" enctype="multipart/form-data" onSubmit="return(submitInteger(this.resume, '<%=r.getString(teasession._nLanguage,"1167991204484")%>')&&submitInteger(this.job, '<%=r.getString(teasession._nLanguage,"1167991204484")%>')&&submitInteger(this.company, '<%=r.getString(teasession._nLanguage,"1167991204484")%>'))">
<input type="hidden" name="community" value="<%=community%>"/>
<input name="action"   type="hidden" value="jobsystem">

<h2><%=r.getString(teasession._nLanguage,"1167991617546")%><!--=简历相关设置--></h2>
<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167991204484")%>
      <!--简历-->:</td>
    <td><input type="text" class="edit_input" value="<%=obj.getResume()%>"  name="resume">
      先要在前台创建类别是简历的节点并设置于此，本社区创建的简历将存放于该节点下。</td>
  </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991240234")%><!--职位-->:</td>
      <td><input type="text"  class="edit_input" name="job" value="<%=obj.getJob()%>">
      先要在前台创建类别是职位的节点并设置于此，本社区创建的职位将存放于该节点下。</td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991267171")%><!--公司-->:</td>
      <td><input type="text" class="edit_input" value="<%=obj.getCompany()%>"  name="company">
      先要在前台创建类别是公司的节点并设置于此，本社区创建的公司将存放于该节点下。</td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991307156")%><!--反馈-->:</td>
      <td><input type="text"  class="edit_input" value="<%=obj.getTalkbacks()%>" name="talkbacks">
      先要在前台创建类别是留言板的节点并设置于此，用户在使用招聘系统时提交的问题反馈后存放于该节点下。 </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"Job")%>:</td>
      <td><input type="text"  class="edit_input" value="<%=obj.getMaxSum()%>" name="maxsum">
      一份简历最多申请的职位数.0表示:无限制</td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991326609")%><!--管理员-->:</td>
      <td><input type="text"  class="edit_input" value="<%if(obj.getJobmember()!=null)out.print(obj.getJobmember());%>" name="jobmember">
      后台招聘管理超级管理员      </td>
    </tr>
    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991371578")%><!--小Logo-->:</td>
      <td><input type="file" name="logo" /><%if(logolen>0)out.print(logolen+r.getString(teasession._nLanguage,"Bytes"));%><input onClick="form1.logo.disabled=this.checked;" type="checkbox" name="logoclear" value=""/><%=r.getString(teasession._nLanguage,"Clear")%>　　用于没有传照片的简历，显示的默认图片。</td>
    </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage,"Applytable")%>1:</td>
        <td><input type="file" name="applytable0" /><%if(a0len>0)out.print("<A href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getApplytable(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getApplytablename(),"UTF-8")+" >"+a0len+r.getString(teasession._nLanguage,"Bytes")+"</a>");%><input onClick="form1.applytable0.disabled=this.checked;" type="checkbox" name="applytable0clear" value=""/><%=r.getString(teasession._nLanguage,"Clear")%>　　用于创建简历时要求会员下载填写申请表。</td>
      </tr>
            <tr>
        <td nowrap><%=r.getString(teasession._nLanguage,"Applytable")%>2:</td>
        <td><input type="file" name="applytable1" /><%if(a1len>0)out.print("<A href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getApplytable2(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getApplytablename2()+"","UTF-8")+" >"+a1len+r.getString(teasession._nLanguage,"Bytes")+"</a>");%><input onClick="form1.applytable1.disabled=this.checked;" type="checkbox" name="applytable1clear" value=""/><%=r.getString(teasession._nLanguage,"Clear")%>　　同上</td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage,"Applytable")%>3:</td>
        <td><input type="file" name="applytable2" /><%if(a2len>0)out.print("<A href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getApplytable3(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getApplytablename3(),"UTF-8")+" >"+a2len+r.getString(teasession._nLanguage,"Bytes")+"</a>");%><input onClick="form1.applytable2.disabled=this.checked;" type="checkbox" name="applytable2clear" value=""/><%=r.getString(teasession._nLanguage,"Clear")%>　　同上</td>
      </tr>
      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage,"Applytable")%>4:</td>
        <td><input type="file" name="applytable3" /><%if(a3len>0)out.print("<A href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(obj.getApplytable4(),"UTF-8")+"&name="+java.net.URLEncoder.encode(obj.getApplytablename4(),"UTF-8")+" >"+a3len+r.getString(teasession._nLanguage,"Bytes")+"</a>");%><input onClick="form1.applytable3.disabled=this.checked;" type="checkbox" name="applytable3clear" value=""/><%=r.getString(teasession._nLanguage,"Clear")%>　　同上</td>
      </tr>

      <tr>
        <td nowrap><%=r.getString(teasession._nLanguage,"Options")%>:</td><td><input name="confederacy"  id="CHECKBOX" type="CHECKBOX" <%if((obj.getOptions()&1)!=0)out.print(" CHECKED ");%> value=""><%=r.getString(teasession._nLanguage,"1167991442468")%>如果设为邦定，则没有上传申请表的简历会被认为是不完整简历，不能申请职位       <!--申请表是否邦定简历--></td>
      </tr>
        <tr>
          <td nowrap><%=r.getString(teasession._nLanguage,"1167991470234")%><!--职位角色-->:</td>
          <td>
          <select name="rolejob">
          <option value="0">---------------</option>
          <%
          java.util.Enumeration ar_enumer= AdminRole.find1ByCommunity(teasession._strCommunity,teasession._nStatus);
          for(int intCount=1;ar_enumer.hasMoreElements();intCount++)
          {
            int id=((Integer)ar_enumer.nextElement()).intValue();
            AdminRole ar_obj=AdminRole.find(id);
            out.print("<option value="+id+" >"+ar_obj.getName());
          }
          %>
          </select>
          定义后台哪个角色可以管理职位 </td>
        </tr>
            <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991489500")%><!--简历角色-->:</td>
      <td><select name="roleresume"></select>
        定义后台哪个角色可以管理简历 </td>
    </tr>
        <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991510859")%><!--应聘角色-->:</td>
      <td><select name="roleapp"></select>
        定义后台哪个角色可以管理应聘信息</td>
    </tr>
        <tr>
      <td nowrap><%=r.getString(teasession._nLanguage,"1167991530375")%><!--公司角色-->:</td>
      <td><select name="rolecom"></select>
        定义后台哪个角色可以管理招聘公司</td>
    </tr>
            <tr>
          <td nowrap><td><input name="jobsystem" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>" class="edit_button" disabled="disabled"  type="submit">
        </tr>
  </table>
</form>


<table border="0" cellspacing="0" cellpadding="0" id="tablecenter" >
<tr><td>

<h2><%=r.getString(teasession._nLanguage,"SetOccType")%><!--职业类别设置--></h2>
<form name="form2"  action="/servlet/EditCommunityjob" method="POST"  >

<input type="hidden" name="community" value="<%=community%>"/>
 <input name="action"  type="hidden" value="occupation">


 <table border="0" cellspacing="0" cellpadding="0" id="tablecenter" >
   <tr>
    <td><select name="occupation"  size="15" onChange="fchange2(this);" style="WIDTH: 200px">
      <%
      int selBigList;
      try
      {
        selBigList=Integer.parseInt(request.getParameter("occupation"));
      } catch (Exception ex)
      {
        selBigList=-1;
      }
      java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(community));
      int occupation;
      StringBuffer sb=new StringBuffer();
      for(int index=0;bigOcc.hasMoreElements();index++)
      {
        occupation=((Integer)bigOcc.nextElement()).intValue();
        Occupation occ_obj=Occupation.find(occupation);
        out.print("<option ");
        if(selBigList==occupation)out.print(" SELECTED ");
        out.print("value="+occupation+">"+occ_obj.getSubject()+"</option>");

        sb.append("case "+occupation+":form2.subject.value=\""+occ_obj.getSubject().replaceAll("\"","&quot;")+"\";form2.code.value=\""+occ_obj.getCode().replaceAll("\"","&quot;")+"\";form2.addsub.disabled=false;break;\r\n");
        java.util.Enumeration smallOcc=Occupation.findByFather(occupation);
        for(int smallindex=0;smallOcc.hasMoreElements();smallindex++)
        {
          occupation=((Integer)smallOcc.nextElement()).intValue();
          occ_obj=Occupation.find(occupation);
          sb.append("case "+occupation+":form2.subject.value=\""+occ_obj.getSubject().replaceAll("\"","&quot;")+"\";form2.code.value=\""+occ_obj.getCode().replaceAll("\"","&quot;")+"\";form2.addsub.disabled=true;break;\r\n");
          out.print("<option ");
          if(selBigList==occupation)out.print(" SELECTED ");
          out.print("value="+occupation+">-- "+occ_obj.getSubject()+"</option>");
        }
      }
      %>
</select>
<!--请选择要向上的项-->
<input  type="submit" onClick="return(submitSelect(form2.occupation, '<%=r.getString(teasession._nLanguage,"1167992041937")%>'))" name="bigup" value="↑"/>
<!--请选择要向下的项-->
<input type="submit" onClick="return(submitSelect(form2.occupation, '<%=r.getString(teasession._nLanguage,"1167992090609")%>'))" name="bigdown" value="↓"/>
    </td>
    <td>&nbsp;      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%>
    <input  name="subject" type="text" class="edit_input" value="" size="40"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Code")%>
    <input  name="code" type="text" class="edit_input" value="" maxlength="10"></td>
  </tr>
  <tr>
    <td>
        <input name="add" onClick="return(submitText(form2.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>'))" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"Add")%>">
        <input name="edit" onClick="return(submitSelect(form2.bigList, '<%=r.getString(teasession._nLanguage,"1167992160078")%>')&&submitText(form2.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitText(form2.code, '<%=r.getString(teasession._nLanguage,"1167992187906")%>'));" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
        <input name="addsub" onClick="return(submitSelect(form2.bigList, '<%=r.getString(teasession._nLanguage,"1167992234750")%>')&&submitText(form2.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitText(form2.code, '<%=r.getString(teasession._nLanguage,"1167992187906")%>'));" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"1167992267125")%>">
        <input type="submit" onClick="return(submitSelect(form2.bigList, '<%=r.getString(teasession._nLanguage,"1167992286421")%>')&&(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')))"  class="edit_button" value="<%=r.getString(teasession._nLanguage,"Delete")%>"  name="delbig">
        <br>
        <br>
        －－定义本社区招聘时的职业类别选项</td>

    <td>&nbsp;
    </td>
  </tr>
</table>
<script type="">
function fchange2(obj)
{
   switch(parseInt(obj.value))
   {
     <%=sb.toString()%>
   }
}
fchange2(form2.occupation);
</script>
</form>

</td>


<!--================================================================================================-->

<td>

<h2><%=r.getString(teasession._nLanguage,"1167992358625")%><!--工作地区设置--></h2>
<form name="form3" action="/servlet/EditCommunityjob" method="POST"  >

<input type="hidden" name="community" value="<%=community%>"/>
 <input name="action"  type="hidden" value="jobcity">


 <table border="0" cellspacing="0" cellpadding="0" id="tablecenter" >
   <tr>
    <td><select name="jobcity"  size="15" onChange="fchange3(this);" style="WIDTH: 200px">
      <%
      int jobcity;
      try
      {
        jobcity=Integer.parseInt(request.getParameter("jobcity"));
      } catch (Exception ex)
      {
        jobcity=-1;
      }

      java.util.Enumeration jobcit_big=Jobcity.findByFather(Jobcity.getRootId(community));
      StringBuffer jobcit_sb=new StringBuffer();
      for(int index=0;jobcit_big.hasMoreElements();index++)
      {
        int id=((Integer)jobcit_big.nextElement()).intValue();
        Jobcity jcobj=Jobcity.find(id);
        out.print("<option ");
        if(jobcity==id)out.print(" SELECTED ");
        out.print("value="+id+">"+jcobj.getSubject()+"</option>");

        jobcit_sb.append("case "+id+":form3.subject.value=\""+jcobj.getSubject().replaceAll("\"","&quot;")+"\";form3.code.value=\""+jcobj.getCode().replaceAll("\"","&quot;")+"\";form3.addsub.disabled=false;break;\r\n");
        java.util.Enumeration jobcit_small=Jobcity.findByFather(id);
        for(int smallindex=0;jobcit_small.hasMoreElements();smallindex++)
        {
          id=((Integer)jobcit_small.nextElement()).intValue();
          jcobj=Jobcity.find(id);
          jobcit_sb.append("case "+id+":form3.subject.value=\""+jcobj.getSubject().replaceAll("\"","&quot;")+"\";form3.code.value=\""+jcobj.getCode().replaceAll("\"","&quot;")+"\";form3.addsub.disabled=true;break;\r\n");
          out.print("<option ");
          if(jobcity==id)out.print(" SELECTED ");
          out.print("value="+id+">-- "+jcobj.getSubject()+"</option>");
        }
      }
      %>
</select>
<!--请选择要向上的项-->
<input  type="submit" onClick="return(submitSelect(form3.bigList, '<%=r.getString(teasession._nLanguage,"1167992041937")%>'))" name="bigup" value="↑"/>
<!--请选择要向下的项-->
<input type="submit" onClick="return(submitSelect(form3.bigList, '<%=r.getString(teasession._nLanguage,"1167992090609")%>'))" name="bigdown" value="↓"/>
    </td>
    <td>&nbsp;      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%>
    <input  name="subject" type="text" class="edit_input" value="" size="40"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Code")%>
    <input  name="code" type="text" class="edit_input" value="" maxlength="10"></td>
  </tr>
  <tr>
    <td>
        <input name="add" onClick="return(submitText(form3.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>'))" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"Add")%>">
        <input name="edit" onClick="return(submitSelect(form3.bigList, '<%=r.getString(teasession._nLanguage,"1167992160078")%>')&&submitText(form3.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitText(form3.code, '<%=r.getString(teasession._nLanguage,"1167992187906")%>'));" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
        <input name="addsub" onClick="return(submitSelect(form3.bigList, '<%=r.getString(teasession._nLanguage,"1167992234750")%>')&&submitText(form3.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitText(form3.code, '<%=r.getString(teasession._nLanguage,"1167992187906")%>'));" class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"1167992267125")%>">
        <input type="submit" onClick="return(submitSelect(form3.bigList, '<%=r.getString(teasession._nLanguage,"1167992286421")%>')&&(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')))"  class="edit_button" value="<%=r.getString(teasession._nLanguage,"Delete")%>"  name="delbig">
        <br>
        <br>
        －－
        定义本社区招聘时的地区选项    </td>
    <td>&nbsp;
    </td>
  </tr>
</table>
<script type="">
function fchange3(obj)
{
   switch(parseInt(obj.value))
   {
     <%=jobcit_sb.toString()%>
   }
}
fchange3(form3.jobcity);
</script>
</form>
</td></tr>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>


