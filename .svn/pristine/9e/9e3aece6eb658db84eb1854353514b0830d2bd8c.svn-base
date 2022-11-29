<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
//h.member=teasession._rv.toString();

String community=teasession._strCommunity;

Communityjob communityjob=Communityjob.find(community);


String tmp;


StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
if(h.get("member")!=null&&h.get("member").length()>0)
{
    sql.append(" and n.rcreator = ").append(DbAdapter.cite(teasession._rv.toString()));
}
String q=h.get("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  q=DbAdapter.cite("%"+ q.replaceAll(" ","%")+"%");
  sql.append(" AND( j.name LIKE "+q);

  String KEYWORD[]={"r.name","r.NowTrade","r.NowMainCareer"  ,
  "r.NowCareerLevel",
  "r.SalarySum"     ,
  "r.ExpectTrade"    ,
  "r.ExpectCareer"   ,
  "r.ExpectCity"     ,
  "r.ExpectSalarySum",
  "r.JoinDateType"   ,
  "r.SelfValue"      ,
  "r.SelfAim"   ,
  "pl.school",
  "pl.firstname",
  "pl.lastname",
  "pl.email"
  };
  for(int len=0;len<KEYWORD.length;len++)
  {
    sql.append(" OR "+KEYWORD[len]+" LIKE "+q);
  }
  sql.append(")");
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}



//String ExpectCareer=h.get("sltOccId_list");//期望从事职业
//if(ExpectCareer!=null&&ExpectCareer.length()>0)
//{
//    sql.append(" AND r.ExpectCareer LIKE "+DbAdapter.cite("%"+ExpectCareer+"%"));
//    par.append("&sltOccId_list=").append(ExpectCareer);
//}
String ExpectCity=h.get("tgt_loc_city_id");//工作地区
if(ExpectCity!=null&&ExpectCity.length()>0)
{
    sql.append(" AND r.ExpectCity LIKE "+DbAdapter.cite("%"+ExpectCity+"%"));
    par.append("&tgt_loc_city_id=").append(ExpectCity);
}


int age=h.getInt("age",-1);
int sex=h.getInt("sex",-1);
String degree=h.get("degree");
String expectcity = h.get("expectcity");
int experience=h.getInt("experience");
String expectcareer =h.get("expectcareer");
int majorcategory=h.getInt("majorcategory",-1);

int rsearch=h.getInt("rsearch");
if(rsearch>0)
{
  RSearch rs=RSearch.find(rsearch);
  rs.set("hits",String.valueOf(++rs.hits));
  age=rs.age;
  sex=rs.sex;
  degree=rs.degree;
  expectcity=rs.expectcity;
  experience=rs.experience;
  expectcareer=rs.expectcareer;
  majorcategory=rs.majorcategory;
}

//年龄
if(age!=-1)
{
  switch(age)
  {
    case 1:
    sql.append(" AND p.age >=18 AND p.age<25");
    break;
    case 2:
    sql.append(" AND p.age >=25 AND p.age<30");
    break;
    case 3:
    sql.append(" AND p.age >=30 AND p.age<35");
    break;
    case 4:
    sql.append(" AND p.age >=35 AND p.age<40");
    break;
    case 5:
    sql.append(" AND p.age >=40 AND p.age<45");
    break;
    case 6:
    sql.append(" AND p.age >=45 AND p.age<50");
    break;
    case 7:
    sql.append(" AND p.age >=50 ");
  }
  par.append("&age=").append(age);
}

//性别
if(sex!=-1)
{
  sql.append(" AND p.sex ="+sex);
  par.append("&sex=").append(sex);
}

String polity=h.get("polity");//政治面貌
if(polity!=null&&polity.length()>0)
{
  sql.append(" AND p.polity="+polity);
  par.append("&polity=").append(polity);
}

//String name=h.get("name");//姓名
//if(name!=null&&name.length()>0)
//{
//  //sql.append(" AND( pl.firstname LIKE '%"+name+"%' OR pl.lastname LIKE "+DbAdapter.cite("%"+name+"%")+")");
//  sql.append(" AND pl.lastname+pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
//  par.append("&name=").append(name);
//}

//学历
if(degree!=null && degree.length()>0)
{
  sql.append(" AND pl.degree=").append(DbAdapter.cite(degree));
  par.append("&degree=").append(degree);
}

