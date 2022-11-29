<%@page contentType="application/x-msdownload;charset=UTF-8" %><%@ page import="tea.ui.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%!

public static final java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMMdd");
public static java.util.Calendar c=java.util.Calendar.getInstance();

%><%//
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setHeader("Content-Disposition", "attachment;filename="+System.currentTimeMillis()+".xml");

if(!request.getRemoteAddr().equals("127.0.0.1"))
{
//  response.sendError(404);
//  return;
}
//String community=request.getParameter("community");
StringBuffer sb=new StringBuffer();
int language=1;
int job_id=0;
String resumes[];

sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n");
sb.append("<APPLICANTS>\r\n");
try
{
  if(request.getParameter("applyAmount")!=null)
  job_id=Integer.parseInt(request.getParameter("applyAmount"));
}catch(Exception e)
{
  System.out.println(e.getMessage());
  return;
}
resumes=request.getParameterValues("Node");
//Enumeration enumer=Apply.find(start);
for(int count=0;count<resumes.length;count++)
{
  Apply obj=Apply.find(job_id,Integer.parseInt(resumes[count]));
  Resume resume=Resume.find(obj.getResumeNode(),language);
  Node node=Node.find(obj.getResumeNode());
//  if(resume.getMember()==null)
if(node.getCreator()==null)
  continue ;

  String member=node.getCreator()._strV;

  Profile profile=Profile.find(member,node.getCommunity());

  Job job=Job.find(obj.getCorpNode(),language);
  tea.entity.node.Company company=tea.entity.node.Company.find(job.getSltOrgId());

//  Inhabit inhabit=Inhabit.findByLast(resume.getMember());


  sb.append("  <APPLICANT>\r\n");
//  sb.append("    <AP_GROUP>"+job.getSongroup()+"</AP_GROUP>\r\n");//应聘者分组   //对应员工子组，从广告中获取
  sb.append("    <AP_SUBGRP>"+company.getAptyp()+"</AP_SUBGRP>\r\n");//应聘者范围  //固定为99：中国海油招聘平台
//  sb.append("    <PERS_AREA>"+job.getPersonelarea()+"</PERS_AREA>\r\n");//人事范围  //对应人事范围，从广告或从招聘机构中获得
//  sb.append("    <P_SUBAREA>"+1000+"</P_SUBAREA>\r\n");//人事子范围  //固定为1000  job.getSubarea()
//  sb.append("    <PERSONNEL>"+job.getPersonelofficer()+"</PERSONNEL>\r\n");//应聘者管理员
sb.append("    <PERSONNEL></PERSONNEL>\r\n");
  sb.append("    <USER_ID>EX"+member+"</USER_ID>\r\n");//招聘平台用户名
  sb.append("    <F_NAME>"+profile.getFirstName(language)+"</F_NAME>\r\n");//姓
  sb.append("    <L_NAME>"+profile.getLastName(language)+"</L_NAME>\r\n");//名
  sb.append("    <BIRTHNAME></BIRTHNAME>\r\n");//别名
  sb.append("    <B_DATE>"+sdf.format(profile.getBirth(language))+"</B_DATE>\r\n");//生日
  sb.append("    <GENDER>"+(profile.isSex()?"1":"2")+"</GENDER>\r\n");//性别       1男 2女
  sb.append("    <BIRTHPLACE>"+profile.getGbort(language)+"</BIRTHPLACE>\r\n");//出生地

  int famst=profile.getFamst();
  if(famst>0)
  famst--;
  else
  if(famst==0)
  famst=6;
  sb.append("    <MAR_STAT>"+famst+"</MAR_STAT>\r\n");//婚姻状况:0单身 1已婚 2寡居 3离异 5分居 6未知
  sb.append("    <NATION>"+profile.getCountry(language)+"</NATION>\r\n");//国籍

  sb.append("    <STREET></STREET>\r\n");//住宅号及街道
  sb.append("    <SECOND_ADD_LN></SECOND_ADD_LN>\r\n");//住宅号及街道-行2
  sb.append("    <CITY>"+profile.getCity(language)+"</CITY>\r\n");//城市State
  sb.append("    <REGION>"+profile.getState(language)+"</REGION>\r\n");//地区 (州、省、县)
  sb.append("    <DISTRICT></DISTRICT>\r\n");
  sb.append("    <PCD_CITY>"+profile.getZip(language)+"</PCD_CITY>\r\n");//邮政编码
  sb.append("    <CNTRY>"+profile.getCountry(language)+"</CNTRY>\r\n");//国家Country
  sb.append("    <TEL_NO>"+profile.getTelephone(language)+"</TEL_NO>\r\n");//住宅电话
  sb.append("    <ADVERT>"+job.getAdcode()+"</ADVERT>\r\n");//广告编号
  sb.append("    <EMPLOYEENUMBER></EMPLOYEENUMBER>\r\n");//海油员工号
  sb.append("    <E_MAIL>"+profile.getEmail(language)+"</E_MAIL>\r\n");//电子邮件
  sb.append("    <ZZHKSZD>"+profile.getZzhkszd(language)+"</ZZHKSZD>\r\n");//户口所在地

  sb.append("    <ZZJIGUAN_SHENG>"+profile.getState(language)+"</ZZJIGUAN_SHENG>\r\n");//籍贯（省市下拉选择）
  sb.append("    <ZZJIGUAN_NOTE>"+profile.getAddress(language)+"</ZZJIGUAN_NOTE>\r\n");//籍贯（描述）
  sb.append("    <ZZGATWJ>"+(profile.isZzgatwj()?"X":" ")+"</ZZGATWJ>\r\n");//港澳台或外籍人士  zzgatwj
  sb.append("    <ZZNYHK>"+(profile.isZznyhk()?"X":" ")+"</ZZNYHK>\r\n");//是否农业户口  zznyhk
  sb.append("    <ZZPRIDN>"+profile.getZzpridn()+"</ZZPRIDN>\r\n");//个人身份 09=其它
  sb.append("    <ZZFMBKG>"+profile.getZzfmbkg()+"</ZZFMBKG>\r\n");//家庭出身 99=其它
  sb.append("    <ZZRACKY>"+profile.getZzracky()+"</ZZRACKY>\r\n");//民族分组
  sb.append("    <PCODE>"+profile.getPolity()+"</PCODE>\r\n");//政治面貌  polity
  sb.append("    <JOINU>"+resume.getJoinu()+"</JOINU>\r\n");//参加单位
  sb.append("    <INTR1>"+resume.getIntr1()+"</INTR1>\r\n");//介绍人 1
  sb.append("    <INTR2>"+resume.getIntr2()+"</INTR2>\r\n");//介绍人 2
  sb.append("    <ZCSZY>"+resume.getNowmaincareer()+"</ZCSZY>\r\n");//行业代码
  sb.append("    <ZXRGS>"+resume.getZxrgs()+"</ZXRGS>\r\n");//现任职公司名称

  sb.append("    <ZZWJB>"+resume.getNowcareerlevel()+"</ZZWJB>\r\n");//现职位级别  NowCareerLevel
  sb.append("    <ZGZJY>"+resume.getExperience()+"</ZGZJY>\r\n");//工作经验(年数) Experience
  sb.append("    <ZHWJL>"+(resume.isHasabroad()?"X":" ")+"</ZHWJL>\r\n");//有海外工作经历 Has_Abroad
  sb.append("    <ZMQYX>"+resume.getSalarysum()+"</ZMQYX>\r\n");//目前月薪(税前)  SalarySum
  sb.append("    <ZWAERS_MQYX>"+resume.getZwaers_yx()+"CNY</ZWAERS_MQYX>\r\n");//目前月薪货币代码

  sb.append("    <ZQWGZ>"+resume.getZqwgz()+"</ZQWGZ>\r\n");//期望工作性质



  //专业工种
  int zgz_index=1;
  String zgz_ec=resume.getExpectcareer();
  if(zgz_ec!=null)
  {
    java.util.StringTokenizer tokenizer=new StringTokenizer(zgz_ec,"/");
    while(tokenizer.hasMoreTokens())
    {
      String str=tokenizer.nextToken();
//      for(int index=0;index<tea.resource.Common.ZGZ.length;index++)
      {
        sb.append("    <ZGZ0"+zgz_index+">"+str+"</ZGZ0"+zgz_index+">\r\n"); //专业工种srcExpectCareer
        zgz_index++;
      }
    }
  }
  for(;zgz_index<=5;zgz_index++)
  sb.append("    <ZGZ0"+zgz_index+"></ZGZ0"+zgz_index+">\r\n");



  sb.append("    <ZQWYX>"+resume.getExpectsalarysum()+"</ZQWYX>\r\n");//期望月薪（税前）ExpectSalarySum
  sb.append("    <ZWAERS_QWYX>"+resume.getZwaers_qwyx()+"</ZWAERS_QWYX>\r\n");//期望月薪（税前货币代码)

  sb.append("    <ZDGSJ>"+resume.getJoindatetype()+"</ZDGSJ>\r\n");//到岗时间JoinDateType


  //期望工作地点
  int index=1;
  String ec=resume.getExpectcity();
  if(ec!=null)
  {
    java.util.StringTokenizer tokenizer=new StringTokenizer(ec,"/");
    while(tokenizer.hasMoreTokens())
    {
      String str=tokenizer.nextToken();
      sb.append("    <ZDD0"+index+">"+str+"</ZDD0"+index+">\r\n");//期望工作地点 ExpectCity
    }
  }
  for(;index<5;index++)
  sb.append("    <ZDD0"+index+"></ZDD0"+index+">\r\n");//期望工作地点 ExpectCity


  //自我评价
  String zpj=resume.getSelfvalue();
  if(zpj==null)
  zpj="";
  else
  zpj=zpj.replaceAll("&","&amp;").replaceAll("<","&lt;");
  int zpjlen=zpj.length();
  for(int i=1;i<5;i++)
  {
    int len=i*50;
    if(len>zpjlen)
    len=zpjlen;
    int from=(i-1)*50;
    if(from>zpjlen)
    from=zpjlen;
    sb.append("    <ZPJ0"+i+">"+zpj.substring(from,len)+"</ZPJ0"+i+">\r\n");//自我评价 SelfValueCN
  }


//职业目标
  String zmb=resume.getSelfaim();
  if(zmb==null)
  zmb="";
  else
  zmb=zmb.replaceAll("&","&amp;").replaceAll("<","&lt;");
  int zmblen=zmb.length();
  for(int i=1;i<=5;i++)
  {
    int len=i*50;
    if(len>zmblen)
    len=zmblen;
    int from=(i-1)*50;
    if(from>zmblen)
    from=zmblen;
    sb.append("    <ZMB0"+i+">"+zmb.substring(from,len)+"</ZMB0"+i+">\r\n");
  }


  //教育背景
  sb.append("    <EDUCATION>\r\n");
  java.util.Enumeration educate_enumer=Educate.find(resume.getNode(),language);
  while(educate_enumer.hasMoreElements())
  {
    int educate_id=((Integer)educate_enumer.nextElement()).intValue();
    Educate educate=Educate.find(educate_id);
    if (educate.getStart() == null)
    continue;
    String stop;
    if (educate.getStop()==null)
    stop="99991231";
    else
    {
      c.setTime(educate.getStop());
      if (c.get(c.YEAR)==3000)
      stop="99991231";
      else
      stop=sdf.format(educate.getStop());
    }
    String zzqtbz=educate.getComment().replaceAll("&","&amp;").replaceAll("<","&lt;");
    if(zzqtbz.length()>60)
    {
      zzqtbz=zzqtbz.substring(0,60);
    }
    sb.append("      <ITEM>\r\n");
    sb.append("        <BEGDA>"+sdf.format(educate.getStart())+"</BEGDA>\r\n");//开始日期
    sb.append("        <ENDDA>"+stop+"</ENDDA>\r\n");//结束日期
    sb.append("        <SLART>"+educate.getDegree()+"</SLART>\r\n");//学历
    sb.append("        <INSTI>"+educate.getSchool()+"</INSTI>\r\n");//毕业院校
    sb.append("        <SLAND>"+educate.getSland()+"</SLAND>\r\n");//国家代码

    String slabs=educate.getZzxlbh();
    if(!"".equals(slabs))
    if("ZB".equals(educate.getDegree()))
    {
      if(!"Z3".equals(slabs)&&!"Z4".equals(slabs))
      slabs="";
    }else
    if("ZA".equals(educate.getDegree()))
    {
      if(!"Z4".equals(slabs))
      slabs="";
    }else
    if("Z9".equals(educate.getDegree()))
    {
      if(!"Z3".equals(slabs))
      slabs="";
    }else
    if("Z8".equals(educate.getDegree()))
    {
      if(!"Z1".equals(slabs)&&!"Z2".equals(slabs))
      slabs="";
    }else
    slabs="";
    sb.append("        <SLABS>"+slabs+"</SLABS>\r\n");//学位zzxlbh
    sb.append("        <ANZKL>"+educate.getAnzkl()+"</ANZKL>\r\n");//学制anzkl
    sb.append("        <ANZEH>"+educate.getAnzeh()+"</ANZEH>\r\n");//描述学制时间/度量单位
    sb.append("        <ZZJYLX>"+(educate.isZzjylx()?"Q":"Z")+"</ZZJYLX>\r\n");//学历类型(全日制/在职教育)
    sb.append("        <ZZZYMC1>"+educate.getMajorName()+"</ZZZYMC1>\r\n");//专业名称1 tbMajorName
    sb.append("        <ZZZYMC2>"+educate.getZzzymc2()+"</ZZZYMC2>\r\n");//第二专业名称
    sb.append("        <ZZZGXL>"+(educate.isZzzgxl()?"X":" ")+"</ZZZGXL>\r\n");//最高学历
    sb.append("        <ZZZGXW>"+(educate.isZzzgxw()?"X":" ")+"</ZZZGXW>\r\n");//最高学位
    sb.append("        <ZZXLBH>"+educate.getZzxlbh()+"</ZZXLBH>\r\n");//学历证书编号
    sb.append("        <ZZXWSJ>"+(educate.getZzxwsj()==null?"99991231":sdf.format(educate.getZzxwsj()))+"</ZZXWSJ>\r\n");//学位授予时间
    sb.append("        <ZZXWJG>"+educate.getZzjgdz()+"</ZZXWJG>\r\n");//学位授予机构zzjgdz
    sb.append("        <ZZJGDZ>"+educate.getZzjgdz()+"</ZZJGDZ>\r\n");//教育机构地址
    sb.append("        <ZZXXXS>"+educate.getZzxxxs()+"</ZZXXXS>\r\n");//学习形式zzxxxs
    sb.append("        <ZZQTBZ>"+zzqtbz+"</ZZQTBZ>\r\n");//备注tbComment
    sb.append("        <ZZBSH>"+(educate.isZzbsh()?"X":" ")+"</ZZBSH>\r\n");//博士后
    sb.append("        <ZZXWBH>"+educate.getZzxlbh2()+"</ZZXWBH>\r\n");//学位证书编号zzxlbh
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </EDUCATION>\r\n");


  //工作经验
  sb.append("    <PREVIOUS_EMPLOYER>\r\n");
  java.util.Enumeration employment_enumer=Employment.find(resume.getNode(),language);
  while(employment_enumer.hasMoreElements())
  {
    int employment_id=((Integer)employment_enumer.nextElement()).intValue();
    Employment employment=Employment.find(employment_id);
    if (employment.getStartDate() == null)
    continue;
    String stop;
    if(employment.getEndDate()==null)
    {
      stop="99991231";
    }else
    {
      c.setTime(employment.getEndDate());
      if (c.get(c.YEAR)==3000)
      stop="99991231";
      else
      stop=sdf.format(employment.getEndDate());
    }
    sb.append("      <ITEM>\r\n");
    sb.append("        <BEGDA>"+sdf.format(employment.getStartDate())+"</BEGDA>\r\n");//开始日期
    sb.append("        <ENDDA>"+stop+"</ENDDA>\r\n");//结束日期 ymEndDate:ymYear
    sb.append("        <ARBGB>"+employment.getOrgName()+"</ARBGB>\r\n");//工作单位
    sb.append("        <ORT01>"+employment.getWorkSite()+"</ORT01>\r\n");//城市
    sb.append("        <LAND1>CN</LAND1>\r\n");//国家
    sb.append("        <BRANC>"+employment.getBranc()+"</BRANC>\r\n");//行业
    sb.append("        <ZZMR>"+employment.getZzmr()+"</ZZMR>\r\n");//工作经历证明人
    sb.append("        <ZZLXFS>"+employment.getZzlxfs()+"</ZZLXFS>\r\n");//工作经历证明人联系方式
    sb.append("        <ZZJLLX>"+(employment.getZzjllx()+1)+"</ZZJLLX>\r\n");//工作经历类型
    sb.append("        <ZZZWMC>"+employment.getPositionName()+"</ZZZWMC>\r\n");//职务名称 tbPositionName
    sb.append("        <ZZJRFS>"+employment.getZzjrfs()+"</ZZJRFS>\r\n");//加入方式zzjrfs
    sb.append("        <ZZPCDW>"+employment.getZzpcdw()+"</ZZPCDW>\r\n");//派出单位
    sb.append("        <ZZPCYY>"+employment.getZzpcyy()+"</ZZPCYY>\r\n");//派出原因
    sb.append("        <ZZJRLL>"+(employment.isZzjrll()?"X":" ")+"</ZZJRLL>\r\n");//兼职
    sb.append("        <ZZYGLX>"+employment.getZzyglx()+"</ZZYGLX>\r\n");//用工类型
    sb.append("        <ZZQTBZ>"+employment.getFunction()+"</ZZQTBZ>\r\n");//备注 tbFunction
    sb.append("        <ZZBM>"+employment.getDepartment()+"</ZZBM>\r\n");//部门  tbDepartment
    sb.append("        <ZZDCDW></ZZDCDW>\r\n");//调出单位
    sb.append("        <ZZDCYY>"+(employment.getZzdcyy()+1)+"</ZZDCYY>\r\n");//调出原因
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </PREVIOUS_EMPLOYER>\r\n");

//奖惩记录
  sb.append("    <COMMENDATION>\r\n");
  java.util.Enumeration award_enumer=Award.findByNode(resume.getNode(),language);
  while(award_enumer.hasMoreElements())
  {
    int award_id=((Integer)award_enumer.nextElement()).intValue();
    Award award=Award.find(award_id);
    if (award.getBegda() == null||award.getEndda()==null)
    continue;

    sb.append("      <ITEM>\r\n");
    sb.append("        <BEGDA>"+sdf.format(award.getBegda())+"</BEGDA>\r\n");//开始日期
    sb.append("        <ENDDA>"+sdf.format(award.getEndda())+"</ENDDA>\r\n");//结束日期
    sb.append("        <ZJLJB>"+award.getZjljb()+"</ZJLJB>\r\n");//奖励级别
    sb.append("        <ZJCMC>"+award.getZjcmc()+"</ZJCMC>\r\n");//奖惩名称
    sb.append("        <ZJCDW>"+award.getZjcdw()+"</ZJCDW>\r\n");//奖惩给与单位
    sb.append("        <ZJCYY>"+award.getZjcyy()+"</ZJCYY>\r\n");//奖惩原因
    sb.append("        <ZJCSJ>"+sdf.format(award.getZjcsj())+"</ZJCSJ>\r\n");//奖惩审批时间
    sb.append("        <ZJCBH>"+award.getZjcbh()+"</ZJCBH>\r\n");//奖惩审批文件编号
    sb.append("        <ZQTBZ1>"+award.getZqtbz1()+"</ZQTBZ1>\r\n");//备注
    sb.append("        <ZQTBZ2>"+award.getZqtbz2()+"</ZQTBZ2>\r\n");//备注
    sb.append("        <ZQTBZ3>"+award.getZqtbz3()+"</ZQTBZ3>\r\n");//备注
    sb.append("        <ZQTBZ4>"+award.getZqtbz4()+"</ZQTBZ4>\r\n");//备注
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </COMMENDATION>\r\n");

  //职业资格
  sb.append("    <CERTIFICATION>\r\n");
  java.util.Enumeration professional_enumer=Professional.find(resume.getNode(),language);
  while(professional_enumer.hasMoreElements())
  {
    int professional_id=((Integer)professional_enumer.nextElement()).intValue();
    Professional professional=Professional.find(professional_id);
    if (professional.getBegda() == null||professional.getEndda()==null)
    continue;
    sb.append("      <ITEM>\r\n");
    sb.append("        <BEGDA>"+sdf.format(professional.getBegda())+"</BEGDA>\r\n");//开始日期
    sb.append("        <ENDDA>"+sdf.format(professional.getEndda())+"</ENDDA>\r\n");//结束日期
    sb.append("        <ZZGLB>"+professional.getZzglb()+"</ZZGLB>\r\n");//职业资格类别
    sb.append("        <ZRZJB>"+professional.getZrzjb()+"</ZRZJB>\r\n");//认证级别
    sb.append("        <ZZGDM>"+professional.getZzgdm()+"</ZZGDM>\r\n");//职业资格代码
    sb.append("        <ZFZDW>"+professional.getZfzdw()+"</ZFZDW>\r\n");//发证单位
    sb.append("        <ZQZSJ>"+sdf.format(professional.getZqzsj())+"</ZQZSJ>\r\n");//取证时间
    sb.append("        <ZZSBH>"+professional.getZzsbh()+"</ZZSBH>\r\n");//证书编号
    sb.append("        <ZJDDW>"+professional.getZjddw()+"</ZJDDW>\r\n");//鉴定单位
    sb.append("        <ZQTBZ>"+professional.getZqtbz()+"</ZQTBZ>\r\n");//备注
    sb.append("        <ZQDZGTJ>"+professional.getZqdzgtj()+"</ZQDZGTJ>\r\n");//取得资格途径
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </CERTIFICATION>\r\n");
  /*
  //人员标志
  sb.append("    <FAMILY_MEMBER>\r\n");
  java.util.Enumeration inhabit_enumer=Inhabit.findByMember(resume.getMember());
  while(inhabit_enumer.hasMoreElements())
  {
    int id=((Integer)inhabit_enumer.nextElement()).intValue();
    Inhabit inhabit=Inhabit.find(id);
    sb.append("      <ITEM>\r\n");
    sb.append("        <FAMSA>"+inhabit.getAnssa()+"</FAMSA>\r\n");//家庭记录的类型
    sb.append("        <FGBDT>"+sdf.format(inhabit.getBegda())+"</FGBDT>\r\n");//出生日期
    sb.append("        <FGBLD>CN</FGBLD>\r\n");//出生国家
    sb.append("        <FANAT>国籍</FANAT>\r\n");//国籍
    sb.append("        <FASEX>性别代码</FASEX>\r\n");
    sb.append("        <FAVOR>名</FAVOR>\r\n");
    sb.append("        <FANAM>姓</FANAM>\r\n");
    sb.append("        <FGBOT>出生地</FGBOT>\r\n");
    sb.append("        <FGDEP>状态</FGDEP>\r\n");
    sb.append("        <ZZHKSZD>户口所在地</ZZHKSZD>\r\n");
    sb.append("        <ZZRACKY>民族血统</ZZRACKY>\r\n");
    sb.append("        <ZZGZDW>家庭成员工作单位名称</ZZGZDW>\r\n");
    sb.append("        <ZZZWMC>职务名称</ZZZWMC>\r\n");
    sb.append("        <ZZSLART>家庭成员文化程度</ZZSLART>\r\n");
    sb.append("        <STATU>工作状态</STATU>\r\n");
    sb.append("        <PSTAT>政治面貌</PSTAT>\r\n");
    sb.append("        <TELNR>电话号码</TELNR>\r\n");
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </FAMILY_MEMBER>\r\n");
  */

  //家庭成员
  sb.append("    <FAMILY_MEMBER>\r\n");
  java.util.Enumeration family_enumer=Family.find(resume.getNode(),language);
  while(family_enumer.hasMoreElements())
  {
    int family_id=((Integer)family_enumer.nextElement()).intValue();
    Family family=Family.find(family_id);

    sb.append("      <ITEM>\r\n");
    sb.append("        <FAMSA>"+family.getFamsa()+"</FAMSA>\r\n");//家庭记录的类型
    sb.append("        <FGBDT>"+sdf.format(family.getFgbdt())+"</FGBDT>\r\n");//出生日期
    sb.append("        <FGBLD>"+family.getFgbld()+"</FGBLD>\r\n");//出生国家
    sb.append("        <FANAT>"+family.getFanat()+"</FANAT>\r\n");//国籍
    sb.append("        <FASEX>"+(family.isFasex()?"1":"2")+"</FASEX>\r\n");//性别代码
    sb.append("        <FAVOR>"+family.getFavor()+"</FAVOR>\r\n");//名
    sb.append("        <FANAM>"+family.getFanam()+"</FANAM>\r\n");//姓
    sb.append("        <FGBOT>"+family.getFgbot()+"</FGBOT>\r\n");//出生地
    sb.append("        <FGDEP></FGDEP>\r\n");//状态
    sb.append("        <ZZHKSZD>"+family.getZzhkszd()+"</ZZHKSZD>\r\n");//户口所在地
    sb.append("        <ZZRACKY>"+family.getZzracky()+"</ZZRACKY>\r\n");//民族血统
    sb.append("        <ZZGZDW>"+family.getZzgzdw()+"</ZZGZDW>\r\n");//家庭成员工作单位名称
    sb.append("        <ZZZWMC>"+family.getZzzwmc()+"</ZZZWMC>\r\n");//职务名称
    sb.append("        <ZZSLART>"+family.getZzslart()+"</ZZSLART>\r\n");//家庭成员文化程度
    sb.append("        <STATU>"+family.getStatu()+"</STATU>\r\n");//工作状态
    sb.append("        <PSTAT>"+family.getPstat()+"</PSTAT>\r\n");//政治面貌
    sb.append("        <TELNR>"+family.getTelnr()+"</TELNR>\r\n");//电话号码
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </FAMILY_MEMBER>\r\n");

  ///语言能力///////////////////////////////////////
  sb.append("    <LANGUAGE>\r\n");
  java.util.Enumeration lang_enumer=Lang.find(resume.getNode(),language);
  while(lang_enumer.hasMoreElements())
  {
    int lang_id=((Integer)lang_enumer.nextElement()).intValue();
    Lang lang=Lang.find(lang_id);
    sb.append("      <ITEM>\r\n");
    sb.append("        <SPRSL>"+lang.getSprsl()+"</SPRSL>\r\n");//语种
    sb.append("        <ZTLNL>"+lang.getZtlnl()+"</ZTLNL>\r\n");//听力能力
    sb.append("        <ZKYNL>"+lang.getZkynl()+"</ZKYNL>\r\n");//口语能力
    sb.append("        <ZXZNL>"+lang.getZxznl()+"</ZXZNL>\r\n");//写作能力
    sb.append("        <ZYDNL>"+lang.getZydnl()+"</ZYDNL>\r\n");//阅读能力
    sb.append("        <ZDZDJ>"+lang.getZdzdj()+"</ZDZDJ>\r\n");//对照国家等级
    sb.append("        <ZBZ>"+lang.getZbz()+"</ZBZ>\r\n");//备注
    sb.append("      </ITEM>\r\n");
  }
  sb.append("    </LANGUAGE>\r\n");
  sb.append("  </APPLICANT>\r\n");
}
sb.append("</APPLICANTS>");



javax.servlet.ServletOutputStream os=response.getOutputStream();
os.print(sb.toString());

if(true)
return;
%>

