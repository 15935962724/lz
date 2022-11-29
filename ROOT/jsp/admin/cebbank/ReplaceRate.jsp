<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.math.BigDecimal"%><%!
public double f(double value,int value2)
{/*
  double result=value;
  for(;value2>1;value2--)
  {
    result*=value;
  }
  return result;*/
  return java.lang.Math.pow(value,value2);
}
public int f(int value,int value2)
{
  int result=value;
  for(;value2>1;value2--)
  {
    result*=value;
  }
  return result;
}
public BigDecimal f(BigDecimal value,int value2)
{
  BigDecimal result=value;
  for(;value2>1;value2--)
  {
    result=result.multiply(value);
  }
//  System.out.println(value.scale());
  return result;//.setScale(value.scale(),4);
}
java.text.DecimalFormat nf=new java.text.DecimalFormat("#,##0.00");
java.text.DecimalFormat nf2=new java.text.DecimalFormat("0.0000");
%><%
int life=0;
int year=0;

int otype=0;
BigDecimal indivcont=null;
BigDecimal empcont=null;
BigDecimal wagerise=null;
BigDecimal syl=null;
BigDecimal atc001=null;
BigDecimal laborage=null;
BigDecimal sn=null;
BigDecimal p4=null;
BigDecimal t=null;
boolean post=request.getMethod().equals("POST");
if(post)
{
  try
  {
    //解决1.4不存在的常量问题
    BigDecimal ONE=new BigDecimal("1");

    otype=Integer.parseInt(request.getParameter("otype"));//缴费方式

    indivcont=new BigDecimal(request.getParameter("indivcont"));//个人月缴费额       P1
    empcont=new BigDecimal(request.getParameter("empcont"));//企业月缴费额            P2
    wagerise=new BigDecimal(request.getParameter("wagerise")).divide(BigDecimal.valueOf(100L),4,4);//工资年增长率%         R2
    syl=new BigDecimal(request.getParameter("syl")).divide(BigDecimal.valueOf(100L),4,4);//年金收益率%                    R1
    life=Integer.parseInt(request.getParameter("life").trim());//年金领取年数                    M
    year=Integer.parseInt(request.getParameter("year").trim());//缴费年数                        N
    atc001=new BigDecimal(request.getParameter("atc001"));//个人目前累计缴费额          Pv
    laborage=new BigDecimal(request.getParameter("laborage"));//月平均工资          Sal




    BigDecimal p3=indivcont.add(empcont).multiply(new BigDecimal(12/otype));//月缴费合计

    int n=year*otype;
    int m=life*12;

    BigDecimal bd=ONE.divide(new BigDecimal(otype),32,4);//   1/12
    BigDecimal r1=syl.multiply(bd);//.setScale(40,4);//月投资收益率
    BigDecimal r2=wagerise;//wagerise.multiply(bd).setScale(4,4);
    //System.out.println(r1);
    BigDecimal r1_12=f(ONE.add(r1),otype); //(1+r1) ^ 12
    BigDecimal r1_1=r1.add(ONE);        //1+r1
    BigDecimal r2_1=r2.add(ONE);        //1+r2

    if(otype!=1)
    {
//      System.out.println("r1 \t:"+r1);
//      System.out.println("1+r1 \t:"+ONE.add(r1));
//      System.out.println("(1+r1)^n \t:"+f(ONE.add(r1),n));
      if(r1.floatValue()!=0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))!=0)
      {
        sn=p3.multiply(f(ONE.add(r1),n).subtract(f(ONE.add(r2),year)));//      p3*[(1+r1)^n-(1+r2)^n]
        //
        sn=sn.multiply(r1_12).divide(r1_12.subtract(ONE.add(r2)),10,4); //  (1+r1)^12 / (1+r1)^12-(1+r2)
        sn=sn.multiply(ONE.subtract(ONE.divide(r1_12,10,4)));//  1-(1/(1+r1)^12)
        sn=sn.multiply(r1_1.divide(r1,10,4));//  (1+r1)/r1
        sn=sn.add(atc001.multiply(f(r1_1,n))); // pv*(1+r1)^n
        //    System.out.println(r1_12);
      }else
      if(r1.floatValue()!=0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))==0)
      {
        sn=new BigDecimal(year).multiply(p3).multiply(f(r1_1,n)).multiply(ONE.subtract(ONE.divide(r1_12,10,4))).multiply(r1_1.divide(r1,10,4)).add(atc001.multiply(f(r1_1,n)));
      }else
      if(r1.floatValue()==0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))!=0)
      {
        sn=p3.multiply(new BigDecimal(12)).multiply(f(ONE.add(r2),year).subtract(ONE)).multiply(ONE.divide(r2,10,4)).add(atc001);
      }else
      if(r1.floatValue()==0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))==0)
      {
        sn=new BigDecimal(n).multiply(p3).add(atc001);
      }

    }else//（按年缴费）（年缴费频率为1）
    {
      if(r1.floatValue()!=0&&ONE.add(r2).compareTo(ONE.add(r1))!=0)
      {
        sn=p3.multiply(f(ONE.add(r1),n).subtract(f(ONE.add(r2),year)));//
        sn=sn.multiply(ONE.add(r1).divide(r1.subtract(r2),32,4)); //
        sn=sn.add(atc001.multiply(f(ONE.add(r1),n))); // pv*(1+r1)^n
      }else
      if(r1.floatValue()!=0&&ONE.add(r2).compareTo(ONE.add(r1))==0)
      {
        sn=new BigDecimal(year).multiply(p3).multiply(f(ONE.add(r1),n));
        sn=sn.add(atc001.multiply(f(ONE.add(r1),n)));
      }else
      if(r1.floatValue()==0&&ONE.add(r2).compareTo(ONE.add(r1))!=0)
      {
        sn=p3.multiply(f(ONE.add(r2),year).subtract(ONE)).multiply(ONE.divide(r2,32,4)).add(atc001);
      }else
      if(r1.floatValue()==0&&ONE.add(r2).compareTo(ONE.add(r1))==0)
      {
        sn=new BigDecimal(n).multiply(p3).add(atc001);
      }

    }

    r1=syl.multiply(ONE.divide(new BigDecimal(12),32,4));
