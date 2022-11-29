<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.math.BigDecimal"%>
<%
boolean bool=request.getMethod().equals("POST");
int aac006=0;
int lab001=4;
int var001=4;
int pay001=4;
int pro001=4;
int ven001=4;
int sha001=4;
int que001=4;
float value=0;
if(bool)
{
   aac006=Integer.parseInt(request.getParameter("aac006").trim());
   lab001=Integer.parseInt(request.getParameter("lab001"));
   var001=Integer.parseInt(request.getParameter("var001"));
   pay001=Integer.parseInt(request.getParameter("pay001"));
   pro001=Integer.parseInt(request.getParameter("pro001"));
   ven001=Integer.parseInt(request.getParameter("ven001"));
   sha001=Integer.parseInt(request.getParameter("sha001"));
   que001=Integer.parseInt(request.getParameter("que001"));
   value=aac006/10F+lab001+var001+pay001+pro001+ven001+sha001+que001;

}
%>



<script language="javascript">
<!--
 function fcheck(obj)
 {
   if(parseInt(obj.value)<=0)
   {
     alert(obj.label+"-必须大于0.");
     obj.focus();
     return false;
   }
   return true;
 }

 function epamsaccount(obj)
 {
   if (!checkValue(obj)){return;}
   if(!fcheck(obj.aac006))return;
   obj.submit();
 }
//-->
</script>
<html>

	<head><title>企业年金管理信息系统</title> <base target = '_self'></head><link href='cssjs/style2.css' rel='stylesheet' type='text/css'><script src='cssjs/Globals.js'></script><script src='cssjs/validate.js'></script>
	<body leftmargin="0" topmargin="0" onload="page_init()">
		<table class=navigation>
		<tr>
			<td  onmousemove="this.title='';this.style.color='#FF0000'"  onmouseout="this.style.color='#000000';" >◆	风险承受测算</td>
		</tr>
</TABLE>
		<!--录入部分-->
		<table class=tableTitle>
		<tr>
			<td style='word-break:keep-all'>风险承受测算</td>
		</tr>
