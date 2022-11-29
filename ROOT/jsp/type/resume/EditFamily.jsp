<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-mm-dd");

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

int family=0;
if(teasession.getParameter("family")!=null)
family=Integer.parseInt(teasession.getParameter("family"));

Node node=Node.find(teasession._nNode);

String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
Family obj=Family.find(family);
if(!node.isCreator(teasession._rv)||(family!=0&&obj.getNode()!=teasession._nNode))
{
  response.sendError(403);
  return;
}

String nexturl=request.getParameter("nexturl");


if(request.getMethod().equals("POST"))
{
  if(request.getParameter("delete")!=null)
  {
    obj.delete();
  }else
  {
    String famsa=request.getParameter("famsa");
    java.util.Date fgbdt=null;//java.text.DateFormat.getDateInstance().parse(request.getParameter("fgbdtYear")+"-"+request.getParameter("fgbdtMonth")+"-"+request.getParameter("fgbdtDay"));
    if(teasession.getParameter("fgbdt")!=null && teasession.getParameter("fgbdt").length()>0)
        fgbdt = Family.sdf.parse(teasession.getParameter("fgbdt"));
    String fgbld=request.getParameter("fgbld");
    String fanat=request.getParameter("fanat");
    boolean fasex=Boolean.parseBoolean(request.getParameter("fasex"));
    String favor=request.getParameter("favor");
    String fanam=request.getParameter("fanam");
    String fgbot=request.getParameter("fgbot");
    String zzhkszd=request.getParameter("zzhkszd");
    String zzracky=request.getParameter("zzracky");
    String zzgzdw=request.getParameter("zzgzdw");
    String zzzwmc=request.getParameter("zzzwmc");
    String zzslart=request.getParameter("zzslart");
    String statu=request.getParameter("statu");
    String pstat=request.getParameter("pstat");
    String telnr=request.getParameter("telnr");
    if(family==0)
    {
      Family.create(teasession._nNode,teasession._nLanguage,    famsa,    fgbdt,    fgbld,    fanat,    fasex,    favor,    fanam,fgbot,zzhkszd,zzracky,zzgzdw,zzzwmc,zzslart,statu,pstat,telnr);
    }else
    {
      obj.set(famsa,    fgbdt,    fgbld,    fanat,    fasex,    favor,    fanam,fgbot,zzhkszd,zzracky,zzgzdw,zzzwmc,zzslart,statu,pstat,telnr);
    }
  }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&community="+community+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

Date fgbdt=obj.getFgbdt();
if(fgbdt==null)
{
  Calendar c=Calendar.getInstance();
  c.set(c.YEAR,c.get(c.YEAR)-30);
  fgbdt=c.getTime();
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>

<script type="text/javascript">
function submitSelect(obj,text)
{
  if(obj.selectedIndex==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
  </HEAD>
  <body >

<h1><%=r.getString(teasession._nLanguage,"1167538816203")%><!--家庭成员--></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="?"  onsubmit="">
<input type="hidden" name="family" value="<%=family%>" />
<input type="hidden" name="node" value="<%=teasession._nNode%>" />
<input type="hidden" name="community" value="<%=community%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />


<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"1167538880937")%><!--类型--></td>
    <td><%=r.getString(teasession._nLanguage,"1167442318656")%><!--姓名--></td>
    <td><%=r.getString(teasession._nLanguage,"1167538919937")%><!--职务--></td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration enumeration=Family.find(teasession._nNode,teasession._nLanguage);
  while(enumeration.hasMoreElements())
  {
    int id=((Integer)enumeration.nextElement()).intValue();
    Family familyobj=Family.find(id);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td>
      <%
      for(int index=0;index<Family.FAMSA_TYPE.length;index++)
      {
        if(Family.FAMSA_TYPE[index][0].equals(familyobj.getFamsa()))
        {
          out.print(Family.FAMSA_TYPE[index][1]);
          break;
        }
      }
      %>
          </td>
          <td><%=familyobj.getFanam()+" "+familyobj.getFavor()%></td>
          <td><%=familyobj.getZzzwmc()%></td>
        <td><input class="edit_button" type=button  value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('?family=<%=id%>&node=<%=teasession._nNode%>&community=<%=community%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
            <input class="edit_button" type=submit name=delete value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){document.form1.family.value=<%=id%>;return true;}else return false;"/>
        </td>
	</tr>

    <%} %>
</table>

<br>
<h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--添加/编辑--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width="140" align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167539003406")%><!--家庭记录的类型--></strong></td>
    <td>
      <select name="famsa" >
      <%
      for(int index=0;index<Family.FAMSA_TYPE.length;index++)
      {
        out.print("<option value="+Family.FAMSA_TYPE[index][0]);
        if(Family.FAMSA_TYPE[index][0].equals(obj.getFamsa()))
        out.print(" SELECTED");
        out.print(" >"+Family.FAMSA_TYPE[index][1]);
      }
      %>
      </select></td>
      </tr>

      <tr>
        <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167539027875")%><!--出生日期--></strong></td>


        <td><input type="text" name="fgbdt" value="<%if(fgbdt!=null){out.print(format.format(fgbdt));}%>" readonly="readonly"/>
          <A href="###"><img onclick="showCalendar('form1.fgbdt');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a><%//new tea.htmlx.TimeSelection("fgbdt", fgbdt)%></td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167469238859")%><!--出生国家--></strong></td>
        <td><%=new tea.htmlx.CountrySelection("fgbld",teasession._nLanguage,obj.getFgbld())%></td>
      </tr>

      <tr>
        <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167469217921")%><!--国籍--></strong></td>
        <td><%=new tea.htmlx.CountrySelection("fanat",teasession._nLanguage,obj.getFanat())%>
        </td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167455197453")%><!--性别--></strong></td>
        <td><input name="fasex" type="radio" value="true" checked><%=r.getString(teasession._nLanguage,"1167457951671")%><!--男-->
          <input name="fasex" type="radio" value="false" <%if(!obj.isFasex())out.print(" checked ");%>><%=r.getString(teasession._nLanguage,"1167457972406")%><!--女-->
        </td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539198562")%><%=r.getString(teasession._nLanguage,"1167539174828")%><!--名--></strong></td>
        <td><input name="favor" type="text" maxlength="60" size="40"  value="<%if(obj.getFavor()!=null)out.print(obj.getFavor());%>"/></td>
      </tr>
     <%--  <tr>
        <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167539198562")%><!--姓--></strong></td>
        <td><input name="fanam" type="text" maxlength="60" size="40"  value="<%if(obj.getFanam()!=null)out.print(obj.getFanam());%>"/></td>
      </tr>--%>
      <tr>
        <td valign="top" align="right"><strong>*</strong><strong><B><%=r.getString(teasession._nLanguage,"1167469260593")%><!--出生地--></B></td>
          <td><input name="fgbot" type="text" maxlength="60" size="40"  value="<%if(obj.getFgbot()!=null)out.print(obj.getFgbot());%>"/></td>
      </tr>

      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167469359000")%><!--户口所在地--></strong></td>
        <td><input name="zzhkszd" type="text" value="<%if(obj.getZzhkszd()!=null)out.print(obj.getZzhkszd());%>"></td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167539261734")%><!--民族血统--></strong></td>
        <td>
          <select name="zzracky">
          <%
          for(int index=0;index<Common.ZZRACKY.length;index++)
          {
            out.print("<option value="+Common.ZZRACKY[index][0]);
            if(Common.ZZRACKY[index][0].equals(obj.getZzracky()))
            out.print(" SELECTED");
            out.print(" >"+Common.ZZRACKY[index][1]);
          }
          %></select>
          </td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539292375")%><!--家庭成员工作单位名称--></strong></td>
        <td><input name="zzgzdw" type="text" value="<%if(obj.getZzgzdw()!=null)out.print(obj.getZzgzdw());%>"></td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539315546")%><!--职务名称--></strong></td>
        <td><input name="zzzwmc" type="text" value="<%if(obj.getZzzwmc()!=null)out.print(obj.getZzzwmc());%>"></td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539337750")%><!--家庭成员文化程度--></strong></td>
        <td><%=new tea.htmlx.DegreeSelection("zzslart",obj.getZzslart())%>
        </td>
      </tr>
      <tr>
        <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539361265")%><!--工作状态--></strong></td>
        <td><select name="statu" >
        <%
        for(int index=0;index<Family.STATU_TYPE.length;index++)
        {
          out.print("<option value="+Family.STATU_TYPE[index][0]);
          if(Family.STATU_TYPE[index][0].equals(obj.getStatu()))
          out.print(" SELECTED");
          out.print(" >"+Family.STATU_TYPE[index][1]);
        }
        %>
        </select>
        </td>
        </tr>
        <tr>
          <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167461082921")%><!--政治面貌--></strong></td>
          <td>
            <select name="pstat" >
            <%
            for(int index=0;index<Common.PCODE.length;index++)
            {
              out.print("<option value="+Common.PCODE[index][0]);
              if(Common.PCODE[index][0].equals(obj.getPstat()))
              out.print(" SELECTED");
              out.print(" >"+Common.PCODE[index][1]);
            }
            %>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right" valign="baseline"><strong>*</strong><strong><%=r.getString(teasession._nLanguage,"1167539652328")%><!--电话号码--></strong></td>
          <td><input name="telnr" type="text" value="<%if(obj.getTelnr()!=null)out.print(obj.getTelnr());%>"></td>
        </tr>


        <tr>
          <td colspan="2" align="center">
            <!--保存&amp;新增-->
            <input  class="edit_button" type="submit"  value="<%=r.getString(teasession._nLanguage,"1167532473640")%>" onClick="return submitText(document.form1.favor,'<%=r.getString(teasession._nLanguage,"1167539695734")%>')&&submitText(document.form1.fanam,'<%=r.getString(teasession._nLanguage,"1167539723968")%>')&&submitText(document.form1.fgbot,'<%=r.getString(teasession._nLanguage,"1167472634203")%>')&&submitText(document.form1.zzhkszd,'<%=r.getString(teasession._nLanguage,"1167472674031")%>')&&submitText(document.form1.zzracky,'<%=r.getString(teasession._nLanguage,"1167539797843")%>')&&submitText(document.form1.zzgzdw,'<%=r.getString(teasession._nLanguage,"1167539831906")%>')&&submitText(document.form1.zzzwmc,'<%=r.getString(teasession._nLanguage,"1167539855312")%>')&&submitText(document.form1.zzslart,'<%=r.getString(teasession._nLanguage,"1167539911968")%>')&&submitText(document.form1.telnr,'<%=r.getString(teasession._nLanguage,"1167539937625")%>');"  />
          </td>
        </tr>
</table>



  <br>
<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditLang.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<!-- input type="button" class="edit_button" name="btnSaveAndNext2" value="下一步" onClick="window.open('/jsp/type/resume/EditEmployment.jsp?node=<%=teasession._nNode%>','_self');"/ -->
<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')"   />



  </form>
  <br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>

