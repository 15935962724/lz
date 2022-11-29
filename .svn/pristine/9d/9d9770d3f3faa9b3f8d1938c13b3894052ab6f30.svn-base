<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page  import="java.util.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


 
String membertypeact = teasession.getParameter("membertypeact");

//前台查询出来 点击的注册
String vrsname = teasession.getParameter("vrsname");
String vrstelephone=teasession.getParameter("vrstelephone"); 

 int membertype = 0;//是否新会员注册 0 新会员，1 老会员
 
 if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
 {
	 membertype = Integer.parseInt(teasession.getParameter("membertype"));
 }

 if("dj".equals(membertypeact))
 {
	 membertype = 1;
 } 
 
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
String birth = "",card="";
if(shenhe!=null || members!=null)
{
  if("1".equals(shenhe) || members!=null)
  {
    Volunteer vo = Volunteer.find(members);
    Profile pro = Profile.find(members);
    if(vo.getMembertype()==1)//已经登记过，不能再修改信息
    {
    	out.println("您已经登记过信息，不能修改信息，如果要修改，请登录网站，再后台修改信息!");
    	return;
    }

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
    card=pro.getCard();
    email = pro.getEmail();
    mobile = pro.getMobile();
    xuanyan = vo.getXuanyan();
    zhiye = vo.getZhiye();
    yixiang = vo.getWay();
    answer = vo.getAnswer();
    province=pro.getProvince(teasession._nLanguage);
    city = pro.getCity(teasession._nLanguage);
    picture=pro.getPhotopath(teasession._nLanguage);
    password=pro.getPassword();
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

tea.entity.site.Community cobj=tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css"/>
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
  <script src="/tea/Calendar.js" type="text/javascript"></script>
  <script type="text/javascript">
  function subs()
  {
	  
	  
	  
	  if(form1.member.value=='')
	    {
	        //alert("");
	        alert("用户名不能为空.");
	        form1.member.focus();
	        return false;
	    }
	  
	  if(form1.EnterPassword.value.length<6 || form1.EnterPassword.value.length>18)
	    {
	        //alert("");
	        alert("密码必须为6到18位之间.");
	        form1.EnterPassword.focus();
	        return false;
	    }
	     
	  
	    if(form1.ConfirmPassword.value!=form1.EnterPassword.value)
	    { 
	      alert("两次密码输入不一致.");
	       form1.ConfirmPassword.focus();
	       return false;
	   }
	    	


    if(form1.firstname.value=="" )
    {
      alert("姓名不能为空！");
      form1.firstname.focus();
      return false;
    }

 
    if(form1.sex.value=="" )
    {
      alert("请填写性别！");
      form1.sex.focus();
      return false;
    }
    if(form1.birth.value=="")
    {
      alert("出生日期不能为空！");
      form1.birth.focus();
      return false;
    }
    if(form1.mobile.value=="" )
    {
      alert("手机号不能为空！");
      form1.mobile.focus();
      return false;
    }else
    {
    	var str = document.form1.mobile.value;
    	 var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
        if(!reg.test(str)){
          alert("请填写正确的手机号！");
          form1.mobile.focus();
          return false;
        }

    }

    if(form1.email.value=="" )
    {
      alert("请填写您的Email！");
      form1.email.focus();
      return false;
    }else
    {
    	 var strReg="";
         var r;
         var str = form1.email.value;
         strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
         r=str.search(strReg);
         if(r==-1){
          // alert("请正确填写【邮箱地址】！");
           alert("您填写的Email格式不正确！");
           form1.email.focus();
           return false;
         }
	
    }
    if(form1.zhiye.value=="" )
    {
      alert("职业不能不能为空！");
      form1.zhiye.focus();
      return false;
    }
    if(form1.city.value=="" )
    {
      alert("请选择所在区县！");
      form1.city.focus();
      return false;
    }
    


    
    if(form1.card.value=='')
    {
    	alert('请填写您的身份证');
    	form1.card.focus();
    	return false;
    }else{
    	
	    var sID = document.form1.card.value
	   
		var type="^\s*[+-]?[0-9]+\s*$";
		var re = new RegExp(type);

		if(sID.substr(1,17).match(re)==null)
		{
			 alert("身份证号输入错误");
			 document.form1.card.focus();
		     
		      return false;
			 
		}else
		{
		    if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
		    {
		      alert("请输入15位或18位身份证号");
		      document.form1.card.focus();
		     
		      return false;
		    }
	    }
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
    
    return true;
  }
  
  function f_ajax()
  {
    var value = form1.member.value;
  
      var name ="MemberId";
     
   	  
   	  
   	  
   	sendx("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name,
   		 function(data)
   		 {

   		  //alert("4444->>>>."+data.length);
   		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
   		   {
   			document.getElementById("show").innerHTML=data;
	   			if(data.indexOf('red')!=-1)
	   	   	  {
	   	   		document.getElementById("submits").disabled=true;
	   	   		document.getElementById("submits").value='用户名重复,不能提交信息...'; 
	   	   	  }else
	   	   	  {
	   	   		document.getElementById("submits").disabled=false;
	   	   		document.getElementById("submits").value='提交用户信息'; 
	   	   	  }
   		   }
   		 }
   		 );

   	  
   	  
  } 

  
  </script>
  
  <style>
#bodyvl h1{width:1002px;margin-left:0px;}
#bodyvl #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;border-collapse:collapse;
}
</style>
  </HEAD> 
  <body id="bodyvl">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=cobj.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  
  <h1>志愿者报名表</h1>
  <form name="form1" action="/servlet/EditVolunteer" method="POST" enctype="multipart/form-data">
<input type="hidden" name="membertype" value="<%=membertype %>"> 
<input type="hidden" name="community" value="<%=community %>"> 
<input type="hidden" name="repository" value="volunteer" >
  <TABLE width="1002" border="1" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  
  <%
  	if("zc".equals(membertypeact)){//新注册用户
  		 
  %>
 <tr>
      <td align="right">*&nbsp;用户名：</td>
      <td><input type="text" size="20" name="member" value="<%=Entity.getNULL(members)%>"  onkeyup="f_ajax();"><SPAN ID=show></SPAN></td>
        <td align="right">*&nbsp;密码：</td>
         <td><input type="password" size="20" name="EnterPassword" value="<%=password%>"></td>
          <td align="right">*&nbsp;确认密码：</td>
         <td><input type="password" size="20" name="ConfirmPassword" value="<%=password%>"></td>
       
    </tr>
   
  <%}else if("dj".equals(membertypeact)){//老志愿者 已经登记%>
  <input type="hidden" name="member" value="<%=members %>">
   
  <tr>
      <td align="right">*&nbsp;用户名：</td>
      <td><input type="text" size="20" name="member" value="<%=members%>" disabled="disabled" readonly="readonly"></td>
        <td align="right">*&nbsp;密码：</td>
         <td><input type="password" size="20" name="EnterPassword" value=""  ></td>
          <td align="right">*&nbsp;确认密码：</td>
         <td><input type="password" size="20" name="ConfirmPassword" value=""  ></td>
       
    </tr>
  
  <%} %>
    <tr>
      <td align="right">*&nbsp;姓名：</td>

      <td><input type="text" size="20" name="firstname" value="<%if(vrsname!=null && vrsname.length()>0){out.println(vrsname);}else{out.println(firstname);}%>" <%if(vrsname!=null && vrsname.length()>0){out.println(" readonly");} %> ></td>
        <td align="right">*&nbsp;性别：</td> 
        <td><select name="sex"><option value="1"   <%if(sex)out.print("selected");%> >男</option><option value="0" <%if(!sex)out.print("selected");%>>女</option></select></td>
        <td align="right">*&nbsp;出生日期：</td>
        <td>
         
            <input id="birth" name="birth" size="7"  value="<%=time %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.birth');"> 
        <img style="margin-bottom:-8px;cursor:pointer" src="/tea/image/bbs_edit/table.gif" onClick="new Calendar().show('form1.birth');" />
  
        </td>
    </tr>
     <tr>
      <td align="right">*&nbsp;手机：</td>
      <td><input type="text" name="mobile" size="20"   value="<%if(vrstelephone!=null && vrstelephone.length()==11){out.println(vrstelephone);}else{out.println(mobile);}%>" <%if(vrstelephone!=null && vrstelephone.length()==11){out.println(" readonly");} %>></td>
     <td align="right">&nbsp;座机电话：</td>
        <td><input type="text" name="telephone" size="20"   value="<%if(vrstelephone!=null && vrstelephone.length()!=11){out.println(vrstelephone);}else{out.println(telephone);}%>"></td>
        
      <td align="right">*&nbsp;Email：</td>
      <td><input type="text" name="email" size="20" value="<%=email%>" ></td>
       
    </tr>
    <tr>
    
        <td align="right">*&nbsp;职业：</td>
         <td><input type="text" name="zhiye" size="20" value="<%=zhiye%>"  ></td>
          <td align="right">*&nbsp;现居住地所在区县：</td>
          <td>
          	<select name="city">
          		<option value="">-选择区县-</option>
          		<%
          			for(int i = 0;i<Volunteer.CITYS.length;i++)
          			{
          				out.print("<option value="+i);
          				if(String.valueOf(i).equals(city))
          				{
          					out.println(" selected ");
          				}
          				out.print(">"+Volunteer.CITYS[i]);
          				out.print("</option>");
          			}
          		%>
          	</select>
          </td>
          <td align="right">*&nbsp;身份证：</td>
         <td><input type="text" name="card" size="20" value="<%=card%>"  ></td>
         
    </tr>
    
  
   
    
    <tr>
  <td align="right">&nbsp;图片:</td>
  <td COLSPAN=6><input type="file" name="picture" size="40">
    <%
    if(picture!=null && picture.length()>0)
    {
       long lenpic=new File(application.getRealPath(picture)).length();
       if(lenpic>0){
      out.print("<a target='_blank' href="+picture+"><span id=pictureid>"+lenpic+"</span>字节</a>");
      out.print("<input type='CHECKBOX' name='clearpicture' onClick='form1.picture.disabled=checked' />"+"清除");
       }
    }
    %>
  </td>
</tr>
  
</table>

<h1>常识问答 </h1>

<TABLE width="1002" border="1" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <input type="hidden" value="EditVolunteer" name="act">
  <tr>
    <td colspan="4">1.世界艾滋病日是每年的何月何日?</td>
  </tr>
  <tr>
    <td width="238"><input type="radio" name="wt1" value="1"  <%if(wt1.equals("1"))out.print(" checked ");%>>.6月1日；
    </td>
    <td width="238"><input type="radio" name="wt1" value="2" <%if(wt1.equals("2"))out.print(" checked ");%>>.8月1日；
    </td>
    <td width="256"><input type="radio" name="wt1" value="3" <%if(wt1.equals("3"))out.print(" checked ");%>>.12月1日；
    </td>
    <td width="268"><input type="radio" name="wt1" value="4" <%if(wt1.equals("4"))out.print(" checked  ");%>>.11月1日
    </td>
  </tr>
  <tr>
    <td colspan="4">2.预防艾滋病是_____的责任?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt2" value="1" <%if(wt2.equals("1"))out.print(" checked ");%>>.卫生部；</td>
      <td><input type="radio" name="wt2" value="2" <%if(wt2.equals("2"))out.print(" checked ");%>>.政府；</td>
        <td><input type="radio" name="wt2" value="3" <%if(wt2.equals("3"))out.print(" checked ");%>>.非政府组织；</td>
          <td><input type="radio" name="wt2" value="4" <%if(wt2.equals("4"))out.print(" checked");%>>.全社会 </td>
  </tr>
  <tr>
    <td colspan="4">3.一个感染了艾滋病病毒的人能从外表上看出来吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt3" value="1" <%if(wt3.equals("1"))out.print(" checked");%>>.能；</td>
      <td><input type="radio" name="wt3" value="2" <%if(wt3.equals("2"))out.print(" checked");%>>.不能；</td>
        <td><input type="radio" name="wt3" value="3" <%if(wt3.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">4.蚊虫叮咬会传播艾滋病吗?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt4" value="1" <%if(wt4.equals("1"))out.print(" checked");%>>.会；</td>
      <td><input type="radio" name="wt4" value="2" <%if(wt4.equals("2"))out.print(" checked");%>>.不会；</td>
        <td><input type="radio" name="wt4" value="3" <%if(wt4.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">5.与艾滋病病毒感染者或病人一起吃饭会感染艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt5" value="1" <%if(wt5.equals("1"))out.print(" checked");%>>.会；</td>
      <td><input type="radio" name="wt5" value="2" <%if(wt5.equals("2"))out.print(" checked");%>>.不会；</td>
        <td><input type="radio" name="wt5" value="3" <%if(wt5.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">6.输入带有艾滋病病毒的血液会得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt6" value="1" <%if(wt6.equals("1"))out.print(" checked");%>>.会；</td>
      <td><input type="radio" name="wt6" value="2" <%if(wt6.equals("2"))out.print(" checked");%>>.不会；</td>
        <td><input type="radio" name="wt6" value="3" <%if(wt6.equals("3"))out.print(" checked");%>>.不知道 </td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">7.正确使用安全套可以减少艾滋病的传播吗?</td>
  </tr>
  <tr>
    <td><input type="radio" name="wt7" value="1" <%if(wt7.equals("1"))out.print(" checked");%>>.可以； </td>
      <td><input type="radio" name="wt7" value="2" <%if(wt7.equals("2"))out.print(" checked");%>>.不可以；</td>
        <td><input type="radio" name="wt7" value="3" <%if(wt7.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">8.只与一个性伙伴发生性行为可以减少艾滋病的传播吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt8" value="1" <%if(wt8.equals("1"))out.print(" checked");%>>.可以； </td>
      <td><input type="radio" name="wt8" value="2" <%if(wt8.equals("2"))out.print(" checked");%>>.不可以；</td>
        <td><input type="radio" name="wt8" value="3" <%if(wt8.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">9.与艾滋病病毒感染者公用注射器有可能得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt9" value="1" <%if(wt9.equals("1"))out.print(" checked");%>>.有；</td>
      <td><input type="radio" name="wt9" value="2" <%if(wt9.equals("2"))out.print(" checked");%>>.没有；</td>
        <td><input type="radio" name="wt9" value="3" <%if(wt9.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">10.感染艾滋病病毒的妇女生下的小孩有可能得艾滋病吗? </td>
  </tr>
  <tr>
    <td><input type="radio" name="wt10" value="1" <%if(wt10.equals("1"))out.print(" checked");%>>.有；</td>
      <td><input type="radio" name="wt10" value="2" <%if(wt10.equals("2"))out.print(" checked");%>>.没有；</td>
        <td><input type="radio" name="wt10" value="3" <%if(wt10.equals("3"))out.print(" checked");%>>.不知道</td>
          <td>&nbsp;</td>
  </tr>
  <tr>    <td colspan="4" align="center">
  <%if(shenhe!=null && shenhe.length()>0)
  {
    %>
    <input type="button" value="审核通过" onClick="window.open('/jsp/volunteer/VolunteerList.jsp?type=1&members=<%=members%>','_self');">
    <%
    }else
    {
      %>
      <input type="submit" value="提交" name="submits" onClick="return subs();"/>
      <%

    }
    %>
    </td>
  </tr>
</table>
  </form>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=cobj.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
  
  </body>
</html>