if(expectcity!=null && expectcity.length()>0)
{
  sql.append(" AND r.expectcity like ").append(DbAdapter.cite("%"+expectcity+"%"));
  par.append("&expectcity=").append(expectcity);
}


//工作经验
if(experience>0)
{
 sql.append(" AND r.experience=").append(experience);
 par.append("&experience=").append(experience);
}

//if(h.get("skr_wrk_year")!=null&& h.get("skr_wrk_year").length()>0)
//{
//  int experience_1= Integer.parseInt(h.get("skr_wrk_year"));
//  experience=h.get("skr_wrk_year");
//  sql.append(" AND r.experience=").append(experience_1);
//  par.append("&experience=").append(experience);
//}

//期望工作职业
//if(h.get("sltOccId_BigClass")!=null && h.get("sltOccId_BigClass").length()>0)
//{
//  expectcareer = h.get("sltOccId_BigClass");
//}
if(expectcareer!=null && expectcareer.length()>0)
{
  sql.append(" AND expectcareer LIKE ").append(DbAdapter.cite("%"+expectcareer+"%"));
  par.append("&expectcareer=").append(expectcareer);
}

//专业
if(majorcategory!=-1)
{
  sql.append(" AND n.node IN(SELECT node FROM Educate WHERE majorcategory = "+majorcategory+")");
  par.append("&majorcategory="+majorcategory);
}
String time_s = h.get("time_s");
if(time_s!=null && time_s.length()>0)
{
    sql.append(" AND n.time >=").append(DbAdapter.cite(time_s));
    par.append("&time_s=").append(time_s);
}
String time_k = h.get("time_k");
if(time_k!=null && time_k.length()>0)
{
    sql.append(" AND n.time <=").append(DbAdapter.cite(time_k));
    par.append("&time_k=").append(time_k);
}

////////////////////////////////////////////////////////////////////////////
int type=-1;
tmp=h.get("type");
String table=" Node n,Resume r";
if(tmp!=null)
{
  type=Integer.parseInt(tmp);
}
if(type!=-1)
{
  String strResumeSortjob=h.get("ResumeSortjob");
  if(strResumeSortjob!=null)
  {
    strResumeSortjob=" AND ResumeSort.job=" +strResumeSortjob+" AND ja.corpnode="+strResumeSortjob;
  } else
  {
    strResumeSortjob="";
  }
  table=table+",ResumeSort rs";
  //    if("1".equals(resumesorttype))
  //    sql.append(" AND ResumeSort.member="+dbadapter.cite(teasession._rv.toString())+" AND ResumeSort.type="+resumesorttype+strResumeSortjob);
  //    else
  sql.append(" AND rs.member="+DbAdapter.cite(teasession._rv.toString())+" AND rs.resume=r.node AND rs.type="+type+strResumeSortjob);
}
if(sql.indexOf("p.")!=-1)
{
  table+=",Profile p";
  sql.append(" AND p.member=n.vcreator");
}
if(sql.indexOf("pl.")!=-1)
{
  table+=",ProfileLayer pl";
  sql.append(" AND pl.member=n.vcreator");
}

