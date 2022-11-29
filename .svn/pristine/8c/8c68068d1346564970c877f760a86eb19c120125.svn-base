<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import = "tea.resource.Resource" %>
<%
 	TeaSession teasession = new TeaSession(request);
out.println("<script>alert('Your registration is successfully completed. Please activate your account.We\\'ve already sent you  an activation email Please click the affirm link and your account will be activated immediately.');</script>");

 	Resource r = new Resource("/tea/resource/Photography");
        int membertype = 0;
        if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0){
            membertype = Integer.parseInt(teasession.getParameter("membertype"));
        }
 %>

 


<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script>
function f_sub()
{
	//user
	    if (loginform.member.value == "") {

             document.getElementById("memberid").innerHTML='<font color=red>Sorry! Please enter your email.</font>';
            loginform.member.focus();
            return;
        } else {
            var strm = document.loginform.member.value   //提交mail地址的文本框
           // var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
            var regm = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            //验证Mail的正则表达式,^[a-zA-Z0-9_-]:开头必须为字母,下划线,数字,
            if (!strm.match(regm) && strm != "")
            {
                document.getElementById("memberid").innerHTML='<font color=red>Sorry! This e-mail address has been used as sign-in name.</font>';
                document.loginform.member.focus();
                return;
            }
        }

	//name

      if(loginform.membername.value=='')
      {
         // alert("【】！");

         document.getElementById("membernameid").innerHTML='<font color=red>Sorry! Please enter your name.</font>';
          loginform.membername.focus();
          return false;
      }
      document.getElementById("membernameid").innerHTML='';


	    //password

		if(loginform.EnterPassword.value=='')
			{
				 document.getElementById("passwordid").innerHTML='<font color=red>Please enter password.</font>';
	        loginform.EnterPassword.focus();
	        return false;
			}

	    if(loginform.EnterPassword.value.length<6 || loginform.EnterPassword.value.length>18)
	    {
	        //alert("");
	        document.getElementById("passwordid").innerHTML='<font color=red>Sorry! Passwords Pin must be 6 to 18 digits.</font>';
	        loginform.EnterPassword.focus();
	        return false;
	    }
     document.getElementById("passwordid").innerHTML='';
     
     if(loginform.ConfirmPassword.value=='')
			{
				 document.getElementById("confirmpasswordid").innerHTML='<font color=red>Please re-enter password.</font>';
	        loginform.EnterPassword.focus();
	        return false;
			}

	    if(loginform.ConfirmPassword.value!=loginform.EnterPassword.value)
		    {
		       document.getElementById("confirmpasswordid").innerHTML='<font color=red><%=r.getString(0,"7564207487")%><%=r.getString(0,"1602371535")%><%=r.getString(0,"3537376961")%>.</font>';
		       loginform.ConfirmPassword.focus();
		       return false;
		   }
	    	document.getElementById("confirmpasswordid").innerHTML='';

	    //newsletter
	     var getnewsletter = 0;
	    for (var n = 0; n < loginform.newsletter.length; n++) {
	        if (document.loginform.newsletter[n].checked) {
	            getnewsletter += 1;
	        }
	    }
	    if (getnewsletter == 0) {

	        document.getElementById("newsletterid").innerHTML='<font color=red>Please choose!</font>';
	       // loginform.newsletter.focus();
	        return false;
	    }
	     document.getElementById("newsletterid").innerHTML='';


	      //newsletter
	     var getabstracts = 0;
	    for (var n = 0; n < loginform.abstracts.length; n++) {
	        if (document.loginform.abstracts[n].checked) {
	            getabstracts += 1;
	        }
	    }
	    if (getabstracts == 0) {

	        document.getElementById("abstractsid").innerHTML='<font color=red>Please choose!</font>';
	        //loginform.abstracts.focus();
	        return false;
	    }
	     document.getElementById("abstractsid").innerHTML='';

	      //ageid
	     var getage = 0;
	    for (var n = 0; n < loginform.age.length; n++) {
	        if (document.loginform.age[n].checked) {
	            getage += 1;
	        }
	    }
	    if (getage == 0) {

	        document.getElementById("ageid").innerHTML='<font color=red>Please choose!</font>';
	        //loginform.age.focus();
	        return false;
	    }
	     document.getElementById("ageid").innerHTML='';

	     //city
	       if(loginform.city.value=='')
      		{
	        	 document.getElementById("cityid").innerHTML='<font color=red>Sorry! Please enter your city!</font>';
	         	 loginform.city.focus();
	          	 return false;
      		}
      document.getElementById("cityid").innerHTML='';

	     //Industry
	     if(loginform.industry.value==-1)
      		{
	        	 document.getElementById("industryid").innerHTML='<font color=red>please input your industry!</font>';
	         	 loginform.industry.focus();
	          	 return false;
      		}
      document.getElementById("industryid").innerHTML='';

          //Job
	     if(loginform.job.value==-1)
      		{
	        	 document.getElementById("jobid").innerHTML='<font color=red>please input your job!</font>';
	         	 loginform.job.focus();
	          	 return false;
      		}
      document.getElementById("jobid").innerHTML='';
      document.getElementById("submits").disabled=true;
      loginform.action='/servlet/EditMember';
      loginform.submit();

} 
function loginform_ajax()
{

 			var strm = document.loginform.member.value   //提交mail地址的文本框
           // var regm = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
 			var regm =/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            //验证Mail的正则表达式,^[a-zA-Z0-9_-]:开头必须为字母,下划线,数字,
            if (!strm.match(regm) && strm != "")
            { 
               // alert("the email's format is error!please check it!");
                document.getElementById("memberid").innerHTML='<font color=red>Sorry! This e-mail address has been used as sign-in name.</font>';
                document.loginform.member.focus();
                return;
            }
    var value = loginform.member.value;
    var name ="MemberId_en";

      sendx("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name,
		 function(data)
		 {
		   if(data!=''&&data.length>0)//如果有这个用户  则写入Cookie
		   {
				document.getElementById("memberid").innerHTML=data.trim();
				if(data.indexOf('red')==-1){
					document.getElementById("submits").disabled=false;
				}else{
					document.getElementById("submits").disabled=true;
				}
		   }
		 }
		 );

    //submits


}
</script>