</TABLE>
			<form name="RiskPredictForm" method="POST" action="<%=request.getRequestURI()%>" onsubmit="return checkValue(this);">
			<table class="TableInput" width="618">
			<COLGROUP><COL width='16%'><COL width='17%'><COL width='16%'><COL width='17%'><COL width='16%'><COL width='17%'></COLGROUP>
			<tr>
				<td><font color='#FF0000'>*</font>个人年龄</td><td colspan="1"><textarea style='width:100%'  name="aac006" mask="nn" label="个人年龄" required="true" disable="false" cols="20" rows="1" class="mask"><%if(bool)out.print(aac006);%></textarea></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr ><td align="left">1.个人月收入:</td>
				<td><input type="radio" name="lab001" value="4" checked="checked">1000元以下</td>
				<td><input type="radio" name="lab001" value="3"<%if(lab001==3)out.print(" checked");%>>2000元以下</td>
				<td><input type="radio" name="lab001" value="2"<%if(lab001==2)out.print(" checked");%>>4000元以下</td>
				<td><input type="radio" name="lab001" value="1"<%if(lab001==1)out.print(" checked");%>>4000元以上</td>
			</tr>

			<tr><td align="left">2.个人投资期限:</td>
				<td><input type="radio" name="var001" value="4" checked="checked">少于3年</td>
				<td><input type="radio" name="var001" value="3"<%if(var001==3)out.print(" checked");%>>3-5年</td>
				<td><input type="radio" name="var001" value="2"<%if(var001==2)out.print(" checked");%>>6-10年</td>
				<td><input type="radio" name="var001" value="1"<%if(var001==1)out.print(" checked");%>>10年以上</td>
			</tr>
			<tr><td align="left">3.您的投资中哪一品种所占的比重最大？:</td>
				<td><input type="radio" name="pay001" value="4" checked="checked">银行存款</td>
				<td><input type="radio" name="pay001" value="3"<%if(pay001==3)out.print(" checked");%>>保险</td>
				<td><input type="radio" name="pay001" value="2"<%if(pay001==2)out.print(" checked");%>>房地产投资</td>
				<td><input type="radio" name="pay001" value="1"<%if(pay001==1)out.print(" checked");%>>股票／基金</td>
			</tr>
			<tr><td align="left">4.选择投资对象时，您更倾向于下列哪类投资品：</td>
				<td><input type="radio" name="pro001" value="4" checked="checked">平均投资回报率为３％ </td>
				<td><input type="radio" name="pro001" value="3"<%if(pro001==3)out.print(" checked");%>>平均投资回报率为５.６％</td>
				<td><input type="radio" name="pro001" value="2"<%if(pro001==2)out.print(" checked");%>>平均投资回报率为１１.７％</td>
				<td><input type="radio" name="pro001" value="1"<%if(pro001==1)out.print(" checked");%>>平均投资回报率为２０％</td>
			</tr>
			<tr><td align="left">5.您对投资价值波动的感觉是:</td>
				<td><input type="radio" name="ven001" value="4" checked="checked">对任何波动都感到难以承受</td>
				<td><input type="radio" name="ven001" value="3"<%if(ven001==3)out.print(" checked");%>>能够接受轻微波动，关心资产保值多于增值</td>
				<td><input type="radio" name="ven001" value="2"<%if(ven001==2)out.print(" checked");%>>能够理解并接受“高收益就意味着要承受投资波动”</td>
				<td><input type="radio" name="ven001" value="1"<%if(ven001==1)out.print(" checked");%>>潜意识中追求高增长，同时能够坦然接受投资亏损</td>
			</tr>
			<tr><td align="left">6.假如您持有的某种股票下跌２５％，您会怎样处理这项投资?</td>
				<td><input type="radio" name="sha001" value="4" checked="checked">全部卖掉，断腕止损</td>
				<td><input type="radio" name="sha001" value="3"<%if(sha001==3)out.print(" checked");%>>卖出大半，保存实力</td>
				<td><input type="radio" name="sha001" value="2"<%if(sha001==2)out.print(" checked");%>>按兵不动，等待反转</td>
				<td><input type="radio" name="sha001" value="1"<%if(sha001==1)out.print(" checked");%>>追加投资，摊平成本</td>
			</tr>

			<tr><td align="left">7.在您看表演时，舞台上的催眠师征求自愿者上台合作，您会上去吗?</td>
				<td><input type="radio" name="que001" value="4" checked="checked">我决不会做</td>
				<td><input type="radio" name="que001" value="3"<%if(que001==3)out.print(" checked");%>>我不可能加以考虑</td>
				<td><input type="radio" name="que001" value="2"<%if(que001==2)out.print(" checked");%>>我可能会做</td>
				<td><input type="radio" name="que001" value="1"<%if(que001==1)out.print(" checked");%>>我绝对会做</td>
			</tr>
		</table>
		</form>
		<table class='tableInput' width='95%' height='35' border='0' align='center' cellspacing='0' ><tr><td><table width='140' height='31' border='0' align='right' cellpadding='0' cellspacing='0'><tr><td><input class='buttonGray' type='button' onclick="epamsaccount(document.forms[0])" value='测算'>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table></td></tr></table><table width='95%' height='1' border='0' align='center' cellpadding='0' cellspacing='0'><tr><td height='1' class='BottomlineColor'></td></tr></table>
<%
if(bool)
  if(value<30)
  {
    out.print("<script>alert('风险承受力强');</script>");
  }else
  if(value>30)
  {
    out.print("<script>alert('风险承受力弱');</script>");
  }else
  {
    out.print("<script>alert('风险承受力一般');</script>");
  }
%>

	 </body>
</html>



