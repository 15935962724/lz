<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);


Node node=Node.find(teasession._nNode);


Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");
r.add("/tea/resource/Photography");
boolean flag1 = node.isCreator(teasession._rv);
boolean bool2=(teasession._rv != null && (flag1 || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()||teasession._rv.isManager(node.getCommunity())));

String member = "";
if(teasession._rv!=null && teasession._rv._strR.length()>0)
{
  member = teasession._rv.toString();
}

StringBuffer sql = new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?node=").append(teasession._nNode);
sql.append(" AND node=").append(teasession._nNode);

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

sql.append(" AND(  hidden = 1  or rmember="+DbAdapter.cite(session.getId())+" or rmember="+DbAdapter.cite(member)+" ) ");//显示审核通过




int count = Talkback.count(teasession._nNode);

sql.append(" ORDER BY talkback DESC ");


tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = request.getRequestURI()+"?node="+teasession._nNode;

%>
<script src="/tea/country.js"></script>
<script type="text/javascript" src="/tea/ym/ymPrompt.js"></script>
<link rel="stylesheet" id='skin' type="text/css" href="/tea/ym/skin/bluebar/ymPrompt.css" />

<script>


function f_submit1()
{

  if(form1.name.value=='')
  {
    alert('Please enter your name.');
    form1.name.focus();
    return false;
  }
  if(form1.country.value=='')
  {
    alert(' Please enter your Nationality.');
    form1.country.focus();
    return false;
  }
//  if(form1.address.value=='')
//  {
//    alert(' Please enter your Location.');
//    form1.address.focus();
//    return false;
//  }
  if(form1.vertify.value=='')
  {
    alert('Please enter your Verification code.');
    form1.vertify.focus();
    return false;
  }
  if(form1.content.value=='')
  {
    alert('<%=r.getString(0,"5216026538")%>.');
    form1.content.focus();
    return false;
  }
  form1.action="/servlet/EditTalkback";
}
function f_submit2()
{
  if(foLogin.LoginId.value=='')
  {
    alert('<%=r.getString(0,"5175695187")%>.');
    foLogin.LoginId.focus();
      return false;
  }
  if(foLogin.Password.value=='')
  {
    alert('<%=r.getString(0,"1079474851")%>.');
    foLogin.Password.focus();
       return false;
  }
}
function f_submit_3()
{

  if(foLogin_2.yonghuming.value=='')
  {
    alert('<%=r.getString(0,"5175695187")%>.');
    foLogin_2.yonghuming.focus();
    return false;
  }
  if(foLogin_2.mima.value=='')
  {
    alert('<%=r.getString(0,"1079474851")%>.');
    foLogin_2.mima.focus();
    return false;
  }
  sendx("/jsp/talkback/log_ajax.jsp?act=Talkbacks_f_submit_3&yonghuming="+foLogin_2.yonghuming.value+"&mima="+foLogin_2.mima.value,
  function(data)
  {

    if(data.trim()!='' && data.trim().length==18)
    {
       alert(data.trim());
    }else
    {
      document.getElementById("cancels").innerHTML=data.trim();
    }
  }
  );

}

function $(id)
{
	return document.getElementById(id);
}

