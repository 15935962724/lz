<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>


<%!
Purview purview;
String community;
java.util.Enumeration enumeration;
StringBuffer sb;
public java.util.Enumeration getOrg() throws java.sql.SQLException
{DbAdapter dbadapter= new DbAdapter();
    StringBuffer sb=new StringBuffer();
    if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
    {
        java.util.StringTokenizer tokenizer=new StringTokenizer(purview.getNode(),"/");
        if(tokenizer.hasMoreTokens())
        sb.append(" and (Node.node="+tokenizer.nextToken());
        while(tokenizer.hasMoreTokens())
        {
            sb.append(" OR Node.node="+tokenizer.nextToken());
        }
        sb.append(")");
    }
    java.util.Vector vector=new java.util.Vector();
    try
    {
        dbadapter.executeQuery("SELECT node FROM Node  WHERE type=21 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");
        for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
    } catch (Exception exception)
    {
        exception.printStackTrace();
    }finally
    {
      dbadapter.close();
    }
    return vector.elements();
}
%>





<%
 DbAdapter dbadapter= new DbAdapter();
 purview=Purview.find(teasession._rv.toString());
if(!purview.isApply()&&!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
{
    ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
int pagesize=15;





 community=Node.find(teasession._nNode).getCommunity();



String strPurview =purview.getNode();
StringBuffer sbNode=new StringBuffer();
if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase("cnooc"))
{
    java.util.StringTokenizer tokenizer=new StringTokenizer(strPurview,"/");
    if(tokenizer.hasMoreTokens())
        sbNode.append(" AND (Job.orgid="+tokenizer.nextToken());
        while(tokenizer.hasMoreTokens())
        {
            sbNode.append(" OR Job.orgid="+tokenizer.nextToken());
        }
    sbNode.append(")");
}

StringBuffer sbNode2=new StringBuffer();
String applyAmount=request.getParameter("applyAmount");
String keyword=request.getParameter("keyword");
if(keyword!=null&&keyword.length()>0)
{
    sbNode2.append(" AND Job.name like '%"+keyword.trim()+"%' ");
}
if(applyAmount!=null&&applyAmount.length()>0)
sbNode2.append(" AND Job.node="+applyAmount);
else
{
    String orgid=request.getParameter("orgid");
    if(orgid!=null&&orgid.length()>0)
    sbNode2.append(" AND Job.orgid="+orgid);
}




String ExpectCareer=request.getParameter("sltOccId_list");//期望从事职业
if(ExpectCareer!=null&&ExpectCareer.length()>0)
{
    sbNode2.append("  AND Resume.ExpectCareer like '%"+new String(ExpectCareer.getBytes("ISO-8859-1"))+"%'");
}
String ExpectCity=request.getParameter("tgt_loc_city_id");//工作地区
if(ExpectCity!=null&&ExpectCity.length()>0)
{
    ExpectCity=new String(ExpectCity.getBytes("ISO-8859-1"));
    if(!ExpectCity.equals("--选择城市--"))
    sbNode2.append(" AND  Resume.ExpectCity like '%"+ExpectCity+"%'");
}

String Degree=request.getParameter("skr_deg_id");//学历
if(Degree!=null&&Degree.length()>0)
sbNode2.append("  AND ProfileLayer.degree <="+Degree);

String age=request.getParameter("age");//性别
if(age!=null&&age.length()>0)
{
    switch(Integer.parseInt(age))
    {
        case 1:
        sbNode2.append(" AND  Profile.age >=18 AND  Profile.age<25");
        break;
        case 2:
        sbNode2.append(" AND  Profile.age >=25 AND  Profile.age<30");
        break;
        case 3:
        sbNode2.append(" AND  Profile.age >=30 AND  Profile.age<35");
        break;
        case 4:
        sbNode2.append("  AND Profile.age >=35 AND  Profile.age<40");
        break;
        case 5:
        sbNode2.append(" AND  Profile.age >=40 AND  Profile.age<45");
        break;
        case 6:
        sbNode2.append(" AND  Profile.age >=45 AND  Profile.age<50");
        break;
        case 7:
        sbNode2.append(" AND  Profile.age >=50 ");
    }
}
String sex=request.getParameter("sex");//年龄
if(sex!=null&&sex.length()>0)
sbNode2.append("  AND Profile.sex ="+sex);

String Experience=request.getParameter("skr_wrk_year");//工作经验
if(Experience!=null&&Experience.length()>0)
{
    if((Experience).equals("0"))
    sbNode2.append(" AND Resume.Experience <1");
    else
    sbNode2.append(" AND Resume.Experience >="+Experience);
}
/*
String keyword=request.getParameter("keyword");//关键字
if(keyword!=null&&keyword.length()>0)
{
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
sbNode2.append(" AND (Resume."+KEYWORD[0]+" like '%"+keyword+"%' ");
for(int len=1;len<KEYWORD.length;len++)
sbNode2.append(" OR Resume."+KEYWORD[len]+" like '%"+keyword+"%' ");
sbNode2.append(")");
}*/

String strResumeSorttype=request.getParameter("ResumeSorttype");
String table=" Node,Apply,Job,Resume ";
if(strResumeSorttype!=null)
{
    String  strResumeSortjob=request.getParameter("ResumeSortjob");
    if(strResumeSortjob!=null)
    {
        strResumeSortjob=" AND ResumeSort.job=" +strResumeSortjob+" AND Apply.corpnode="+strResumeSortjob;
    } else
    strResumeSortjob="";
    table=table+",ResumeSort ";
    sbNode2.append(" AND ResumeSort.member="+dbadapter.cite(teasession._rv.toString())+" AND ResumeSort.resume=Resume.node AND ResumeSort.type="+strResumeSorttype+strResumeSortjob);
}
java.util.Vector vector=new java.util.Vector();java.util.Vector vector2=new java.util.Vector();
java.util.Vector vector3=new java.util.Vector();
        try
        {
            dbadapter.executeQuery("SELECT Node.node FROM Node,Apply,Job,Resume  WHERE   Resume.node=Node.node AND Resume.node=Apply.resumenode AND Apply.corpnode=Job.node AND type=52 AND community="+dbadapter.cite(community)+sbNode.toString()+" ORDER BY sequence");
            for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
//System.out.print("SELECT DISTINCT  Node.node,Apply.corpnode FROM Node,Apply,Job,Resume,ResumeSort  WHERE Resume.node=Node.node AND Resume.node=Apply.resumenode AND Apply.corpnode=Job.node AND Node.type=52 AND community="+dbadapter.cite(community)+sbNode.toString()+sbNode2.toString());
            dbadapter.executeQuery("SELECT DISTINCT  Node.node,Apply.corpnode FROM "+table+"  WHERE Resume.node=Node.node AND Resume.node=Apply.resumenode AND Apply.corpnode=Job.node AND Node.type=52 AND community="+dbadapter.cite(community)+sbNode.toString()+sbNode2.toString());//+" ORDER BY Apply.appdate DESC");
            for (; dbadapter.next(); vector2.addElement(new Integer(dbadapter.getInt(1))),vector3.addElement(new Integer(dbadapter.getInt(2))));
        } catch (Exception exception)
        {
           exception.printStackTrace();
        } finally
        {

        }
        int nodeCode;
int count=vector2.size();
int countsize=vector.size();
%>






<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>
<div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">应聘管理</h1>

<form name="foEdit" method="post" action="/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542">

<table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;border-bottom:0px" align="center">
  <tr  bgcolor="#FFFBF0">
    <td align="left" style="padding:5px "><span >&nbsp;&nbsp;您所发布的职位共有 <%=countsize%> 人应聘.<%if(countsize>count)out.println("查找到 "+count+" 个");if(applyAmount==null){ %>

<SELECT NAME="orgid"  onchange="fadd(foEdit.orgid.options[foEdit.orgid.selectedIndex].value)">
<OPTION VALUE="">--请选择招聘机构--</OPTION>

<%         enumeration=getOrg();
            sb=new StringBuffer();
   sb.append("<script>function fadd(value){ var ccc=foEdit.applyAmount.length; for(;1<=ccc;ccc--)foEdit.applyAmount.remove(ccc);");
while(enumeration.hasMoreElements())
{int len;
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   dbadapter.executeQuery("SELECT Job.node FROM Node,Job WHERE Node.node=Job.node AND orgid ="+nodeCode);
      sb.append("if(value=="+nodeCode+"){\r\n");
while(dbadapter.next())
{
    len=dbadapter.getInt(1);
    Job job=Job.find(len,1);
sb.append("foEdit.applyAmount.options.add(new Option('"+job.getName()+"','"+len+"'));\r\n");
}
sb.append("} else ");
%>
<OPTION VALUE="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}
sb=sb.delete(sb.length()-5,sb.length());
sb.append("}</script>");
%>
</SELECT>
<select name="applyAmount" STYLE="WIDTH: 200px">
    <option value="">----请选择职位----</option>
</select>
<%=sb.toString()%>
<input name="keyword"/>
<%
if(strResumeSorttype!=null)
out.println("<input type=hidden name=ResumeSorttype value="+strResumeSorttype+" />");
%>
<span >
<input name="submit" type="submit" class="in" value="查询"/>
<input name="button" type="button" class="in" value="高级查询" onclick="window.open('/jsp/type/resume/ApplySearch.jsp<%
if(strResumeSorttype!=null)
out.print("?ResumeSorttype="+strResumeSorttype);
%>','_self')"/>
</span>

    </span></span><%}%></td>
  </tr></table>

</form>

<%//没有检索&& 也是没有检索  && 不是在备选简历或价值简历或不合格简历 的相看中
if(applyAmount==null&&(keyword==null)&&strResumeSorttype==null)
{
    if(request.getParameter("stat")==null){
    %>
    <jsp:include flush="true" page="cnoocjobapplymanage2.jsp">
        <jsp:param name="Node" value="15542"/>
    </jsp:include>

<%         }else{%>
    <jsp:include flush="true" page="cnoocjobapplymanage3.jsp">
        <jsp:param name="Node" value="15542"/>
    </jsp:include>
<%}%>
<%}else{%>

<form action="/servlet/ExportResume" name="form2" target="_blank">
    <table width="98%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;" align="center">
        <tr align="center" bgcolor="#FFFBF0">
            <td>    </td>
            <td nowrap>姓名</td>
            <td nowrap>应聘职位</td>
            <td nowrap>性别</td>
            <td nowrap>年龄</td>
            <td nowrap>学历</td>
            <td nowrap>毕业学校</td>
            <td nowrap>现从事行业</td>
            <td nowrap>工作经验</td>
            <td nowrap>期望工作职业</td>
            <td nowrap>专业</td>
            <td nowrap>电子邮箱</td>
            <td nowrap>申请表</td>
            <td nowrap>申请日期</td>
        </tr>
        <%
        if(applyAmount!=null) out.print(new tea.html.HiddenField("applyAmount",applyAmount));

        enumeration=vector2.elements();
        java.util.Enumeration enumerationJobName=vector3.elements();
        int pos=request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"))-1;
        for(int len=0;len<pos*pagesize&&(enumeration.hasMoreElements()&&enumerationJobName.hasMoreElements());enumeration.nextElement(),enumerationJobName.nextElement(),len++);
        //java.util.Enumeration enumeration=tea.entity.node.Node.findByType(50,community);
        //while(enumeration.hasMoreElements())
        int JobNameCode;int jobApply;
        for(int len=0;len<pagesize&&enumeration.hasMoreElements()&&enumerationJobName.hasMoreElements();len++)
        {
            nodeCode =((Integer)enumeration.nextElement()).intValue();
            Resume summary=Resume.find(nodeCode,1);
            Profile profile = Profile.find(summary.getMember());
            JobNameCode=((Integer)enumerationJobName.nextElement()).intValue();
            Apply applyObj=            Apply.find(JobNameCode,nodeCode);
            jobApply=applyObj.getCorpNode();

            %>
            <tr>
                <td nowrap>
                    <Span ID=ResumeIDCheckbox>
                        <input  id=CHECKBOX type="CHECKBOX" name="Node" value="<%=nodeCode%>"/>
                        </Span>
                    </td>
                    <td nowrap align=center>
                        <input type="hidden" name="jobcheckbox<%=nodeCode%>" value="<%=jobApply%>"/>
                        <Span ID=ResumeIDname><a href="/jsp/type/resume/Preview.jsp?resumes=<%=nodeCode%><%if(applyAmount!=null)out.println("&applyAmount="+applyAmount);%>"><%=getNull(profile.getFirstName(teasession._nLanguage))%></A></Span>
                    </td>
                    <td nowrap align=left>
                        <Span ID=ResumeIDState>&nbsp;<%=Node.find(jobApply).getSubject(1)%></Span>
                    </td>
                    <td nowrap align=center>
                        <Span ID=ResumeIDSex><%=profile.isSex()?"男":"女"%></Span>
                    </td>
                    <td nowrap align=center>
                        <Span ID=ResumeIDBirTD><%=profile.getAge()%></Span>
                    </td>
                    <td nowrap align=center>
                        <Span ID=ResumeIDDegree><%=DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))%></Span>
                    </td>
                     <td nowrap>
                       <Span ID=ResumeIDNowTrade><%=profile.getSchool(teasession._nLanguage)%></Span>
                     </td>
                    <td nowrap>
                        <Span ID=ResumeIDNowTrade><%=summary.getNowMainCareer()%><%=TradeSelection.getTrade(summary.getNowTrade())%></Span>
                    </td>
                    <td nowrap>
                        <Span ID=ResumeIDExperience>　<%=summary.getExperience()%>年</Span>
                    </td>
                    <td nowrap>
                        <Span ID=ResumeIDExpectCity>　<%
                  StringTokenizer   tokenizer=new StringTokenizer(getNull(summary.getExpectCareer()),"&");
                    while(tokenizer.hasMoreTokens())
                    {out.print(tokenizer.nextToken()+"<br>");
                    }%></Span>
                    </td>
                    <td nowrap>
                        <Span ID=ResumeIDMajorCategory>　
                            <%
                            sb = new StringBuffer();
                            java.util.Enumeration enumerationabc = Educate.find(nodeCode, 1);
                            while (enumerationabc.hasMoreElements())
                            {
                                Educate educate = Educate.find( ( (Integer) enumerationabc.nextElement()).intValue());
                                sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                            }
                            out.print(sb.toString());
                            %>      </Span>
                            </td>
                            <td nowrap>
                                <Span ID=ResumeIDEmailAddress><a href="mailto:<%=profile.getEmail()%>"><%=profile.getEmail()%></A></Span>
                            </td>
                            <td align="center" nowrap>
                                <Span ID=ResumeIDEmailAddress><%
                                if(applyObj.getApplyTable()!=0)
out.print(new tea.html.Anchor("/servlet/EditApplyTable?act=down&applytable="+applyObj.getApplyTable(),"有"));
else
out.print("无");
                                %></Span>    </td>
                            <td align="center" nowrap>
                                <Span ID=ResumeIDEmailAddress><%=applyObj.getAppDate("yyyy-MM-dd")%></Span>    </td>
                            </tr>
                            <%}%>
                            <tr bgcolor="#FFFBF0"><td colspan="12"><Span ID=ResumeIDCheckbox><input  id=CHECKBOX type="CHECKBOX" name=allselect onClick="fclick()"/></Span>&nbsp;全选</td></tr></table>
                            <LI ID="PageNum">
                                <%
                                if(pagesize<count)
                                {
                                  String param=applyAmount!=null&&applyAmount.length()>0?"&applyAmount="+applyAmount:"";
                                    int sum=count/pagesize;
                                    if(count%pagesize!=0)
                                    sum=sum+1;
                                    if(sum>0)
                                    {
                                        if(pos>0)
                                        out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+pos+param+" >上一页</A> ");

                                        for(int len=1;len<=sum;len++)
                                        {
                                            if((pos+1)==len)
                                            out.println("<span>"+len+"</span> ");
                                            else
                                            out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+len+param+">"+len+"</A> ");
                                        }
                                        if((pos+2)<=sum)
                                        out.print("<A HREF="+request.getRequestURI()+"?node="+teasession._nNode+"&pos="+(pos+2)+param+">下一页</A> ");
                                    }
                                }

                                %>
                                </LI>
                                <script>
                                    function fclick()
                                    {
                                        for(var counter=0;counter<form2.elements.length;counter++)
                                        {
                                            if(form2.elements[counter].type=="checkbox")
                                            {
                                                form2.elements[counter].checked=form2.elements["allselect"].checked;
                                            }
                                        }
                                    }
                                    </script><div style="TEXT-ALIGN: center;padding-top:5px">
                                      <input type=hidden name="act" value="">
