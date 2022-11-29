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
String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();

%>

<html>
	<head>
<link href="/res/<%=teasession._strCommunity %>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/tea/mt.js"></script>
	
<script>
function f_submit1()
{
  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0&&!foLogin.tourist_sub.checked)
  {
     alert('<%=r.getString(teasession._nLanguage,"0070206976")%>');
     foLogin.LoginId.focus();
    return false;
  }
  if(form1.subject.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"5568315361")%>.');
    form1.subject.focus();
    return false;
  }
  if(form1.content.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"5216026538")%>.');
    form1.content.focus();
       return false;
  }
}
function f_submit2()
{
  if(foLogin.LoginId.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"5175695187")%>.');
    foLogin.LoginId.focus();
      return false;
  }
  if(foLogin.Password.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"1079474851")%>.');
    foLogin.Password.focus();
       return false;
  }
}
function f_submit_3()
{

  if(foLogin_2.yonghuming.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"5175695187")%>.');
    foLogin_2.yonghuming.focus();
    return false;
  }
  if(foLogin_2.mima.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"1079474851")%>.');
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

//回复
function  huifu(igd)
{
  var strHtml  = "";
  strHtml  =strHtml+ "<FORM  name=\"foLogin_2\" METHOD=\"POST\" action=\"?\" > ";
  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0)
  {
    strHtml  =strHtml+ "<span id =cancels>";
    strHtml =strHtml+"<%=r.getString(teasession._nLanguage,"2969876073")%>：&nbsp;<input type=\"text\"   name=\"yonghuming\" value=\"\">&nbsp;&nbsp;";
    strHtml=strHtml+"<%=r.getString(teasession._nLanguage,"1602371535")%>：&nbsp;<input type=\"password\" name=\"mima\" value=\"\">&nbsp;&nbsp;";
    strHtml =strHtml+"<input  type=\"button\" value=\"<%=r.getString(teasession._nLanguage,"2592261394")%>\" onclick=\"f_submit_3();\">";
    strHtml =strHtml+" </span>";
     strHtml = strHtml+" &nbsp;<input type=\"checkbox\" name=\"tourist_sub\" id=tourist_sub2 value=1 onclick=\"f_tourist2('tourist_sub2');\">&nbsp;<%=r.getString(teasession._nLanguage,"2089063390")%>";
  }else if('<%=teasession._rv%>'!='null')
  {

    strHtml =strHtml+"<%=member%>&nbsp;|&nbsp;";
    strHtml =strHtml+"<a id=\"cancels\" href=\"/servlet/Logout?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>\" target=\"_top\"><%=r.getString(teasession._nLanguage,"5145993558")%></a>";
     strHtml = strHtml+" &nbsp;<input type=\"checkbox\" name=\"tourist_sub\" id=tourist_sub2 value=1 onclick=\"f_tourist2('tourist_sub2');\">&nbsp;<%=r.getString(teasession._nLanguage,"2089063390")%>";
  }

     strHtml =strHtml+" </FORM> ";

  strHtml =strHtml+"<FORM  name=\"foLogin_3\" METHOD=\"POST\" action=\"/servlet/EditTalkbackReply\">";
  strHtml =strHtml+"<input type=hidden name=talkback value="+igd+">";
    strHtml =strHtml+"<input type=hidden name=tourist2>";
  strHtml =strHtml+"<input type=hidden name=nexturl value=<%=nexturl%>>";
  strHtml =strHtml+ "<TEXTAREA NAME=\"reply\" COLS=60 ROWS=8 class=\"edit_input\"></TEXTAREA>";
  strHtml =strHtml+"</FORM>";

  sAlert(strHtml,"<%=r.getString(teasession._nLanguage,"6948521657")%>","<input type=\"button\" value=\"<%=r.getString(teasession._nLanguage,"Submit")%>\" id=\"do_OK\" onclick=\"sAlert_submit()\" />&nbsp; <input type=\"button\" value=\"<%=r.getString(teasession._nLanguage,"1315968283")%>\" id=\"do_OK\" onclick=\"doOk()\" />");
}
//提交回复
function sAlert_submit()
{

  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0&&!foLogin_2.tourist_sub.checked)
  {
     alert('<%=r.getString(teasession._nLanguage,"0070206976")%>');
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
  if(foLogin_3.reply.value=='')
  {
    alert('<%=r.getString(teasession._nLanguage,"9594605981")%>!');
    foLogin_3.reply.focus();
    return false;
  }


  foLogin_3.action='/servlet/EditTalkbackReply';
  foLogin_3.submit();
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
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script>mt.fit();</script>
</head>
<body id="NodeCommentid">
<%=new tea.ui.TeaServlet().getSections(Node.find(teasession._nNode),teasession._nStatus,teasession._rv, teasession._nLanguage, 10, false)%>



<h1><%=r.getString(teasession._nLanguage,r.getString(teasession._nLanguage,"6533046079")+":<a href=\"/html/report/"+teasession._nNode+"-"+teasession._nLanguage+".htm\" target=\"top\">"+node.getSubject(teasession._nLanguage))%></a></h1>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecen1" >
  <%


  java.util.Enumeration e = Talkback.find(sql.toString(), pos, size);
  if(!e.hasMoreElements())
  {
      out.print("<tr><td colspan=10 align=center>"+r.getString(teasession._nLanguage,"5663756403")+"</td></tr>");
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
	    	  creator=r.getString(teasession._nLanguage,"2089063390");
	     }

    }

    String subject=obj.getSubject(teasession._nLanguage);//主题
    String conten=obj.getContent(teasession._nLanguage);//内容


    %>
    <tr  id=tableone1>
      <td class="creator"><%=r.getString(teasession._nLanguage,"5582766512") %>：<span><%=creator %></span></td>
      <td align="right"><%=Talkback.sdf3.format(obj.getTime()) %>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage,"3889150508") %></td>
    </tr>
    <!--
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';>
      <td colspan="2"><%=subject%>&nbsp;&nbsp;<img src="/tea/image/hint/<%=obj.getHint()%>.gif"></td>
    </tr>
     -->
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';>
      <td colspan="2" class="content"><img src="/tea/image/hint/<%=obj.getHint()%>.gif">&nbsp;&nbsp;<%=conten%></td>
    </tr>
    <%
    java.util.Enumeration e2 = TalkbackReply.findByTalkback(tbid);

    if(e2.hasMoreElements()){
    %>
       <tr>
      <td colspan="2" align="center">
        <table border="0" cellpadding="0" cellspacing="0" id="tablecen2">
        <%

        for(int j = 1;e2.hasMoreElements();j++)
        {
          int trid = ((Integer)e2.nextElement()).intValue();
          TalkbackReply trobj = TalkbackReply.find(trid);
          String trmember =r.getString(teasession._nLanguage,"2089063390");

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
            	 trmember = r.getString(teasession._nLanguage,"2089063390");
             }
          }

         %>
        <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
            <td class="tablecen2creator"><%=j%>&nbsp;&nbsp;<%=r.getString(teasession._nLanguage,"5582766512") %>&nbsp;<span><%=trmember%></span>&nbsp;<%=r.getString(teasession._nLanguage,"4265227904") %>：</td>
              <td align="right"><%=Talkback.sdf3.format(trobj.getTime()) %>&nbsp;</td>
          </tr>
          <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';>
           <td colspan="2" class="tablecen2Con"><%=trobj.getText()%></td>
          </tr>
          <%}%>
        </table>
     </td>
    </tr>
    <%} %>

      <tr>
      <td align="right" colspan="2"  class="huifu"><a href="#"  onclick="huifu('<%=tbid%>');"><%=r.getString(teasession._nLanguage,"6948521657") %></a></td>
    </tr>
    <%} %>

    <%if (count > size) {  %>
    <tr> <td colspan="10" align="right"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
    <%}  %>

    <tr>
      <td colspan="2" class="tip" valign="middle"><%=r.getString(teasession._nLanguage,"5666186480") %>。</td>
    </tr>