//    System.out.println("r1=R1*1/12 \t:"+r1);
//    System.out.println("1+r1^m \t:"+f(ONE.add(r1),m));
    if(r1.floatValue()!=0)
    {
      p4=sn.multiply(r1.multiply(f(ONE.add(r1),m)).divide(f(ONE.add(r1),m).subtract(ONE),32,4)).setScale(2,4);
    }else
    {
      p4=sn.divide(new BigDecimal(m),2,4);
    }
















    t=p4.divide(laborage,4,4).multiply(BigDecimal.valueOf(100L)).setScale(2,4);






  }catch(Exception e)
  {
    out.print("<script>alert('输入值非法,请检查.');</script>");
    e.printStackTrace();
  }

}

%>




<script src='cssjs/validate.js'></script>
<script language="JavaScript">
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
function fcheck2(obj)
{
  if(parseInt(obj.value)<0)
  {
    alert(obj.label+"-必须大于等于0.");
    obj.focus();
    return false;
  }
  return true;
}
function epamsaccount(obj)
{
  if(obj.otype.value.length==0)
  {
    alert('请选择-缴费方式');
    obj.otype.focus();
    return false;
  }

  if (!checkValue(obj)){return;}

  if(!fcheck(obj.indivcont)||
  !fcheck(obj.empcont)||
  !fcheck(obj.laborage)||
  !fcheck(obj.year)||
  !fcheck2(obj.wagerise)||
  !fcheck(obj.life)||
  !fcheck2(obj.syl))
    return ;
//||  !fcheck(obj.atc001)
   obj.submit();
}
</script>
<html>
	<head><title>企业年金管理信息系统</title> <base target = '_self'></head><link href='cssjs/style2.css' rel='stylesheet' type='text/css'><script src='cssjs/Globals.js'></script><script src='cssjs/validate.js'></script>
	<body leftmargin="0" topmargin="0" onload="page_init()">
		<table class=navigation>
		<tr>
			<td  onmousemove="this.title='';this.style.color='#FF0000'"  onmouseout="this.style.color='#000000';" >◆	替代率计算</td>
		</tr>
</TABLE>
		<table class=tableTitle>
		<tr>
			<td style='word-break:keep-all'>替代率计算</td>
		</tr>
</TABLE>