//回复
function  huifu(igd)
{
  var strHtml  = "";

  strHtml  =strHtml+ "<FORM  name=\"foLogin_2\" METHOD=\"POST\" action=\"?\" > ";
  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0)
  {

    strHtml  =strHtml+ "<span id =cancels>";
    strHtml =strHtml+"<%=r.getString(0,"2969876073")%>：&nbsp;<input type=\"text\"   name=\"yonghuming\" value=\"\">&nbsp;&nbsp;";
    strHtml=strHtml+"<%=r.getString(0,"1602371535")%>：&nbsp;<input type=\"password\" name=\"mima\" value=\"\">&nbsp;&nbsp;";
    strHtml =strHtml+"<input  type=\"button\" value=\"<%=r.getString(0,"2592261394")%>\" onclick=\"f_submit_3();\">";
    strHtml =strHtml+" </span>";
     strHtml = strHtml+" &nbsp;<input type=\"checkbox\" name=\"tourist_sub\" id=tourist_sub2 value=1 onclick=\"f_tourist2('tourist_sub2');\">&nbsp;<%=r.getString(0,"2089063390")%>";
  }else if('<%=teasession._rv%>'!='null')
  {

    strHtml =strHtml+"<%=member%>&nbsp;|&nbsp;";
    strHtml =strHtml+"<a id=\"cancels\" href=\"/servlet/Logout?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>\" target=\"_top\"><%=r.getString(0,"5145993558")%></a>";
     strHtml = strHtml+" &nbsp;<input type=\"checkbox\" name=\"tourist_sub\" id=tourist_sub2 value=1 onclick=\"f_tourist2('tourist_sub2');\">&nbsp;<%=r.getString(0,"2089063390")%>";
  }


     strHtml =strHtml+" </FORM> ";

  strHtml =strHtml+"<FORM  name=\"foLogin_3\" METHOD=\"POST\" action=\"/servlet/EditTalkbackReply\">";
  strHtml =strHtml+"<input type=hidden name=talkback id=talkbackid value="+igd+">";

  strHtml =strHtml+"<input type=hidden name=nexturl value=<%=nexturl%>>";
   strHtml =strHtml+" <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"tablecen3\">";


  	strHtml =strHtml+"<tr><td align=right>Name：</td><td><input type=text id=nameid name=name></td></tr>";
   	strHtml =strHtml+"<tr><td align=right>Country/Area：</td><td><input type=text id=countryid name=country></td></tr>";
    strHtml =strHtml+"<tr><td align=right>Content：</td><td><TEXTAREA NAME=\"reply\" id=replyid COLS=40 ROWS=4 class=\"edit_input\"></TEXTAREA></td></tr>";

    strHtml =strHtml+"<tr><td align=right>Verification code：</td><td><img src=\"/NFasts.do?act=verify\" id=\"vcodeImg2\" alt=\"Click to change the identifying code\"  style=\"cursor:pointer\" align=\"absmiddle\" class=\"CodeImg\" onClick=\"reloadVcode2();\">";
    strHtml =strHtml+"&nbsp;<input type=\"TEXT\"  name=vertify id=vertifyid  size=\"5\" /></td></tr>";
  strHtml =strHtml+ "</table>";

  strHtml =strHtml+"</FORM>";

  //语言层
  ymPrompt.setDefaultCfg({title:'Default Title', message:"Default Message",okTxt:' OK ',cancelTxt:' Cancel ',closeTxt:'Close',minTxt:'Minimize',maxTxt:'Maximize'});


  //ymPrompt.win({message:strHtml,width:510,height:300,title:'Reply',handler:sAlert_submit,btn:[['是','yes'],['否','no']],msgCls:'customCls'});
 ymPrompt.confirmInfo({icoCls:'',msgCls:'confirm',message:strHtml,title:'Reply',width:510,height:270,handler:sAlert_submit,autoClose:false});

  //sAlert(strHtml,"<%=r.getString(0,"6948521657")%>","<input type=\"button\" value=\"<%=r.getString(0,"Submit")%>\" id=\"do_OK\" onclick=\"sAlert_submit()\" />&nbsp; <input type=\"button\" value=\"<%=r.getString(0,"1315968283")%>\" id=\"do_OK\" onclick=\"doOk()\" />");
}
//提交回复
function sAlert_submit(tp)
{
	//alert($('tdddd').value);
	if(tp!='ok') return ymPrompt.close();
	var v=$('replyid').value;
	var v1=$('vertifyid').value;

	if(v==''){
		  alert('<%=r.getString(0,"9594605981")%>!');
	}else if (v1==''){
		alert('Sorry! Please enter your Verification code!');
	}
	else{


		sendx("/jsp/admin/edn_ajax.jsp?act=replysubmit&name="+encodeURIComponent($("nameid").value)+"&country="+encodeURIComponent($("countryid").value)+"&reply="+encodeURIComponent($("replyid").value)+"&talkback="+$("talkbackid").value+"&vertify="+$("vertifyid").value,
		 function(data)
		 {

		  data = data.trim();

		   if(data!=''&&data.length>0)//如果有这个用户  则写入Cookie
		   {
				if(data=='1')//验证码错误
				{
					alert('Sorry! There\'s an error in the verification code. Please add-up the numbers again!');
					reloadVcode2();

				}else if(data=='2')
				{
					alert('Your comment has been submitted successfully!');
					window.location.reload();
					ymPrompt.close();
				}

		   }
		 }
		 );




		// foLogin_3.action='/servlet/EditTalkbackReply';
 		// foLogin_3.submit();
		// ymPrompt.close();
	}
	/*
		  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0&&!foLogin_2.tourist_sub.checked)
		  {
		     alert('<%=r.getString(0,"0070206976")%>');
		     foLogin_2.yonghuming.focus();
		    return false;
		  }
		  if(<%=( node.getOptions() & 0x8000)%>==0){
			  if(foLogin_2.tourist_sub.checked)
			  {
				  foLogin_3.tourist2.value=1;
			  }else
			  {
				  foLogin_3.tourist2.value='';
			  }
		  }

		  if($('replyid').value=='')
		  {
		    alert('<%=r.getString(0,"9594605981")%>!');
		    //foLogin_3.reply.focus();
		    return false;
		  }


		  foLogin_3.action='/servlet/EditTalkbackReply';
		  foLogin_3.submit();
		  */

}
function f_tourist(igd)
{
	var obj = document.getElementById(igd);
	if(obj.checked){
		document.getElementById("loginid").style.display='none';
		form1.tourist.value=1;

	}else{
		document.getElementById("loginid").style.display='';
		form1.tourist.value='';
	}
}
function f_tourist2(igd)
{
	var obj = document.getElementById(igd);
	if(obj.checked){
		//document.getElementById("loginid").style.display='none';

	}else{
		//document.getElementById("loginid").style.display='';
	}
}

