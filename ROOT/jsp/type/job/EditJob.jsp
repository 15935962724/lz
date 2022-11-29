<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%!

String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getSelect(boolean i)
{
	return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}
String getDisplay(boolean bool)
{
    return bool?" style=\"display:\" ":" style=\"display:none\" ";
}
%>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

int copy=teasession._nNode;
Node node = Node.find(teasession._nNode);
String tmp=request.getParameter("copynode");
if(tmp!=null&&tmp.length()>0)
{
  copy=Integer.parseInt(tmp);
}
Job job;
String subject,text;
if(request.getParameter("NewNode")!=null&&copy==teasession._nNode)
{
    job=Job.find(0,0);
    text=subject="";
}else
{
    Node n=Node.find(copy);
    subject=n.getSubject(teasession._nLanguage);
    text=n.getText(teasession._nLanguage);

    job= Job.find(copy, teasession._nLanguage);
}
Resource r = new Resource();
r.add("/tea/resource/Job");

SupplierMember sm=SupplierMember.find(teasession._strCommunity,teasession._rv._strV);

String community=node.getCommunity();

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fadd(obj1,obj2,size)
{
  for(var i=0;i<obj1.options.length;i++)
  {
    if(obj1.options[i].selected)
    {
      for(var j=0;j<=obj2.options.length&&j<size;j++)
      {
        if(j==obj2.options.length)
        {
          obj2.options[j]=new Option(obj1.options[i].text,obj1.options[i].value);
          break;
        }else
        if(obj2.options[j].value==obj1.options[i].value)
        {
          break;
        }
      }
    }
  }
}
function fdel(obj)
{
  for(var i=obj.options.length-1;i>-1;i--)
  {
    if(obj.options[i].selected)
    {
      obj.options[i]=null;
    }
  }
}

function alteroption(select1,select2)
{
  var ccc=select2.length;
  for(var len=0;ccc>=0;ccc--)
  select2.options[ccc]=null;
  switch(select1.value)
  {
    <%
    java.util.Enumeration smallOccScript,bigOccScript=Occupation.findByFather(Occupation.getRootId(community));
    StringBuffer sbBig=new StringBuffer();
    StringBuffer sbSmall=new StringBuffer();
    while(bigOccScript.hasMoreElements())
    {
      int occ=((Integer)bigOccScript.nextElement()).intValue();
      Occupation occ_obj=Occupation.find(occ);
      out.println("case '"+occ_obj.getCode()+"' : ");
      String temp=occ_obj.getSubject();
      smallOccScript=Occupation.findByFather(occ);
      sbBig.append("<OPTION VALUE="+occ_obj.getCode()+">"+temp+"</OPTION>");
      sbSmall.append("select2.options.add(new Option(\""+temp+"\",\""+occ_obj.getCode()+"\"));");
      out.println("select2.options.add(new Option(\""+temp+"\",\""+occ_obj.getCode()+"\"));");
      for(int smallIndex=0;smallOccScript.hasMoreElements();smallIndex++)
      {
        occ=((Integer)smallOccScript.nextElement()).intValue();
        occ_obj=Occupation.find(occ);
        temp=occ_obj.getSubject();
        out.println("select2.options.add(new Option(\"-- "+temp+"\",\""+occ_obj.getCode()+"\"));");
        sbSmall.append("select2.options.add(new Option(\"-- "+temp+"\",\""+occ_obj.getCode()+"\"));");
      }
      out.println("break;");
    }
    out.println("default : "+sbSmall.toString());
    %>
  }
}

function alteroption_jobcity(select1,select2)
{
  var ccc=select2.length;
  for(var len=0;ccc>=0;ccc--)
  select2.options[ccc]=null;
  switch(select1.value)
  {
    <%
    java.util.Enumeration big_jobcity=Jobcity.findByFather(Jobcity.getRootId(community));
    StringBuffer sbbig_jobcity=new StringBuffer();
    StringBuffer sbsmall_jobcity=new StringBuffer();
    while(big_jobcity.hasMoreElements())
    {
      int occ=((Integer)big_jobcity.nextElement()).intValue();
      Jobcity occ_obj=Jobcity.find(occ);
      out.println("case '"+occ_obj.getCode()+"' : ");
      String temp=occ_obj.getSubject();
      java.util.Enumeration small_jobcity=Jobcity.findByFather(occ);
      sbbig_jobcity.append("<OPTION VALUE="+occ_obj.getCode()+">"+temp+"</OPTION>");
      sbsmall_jobcity.append("select2.options.add(new Option(\""+temp+"\",\""+occ_obj.getCode()+"\"));");
      out.println("select2.options.add(new Option(\""+temp+"\",\""+occ_obj.getCode()+"\"));");
      for(int smallIndex=0;small_jobcity.hasMoreElements();smallIndex++)
      {
        occ=((Integer)small_jobcity.nextElement()).intValue();
        occ_obj=Jobcity.find(occ);
        temp=occ_obj.getSubject();
        out.println("select2.options.add(new Option(\"-- "+temp+"\",\""+occ_obj.getCode()+"\"));");
        sbsmall_jobcity.append("select2.options.add(new Option(\"-- "+temp+"\",\""+occ_obj.getCode()+"\"));");
      }
      out.println("break;");
    }
    out.println("default : "+sbsmall_jobcity.toString());
    %>
  }
}

