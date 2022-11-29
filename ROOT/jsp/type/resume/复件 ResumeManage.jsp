<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String community=teasession._strCommunity;

Communityjob communityjob=Communityjob.find(community);

/*
Purview purview=Purview.find(teasession._rv.toString(),community);
if(!purview.isResume()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(communityjob.getJobmember()))
{
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你没有权限,访问本页.","UTF-8"));
    return;
}
String strPurview =purview.getNode();
*/

int pagesize=25;
int count=0;
int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

StringBuffer param=new StringBuffer();
StringBuffer sb=new StringBuffer();
StringBuffer from=new StringBuffer(" FROM Node n,NodeLayer nl,Resume r");

String ExpectCareer=request.getParameter("sltOccId_list");//期望从事职业
if(ExpectCareer!=null&&ExpectCareer.length()>0)
{
  sb.append("  AND r.expectcareer like '%"+ExpectCareer.replaceAll("--","")+"%'");
  param.append("&sltOccId_list="+ExpectCareer);
}
String expectcity=request.getParameter("expectcity");//工作地区
if(expectcity!=null&&expectcity.length()>0)
{
  sb.append(" AND  r.expectcity like '%"+expectcity+"%'");
  param.append("&expectcity="+expectcity);
}

String degree=request.getParameter("skr_deg_id");//学历
if(degree!=null&&degree.length()>0)
{
  sb.append("  AND pl.degree >="+DbAdapter.cite(degree));
  param.append("&skr_deg_id="+degree);
}

String age=request.getParameter("age");//年龄
if(age!=null&&age.length()>0)
{
    switch(Integer.parseInt(age))
    {
        case 1:
        sb.append(" AND  p.age >=18 AND  p.age<25");
        break;
        case 2:
        sb.append(" AND  p.age >=25 AND  p.age<30");
        break;
        case 3:
        sb.append(" AND  p.age >=30 AND  p.age<35");
        break;
        case 4:
        sb.append("  AND p.age >=35 AND  p.age<40");
        break;
        case 5:
        sb.append(" AND  p.age >=40 AND  p.age<45");
        break;
        case 6:
        sb.append(" AND  p.age >=45 AND  p.age<50");
        break;
        case 7:
        sb.append(" AND  p.age >=50 ");
    }
    param.append("&age="+age);
}
String sex=request.getParameter("sex");//性别
if(sex!=null&&sex.length()>0)
{
  sb.append("  AND p.sex ="+sex);
  param.append("&sex="+sex);
}

String Experience=request.getParameter("skr_wrk_year");//工作经验
if(Experience!=null&&Experience.length()>0)
{
    if((Experience).equals("0"))
    sb.append("  AND r.experience <1");
    else
    sb.append("  AND r.experience >="+Experience);
    param.append("&skr_wrk_year="+Experience);
}
String keyword=request.getParameter("keyword");//关键字
if(keyword!=null&&(keyword=keyword.trim()).length()>0)
{
param.append("&keyword="+keyword);

String KEYWORD[]={"nl.subject","r.joinu","r.intr1"  ,
"r.intr2",
"r.intr3"     ,
"r.zxrgs"    ,
"r.expectcareer"   ,
"r.expectcity"     ,
//"r.expectsalarysum",
//"r.joindatetype"   ,
"r.selfvalue"      ,
"r.selfaim",
"r.other"        };

keyword=DbAdapter.cite("%"+keyword.replaceAll(" ","%")+"%");
sb.append(" AND ("+KEYWORD[0]+" like "+keyword);
for(int len=1;len<KEYWORD.length;len++)
sb.append(" OR "+KEYWORD[len]+" like "+keyword);
sb.append(")");

}
java.util.Vector vector=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
try
{
  //,ProfileLayer pl,Profile p,Educate e,Employment et
  count=dbadapter.getInt("SELECT COUNT(DISTINCT n.node) FROM Node n,NodeLayer nl,Resume r,ProfileLayer pl,Profile p WHERE p.member=pl.member AND n.vcreator=p.member AND n.node=nl.node AND n.node=r.node AND n.type=52 AND n.community="+dbadapter.cite(community)+sb.toString());
  dbadapter.executeQuery("SELECT DISTINCT n.node,n.time FROM Node n,NodeLayer nl,Resume r,ProfileLayer pl,Profile p WHERE p.member=pl.member AND n.vcreator=p.member AND n.node=nl.node AND n.node=r.node AND n.type=52 AND n.community="+dbadapter.cite(community)+sb.toString()+" ORDER BY n.time DESC");
  for (int l = 0; l < pos + pagesize && dbadapter.next(); l++)
  {
    if (l >= pos)
    {
      vector.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }
}finally
{
  dbadapter.close();
}
java.util.Enumeration enumeration=vector.elements();

Resource r=new Resource("/tea/resource/Job");

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167461566906");//"简历管理";
}

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function fclick()
{
  for(var counter=0;counter<form1.elements.length;counter++)
  {
    if(form1.elements[counter].type=="checkbox")
    {
      form1.elements[counter].checked=form1.elements["allselect"].checked;
    }
  }
}
</script>
</HEAD>
<body>
<h1 ><%=info+"("+count+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>
<form name="form1" method="post" action="/servlet/ExportResume">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td>    </td>
    <td height="20" nowrap><%=r.getString(teasession._nLanguage,"1167442318656")%><!--姓名--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167455197453")%><!--性别--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167455221093")%><!--年龄--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167461675828")%><!--地区--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167461717421")%><!--期望工作地区--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457804750")%><!--现从事职业--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457831203")%><!--专业--></td>
    <td nowrap>E-Mail</td>
    <td nowrap><%=r.getString(teasession._nLanguage,"Applytable")%><!--申请表--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167461815640")%><!--更新日期--></td>
  </tr>
  <%

