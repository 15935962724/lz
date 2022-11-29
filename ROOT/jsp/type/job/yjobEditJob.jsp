<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%

teasession._nLanguage=1;//强制改变当前的语言为简体中文
session.setAttribute("tea.Language", new Integer(1));
//response.setContentLength(101063);
int copyNode=teasession._nNode;
if(request.getParameter("copynode")!=null)
copyNode=Integer.parseInt(request.getParameter("copynode"));
Job job ;
String name,text;
 if((request.getParameter("NewNode")!=null||request.getParameter("NewBrother")!=null)&&copyNode==teasession._nNode)
 {job=Job.find(0,0);
 text=name="";
 }else
 {job= Job.find(copyNode, teasession._nLanguage);
 name=job.getName();
 text=Node.find(copyNode).getText(teasession._nLanguage);
 }

 String TYPE[][]={
{"勘探类","-- 石油地质","-- 地球物理勘探","-- 测井","-- 其他"},
{"开发类","-- 开发地质","-- 油藏工程","-- 其他"},
{"钻采类","-- 钻井","-- 完井","-- 采油","-- 油田化学","-- 其他"},
{"工程类","-- 工程项目管理","-- 工程设计","-- 工程制造","-- 工程安装","-- 工程维修","-- 其他"},
{"炼化气电","-- 炼油工艺","-- 炼油设备","-- 化工工艺","-- LNG","-- 发电","-- 管道","-- 其他"},
{"管理类","-- 财务/审计","-- 金融保险","-- 投资与经济评价","-- 规划/计划/统计","-- 资本运营","-- 市场营销","-- 物流管理","-- 合同/采办","-- 国际贸易","-- 法律","-- 安全环保","-- 行政管理","-- 党群工作","-- 人力资源","-- 科技管理","-- 新闻与媒体传播","-- 计算机与网络","-- 港口码头管理","-- 医学","-- 教育","-- 其他"},
{"工种","-- 采油操作工","-- 钻井司钻","-- 钻修工","-- 维修电工","-- 电器维修员","-- 发电工","-- 仪表工","-- 机工","-- 机电工（工程船舶）","-- 钳工（机修工）","-- 车工","-- 数控车工","-- 铆工","-- 焊工","-- 管工","-- 铣工","-- 起重工","-- 吊车司机","-- 铲/叉车司机","-- 起重水手","-- 水手","-- 潜水员","-- 测井全能操作手","-- 气爆主操","-- 探伤工","-- 外观检验员","-- 合成氨生产工","-- 尿素生产工","-- 化学检验工","-- 通讯工","-- 计算机及网络设备机务员","-- 一般秘书","-- 厨师","-- 司机","-- 物业","-- 其他"}
};
StringBuffer sb[]=new StringBuffer[7];
for(int indexlen=0;indexlen<sb.length;indexlen++)
{sb[indexlen]=new StringBuffer();
  for(int len=0;len<TYPE[indexlen].length;len++)
  {
    sb[indexlen].append("form1.sltOccId_list.options.add(new Option('"+TYPE[indexlen][len]+"','"+TYPE[indexlen][len]+"'));");
  }
}

%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>

