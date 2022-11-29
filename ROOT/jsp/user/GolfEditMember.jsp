
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%@page import="tea.resource.*" %><%


Http h=new Http(request);
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
h.member=teasession._rv.toString();

Profile p=Profile.find(h.member);
ProfileBBS pb=ProfileBBS.find(h.community,h.member);

if("POST".equals(request.getMethod()))
{

 
  
  String titles=h.get("titles");
  String mobile=h.get("mobile");
  String membername=h.get("membername");
  int sex = h.getInt("sex");

  String card =h.get("card");
  String email=h.get("email");
  String address =h.get("address");
  
  	Profile pobj = Profile.find(teasession._rv.toString());
	
  	
	ProfileBBS pbobj = ProfileBBS.find(teasession._strCommunity,teasession._rv.toString());
	if(!pbobj.getTitle(teasession._nLanguage).equals(titles)||"游客".equals(titles))
	{
		//如果是修改
		if(Profile.isExisted(ProfileBBS.getMember(teasession._strCommunity, titles)))
		{
			//昵称存在
			out.print("<script>alert('"+r.getString(teasession._nLanguage, "Nicknamealreadyexists")+"');history.go(-1);</script>");
		    return;
		}
	}
	if(!pobj.getMobile().equals(mobile))
	{
		//如果是修改
		if(Profile.isExisted(Profile.getMobile(mobile, teasession._strCommunity)))
		{
			//手机
			out.print("<script>alert('"+r.getString(teasession._nLanguage, "Mobilephonealreadyexists")+"');history.go(-1);</script>");
		    return;
		}
	}

  pb.set(h.language,titles,pb.getPortrait(h.language),h.get("signature"));
  p.setMobile(mobile);
  p.setFirstName(membername, h.language);
  p.setSex(sex==0?true:false);
  p.setCard(card);
  p.setEmail(email);
  p.setAddress(address,h.language);
  out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" type=\"\"></SCRIPT>");
  out.print("<link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">");
  out.print("<script> ymPrompt.win({message:'<br><center>"+r.getString(teasession._nLanguage, "Informationisaddedsuccessfully")+"</center>',title:'',width:'300',height:'50',titleBar:false});");
  out.print("setTimeout(function(){history.go(-1);},1000);</script>");
  return;
}
  
%>



<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_alert()
{
	alert('ddd');
}
function $(igd)
{
	return document.getElementById(igd);
}
	function f_gesubmt()
	{
		
		if(formgem.titles.value=='')
		{
			$('titleshow').innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefilloutthenickname")%></font>';
			formgem.titles.focus();
			return false;
		}
		$('titleshow').innerHTML='';
		
		//手机昵称
		 sendx("/jsp/admin/edn_ajax.jsp?act=GolfEditMember&titles="+formgem.titles.values+"&mobile="+formgem.mobile.value,
			 function(data)
			 {
			   if(data!=''&&data.length>1)//
			   { 
					data = data.trim();
					
					if(data.split("/")[1]=='f')
					{
						$('titleshow').innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Thenicknameisalreadytakenpleaserefill")%></font>';
						formgem.titles.focus();
						return false;
					}else if(data.split("/")[2]=='f')
					{
						$('mobileshow').innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Thephonenumberhasbeenoccupiedrefill")%></font>';
						formgem.mobile.focus();
						return false;
					}
					$('titleshow').innerHTML='';
					$('mobileshow').innerHTML='';
					f_s();
					
					formgem.submit();
				   
			   }
			 }
		);

	}
	function f_s()
	{
		if(formgem.card.value!=''&&!isIdCardNo(formgem.card.value))
		{
			$('cardshow').innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "IDnumberofthformatisnotcorrectpleaserefill")%></font>'
			return false;
		}
		$('cardshow').innerHTML='';
		
		 var str = formgem.email.value;
	      strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
	      r=str.search(strReg);
	      if(str!=''&& r==-1){
	       
	        $("emailshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Emailaddressformatisincorrectpleaserefill")%></font>'; 
	        formgem.email.focus();
	        return false;
	      }
	      $("emailshow").innerHTML=''; 

	}
 
</script>


<form method="POST" action="?" name="formgem">
<input type="hidden" name="community" value="<%=h.community%>"/>

<div id="TabMyPro">
<div class="title"><%=r.getString(teasession._nLanguage, "Basicpersonalinformation")%></div>
<div class="con">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
<tr id="tableonetr">
    <td colspan="3" align="left" ><%=r.getString(teasession._nLanguage, "Basicinformation")%></td>
    </tr>
  
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Nickname")%>：</td>
    <td width="231" ><input name="titles" value="<%=pb.getTitle(h.language)%>" alt="<%=r.getString(teasession._nLanguage, "Nickname")%>"><span id="titleshow"></span></td>
    <td width="166" rowspan="6" id="TabTimg">
    
    <div><img src="<%=pb.getPortrait(h.language)%>" /><br>
<a href="#" onclick="mt.show('/jsp/custom/westrac/MemberSetAvatar.jsp',2,'<%=r.getString(teasession._nLanguage, "EdityourAvatar")%>',450,277)"><%=r.getString(teasession._nLanguage, "UploadAvatar")%></a></div>
    
    </td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "Phonenumber")%>：</td>
    <td><input name="mobile" value="<%=p.getMobile() %>" alt="<%=r.getString(teasession._nLanguage, "Phonenumber")%>"><span id="mobileshow"></span></td>
    </tr>
  
  <tr id="tableonetr">
    <td colspan="2" class="td02"><%=r.getString(teasession._nLanguage, "Formoreinformation")%></td>
       </tr>
  
  <tr>
    <td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Name")%>：</td>
    <td id="input"><input name="membername" value="<%=p.getFirstName(h.language)%>"></td>
    </tr>
     <tr>
    <td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Gender")%>：</td>
    <td>
      <input type="radio" name="sex" value="0" <%if(p.isSex()){out.print(" checked");} %>>&nbsp;<%=r.getString(teasession._nLanguage, "Male")%>&nbsp;&nbsp;
      <input type="radio" name="sex" value="1"  <%if(!p.isSex()){out.print(" checked");} %>>&nbsp;<%=r.getString(teasession._nLanguage, "Female")%>
      
    </td>
    </tr>
     <tr>
    <td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "IDnumber")%>：</td>
    <td  id="input"><input name="card" value="<%=p.getCard()%>"><span id="cardshow"></span></td>
    </tr>
      <tr>
    <td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Mailbox")%>：</td>
    <td colspan="2"  id="input"><input name="email" value="<%=p.getEmail()%>"><span id="emailshow"></span></td>
    </tr>	
      <tr>
    <td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "address")%>：</td>
    <td colspan="2"  id="input"><input name="address" value="<%=p.getAddress(h.language)%>"></td>
    </tr>	
    
    	
   <tr>
    <td colspan="2" align="center" id="button"><input type="button" value="" class="submit" onclick="f_gesubmt();"></td>
    <td align="right"></td>
  </tr>
</table>

</div></div>
</form>