int nodeCode;
while(enumeration.hasMoreElements())
{
  nodeCode =((Integer)enumeration.nextElement()).intValue();
  Resume summary=Resume.find(nodeCode,teasession._nLanguage);
  Node node_obj=Node.find(nodeCode);
  String member=node_obj.getCreator()._strV;
  Profile profile = Profile.find(member);

  String fname=profile.getFirstName(teasession._nLanguage);
  String lname=profile.getLastName(teasession._nLanguage);
  String state=profile.getState(teasession._nLanguage);
  String eamil=profile.getEmail();
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><input type=checkbox name="Node" value="<%=nodeCode%>"/></td>
    <td nowrap><a href="/jsp/type/resume/Preview.jsp?resumes=<%=nodeCode%>"><%if(fname!=null)out.print(fname+" ");if(lname!=null)out.print(lname);%></a></td>
    <td nowrap ><%=r.getString(teasession._nLanguage,(profile.isSex()?"1167457951671":"1167457972406"))%></td>
    <td nowrap ><%=profile.getAge()%></td>
    <td nowrap >
    <%
    for(int index=0;index<=tea.resource.Common.PROVINCE.length;index++)
    {
      if(index==tea.resource.Common.PROVINCE.length)
      {
        if(state!=null)
        out.println(state);
      }else
      if(tea.resource.Common.PROVINCE[index].equals(state))
      {
        out.println(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]));
        break;
      }
    }
    %>
    </td>
    <td nowrap ><%=tea.htmlx.DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%></td>
    <td nowrap>
    <%
    String expectctcity[]=summary.getExpectcity().split("&");//.replaceAll("&",",")
    for(int i=0;i<expectctcity.length;i++)
    {
      for(int index=0;index<=tea.resource.Common.PROVINCE.length;index++)
      {
        if(index==tea.resource.Common.PROVINCE.length)
        {
          out.print(expectctcity[i]+",");
        }else
        if(tea.resource.Common.PROVINCE[index].equals(expectctcity[i]))
        {
          out.print(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index])+",");
          break;
        }
      }
    }
    %>
    </td>
    <td nowrap ><%=summary.getExperience()%><%=r.getString(teasession._nLanguage,"1167448647531")%><!--年--></td>
    <td nowrap>
    <%
    expectctcity=summary.getNowmaincareer().split("&");//.replaceAll("&",",")
    for(int i=0;i<expectctcity.length;i++)
    {
      for(int index=0;index<=tea.resource.Common.ZCSZY.length;index++)
      {
        if(index==tea.resource.Common.ZCSZY.length)
        {
          out.print(expectctcity[i]+",");
        }else
        if(tea.resource.Common.ZCSZY[index][0].equals(expectctcity[i]))
        {
          out.print(tea.resource.Common.ZCSZY[index][1]+",");
          break;
        }
      }
    }
    %>
    </td>
    <td nowrap>
        <%
        sb = new StringBuffer();
        java.util.Enumeration enumerationEducate = Educate.find(nodeCode, 1);
        while (enumerationEducate.hasMoreElements())
        {
          Educate educate = Educate.find( ( (Integer) enumerationEducate.nextElement()).intValue());
          sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
        }
        out.print(sb.toString());
        %>
    </td>
    <td nowrap><A href="mailto:<%=eamil%>"><%if(eamil!=null)out.print(eamil);%></A></td>
       <td nowrap>
       <%
       java.util.Enumeration enumerApplyTable=          tea.entity.node.ApplyTable.findByMember(member,community);
       if(enumerApplyTable.hasMoreElements())
       {
         out.print(new tea.html.Anchor("/servlet/EditApplyTable?act=down&applytable="+((Integer)  enumerApplyTable.nextElement()).intValue(),r.getString(teasession._nLanguage,"1167458057468")));//"有"
       }else
       out.print(r.getString(teasession._nLanguage,"1167458013921"));//"无"
       %>

    </td>
    <td align="center" nowrap><%=node_obj.getTimeToString()%></td>