int pos=0,size=20;
tmp=h.get("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}


int count=0;
Vector vector2=new Vector();
DbAdapter db= new DbAdapter();
try
{
  count=db.getInt("SELECT COUNT(n.node) FROM "+table+" WHERE n.finished=1 AND r.node=n.node AND n.type=52 AND n.community="+DbAdapter.cite(community)+sql.toString());
  db.executeQuery("SELECT n.node FROM "+table+" WHERE n.finished=1 AND r.node=n.node AND n.type=52 AND n.community="+DbAdapter.cite(community)+sql.toString()+" ORDER BY n.time DESC",pos , size);
  while(db.next())vector2.addElement(new Integer(db.getInt(1)));
} finally
{
  db.close();
}
Enumeration enumeration=vector2.elements();


Resource r=new Resource("/tea/resource/Job");

String info=h.get("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"1167461566906");//"简历管理";
}
switch(type)
{
  case 1:
  info="人才库";
  break;
  case 2:
  info="有价值的简介";
  break;
}

String menuid=h.get("id");

StringBuffer sb = new StringBuffer();

%>
<HTML>
<HEAD>
<title><%=info%></title>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_load()
{
  form1.age.value="<%=age%>";
  form1.sex.value="<%=sex%>";
}
function returnCheck()
{
  var counter=0;
  for(;counter<form1.elements.length;counter++)
  {
    if(form1.elements[counter].type=="checkbox"&&form1.elements[counter].checked==true)
    {
      return true;
    }
  }
  alert('<%=r.getString(teasession._nLanguage,"1167458485203")%>');<!--请先选择.-->
  return false;
}
function f_act(act,v)
{
  if(act=="?")
  {
    form1.action='?';
  }else if(returnCheck())
  {
    form1.act.value=act;
    if(act=='view')
    {
      form1.action='/jsp/type/resume/Preview.jsp';
    }else if(act=='type')
    {
      form1.action='/servlet/EditResumeSort';
      form1.type.value=v;
    }else if(act=='email')
    {
      form1.action='/jsp/type/resume/SendEmailCandidate.jsp';
      form1.target='_blank';
    }else if(act=='hr')
    {
      form1.action='/jsp/type/resume/SendEmailCandidate.jsp';
      form1.target='_blank';
    }else if(act=='down')
    {
      form1.action='/servlet/EditJobApply';
    }else if(act=='exp')
    {
      window.open('about:blank','jam_exp','height=170px,width=370px,left=250,top=150');
      form1.action='/jsp/type/resume/ExportResumeAlert.jsp';
      form1.target='jam_exp';
    }
    form1.nexturl.value=location;
    form1.submit();

    form1.target='_self';
  }
}

///servlet/ExportResume
</script>
</HEAD>
<body onLoad="f_load()">
<h1><%=info%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<select onchange="location='?id=<%=menuid%>&rsearch='+value">
<option value="0">---快速搜索---</option>
<%
ArrayList list = RSearch.find(" AND member="+Profile.find(h.member).getMember(),0,200);
Iterator it = list.iterator();
for(int i=1+pos;it.hasNext();i++)
{
  RSearch t=(RSearch)it.next();
  out.print("<option value="+t.rsearch+">"+t.name);
}
%>
</select>

<h2><%=r.getString(teasession._nLanguage,"1167443806359")%><!--查询--></h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>">
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="nexturl">
<input type=hidden name="act">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD nowrap="nowrap"><%=r.getString(teasession._nLanguage, "性别")%>
      <select name="sex">
      <option value="-1">----------------
      <option value="1"><%=r.getString(teasession._nLanguage, "男")%>
      <option value="0"><%=r.getString(teasession._nLanguage, "女")%>
      </select>
    </TD>
    <TD nowrap="nowrap"><%=r.getString(teasession._nLanguage, "年龄")%>
      <select name="age">
      <option value="-1">----------------
      <option value="1">18-25
      <option value="2">25-30
      <option value="3">30-35
      <option value="4">35-40
      <option value="5">40-45
      <option value="6">45-50
      <option value="7">>50
      </select>
    </TD>
   <%-- <TD><%=r.getString(teasession._nLanguage, "姓名")%><input name="name" value="<%if(name!=null)out.print(name);%>"></TD>--%>
    <td nowrap="nowrap">学历:
     <SELECT NAME="degree"  >
        <OPTION VALUE="">--------------</OPTION>
          <OPTION VALUE="Z0" <%if("Z0".equals(degree))out.print(" selected");%>>小学</OPTION>
          <OPTION VALUE="Z1" <%if("Z1".equals(degree))out.print(" selected");%>>初中</OPTION>
          <OPTION VALUE="Z2" <%if("Z2".equals(degree))out.print(" selected");%>>高中</OPTION>
          <OPTION VALUE="Z3" <%if("Z3".equals(degree))out.print(" selected");%>>技校/职高</OPTION>
          <OPTION VALUE="Z4" <%if("Z4".equals(degree))out.print(" selected");%>>中专</OPTION>
          <OPTION VALUE="Z5"  <%if("Z5".equals(degree))out.print(" selected");%>>大专</OPTION>
          <OPTION VALUE="Z8" <%if("Z8".equals(degree))out.print(" selected");%>>大学本科</OPTION>
          <OPTION VALUE="Z9" <%if("Z9".equals(degree))out.print(" selected");%>>硕士研究生</OPTION>
          <OPTION VALUE="ZA" <%if("ZA".equals(degree))out.print(" selected");%>>博士研究生</OPTION>
          <OPTION VALUE="ZB" <%if("ZB".equals(degree))out.print(" selected");%>>无学历</OPTION>
        </SELECT>
    </td>
    <td nowrap="nowrap">期望工作地区:<select name="expectcity">
    <option value="">---------</option>
<%
 java.util.Enumeration bigjobcity=Jobcity.findByFather(Jobcity.getRootId(community));
 for(int index=0;bigjobcity.hasMoreElements();index++)
 {
   int occupation=((Integer)bigjobcity.nextElement()).intValue();
   Jobcity occ_obj=Jobcity.find(occupation);
   out.print("<option value="+occ_obj.getCode());
   if(occ_obj.getCode().equals(expectcity))
   out.print(" selected");
   out.print(">"+occ_obj.getSubject());
   out.print("</option>");
 }
//%>
</select></td>
</tr>
<tr>
  <td nowrap="nowrap">工作经验:<input name="experience" type="text" maxlength="2" size="2" mask="int" value="<%if(experience>0)out.print(experience);%>" />年</td>
    <td nowrap="nowrap">期望工作职业:
      <select  name="expectcareer" >
        <option value="">--------</option>
        <%
        java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(community));
        for(int index=0;bigOcc.hasMoreElements();index++)
        {
          int occupation=((Integer)bigOcc.nextElement()).intValue();out.print(occupation);
          Occupation occ_obj=Occupation.find(occupation);
          String code=occ_obj.getCode();
          out.print("<option value="+code);
          if(code.equals(expectcareer))
             out.print(" selected");
          out.print(">"+occ_obj.getSubject());
          out.print("</option>");
        }
        %>
      </select>
    </td>
    <td nowrap="nowrap">
      专业:<SELECT NAME="majorcategory" >
        <option value="-1">--------</option>
        <%
        for(int i =0;i<Educate.ME.length;i++)
        {
          out.print("<option value="+i);
          if(majorcategory==i)
          out.print(" selected");
          out.print(">"+Educate.ME[i]);
          out.print(" </option>");
        }
         %></select>
         </td><td nowrap="nowrap">
         更新日期:<input name="time_s" size="7"  value="<%if(time_s!=null)out.print(time_s);%>">
         <A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

