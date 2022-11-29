<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="com.capinfo.crypt.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="java.math.*"%>
<%@ page import="tea.entity.csvclub.alipay.*"%>
<%@ page import="tea.entity.csvclub.encrypt.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %>
<%


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
Ocean oce = Ocean.find(ids);
String oceanorder = teasession.getParameter("oceanorder");
//String str123 = "210402198404231711";
Calendar   calendarSys=new   java.util.GregorianCalendar();
java.util.Date   da   =   new   java.util.Date(System.currentTimeMillis());
calendarSys.setTime(da);

int   year=calendarSys.get(Calendar.YEAR);
//out.print(str123.substring(6,10));

%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.js" rel="stylesheet" type="text/css">
<title>海洋护照登记表</title>
<script>
//alert('北京海洋馆2010年海洋护照已经售罄，感谢您的支持与厚爱。欢迎您到北京海洋馆参观游览，北京海洋馆永远超乎你的想象！');
//history.go(-1);
function find_x(aa) 
{
  if(aa==1)
  {
    document.getElementById('dada').style.display="";
    shownuminfo.innerHTML="可使用原照片";
    shownuminfo2.innerHTML="照片";
  }else
  {
    document.getElementById('dada').style.display="none";
    shownuminfo.innerHTML="";
    shownuminfo2.innerHTML="*照片";
  }
}
function find_sub()
{
	
	//alert('北京海洋馆2010年海洋护照已经售罄，感谢您的支持与厚爱。欢迎您到北京海洋馆参观游览，北京海洋馆永远超乎你的想象！');
	//return false; 
 
  var   strReg="";
  var   r;
  var str = document.getElementById("email").value;
  strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
  r=str.search(strReg);

  if(form1.name.value=="" ||form1.name.value==null  )
  {
    alert("姓名不能为空，请重新填写！");
    form1.name.focus();
    return false;
  }
  if(form1.card.value=="" ||form1.card.value==null  )
  {
    alert("证件号不能为空，请重新填写！");
      form1.card.focus();
    return false;
  }
  if(form1.mobile.value=="" ||form1.mobile.value==null  )
  {
    alert("移动电话不能为空，请重新填写！");
     form1.mobile.focus();
    return false;
  }
  if(form1.telephone.value=="" ||form1.telephone.value==null  )
  {
    alert("固定电话不能为空，请重新填写！");
     form1.telephone.focus();
    return false;
  }
  if('<%=oce.getPicpath()%>'=='')
  {
    if(form1.picture.value=='')
    {
      alert("照片不能为空!");
      form1.picture.focus();
      return false;
    }
  }


  if(form1.urban.value==0)
  {
    alert("请选择居住城区！");
    form1.urban.focus();
    return false;
  }

  if(form1.address.value=="" ||form1.address.value==null  )
  {
    alert("通讯地址不能为空，请重新填写！");
     form1.address.focus();
    return false;
  }
  if(form1.zip.value=="" ||form1.zip.value==null  )
  {
    alert("邮政编码不能为空，请重新填写！");
     form1.zip.focus();
    return false;
  }
  if(form1.email.value=="" ||form1.email.value==null  )
  {
    alert("邮箱不能为空，请重新填写！");
     form1.email.focus();
    return false;
  }
  if(r==-1)
  {
    alert("您输入的邮件地址含有非法字符,请重新填写！");
         form1.email.focus();
    return false;
  }
  if(form1.applycard[1].checked)
  {
    if(form1.oceancard.value=="" ||form1.oceancard.value==null  )
    {
           alert("原卡号不能为空，请重新填写！");
           form1.oceancard.focus();
      return false;
    }
  }
  if(form1.passport[1].checked)
  {
    if(form1.cardtype[0].selected)
    {
      var num=parseInt(form1.card.value.substring(6,10));

      if(parseInt(parseInt(<%=year%>)-num)>18)
      {
        alert("您已经超过18岁，需要办理成人卡。");
	return false;
      }

    }else if(form1.cardtype[1].selected)
    {
      alert("您需要办理成人卡。");
      return false;
    }
    if(form1.cardtype.value=='0')
    {

      if(isIdCardNo(form1.card.value))
      {
        return true;
      }else
      {
        return false;
      }
    }

  }
  if(form1.cardtype.value=='0')
  {
    if(isIdCardNo(form1.card.value))
    {
      return true;
    }else
    {
      return false;
    }
  }
  if(!hs("interest"))
  {
    alert("请选择您感兴趣的会员活动或写下您希望我们举办哪些活动");
    return false;
  }

}
function f_picture(Obj)
{
  var tempImg=new Image();
  tempImg.onerror=function(){alert('目标类型错误或路径不存在！');Obj.outerHTML=Obj.outerHTML;};
  tempImg.onload=function(){if(this.width<145||this.width>176 || this.height<164 || this.height>194 ) {alert('提示:图像大小不符合系统要求！');Obj.outerHTML=Obj.outerHTML;}};
  tempImg.src=Obj.value;
  // oImg.src=this.value;if(oImg.width>100||oImg.width>80){alert('尺寸大了\n宽度是：'+oImg.width+'\n高度是：'+oImg.height)}

}
function isIdCardNo(s)
{
  if ((s.length <15)||(s.length ==16)||(s.length ==17)||(s.length >18))
  {
    window.alert("身份证位数不正确！");
    return false;
  }
  slen=s.length-1;//身份证除最后一位外，必须为数字！
  for (i=0; i<slen; i++)
  {
    cc = s.charAt(i);
    if (cc <"0" || cc >"9")
    {
      window.alert("请填写正确的身份证号！");
      return false;
    }
  }

  return true;
}