<form name="ReplaceRateForm" method="POST" action="" onsubmit="return checkValue(this);">
		<table class="TableInput">
			<COLGROUP><COL width='16%'><COL width='17%'><COL width='16%'><COL width='17%'><COL width='16%'><COL width='17%'></COLGROUP>
				<tr>
	<td><font color='#FF0000'>*</font>缴费方式</td><td>
          <select name="otype"  label="缴费方式" >
            <option value="">---------请选择---------
	    <option value="12" <%if(otype==12)out.print(" SELECTED ");%>>月缴费
	    <option value="4" <%if(otype==4)out.print(" SELECTED ");%>>季缴费
	    <option value="2" <%if(otype==2)out.print(" SELECTED ");%>>半年缴费
	    <option value="1" <%if(otype==1)out.print(" SELECTED ");%>>年缴费
	    </select></td>
	</tr>
                          <tr>
				<td><font color='#FF0000'>*</font>个人月缴费额</td><td colspan="1"><textarea style='width:100%'  name="indivcont" mask="nnnnnnn.nn" label="个人月缴费额" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(indivcont);%></textarea></td>
				<td><font color='#FF0000'>*</font>企业月缴费额</td><td colspan="1"><textarea style='width:100%'  name="empcont" mask="nnnnnnn.nn" label="企业月缴费额" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(empcont);%></textarea></td>
			</tr>
			<tr>
				<td><font color='#FF0000'>*</font>退休前月工资<!--月平均工资--></td><td colspan="1"><textarea style='width:100%'  name="laborage" mask="nnnnnnn.nn" label="退休前工资" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(laborage);%></textarea></td>
				<td><font color='#FF0000'>*</font>缴费年数</td><td colspan="1"><textarea style='width:100%'  name="year" mask="nn" label="缴费年数" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(year);%></textarea></td>
			</tr>
			<tr>
			<!-- 	<td><font color='#FF0000'>*</font>缴费增长率%</td><td colspan="1"><textarea style='width:100%'  name="gkrise" mask="nnn" label="缴费增长率%" required="true" disable="false" cols="20" rows="1" class="mask"></textarea></td> -->
				<td><font color='#FF0000'>*</font>工资增长率%</td><td colspan="1"><textarea style='width:100%'  name="wagerise" mask="nnn.nnnn" label="工资增长率%" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(request.getParameter("wagerise"));%></textarea></td>
				<td><font color='#FF0000'>*</font>年金领取年数</td><td colspan="1"><textarea style='width:100%'  name="life" mask="nn" label="年金领取年数" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(life);%></textarea></td>
			</tr>
			<!--<tr>
				 <td><font color='#FF0000'>*</font>通货膨胀率%</td><td colspan="1"><textarea style='width:100%'  name="thpzl" mask="nnn" label="通货膨胀率%" required="true" disable="false" cols="20" rows="1" class="mask"></textarea></td>

			</tr>-->
			<tr>
				<td><font color='#FF0000'>*</font>年金收益率%</td><td colspan="1"><textarea style='width:100%'  name="syl" mask="nnn.nnnn" label="年金收益率%" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(request.getParameter("syl"));%></textarea></td>
				<td><font color='#FF0000'>*</font>个人目前累计缴费额</td><td colspan="1"><textarea style='width:100%'  name="atc001" mask="nnnnnnn.nn" label="个人目前累计缴费额" required="true" disable="false" cols="20" rows="1" class="mask"><%if(post)out.print(atc001);%></textarea></td>
			</tr>
			<tr>
				<td>
					<font color="#FF0000">注意</font></td>
<td colspan="5" align="left">本计算结果仅用于参考&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td nowrap>替代率%</td><td colspan="1"><input type = 'hidden' name='replace' value="" /><label><%if(post&&t!=null)out.print(nf.format(t));%></label></td>
				<td colspan="2" >&nbsp</td>
			</tr>
</table>
</form>

<table class='tableInput' width='95%' height='35' border='0' align='center' cellspacing='0' ><tr><td><table width='140' height='31' border='0' align='right' cellpadding='0' cellspacing='0'><tr><td><input class='buttonGray' type='button' onclick="epamsaccount(document.forms[0])" value='计算'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='buttonGray' type='button' onclick="clearForm(document.forms[0])" value='重置'>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table></td></tr></table><table width='95%' height='1' border='0' align='center' cellpadding='0' cellspacing='0'><tr><td height='1' class='BottomlineColor'></td></tr></table>

</body>
</html>



