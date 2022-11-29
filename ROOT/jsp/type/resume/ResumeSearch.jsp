<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String nu=request.getParameter("nexturl");
if(nu==null)
{
  nu="/jsp/type/resume/ResumeManage.jsp";
}

if(request.getMethod().equals("POST"))
{

  int id=Integer.parseInt(request.getParameter("rid"));
  System.out.print(id);
  ResumeSearchWare rsw=ResumeSearchWare.find(id);
  if(request.getParameter("save")!=null)
  {
    String subject=request.getParameter("subject");
//    String sltOccId_list=request.getParameter("sltOccId_list");
String sltOccId_BigClass = request.getParameter("sltOccId_BigClass");

    String expectcity=request.getParameter("expectcity");
    String degree=request.getParameter("degree");
    String sex=request.getParameter("sex");
    String age=(request.getParameter("age"));
    String skr_wrk_year=(request.getParameter("skr_wrk_year"));
    String keyword=request.getParameter("keyword");
    rsw.set(sltOccId_BigClass,expectcity,degree,sex,age,skr_wrk_year,keyword,subject,teasession._rv._strR);
  }else
  if(request.getParameter("del")!=null)
  {
    rsw.delete();
  }
//  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function selectvalue(obj,value)
{
  for(index=0;index<obj.length;index++){
    if(obj[index].value==value)
    {
      obj[index].selected=true;
      break;
    }
  }
}

function selectvalue1(obj,value)
{
  for(index=0;index<obj.length;index++){
    if(Number(obj[index].value)==Number(value))
    {
      obj[index].selected=true;
      break;
    }
  }
}
</script>
</HEAD>

<body><h1><%=r.getString(teasession._nLanguage, "1167466509953")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" METHOD="POST" action="/jsp/type/resume/ResumeManage.jsp">
<input type="hidden" name="id" value="0"/>
<input type="hidden" name="rid" value="0"/>
<input type="hidden" name="nexturl" value="<%=nu%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1167460620765")%><!--期望从事职业--></td>
    <td>
    <SELECT  NAME="sltOccId_BigClass" onchange="alteroption(this.value);" >
    <OPTION VALUE="">--------------------</OPTION>
    <%
    StringBuffer script=new StringBuffer();
    java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(teasession._strCommunity));
    while(bigOcc.hasMoreElements())
    {
      int occupation=((Integer)bigOcc.nextElement()).intValue();
      Occupation occ_obj=Occupation.find(occupation);
      out.print("<option value="+occ_obj.getCode()+" >"+occ_obj.getSubject());

      script.append("case '"+occ_obj.getCode()+"':\r\n");
      java.util.Enumeration smallOcc=Occupation.findByFather(occupation);
      while(smallOcc.hasMoreElements())
      {
        occupation=((Integer)smallOcc.nextElement()).intValue();
        occ_obj=Occupation.find(occupation);
        script.append("objobj.length]=new Option('"+occ_obj.getSubject()+"','"+occ_obj.getCode()+"');");
      }
      script.append("break;\r\n");
    }
    %>
    </select>
    <select name="sltOccId_list" style="display:none">
    <OPTION VALUE="">-----------</OPTION>
    </select>
    <script type="">
    function alteroption(value)
    {
      var obj=form1.sltOccId_list.options;
      while(obj.length>1)
      {
        obj[i]=null;
      }
      switch(value)
      {
        <%=script.toString()%>
      }
      if(obj.length>1)
      {
        form1.sltOccId_list.style.display="";
      }
    }
    </script>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167460801234")%><!--期望地区--></td>
            <td><SELECT NAME="expectcity" >
              <OPTION VALUE="">-----------</OPTION>
              <%
              for(int index=0;index<Common.PROVINCE.length;index++)
              {
                out.print("<option value="+Common.PROVINCE[index]);
                out.print(">"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]));
              }
              %>
              </select>
            </td>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
            <td>
            <%=new tea.htmlx.DegreeSelection("degree",null)%>
            <script type="">form1.degree.options[0]=new Option("------------",""); form1.degree.selectedIndex=0;</script>
            <%--
              <SELECT NAME="degree">
                <OPTION VALUE="" SELECTED>--------</OPTION>
                <OPTION VALUE="0">博士</OPTION>
                <OPTION VALUE="1">MBA</OPTION>
                <OPTION VALUE="2">硕士</OPTION>
                <OPTION VALUE="3">本科</OPTION>
                <OPTION VALUE="4">大专</OPTION>
                <OPTION VALUE="5">中专</OPTION>
                <OPTION VALUE="6">中技</OPTION>
                <OPTION VALUE="7">高中</OPTION>
                <OPTION VALUE="8">初中</OPTION>
              </SELECT>
              --%>
            </td>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167455197453")%><!--性别--></td>
            <td>
              <select name="sex">
                <option value="">--------</option>
                <option value="1" ><%=r.getString(teasession._nLanguage,"1167457951671")%><!--男--></option>
                <option value="0" ><%=r.getString(teasession._nLanguage,"1167457972406")%><!--女--></option>
              </select>
            </td>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167455221093")%><!--年龄--></td>
            <td>
              <select name="age">
                <option value="" selected>--------</option>
                <option value="1">18-25</option>
                <option value="2">25-30</option>
                <option value="3">30-35</option>
                <option value="4">35-40</option>
                <option value="5">40-45</option>
                <option value="6">45-50</option>
                <option value="7">50以上</option>
              </select>
            </td>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></td>
            <td>
            <SELECT name="skr_wrk_year">
              <OPTION value="" SELECTED>--------</OPTION>
              <OPTION value="0">一年以下</OPTION>
              <OPTION value="1">1年</OPTION>
              <OPTION value="2">2年</OPTION>
              <OPTION value="3">3年</OPTION>
              <OPTION value="4">4年</OPTION>
              <OPTION value="5">5年</OPTION>
              <OPTION value="6">6年</OPTION>
              <OPTION value="7">7年</OPTION>
              <OPTION value="8">8年</OPTION>
              <OPTION value="9">9年</OPTION>
              <OPTION value="10">10年</OPTION>

            </SELECT>
            </td>
          </tr>

          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167461342281")%><!--关键词--></td>
            <td> <INPUT TYPE="text" NAME="keyword" MAXLENGTH="20" VALUE=""></td>
          </tr>

          <tr>
            <TD  NOWRAP>&nbsp;</td>
            <TD COLSPAN="2">
              <INPUT class="edit_button" NAME="" TYPE="submit" value="<%=r.getString(teasession._nLanguage,"1167443806359")%>"><!-- onClick="form_submit();return false;">&nbsp; -->
              <input name="Input"  class="edit_button"  type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.open('<%=nu%>','_self')">
            </td>
          </tr>

          <tr><td colspan="2"><hr size="1" /></td></tr>
          <tr>
            <td><%=r.getString(teasession._nLanguage,"1167466317625")%><!--搜索器名称-->:</td>
            <td><input name="subject" type="text"></td>
          </tr>
          <tr>
            <td></td>
            <!--保存到搜索器-->
            <td><input  class="edit_button"  name="save" value="<%=r.getString(teasession._nLanguage,"1167466353828")%>" onclick="if(submitText(form1.subject, '<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')){form1.action='';return true;}else return false;" type="submit"></td>
          </tr>
