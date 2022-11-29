<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");
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

SupplierMember sm=SupplierMember.find(teasession._strCommunity,teasession._rv._strV);
//String cex=sm.getCompanyEx();
//if(cex.length()<2)
//{
 //  response.sendError(403);
  //  return;
  //}


Communityjob communityjob=Communityjob.find(community);

String member = request.getParameter("member");
StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();

if("member".equals(member))
{
  //sql.append(" and n.rcreator = ").append());
  sql.append(" and j.node in (select ns.node from Node ns where ns.type = 50 and ns.rcreator = "+DbAdapter.cite(teasession._rv.toString())+")");
  //nexturl = request.getRequestURI()+"?member="+member;
}
//sql.append(" AND j.orgid IN("+cex.substring(1,cex.length()-1).replaceAll("/",",")+")");

int job=0;
String tmp=request.getParameter("job");
if(tmp!=null&&!tmp.equals(""))
{
  job=Integer.parseInt(tmp);
  sql.append(" AND j.node="+job);
  par.append("&job=").append(job);
}else
{
  String orgid=request.getParameter("orgid");
  if(orgid!=null&&orgid.length()>0)
  {
    sql.append(" AND j.orgid="+orgid);
    par.append("&orgid=").append(orgid);
  }
}

String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  q=DbAdapter.cite("%"+ q.replaceAll(" ","%")+"%");
  sql.append(" AND( j.name like "+q);

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



String ExpectCareer=request.getParameter("sltOccId_list");//期望从事职业
if(ExpectCareer!=null&&ExpectCareer.length()>0)
{
  sql.append(" AND r.ExpectCareer LIKE "+DbAdapter.cite("%"+ExpectCareer+"%"));
  par.append("&sltOccId_list=").append(ExpectCareer);
}
String ExpectCity=request.getParameter("tgt_loc_city_id");//工作地区
if(ExpectCity!=null&&ExpectCity.length()>0)
{
  sql.append(" AND  r.ExpectCity like "+DbAdapter.cite("%"+ExpectCity+"%"));
  par.append("&tgt_loc_city_id=").append(ExpectCity);
}

String Degree=request.getParameter("skr_deg_id");//学历
if(Degree!=null&&Degree.length()>0)
{
  sql.append(" AND pl.degree <="+Degree);
  par.append("&skr_deg_id=").append(Degree);
}

