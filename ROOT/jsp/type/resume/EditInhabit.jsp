<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);

int id=0;
if(request.getParameter("inhabit")!=null)
{
  id=Integer.parseInt(request.getParameter("inhabit"));
}

String member=teasession._rv._strV;
if(!node.isCreator(teasession._rv)||(id!=0&&!member.equals(Inhabit.find(id).getMember())))
{
  response.sendError(403);
  return;
}

String nexturl=request.getParameter("nexturl");

if(request.getMethod().equals("POST"))
{
  Inhabit inhabit=Inhabit.find(id);
  if(request.getParameter("delete")!=null)
  {
    inhabit.delete();
  }else
  {
    inhabit.setAnssa(request.getParameter("anssa"));
    inhabit.setName2(request.getParameter("name2"));
    inhabit.setStras(request.getParameter("stras"));
    inhabit.setOrto1(request.getParameter("orto1"));
    inhabit.setPstlz(request.getParameter("pstlz"));
    inhabit.setLand1(request.getParameter("land1"));
    inhabit.setState(request.getParameter("state"));
    inhabit.setMember(member);
    inhabit.setBegda(inhabit.sdf.parse(request.getParameter("begdaYear")+"-"+request.getParameter("begdaMonth")+"-"+request.getParameter("begdaDay")));
    if(request.getParameter("enddaYear")!=null)
    inhabit.setEndda(inhabit.sdf.parse(request.getParameter("enddaYear")+"-"+request.getParameter("enddaMonth")+"-"+request.getParameter("enddaDay")));
    else
    inhabit.setEndda(null);
    inhabit.set();
  }
  response.sendRedirect(request.getRequestURI() +"?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}
java.util.Date begda=null;
java.util.Date endda=null;
String anssa=null,name2=null;
String stras,orto1,pstlz,land1,state;

if(id>0)
{
  Inhabit inhabit=Inhabit.find(id);
  begda=inhabit.getBegda();
  endda=inhabit.getEndda();
  anssa=inhabit.getAnssa();
  name2=inhabit.getName2();
  stras=inhabit.getStras();
  orto1=inhabit.getOrto1();
  pstlz=inhabit.getPstlz();
  land1=inhabit.getLand1();
  state=inhabit.getState();
  id=inhabit.getInhabit();
}else
{
  state=pstlz=orto1=stras=name2="";
  land1="CN";
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");


%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function fun()
{
  form06.enddaYear.disabled=form06.enddaMonth.disabled=form06.enddaDay.disabled=form06.enddacheck.checked;
}

</script>
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage,"1167531487375")%><!--地址列表--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Time")%><!--时间--></td>
    <td><%=r.getString(teasession._nLanguage,"1167531590750")%><!--地址记录类型--></td>
    <td><%=r.getString(teasession._nLanguage,"1167469569609")%><!--邮政编码--></td>
    <td>&nbsp;</td>
  </tr>
  <%
  StringBuffer sb=new StringBuffer("/");
java.util.Enumeration enumer=tea.entity.member.Inhabit.findByMember(teasession._rv._strV);
while(enumer.hasMoreElements())
{
int enumer_id=((Integer)  enumer.nextElement()).intValue();
Inhabit obj=Inhabit.find(enumer_id);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=obj.getBegdaToString()%> -- <%=obj.getEnddaToString()%></td>
  <td><%
  for(int index=0;index<Inhabit.ANSSA_TYPE.length;index++)
  {
    if(Inhabit.ANSSA_TYPE[index][0].equals(obj.getAnssa()))
    {
      sb.append(index+"/");
      out.print(Inhabit.ANSSA_TYPE[index][1]);
      break;
    }
  }
  %></td>
    <td><%=obj.getPstlz()%></td>
  <td>
  <form method="POST"  action="<%=request.getRequestURI()%>" >
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="inhabit" value="<%=enumer_id%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

    <input type="button" name="Submit" class="edit_button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onclick="location='<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&inhabit=<%=enumer_id%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>';">
    <input type="Submit" name="delete" class="edit_button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onclick="return(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));">
  </form>
  </td>
</tr>
<%
}
%>
</table>

<%
if(id!=0||Inhabit.ANSSA_TYPE.length>sb.toString().split("/").length-1)
{
%>
  <h2><%=r.getString(teasession._nLanguage,"1167471137156")%><!--新增/编辑--></h2>
<form name="form06" action="<%=request.getRequestURI()%>?node=<%=teasession._nNode%>" method="post"  onsubmit="return submitInteger(this.pstlz,'<%=r.getString(teasession._nLanguage,"1167531748640")%>')&&submitText(this.state,'<%=r.getString(teasession._nLanguage,"1167531770421")%>')">
<input type="hidden" name="inhabit" value="<%=id%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>* <%=r.getString(teasession._nLanguage,"1167471168140")%><!--开始时间--></td>
          <td><%=new tea.htmlx.TimeSelection("begda", begda)%></td>
        </tr>
        <tr>
          <td>* <%=r.getString(teasession._nLanguage,"1167471229125")%><!--结束时间--></td>
          <td><%=new tea.htmlx.TimeSelection("endda", endda)%>
            <input type="checkbox" name="enddacheck"  value="" <%if(endda==null)out.print(" checked ");%> onclick="fun();"/><%=r.getString(teasession._nLanguage,"1167471250265")%><!--至今-->
            <script type="text/javascript">
            fun();
            </script>
            </td>
        </tr>
        <tr>
          <td>* <%=r.getString(teasession._nLanguage,"1167531590750")%><!--地址记录类型--></td>
          <td>
            <select  name="anssa" >
            <%
            for(int index=0;index<Inhabit.ANSSA_TYPE.length;index++)
            {
              if(sb.toString().indexOf("/"+index+"/")==-1||Inhabit.ANSSA_TYPE[index][0].equals(anssa))
              {
                %>
                <option value="<%=Inhabit.ANSSA_TYPE[index][0]%>" <%if(Inhabit.ANSSA_TYPE[index][0].equals(anssa))out.print(" selected ");%>><%=Inhabit.ANSSA_TYPE[index][1]%></option>
                <%
                }
              }
              %>
              </select>

          </td>
        </tr>
        <tr>
          <td>&nbsp; <%=r.getString(teasession._nLanguage,"1167441134359")%><!--联系人--></td>
          <td><input name="name2" type="text" value="<%=name2%>" maxlength="40"></td>
        </tr>
        <tr>
          <td>&nbsp; <%=r.getString(teasession._nLanguage,"1167531886234")%><!--街道或门牌号--></td>
          <td><input name="stras" type="text" value="<%=stras%>" maxlength="60" size="50"></td>
        </tr>
        <tr>
          <td>&nbsp; <%=r.getString(teasession._nLanguage,"1167531909234")%><!--城市/地区--></td>
          <td><input name="orto1" type="text" value="<%=orto1%>" maxlength="40" size="30"></td>
        </tr>
        <tr>
          <td>* <%=r.getString(teasession._nLanguage,"1167469569609")%><!--邮政编码--></td>
          <td><input name="pstlz" type="text" value="<%=pstlz%>" maxlength="10"></td>
        </tr>
        <tr>
        <%
       // tea.htmlx.CountrySelection cc = new CountrySelection("land1",land1,teasession._nLanguage) ;
        %>
          <td>* <%=r.getString(teasession._nLanguage,"1167471683859")%><!--国家代码--></td>
          <td><%=new tea.htmlx.CountrySelection("land1",teasession._nLanguage,land1)%></td>
        </tr>
        <tr>
          <td nowrap>* <%=r.getString(teasession._nLanguage,"1167532428968")%><!--地区(州、省、县)--></td>
          <td>
            <select name="state">
            <option value="">---------------</option>
            <%
            for(int index=0;index<tea.resource.Common.PROVINCE.length;index++)
            {
              out.print("<option value="+tea.resource.Common.PROVINCE[index]);
              if(tea.resource.Common.PROVINCE[index].equals(state))
              {
                out.print(" selected ");
              }
              out.println(">"+r.getString(teasession._nLanguage,"Province."+tea.resource.Common.PROVINCE[index]));
            }
            %>
           </td></tr><tr><td colspan="2" align="center">
           <!--保存&新增-->
             <input type="submit" class="edit_button" name="Submit" value="<%=r.getString(teasession._nLanguage,"1167532473640")%>"></td></tr>
      </table>



</form>
<%}%>
<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditResumeOther.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext3" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditAward.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')"   />

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