function CheckForm()
{
  var frm = document.form1;

  //职位名称
  if(!submitText(frm.subject, '<%=r.getString(teasession._nLanguage,"1167445851734")%>')) return false;
  //所属机构
  if(!submitText(frm.company, '<%=r.getString(teasession._nLanguage,"1167445935359")%>')) return false;
  //职位性质


  if(!submitText(frm.jobtype, '<%=r.getString(teasession._nLanguage,"1167445992187")%>')) return false;

  if(frm.sltOccId.length<=0)
  {
    alert('<%=r.getString(teasession._nLanguage,"1167446047937")%>');//请选择职业类别！
    frm.sltOccId.focus();
    return false;
  } else
  {
    var h = "/";
    for(var x=0;x<frm.sltOccId.length;x++)
    {
      h+=frm.sltOccId.options[x].value+"/";
    }
    frm.occid.value=h;
  }

  if(frm.txtHeadCount.value=='')
  {
    alert("请输入招聘人数!");
    return false;
  }
//招聘人数

  //if(!submitInteger(frm.txtHeadCount, '<%=r.getString(teasession._nLanguage,"1167446243375")%>')) return false;

  /*
  if(!ChkTxt(frm.sltExpiryDays, '距到期日')) return false;
  if(!ChkPositive(frm.sltExpiryDays, '距到期日')) return false;
  var num1=Trim(frm.sltExpiryDays.value);
  if((num1<1)||(num1>365)) {alert('距到期日为1至365的整数！');frm.sltExpiryDays.focus();return false;}
*/
  if(frm.sltLocId.length<=0)
  {
    alert('<%=r.getString(teasession._nLanguage,"1167446338531")%>');//请选择工作地区！
    frm.sltLocId.focus();
    return false;
  }else
  {
    var h="/";
    for(var x=0;x<frm.sltLocId.length;x++)
    {
      h+=frm.sltLocId.options[x].value+"/";
    }
    frm.locid.value=h;
  }

//职位描述及要求
  if(!submitText(frm.text, '<%=r.getString(teasession._nLanguage,"1167446554265")%>')) return false;


  return true;
}


function fload()
{
  alteroption(form1.sltOccId_BigClass,form1.sltOccId_list);//职业类别
  alteroption_jobcity(form1.sltProvinceId,form1.sltAllLocId);//工作地区
}
</SCRIPT>
</HEAD>
<BODY onload="fload();">
<h1><%=r.getString(teasession._nLanguage, "CBNewJob")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<%-- <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div> --%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