</script>
<%=new tea.ui.TeaServlet().getSections(teasession._nNode,teasession._nStatus,teasession._rv, teasession._nLanguage, 10, false)%>


<div class="hn"><%=r.getString(0,r.getString(0,"6533046079")+":<a href=\"/html/report/"+teasession._nNode+"-"+teasession._nLanguage+".htm\" target=\"top\">"+node.getSubject(teasession._nLanguage))%></a></div>



  <table border="0" cellpadding="0" cellspacing="0" id="tablecen3">
    <tr  id=trcen1>
    <%
    if(teasession._rv == null&&(node.getOptions() & 0x8000) == 0)
    {
      //response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
      // return;

      %>
      <FORM target="_parent" name="foLogin" METHOD="POST" action="/servlet/Login" onSubmit="return f_submit2();">
        <input type='hidden' name="nexturl" VALUE="<%=nexturl%>"/>
        <input type='hidden' name="community" VALUE="<%=teasession._strCommunity%>"/>
         <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>"/>
      <td colspan="2" id="sbmbox" >
      <span id="loginid"><%=r.getString(0,"2969876073") %>：&nbsp;<input name="LoginId" type="text" size="16" id="text">
      &nbsp;&nbsp;<%=r.getString(0,"1602371535") %>：&nbsp;<input name="Password" type="password" size="16">
      &nbsp;&nbsp;
      <input type="submit" id="submits" value="<%=r.getString(0,"2592261394") %>"/> </span>
      &nbsp;<span id="tourist_subid"><input type="checkbox" name="tourist_sub" value="1" id="tourist_sub" checked="checked"  onClick="f_tourist('tourist_sub');">&nbsp;<%=r.getString(0,"2089063390")%>     </span> </td>
      </form>
   <%
 }else if(teasession._rv!=null)
 {
   out.print(" <FORM  name=foLogin>   <span id=loginid></span>");
   out.println("<td colspan=2>");
   out.print(""+teasession._rv.toString()+"&nbsp;|&nbsp;<a id=\"cancels\" href=\"/servlet/Logout?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&node="+teasession._nNode+"\" target=\"_top\">"+r.getString(0,"5145993558")+"</a>");
   out.print("&nbsp;<span id=tourist_subid><input type=\"checkbox\" checked name=\"tourist_sub\" id=tourist_sub value=1 onclick=\"f_tourist('tourist_sub');\">&nbsp;"+r.getString(0,"2089063390")+"</span>");
   out.print("</td>");
   out.print("</form>");
 }
   %>
    </tr>


    <FORM NAME="form1" METHOD=POST onSubmit="return f_submit1();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
   <input type='hidden' name='act' value="fa_en">
   <input type='hidden' name='tourist' value='1'>
   <input type='hidden' name='subject' value='主题'>
    <tr><td id="Name" align="right">Name：</td> <td><input type="text" name="name" value=""></td>  </tr>
    <tr><td id="Nat" align="right">Nationality：</td><td><script>mt.country('country',null,"Nationality");</script></td></tr>
    <!-- <tr class="nons"><td id="Loca" align="right">Location：</td> <td class="inputnone"><input type="text" name="address" value=""></td></tr> -->
      <tr>
        <td  align="right" id="con"><%=r.getString(0, "Content")%>：</td>
        <td><textarea id="status"   name="content" cols=60 rows=8 class="edit_input" onKeyDown='countChar("status","counter");' onKeyUp='countChar("status","counter");'></textarea></td>
      </tr>
      <tr>
      <td align="right">&nbsp;</td>
        <td><%=r.getString(0,"4738711624") %><span id="counter"> 6,000 </span><%=r.getString(0,"1810120135") %></td>
      </tr>
       <tr>
        <td align="right"><%=r.getString(0, "2549850593")%>：</td>
        <td><img src="/NFasts.do?act=verify&r=<%=new Date().getTime()%>" id="vcodeImg1" alt="<%=r.getString(0,"4795430490") %>"  style="cursor:pointer" align="absmiddle" class="CodeImg" onClick="reloadVcode1();">&nbsp;
        <input type="TEXT"  name=vertify value="" size="5" /><a href="###"   style="cursor:pointer"  onClick="reloadVcode1();">&nbsp;&nbsp;If the code is not clear, please click here for a new code.</a><!-- &nbsp;&nbsp;Messages that harass,abuse or threaten others;have obscene or otherwise objectionable content;have commercial or advertising content or links may be removed. --> <!--<%=r.getString(0,"4249463039") %> &nbsp;(<%=r.getString(0,"0207031817") %>)--></td>
      </tr>
      <tr><td></td><td></td></tr>
      <script language="javascript">
         function reloadVcode1()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg1');
           if(vcode)vcode.setAttribute('src','/NFasts.do?act=verify&r='+Math.random());
         }
         function reloadVcode2()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg2');
           if(vcode)vcode.setAttribute('src','/NFasts.do?act=verify&r='+Math.random());
         }
         function countChar(textareaName,spanName)//统计剩余字数
         {

           if(document.getElementById(textareaName).value.length > 6000){
             alert("<%=r.getString(0,"3513810607")%>6000");
             document.getElementById(spanName).innerHTML = 0;
           }else{
             document.getElementById(spanName).innerHTML = 6000 - document.getElementById(textareaName).value.length;
           }
         }
        reloadVcode1();
        reloadVcode2();
      </script>
      <tr>
	  <td>&nbsp;</td>
      <td class="submit"><input type="submit" value="<%=r.getString(0,"Submit") %>" /></td>
       </tr>
    </form>
