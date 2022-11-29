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
  return result;//.setScale(40,4);
}
java.text.DecimalFormat nf=new java.text.DecimalFormat("#,##0.00");
java.text.DecimalFormat nf2=new java.text.DecimalFormat("0.0000");
%><%

// http://ceb.redcome.com/jsp/admin/cebbank/CalPension2.jsp?ageNumber=11&sexNumber=1&payWayNumber=1&laborageNumber=1&payScaleNumber1=1&payScaleNumber2=1&increaseRateNumber=1&yieldNumber=1&addUpPayNumber=1&getWayType=1

System.out.println("==============");
int life=0;

BigDecimal p1=null;
BigDecimal p2=null;
BigDecimal r2=null;
BigDecimal syl=null;
BigDecimal pv=null;
BigDecimal sn=null;
BigDecimal p4=null;
//解决1.4不存在的常量问题
BigDecimal ONE=new BigDecimal("1");
try
{
  int wtype=Integer.parseInt(request.getParameter("getWayType"));//领取方式
  int otype=Integer.parseInt(request.getParameter("payWayNumber"));//缴费方式
  switch(otype)//既 "月缴费", "季缴费", "半年缴费", "年缴费"分别一次为1、2、3、4;
  {
    case 1:
    otype=12;
    break;
    case 2:
    otype=4;
    break;
    case 3:
    otype=2;
    break;
    case 4:
    otype=1;
    break;
    default:
    return;
  }
  System.out.println("缴费方式:"+otype);

  BigDecimal s=new BigDecimal(request.getParameter("laborageNumber"));//月工资

  BigDecimal cp=new BigDecimal(request.getParameter("payScaleNumber1")).divide(BigDecimal.valueOf(100L),4,4);//个人缴费比例
  p1=s.multiply(cp);//个人月缴费额
  System.out.println("个人月缴费额:"+p1);

  BigDecimal ce=new BigDecimal(request.getParameter("payScaleNumber2")).divide(BigDecimal.valueOf(100L),4,4);//企业缴费比例
  p2=s.multiply(ce);//企业月缴费额
  System.out.println("企业月缴费额:"+p2);

  r2=new BigDecimal(request.getParameter("increaseRateNumber")).divide(BigDecimal.valueOf(100L),4,4);//工资年增长率%
  System.out.println("工资年增长率:"+r2);

  syl=new BigDecimal(request.getParameter("yieldNumber")).divide(BigDecimal.valueOf(100L),4,4);//年金收益率%
  System.out.println("年金收益率:"+syl);
  if(wtype==2)
  {
    life=Integer.parseInt(request.getParameter("getYearNumber").trim());//年金领取年数                    M
  }
  System.out.println("年金领取年数:"+life);

  int year=(Integer.parseInt(request.getParameter("sexNumber"))==1?60:55)-Integer.parseInt(request.getParameter("ageNumber"));//缴费年数 N
  System.out.println("缴费年数:"+year);

  pv=new BigDecimal(request.getParameter("addUpPayNumber"));//个人目前累计缴费额          Pv
  System.out.println("个人目前累计缴费额:"+pv);

  BigDecimal p3=p1.add(p2).multiply(new BigDecimal(12/otype));//月缴费合计
  System.out.println("P3: 月缴费合计:"+p3);

  int n=year*otype;
  int m=life*12;

  BigDecimal bd=ONE.divide(new BigDecimal(otype),32,4);//   1/12
  BigDecimal r1=syl.multiply(bd);//月投资收益率

  //System.out.println(r1);
  BigDecimal r1_12=f(ONE.add(r1),otype); //(1+r1) ^ 12
  BigDecimal r1_1=r1.add(ONE);        //1+r1
  BigDecimal r2_1=r2.add(ONE);        //1+r2

  if(otype!=1)
  {
    /*
    System.out.println("1/"+otype+" \t:"+bd);
    System.out.println("syl \t:"+syl);
    System.out.println("r1 \t:"+r1);
    System.out.println("1+r1 \t:"+ONE.add(r1));
    System.out.println("(1+r1)^n \t:"+f(ONE.add(r1),n));
    */
    if(r1.floatValue()!=0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))!=0)
    {
      sn=p3.multiply(f(ONE.add(r1),n).subtract(f(ONE.add(r2),year)));//      p3*[(1+r1)^n-(1+r2)^n]
      //
      sn=sn.multiply(r1_12).divide(r1_12.subtract(ONE.add(r2)),10,4); //  (1+r1)^12 / (1+r1)^12-(1+r2)
      sn=sn.multiply(ONE.subtract(ONE.divide(r1_12,10,4)));//  1-(1/(1+r1)^12)
      sn=sn.multiply(r1_1.divide(r1,10,4));//  (1+r1)/r1
      sn=sn.add(pv.multiply(f(r1_1,n))); // pv*(1+r1)^n
      //    System.out.println(r1_12);
    }else
    if(r1.floatValue()!=0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))==0)
    {
      sn=new BigDecimal(year).multiply(p3).multiply(f(r1_1,n)).multiply(ONE.subtract(ONE.divide(r1_12,10,4))).multiply(r1_1.divide(r1,10,4)).add(pv.multiply(f(r1_1,n)));
    }else
    if(r1.floatValue()==0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))!=0)
    {
      sn=p3.multiply(new BigDecimal(12)).multiply(f(ONE.add(r2),year).subtract(ONE)).multiply(ONE.divide(r2,10,4)).add(pv);
    }else
    if(r1.floatValue()==0&&ONE.add(r2).compareTo(f(ONE.add(r1),otype))==0)
    {
      sn=new BigDecimal(n).multiply(p3).add(pv);
    }

  }else//（按年缴费）（年缴费频率为1）
  {
    if(r1.floatValue()!=0&&ONE.add(r2).compareTo(ONE.add(r1))!=0)
    {
      sn=p3.multiply(f(ONE.add(r1),n).subtract(f(ONE.add(r2),year)));//
      sn=sn.multiply(ONE.add(r1).divide(r1.subtract(r2),32,4)); //
      sn=sn.add(pv.multiply(f(ONE.add(r1),n))); // pv*(1+r1)^n
    }else
    if(r1.floatValue()!=0&&ONE.add(r2).compareTo(ONE.add(r1))==0)
    {
      sn=new BigDecimal(year).multiply(p3).multiply(f(ONE.add(r1),n));
      sn=sn.add(pv.multiply(f(ONE.add(r1),n)));
    }else
    if(r1.floatValue()==0&&ONE.add(r2).compareTo(ONE.add(r1))!=0)
    {
      sn=p3.multiply(f(ONE.add(r2),year).subtract(ONE)).multiply(ONE.divide(r2,32,4)).add(pv);
    }else
    if(r1.floatValue()==0&&ONE.add(r2).compareTo(ONE.add(r1))==0)
    {
      sn=new BigDecimal(n).multiply(p3).add(pv);
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
  sn=sn.setScale(2,4);

  int ageNumber=Integer.parseInt(request.getParameter("ageNumber"));
  String sexNumber=request.getParameter("sexNumber");
  String payScaleNumber=request.getParameter("payScaleNumber");
  String increaseRateNumber=request.getParameter("increaseRateNumber");
  String yieldNumber=request.getParameter("yieldNumber");
  String str="<xml ageNumber=\""+ageNumber+"\" sexNumber=\""+sexNumber+"\" payWayNumber=\""+otype+"\" laborageNumber=\""+s.toString()+"\" payScaleNumber=\""+payScaleNumber+"\" increaseRateNumber=\""+increaseRateNumber+"\" yieldNumber=\""+yieldNumber+"\" addUpPayNumber=\""+pv+"\" drawNumber=\""+nf.format(wtype==2?p4:sn)+"\"></xml>";
  //System.out.println(str);

  out.print(str);
}catch(Exception e)
{
  out.print("<script>alert('输入值非法,请检查.');</script>");
  e.printStackTrace();
}

%>