</tr>
<%}%>
<tr ><td colspan="2"><input type=checkbox name=allselect onClick="fclick()"/><%=r.getString(teasession._nLanguage,"1167445122937")%><!--全选--> </td>
  <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+community+"&pos=",pos,count) %></td></tr>
</table>



<!--查看-->
  <INPUT TYPE="submit" name="standby" VALUE="<%=r.getString(teasession._nLanguage,"1167444621250")%>" ID="CBNewCompany" onClick="if(returnCheck()){window.document.form1.action='/jsp/type/resume/Preview.jsp';form1.target='_self';}else return false;"  CLASS="in"/>
<!--查询-->
  <INPUT TYPE="submit" CLASS="in" ID="BUTTON2"  VALUE="<%=r.getString(teasession._nLanguage,"1167443806359")%>" onclick="form1.action='/jsp/type/resume/yResumeSearch.jsp';form1.method='GET';"/>
  <%--  <INPUT TYPE="submit" VALUE="发信到选中项" ID="CBNewCompany" CLASS="in"  onClick="window.document.form1.action='/jsp/type/resume/SendEmailCandidate.jsp';form1.target='_self';"  />
  <INPUT name="BUTTON" TYPE="submit" CLASS="in" ID="BUTTON2" onclick="window.document.form1.action='/servlet/ExportResume';form1.target='_blank';"  VALUE="导出选中项"/>
  --%><input type="hidden" name="act"/>
  <!--发信到选中项-->
  <INPUT TYPE="submit" VALUE="<%=r.getString(teasession._nLanguage,"1167458288546")%>" ID="CBNewCompany" CLASS="in"  onClick="if(returnCheck()){window.document.form1.action='/jsp/type/resume/SendEmailCandidate.jsp';form1.target='_blank';}else return false;"  />
<!--推荐应聘简历-->
  <INPUT TYPE="submit" VALUE="<%=r.getString(teasession._nLanguage,"1167458313718")%>" ID="CBNewCompany" CLASS="in"  onClick="if(returnCheck()){window.document.form1.action='/jsp/type/resume/SendEmailCandidate.jsp';form1.target='_blank';form1.act.value='hr';}else return false;"  />
<!--将选中项导出-->
  <INPUT name="BUTTON" TYPE="button" CLASS="in" ID="BUTTON" onClick="ExportResumeAlertOpen()" VALUE="<%=r.getString(teasession._nLanguage,"1167462052203")%>"/>

</form>
<script type="">
function ExportResumeAlertOpen()
{
  var param='';var counter=0;
  for(;counter<window.document.form1.elements.length;counter++)
  {
    if(window.document.form1.elements[counter].type=="checkbox"&&window.document.form1.elements[counter].checked==true)
    {
      param+='&node='+window.document.form1.elements[counter].value;
    }
  }
  if(param.length==0)
  alert('<%=r.getString(teasession._nLanguage,"1167458485203")%>');//<!--请先选择-->
  else
  window.open('/jsp/type/resume/ExportResumeAlert.jsp?a=a'+param,'','height=170px,width=370px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');
}
function returnCheck()
{
  var counter=0;
  for(;counter<window.document.form1.elements.length;counter++)
  {
    if(window.document.form1.elements[counter].type=="checkbox"&&window.document.form1.elements[counter].checked==true)
    {
      return true;
    }
  }
  alert('<%=r.getString(teasession._nLanguage,"1167458485203")%>');//<!--请先选择-->
  return false;
}

</script>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