<SCRIPT language="javascript">
<%@include file="EditJob.js" %>
</SCRIPT>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "CBNewJob")%></h1> 
<div id="head6"><img height="6" src="about:blank"></div>
<!--<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>-->
      <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
        <FORM NAME="form1" METHOD="post" action="/servlet/EditJob" onSubmit="return CheckForm();">
            <%    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
      String param="";

            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
                param="&NewNode=ON";
            }else
            if(request.getParameter("NewBrother")!=null)
            {param="&NewBrother=ON";
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }
          if(parambool)
   { out.print("<input type='hidden' name=nexturl value="+parameter+">");
   param=param+"&nexturl="+parameter;
}

            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
          <INPUT TYPE="hidden" NAME="hdnTodo" VALUE="save">
          <TR>
            <TD colspan="2"> <h2>职位发布</h2></TD>
          </TR>
          <TR>
            <TD>选择职位模板</TD>
            <TD> <SPAN>
              <SELECT  class="edit_input" NAME="sltJobTemplate" onChange="window.open('cnoocjobEditJob.jsp?node=<%=teasession._nNode+param%>&copynode='+window.document.form1.sltJobTemplate.options[window.document.form1.sltJobTemplate.selectedIndex].value,'_self')" STYLE="WIDTH: 222px">
                <OPTION VALUE=""></OPTION>
                <%java.util.Enumeration enumerationtype=Node.findByType(50,node.getCommunity());int nodetype;
                while(enumerationtype.hasMoreElements()){nodetype=((Integer)enumerationtype.nextElement()).intValue();
                if(nodetype!=teasession._nNode){%>
                <OPTION VALUE="<%=nodetype%>"><%=Node.find(nodetype).getSubject(teasession._nLanguage)%></OPTION>
                <%}}%>
              </SELECT>
              使用职位模板，不必重复输入相同信息。</SPAN></TD>
          </TR>
          <TR>
            <TD>* 职位名称
			</TD>
			<TD>
              <INPUT class="edit_input" NAME="txtJobTitle" TYPE="text" VALUE="<%=name%>" SIZE="30" MAXLENGTH="60" STYLE="WIDTH:222px">
            </TD>
          </TR><!--
          <TR>
            <TD ALIGN="right"><strong>职位编号&nbsp;</strong></TD>
            <TD>
              <INPUT class="edit_input" TYPE="hidden" NAME="txtRefCode" MAXLENGTH="30" VALUE="<%//=job.getTxtRefCode()%>">
            </TD>
          </TR>-->
          <TR>
            <TD>* 所属机构&nbsp;</TD>
            <TD><select  class="edit_input" name="sltOrgId" style="WIDTH: 292px">
              <option value="-1">--请选择--</option>
              <%int nodeCode;StringBuffer sbPurview=new StringBuffer();
              if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(tea.entity.site.Community.find(teasession._nNode).getJobMember()))
              {
                  Purview purview=Purview.find(teasession._rv.toString());
                  java.util.StringTokenizer tokenizer=new StringTokenizer(purview.getNode(),"/");

                  if(tokenizer.hasMoreTokens())
                  sbPurview.append(" and (node="+tokenizer.nextToken());
                  while(tokenizer.hasMoreTokens())
                  {
                      sbPurview.append(" OR node="+tokenizer.nextToken());
                  }
                  sbPurview.append(") ");
              }
   DbAdapter dbadapter = new DbAdapter(); Vector vector=new Vector();
        try
        {
            dbadapter.executeQuery("SELECT Node.node FROM Node  WHERE type=21 AND community="+dbadapter.cite(node.getCommunity())+sbPurview.toString()+" ORDER BY sequence");
            for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
        } catch (Exception exception)
        {
           exception.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
              java.util.Enumeration enumeration=vector.elements();
while(                enumeration.hasMoreElements()){
   nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
              <option value="<%=nodeCode%>" <%=getSelect(job.getSltOrgId()==nodeCode)%>><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></option>
              <%}%>
            </select>              <SPAN >轻松管理分公司或部门的职位和应聘简历。</SPAN></TD>
          </TR>
          <TR>
            <TD>* 职位性质&nbsp;</TD>
            <TD> <SELECT  class="edit_input"  NAME="sltJobType">
                <OPTION VALUE = "-1">--请选择--</OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="全职" <%=getSelect(job.getSltJobType().equals("全职"))%>>全职</OPTION>
<OPTION VALUE="兼职" <%=getSelect(job.getSltJobType().equals("兼职"))%>>兼职</OPTION>
<OPTION VALUE="临时" <%=getSelect(job.getSltJobType().equals("临时"))%>>临时</OPTION>
<OPTION VALUE="实习" <%=getSelect(job.getSltJobType().equals("实习"))%>>实习</OPTION>

              </SELECT> </TD>
          </TR>
          <TR>
            <TD>* 职业类别&nbsp;</TD>
            <TD> <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
                <TR>
                  <TD>
                      <SELECT  NAME="sltOccId_BigClass"  class="edit_input" "width:200px" onchange="alteroption(form1.sltOccId_BigClass.selectedIndex)" ><%-- %> ONCHANGE="javascript:SelectOption('Occupation',true, form1.sltOccId_BigClass,form1.sltOccId_list, '', '', '');">--%>
                      <OPTION VALUE="-1">--请选择职业--</OPTION>
                     <!--版本号：0002-->
<!--Action:1-->
<OPTION VALUE="勘探类">勘探类</OPTION>
<OPTION VALUE="开发类">开发类</OPTION>
<OPTION VALUE="钻采类">钻采类</OPTION>
<OPTION VALUE="工程类">工程类</OPTION>
<OPTION VALUE="炼化气电">炼化气电</OPTION>
<OPTION VALUE="管理类">管理类</OPTION>
<OPTION VALUE="工种">工种</OPTION>
                    </SELECT></TD>
                  <TD COLSPAN="2" > &nbsp;按住Ctrl键点击可多选，最多可选三项</TD>
                </TR>
                <TR>
                  <TD>
                  <SELECT class="edit_input" NAME="sltOccId_list"  SIZE="5" MULTIPLE STYLE="width:200px">
                   <Script language="javascript">SelectOption('Occupation',true, form1.sltOccId_BigClass,form1.sltOccId_list, '', '', '');//处理后退时条件保存不住的问题</Script>
                   <!--版本号：0002-->
<!--Action:1-->
<OPTION VALUE="勘探类">勘探类</OPTION>
<OPTION VALUE="石油地质">-- 石油地质</OPTION>
<OPTION VALUE="地球物理勘探">-- 地球物理勘探</OPTION>
<OPTION VALUE="测井">-- 测井</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="开发类">开发类</OPTION>
<OPTION VALUE="开发地质">-- 开发地质</OPTION>
<OPTION VALUE="油藏工程">-- 油藏工程</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="钻采类">钻采类</OPTION>
<OPTION VALUE="钻井">-- 钻井</OPTION>
<OPTION VALUE="完井">-- 完井</OPTION>
<OPTION VALUE="采油">-- 采油</OPTION>
<OPTION VALUE="油田化学">-- 油田化学</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="工程类">工程类</OPTION>
<OPTION VALUE="工程项目管理">-- 工程项目管理</OPTION>
<OPTION VALUE="工程设计">-- 工程设计</OPTION>
<OPTION VALUE="工程制造">-- 工程制造</OPTION>
<OPTION VALUE="工程安装">-- 工程安装</OPTION>
<OPTION VALUE="工程维修">-- 工程维修</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="炼化气电">炼化气电</OPTION>
<OPTION VALUE="炼油工艺">-- 炼油工艺</OPTION>
<OPTION VALUE="炼油设备">-- 炼油设备</OPTION>
<OPTION VALUE="化工工艺">-- 化工工艺</OPTION>
<OPTION VALUE="LNG">-- LNG</OPTION>
<OPTION VALUE="发电">-- 发电</OPTION>
<OPTION VALUE="管道">-- 管道</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="管理类">管理类</OPTION>
<OPTION VALUE="财务/审计">-- 财务/审计</OPTION>
<OPTION VALUE="金融保险">-- 金融保险</OPTION>
<OPTION VALUE="投资与经济评价">-- 投资与经济评价</OPTION>
<OPTION VALUE="规划/计划/统计">-- 规划/计划/统计</OPTION>
<OPTION VALUE="资本运营">-- 资本运营</OPTION>
<OPTION VALUE="市场营销">-- 市场营销</OPTION>
<OPTION VALUE="物流管理">-- 物流管理</OPTION>
<OPTION VALUE="合同/采办">-- 合同/采办</OPTION>
<OPTION VALUE="国际贸易">-- 国际贸易</OPTION>
<OPTION VALUE="法律">-- 法律</OPTION>
<OPTION VALUE="安全环保">-- 安全环保</OPTION>
<OPTION VALUE="行政管理">-- 行政管理</OPTION>
<OPTION VALUE="党群工作">-- 党群工作</OPTION>
<OPTION VALUE="人力资源">-- 人力资源</OPTION>
<OPTION VALUE="科技管理">-- 科技管理</OPTION>
<OPTION VALUE="计算机与网络">-- 计算机与网络</OPTION>
<OPTION VALUE="港口码头管理">-- 港口码头管理</OPTION>
<OPTION VALUE="医学">-- 医学</OPTION>
<OPTION VALUE="教育">-- 教育</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
<OPTION VALUE="工种">工种</OPTION>
<OPTION VALUE="采油操作工">-- 采油操作工</OPTION>
<OPTION VALUE="钻井司钻">-- 钻井司钻</OPTION>
<OPTION VALUE="钻修工">-- 钻修工</OPTION>
<OPTION VALUE="维修电工">-- 维修电工</OPTION>
<OPTION VALUE="电器维修员">-- 电器维修员</OPTION>
<OPTION VALUE="发电工">-- 发电工</OPTION>
<OPTION VALUE="仪表工">-- 仪表工</OPTION>
<OPTION VALUE="机工">-- 机工</OPTION>
<OPTION VALUE="机电工（工程船舶)">-- 机电工（工程船舶)</OPTION>
<OPTION VALUE="钳工（机修工）">-- 钳工（机修工）</OPTION>
<OPTION VALUE="车工">-- 车工</OPTION>
<OPTION VALUE="数控车工">-- 数控车工</OPTION>
<OPTION VALUE="铆工">-- 铆工</OPTION>
<OPTION VALUE="焊工">-- 焊工</OPTION>
<OPTION VALUE="管工">-- 管工</OPTION>
<OPTION VALUE="铣工">-- 铣工</OPTION>
<OPTION VALUE="起重工">-- 起重工</OPTION>
<OPTION VALUE="吊车司机">-- 吊车司机</OPTION>
<OPTION VALUE="铲/叉车司机">-- 铲/叉车司机</OPTION>
<OPTION VALUE="起重水手">-- 起重水手</OPTION>
<OPTION VALUE="水手">-- 水手</OPTION>
<OPTION VALUE="潜水员">-- 潜水员</OPTION>
<OPTION VALUE="测井全能操作手">-- 测井全能操作手</OPTION>
<OPTION VALUE="气爆主操">-- 气爆主操</OPTION>
<OPTION VALUE="探伤工">-- 探伤工</OPTION>
<OPTION VALUE="外观检验员">-- 外观检验员</OPTION>
<OPTION VALUE="合成氨生产工">-- 合成氨生产工</OPTION>
<OPTION VALUE="尿素生产工">-- 尿素生产工</OPTION>
<OPTION VALUE="化学检验工">-- 化学检验工</OPTION>
<OPTION VALUE="通讯工">-- 通讯工</OPTION>
<OPTION VALUE="计算机及网络设备机务员">-- 计算机及网络设备机务员</OPTION>
<OPTION VALUE="一般秘书">-- 一般秘书</OPTION>
<OPTION VALUE="厨师">-- 厨师</OPTION>
<OPTION VALUE="司机">-- 司机</OPTION>
<OPTION VALUE="物业">-- 物业</OPTION>
<OPTION VALUE="其他">-- 其他</OPTION>
                  </SELECT>