<form name="loginform" method="POST" action="/servlet/EditMember">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="WomenRegister"/>

<div class="Registration">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

		<tr>
			<td nowrap align="right"><b>My E-Mail address is：</b></td>
			<td><input type=text name="member" value="" onblur="loginform_ajax();">&nbsp;<font color=red>*</font>&nbsp;<span id="memberid"></span><br>
			(This is your sign-in name.Please use a valid email address.)
			</td>
		</tr>

		<tr>
			<td nowrap align="right"><b>My name is：</b></td>
			<td><input type=text name="membername" value="">&nbsp;<font color=red>*</font>&nbsp;<span id="membernameid"></span><br>
			(This name shows up when you make comments.)
			</td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Enter a password：</b></td>
			<td><input type="password" name=EnterPassword value="">&nbsp;<font color=red>*</font>&nbsp;<span id="passwordid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Confirm your password：</b></td>
			<td><input type="password" name=ConfirmPassword value="">&nbsp;<font color=red>*</font>&nbsp;<span id="confirmpasswordid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Subscription to Newsletter：</b></td>
			<td> <input type="radio" name="newsletter"   value="1"/>&nbsp;Yes&nbsp;
                 <input type="radio" name="newsletter"  value="0"/>&nbsp;No&nbsp;<font color=red>*</font>&nbsp;<span id="newsletterid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Subscription to Academic<br/>Papers Abstracts：</b></td>
			<td><input type="radio" name="abstracts"  value="1"/>&nbsp;Yes&nbsp;
                <input type="radio" name="abstracts"  value="0"/>&nbsp;No&nbsp;<font color=red>*</font>&nbsp;<span id="abstractsid"></span></td>
		</tr>
	</table>
    </div>
    <div class="yourself">
	<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

		<tr>
			<td nowrap colspan="2" class="no1">Knowing more about you will help us improve our websites and provide a better service.<br>
