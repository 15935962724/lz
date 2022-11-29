<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.htmlx.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
//java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-mm-dd");
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

int award=0;
if(teasession.getParameter("award")!=null)
award=Integer.parseInt(teasession.getParameter("award"));

Node node=Node.find(teasession._nNode);
if(!node.isCreator(teasession._rv)||(award!=0&&Award.find(award).getNode()!=teasession._nNode))
{
  response.sendError(403);
  return;
}

String nexturl=request.getParameter("nexturl");


if(request.getMethod().equals("POST"))
{
  Date begda=null;//Award.sdf.parse(request.getParameter("begdaYear")+"-"+request.getParameter("begdaMonth")+"-"+request.getParameter("begdaDay"));
  if(request.getParameter("begda")!=null && request.getParameter("begda").length()>0)
    begda = Award.sdf.parse(request.getParameter("begda"));

  Date endda=null;//Award.sdf.parse(request.getParameter("enddaYear")+"-"+request.getParameter("enddaMonth")+"-"+request.getParameter("enddaDay"));
   if(request.getParameter("endda")!=null && request.getParameter("endda").length()>0)
    endda = Award.sdf.parse(request.getParameter("endda"));
  int zjljb=Integer.parseInt(request.getParameter("zjljb"));
  String zjcmc=request.getParameter("zjcmc");
  String zjcdw=request.getParameter("zjcdw");
  String zjcyy=request.getParameter("zjcyy");
  Date zjcsj=Award.sdf.parse(request.getParameter("zjcsjYear")+"-"+request.getParameter("zjcsjMonth")+"-"+request.getParameter("zjcsjDay"));
  String zjcbh=request.getParameter("zjcbh");
  String zqtbz1=request.getParameter("zqtbz1");
  String zqtbz2=request.getParameter("zqtbz2");
  String zqtbz3=request.getParameter("zqtbz3");
  String zqtbz4=request.getParameter("zqtbz4");
  if(award==0)
  {
    Award.create(teasession._nNode,teasession._nLanguage,begda,endda,zjljb,zjcmc,zjcdw,zjcyy,zjcsj,zjcbh,zqtbz1,zqtbz2,zqtbz3,zqtbz4);
  }else
  {
    Award obj=Award.find(award);
    if(request.getParameter("delete")!=null)
    {
      obj.delete();
    }else
    {
      obj.set(begda,endda,zjljb,zjcmc,zjcdw,zjcyy,zjcsj,zjcbh,zqtbz1,zqtbz2,zqtbz3,zqtbz4);
    }
  }
  response.sendRedirect("EditAward.jsp?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

Date begda=null,endda=null,zjcsj=null;
int zjljb=8;
String zjcmc,zjcdw,zjcyy,zjcbh,zqtbz1,zqtbz2,zqtbz3,zqtbz4;
int award_node=0;
System.out.println("111***"+begda);
if(award!=0)
{
  Award obj=Award.find(award);
  award_node=obj.getNode();

  begda=obj.getBegda();
  endda=obj.getEndda();
  zjljb=obj.getZjljb();
  zjcmc=obj.getZjcmc();
  zjcdw=obj.getZjcdw();
  zjcyy=obj.getZjcyy();
  zjcsj=obj.getZjcsj();
  zjcbh=obj.getZjcbh();
  zqtbz1=obj.getZqtbz1();
  zqtbz2=obj.getZqtbz2();
  zqtbz3=obj.getZqtbz3();
  zqtbz4=obj.getZqtbz4();

}else
{
  zjcmc=zjcdw=zjcyy=zjcbh=zqtbz1=zqtbz2=zqtbz3=zqtbz4="";
}


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
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
<body  onLoad="Form1.zjcmc.focus();">
<h1><%=r.getString(teasession._nLanguage,"1167533365656")%><!--奖惩记录--></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
  <form name="Form1" method="post" action="<%=request.getRequestURI()%>"  onsubmit="" id="Form1">
  <input type="hidden" name="node" value="<%=teasession._nNode%>" />
  <input type="hidden" name="award" value="<%=award%>" />
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr ID=tableonetr>
         <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
         <td><%=r.getString(teasession._nLanguage,"1167533470218")%><!--奖惩名称--></td>
         <td><%=r.getString(teasession._nLanguage,"1167533489218")%><!--奖励级别--></td>
         <td><%=r.getString(teasession._nLanguage,"1167533519515")%><!--审批时间--></td>
         <td></td>
         </tr>
<%
java.util.Enumeration enumeration=Award.findByNode(teasession._nNode,teasession._nLanguage);
while(enumeration.hasMoreElements())
{
  Award obj=Award.find(((Integer)enumeration.nextElement()).intValue());

%>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
   <td><%=obj.getBegdaToString()%>--<%=obj.getEnddaToString()%></td>
   <td><%=obj.getZjcmc()%></td>
   <td><%=Award.ZJLJB_TYPE[obj.getZjljb()-1]%></td>
   <td><%=obj.getZjcsjToString()%></td>
   <td><input class="edit_button" type=button name=Edit value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('EditAward.jsp?award=<%=obj.getAward()%>&node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
     <input  class="edit_button" type=submit name=delete value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){Form1.award.value=<%=obj.getAward()%>;return true;}else return false;"/>
</td>
</tr>

<%} %>
</table>


<br>
<h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--添加/编辑--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td valign="baseline" align="right" width="140">* <strong><%=r.getString(teasession._nLanguage,"1167471168140")%><!--开始日期--></strong></td>
    <td><%--<%=new TimeSelection("begda", begda)%>--%>
    <input name="begda" size="7"  value="<%if(begda!=null)out.print(begda);%>"><A href="###"><img onclick="showCalendar('Form1.begda');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
  </tr>
  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167471229125")%><!--结束日期--></strong></td>
    <td><%--<%=new TimeSelection("endda", endda)%>--%>
    <input name="endda" size="7"  value="<%if(endda!=null)out.print(endda);%>"><A href="###"><img onclick="showCalendar('Form1.endda');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>

  </tr>
  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167533489218")%><!--奖励级别--></strong></td>
    <td><select name="zjljb" id="zjljb">
    <%
    for(int index=Award.ZJLJB_TYPE.length;index>0;index--)
    {
      out.print("<option value="+(index));
      if(index==zjljb)
      out.print(" SELECTED ");
      out.print(" >"+Award.ZJLJB_TYPE[index-1]);
    }
    %>
    </select></td>
  </tr>

  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167533470218")%><!--奖惩名称--></strong></td>
    <td><font size="2"><input class="edit_input" name="zjcmc" id="zjcmc" type="text" size="20" maxlength="60"  value="<%=zjcmc%>"/>
</font>                </td>
  </tr>
  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"奖惩单位")%><!--奖惩给与单位--></strong></td>
    <td><input name="zjcdw" type="text" id="zjcdw" value="<%=zjcdw%>"></td>
  </tr>

  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167536155468")%><!--奖惩原因--></strong></td>
    <td><input class="edit_input" name="zjcyy" id="zjcyy" type="text" maxlength="60" size="40"  value="<%=zjcyy%>"/></td>
  </tr>
  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167536182625")%><!--奖惩审批时间--></strong></td>
    <td><%=new TimeSelection("zjcsj", zjcsj)%></td>
  </tr>
  <tr>
    <td align="right" valign="baseline">* <strong><%=r.getString(teasession._nLanguage,"1167536200968")%><!--奖惩审批文件编号--></strong></td>
    <td><input class="edit_input" name="zjcbh" id="zjcbh" type="text" maxlength="60" size="40"  value="<%=zjcbh%>"/></td>
  </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167536241906")%>1<!--备注1--></strong></td>
                <td><input class="edit_input" name="zqtbz1" id="zqtbz1" type="text" maxlength="60" size="40"  value="<%=zqtbz1%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167536241906")%>2<!--备注2--></strong></td>
                <td><input class="edit_input" name="zqtbz2" id="zqtbz2" type="text" maxlength="60" size="40"  value="<%=zqtbz2%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167536241906")%>3<!--备注3--></strong></td>
                <td><input class="edit_input" name="zqtbz3" id="zqtbz3" type="text" maxlength="60" size="40"  value="<%=zqtbz3%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167536241906")%>4<!--备注4--></strong></td>
                <td><input class="edit_input" name="zqtbz4" id="zqtbz4" type="text" maxlength="60" size="40"  value="<%=zqtbz4%>"/></td>
              </tr>
	<tr>
		<td align="center" colspan="2">

<!--保存&amp;新增-->
<input  class="edit_button" type="submit" name="btnSave" value="<%=r.getString(teasession._nLanguage,"1167532473640")%>" onClick="return (submitText(document.Form1.zjcmc,'<%=r.getString(teasession._nLanguage,"1167536432187")%>')&&submitText(document.Form1.zjcdw,'<%=r.getString(teasession._nLanguage,"1167536452343")%>')&&submitText(document.Form1.zjcyy,'<%=r.getString(teasession._nLanguage,"1167536475875")%>')&&submitText(document.Form1.zjcbh,'<%=r.getString(teasession._nLanguage,"1167536512265")%>')&&submitText(document.Form1.zqtbz1,'<%=r.getString(teasession._nLanguage,"1167536547484")%>')); "  id="btnSave" />

                </td>
        </tr>
</table>



  <br>
<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext1" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditInhabit.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditProfessional.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')"   />



  </form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>