<FORM NAME="form1" METHOD="post" action="/servlet/EditJob" onSubmit="return CheckForm();">
<input  type="hidden" value="<%=teasession._nNode%>" name="Node"/>
<input type="hidden" name="locid" value="/"/>
<input type="hidden" name="occid" value="/"/>
    <%
    String parameter=teasession.getParameter("nexturl");
    boolean parambool=(parameter!=null&&!parameter.equals("null"));
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String param="";
    if(request.getParameter("NewNode")!=null)
    {
      out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
      param="&NewNode=ON";
    }
    %>
    <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
    <INPUT TYPE="hidden" NAME="hdnTodo" VALUE="save">
    <TR>
      <TD><%=r.getString(teasession._nLanguage,"1167445759265")%><!--选择职位模板--></TD>
      <TD><SPAN>
        <SELECT  class="edit_input" onChange="window.open('EditJob.jsp?copynode='+value+'&<%=request.getQueryString()%>','_self')" STYLE="WIDTH: 222px">
          <OPTION VALUE="">-------------------------</OPTION>
          <%
          java.util.Enumeration enumerationtype=Node.findByType(50,teasession._strCommunity);
          while(enumerationtype.hasMoreElements())
          {
            int nodetype=((Integer)enumerationtype.nextElement()).intValue();
            if(nodetype!=teasession._nNode)
            {
              out.println("<option value="+nodetype);
              if(nodetype==copy)
              {
                out.print(" selected ");
              }
              out.print(">"+Node.find(nodetype).getSubject(teasession._nLanguage));
            }
          }
          %>
        </SELECT>
        <%=r.getString(teasession._nLanguage,"1167445800671")%><!--使用职位模板，不必重复输入相同信息。--></SPAN></TD>
    </TR>
    <TR>
      <TD colspan="2"><hr size="1"></TD>
    </TR>
    <TR>
      <TD>* <%=r.getString(teasession._nLanguage,"1167445851734")%><!--职位名称--></TD>
      <TD><INPUT  class="edit_input" NAME="subject" TYPE="text" VALUE="<%=subject%>" SIZE="30" MAXLENGTH="60"></TD>
    </TR>
    
    <TR>
      <TD>* <%=r.getString(teasession._nLanguage,"1167445871781")%><!--职位编号--></TD><%--job.getTxtRefCode() --%>
      <TD> <INPUT class="edit_input" TYPE="text" NAME="txtRefCode" MAXLENGTH="30" VALUE="<%=job.getRefCode()!=null?job.getRefCode():""%>">
        <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=r.getString(teasession._nLanguage,"1167445897640")%><!--广告编号-->&nbsp;
        <INPUT class="edit_input" TYPE="text" NAME="adcode" MAXLENGTH="30" VALUE="<%=job.getAdcode()%>"> --%></TD>
    </TR>
    <TR>
      <TD HEIGHT="11">* <%=r.getString(teasession._nLanguage,"1167445935359")%><!--所属机构--></TD>
      <TD HEIGHT="11"><%-- <%=sm.toHtmlCompany(teasession._nLanguage,job.getSltOrgId())%>--%>

        <select  class="edit_input" name="company" style="WIDTH: 292px">
          <option value="">---------</option>
          <%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,teasession._strCommunity);
              int nodeCode;
              while(enumeration.hasMoreElements()){
                nodeCode =((Integer)enumeration.nextElement()).intValue();
              out.print("<option value="+nodeCode);
              out.print(getSelect(job.getOrgId()==nodeCode));
              out.print(">"+tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage));
              out.print("</option>");
              }
                %>
        <%--   <option value="<%=nodeCode%>" <%=getSelect(job.getSltOrgId()==nodeCode)%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></option>
          <%}
          enumeration=tea.entity.node.Node.findByType(18,node.getCommunity());
              while(enumeration.hasMoreElements()){
                nodeCode =((Integer)enumeration.nextElement()).intValue();%>
          <option value="<%=nodeCode%>"  <%=getSelect(job.getSltOrgId()==nodeCode)%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></option>
          <%}%>
          --%>
        </select>

      </TD>
    </TR>




    <TR>
      <TD HEIGHT="11" NOWRAP>* <%=r.getString(teasession._nLanguage,"1167445992187")%><!--职位性质--></TD>
      <TD HEIGHT="11"><SELECT  class="edit_input"  NAME="jobtype">
          <OPTION VALUE = "">---------</OPTION>
          <OPTION VALUE="1" <%=getSelect(job.getJobType().equals("1"))%>><%=r.getString(teasession._nLanguage,"1167447115546")%><!--全职--></OPTION>
          <OPTION VALUE="2" <%=getSelect(job.getJobType().equals("2"))%>><%=r.getString(teasession._nLanguage,"1167447133937")%><!--兼职--></OPTION>
          <OPTION VALUE="3" <%=getSelect(job.getJobType().equals("3"))%>><%=r.getString(teasession._nLanguage,"1167447161953")%><!--临时--></OPTION>
          <OPTION VALUE="4" <%=getSelect(job.getJobType().equals("4"))%>><%=r.getString(teasession._nLanguage,"1167447180562")%><!--实习--></OPTION>
        </SELECT> </TD>
    </TR>
    <TR>
      <TD valign="top">* <%=r.getString(teasession._nLanguage,"1167446047937")%><!--职业类别--></TD>
      <TD><TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
          <TR>
            <TD><SELECT  NAME="sltOccId_BigClass"  class="edit_input" "width:200px" onchange="alteroption(this,form1.sltOccId_list);" >
                <OPTION VALUE="-1">-----------</OPTION>
                <%=sbBig.toString()%>
              </SELECT></TD>
            <TD COLSPAN="2" >&nbsp;<%=r.getString(teasession._nLanguage,"1167446055140")%><!--按住Ctrl键点击可多选，最多可选三项--></TD>
          </TR>
          <TR>
            <TD><SELECT class="edit_input" NAME="sltOccId_list"  SIZE="5" MULTIPLE STYLE="width:200px">
              </SELECT>
            </TD>
            <TD WIDTH="95" ALIGN="CENTER">
            <!--添加-->
              <INPUT class="edit_button" TYPE="BUTTON" VALUE="<%=r.getString(teasession._nLanguage,"1167446148625")%>" NAME="btnAdd" onClick="fadd(form1.sltOccId_list, form1.sltOccId,3);">
              <BR>
              <BR>
              <INPUT class="edit_button" TYPE="BUTTON" VALUE="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="fdel(form1.sltOccId);return false;"> </TD>
            <TD><SELECT  class="edit_input" NAME="sltOccId" SIZE="5" MULTIPLE STYLE="width:200px">
                <%
                String arr[]=job.getOccId().split("/");
                for(int i = 1;i<arr.length;i++)
                {
                  String code=arr[i];
                  Occupation occ_obj=Occupation.find(teasession._strCommunity,code);
                  if(occ_obj.isExists())
                  out.println("<OPTION VALUE="+code+" >"+occ_obj.getSubject());
                }
                %>
              </SELECT> </TD>
          </TR>
        </TABLE></TD>
    </TR>
    <TR>
      <TD>* <%=r.getString(teasession._nLanguage,"1167446216531")%><!--职位有效期--></TD>
      <TD><%=new TimeSelection("Validity", job.getValidityDate())%>
        <INPUT NAME="sltExpiryDays" type="hidden" VALUE="1" SIZE="3" MAXLENGTH="3"> </TD>
    </TR>
    <TR>
      <TD>*<%=r.getString(teasession._nLanguage,"1167446243375")%><!--招聘人数--></TD>
      <TD><INPUT class="edit_input" NAME="txtHeadCount" TYPE="text" VALUE="<%if(job.getHeadCount()>0)out.println(job.getHeadCount());%>" SIZE="4" MAXLENGTH="4"></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage,"1167446271906")%><!--月薪范围--></TD>
      <TD><SELECT NAME="sltSalaryId">
      <%
      for(int index=0;index<Job.SALARY_TYPE.length;index++)
      {
        out.print("<option value="+index);
        if(job.getSalaryId().equals(String.valueOf(index)))
        {
          out.print(" SELECTED ");
        }
        out.print(" >");
        if(index>1)
        out.print(Job.SALARY_TYPE[index]);
        else
        out.print(r.getString(teasession._nLanguage,"Salary."+Job.SALARY_TYPE[index]));
      }
      %></TD>
    </TR>
    <TR>
      <TD>* <%=r.getString(teasession._nLanguage,"1167446338531")%><!--工作地区--></TD>
      <TD><TABLE id="tablecenter" BORDER="0" CELLSPACING="0" CELLPADDING="0">
          <TR>
            <TD>
            <SELECT  NAME="sltProvinceId"  class="edit_input" "width:200px" onchange="alteroption_jobcity(this,form1.sltAllLocId);" >
              <OPTION VALUE="-1">-----------</OPTION>
              <%=sbbig_jobcity.toString()%>
             </select>
            </TD>
            <TD COLSPAN="2" ALIGN="CENTER" >&nbsp;<%=r.getString(teasession._nLanguage,"1167446409328")%><!--如选择了省/区，则不能再选择该省/区下属城市--> </TD>
          </TR>
          <TR>
            <TD><SELECT class="edit_input"  NAME="sltAllLocId" SIZE="5" MULTIPLE STYLE="width:140px"  >

              </SELECT>
            </TD>
            <TD WIDTH="80" ALIGN="CENTER">
            <!--添加-->
              <INPUT NAME="btnAdd"  class="edit_button" TYPE="BUTTON" VALUE="<%=r.getString(teasession._nLanguage,"1167446148625")%>" onClick="fadd(form1.sltAllLocId, form1.sltLocId,5);return false;">
              <BR>
              <BR><!--删除-->
              <INPUT NAME="btnDelete" class="edit_button" TYPE="BUTTON" VALUE="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="fdel(form1.sltLocId);return false;"> </TD>
            <TD><SELECT  class="edit_input" NAME="sltLocId" SIZE="5" MULTIPLE STYLE="width:140px">
                <!--Action:1-->
                <%

                String arr2[]=job.getLocId().split("/");
                 for(int j= 1;j<arr2.length;j++)
                {
                  String code=arr2[j];
                  Jobcity occ_obj=Jobcity.find(teasession._strCommunity,code);
                  if(occ_obj.isExists())
                  out.println("<OPTION VALUE="+code+" >"+occ_obj.getSubject());
                }
                %>
              </SELECT>
              </TD>
          </TR>
        </TABLE></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage,"1167446489828")%><!--最低工作经验--></TD>
      <TD><SELECT class="edit_input"  NAME="sltReqWyearId">
          <OPTION VALUE="0" <%=getSelect(job.getReqWyearId()==0)%>><%=r.getString(teasession._nLanguage,"1167448558562")%></OPTION><!-- 一年以下 -->
          <OPTION VALUE="1"<%=getSelect(job.getReqWyearId()==1)%>>1<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION><!--  年 -->
          <OPTION VALUE="2"<%=getSelect(job.getReqWyearId()==2)%>>2<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="3"<%=getSelect(job.getReqWyearId()==3)%>>3<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="4"<%=getSelect(job.getReqWyearId()==4)%>>4<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="5"<%=getSelect(job.getReqWyearId()==5)%>>5<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="6"<%=getSelect(job.getReqWyearId()==6)%>>6<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="7"<%=getSelect(job.getReqWyearId()==7)%>>7<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="8"<%=getSelect(job.getReqWyearId()==8)%>>8<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="9"<%=getSelect(job.getReqWyearId()==9)%>>9<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
          <OPTION VALUE="10"<%=getSelect(job.getReqWyearId()==10)%>>10<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
        </SELECT></TD>
    </TR>
    <TR>
      <TD><%=r.getString(teasession._nLanguage,"1167446517671")%><!--学历--></TD>
      <TD><%=new tea.htmlx.DegreeSelection("sltReqDegId",job.getReqDegId())%>
        <%--
        <select class="edit_input"  name="sltReqDegId">
          <option value = ""></option>
          <option value="博士" <%=getSelect(job.getSltReqDegId().equals("博士"))%>>博士</option>
          <option value="MBA" <%=getSelect(job.getSltReqDegId().equals("MBA"))%>>MBA</option>
          <option value="硕士" <%=getSelect(job.getSltReqDegId().equals("硕士"))%>>硕士</option>
          <option value="本科" <%=getSelect(job.getSltReqDegId().equals("本科"))%>>本科</option>
          <option value="大专" <%=getSelect(job.getSltReqDegId().equals("大专"))%>>大专</option>
          <option value="中专" <%=getSelect(job.getSltReqDegId().equals("中专"))%>>中专</option>
          <option value="中技" <%=getSelect(job.getSltReqDegId().equals("中技"))%>>中技</option>
          <option value="高中" <%=getSelect(job.getSltReqDegId().equals("高中"))%>>高中</option>
          <option value="初中" <%=getSelect(job.getSltReqDegId().equals("初中"))%>>初中</option>
        </select>
        以上 --%>
      </TD>
    </TR>
    <TR>
      <TD VALIGN="top" NOWRAP>* <%=r.getString(teasession._nLanguage,"1167446554265")%><!--职位描述及要求--></TD>
      <TD><TEXTAREA  class="edit_input" NAME="text" COLS="70" ROWS="5"><%=HtmlElement.htmlToText(text)%></TEXTAREA>
        <BR>
        <%=r.getString(teasession._nLanguage,"1167446614609")%><!--最多可以输入3000个字。(<a id="linkObjectCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['txtJobDuty'].value.length+&quot;个字！&quot;);">计算字数</a>)-->
        <br>
      </TD>
    </TR>
    <!--<input NAME="txtJobDuty" type="hidden" value="aa">
          <SCRIPT language="javascript">
            document.form1.chkGetCvTypeEmail.checked = true;
            document.all.trJobCcType.style.display = "";
          </SCRIPT>
          -->
    <TR>
      <TD COLSPAN="2" ALIGN="CENTER">

<%--        <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">--%>
        <input  class="edit_button" type="submit" value="<%=r.getString(teasession._nLanguage,"1167446697781")%>"/><!--发布-->
        <input class="edit_button"  type="submit" value="<%=r.getString(teasession._nLanguage,"1167446722015")%>" name="save"/><!--保存-->
        <input  class="edit_button" type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" name="cancel" onclick="window.location.href='/jsp/type/job/JobManage.jsp';"/> </TD>
    </TR>
  </FORM>
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</HTML>