<script>
function alteroption(index)
{
    var ccc=form1.sltOccId_list.length;
    for(var len=0;ccc>=0;ccc--)
    form1.sltOccId_list.options[ccc]=null;
    if(index==1)
{
    <%=sb[0].toString()      %>
}else if(index==2)
{
        <%=sb[1].toString()      %>
}else if(index==3)
{
        <%=sb[2] .toString()     %>
}else if(index==4)
{
        <%=sb[3]   .toString()   %>
}else if(index ==5)
{
        <%=sb[4]   .toString()   %>
}else if(index==6)
{
        <%=sb[5]  .toString()    %>
}else if(index==7)
{
        <%=sb[6]    .toString()  %>
}
}
</script>
                  </TD>
                  <TD WIDTH="95" ALIGN="CENTER"> <INPUT class="edit_button" TYPE="BUTTON" VALUE="添加" NAME="btnAdd"  ALT="添加" WIDTH="52" HEIGHT="20" BORDER="0" onClick="AddOption('Occupation', form1.sltOccId_list, form1.sltOccId, 3);return false;">
                    <br/> <br/> <INPUT class="edit_button" TYPE="BUTTON" VALUE="删除" ALT="删除" WIDTH="52" HEIGHT="20" BORDER="0" onClick="DelOption(form1.sltOccId);return false;">
                  </TD>
                  <TD>
                    <SELECT  class="edit_input" NAME="sltOccId" SIZE="5" MULTIPLE STYLE="width:200px">
                   <!--版本号：0002-->