function f_load()
{
 alert("北京海洋馆2009年海洋护照即将售罄，网络办理平台将于2009年4月24日16： 00关闭，请您前往北京动物园北门团售办公室进行现场办理，咨询电话62176655-6799/6792/6738/6103。");

}


function f_tanchu()
{
  alert("2009年度海洋护照网上购买已经结束，感谢您的关注");
  return false;
}


</script>
</head>
<!--body class="OceanPassport" onload="f_load()"-->
<body class="OceanPassport">
<div class="body">
  <table class="Flow2">
    <tr>
      <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用（首信易支付）</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
        <div class="Description"></div>
        <form  name="form1" action="/servlet/EditOcean" method="POST" enctype="multipart/form-data" onSubmit="return find_sub();">
        <input  type="hidden" value="EditOceanRoll" name="act">
        <input  type="hidden" value="<%=ids%>" name="ids">
        <input type="hidden" name="oceanorder" value="<%=oceanorder%>">
        <table  border="0" class="Ocean_table">
          <tr>
            <td  nowrap class="td01">*购买类型：</td>
            <td  nowrap class="td02">成人卡
              <input name="passport" type="radio"  value="0" checked="checked" <%if((oce.getPassport()==0)){out.print("checked");}%>>
              　学生卡
              <input type="radio" name="passport" value="1" <%if((oce.getPassport()==1)){out.print("checked");}%>>
            </td>
            <td nowrap class="td03"></td>
            <td nowrap class="td04">&nbsp;</td>
          </tr>
          <tr>
            <td class="td01">*您的姓名：</td>
            <td class="td02"><label>
              <input type="text" name="name" value="<%if(oce.getName()!=null){out.print(oce.getName());}%>">