</table>
<div class="tablecen1">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecen1" >
  <%


  java.util.Enumeration e = Talkback.find(sql.toString(), pos, size);
  if(!e.hasMoreElements())
  {
      out.print("<tr><td colspan=10 align=center>"+r.getString(0,"5663756403")+"</td></tr>");
  }
  for(int i=1;e.hasMoreElements();i++)
  {
    int tbid = ((Integer)e.nextElement()).intValue();
    Talkback obj = Talkback.find(tbid);
    RV rv = obj.getCreator();
    String creator=obj.getIp();

    if(rv._strR!=null && rv._strR.length()>0 &&  !"<ANONYMITY>".equals(rv._strR) )
    {

    	tea.entity.member.Profile pobj = tea.entity.member.Profile.find(rv._strR);
    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);

    	if(pname!=null && pname.length()>0)
    	{
    		creator = pname;
    	}else
    	{
    	    creator=rv._strR;
    	}

	     if(creator.length()==32)
	     {
	    	  creator=r.getString(0,"2089063390");
	     }

    }

    String subject=obj.getSubject(teasession._nLanguage);//主题
    String conten=obj.getContent(teasession._nLanguage);//内容


    %>
    <tr  id=tableone1>
      <td style="border-right:0px;"><span class="Username"><%=Entity.getNULL(obj.getName(1)) %></span><span class="Froms">From&nbsp;<%=Entity.getNULL(obj.getAddress(1)) %></span>　　<span class="time"><%=Talkback.sdf_en.format(obj.getTime()) %></span></td>
    </tr>
    <!--
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';>
      <td colspan="2"><%=subject%>&nbsp;&nbsp;<img src="/tea/image/hint/<%=obj.getHint()%>.gif"></td>
    </tr>
     -->
    <tr class="con">
      <td><div class="con_hh"><img src="/tea/image/hint/<%=obj.getHint()%>.gif">&nbsp;&nbsp;<%=conten%></div>
      <div class="huifu"><a href="#"  onclick="huifu('<%=tbid%>');"><%=r.getString(0,"6948521657") %></a></div>
      </td>
    </tr>
    <%
    java.util.Enumeration e2 = TalkbackReply.findByTalkback(tbid);

    if(e2.hasMoreElements()){
    %>
       <tr>
      <td colspan="3" align="center">
        <table border="0" cellpadding="0" cellspacing="0" id="tablecen2">
        <%

        for(int j = 1;e2.hasMoreElements();j++)
        {
          int trid = ((Integer)e2.nextElement()).intValue();
          TalkbackReply trobj = TalkbackReply.find(trid);
          String trmember =r.getString(0,"2089063390");

          if(trobj.getMember()!=null && trobj.getMember().length()>0)
          {
        	 tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(rv._strR);
          	String pname2 = pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage);
          	if(pname2!=null && pname2.length()>0)
        	{
          		trmember = pname2;
        	}else{
        		trmember = trobj.getMember();

        	}

             if(trmember.length()==32){
            	 trmember = r.getString(0,"2089063390");
             }
          }

         %>
        <tr class="huifuren">
            <td><%=j%>&nbsp;<span class="Username"><%=Entity.getNULL(trobj.getName()) %></span>　　From&nbsp;<%=trobj.getNULL(trobj.getCountry()) %>　　<%=Talkback.sdf_en.format(trobj.getTime()) %></td>
          </tr>
          <tr class="huifutext">
           <td><%=trobj.getText()%></td>
          </tr>
          <%}%>
        </table>
     </td>
    </tr>
    <%} %>


    <%} %>

    <%if (count > size) {  %>
    <tr> <td colspan="10" align="right"><%=new tea.htmlx.FPNL(0,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
    <%}  %>



</table></div>

