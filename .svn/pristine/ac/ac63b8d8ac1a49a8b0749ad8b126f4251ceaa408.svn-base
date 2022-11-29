<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
Purview purview=Purview.find(teasession._rv.toString());
if(!purview.isResume()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
int pagesize=15;
%>
<html>
<head>
<title>简历管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>
<div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">简历管理</h1>
            <form name="form1" method="post" action="/servlet/ExportResume">
			<!--<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;border-bottom:0px" align="center">
  <tr  bgcolor="#FFFBF0">
    <td align="left" style="padding:5px "><span >&nbsp;&nbsp;共收到　份简历.您可以按条件进行<a href="#">简历检索</a></td>
  </tr>
  </table>-->
<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" align="center">
  <tr align="center" bgcolor="#FFFBF0">
    <td>    </td>
    <td nowrap>姓名</td>
    <td nowrap>性别</td>
    <td nowrap>年龄</td>
    <td nowrap>国籍</td>
    <td nowrap>学历</td>
    <td nowrap>毕业学校</td>
    <td nowrap>期望工作地区</td>
    <td nowrap>工作经验</td>
    <td nowrap>期望从事职业</td>
    <td nowrap>专业</td>
    <td nowrap>电子邮箱</td>
        <td nowrap>更新日期</td>
  </tr>
  <%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=Node.find(teasession._nNode).getCommunity();
String strPurview =purview.getNode();
java.util.Vector vector=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
StringBuffer sb=new StringBuffer();
String ExpectCareer=request.getParameter("sltOccId_list");//期望从事职业
if(ExpectCareer!=null&&ExpectCareer.length()>0)
{
    sb.append("  AND Resume.ExpectCareer like '%"+new String(ExpectCareer.getBytes("ISO-8859-1"))+"%'");
}
String ExpectCity=request.getParameter("tgt_loc_city_id");//工作地区
if(ExpectCity!=null&&ExpectCity.length()>0)
{
    ExpectCity=new String(ExpectCity.getBytes("ISO-8859-1"));
    if(!ExpectCity.equals("--选择城市--"))
    sb.append(" AND  Resume.ExpectCity like '%"+ExpectCity+"%'");
}

String Degree=request.getParameter("skr_deg_id");//学历
if(Degree!=null&&Degree.length()>0)
sb.append("  AND ProfileLayer.degree <="+Degree);

String age=request.getParameter("age");//性别
if(age!=null&&age.length()>0)
{
    switch(Integer.parseInt(age))
    {
        case 1:
        sb.append(" AND  Profile.age >=18 AND  Profile.age<25");
        break;
        case 2:
        sb.append(" AND  Profile.age >=25 AND  Profile.age<30");
        break;
        case 3:
        sb.append(" AND  Profile.age >=30 AND  Profile.age<35");
        break;
        case 4:
        sb.append("  AND Profile.age >=35 AND  Profile.age<40");
        break;
        case 5:
        sb.append(" AND  Profile.age >=40 AND  Profile.age<45");
        break;
        case 6:
        sb.append(" AND  Profile.age >=45 AND  Profile.age<50");
        break;
        case 7:
        sb.append(" AND  Profile.age >=50 ");
    }
}
String sex=request.getParameter("sex");//年龄
if(sex!=null&&sex.length()>0)
sb.append("  AND Profile.sex ="+sex);

String Experience=request.getParameter("skr_wrk_year");//工作经验
if(Experience!=null&&Experience.length()>0)
{
    if((Experience).equals("0"))
    sb.append("  AND Resume.Experience <1");
    else
    sb.append("  AND Resume.Experience >="+Experience);
}
String keyword=request.getParameter("keyword");//关键字
if(keyword!=null&&keyword.length()>0)
{keyword=keyword.trim();
String KEYWORD[]={"name","NowTrade","NowMainCareer"  ,
"NowCareerLevel",
"SalarySum"     ,
"ExpectTrade"    ,
"ExpectCareer"   ,
"ExpectCity"     ,
"ExpectSalarySum",
"JoinDateType"   ,
"SelfValue"      ,
"SelfAim"        };
//keyword=new String(keyword.getBytes("ISO-8859-1"));
sb.append(" AND (Resume."+KEYWORD[0]+" like '%"+keyword+"%' ");
for(int len=1;len<KEYWORD.length;len++)
sb.append(" OR Resume."+KEYWORD[len]+" like '%"+keyword+"%' ");
sb.append(")");
}
        try
        {

            dbadapter.executeQuery("SELECT DISTINCT( Node.node ),Node.time FROM Node,Resume,ProfileLayer,Profile,Educate,Employment WHERE Educate.node=Resume.node AND Employment.node=Resume.node AND Resume.node=Node.node AND ProfileLayer.member=Profile.member AND Profile.member=Resume.member AND Node.type=52 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY Node.time desc");
            for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
        } catch (Exception exception)
        {
           exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }

int count=vector.size();out.print("总数为："+count);
java.util.Enumeration enumeration=vector.elements();
int nodeCode;
int pos=request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos").trim())-1;
for(int len=0;len<pos*pagesize&&enumeration.hasMoreElements();enumeration.nextElement(),len++);
//java.util.Enumeration enumeration=tea.entity.node.Node.findByType(50,community);
//while(enumeration.hasMoreElements())
for(int len=0;len<pagesize&&enumeration.hasMoreElements();len++)
{
nodeCode =((Integer)enumeration.nextElement()).intValue();
Resume summary=Resume.find(nodeCode,1);
Profile profile = Profile.find(summary.getMember());
%>
<tr>
    <td nowrap>
        <Span ID=ResumeIDCheckbox>
            <input  id=CHECKBOX type="CHECKBOX" name="checkbox<%=nodeCode%>"/>
        </Span>
    </td>
    <td nowrap align=left>
        <Span ID=ResumeIDname><a href="/jsp/type/resume/Preview.jsp?resumes=<%=nodeCode%>">&nbsp;<%=getNull(profile.getFirstName(1))%></a></Span>    </td>
    <td nowrap align=center>
        <Span ID=ResumeIDSex><%=profile.isSex()?"男":"女"%></Span>
    </td>
    <td nowrap align=center>
        <Span ID=ResumeIDBirTD><%=profile.getAge()%></Span>
    </td>
    <td nowrap align=center>
        <Span ID=ResumeIDState><%=getNull(profile.getState(teasession._nLanguage))%></Span>
    </td>
    <td nowrap align=center>
        <Span ID=ResumeIDDegree><%=DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%></Span>
    </td>
            <td nowrap>
        <Span ID=ResumeIDNowTrade><%=profile.getSchool(teasession._nLanguage)%></Span>
    </td>
    <td nowrap>
        <Span ID=ResumeIDNowTrade><%=summary.getExpectCity().replaceAll("&",",")%>　<%//=TradeSelection.getTrade(summary.getNowTrade())%></Span>
    </td>

    <td nowrap align=center>
        <Span ID=ResumeIDExperience><%=summary.getExperience()%>年</Span>
    </td>
    <td nowrap>
        <Span ID=ResumeIDExpectCity>　<%=summary.getNowMainCareer()%></Span>
    </td>
    <td nowrap>
        <Span ID=ResumeIDMajorCategory>　
        <%
                                sb = new StringBuffer();
                        java.util.Enumeration enumerationEducate = Educate.find(nodeCode, 1);
                        while (enumerationEducate.hasMoreElements())
                        {
                            Educate educate = Educate.find( ( (Integer) enumerationEducate.nextElement()).intValue());
                            sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                        }
                       out.print(sb.toString());
        %>      </Span>
    </td>
    <td nowrap>
        <Span ID=ResumeIDEmailAddress><A href="mailto:<%=getNull(profile.getEmail())%>">&nbsp;<%=getNull(profile.getEmail())%></A></Span>
    </td>
        <td align="center" nowrap>
        <Span ID=ResumeIDEmailAddress><%=Node.find(nodeCode).getTime("yyyy-MM-dd")%></Span>    </td>
</tr>
<%}%>
<tr bgcolor="#FFFBF0"><td colspan="12"><Span ID=ResumeIDCheckbox><input  id=CHECKBOX type="CHECKBOX" name=allselect onClick="fclick()"/></Span>&nbsp;全选</td></tr></table>


    <LI ID="PageNum">
<%
int sum=count/pagesize;
if(count%pagesize!=0)
sum=sum+1;
if(count>pagesize)
{String pospath=request.getRequestURI()+"?node="+teasession._nNode+"&pos=";
    if(pos>0)
    out.print("<A HREF="+pospath+pos+" >上一页</A> ");

    int showsum=pos+5;
    int len=pos-4;
    if(len<1)
    {
    showsum=showsum-len;
    len=1;
  }
  if(showsum>sum)
  showsum=sum;

    for(;len<=showsum;len++)
    {
        if((pos+1)==len)
        out.println("<span>"+len+"</span> ");
        else
        out.print("<A HREF="+pospath+len+">"+len+"</A> ");
    }
    if((pos+2)<=sum)
    out.print("<A HREF="+pospath+(pos+2)+">下一页</A> ");
    %>
    <input name="pos" value="<%=pos+1%>" size="4"/><input onclick="if(submitInteger(document.all['pos'],'无效页数')){window.open('<%=pospath%>'+document.all['pos'].value,'_self');}" type="button" value="GO" CLASS="in" />
共页数:<%=sum%>
 <%
}
%>
</LI>


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
</script><div style="TEXT-ALIGN: center;padding-top:5px">
  <INPUT name="BUTTON" TYPE="button" CLASS="in" ID="BUTTON2"  VALUE="查询" onclick="window.open('/jsp/type/resume/ResumeSearch.jsp','_self')"/>
  <INPUT TYPE="submit" VALUE="发信到选中项" ID="CBNewCompany" CLASS="in"  onClick="window.document.form1.action='/jsp/type/resume/SendEmailCandidate.jsp';form1.target='_self';"  />

  <INPUT name="BUTTON" TYPE="submit" CLASS="in" ID="BUTTON2" onclick="window.document.form1.action='/servlet/ExportResume';form1.target='_blank';"  VALUE="导出选中项"/>
  </form>
</div></div></div></div>
<%@include file="/jsp/type/job/cnoocjobfooter.jsp" %>