Please fill in the required fields which are marked with a red asterisk. </td>

		</tr>

		<tr>
			<td nowrap align="right"><b>Gender：</b></td>
			<td><input type="radio" name="sex" checked="checked"  value="1"/>&nbsp;Male&nbsp;
                <input type="radio" name="sex"  value="0"/>&nbsp;Female&nbsp;<font color=red>*</font></td>
		</tr>

			<tr>
			<td nowrap align="right"><b>Age：</b></td>
			<td>
			<input type="radio" name="age" value="1"/>
	        under20
	        <input type="radio" name="age" value="2"/>
	        21-25
	        <input type="radio" name="age" value="3"/>
	        26-30
	        <input type="radio" name="age" value="4"/>
	        31-40
	        <input type="radio" name="age" value="5"/>
	        41-50
	        <input type="radio" name="age" value="6"/>
	        51-60
	        <input type="radio" name="age" value="7"/>
	       above60
	
             &nbsp;<font color=red>*</font>&nbsp;<span id="ageid"></span></td>
		</tr>

		<tr>
			<td nowrap align="right"><b>City：</b></td>
			<td><input type=text name="city" value="">&nbsp;<font color=red>*</font>&nbsp;<span id="cityid"></span>
			</td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Country：</b></td>
			<td><%=new tea.htmlx.CountrySelection("Country",0,"CN") %>&nbsp;<font color=red>*</font></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Industry：</b></td>
			<td>
                            <select name="industry">

                                <%
                                    for(int i=0;i<Profile.INDUSTRY.length;i++)
                                    {
                                        out.print("<option value="+i);
                                        out.print(">"+Profile.INDUSTRY[i]);
                                        out.print("</option>");
                                    }
                                %>

                            </select>
                            &nbsp;<font color=red>*</font>&nbsp;<font id="industryid"></font></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Job：</b></td>
			<td><select name="job">

                                <%
                                    for(int i=0;i<Profile.JOB.length;i++)
                                    {
                                        out.print("<option value="+i);
                                        out.print(">"+Profile.JOB[i]);
                                        out.print("</option>");
                                    }
                                %>
                            </select>&nbsp;<font color=red>*</font>&nbsp;<font id="jobid"></font></td>
		</tr>
	</table>
</div>
<div class="website">
	<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

		<tr>
			<td nowrap colspan="2" class="no1"><span id ="whatid">What information you would like to read from the website?</span> </td>

		</tr>
                <%
                            java.util.Enumeration e = WomenOptions.find(teasession._strCommunity, " and type= 0", 0, Integer.MAX_VALUE);
                if(!e.hasMoreElements()){
                	out.print("<script>document.getElementById('whatid').style.display='none'</script>");
                } 
                            while (e.hasMoreElements()) {
                                int wid = ((Integer) e.nextElement()).intValue();
                                WomenOptions obj = WomenOptions.find(wid);
                               int count =  WomenOptions.count(teasession._strCommunity, " and type = " + wid);

                %>
                <tr>
                    <td align="right"><%=obj.getWoname()%>：<%if(count==0) { 
                    	out.print("<input type=\"checkbox\" name=\"woid\" value="+wid+">");
                   // out.print("&nbsp;"+obj.getWoname()+"&nbsp;");
                    }%></td>
                    <td>
                    <%
                        java.util.Enumeration e2 = WomenOptions.find(teasession._strCommunity, " and type = " + wid, 0, Integer.MAX_VALUE);
                        for (int i=0;e2.hasMoreElements();i++) {
                            int wid2 = ((Integer) e2.nextElement()).intValue();
                            WomenOptions obj2 = WomenOptions.find(wid2);
                           if(i%4==0){
                            out.print("<br>");
                           }
                            out.print("<input type=\"checkbox\" name=\"woid\" value="+wid2+">");
                            out.print("&nbsp;"+obj2.getWoname()+"&nbsp;");
                           
                        }                                   
                    %>
                    </td>
                </tr>
                <%}%>


	</table>
<div class="submits">
<input type="button" id="submits" value="Submit" style="width:80px;height:20px;margin:10px 0;" onclick=f_sub();></div>
</div>
</form>