<!--Action:1--><%java.util.Enumeration enumerationOccId=job.getSltOccId();
while(enumerationOccId.hasMoreElements()){
%><option><%=enumerationOccId.nextElement()%></option><%}%>

                    </SELECT> </TD>
                </TR>
              </TABLE> </TD>
          </TR>
          <TR>
            <TD> * 职位有效期 &nbsp;</TD>
            <TD> <%=new TimeSelection("Validity", job.getValidityDate())%>
                <INPUT NAME="sltExpiryDays" type="hidden" VALUE="1" SIZE="3" MAXLENGTH="3">
            </TD>
          </TR>
          <TR>
            <TD>招聘人数 &nbsp; </TD>
            <TD><INPUT class="edit_input" NAME="txtHeadCount" TYPE="text" VALUE="<%if(job.getTxtHeadCount()>0)out.println(job.getTxtHeadCount());%>" SIZE="4" MAXLENGTH="4"></TD>
          </TR>
          <TR>
            <TD>月薪范围&nbsp;</TD>
            <TD>
              <SELECT NAME="sltSalaryId">
                <%--  <OPTION VALUE = "255"></OPTION>--%>
                <!--版本号：0001-->
                <!--Action:2-->
                <OPTION VALUE="面议" <%=getSelect(job.getSltSalaryId().equals("面议"))%>>面议</OPTION>
                <OPTION VALUE="1000以下"<%=getSelect(job.getSltSalaryId().equals("1000以下"))%>>1000以下</OPTION>
                <OPTION VALUE="1000~2000"<%=getSelect(job.getSltSalaryId().equals("1000~2000"))%>>1000~2000</OPTION>
                <OPTION VALUE="2000~3000"<%=getSelect(job.getSltSalaryId().equals("2000~3000"))%>>2000~3000</OPTION>
                <OPTION VALUE="3000~4000"<%=getSelect(job.getSltSalaryId().equals("3000~4000"))%>>3000~4000</OPTION>
                <OPTION VALUE="4000~6000"<%=getSelect(job.getSltSalaryId().equals("4000~6000"))%>>4000~6000</OPTION>
                <OPTION VALUE="6000~8000"<%=getSelect(job.getSltSalaryId().equals("6000~8000"))%>>6000~8000</OPTION>
                <OPTION VALUE="8000~10000"<%=getSelect(job.getSltSalaryId().equals("8000~10000"))%>>8000~10000</OPTION>
                <OPTION VALUE="10000~15000"<%=getSelect(job.getSltSalaryId().equals("10000~15000"))%>>10000~15000</OPTION>
                <OPTION VALUE="15000~20000"<%=getSelect(job.getSltSalaryId().equals("15000~20000"))%>>15000~20000</OPTION>
                <OPTION VALUE="20000~30000"<%=getSelect(job.getSltSalaryId().equals("20000~30000"))%>>20000~30000</OPTION>
                <OPTION VALUE="30000~50000"<%=getSelect(job.getSltSalaryId().equals("30000~50000"))%>>30000~50000</OPTION>
                <OPTION VALUE="50000+"<%=getSelect(job.getSltSalaryId().equals("50000+"))%>>50000+</OPTION>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD>* 工作地区&nbsp;</TD>
            <TD> <TABLE id="tablecenter" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <TR>
                  <TD><SELECT  class="edit_input" NAME="sltProvinceId" onChange="javascript:SelectOption('Location',true, form1.sltProvinceId,form1.sltAllLocId, '', '', '');CheckLoc(form1.sltAllLocId);" STYLE="width:140px">
                      <OPTION VALUE="-1">--请选择省区--</OPTION>
                      <!--版本号：0001-->
