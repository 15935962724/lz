<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.cfw.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();
if(teasession.getParameter("nexturl")!=null && teasession.getParameter("nexturl").length()>0)
{
	nexturl = teasession.getParameter("nexturl");
}
int mrid = 0;
if(teasession.getParameter("mrid")!=null && teasession.getParameter("mrid").length()>0)
{
	mrid = Integer.parseInt(teasession.getParameter("mrid"));
}

MemberRegister mrobj = MemberRegister.find(mrid);


%>
<script>
	function f_submit()
	{
		if(form1.names.value=='')
		{
			alert('姓名/Name不能为空');
			form1.names.focus();
			return false;
		}
		if(form1.birthdate.value=='')
		{
			alert('出生日期/Birth date不能为空');
			form1.birthdate.focus();
			return false;
		}

		if(form1.occupation.value=='')
		{
			//alert('职业/Occupation不能为空');
			//form1.occupation.focus();
			//return false;
		}
		if(form1.conporation.value=='')
		{
			//alert('所属机构/Conporation不能为空');
			//form1.conporation.focus();
			//return false;
		}
		if(form1.mobile.value=='')
		{
			alert('移动电话/Mobile No不能为空');
			form1.mobile.focus();
			return false;
		}else
		{
			 var string_value =form1.mobile.value;
			 var type="^\s*[+-]?[0-9]+\s*$";
			 var re = new RegExp(type);

			   if(string_value.match(re)==null)
			   {

			     alert("手机号码有误,请确认.");
			     form1.mobile.focus();
			     return false;
			   }
			  if(string_value.length!=11)
			   {

				     alert("手机号码有误,请确认.");
				     form1.mobile.focus();
				     return false;
			   }
		}
		if(form1.tel.value=='')
		{
			//alert('固定电话/Tel No不能为空');
			//form1.tel.focus();
			//return false;
		}
		if(form1.email.value=='')
		{
			//alert("电子邮箱/E-mail不能为空");
			//form1.email.focus();
			//return false;
		}else
		{
			var temp = document.getElementById("email");
			  //对电子邮件的验证
			  var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			  if(!myreg.test(temp.value))
			  {
			    //alert('请输入有效的E_mail！');
			    //document.form1.email.focus();

			    //return false;
			  }
		}

		if(form1.fax.value=='')
		{
			//alert('传真/Fax不能为空');
			//form1.fax.focus();
			//return false;
		}
		if(form1.address.value=='')
		{
			//alert('邮寄地址/Mailing address不能为空');
			//form1.address.focus();
			//return false;
		}
		if(form1.postalcode.value=='')
		{
			//alert('邮编/Postal code不能为空');
			//form1.postalcode.focus();
			//return false;
		}else
		{
			var string_value =form1.postalcode.value;
			 var type="^\s*[+-]?[0-9]+\s*$";
			 var re = new RegExp(type);

			   if(string_value.match(re)==null)
			   {

			     //alert("邮编/Postal code有误,请确认.");
			     //form1.mobile.focus();
			     //return false;
			   }
			  if(string_value.length!=6)
			   {

				     //alert("邮编/Postal code,请确认.");
				     //form1.mobile.focus();
				    // return false;
			   }


		}
		if(form1.favorite.value=='')
		{
			//alert("喜爱的艺术家/Favorite artists不能为空");
			//form1.favorite.focus();
			//return false;
		}
		if((form1.activity.length+"")=="undefined")
		{
	 	 		if(!form1.activity.checked)
	 	 		{
	 	 			//alert("请选择您最期望中国书画艺术沙龙举办什么样的活动");
					//return false;
	 	 	 	}

	 	 }else
	 	 {
			    var f = false;
			    for (var i=0; i< form1.activity.length; i++)
			    {
			      if (form1.activity[i].checked)
			      {
				      f = true;
				  }
			    }
			    if(!f)
			    {
					//alert("请选择您最期望中国书画艺术沙龙举办什么样的活动");
					//return false;
			    }
	 	 }


		if(form1.membersignature.value=='')
		{
			//alert("会员签名/Signature menbers不能为空");
			//form1.membersignature.focus();
			//return false;
		}
		if(form1.signature.value=='')
		{
			alert("日期/Date不能为空");
			form1.membersignature.focus();
			return false;
		}

	}