</label></td>
<td nowrap class="td03">您的性别：</td>
<td class="td04">男
  <input type="radio" name="sex" value="1" <%if((ids!=0)&&(oce.isSex())){out.print("checked");}else if(ids==0){out.print("checked");}%>>
  女
  <input type="radio" name="sex"  value="0" <%if((ids!=0)&&(!oce.isSex())){out.print("checked");}%>></td>
          </tr>
          <tr>
            <td nowrap  class="td01">*办理情况：</td>
            <td nowrap>新办卡：<input type="radio" name="applycard" value="0" onClick="find_x(this.value)"  checked="checked" <%if((oce.getApplycard()==0)){out.print("checked");}%>/>　续办卡：<input type="radio" name="applycard" <%if((oce.getApplycard()==1)){out.print("checked");}%> value="1" onClick="find_x(this.value)"   /></td>
              <td nowrap colspan="2"></td>
          </tr>

          <tr id=dada  style=display:none;>
            <td></td>
            <td colspan="2">*是否连续三年以上办理海洋护照： 是<input type="radio" name="applycard3" value="0"  checked="checked" <%if((oce.getApplycard3()==0)){out.print("checked");}%>/>否<input type="radio" name="applycard3" value="1" <%if((oce.getApplycard3()==1)){out.print("checked");}%>/><div>*请输入原卡号：<input type="text"  name="oceancard" value="<%if(oce.getOceancard()!=null && oce.getOceancard().length()>0){out.print(oce.getOceancard());}%>"/></div></td>
              <td></td>

          </tr>
          <tr>
            <td nowrap class="td01">*证件类型：</td>
            <td ><select id="cdt" name="cardtype">
            <%
            for(int i=0;i<Ocean.CARDTYPE.length;i++)
            {
              out.print("<option value="+i);
              if(oce.getCardtype()==i)
              {
                out.print(" selected");
              }
              out.print(">"+Ocean.CARDTYPE[i]+"</option>");
            }
            %></select></td>
            <td class="td03">*证件号码：</td><td><input type="text" name="card" maxlength="18" size="21" value="<%if(oce.getCard()!=null)out.print(oce.getCard());%>"></td>
          </tr>
          <tr>
            <td nowrap class="td01">*您的移动电话：</td>
            <td ><input type="text" name="mobile" value="<%if(oce.getMobile()!=null)out.print(oce.getMobile());%>"  mask="float" maxlength="11"></td>
              <td colspan="2"></td>
          </tr>
          <tr>
            <td class="td01">*固定电话：</td>
            <td ><input type="text" name="telephone" value="<%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%>"></td>
              <td></td>
              <td></td>
          </tr>
          <tr>


            <td class="td01"><span id="shownuminfo2">*照片：</span></td>
            <td colspan="2"><input type="file"  name="picture"  value="" onChange="f_picture(this);"></td>
              <td nowrap rowspan="2" class="tetd1"><img  id="oImg"  src="<%if(oce.getPicpath()!=null)out.print(oce.getPicpath());else{out.print("/tea/image/oceanRoll/phonomember.jpg");} %>" width="100"></td>
          </tr>
          <tr>
            <td></td>
            <td colspan="2" class="tetd2">请上传个人1寸左右免冠彩色近照，像素<br/>大于145*164小于176*194，如不上传则使用原护照照片<!--请上传标准1寸或2寸免冠彩色近照，用于制证：--><br/><span id="shownuminfo"></span></td>
          </tr>
          <tr>
            <td  class="td01" valign="top">教育程度：</td>
            <td colspan="3">
            <%
               for(int i =0;i<Ocean.EDUCATION.length;i++)
               {

                 out.print("<input type=\"radio\" name=education value="+i);
                 if(oce.getEducation()==i)
                 {
                   out.print(" checked ");
                 }
                 out.print(" >&nbsp;");
                 out.print(Ocean.EDUCATION[i]);
                 out.print("　");
               }
            %>
            </td>
          </tr>
          <tr>
            <td  class="td01" valign="top">您的职业：</td>
            <td colspan="3">
            <%
            for(int i =0;i<Ocean.OCCUPA_TION.length;i++)
            {

              out.print("<input type=\"radio\" name=\"occupation\" value="+i);
              if(oce.getOccupation()==i)
              {
                out.print(" checked ");
              }
              out.print(" >&nbsp;");
              out.print(Ocean.OCCUPA_TION[i]);
              out.print("　");
            }
            %>
</td>
          </tr>
          <tr>
            <td  class="td01" valign="top">*居住城区：</td>

           <td colspan="3">
           <select name="urban">
              <%
                 for(int i = 0;i<Ocean.URBAN_TYPE.length;i++)
                 {
                   out.print("<option value = "+i);
                   if(oce.getUrban()==i)
                   {
                     out.print(" selected ");
                   }
                   out.print(">"+Ocean.URBAN_TYPE[i]);
                   out.print("</option>");
                 }
              %>
           </select>
           </td>

          </tr>
          <tr>
            <td  class="td01" valign="top">*您的通信地址：</td>
            <td colspan="3"><label>
              <textarea name="address" id="textarea" cols="45" rows="5"><%if(oce.getAddress()!=null){out.print(oce.getAddress());}%></textarea>
</label></td>
          </tr>

          <tr>
            <td class="td01">*邮政编码：</td>
            <td style="width=150px;"> <input type="text" name="zip" value="<%if(oce.getZip()!=null)out.print(oce.getZip());%>" mask="float" maxlength="6"></td>
              <td class="td03">*电子邮箱：</td>
              <td><label>
                <input type="text" name="email" value="<%if(oce.getEmail()!=null)out.print(oce.getEmail());%>">
</label></td>
          </tr>

          <tr>
          <!--
            <td nowrap class="td01">您宝宝的姓名：</td>
            <td><label>
              <input type="text" name="babyname" value="<%if(oce.getBabyname()!=null)out.print(oce.getBabyname());%>">
</label></td>-->
<td class="td03">宝宝生日：</td>
<td width="104" colspan="3"><input type="text" readonly="readonly" name="babybirth" value="<%if(oce.getBabybirthtoString()!=null){out.print(oce.getBabybirthtoString());}%>" onClick="new Calendar('1997', '2010', 0,'yyyy-MM-dd').show(this);" /></td>
          </tr>
          <!--
          <tr>
            <td class="td01">您宝宝的年龄：</td>
            <td><label>
              <input type="text" name="babyage" value="<%if(oce.getBabyage()!=null)out.print(oce.getBabyage());%>" mask="float" maxlength="2">岁