</TABLE>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2"><%=r.getString(teasession._nLanguage,"1167466398578")%><!--搜索器列表--></td>
  </tr>
  <%
java.util.Enumeration enumer=ResumeSearchWare.findByMember(teasession._rv._strR);
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  ResumeSearchWare rsw=ResumeSearchWare.find(id);

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=rsw.getName()%></td>
  <td>
    <script type="">
    function fedit<%=id%>()
    {
      form1.rid.value='<%=id%>';
//      for(var i=0;i<form1.sltOccId_BigClass.options.length;i++)
//      {
//        form1.sltOccId_BigClass.options[i].selected=true;
//        form1.sltOccId_BigClass.onchange();
//        for(var j=0;j<form1.sltOccId_list.options.length;j++)
//        {
//          if(form1.sltOccId_list.options[j].value=="<%=rsw.getOccid()%>")
//          {
//            form1.sltOccId_list.options[j].selected=true;
//            i=9999999;
//            break;
//          }
//        }
//      }

selectvalue(form1.sltOccId_BigClass,'<%=rsw.getOccid()%>');
      selectvalue(form1.expectcity,'<%=rsw.getCity()%>');
      selectvalue(form1.degree,'<%=rsw.getDeg()%>');
      selectvalue(form1.sex,'<%=rsw.getSex()%>');
      selectvalue(form1.age,'<%=rsw.getAge()%>');
      selectvalue1(form1.skr_wrk_year,'<%=rsw.getWrk()%>');
      form1.keyword.value='<%=rsw.getKeyword()%>';
      form1.subject.value='<%=rsw.getName()%>';
    }
    </script>
<input type="Submit" name="Submit" onclick="fedit<%=id%>();" value="<%=r.getString(teasession._nLanguage,"1167443806359")%>">
<input type="button" name="Submit" onclick="fedit<%=id%>();form1.subject.focus();" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>">
<input type="Submit" name="del" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form1.action='';form1.rid.value='<%=id%>';return true;}else return false;" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>"></td>
</tr>
<%}%>
</table>
 </FORM>

<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</HTML>