</script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<form action="/jsp/type/cfw/MemberRegisterServlet.jsp" name="form1" method="POST" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="act" value="MemberRegister">
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="mrid" value="<%=mrid %>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
	      <td colspan="2" class="td"><div>姓　　名/Name</div><input type="text" name="names" value="<%if(mrobj.getNames()!=null)out.print(mrobj.getNames()); %>"/></td>
    </tr>
     <tr>
	      <td class="td"><div>性　　别/Gender</div><select name="gender">
	      		<option value="1" <%if(mrobj.getGender()==1)out.println(" selected "); %>>--男--</option>
	      		<option value="2" <%if(mrobj.getGender()==2)out.println(" selected "); %>>--女--</option>
	      	</select>
	      </td>
	      <td class="td02"><div>出生日期/Birth date</div><input id="birthdate" name="birthdate" size="7"  value="<%if(mrobj.getBirthdate()!=null)out.print(mrobj.getBirthdateToString()); %>">
          <!--<img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.birthdate');" />--></td>
    </tr>

      <tr>
	      <td class="td"><div>职　　业/Occupation</div><input type="text" name="occupation" value="<%if(mrobj.getOccupation()!=null)out.print(mrobj.getOccupation()); %>"/></td>
	      <td class="td"><div>所属机构/Conporation</div><input type="text" name="conporation" value="<%if(mrobj.getConporation()!=null)out.print(mrobj.getConporation()); %>"/></td>
    </tr>
      <tr>
	      <td class="td"><div>移动电话/Mobile No</div><input type="text" name="mobile" value="<%if(mrobj.getMobile()!=null)out.print(mrobj.getMobile()); %>"/></td>
	      <td class="td"><div>固定电话/Tel No</div><input type="text" name="tel" value="<%if(mrobj.getTel()!=null)out.print(mrobj.getTel()); %>"/></td>
    </tr>
      <tr>
	      <td class="td"><div>电子邮箱/E-mail</div><input type="text" name="email" id="email" value="<%if(mrobj.getEmail()!=null)out.print(mrobj.getEmail()); %>"/></td>
	      <td class="td"><div>传　　真/Fax</div><input type="text" name="fax" value="<%if(mrobj.getFax()!=null)out.print(mrobj.getFax()); %>"/></td>
    </tr>
      <tr>
	      <td colspan="2" class="td01">邮寄地址/Mailing address&nbsp;&nbsp;<input type="text" name="address" value="<%if(mrobj.getAddress()!=null)out.print(mrobj.getAddress()); %>"/></td>
    </tr>
      <tr>
	      <td colspan="2" class="td03">邮编/Postal code&nbsp;&nbsp;<input type="text" name="postalcode" value="<%if(mrobj.getPostalcode()!=null)out.print(mrobj.getPostalcode()); %>"/></td>
    </tr>
      <tr>
	      <td  colspan="2" class="td04">喜爱的艺术家/Favorite artists&nbsp;&nbsp;<input type="text" name="favorite" value="<%if(mrobj.getFavorite()!=null)out.print(mrobj.getFavorite()); %>"/></td>

    </tr>
     <tr>
	      <td colspan="2" class="td05">
           <table><tr><td colspan="2">您最期望中国书画艺术沙龙举办什么样的活动?(请打"√")</td></tr>
         <tr><td colspan="2">Which kind of Art Salon activity will interest you the most?</td></tr>

    <%


    	for(int i=0;i<MemberRegister.ACTIVITY_TYPE.length;i++)
    	{
    		if(i%2==0)
    		{
    			out.print("<tr>");
    		}
    		out.print("<td>");
    		out.print(" <input type=\"checkbox\" name=\"activity\" value= "+i);
    		if(mrobj.getActivity()!=null && mrobj.getActivity().indexOf("/"+i+"/")!=-1)
    		{
    			out.print(" checked = true ");
    		}


    		out.print(">&nbsp;"+MemberRegister.ACTIVITY_TYPE[i]);

    		out.print("</td>");
    		if(i%2==1)
    		{
    			out.print("</tr>");

    		}

    	}

    %>
    </table>
    </td></tr>
      <tr>
	      <td class="td06">会员签名/Signature menbers&nbsp;&nbsp;<input type="text" name="membersignature" value="<%if(mrobj.getMembersignature()!=null)out.print(mrobj.getMembersignature()); %>"/></td>
	      <td class="td02">日期/Date&nbsp;&nbsp;<input id="signature" name="signature" size="7"  value="<%if(mrobj.getSignatureToString()!=null)out.print(mrobj.getSignatureToString()); %>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.signature');" /></td>
    </tr>
    </table>
      <div class="ArtsSalon">以下由艺术沙龙秘书处填写/The following fill in the Secretariat by the Arts Salon:</div>
 <table border="0" cellpadding="0" cellspacing="0"  id="tablecenter02">
     <tr>
	      <td class="td01">会员标准：&nbsp;<span>800元</span></td>
	      <td class="td01">卡号：&nbsp;</td>
    </tr>
    <tr>
	      <td colspan="2" class="td02">有效日期：&nbsp;年  月  日 至 年 月 日</td>
    </tr>

     <tr>
	      <td colspan="2">
          <table border="0" cellpadding="0" cellspacing="0" >
          <tr><td class="td03">经办人：&nbsp;</td><td class="td04">财务确认：&nbsp;</td><td class="td05">主任意见：&nbsp;</td>
    		</tr>
        </table>
    </td>
</tr>
  </table>
  <div class="button"><input class="submit" type="submit" value=""/>&nbsp;<input class="reset" type="reset" value=""/></div>
</form>
</body>
</html>
