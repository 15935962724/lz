<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%><%@page import="tea.entity.site.*"%>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession =new TeaSession(request);
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}


Ocean oce = Ocean.find(ids);
if("exp".equals(request.getParameter("act")))
{
  response.setHeader("Content-Disposition", "attachment; filename=exp.doc");
}

String show = "";
if(teasession.getParameter("show")!=null && teasession.getParameter("show").length()>0)
{
  show = teasession.getParameter("show");
}




String oceancard =teasession.getParameter("oceancard");
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<!--base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/"/>
<style type="text/css">
<%//Community.find(teasession._strCommunity).getCss()%>
</style-->
<script type="">
function load(aa)
{

  if(aa==1)
  {
    document.getElementById('huzhao').style.display="";
  }else
  {
    document.getElementById('huzhao').style.display="none";
  }

}


function find_x(aa)
{
  if(aa==1)
  {
    document.getElementById('huzhao').style.display="";
  }else
  {
    document.getElementById('huzhao').style.display="none";
  }
}

function find_sub()
{
   var x=document.getElementsByName("drawtype"); ;

  for(var i=0;i<x.length;i++)
  {
    if(x[i].value==0)
    {
      if(x[i].checked)
      {
          return true;   //
      }
    }
    if(x[i].value==1)
    {
      if(x[i].checked)
      {
        if(form1.drawcards.value=="" ||form1.drawcards.value==null  )
        {
          alert("????????????????????????????????????????????????????????????????????????");
          return false;
        }
         if(form1.drawnames.value=="" ||form1.drawnames.value==null  )
        {
          alert("????????????????????????????????????????????????????????????????????????");
          return false;
        }
        else
        {
            return true;
        }
      }
    }
  }



}
</script>
<title>
?????????????????????
</title>
</head>
<body  bgcolor="#ffffff">
<h1 style="display:block;width:100%;border-bottom:3px solid #ccc;">
?????????????????????
</h1>
<!--input type="button" value="exp" onclick="window.open('?act=exp','_self')"//servlet/EditOcean-->
<form name="form1" action="/servlet/EditOcean"  method="POST">
<input type="hidden" name="ids" value="<%=ids%>" />
<input type="hidden" name="act" value="Oceanfafang" />
<table id="tablecentermm">
  <tr>
    <td nowrap colspan="5" class="tdte">