</table>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecen3">
    <tr class="tr01">
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
      <td colspan="2">
      <span id="loginid"><%=r.getString(teasession._nLanguage,"2969876073") %>：&nbsp;<input name="LoginId" type="text" size="16">
      &nbsp;&nbsp;<%=r.getString(teasession._nLanguage,"1602371535") %>：&nbsp;<input name="Password" type="password" size="16">
      &nbsp;&nbsp;
      <input type="submit" class="logBtn" value="<%=r.getString(teasession._nLanguage,"2592261394") %>"/> </span>
      &nbsp;<input type="checkbox" name="tourist_sub" value="1" id="tourist_sub" onClick="f_tourist('tourist_sub');">&nbsp;<%=r.getString(teasession._nLanguage,"2089063390")%>      </td>
      </form>
   <%
 }else if(teasession._rv!=null)
 {
   out.print(" <FORM  name=foLogin>   <span id=loginid></span>");
   out.println("<td colspan=2>");
   out.print(""+teasession._rv.toString()+"&nbsp;|&nbsp;<a id=\"cancels\" href=\"/servlet/Logout?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&node="+teasession._nNode+"\" target=\"_top\">"+r.getString(teasession._nLanguage,"5145993558")+"</a>");
   out.print("&nbsp;<input type=\"checkbox\" name=\"tourist_sub\" id=tourist_sub value=1 onclick=\"f_tourist('tourist_sub');\">&nbsp;"+r.getString(teasession._nLanguage,"2089063390"));
   out.print("</td>");
   out.print("</form>");
 }
   %>
    </tr>


    <FORM NAME="form1" METHOD=POST action="/servlet/EditTalkback" onSubmit="return f_submit1();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
   <input type='hidden' name='act' value="fa">
   <input type='hidden' name='tourist'>
    <tr class="Hint"><td align="left" valign="bottom"><%=r.getString(teasession._nLanguage, "Hint")%>：</td>
      <td>
      <%
      for(int i=1;i<11;i++)
      {
        out.print("<input id=radio"+i+" type=radio name=hint value="+i);
        if(1==i)
        {
          out.print(" checked ");
        }

        out.print(">");
        out.print("<img src=/tea/image/hint/"+i+".gif");
        out.print(" style=cursor:pointer  onclick=document.getElementById('radio"+i+"').checked=true  title="+Talkback.getHintString(i,teasession._nLanguage));
        out.print(">");
      }
      %></td>
      </tr>
      <tr style="display:none">
