<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page  import="java.util.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


String shenhe= teasession.getParameter("shenhe");
String members=teasession.getParameter("members");
String password = "";
String firstname ="";

String telephone = "";
String email = "";
String mobile = "";
String xuanyan = "";
String zhiye = "";
String city = "";
String answer="";
String yixiang="";
String time="";
String wt1="",wt2="",wt3="",wt4="",wt5="",wt6="",wt7="",wt8="",wt9="",wt10="";
int province=0,age=0;
String picture="";
boolean sex=true;
if(shenhe!=null)
{
  if(shenhe.equals("1"))
  {
    Volunteer vo = Volunteer.find(members);
    Profile pro = Profile.find(members);

    sex=pro.isSex();
    firstname =pro.getFirstName(teasession._nLanguage);
    telephone = pro.getTelephone(teasession._nLanguage);
    time= pro.getBirthToString();
    if(pro.getBirth()!=null)
    {
      Calendar cal = Calendar.getInstance();
      Calendar caldate = Calendar.getInstance();
      cal.setTime(pro.getBirth());
      caldate.setTime(date);
      int year =cal.get(Calendar.YEAR);
      int yeardate=caldate.get(Calendar.YEAR);
      age = yeardate - year;
    }
    email = pro.getEmail();
    mobile = pro.getMobile();
    xuanyan = vo.getXuanyan();
    zhiye = vo.getZhiye();
    yixiang = vo.getWay();
    answer = vo.getAnswer();
    province=pro.getProvince(teasession._nLanguage);
    city = pro.getCity(teasession._nLanguage);
    picture=pro.getPhotopath(teasession._nLanguage);
    if(answer!=null)
    {
      String ss[]=answer.split(",");

      if(ss.length!=-1)
      {
        for(int j=0;j<ss.length;j++)
        {
          if(j==1)
          {
            wt1=ss[j];
          }else if(j==2)
          {
            wt2=ss[j];
          }else if(j==3)
          {
            wt3=ss[j];
          }else if(j==4)
          {
            wt4=ss[j];
          }else if(j==5)
          {
            wt5=ss[j];
          }else if(j==6)
          {
            wt6=ss[j];
          }else if(j==7)
          {
            wt7=ss[j];
          }else if(j==8)
          {
            wt8=ss[j];
          }else if(j==9)
          {
            wt9=ss[j];
          }
          else if(j==10)
          {
            wt10=ss[j];
          }
        }
      }
    }
  }
}
%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css"/>
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script type="">
  function subs()
  {

    if(form1.firstname.value=="" )
    {
      alert("姓名不能为空！");
      return false;
    }

    else
    if(form1.sex.value=="" )
    {
      alert("请填写性别！");
      return false;
    }else
    if(form1.age.value=="" )
    {
      alert("出生日期不能为空！");
      return false;
    }else

    if(form1.zhiye.value=="" )
    {
      alert("职业不能不能为空！");
      return false;
    }else
    if(form1.city.value=="" )
    {
      alert("请填写所在城市或县！");
      return false;
    }else
    if(form1.telephone.value=="" )
    {
      alert("手机号不能为空！");
      return false;
    }else

    if(form1.mobile.value=="" )
    {
      alert("联系电话不能为空！");
      return false;
    }else
    if(form1.email.value=="" )
    {
      alert("请填写您的Email！");
      return false;
    }else

    if(form1.xuanyan.value=="" )
    {
      alert("请填写您的宣言！");
      return false;
    }else
    if(form1.picture.value=="" )
    {
      alert("请上传您的照片！");
      return false;
    }
    for(var j=1;j<11;j++)
    {
      var a = document.getElementsByName("wt"+j);
      var num=0;
      for (var i=0; i<a.length; i++)
      {
        if(a[i].checked)
        {
          num++;
        }
      }
      if(num==0)
      {
        alert("对不起, 请检查第"+j+"题是否填写！");
        return false;
      }
    }
    var num2=0;
    for (var i=0; i<10; i++)
    {
      if(document.all("way"+i).checked)
      {
        num2++;
      }
    }
    if(num2==0)
    {
      alert("至少选一个意向");
      return false;
    }
    return true;
  }
  </script>
  
  <style>