到　<input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>">
  <A href="###"><img onclick="showCalendar('form1.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
  </td>
    <td>
      <input type="submit" value="<%=r.getString(teasession._nLanguage, "1167445161546")%>" onClick="f_act('?')"/>
      <%-- <input type="button" value="<%=r.getString(teasession._nLanguage, "1167460447781")%>" onClick="window.open('/jsp/type/resume/ResumeSearch.jsp','_self');"/>--%>
    </td>
  </tr>
</table>



<h2><%=r.getString(teasession._nLanguage,"1167443831593")+" ( "+count+" )"%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td>&nbsp;</td>
    <td height="20" nowrap><%=r.getString(teasession._nLanguage,"1167442318656")%><!--姓名--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167455197453")%><!--性别--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167455221093")%><!--年龄--></td>
<%--    <td nowrap><%=r.getString(teasession._nLanguage,"1167461675828")%>地区</td>--%>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167461717421")%><!--期望工作地区--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457804750")%><!--期望从事职业--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167457831203")%><!--专业--></td>
    <td nowrap>E-Mail</td>
    <td nowrap><%=r.getString(teasession._nLanguage,"下载简历")%><!--申请表--></td>
    <td nowrap><%=r.getString(teasession._nLanguage,"1167461815640")%><!--更新日期--></td>
  </tr>
