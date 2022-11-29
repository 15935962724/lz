<%@page contentType="text/html;charset=utf-8" %><%@ page import="tea.ui.TeaSession"%><%@ page import = "tea.entity.member.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%

request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

tea.resource.Resource r = new tea.resource.Resource("/tea/ui/util/SignUp1");



String vertify=sms.password();
session.setAttribute("sms.vertify" ,vertify);





String member=request.getParameter("member");

String act=request.getParameter("act");
if(act==null)
act="reg";

String email=null,firstname=null,card=null,degree=null,job=null,address=null,zip=null,comm=null,saddress=null,telephone=null,mobile=null;
String event=null,info=null,remark=null;
java.util.Date birth=null;
boolean sex=true;
int cityzone=0,street=0,stype=0;
if("edit".equals(act)||"bgedit".equals(act))
{
  if("edit".equals(act))
  member=teasession._rv._strV;

  Profile p=Profile.find(member);
  email=p.getEmail();
  sex=p.isSex();
  firstname=p.getFirstName(teasession._nLanguage);
  card=p.getCard();
  birth=p.getBirth();
  degree=p.getDegree(teasession._nLanguage);
  job=p.getJob(teasession._nLanguage);
  address=p.getAddress(teasession._nLanguage);
  zip=p.getZip(teasession._nLanguage);
  telephone=p.getTelephone(teasession._nLanguage);
  mobile=p.getMobile();

  ProfilePostulant pp=ProfilePostulant.find(member,teasession._strCommunity);
  cityzone=pp.getCityzone();
  street=pp.getStreet();
  comm=pp.getComm();
  saddress=pp.getSaddress();
  event=pp.getEvent();
  info=pp.getInfo();
  remark=pp.getRemark();
  stype=pp.getStype();
}else
{
  java.util.Calendar c=java.util.Calendar.getInstance();
  c.set(c.YEAR,1970);
  birth=c.getTime();
  event=info="";
  degree="Z6";
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function submitCard(obj,text)
{
  var len=obj.value.length;
  if(len!=15&&len!=18)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
function submitTelMob(tel,mob,text)
{
//   submitLength(8,20,tel,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>-最少8位,全部是数字.')
   if(tel.value.length<8&&mob.value.length<11)
   {
     alert(text)
     tel.focus();
     return false;
   }
   return true;
}

function submitText2(obj,obj2,text)
{
  if(obj.value.length<1)
  {
    alert(text);
    try
    {
      obj.focus();
    }catch(e)
    {
      obj2.focus();
    }
    return false;
  }
  return true;
}
function f_submit(form1)
{
  return submitMemberid(form1.member,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&
  (!form1.EnterPassword||submitIdentifier(form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>'))&&
  (!form1.EnterPassword||submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>'))&&
  submitEmail(form1.email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&
  submitIdentifier(form1.vertify,'<%=r.getString(teasession._nLanguage, "Validate")%>')&&
  submitLength(2,20,form1.firstname,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>-最少2位,全部是中文汉字.')&&
  submitCard(form1.card,'<%=r.getString(teasession._nLanguage, "无效身份证号-长度应是15位或18位.")%>')&&
  submitText(form1.job,'<%=r.getString(teasession._nLanguage, "无效职业")%>')&&
  submitText(form1.cityzone,'<%=r.getString(teasession._nLanguage, "无效所在城区-请选择所在城区")%>')&&
  submitText(form1.address,'<%=r.getString(teasession._nLanguage, "无效居住地址")%>')&&
  submitText(form1.zip,'<%=r.getString(teasession._nLanguage, "无效邮编")%>')&&
  submitTelMob(form1.telephone,form1.mobile,'固定电话和手机至少有一项必须填正确')&&
  submitText2(form1.event,form1.event_sel,'无效-能否经常参加活动')&&
  submitText2(form1.info,form1.info_sel,'无效-能否经常提供信息');
}
function f_load()
{
  f_city();
  foSignUp.street.value="<%=street%>";
  if(!"<%=event%>"=="能"&&!"<%=event%>"=="周末"&&!"<%=event%>"=="否"&&!"<%=event%>"=="")
  {
    foSignUp.event.style.display='';
  }else
  {
    foSignUp.event_sel.value="<%=event%>";
  }
  if(!"<%=info%>"=="能"&&!"<%=info%>"=="周末"&&!"<%=info%>"=="否"&&!"<%=info%>"=="")
  {
    foSignUp.info.style.display='';
  }else
  {
    foSignUp.info_sel.value="<%=info%>";
  }
  try
  {
    document.foSignUp.member.focus();
  }catch(e)
  {}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body onload="f_load();">
<h1><%=r.getString(teasession._nLanguage, "SeaRegister")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=foSignUp METHOD=POST ACTION="/servlet/EditProfilePostulant" onSubmit="return f_submit(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="act" value="<%=act%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  String nexturl=request.getParameter("nexturl");
  if(nexturl!=null)
  out.print("<input type=hidden name=nexturl value="+nexturl+" >");

  if("edit".equals(act)||"bgedit".equals(act))
  {
    out.print("<tr><td>"+r.getString(teasession._nLanguage, "MemberId")+"</td><td><input type=hidden name=member value="+member+" >"+member+"</td></tr>");
  }else
  {
  %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "MemberId")%>:</td>
      <td><input type="TEXT"  name=member  size=20 maxlength=40></td><td>3-20位</td>
    </tr>
    <%}
    if(!"edit".equals(act))
    {%>

    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</td>
      <td><input type="password"  name=EnterPassword value="" size=20 maxlength=16></td><td>3-20位</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</td>
      <td><input type="password"  name=ConfirmPassword value="" size=20 maxlength=16></td>
      <td>&nbsp;</td>
    </tr>

    <%}%>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="TEXT"  name=email  size=40 maxlength=40 value="<%if(email!=null)out.print(email);%>"></td>
      <td>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "Gender")%>:</td>
      <td><input id="gender_0" type="radio" name="sex" value="1" checked="checked"/><label for="gender_0"><%=r.getString(teasession._nLanguage, "Man")%></label>
        <input id="gender_1" type="radio" name="sex" value="0"  <%if(!sex)out.print(" checked ");%>" /><label for="gender_1"><%=r.getString(teasession._nLanguage, "Woman")%></label></td>
      <td>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "Validate")%>:</td>
      <td><input type="TEXT"  name=vertify value="" size=20 maxlength=20><%=r.getString(teasession._nLanguage, "VerificationCode")%>:<img src="/jsp/user/validate.jsp" ></td>
      <td>&nbsp;</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 真实姓名</td>
      <td><input  name=firstname type="TEXT" value="<%if(firstname!=null)out.print(firstname);%>" onBlur="this.value=this.value.replace(/[^\u4E00-\u9FA5]/g,'');" onKeyPress="if(window.event.keyCode>0&&window.event.keyCode<255)window.event.returnValue=false;" size=20 maxlength=40></td>
      <td>最少2位,全部是中文汉字.</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 身份证号</td>
      <td><input  name=card type="TEXT" value="<%if(card!=null)out.print(card);%>" onBlur="this.value=this.value.replace(/[^0-9xX]/g,'');" onKeyPress="if((event.keyCode<48||event.keyCode>57)&&event.keyCode!=120&&event.keyCode!=88)window.event.returnValue=false;"  size=30 maxlength=18></td>
      <td>15或18位.</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 出生日期</td>
      <td><%=new tea.htmlx.TimeSelection("birth", birth)%></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 学历</td>
      <td><%=new tea.htmlx.DegreeSelection("degree",degree)%></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 职业</td>
      <td><input type="text" name="job" value="<%if(job!=null)out.print(job);%>" /></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 所在城区</td>
      <td><select name="cityzone" onchange="f_city();">
        <option value="">-----------</option>
        <%
        StringBuffer sb=new StringBuffer();
        for(int i=0;i<ProfilePostulant.CITY_TYPE.length;i++)
        {
          out.print("<option value="+(i+1));
          if(cityzone==i+1)
          out.print(" SELECTED ");
          out.print(">"+ProfilePostulant.CITY_TYPE[i][0]+"</option>");

          sb.append("case "+(i+1)+":");
          for(int j=1;j<ProfilePostulant.CITY_TYPE[i].length;j++)
          {
            sb.append("obj.options[obj.options.length]=new Option('"+ProfilePostulant.CITY_TYPE[i][j]+"','"+(j)+"');");
          }
          sb.append("break;\r\n");
        }
        %>
        </select>

      </td>
      <td></td>
    </tr>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>&nbsp;&nbsp;&nbsp;所在街道</td>
      <td>
<select name="street">
<option value="0">-----------</option>
</select>
<script type="">
function f_city()
{
  var obj=foSignUp.street;
  while(obj.options.length>1)
  {
    obj.options[1]=null;
  }
  switch(parseInt(foSignUp.cityzone.value))
  {
    <%=sb.toString()%>
  }
}
</script>
      </td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 居住地址</td>
      <td><input type="text" name="address" value="<%if(address!=null)out.print(address);%>" /></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 邮编</td>
      <td><input type="text" name="zip" value="<%if(zip!=null)out.print(zip);%>"  onBlur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(window.event.keyCode<48||window.event.keyCode>57)window.event.returnValue=false;"/></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>&nbsp;&nbsp;所在社区</td>
      <td><input type="text" name="comm"  value="<%if(comm!=null)out.print(comm);%>" /></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>&nbsp;&nbsp;备用地址</td>
      <td><input type="text" name="saddress"  value="<%if(saddress!=null)out.print(saddress);%>" ></td>
      <td></td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* <%=r.getString(teasession._nLanguage, "Telephone")%></td>
      <td><input  name=telephone type="TEXT" value="<%if(telephone!=null)out.print(telephone);%>"  onBlur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(window.event.keyCode<48||window.event.keyCode>57)window.event.returnValue=false;"  size=30></td>
      <td>固定电话和手机至少填一个</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 手机</td>
      <td><input  name=mobile type="TEXT" value="<%if(mobile!=null)out.print(mobile);%>"  onBlur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(window.event.keyCode<48||window.event.keyCode>57)window.event.returnValue=false;"  size=30></td>
      <td>固定电话和手机至少填一个</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 能否经常参加活动</td>
      <td><select name="event_sel" onChange="if(this.selectedIndex==4){foSignUp.event.value='';foSignUp.event.style.display='';}else{foSignUp.event.value=this.value;foSignUp.event.style.display='none';}">
        <option value="">--------</option>
        <option value="能">能
        <option value="周末">周末
        <option value="否">否
        <option value="">其它</select><input style="display:none" value="<%if(event!=null)out.print(event);%>"  name=event type="text"></td>
      <td>如果是其它请留言</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>* 能否经常提供信息</td>
      <td><select name="info_sel" onChange="if(this.selectedIndex==4){foSignUp.info.value='';foSignUp.info.style.display='';}else{foSignUp.info.value=this.value;foSignUp.info.style.display='none';}">
        <option value="">--------</option>
        <option value="能">能
        <option value="周末">周末
        <option value="否">否
        <option value="">其它</select><input style="display:none" value="<%if(info!=null)out.print(info);%>"  name=info type="text"></td>
      <td>如果是其它请留言</td>
    </tr>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <td>&nbsp;&nbsp;个人简介(备注)</td>
      <td colspan="2"><textarea name="remark" cols="50" rows="5" id="remark"><%if(remark!=null)out.print(remark.replaceAll("&lt;/","</"));%></textarea></td>
    </tr>
    <%
    if("bgreg".equals(act)||"bgedit".equals(act))
    {
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
        <td>&nbsp;&nbsp;报名方式</td>
        <td>
        <select name="stype" >
          <%
          for(int i=0;i< ProfilePostulant.SIGNUP_TYPE.length;i++)
          {
            out.print("<option value="+i);
            if(i==stype)
            out.print(" SELECTED ");
            out.print(" >"+r.getString(teasession._nLanguage,ProfilePostulant.SIGNUP_TYPE[i]));
          }
          %></select>
        </td>
      </tr>
      <%
    }else
    {
      out.print("<input type=hidden name=stype value="+stype+" >");
    }
    %>
  </table>
  <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  <input type="button" onclick="history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<%
if("reg".equals(act))
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>欢迎报名加入1073城市管理志愿者服务队！如有任何问题，请拨打秘书处电话65158266。</td>
</table>
<%}%>
</body>
</html>