#bodyvl h1{width:1002px;margin-left:0px;}
#bodyvl #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;}
</style>
  </HEAD>
  <body id="bodyvl">
  <h1>志愿者报名表aaa</h1>
  <form name="form1" action="/servlet/EditVolunteer" method="POST" enctype="multipart/form-data">
  <input type="hidden" value="EditVolunteer" name="act">
   <input type="hidden" value="tongguo" name="tongguo">
    <input type="hidden" value="new" name="falg">
  <TABLE width="1002" border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
    <tr>
      <td>姓名：</td>
      <td><input type="text" size="20" name="firstname" value="<%=firstname%>"></td>
        <td>性别：</td>
        <td><select name="sex"><option value="1"   <%if(sex)out.print("selected");%> >男</option><option value="0" <%if(!sex)out.print("selected");%>>女</option></select></td>
        <td>年龄：</td>
        <td>
          <input type="text" name="age" size="7"  value="<%=age%>"  >
        </td>
    </tr>
    <tr>
      <td>职业：</td>
      <td><input type="text" name="zhiye" size="20" value="<%=zhiye%>"  ></td>
        <td>居住地所在城市：</td>
        <td>
          <select name="province">
          <%
          for(int i=0;i<Common.CSVCITYS.length;i++)
          {
            out.print("<option value="+Common.CSVCITYS[i][0]);
            if(province==i)
            {
              out.print(" selected ");
            }
            out.print(" >"+Common.CSVCITYS[i][1]+"</option>");
          }

          %>
          </select></td>
          <td>现居住地所在区县：</td>
          <td><input type="text" name="city" size="20" value="<%=city%>"></td>
    </tr>
    <tr>
      <td>手机：</td>
      <td><input type="text" name="telephone" size="20"  mask="int" value="<%=telephone%>"></td>
        <td>座机电话：</td>
        <td><input type="text" name="mobile" size="20"  mask="int" value="<%=mobile%>"></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Email：</td>
      <td><input type="text" name="email" size="20" value="<%=email%>" ></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
      <td>首选参与意向：</td>
      <td colspan="3">
      <%
      for(int i=0;i<Volunteer.WAY.length;i++)
      {

        if(i==(Volunteer.WAY.length/2))
        {
          out.print("<br>");
        }
        out.print("<input  name=\"way"+i+"\" type=\"checkbox\" value="+Volunteer.WAY[i]);

        if(yixiang!=null)
        {

          if(yixiang.indexOf(Volunteer.WAY[i])!=-1)
          {
            out.print(" checked='checked'　");
          }
        }
        out.print("/>"+Volunteer.WAY[i]+"   ");
      }
      %>

      </td>
    </tr>
    <tr>
  <td>图片:</td>
  <td COLSPAN=6><input type="file" name="picture" size="40">
    <%
    if(picture!=null)
    {
       long lenpic=new File(application.getRealPath(picture)).length();
      out.print("<a target='_blank' href="+picture+" >"+lenpic+"字节</a>");
      out.print("<input type='CHECKBOX' name='clearpicture' onClick='foEdit.picture.disabled=checked' />"+"清除");
    }
    %>
  </td>
</tr>
    <tr>
      <td>申请宣言：</td>
      <td colspan="5"><textarea cols="50" rows="6" name="xuanyan"><%=xuanyan%></textarea></td>
    </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<h1>常识问答 dfdsf</h1>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<TABLE width="1002" border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

  <tr>
    <td colspan="4">1.世界艾滋病日是每年的何月何?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt1" value="1"  >.6月1日；
    </td>
    <td><input type="radio" name="wt1" value="2" >.8月1日；
    </td>
    <td><input type="radio" name="wt1" value="3"  checked="checked">.12月1日；
    </td>
    <td><input type="radio" name="wt1" value="4" >.11月1日
    </td>
  </tr>
  <tr>
    <td colspan="4">2.预防艾滋病是_____的责任?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt2" value="1" >.卫生部；</td>
      <td><input type="radio" name="wt2" value="2" >.政府；</td>
        <td><input type="radio" name="wt2" value="3" >.非政府组织；</td>
          <td><input type="radio" name="wt2" value="4" checked="checked">.全社会 </td>
  </tr>
  <tr>
    <td colspan="4">3.一个感染了艾滋病病毒的人能从外表上看出来吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt3" value="1" <%if(wt3.equals("1"))out.print(" checked");%>>.能；</td>
      <td><input type="radio" name="wt3" value="2" checked="checked">.不能；</td>
        <td><input type="radio" name="wt3" value="3" <%if(wt3.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">4.蚊虫叮咬会传播艾滋病吗?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt4" value="1" <%if(wt4.equals("1"))out.print(" checked");%>>.会；</td>
      <td><input type="radio" name="wt4" value="2" checked="checked">.不会；</td>
        <td><input type="radio" name="wt4" value="3" <%if(wt4.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">5.与艾滋病病毒感染者或病人一起吃饭会感染艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt5" value="1" <%if(wt5.equals("1"))out.print(" checked");%>>.会；</td>
      <td><input type="radio" name="wt5" value="2" checked="checked">.不会；</td>
        <td><input type="radio" name="wt5" value="3" <%if(wt5.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">6.输入带有艾滋病病毒的血液会得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt6" value="1" checked="checked">.会；</td>
      <td><input type="radio" name="wt6" value="2" <%if(wt6.equals("2"))out.print(" checked");%>>.不会；</td>
        <td><input type="radio" name="wt6" value="3" <%if(wt6.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">7.正确使用安全套可以减少艾滋病的传播吗?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt7" value="1" checked="checked">.可以； </td>
      <td><input type="radio" name="wt7" value="2" <%if(wt7.equals("2"))out.print(" checked");%>>.不可以；</td>
        <td><input type="radio" name="wt7" value="3" <%if(wt7.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">8.只与一个性伙伴发生性行为可以减少艾滋病的传播吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt8" value="1" checked="checked">.可以； </td>
      <td><input type="radio" name="wt8" value="2" <%if(wt8.equals("2"))out.print(" checked");%>>.不可以；</td>
        <td><input type="radio" name="wt8" value="3" <%if(wt8.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">9.与艾滋病病毒感染者公用注射器有可能得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt9" value="1" checked="checked">.有；</td>
      <td><input type="radio" name="wt9" value="2" <%if(wt9.equals("2"))out.print(" checked");%>>.没有；</td>
        <td><input type="radio" name="wt9" value="3" <%if(wt9.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">10.感染艾滋病病毒的妇女生下的小孩有可能得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt10" value="1" checked="checked">.有；</td>
      <td><input type="radio" name="wt10" value="2" <%if(wt10.equals("2"))out.print(" checked");%>>.没有；</td>
        <td><input type="radio" name="wt10" value="3" <%if(wt10.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>    <td colspan="4" align="center">
  <%if(shenhe!=null)
  {
    %>
    <input type="button" value="审核通过" onClick="window.open('/jsp/volunteer/VolunteerList.jsp?type=1&members=<%=members%>','_self');">
    <%
    }else
    {
      %>
      <input type="submit" value="提交"  onclick="return subs();"/>
      <%
    }
    %>
    </td>
  </tr>
</table>
  </form>
  </body>
</html>