<!--Action:1-->
<OPTION VALUE="30000">北京</OPTION>
<OPTION VALUE="31000">上海</OPTION>
<OPTION VALUE="32000">天津</OPTION>
<OPTION VALUE="33000">重庆</OPTION>
<OPTION VALUE="16000">广东省</OPTION>
<OPTION VALUE="7000">江苏省</OPTION>
<OPTION VALUE="8000">浙江省</OPTION>
<OPTION VALUE="9000">安徽省</OPTION>
<OPTION VALUE="10000">福建省</OPTION>
<OPTION VALUE="24000">甘肃省</OPTION>
<OPTION VALUE="17000">广西自治区</OPTION>
<OPTION VALUE="20000">贵州省</OPTION>
<OPTION VALUE="18000">海南省</OPTION>
<OPTION VALUE="1000">河北省</OPTION>
<OPTION VALUE="13000">河南省</OPTION>
<OPTION VALUE="6000">黑龙江省</OPTION>
<OPTION VALUE="14000">湖北省</OPTION>
<OPTION VALUE="15000">湖南省</OPTION>
<OPTION VALUE="5000">吉林省</OPTION>
<OPTION VALUE="11000">江西省</OPTION>
<OPTION VALUE="4000">辽宁省</OPTION>
<OPTION VALUE="3000">内蒙古自治区</OPTION>
<OPTION VALUE="26000">宁夏自治区</OPTION>
<OPTION VALUE="25000">青海省</OPTION>
<OPTION VALUE="12000">山东省</OPTION>
<OPTION VALUE="2000">山西省</OPTION>
<OPTION VALUE="23000">陕西省</OPTION>
<OPTION VALUE="19000">四川省</OPTION>
<OPTION VALUE="22000">西藏自治区</OPTION>
<OPTION VALUE="27000">新疆自治区</OPTION>
<OPTION VALUE="21000">云南省</OPTION>
<OPTION VALUE="34000">香港</OPTION>
<OPTION VALUE="35000">澳门</OPTION>
<OPTION VALUE="36000">台湾</OPTION>
<OPTION VALUE="37000">其他亚洲国家和地区</OPTION>
<OPTION VALUE="38000">北美洲</OPTION>
<OPTION VALUE="41000">南美洲</OPTION>
<OPTION VALUE="39000">大洋洲</OPTION>
<OPTION VALUE="40000">欧洲</OPTION>
<OPTION VALUE="42000">非洲</OPTION>

                    </SELECT></TD>
                  <TD COLSPAN="2" ALIGN="CENTER" > &nbsp;如选择了省/区，则不能再选择该省/区下属城市
                  </TD>
                </TR>
                <TR>
                  <TD> <SELECT class="edit_input"  NAME="sltAllLocId" SIZE="5" MULTIPLE STYLE="width:140px"  >
                      <!--版本号：0001-->
