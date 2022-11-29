<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*"  %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.htmlx.*" %>
<%@page import="tea.entity.admin.sales.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");


StringBuffer sql=new StringBuffer();
int workproject=0;
if(request.getParameter("workproject")!=null)
{
  workproject=Integer.parseInt(request.getParameter("workproject"));
  sql.append(" AND workproject=").append(workproject);
}
String name=null,tel=null,fax=null,url=null,email=null,content=null;
int type=0;
int employee=50;
int calling=0;
String earning=null;// 年收入
	// /////////开单地址
String country=null;
String postcode=null;
String state=null;
String city=null;
String street=null;
	// /////////发货地址
String country2=null;
String postcode2=null;
String state2=null;
String city2=null;
String street2=null;
int cost=0;
int overallmoney =0;
if(workproject>0)
{
  Workproject obj=Workproject.find(workproject);
  name=obj.getName(teasession._nLanguage);
  tel=obj.getTel();
  fax=obj.getFax();
  url=obj.getUrl();
  email=obj.getEmail();
  content=obj.getContent(teasession._nLanguage);

  type=obj.getType();
  employee=obj.getEmployee();
  calling=obj.getCalling();
  earning=obj.getEarning();

  country=obj.getCountry();
  postcode=obj.getPostcode();
  state=obj.getState();
  city=obj.getCity();
  street=obj.getStreet();

  country2=obj.getCountry2();
  postcode2=obj.getPostcode2();
  state2=obj.getState2();
  city2=obj.getCity2();
  street2=obj.getStreet2();
 // cost = obj.getCost();
 // overallmoney = obj.getOverallmoney();
}