<INPUT TYPE="submit" name="standby" VALUE="查看" ID="CBNewCompany" onClick="if(returnCheck()){window.document.form2.action='/jsp/type/resume/Preview.jsp';form2.target='_self';}else return false;"  CLASS="in"/>
<INPUT TYPE="submit" name="standby" VALUE="转入人才库" ID="CBNewCompany" onClick="window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';"  CLASS="in"/><input  CLASS="in" type="button" value="查看" onclick="window.open('/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=1<%if(applyAmount!=null)out.print("&applyAmount="+applyAmount);%>','_self')"/>
                                    <INPUT TYPE="submit" name="value" VALUE="将选中项设为有价值简历" ID="CBNewCompany" onClick="window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';"  CLASS="in" /><input  CLASS="in" type="button" value="查看" onclick="window.open('/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=2<%if(applyAmount!=null)out.print("&applyAmount="+applyAmount);%>','_self')"/>
<%--                                    <INPUT TYPE="submit" name="not" VALUE="将选中项设为不合格简历" ID="CBNewCompany" onClick="window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';"  CLASS="in" /><input  CLASS="in" type="button" value="查看" onclick="window.open('/jsp/type/resume/cnoocjobapplymanage.jsp?node=15542&ResumeSorttype=3<%if(applyAmount!=null)out.print("&applyAmount="+applyAmount);%>','_self')"/>--%>
  <INPUT TYPE="submit" name="del" VALUE="删除" ID="CBNewCompany" onClick="if(!confirm('确认删除?'))return false;window.document.form2.action='/servlet/EditResumeSort';form2.target='_self';"  CLASS="in" />
                                    <INPUT TYPE="submit" VALUE="发信到选中项" ID="CBNewCompany" CLASS="in"  onClick="window.document.form2.action='/jsp/type/resume/SendEmailCandidate.jsp';form2.target='_blank';"  />
                                    <INPUT TYPE="submit" VALUE="推荐应聘简历" ID="CBNewCompany" CLASS="in"  onClick="if(returnCheck()){window.document.form2.action='/jsp/type/resume/SendEmailCandidate.jsp';form2.target='_self';form2.act.value='hr';}else return false;"  />