String age=request.getParameter("age");//年龄
if(age!=null&&age.length()>0&&!age.equals("-1"))
{
  //  Calendar c = Calendar.getInstance();
  //  int year = c.get(c.YEAR);
  //
  // // c.setTime(_dateBirth);
  //  return year - c.get(c.YEAR);
  switch(Integer.parseInt(age))
  {
    case 1:
    sql.append(" AND p.b >="+(2008-18)+"-10-10 AND p.age<25");
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

int sex=-1;
tmp=request.getParameter("sex");//性别
if(tmp!=null&&tmp.length()>0)
{
  sex=Integer.parseInt(tmp);
}
if(sex!=-1)
{
  sql.append(" AND p.sex ="+sex);
  par.append("&sex=").append(sex);
}

String polity=request.getParameter("polity");//政治面貌
if(polity!=null&&polity.length()>0)
{
  sql.append(" AND p.polity="+polity);
  par.append("&polity=").append(polity);
}

//String name=request.getParameter("name");//姓名
//if(name!=null&&name.length()>0)
//{
  //  //sql.append(" AND( pl.firstname LIKE '%"+name+"%' OR pl.lastname LIKE "+DbAdapter.cite("%"+name+"%")+")");
  //  sql.append(" AND pl.lastname+pl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
  //  par.append("&name=").append(name);
  //}


  String degree = request.getParameter("degree");//学历
  if(degree!=null && degree.length()>0)
  {
    sql.append(" AND pl.degree=").append(DbAdapter.cite(degree));
    par.append("&degree=").append(degree);
  }
  String expectcity = request.getParameter("expectcity");
  if(expectcity!=null && expectcity.length()>0)
  {
    sql.append(" AND r.expectcity like ").append(DbAdapter.cite("%"+expectcity+"%"));
    par.append("&expectcity=").append(expectcity);
  }


  String experience = "";//工作经验
  //int experience = 0;
  if(request.getParameter("experience")!=null&& request.getParameter("experience").length()>0)
  {
    int experience_1= Integer.parseInt(request.getParameter("experience"));
    experience=request.getParameter("experience");
    sql.append(" AND r.experience=").append(experience_1);
    par.append("&experience=").append(experience);
  }

  //int experience = 0;


  String expectcareer = request.getParameter("expectcareer");//期望工作职业
  if(expectcareer!=null && expectcareer.length()>0)
  {
    sql.append(" AND expectcareer like ").append(DbAdapter.cite("%"+expectcareer+"%"));
    par.append("&expectcareer=").append(expectcareer);
  }
  int majorcategory =-1;//专业
  if(request.getParameter("majorcategory")!=null && request.getParameter("majorcategory").length()>0)
  {
    majorcategory= Integer.parseInt(request.getParameter("majorcategory"));
  }
  if(majorcategory!=-1)
  {
    sql.append(" AND n.node in (select node from Educate where majorcategory = "+majorcategory+")");
    par.append("majorcategory="+majorcategory);
  }
  String time_s = request.getParameter("time_s");
  if(time_s!=null && time_s.length()>0)
  {
    sql.append(" AND n.time >=").append(DbAdapter.cite(time_s));
    par.append("&time_s=").append(time_s);
  }
  String time_k = request.getParameter("time_k");
  if(time_k!=null && time_k.length()>0)
  {
    sql.append(" AND n.time <=").append(DbAdapter.cite(time_k));
    par.append("&time_k=").append(time_k);
  }

  int type=-1;
  tmp=request.getParameter("type");

  String table=" Node n,JobApply ja,Job j,Resume r";
  if(tmp!=null && tmp.length()>0)
  {
    type = Integer.parseInt(tmp);
  }
  int typeals = 0;
  if(request.getParameter("typeals")!=null && request.getParameter("typeals").length()>0)
  {
    typeals = Integer.parseInt(request.getParameter("typeals"));
  }

  Resource r=new Resource("/tea/resource/Job");

  String info=request.getParameter("info");
  if(info==null)
  {
    info=r.getString(teasession._nLanguage,"1167454679312");//"应聘管理";
  }
  switch(type)
  {
    case 1:
    info="人才库";
    break;
    case 2:
    info="有价值的简介";
    break;
    case 3:
    info="通知应聘者面试";
    break;
  }

  if(typeals==4)
  {
    sql.append(" AND n.typealias=4 ");
    par.append("&type=").append(type);
    info = "通知应聘者面试成功列表";
  }

  if(type>0)
  {
    type=Integer.parseInt(tmp);
    String  strResumeSortjob=request.getParameter("ResumeSortjob");
    if(strResumeSortjob!=null)
    {
      strResumeSortjob=" AND ResumeSort.job=" +strResumeSortjob+" AND ja.corpnode="+strResumeSortjob;
    } else
    strResumeSortjob="";
    table=table+",ResumeSort ";
    //    if("1".equals(resumesorttype))
    //    sql.append(" AND ResumeSort.member="+dbadapter.cite(teasession._rv.toString())+" AND ResumeSort.type="+resumesorttype+strResumeSortjob);
    //    else
    if(typeals!=4){
      sql.append(" AND ResumeSort.member="+DbAdapter.cite(teasession._rv.toString())+" AND ResumeSort.resume=r.node AND ResumeSort.type="+type+strResumeSortjob+" AND j.node=ResumeSort.job");
    }else{
      sql.append(" AND ResumeSort.resume=r.node");
    }
    //out.print(sql.toString());
  }
  if(sql.indexOf("p.")!=-1)
  {
    table+=",Profile p";
    sql.append(" AND p.member=n.rcreator");
  }
  if(sql.indexOf("pl.")!=-1)
  {
    table+=",ProfileLayer pl";
    sql.append(" AND pl.member=n.rcreator");
  }

  int pos=0,size=25;
  tmp=request.getParameter("pos");
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }

  Vector vector2=new Vector();
  Vector vector3=new Vector();

  String ssql=" FROM "+table+" WHERE n.finished=1 AND r.node=n.node AND r.node=ja.resume AND ja.job=j.node AND n.type=52 AND n.community="+DbAdapter.cite(community)+sql.toString();

  int count=0;
  DbAdapter db= new DbAdapter();
  try
  {
    count=db.getInt("SELECT COUNT(*)"+ssql);
    db.executeQuery("SELECT n.node,ja.job"+ssql+" ORDER BY ja.time DESC",pos, size);
    for (int l = 0; db.next(); l++)
    {
      if (l >= pos)
      {
        vector2.addElement(new Integer(db.getInt(1)));
        vector3.addElement(new Integer(db.getInt(2)));
      }
    }
  } finally
  {
    db.close();
  }
  Enumeration enumeration=vector2.elements();
  Enumeration enumerationJobName=vector3.elements();

  String menuid=request.getParameter("id");

  %>
  <HTML>
    <HEAD>
      <title><%=info%></title>
      <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
      <script src="/tea/tea.js" type="text/javascript"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
      <META HTTP-EQUIV="Expires" CONTENT="0"/>
      <script>
      function f_load()
      {
        <%
        if(age!=null)out.print("form1.age.value="+age+";");
        // if(name!=null)out.print("form1.name.value="+name+";");
        %>
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

      function f_bcm(member,unit){
        var mem = member;
        var uni = unit;
        window.location.href='/jsp/admin/popedom/EditAdminUsrRole.jsp?community=<%=teasession._strCommunity%>&adminunit='+uni+'&member='+mem;
      }
      </script>
      </HEAD>
      <body onload="f_load()">
      <h1><%=info%></h1>
      <div id="head6"><img height="6" src="about:blank"></div>


        <h2><%=r.getString(teasession._nLanguage,"1167443806359")%><!--查询--></h2>
        <form name="form1" action="?">
        <input type="hidden" name="id" value="<%=menuid%>">
        <input type="hidden" name="type" value="<%=type%>">
        <input type="hidden" name="nexturl">
        <input type=hidden name="act">

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td nowrap="nowrap">职位:<%=sm.toHtmlJob_NO(teasession._nLanguage,job)%></td>
            <TD><%=r.getString(teasession._nLanguage, "性别")%>
              <select name="sex">
                <option value="-1">----------------
                  <option value="1"><%=r.getString(teasession._nLanguage, "男")%>
                    <option value="0"><%=r.getString(teasession._nLanguage, "女")%>
              </select>
            </TD>
            <%--  <TD><%=r.getString(teasession._nLanguage, "年龄")%>
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
</TD>--%>
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

            <td nowrap="nowrap">工作经验:<input name="experience" type="text" maxlength="2" size="2" onchange="mu();" value="<%if(experience!=null)out.print(experience);%>" />年
            </td>
            <td nowrap="nowrap">期望工作职业:
              <select  name="expectcareer" >
                <option value="">--------</option>
                <%
                java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(teasession._strCommunity));

                for(int index=0;bigOcc.hasMoreElements();index++)
                {
                  int occupation=((Integer)bigOcc.nextElement()).intValue();out.print(occupation);
                  Occupation occ_obj=Occupation.find(occupation);
                  out.print("<option value="+occ_obj.getCode());
                  if(occ_obj.getCode().equals(expectcareer))
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
                %>
                </td><td nowrap="nowrap">
                  更新日期:<input name="time_s" size="7"  value="<%if(time_s!=null)out.print(time_s);%>">
                  <A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

                  到　<input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>">
                  <A href="###"><img onclick="showCalendar('form1.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
                </td> <td>
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
            <td nowrap><%=r.getString(teasession._nLanguage,"1167455172484")%><!--应聘职位--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167455197453")%><!--性别--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167455221093")%><!--年龄--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457716218")%><!--毕业学校--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457757703")%><!--现从事行业--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457783859")%><!--工作经验--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457804750")%><!--期望工作职业--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457831203")%><!--专业--></td>
            <td nowrap>E-Mail</td>
            <!--td nowrap>申请表</td-->
            <td nowrap><%=r.getString(teasession._nLanguage,"1167457856062")%><!--申请日期--></td>
            <td nowrap><%=r.getString(teasession._nLanguage,"下载简历")%><!--下载简历--></td>
            <%if(typeals==4)
            {%><td nowrap>操作</td><%}%>
            </tr>
            <%
            while(enumeration.hasMoreElements()&&enumerationJobName.hasMoreElements())
            {
              int nodeid =((Integer)enumeration.nextElement()).intValue();
              int jobid=((Integer)enumerationJobName.nextElement()).intValue();
              JobApply ja=JobApply.find(nodeid,jobid);
              Node node=Node.find(nodeid);
              Profile profile =Profile.find(node.getCreator()._strV);
              Resume resume_obj=Resume.find(nodeid,1);
              ApplyTable at = ApplyTable.find(ja.getApplyTable());
              AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,node.getCreator()._strV);

              %>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                <td nowrap><input id=CHECKBOX type="CHECKBOX" name="resumes" value="<%=nodeid%>"/><input type="hidden" name="job<%=nodeid%>" value="<%=jobid%>"/></td>
                  <td nowrap><a href="/jsp/type/resume/Preview.jsp?resumes=<%=nodeid%><%="&job="+job%>"><%=profile.getName(teasession._nLanguage)%></a></td>
                  <td nowrap ><%=Node.find(jobid).getSubject(teasession._nLanguage)%></td>
                  <td nowrap ><%=r.getString(teasession._nLanguage,profile.isSex()?"1167457951671":"1167457972406")%></td>
                  <td nowrap ><%=profile.getAge()%></td>
                  <td nowrap ><%=tea.htmlx.DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%></td>
                  <td nowrap><%=profile.getSchool(teasession._nLanguage)%></td>
                  <%
                  for(int index=0;index<Common.ZCSZY.length;index++)
                  {
                    if(Common.ZCSZY[index][0].equals(resume_obj.getNowmaincareer()))
                    out.print("<td nowrap>"+Common.ZCSZY[index][1] +"</td>");
                  }
                  %>
                  <td nowrap><%=resume_obj.getExperience()%></td>
                  <td nowrap><%=resume_obj.getExpectcareerToHtml()%></td>
                  <td nowrap><%
                  StringBuffer sb = new StringBuffer();
                  java.util.Enumeration enumerationabc = Educate.find(nodeid, 1);
                  while (enumerationabc.hasMoreElements())
                  {
                    Educate educate = Educate.find( ( (Integer) enumerationabc.nextElement()).intValue());
                    sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                  }
                  out.print(sb.toString());
                  %>
                  </td>
                  <td nowrap><a href="mailto:<%=profile.getEmail()%>"><%=profile.getEmail()%></A></td>
                  <!--
                  <%
                  if(ja.getApplyTable()!=0)
                  out.print(new tea.html.Anchor("/servlet/EditApplyTable?act=down&applytable="+ja.getApplyTable(),r.getString(teasession._nLanguage,"1167458057468")));
                  else
                  out.print(r.getString(teasession._nLanguage,"1167458013921"));
                  %></td-->
                  <td align="center" nowrap><%=ja.getTimeToString()%></td>
                  <td align="center" nowrap><%

  java.util.Enumeration enumerApplyTable= tea.entity.node.ApplyTable.findByMember(member,community);
  if(enumerApplyTable.hasMoreElements())
  {
    out.print(new tea.html.Anchor("/servlet/EditApplyTable?act=down&applytable="+((Integer)  enumerApplyTable.nextElement()).intValue(),r.getString(teasession._nLanguage,"1167458057468")));//"有"
  }else
  out.print(r.getString(teasession._nLanguage,"1167458013921"));//"无"