</label></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
          </tr>-->
          <tr>
            <td class="td01">家庭收入：</td>
            <td><label>
              <input type="radio" name="income"  value="0"   <%if(oce.getIncome()==0){out.print(" checked ");}%>>&nbsp;4000元以下</label></td>
              <td nowrap><input type="radio" name="income"  value="1" <%if(oce.getIncome()==1){out.print(" checked ");}%>>&nbsp;4000元—7000元</td>
                <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="radio" name="income"  value="2"  <%if(oce.getIncome()==2){out.print(" checked ");}%>>&nbsp;7000元—10000元</td>
              <td><input type="radio" name="income"  value="3" <%if(oce.getIncome()==4){out.print(" checked ");}%>>&nbsp;10000元以上</td>
              <td>&nbsp;</td>
          </tr>

           <tr>
            <td  class="td01" valign="top">信息获知途径：</td>

           <td colspan="3">
              <%
                 for(int i = 0;i<Ocean.LEARN_WAY.length;i++)
                 {
                   out.print("<input type=radio name=learnway  value="+i);
                   if(oce.getLearnway()==i)
                   {
                     out.print(" checked ");
                   }
                   out.print(" >&nbsp;");
                   out.print(Ocean.LEARN_WAY[i]);
				   out.print("　");
                 }
              %>

           </td>

          </tr>
          <tr>
            <td  class="td01" valign="top">您和宝宝的兴趣爱好：</td>
            <td colspan="3">
            <%
            for(int i = 0;i<8;i++)
            {
              out.print("<input type=checkbox name=bobo_interest"+i+"  value="+i);
              if(oce.getBobo_interest()!=null && oce.getBobo_interest().indexOf("/"+i+"/")!=-1)
              {
                out.print(" checked ");

              }
              out.print(" >&nbsp;");
              out.print(Ocean.BOBO_INTEREST[i]);
			  out.print("　");
            }
            %>
            </td>
          </tr>
           <tr>
            <td>&nbsp;</td>
            <td colspan="3">
            <%
            for(int i = 8;i<Ocean.BOBO_INTEREST.length;i++)
            {
              out.print("<input type=checkbox name=bobo_interest"+i+"  value="+i);
               if(oce.getBobo_interest()!=null &&  oce.getBobo_interest().indexOf("/"+i+"/")!=-1)
              {
                out.print(" checked ");

              }
              out.print(" >&nbsp;");
              out.print(Ocean.BOBO_INTEREST[i]);
			  out.print("　");
            }
            %>
            </td>
          </tr>
           <tr>
            <td>&nbsp;</td>
            <td colspan="3">其他:<input type="text" name="bobo_interest_qita" value="<%if(oce.getBobo_interest_qita()!=null)out.print(oce.getBobo_interest_qita());%>"/>
            </td>
          </tr>
          <tr>
            <td colspan="3">请选择您感兴趣的会员活动或写下您希望我们举办哪些活动,可多项选择：</td>
            <td><label></label></td>
          </tr>
          <%
          for(int i=0;i<Ocean.INTEREST.length;i++)
          {

            out.print("<tr><td nowrap ></td><td nowrap colspan=3><label><input id = interest type=checkbox name=interest"+i+" value="+i);
            if(oce.getInterest()!=null && oce.getInterest().length()>0)
            {
              String spit[] = oce.getInterest().split(",");
              if(spit.length!=-1)
              {
                for(int j=0;j<spit.length;j++)
                {
                  if((spit[j]).length()>0)
                  {
                    int aa = Integer.parseInt(spit[j]);
                    if(aa==i)
                    {
                      out.print(" checked ");
                    }
                  }
                }
              }
            }
            out.print("></label>　"+Ocean.INTEREST[i]+"</td></tr>");
          }
          %>
          <tr>
            <td class="td01" valign="top">其他：</td>
            <td  colspan="3">
              <label>
                <textarea name="other" cols="40" rows="4"><%if(oce.getOther()!=null)out.print(oce.getOther());%></textarea>
              </label></td>
          </tr>
          <tr>
            <td class="td01">是否允许代领：</td><td colspan="3">
              <label>
                是<input type="radio" name="replacetype" value="1" checked="checked" <%if(oce.getReplacetype()==1)out.print("checked");%>>  否<input type="radio" name="replacetype" value="0" <%if(oce.getReplacetype()==0&& ids!=0)out.print("checked");%>>
              </label>*代领人在领卡时需带办卡人所填相关证件</td>
          </tr>
          <tr><!--return find_sub(<%=year%>)                  onClick="window.open('/jsp/ocean/EditOceanOver.jsp','_self')"-->
            <td colspan="4" align="center"><input type="submit" value=""  class="Submit"/></td>
          </tr>
        </table>
        </form>
            </div>
    </div>
</div>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