<!--        <td align="left"><%=r.getString(teasession._nLanguage, "Subject")%>：</td>
-->        <td colspan="2"><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="主题" SIZE=40 MAXLENGTH=255></td>
      </tr>
      <tr>
<!--        <td align="left" valign="top" class="td01"><%=r.getString(teasession._nLanguage, "Content")%>：</td>
-->        <td colspan="2"><textarea id="status"   name="content" cols=60 rows=4 class="edit_input" onKeyDown='countChar("status","counter");' onKeyUp='countChar("status","counter");'></textarea></td>
      </tr>
      <tr style="display:none;">
      <td align="left" class="td01">&nbsp;</td>
        <td><%=r.getString(teasession._nLanguage,"4738711624") %><span id="counter">6000</span><%=r.getString(teasession._nLanguage,"1810120135") %></td>
      </tr>
       <tr>
        <td align="left" class="td01"><%=r.getString(teasession._nLanguage, "2549850593")%>：</td>
        <td><img src="/NFasts.do?act=verify" id="vcodeImg" alt="<%=r.getString(teasession._nLanguage,"4795430490") %>"  style="cursor:pointer" align="absmiddle" class="CodeImg" onClick="reloadVcode();">&nbsp;
        <input type="TEXT"  name=vertify value="" size="5" />&nbsp;&nbsp;<a href="###"   style="cursor:pointer"  onClick="reloadVcode();"><%=r.getString(teasession._nLanguage,"4249463039") %></a></td>
      </tr>
      <script language="javascript">
         function reloadVcode()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg');
           vcode.setAttribute('src','/NFasts.do?act=verify&r='+Math.random());
         }
         function countChar(textareaName,spanName)//统计剩余字数
         {

           if(document.getElementById(textareaName).value.length > 6000){
             alert("<%=r.getString(teasession._nLanguage,"3513810607")%>6000");
             document.getElementById(spanName).innerHTML = 0;
           }else{
             document.getElementById(spanName).innerHTML = 6000 - document.getElementById(textareaName).value.length;
           }
         }
      </script>
      <tr>
      <td colspan="2" class="release">
      <table>
      <tr>
      <td align="right"><input type="submit" class="releaseBtn" value="<%=r.getString(teasession._nLanguage,"Submit") %>"></td>
      <td class="specialTips"><%=r.getString(teasession._nLanguage,"6020412808") %></td>
      </tr></table>
      </td>
      </tr>
    </form>
</table>
<script type="text/javascript">
	mt.fit();
</script>
</body>
</html>