//                  if(at.getName()!=null&&at.getName().length()>0)
//                  {
//                    out.print("<a href =\"/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(at.getFile(),"UTF-8")+"&name="+java.net.URLEncoder.encode("简历.doc","UTF-8")+"\">简历下载</a><br>");
//                  }
                  %></td>
                  <%if(typeals==4)
                  {%>
                  <td>
                    <INPUT TYPE=button VALUE=成为正式会员 onClick=f_bcm('<%=node.getCreator()._strV%>','<%=aur.getUnit()%>'); >
                  </td>
                  <%}%>
              </tr>
              <%
              }
              %>
              <tr>
                <td colspan="2"><input id=CHECKBOX type="CHECKBOX" onClick="selectAll(form1.resumes,checked)"/><%=r.getString(teasession._nLanguage,"1167445122937")%></td>
                <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?community="+teasession._strCommunity+"&pos=",pos,count)%></td>
              </tr>
        </table>


        <%
        //<!--查看-->
        //out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167444621250")+" onClick=f_act('view');>");

        if(type==3){//用系统管理着通知面试者到公司面试

        out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"通知应聘者面试")+" onClick=f_act('type',4)>");
      }else
      {
        //              if(type==1)
        //              out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"通知面试")+" onClick=f_act('type',3)>");
        if(type!=1)
        {
          //<!--转入人才库-->
          out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458160093")+" onClick=f_act('type',1)>");
        }
        //              if(type!=2)
        //              {
          //                //<!--将选中项设为本岗位有价值简历-->
          //                out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458207343")+" onClick=f_act('type',2)>");
          //              }


          //<INPUT TYPE="submit" name="not" VALUE="将选中项设为不合格简历" onClick="window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';" /><input type="button" value="查看" onclick="window.open('/jsp/type/resume/yjobapplymanage.jsp?ResumeSorttype=3<%if(applyAmount!=null)out.print("&applyAmount="+applyAmount);+','_self')"/>
          //<INPUT TYPE="submit" name="del" VALUE="+r.getString(teasession._nLanguage,"CBDelete")+" onClick="if(!confirm('+r.getString(teasession._nLanguage,"ConfirmDeleteSelected")+'))return false;form2.nexturl.value='+(request.getRequestURI()+"?"+request.getQueryString())+';window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';" />

          //<!--发信到选中项-->
          //              out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458288546")+" onClick=f_act('email')>");
          if(typeals!=4)
          {
            out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"通知面试")+" onClick=f_act('type',3)>");
          }


          //<!--推荐应聘简历-->
          //out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458313718")+" onClick=f_act('hr')>");

          //<INPUT name="BUTTON" TYPE="button" ID="BUTTON" onClick="window.document.form2.action='/servlet/ExportResume';form2.target='_blank';" VALUE="将选中项导出"/>

          //<!--将选中项以Excel导出-->
          out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458350890")+" onClick=f_act('exp')>");

          //<!--下载申请表-->
          //out.println("<INPUT TYPE=button VALUE="+r.getString(teasession._nLanguage,"1167458390031")+" onClick=f_act('down')>");
        }


        //<!--将选中项以XML导出,用于SAP系统-->
        //<INPUT name="BUTTON" TYPE="submit" ID="BUTTON" onClick="if(returnCheck()){window.document.form2.action='/jsp/type/resume/Output.jsp';form2.target='_self';}else return false;" VALUE="+r.getString(teasession._nLanguage,"1167458433125")+"/>

        %>
        </form>

        <br>
        <div id="head6"><img height="6" src="about:blank"></div>
      </body>
</html>
