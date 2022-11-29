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
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

 	Resource r = new Resource("/tea/resource/Photography");
        int membertype = 0;
        if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0){
            membertype = Integer.parseInt(teasession.getParameter("membertype"));
        }
         String en = teasession.getParameter("en");
        String member = null;
        if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0){
        	
        	member =teasession.getParameter("member");
        }else
        {
        	member = teasession._rv.toString();
        }
        
        String memberorder =null;
        if(memberorder!=null)
        {
        	memberorder = teasession.getParameter("memberorder");
        }else
        {
        	memberorder = MemberOrder.getMemberOrder(teasession._strCommunity,membertype,member);
        }
	    MemberOrder  moobj = MemberOrder.find(memberorder);
	    Profile pobj = Profile.find(member);
	    MemberType mtobj = MemberType.find(membertype);
	    String nexturl =  request.getRequestURI()+"?"+request.getQueryString();
	    if(teasession.getParameter("nexturl")!=null && teasession.getParameter("nexturl").length()>0){ 
	    	nexturl = teasession.getParameter("nexturl");
	    }  
 %>

 
<html>
<head>
<title>会员编辑管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body style="text-align:center">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script>
function f_sub()
{
	
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

	//name

      if(loginform.membername.value=='')
      {
         // alert("【】！");

         document.getElementById("membernameid").innerHTML='<font color=red>Sorry! Please enter your name.</font>';
          loginform.membername.focus();
          return false;
      }
      document.getElementById("membernameid").innerHTML='';



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



</script>
<h1><%if("en".equals(en)){out.print("Member Editor");}else{out.print("会员编辑");} %></h1>
<form name="loginform" method="POST" action="/servlet/EditMember">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="WomenRegister_edit"/>
<input type="hidden" name="member" value="<%=member %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="en" value="<%=en %>"/>
<div class="Registration">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

		<tr>
			<td nowrap align="right"><b>My E-Mail address is：</b></td>
			<td><font color=red><%=member %></font></td>
		</tr>

		<tr>
			<td nowrap align="right"><b>My name is：</b></td>
			<td><input type=text name="membername" value="<%=pobj.getNULL(pobj.getFirstName(teasession._nLanguage)) %>">&nbsp;<font color=red>*</font>&nbsp;<span id="membernameid"></span><br>
			(This name shows up when you make comments.)
			</td>
		</tr>
		
		<tr>
			<td nowrap align="right"><b>Enter a password：</b></td>
			<td><input type="password" name=EnterPassword value="<%=pobj.getNULL(pobj.getPassword()) %>">&nbsp;<font color=red>*</font>&nbsp;<span id="passwordid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Confirm your password：</b></td>
			<td><input type="password" name=ConfirmPassword value="<%=pobj.getNULL(pobj.getPassword()) %>">&nbsp;<font color=red>*</font>&nbsp;<span id="confirmpasswordid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Subscription to Newsletter：</b></td>
			<td> <input type="radio" name="newsletter" <%if(moobj.getNewsletter()==1)out.print(" checked "); %>  value="1"/>&nbsp;Yes&nbsp;
                 <input type="radio" name="newsletter"  <%if(moobj.getNewsletter()==0)out.print(" checked "); %> value="0"/>&nbsp;No&nbsp;<font color=red>*</font>&nbsp;<span id="newsletterid"></span></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Subscription to Academic<br/>Papers Abstracts：</b></td>
			<td><input type="radio" name="abstracts"  <%if(moobj.getAbstracts()==1)out.print(" checked "); %> value="1"/>&nbsp;Yes&nbsp;
                <input type="radio" name="abstracts"   <%if(moobj.getAbstracts()==0)out.print(" checked "); %> value="0"/>&nbsp;No&nbsp;<font color=red>*</font>&nbsp;<span id="abstractsid"></span></td>
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
			<td><input type="radio" name="sex"  <%if(!pobj.isSex())out.print(" checked "); %>  value="1"/>&nbsp;Male&nbsp;
                <input type="radio" name="sex"  <%if(pobj.isSex())out.print(" checked "); %>  value="0"/>&nbsp;Female&nbsp;<font color=red>*</font></td>
		</tr>

			<tr>
			<td nowrap align="right"><b>Age：</b></td>
			<td><%
			 	for(int i=1;i<Common.AGE_TYPE.length;i++)
	                 {
			 		
	                     out.print("<input type=\"radio\" name=\"age\" value="+i);
	                     if(pobj.getAgent()==i){ 
	                    	 out.print(" checked ");
	                     }
	                     out.print(">&nbsp;"+Common.AGE_TYPE[i]);
	                 }
			 %>
             &nbsp;<font color=red>*</font>&nbsp;<span id="ageid"></span></td>
		</tr>

		<tr>
			<td nowrap align="right"><b>City：</b></td>
			<td><input type=text name="city" value="<%=pobj.getNULL(pobj.getCity(teasession._nLanguage)) %>">&nbsp;<font color=red>*</font>&nbsp;<span id="cityid"></span>
			</td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Country：</b></td>
			<td><%=new tea.htmlx.CountrySelection("Country",0,pobj.getCountry(teasession._nLanguage)) %>&nbsp;<font color=red>*</font></td>
		</tr>
		<tr>
			<td nowrap align="right"><b>Industry：</b></td>
			<td>
                            <select name="industry">

                                <%
                                    for(int i=0;i<Profile.INDUSTRY.length;i++)
                                    {
                                        out.print("<option value="+i);
                                        if(pobj.getIndustry()==i)
                                        	{
                                        		out.print(" selected ");
                                        	}
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
                                        if(pobj.getJob()==i)
                                        	{
                                        		out.print(" selected ");
                                        	}
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
                    	out.print("<input type=\"checkbox\" name=\"woid\" value="+wid);
                    	if(pobj.getWoid()!=null &&  pobj.getWoid().indexOf("/"+wid+"/")!=-1 )
                    		{
                    			out.print(" checked");
                    		}
                    	out.print(">");
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
                            out.print("<input type=\"checkbox\" name=\"woid\" value="+wid2);
                            if(pobj.getWoid()!=null &&  pobj.getWoid().indexOf("/"+wid2+"/")!=-1 )
                    		{ 
                    			out.print(" checked");
                    		}
                    	out.print(">");
                            out.print("&nbsp;"+obj2.getWoname()+"&nbsp;");
                           
                        }                                   
                    %>
                    </td>
                </tr>
                <%}%>


	</table>
<div class="submits">
<%if("en".equals(en)){ %>
<input type="button" id="submits" value="Submit" style="width:80px;height:20px;margin:10px 0;" onclick=f_sub();>
<%}else{ %>
<input type="button" id="submits" value="提交" style="width:80px;height:20px;margin:10px 0;" onclick=f_sub();>
<input type="button" id="submits2" name="reset" value="返回" style="width:80px;height:20px;margin:10px 0;" onClick="javascript:history.go(-1)">
<%} %>
</div>
</div>
</form>

</body>
</html>