String nexturl=request.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="">
<form name=form1 METHOD=get action="/servlet/EditWorkreport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="workproject" value="<%=workproject%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>
  <input type=hidden name="action" value="editworkproject"/>
  <h2>项目基本信息 </h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
    int flowitem = 0 ;

    if(request.getParameter("flowitem")!=null&&request.getParameter("flowitem").equals("kong"))
    {
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%out.print("<font color=red>暂无项目</font>");%></td>
    </tr>
   <%
     return ;
    }
    else if(request.getParameter("flowitem")!=null){
       flowitem = Integer.parseInt(request.getParameter("flowitem"));
    }


    Flowitem itemObj = Flowitem.find(flowitem) ;
    String webmaster = "webmaster" ;
    String manager = webmaster, member = webmaster, itemName = webmaster;

    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    java.util.Date itemTimes = new java.util.Date() ;
    String str_date = formatter.format(itemTimes); //将日期时间格式化
    String itemTime = str_date ;
    if(itemObj.getManager()!=null)
    {
     manager = itemObj.getManager() ;
    }
    if(itemObj.getMember()!=null)
    {
       member = itemObj.getMember() ;
    }
    if(itemObj.getName(teasession._nLanguage)!=null)
    {
      itemName = itemObj.getName(teasession._nLanguage) ;
    }
    if(itemObj.getFtime()!=null)
    {
      itemTime = itemObj.getFtimeToString() ;
    }

    %>
    <tr>
    <td nowrap>项目名称</td>
    <td><%=itemName%></td>
    <td nowrap>项目经理</td>
    <td>
     <%
     for (int i = 0; i < manager.split("/").length; i++) {
       tea.entity.member.Profile probj = tea.entity.member.Profile.find(manager.split("/")[i]);
       %><%=probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)%>
    <%}%>    </td>
    </tr>
     <tr>
    <td nowrap>预计完工时间</td>
    <td><%=itemTime %></td>
    <td nowrap>项目类型</td>
    <td><%=itemObj.ITEMGENRE_TYPE[itemObj.getItemgenre()]%></td>
    </tr>
    <tr>
    <td nowrap>项目参与者</td>
    <td colspan="4"><%
     for (int i = 0; i < member.split("/").length; i++)
     {
       tea.entity.member.Profile probj = tea.entity.member.Profile.find(member.split("/")[i]);
       %>
      <%=probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)%>
      <%}%></td>
    </tr>
    <tr>
    <td nowrap >项目说明</td>
   <td colspan="4">
    <%
    String itemContent = webmaster ;
    if(itemObj.getContent(teasession._nLanguage)!=null)
    {
      itemContent = itemObj.getContent(teasession._nLanguage) ;
    }
    out.println(""+itemContent+"");

    %></td></tr>
  </table>
  <%
  if(itemName!=null && itemName.length()>0)
  {
  %>
      <h2>  <a href="/jsp/admin/workreport/EditFlowitem.jsp?community=REDCOME&flowitem=<%=flowitem%>&workproject=<%=itemObj.getWorkproject()%>" target="m">编辑项目基本信息</a> </h2>
  <%
  }
  %>


    <h2>项目成本核算</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
    	<td nowrap>项目总耗时</td>
    	<td nowrap>实耗成本</td>
    	<td nowrap>预计成本</td>
    	<td nowrap>剩余成本</td>
    	<td nowrap>总金额</td>
    </tr>
    <%
	if(flowitem>0)
	{
		Flowitem flobj = Flowitem.find(flowitem);
		cost =  flobj.getCost();
		overallmoney=flobj.getOverallmoney();
	}

	java.util.Enumeration worme = Worklog.find(teasession._strCommunity," and workproject="+flowitem,0,Integer.MAX_VALUE);
	int hours = 0;//小时
	float minutes =0;//分钟
	float wear = 0;//总耗时 以小时为单位
	int wagetype =0;//工资标准
	float c =0;//成本费用
	float cc =0;
	float aa =0;
    for(int i=0;worme.hasMoreElements();i++)
    {
      int id = ((Integer)worme.nextElement()).intValue();
      Worklog worobj = Worklog.find(id);
      minutes = minutes+worobj.getWearMinutes();
      hours = hours+worobj.getWearHours();
      //求出员工的工资标准
      Profile probj = Profile.find(worobj.getMember());
      wagetype =  probj.getWagetype()/20/8;//1小时这个用户的工资
      aa = worobj.getWearMinutes();
      cc =  (worobj.getWearHours() +(aa/60));
      c =c+ (wagetype*cc);//算出一个用户根据工资标准的 成本
    }
	minutes = minutes/60;
	wear = hours+ minutes;
	int chengben = 0;
	chengben = (int)c;
     %>
     <td><a href="/jsp/admin/workreport/Reckon.jsp?workproject=<%=flowitem %>"><%=Worklog.dff.format(wear) %></a>&nbsp;小时</td>
     <td><%=chengben %></td>
     <td><%=cost %></td>
     <td><%=(cost-chengben) %></td>
     <td><%=overallmoney %></td>
    <tr>

    </tr>
 </table>
    <%
     // Flowitem.setEatype(community," AND type = 0 ");
     int eatype =itemObj.getEatype();
   %>
   <h2>项目统计&nbsp;(&nbsp;<%if(eatype==0){out.print("盈利项目");}else if(eatype==1){out.print("非盈利项目");} %>&nbsp;)&nbsp;</h2>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>总体收入</td>
        <td nowrap>实际收入</td>
        <td nowrap>市场费用</td>
        <td nowrap>人员成本</td>
        <td nowrap>其它成本</td>
        <td nowrap> <%if(eatype==0){ out.print("公司利润");}else if(eatype==1){out.print("公司投入");}//（自动计算：实际收入-市场费用-人员成本-其它成本，然后去负号）}%></td>
       <%if(eatype==0){ %> <td nowrap>人员奖金</td><%} %>

      </tr>
      <%

      //人员奖金=实际收入-市场费用-人员成本-其它成本-公司利润）
      java.math.BigDecimal bonus = new java.math.BigDecimal("0");
      java.math.BigDecimal profits = new java.math.BigDecimal("0");
      java.math.BigDecimal gs = new java.math.BigDecimal("0");
      int fid = flowitem;
      Flowitem fobj = Flowitem.find(fid);
      if(eatype==0)
        {//盈利项目时候

      //  profits=fobj.getProfits(); //公司利润

        //自动计算：实际收入-市场费用-人员成本-其它成本
        gs =  Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2"));
        //如果 gs> 预计利润 则 公司利润显示 是 预计利润 人员奖金 显示为 余数
        if(gs.compareTo(fobj.getProfits())==1)
        {
          profits =fobj.getProfits();
          bonus = Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2")).subtract(fobj.getProfits());
        }else if(gs.compareTo(fobj.getProfits())==0)
        {
           profits =fobj.getProfits();
        }else if (gs.compareTo(fobj.getProfits())==-1)
        {
          profits =gs;
        }
      }else if(eatype==1)//非盈利项目
      {
        //公司投入（自动计算：实际收入-市场费用-人员成本-其它成本，然后去负号）
        profits = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 "));
        profits=new java.math.BigDecimal("0").subtract(profits);
      }
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <td ><%=itemObj.getOverallmoney()%></td>
       <td ><%=Already.getAmountTotalSum(fid," and atype=0")%></td>
       <td  title="<%=itemObj.getMarketexplain(teasession._nLanguage)%>"><%=Already.getAmountTotalSum(fid," and atype=1")%></td>
       <td ><%=Worklog.getMembercost(teasession._strCommunity,fid)%></td>
       <td  title="<%=itemObj.getOtherexplain(teasession._nLanguage)%>"><%=Already.getAmountTotalSum(fid," and atype=2")%></td>
       <td ><%=profits%></td>
     <%  if(eatype==0){%>  <td ><%=bonus%></td><%} %>
       </tr>
       </table>
  <h2>客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168575002906")%>
        <!--名称--></td>
      <td><%if(name!=null)out.print(name);%></td>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><%if(tel!=null)out.print(tel);%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574969234")%>
        <!--传真--></td>
      <td><%if(fax!=null)out.print(fax);%></td>
      <td>URL</td>
      <td><%if(url!=null)out.print(url);%></td>
    </tr>
    <tr>
      <td>E-Mail</td>
      <td><%if(email!=null)out.print(email);%></td>
    </tr>
  </table>
  <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>类型</td>
      <td ><%=r.getString(teasession._nLanguage,Workproject.CLIENT_TYPE[type])%></td>
      <td>职员数</td>
      <td><%=employee%></td>
    </tr>
    <tr>
      <td>行业</td>
      <td><%=r.getString(teasession._nLanguage,Common.SALES_CALLING[calling])%></td>
      <td>年收入</td>
      <td><%if(earning!=null)out.print(earning);%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Text")%>
        <!--内容--></td>
      <td><%if(content!=null)out.print(content);%></td>
    </tr>
    <tr>
      <td>开单地址 - 国家/地区</td>
      <td ><%=new CountrySelection(teasession._nLanguage,country)%></td>
      <td> 发货地址 - 国家/地区 </td>
      <td ><%=new CountrySelection(teasession._nLanguage,country2)%></td>
    </tr>
    <tr>
      <td> 开单地址 - 邮政编码 </td>
      <td><%if(postcode!=null)out.print(postcode);%></td>
      <td> 发货地址 - 邮政编码 </td>
      <td><%if(postcode2!=null)out.print(postcode2);%></td>
    </tr>
    <tr>
      <td> 开单地址 - 州/省 </td>
      <td ><%if(state!=null)out.print(state);%></td>
      <td> 发货地址 - 州/省 </td>
      <td><%if(state2!=null)out.print(state2);%></td>
    </tr>
    <tr>
      <td> 开单地址 - 城市 </td>
      <td><%if(city!=null)out.print(city);%></td>
      <td> 发货地址 - 城市 </td>
      <td><%if(city2!=null)out.print(city2);%></td>
    </tr>
    <tr>
      <td>开单地址 - 街道</td>
      <td><%if(street!=null)out.print(street);%></td>
      <td> 发货地址 - 街道 </td>
      <td><%if(street2!=null)out.print(street2);%></td>
    </tr>
  </table>

    <h2>联系人</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap><%=r.getString(teasession._nLanguage,"1168575002906")%></td>
         <td nowrap><%=r.getString(teasession._nLanguage,"1168574945796")%></td>
         <td nowrap>E-Mail</td>
         <td nowrap><!--邮编-->
         <%=r.getString(teasession._nLanguage,"1168575152750")%></td>
         <td nowrap><!--时间-->
         <%=r.getString(teasession._nLanguage,"CreateTime")%></td>
         <td></td>
     </tr><%
       java.util.Enumeration exe=Worklinkman.find(community,sql.toString(),0,200);
       for(int i=1;exe.hasMoreElements();i++)
       {

         String  members =((String)exe.nextElement().toString());
         Worklinkman work = Worklinkman.find(community,members);


       %>
         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=i%></td>
    <td nowrap>&nbsp;<a href="/jsp/admin/workreport/EditWorklinkman.jsp?community=<%=teasession._strCommunity%>&member=<%=members%>"><%=members%></a></td>
    <td nowrap>&nbsp;<%=work.getMobile()%></td>
    <td>&nbsp;<a href="mailto:<%=work.getEmail()%>" ><%=work.getEmail()%></a></td>
    <td>&nbsp;<%=work.getPostcode()%></td>
    <td>&nbsp;<%=work.getBirthdayToString()%></td>

 </tr>
       <%
       }
       %>
</table>
</form>
</body>
</html>