????????????
<%=oce.getOceanorder()%> </td>
  </tr>
  <tr>
    <td width="110" nowrap class="td01">???????????????</td>
    <td colspan="3"   nowrap><%=Ocean.PASSPORT[oce.getPassport()]%> </td>
    <td width="80" nowrap rowspan="3" class="tdte2"><img src="<%if(oce.getPicpath()!=null && oce.getPicpath().length()>0){out.print(oce.getPicpath());}else{out.print("/\\tea/\\image/\\oceanRoll/\\phonomember.jpg");}%>" width="100"></td>
  </tr>
  <tr>
    <td class="td01">???????????????</td>
    <td class="td02"><label>
      <%if(oce.getName()!=null){out.print(oce.getName());}%>
    </label></td>
    <td nowrap class="td03">???????????????</td>
    <td><%out.print(oce.isSex()?"???":"???");%></td>
  </tr>
  <tr>
    <td nowrap class="td01">???????????????</td>
    <td nowrap colspan="3" ><%if(oce.getApplycard()==0){out.print("?????????");}else{out.print("?????????");};%></td>
  </tr>
  <tr>
    <td nowrap  class="td01">???????????????</td>
    <td class="td02"><%=Ocean.CARDTYPE[oce.getCardtype()]%></td>
    <td class="td03">???????????????</td>
    <td nowrap colspan="2" ><%if(oce.getCard()!=null)out.print(oce.getCard());%></td>
  </tr>
  <tr>
    <td nowrap class="td01">?????????????????????</td>
    <td colspan="4"><%if(oce.getMobile()!=null)out.print(oce.getMobile());%></td>
  </tr>
  <tr>
    <td class="td01">???????????????</td>
    <td colspan="4"><%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%></td>
  </tr>
  <tr>
    <td nowrap class="td01">???????????????</td>
    <td nowrap><%=Ocean.EDUCATION[oce.getEducation()]%></td>

    <td class="td01">???????????????</td>
    <td nowrap colspan="2"> <%=Ocean.OCCUPA_TION[oce.getOccupation()]%></td>
  </tr>
   <tr>
    <td class="td01">???????????????</td>
    <td colspan="4"><label><%=Ocean.URBAN_TYPE[oce.getUrban()]%></label></td>
  </tr>
  <tr>
    <td class="td01">?????????????????????</td>
    <td colspan="4"><label>
      <%if(oce.getAddress()!=null)out.print(oce.getAddress());%>
    </label></td>
  </tr>
   <tr>
    <td class="td01">???????????????</td>
    <td class="td02"><%if(oce.getZip()!=null)out.print(oce.getZip());%></td>
    <td class="td03">???????????????</td>
    <td colspan="2"><label>
      <%if(oce.getEmail()!=null)out.print(oce.getEmail());%>
    </label></td>
  </tr>
  <tr>
  <!--
    <td nowrap class="td01">?????????????????????</td>
    <td class="td02"><label>
      <%if(oce.getBabyname()!=null)out.print(oce.getBabyname());%>
    </label></td>
    -->
    <td class="td01">???????????????</td>
    <td colspan="2"><%if(oce.getBabybirthtoString()!=null)out.print(oce.getBabybirthtoString());%></td>
  </tr>
  <!--
  <tr>
    <td class="td01">?????????????????????</td>
    <td class="td02"><label>
      <%if(oce.getBabyage()!=null)out.print(oce.getBabyage());%>
    </label></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  -->
  <tr>
    <td class="td01">?????????????????????</td>
    <td colspan="4"><label>  <%=Ocean.INCOME[oce.getIncome()]%></label></label></td>
  </tr>
  <tr>
    <td class="td01">?????????????????????</td>
    <td colspan="4"><label>  <%=Ocean.LEARN_WAY[oce.getLearnway()]%></label></td>
  </tr>
  <tr>
    <td class="td01">??????????????????????????????</td>
    <td colspan="4"><label> <%
    for(int i = 1;i<oce.getBobo_interest().split("/").length;i++)
    {
      out.print(Ocean.BOBO_INTEREST[Integer.parseInt(oce.getBobo_interest().split("/")[i])]+"&nbsp;");
    }
    %></label></td>
    </tr>
    <%
    if(oce.getBobo_interest_qita()!=null && oce.getBobo_interest_qita().length()>0)
    {
      out.print("<tr>");
      out.print("<td>&nbsp;</td>");
      out.print("<td colspan=4>");
      out.print("??????:&nbsp;");
      out.print(oce.getBobo_interest_qita());
      out.print("</td>");
      out.print("</tr>");
    }
    %>
  <tr>
    <td  class="td01">?????????????????????????????????????????????</td>
 <td colspan="4">
  <%
  for(int i=0;i<Ocean.INTEREST.length;i++)
  {
    oce.getInterest();
    if(oce.getInterest()!=null && oce.getInterest().length()>0)
    {
      String spit[] = oce.getInterest().split(",");
      if(spit.length!=-1)
      {
        for(int j=0;j<spit.length;j++)
        {
          if((spit[j]).length()>0)
          {
            int aa = Integer.parseInt(spit[j]);
            if(aa==i)
            {
              out.print("<div>"+Ocean.INTEREST[i]+"</div>");
              out.print("");
            }
          }
        }
      }
    }

  }
  %>
  </td></tr>
  <tr>
    <td class="td01">?????????</td>
    <td colspan="4"><%=oceancard%></td>
   </tr>
  <tr>
    <td class="td01">?????????:</td>
    <td colspan="4">??????:
        <input type="radio" name="drawtype" value="0"  onClick="find_x(this.value)"/>
?????????:
        <input type="radio" name="drawtype" value="1"   onClick="find_x(this.value)"/>
    </td>
  </tr>

  <tr id="huzhao" style="display:none;">

  <%
  if(oce.getReplacetype()==0)
  {
    %>
    <td>    </td>    <td colspan="4">??????????????????????????????</td>
    <%
  }else
  {
  %><td>  </td>    <td colspan="4">?????????        <input type="text"  name="drawnames" />???????????????    <input type="text" name="drawcards" />    </td>
    <%
  }
  %>
  </tr>
</table>

<%
if(show.equals("show"))
{
  %>
  <div class="tijiaoa">  <input type="button" value="??????" onClick="window.history.back();" style="width:100px;height:28px;border:0px;"/></div>
  <%
}
else
{
%>
<div class="tijiaoa">  <input type="image" src="/res/bj-sea/u/0902/090219001.gif" value="??????" onClick="return find_sub('1')" style="width:100px;height:28px;border:0px;"/></div>
<%
}
%>
</form>
</body>
</html>