<!--Action:1-->
<OPTION VALUE="5">北京</OPTION>
<OPTION VALUE="115">上海</OPTION>
<OPTION VALUE="140">天津</OPTION>
<OPTION VALUE="25">重庆</OPTION>
<OPTION VALUE="16000">广东省</OPTION>
<OPTION VALUE="40">广州</OPTION>
<OPTION VALUE="16010">潮州</OPTION>
<OPTION VALUE="225">东莞</OPTION>
<OPTION VALUE="16050">佛山</OPTION>
<OPTION VALUE="16020">惠州</OPTION>
<OPTION VALUE="16030">清远</OPTION>
<OPTION VALUE="117">汕头</OPTION>
<OPTION VALUE="125">深圳</OPTION>
<OPTION VALUE="16040">顺德</OPTION>
<OPTION VALUE="16060">湛江</OPTION>
<OPTION VALUE="16080">肇庆</OPTION>
<OPTION VALUE="16070">中山</OPTION>
<OPTION VALUE="180">珠海</OPTION>
<OPTION VALUE="7000">江苏省</OPTION>
<OPTION VALUE="100">南京</OPTION>
<OPTION VALUE="7010">常熟</OPTION>
<OPTION VALUE="18">常州</OPTION>
<OPTION VALUE="7020">昆山</OPTION>
<OPTION VALUE="7070">连云港</OPTION>
<OPTION VALUE="7060">南通</OPTION>
<OPTION VALUE="220">苏州</OPTION>
<OPTION VALUE="7040">太仓</OPTION>
<OPTION VALUE="152">无锡</OPTION>
<OPTION VALUE="7030">徐州</OPTION>
<OPTION VALUE="167">扬州</OPTION>
<OPTION VALUE="7080">镇江</OPTION>
<OPTION VALUE="8000">浙江省</OPTION>
<OPTION VALUE="55">杭州</OPTION>
<OPTION VALUE="107">宁波</OPTION>
<OPTION VALUE="147">温州</OPTION>
<OPTION VALUE="8050">绍兴</OPTION>
<OPTION VALUE="8060">金华</OPTION>
<OPTION VALUE="8080">台州</OPTION>
<OPTION VALUE="8090">湖州</OPTION>
<OPTION VALUE="73">嘉兴</OPTION>
<OPTION VALUE="8110">瞿州</OPTION>
<OPTION VALUE="8100">丽水</OPTION>
<OPTION VALUE="8070">舟山</OPTION>
<OPTION VALUE="9000">安徽省</OPTION>
<OPTION VALUE="65">合肥</OPTION>
<OPTION VALUE="9040">安庆</OPTION>
<OPTION VALUE="9030">蚌埠</OPTION>
<OPTION VALUE="9020">芜湖</OPTION>
<OPTION VALUE="10000">福建省</OPTION>
<OPTION VALUE="35">福州</OPTION>
<OPTION VALUE="10030">泉州</OPTION>
<OPTION VALUE="155">厦门</OPTION>
<OPTION VALUE="10040">漳州</OPTION>
<OPTION VALUE="24000">甘肃省</OPTION>
<OPTION VALUE="85">兰州</OPTION>
<OPTION VALUE="24020">嘉峪关</OPTION>
<OPTION VALUE="24030">酒泉</OPTION>
<OPTION VALUE="17000">广西自治区</OPTION>
<OPTION VALUE="105">南宁</OPTION>
<OPTION VALUE="17040">北海</OPTION>
<OPTION VALUE="42">桂林</OPTION>
<OPTION VALUE="17020">柳州</OPTION>
<OPTION VALUE="17050">玉林</OPTION>
<OPTION VALUE="20000">贵州省</OPTION>
<OPTION VALUE="45">贵阳</OPTION>
<OPTION VALUE="20020">遵义</OPTION>
<OPTION VALUE="18000">海南省</OPTION>
<OPTION VALUE="50">海口</OPTION>
<OPTION VALUE="18020">三亚</OPTION>
<OPTION VALUE="1000">河北省</OPTION>
<OPTION VALUE="130">石家庄</OPTION>
<OPTION VALUE="7">保定</OPTION>
<OPTION VALUE="1070">承德</OPTION>
<OPTION VALUE="53">邯郸</OPTION>
<OPTION VALUE="1080">廊坊</OPTION>
<OPTION VALUE="1030">秦皇岛</OPTION>
<OPTION VALUE="1020">唐山</OPTION>
<OPTION VALUE="1060">张家口</OPTION>
<OPTION VALUE="13000">河南省</OPTION>
<OPTION VALUE="175">郑州</OPTION>
<OPTION VALUE="78">开封</OPTION>
<OPTION VALUE="92">洛阳</OPTION>
<OPTION VALUE="6000">黑龙江省</OPTION>
<OPTION VALUE="60">哈尔滨</OPTION>
<OPTION VALUE="6030">大庆</OPTION>
<OPTION VALUE="6040">佳木斯</OPTION>
<OPTION VALUE="6050">牡丹江</OPTION>
<OPTION VALUE="6020">齐齐哈尔</OPTION>
<OPTION VALUE="14000">湖北省</OPTION>
<OPTION VALUE="150">武汉</OPTION>
<OPTION VALUE="14020">十堰</OPTION>
<OPTION VALUE="14040">襄樊</OPTION>
<OPTION VALUE="14030">宜昌</OPTION>
<OPTION VALUE="14050">潜江</OPTION>
<OPTION VALUE="14060">荆门</OPTION>
<OPTION VALUE="14070">荆州</OPTION>
<OPTION VALUE="14080">黄石</OPTION>
<OPTION VALUE="15000">湖南省</OPTION>
<OPTION VALUE="15">长沙</OPTION>
<OPTION VALUE="15030">湘潭</OPTION>
<OPTION VALUE="15020">株州</OPTION>
<OPTION VALUE="5000">吉林省</OPTION>
<OPTION VALUE="10">长春</OPTION>
<OPTION VALUE="5020">吉林市</OPTION>
<OPTION VALUE="11000">江西省</OPTION>
<OPTION VALUE="95">南昌</OPTION>
<OPTION VALUE="11020">九江</OPTION>
<OPTION VALUE="4000">辽宁省</OPTION>
<OPTION VALUE="120">沈阳</OPTION>
<OPTION VALUE="4030">鞍山</OPTION>
<OPTION VALUE="30">大连</OPTION>
<OPTION VALUE="4040">葫芦岛</OPTION>
<OPTION VALUE="3000">内蒙古自治区</OPTION>
<OPTION VALUE="70">呼和浩特</OPTION>
<OPTION VALUE="3020">包头</OPTION>
<OPTION VALUE="3030">赤峰</OPTION>
<OPTION VALUE="26000">宁夏自治区</OPTION>
<OPTION VALUE="170">银川</OPTION>
<OPTION VALUE="25000">青海省</OPTION>
<OPTION VALUE="165">西宁</OPTION>
<OPTION VALUE="12000">山东省</OPTION>
<OPTION VALUE="75">济南</OPTION>
<OPTION VALUE="12090">德州</OPTION>
<OPTION VALUE="12040">东营</OPTION>
<OPTION VALUE="12060">济宁</OPTION>
<OPTION VALUE="12100">临沂</OPTION>
<OPTION VALUE="110">青岛</OPTION>
<OPTION VALUE="12080">日照</OPTION>
<OPTION VALUE="12070">泰安</OPTION>
<OPTION VALUE="146">威海</OPTION>
<OPTION VALUE="12050">潍坊</OPTION>
<OPTION VALUE="168">烟台</OPTION>
<OPTION VALUE="12030">淄博</OPTION>
<OPTION VALUE="2000">山西省</OPTION>
<OPTION VALUE="135">太原</OPTION>
<OPTION VALUE="2010">大同</OPTION>
<OPTION VALUE="2020">临汾</OPTION>
<OPTION VALUE="2030">运城</OPTION>
<OPTION VALUE="23000">陕西省</OPTION>
<OPTION VALUE="160">西安</OPTION>
<OPTION VALUE="23010">宝鸡</OPTION>
<OPTION VALUE="23020">咸阳</OPTION>
<OPTION VALUE="19000">四川省</OPTION>
<OPTION VALUE="20">成都</OPTION>
<OPTION VALUE="19060">乐山</OPTION>
<OPTION VALUE="19030">泸州</OPTION>
<OPTION VALUE="19040">绵阳</OPTION>
<OPTION VALUE="19050">内江</OPTION>
<OPTION VALUE="19070">宜宾</OPTION>
<OPTION VALUE="19020">自贡</OPTION>
<OPTION VALUE="22000">西藏自治区</OPTION>
<OPTION VALUE="90">拉萨</OPTION>
<OPTION VALUE="22020">日喀则</OPTION>
<OPTION VALUE="27000">新疆自治区</OPTION>
<OPTION VALUE="145">乌鲁木齐</OPTION>
<OPTION VALUE="27030">喀什</OPTION>
<OPTION VALUE="27020">克拉玛依</OPTION>
<OPTION VALUE="27040">伊犁</OPTION>
<OPTION VALUE="21000">云南省</OPTION>
<OPTION VALUE="80">昆明</OPTION>
<OPTION VALUE="21030">大理</OPTION>
<OPTION VALUE="21040">丽江</OPTION>
<OPTION VALUE="21020">玉溪</OPTION>
<OPTION VALUE="185">香港</OPTION>
<OPTION VALUE="190">澳门</OPTION>
<OPTION VALUE="195">台湾</OPTION>
<OPTION VALUE="200">其他亚洲国家和地区</OPTION>
<OPTION VALUE="205">北美洲</OPTION>
<OPTION VALUE="230">南美洲</OPTION>
<OPTION VALUE="210">大洋洲</OPTION>
<OPTION VALUE="215">欧洲</OPTION>
<OPTION VALUE="235">非洲</OPTION>

                    </SELECT><SCRIPT language="javascript">CheckLoc(form1.sltAllLocId);</script> </TD>
                  <TD ALIGN="CENTER"> <INPUT NAME="btnAdd"  class="edit_button" TYPE="BUTTON" VALUE="添加" WIDTH="52" HEIGHT="20" BORDER="0" onClick="AddOption('Location', form1.sltAllLocId, form1.sltLocId, 0);return false;">
                    <br/> <br/> <INPUT NAME="btnDelete" class="edit_button" TYPE="BUTTON" VALUE="删除" ALT="删除" WIDTH="52" HEIGHT="20" BORDER="0" onClick="DelOption(form1.sltLocId);return false;">
                  </TD>
                  <TD> <SELECT  class="edit_input" NAME="sltLocId" SIZE="5" MULTIPLE STYLE="width:140px">