<%--                                    <INPUT name="BUTTON" TYPE="button" CLASS="in" ID="BUTTON" onClick="window.document.form2.action='/servlet/ExportResume';form2.target='_blank';" VALUE="将选中项导出"/>--%>
                                      <INPUT name="BUTTON" TYPE="button" CLASS="in" ID="BUTTON" onClick="ExportResumeAlertOpen()" VALUE="将选中项导出"/>
                                </div></div></div></div>
                            </form>
<script type="">
function ExportResumeAlertOpen()
{
  var param='';var counter=0;
  for(;counter<window.document.form2.elements.length;counter++)
  {
    if(window.document.form2.elements[counter].type=="checkbox"&&window.document.form2.elements[counter].checked==true)
    {
      param+='&node='+window.document.form2.elements[counter].value;
    }
  }
  if(param.length==0)
  alert('请先选择,要导出的项.');
  else
  window.open('/jsp/type/resume/ExportResumeAlert.jsp?a=a'+param,'','height=170px,width=370px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');
}
function returnCheck()
{
  var counter=0;
  for(;counter<window.document.form2.elements.length;counter++)
  {
    if(window.document.form2.elements[counter].type=="checkbox"&&window.document.form2.elements[counter].checked==true)
    {
      return true;
    }
  }
  alert('请先选择.');
  return false;
}

</script>
<%                            }dbadapter.close();%>
<%@include file="/jsp/type/job/cnoocjobfooter.jsp" %>

