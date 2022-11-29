<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

String member = request.getParameter("member");
Profile p = Profile.find(member);
ProfileZh pz = ProfileZh.find(member);


%>
<html>
<head>
<title>
会员信息
</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#ffffff">
<h1>
会员信息
</h1>

<div id="friendship"><img src="/res/china-corea/u/0811/081127512.gif"/></div>
<div id="friendship_02"><img src="/res/china-corea/u/0811/081127515.gif"/></div>
<div id="friendship_03"><img src="/res/china-corea/u/0811/081127519.gif"/></div>

<div id="members_Resume">
  <table  border="1" cellspacing="0" cellpadding="0" ID="members">
    <tr>
      <td id="td_01">姓　名</td>
      <td id="td_02"><%=pz.getName()%></td>
      <td id="td_01">性　别</td>
      <td id="td_02"><%=p.isSex()?"男":"女"%></td>
      <td id="td_03">出生年月日</td>
      <td id="td_02"><%=p.getBirthToString()%></td>
      <td rowspan="4" id="pc" align="center" valign="middle">
      <%if(pz.getPhoto()!=null){if(pz.getPhoto().length()!=4){%><img alt="" src="<%=pz.getPhoto()%>" width="100" height="135" /><%}} %>
      </td>
    </tr>

    <tr>
      <td id="td_01">民　族</td>
      <td id="td_02"><%=pz.getNationnal()%></td>
      <td id="td_01">籍　贯</td>
      <td id="td_02"><%=pz.getNactive()%></td>
      <td id="td_03">出　生　地</td>
      <td id="td_02"><%=pz.getBplace()%></td>
    </tr>
    <tr>
      <td id="td_01">政治面貌</td>
      <td id="td_02"><%=pz.getPolitical()%></td>
      <td id="td_01">身份证号</td>
      <td colspan="3" id="td_05"><%=pz.getCard()%></td>
    </tr>
    <tr>
      <td id="td_01">家庭住址</td>
      <td colspan="3" id="td_06"><%=pz.getFaddr()%></td>
      <td id="td_03">邮　编</td>
      <td id="td_02"><%=pz.getZip()%></td>
    </tr>
    <tr>
      <td id="td_01">住宅电话</td>
      <td colspan="3" id="td_06"><%=pz.getHomephone()%></td>
      <td id="td_03">手　机</td>
      <td colspan="2" id="td_07"><%=p.getMobile()%></td>
    </tr>
    <tr>
      <td id="td_01">E-Mail</td>
      <td colspan="3" id="td_06"><%=p.getEmail()%></td>
      <td id="td_03">个人网页</td>
      <td colspan="2" id="td_07"><%=pz.getWeb()%></td>
    </tr>
    <tr>
      <td id="td_01">单位名称</td>
      <td colspan="3" id="td_06"><%=pz.getComname()%></td>
      <td id="td_03">职　务</td>
      <td colspan="2" id="td_07"><%=pz.getJob()%></td>
    </tr>
    <tr>
      <td id="td_01">单位电话</td>
      <td colspan="3" id="td_06"><%=pz.getComphone()%></td>
      <td id="td_03">传　真</td>
      <td colspan="2" id="td_07"><%=pz.getFax()%></td>
    </tr>
    <tr>
      <td id="td_01">单位地址</td>
      <td colspan="4" id="td_08"><%=pz.getComaddr()%></td>
      <td colspan="2">
        <table border="0" cellspacing="0" cellpadding="0">
          <tr>
        <td id="div_01">邮　编</td><td id="div_02"><%=pz.getComzip()%></td>
    </tr>
  </table>
      </td>
    </tr>
    <tr>
      <td id="td_01">其他社会<br/>职务</td>
      <td colspan="6" id="td_09"><%=pz.getOtherjob()%></td>
    </tr>
    <tr>
      <td id="td_01">联系人</td>
      <td colspan="3" id="td_06"><%=pz.getCper()%></td>
      <td id="td_03">职　务</td>
      <td colspan="2" id="td_07"><%=pz.getCjob() %></td>
    </tr>
    <tr>
      <td id="td_01">电　话</td>
      <td colspan="3" id="td_06"><%=pz.getCphone()%></td>
      <td id="td_03">传　真</td>
      <td colspan="2" id="td_07"><%=pz.getCfax()%></td>
    </tr>
    <tr>
      <td colspan="2" id="td_10">希望协会将邮递资料寄往</td>
      <td colspan="5" id="td_11"><%=pz.getZsToHtml()%></td>
    </tr>
    <tr>
      <td colspan="2" id="td_10">希望协会将有关消息发往</td>
      <td colspan="5" id="td_11"><%=pz.getIsToHtml()%></td>
    </tr>
    <tr id="tr_01"><td colspan="7" align="center">个人简历</td></tr>
    <tr id="tr_02"><td id="td_1" colspan="2" align="center">何年何月至何年何月</td><td id="td_2" colspan="2" align="center">在何地区何单位</td><td id="td_3" colspan="3" align="center">任（兼）何职</td></tr>
       <%
         String resume = pz.getResume();
         String[] trsume = resume.split(",");
         int  cnt=0,start  =  0;
         while(start!=resume.length()){
           int  i  =  resume.indexOf( ",",start);
           if(i!=-1)
           {
             cnt  ++;
             start  =  i+1;
           }
           else
           break;
         }
         String sm=null;
         for(int i = 1; i <cnt;i++)
         {
           out.print("<tr>");
           String[] tdsume = trsume[i].split("`");

           for(int j = 0; j <3; j++)
           {
             if(tdsume[j].equals("　"))
             {
               sm = "";
             }else
             {
               sm = tdsume[j];
             }
             if(j==2){
               out.print("<td colspan=3 align=center>"+sm+"</td>");
             }else{
               out.print("<td colspan=2 align=center>"+sm+"</td>");
             }
           }
           out.print("</tr>");
         }
      %>
</table>

</div>
<table  border="0" cellspacing="0" cellpadding="0" ID="members_bottom">
  <tr><td align="center"><input type="button" value="返回" onclick="history.go(-1)"/></td></tr>
</table>
</body>
</html>