<%
while(enumeration.hasMoreElements())
{
  int nodeid =((Integer)enumeration.nextElement()).intValue();
  Node node=Node.find(nodeid);
  String member=node.getCreator()._strV;
  Profile profile =Profile.find(member);
  Resume resume=Resume.find(nodeid,teasession._nLanguage);
  int exper=resume.getExperience();
  String state=profile.getState(teasession._nLanguage);
  String eamil=profile.getEmail();

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td nowrap><input id=CHECKBOX type="CHECKBOX" name="resumes" value="<%=nodeid%>"/></td>
  <td nowrap><a href="/jsp/type/resume/Preview.jsp?community=<%=teasession._strCommunity%>&resumes=<%=nodeid%>"><%=profile.getName(teasession._nLanguage)%></a></td>
  <td nowrap ><%=r.getString(teasession._nLanguage,profile.isSex()?"1167457951671":"1167457972406")%></td>
  <td nowrap ><%=profile.getAge()%></td>
  <%--<td nowrap >
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
  </td>--%>
  <td nowrap ><%=tea.htmlx.DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%></td>
  <td nowrap>
  <%
  String expectctcity[]=resume.getExpectcity().split("/");//.replaceAll("&",",")
  for(int i=0;i<expectctcity.length;i++)
  {
    for(int index=0;index<=tea.resource.Common.PROVINCE.length;index++)
    {
      if(index==tea.resource.Common.PROVINCE.length)
      {
        out.print(expectctcity[i]);
      }else
      if(tea.resource.Common.PROVINCE[index].equals(expectctcity[i]))
      {
        out.print(r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index])+" ");
        break;
      }
    }
  }
  %>
  </td>
  <td nowrap><%=exper>0?exper+r.getString(teasession._nLanguage,"1167448647531"):"--"%><!--年--></td>
  <td nowrap><%=resume.getExpectcareerToHtml()%></td>
  <td nowrap>
  <%
  sb = new StringBuffer();
  java.util.Enumeration enumerationEducate = Educate.find(nodeid, 1);
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
  java.util.Enumeration enumerApplyTable= tea.entity.node.ApplyTable.findByMember(member,community);
  if(enumerApplyTable.hasMoreElements())
  {
    out.print(new tea.html.Anchor("/servlet/EditApplyTable?act=down&applytable="+((Integer)  enumerApplyTable.nextElement()).intValue(),r.getString(teasession._nLanguage,"1167458057468")));//"有"
  }else
  out.print(r.getString(teasession._nLanguage,"1167458013921"));//"无"
  %>
  </td>
  <td align="center" nowrap><%=node.getTimeToString()%></td>
</tr>
<%
}
%>
<tr>
  <td colspan="2"><input id=CHECKBOX type="CHECKBOX" onClick="selectAll(form1.resumes,checked)"/><%=r.getString(teasession._nLanguage,"1167445122937")%></td>
  <td colspan="11"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?community="+teasession._strCommunity+"&pos=",pos,count,size)%></td>
</tr>
</table>


<%
//<!--查看-->
out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167444621250")+" onClick=f_act('view');>");

//if(type!=1)
//{
//  //<!--转入人才库-->
//  out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458160093")+" onClick=f_act('type',1)>");
//}
//if(type!=2)
//{
//  //<!--将选中项设为本岗位有价值简历-->
//  out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458207343")+" onClick=f_act('type',2)>");
//}

//<INPUT TYPE="submit" name="not" VALUE="将选中项设为不合格简历" onClick="window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';" /><input type="button" value="查看" onclick="window.open('/jsp/type/resume/yjobapplymanage.jsp?ResumeSorttype=3<%if(applyAmount!=null)out.print("&applyAmount="+applyAmount);+','_self')"/>
//<INPUT TYPE="submit" name="del" VALUE="+r.getString(teasession._nLanguage,"CBDelete")+" onClick="if(!confirm('+r.getString(teasession._nLanguage,"ConfirmDeleteSelected")+'))return false;form2.nexturl.value='+(request.getRequestURI()+"?"+request.getQueryString())+';window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';" />

//<!--发信到选中项-->
out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458288546")+" onClick=f_act('email')>");

//<!--推荐应聘简历-->
//out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458313718")+" onClick=f_act('hr')>");

//<INPUT name="BUTTON" TYPE="button" ID="BUTTON" onClick="window.document.form2.action='/servlet/ExportResume';form2.target='_blank';" VALUE="将选中项导出"/>

//<!--将选中项以Excel导出-->
out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458350890")+" onClick=f_act('exp')>");

//<!--下载申请表-->
//out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458390031")+" onClick=f_act('down')>");

//<!--将选中项以XML导出,用于SAP系统-->
//<INPUT name="BUTTON" TYPE="submit" ID="BUTTON" onClick="if(returnCheck()){window.document.form2.action='/jsp/type/resume/Output.jsp';form2.target='_self';}else return false;" VALUE="+r.getString(teasession._nLanguage,"1167458433125")+"/>

%>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