<!--Action:1--><%java.util.Enumeration enumerationLocId=job.getSltLocId();
while(enumerationLocId.hasMoreElements()){
%><option><%=enumerationLocId.nextElement()%></option><%}%>

                    </SELECT></script> </TD>

                </TR>
              </TABLE></TD>
          </TR>

          <TR>
            <TD>最低工作经验&nbsp;</TD>
            <TD> <SELECT class="edit_input"  NAME="sltReqWyearId">
                <OPTION VALUE = ""></OPTION>
                <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="0" <%=getSelect(job.getSltReqWyearId()==0)%>>一年以下</OPTION>
<OPTION VALUE="1"<%=getSelect(job.getSltReqWyearId()==1)%>>1年</OPTION>
<OPTION VALUE="2"<%=getSelect(job.getSltReqWyearId()==2)%>>2年</OPTION>
<OPTION VALUE="3"<%=getSelect(job.getSltReqWyearId()==3)%>>3年</OPTION>
<OPTION VALUE="4"<%=getSelect(job.getSltReqWyearId()==4)%>>4年</OPTION>
<OPTION VALUE="5"<%=getSelect(job.getSltReqWyearId()==5)%>>5年</OPTION>
<OPTION VALUE="6"<%=getSelect(job.getSltReqWyearId()==6)%>>6年</OPTION>
<OPTION VALUE="7"<%=getSelect(job.getSltReqWyearId()==7)%>>7年</OPTION>
<OPTION VALUE="8"<%=getSelect(job.getSltReqWyearId()==8)%>>8年</OPTION>
<OPTION VALUE="9"<%=getSelect(job.getSltReqWyearId()==9)%>>9年</OPTION>
<OPTION VALUE="10"<%=getSelect(job.getSltReqWyearId()==10)%>>10年</OPTION>

              </SELECT> 以上</TD>
          </TR>
          <TR>
            <TD>学历&nbsp;</TD>
            <TD><select class="edit_input"  name="sltReqDegId">
              <option value = ""></option>
              <!--版本号：0001-->
              <!--Action:2-->
              <option value="博士" <%=getSelect(job.getSltReqDegId().equals("博士"))%>>博士</option>
              <option value="MBA" <%=getSelect(job.getSltReqDegId().equals("MBA"))%>>MBA</option>
              <option value="硕士" <%=getSelect(job.getSltReqDegId().equals("硕士"))%>>硕士</option>
              <option value="本科" <%=getSelect(job.getSltReqDegId().equals("本科"))%>>本科</option>
              <option value="大专" <%=getSelect(job.getSltReqDegId().equals("大专"))%>>大专</option>
              <option value="中专" <%=getSelect(job.getSltReqDegId().equals("中专"))%>>中专</option>
              <option value="中技" <%=getSelect(job.getSltReqDegId().equals("中技"))%>>中技</option>
              <option value="高中" <%=getSelect(job.getSltReqDegId().equals("高中"))%>>高中</option>
              <option value="初中" <%=getSelect(job.getSltReqDegId().equals("初中"))%>>初中</option>
            </select>
            以上 </TD>
          </TR>

          <TR>
            <TD VALIGN="top" NOWRAP>* 职位描述及要求&nbsp;</TD>
            <TD> <TEXTAREA  class="edit_input" NAME="txtJobDuty" COLS="70" ROWS="5"><%=HtmlElement.htmlToText(text)%></TEXTAREA>
              <br/>
              最多可以输入3000个字。<a id="linkObjectCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['txtJobDuty'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
          <span id="valObject" controltovalidate="ObjectCN" errormessage="职业目标限500个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,500}" style="color:Red;display:none;">职业目标限500个字！</span><br>
          </span> </TD>
          </TR>

<!--<input NAME="txtJobDuty" type="hidden" value="aa">
          <SCRIPT language="javascript">
            document.form1.chkGetCvTypeEmail.checked = true;
            document.all.trJobCcType.style.display = "";
          </SCRIPT>
		  -->

          <TR>
            <TD COLSPAN="2" ALIGN="CENTER">

<input  type="hidden" value="<%=teasession._nNode%>" name="Node"/>
           <%-- %>   &nbsp; <INPUT NAME="btnPost" TYPE="image" SRC="/images/btn_launch.gif" WIDTH="60" HEIGHT="21" BORDER="0" onClick="return doAction('post');">

              &nbsp; <INPUT NAME="btnSave" TYPE="image" SRC="/images/btn_save.gif" WIDTH="60" HEIGHT="21" BORDER="0" onClick="return doAction('save');">
                               --%>
<!---     <input type="submit" name="Preview" id="edit_GoBack" class="edit_button" VALUE="预览">-->
             <input  class="edit_button" type="submit" value="发布"/>
             <input class="edit_button"  type="submit" value="保存" name="save"/>
              <input  class="edit_button" type="button" value="取消" name="cancel" onclick="javascript:history.back()"/>
            </TD>
          </TR>
        </FORM>
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

