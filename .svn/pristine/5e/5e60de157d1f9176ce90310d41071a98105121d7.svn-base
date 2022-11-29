<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.entity.admin.*" %>
<%!

Purview purview;
String community;
int nodeCode;
public java.util.Enumeration getOrg() throws java.sql.SQLException
{
    StringBuffer sb=new StringBuffer();
    tea.entity.site.Communityjob objcomm=tea.entity.site.Communityjob.find(    community);

    if(!License.getInstance().getWebMaster().equals(teasession._rv.toString())&&!teasession._rv.toString().equalsIgnoreCase(objcomm.getJobmember()))
    {
      AdminUsrRole aur=AdminUsrRole.find(community,teasession._rv._strV);

      java.util.StringTokenizer tokenizer=new StringTokenizer(aur.getRole(),"/");
      if(tokenizer.hasMoreTokens())
      sb.append(" and (Node.node="+tokenizer.nextToken());
      while(tokenizer.hasMoreTokens())
      {
        sb.append(" OR Node.node="+tokenizer.nextToken());
      }
      sb.append(")");
    }
    java.util.Vector vector=new java.util.Vector();
    DbAdapter dbadapter=new DbAdapter();
    try
    {
        dbadapter.executeQuery("SELECT node FROM Node WHERE type=21 AND community="+dbadapter.cite(community)+sb.toString()+" ORDER BY sequence");
        for (; dbadapter.next(); vector.addElement(new Integer(dbadapter.getInt(1))));
    } catch (Exception exception)
    {
        exception.printStackTrace();
    }finally
    {
      dbadapter.close();
    }
    return vector.elements();
}
%>

<%
r.add("/tea/resource/Job");


 community=teasession._strCommunity;
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
{
  sb[indexlen]=new StringBuffer();
  for(int len=0;len<TYPE[indexlen].length;len++)
  {
    sb[indexlen].append("form1.sltOccId_list.options.add(new Option('"+TYPE[indexlen][len]+"','"+TYPE[indexlen][len]+"'));");
  }
}





%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>



<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT LANGUAGE="javascript" SRC="/tea/CssJs/Select.js"></SCRIPT>

</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "1167460447781")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<FORM NAME="form1" METHOD="POST"  action="/jsp/type/resume/yjobapplymanage.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String strResumeSorttype=request.getParameter("ResumeSorttype");
if(strResumeSorttype!=null)
out.println("<input type=hidden name=ResumeSorttype value="+strResumeSorttype+" />");
%>


<tr>
  <td ><%=r.getString(teasession._nLanguage, "1167460500921")%><!--招聘机构--></td>
<td>
  <br>
  <select name="orgid"  onChange="fadd(this.value)">
    <option value="">------------</option>
    <%
    java.util.Enumeration enumeration=getOrg();
    StringBuffer sborg=new StringBuffer();
    sborg.append("<script>function fadd(value){ var ccc=form1.applyAmount.length; for(;1<=ccc;ccc--)form1.applyAmount.remove(ccc);");
    DbAdapter dbadapter=new DbAdapter();
    try
    {
      while(enumeration.hasMoreElements())
      {
        int len;
        nodeCode =((Integer)enumeration.nextElement()).intValue();
        dbadapter.executeQuery("SELECT Job.node FROM Node,Job WHERE Node.node=Job.node AND orgid ="+nodeCode);
        sborg.append("if(value=="+nodeCode+"){\r\n");
        while(dbadapter.next())
        {
          len=dbadapter.getInt(1);
          Job job=Job.find(len,1);
          sborg.append("form1.applyAmount.options.add(new Option('"+job.getName()+"','"+len+"'));\r\n");
        }

        sborg.append("} else ");
%>
    <option value="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></option>
    <%}
    }finally
    {
      dbadapter.close();
    }
    sborg=sborg.delete(sborg.length()-5,sborg.length());
    sborg.append("}</script>");
%>
  </select></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "1167454389921")%><!--职位--></td>
  <td><select name="applyAmount" style="WIDTH: 200px">
    <option value="">-------------</option>
  </select>
    <%=sborg.toString()%></td>
</tr>



<TR >
  <TD  ><%=r.getString(teasession._nLanguage, "1167460620765")%><!--期望从事职业--></TD>
  <TD>
    <SELECT  NAME="sltOccId_BigClass" onchange="alteroption(this.value);" >
    <OPTION VALUE="">-----------</OPTION>
    <%
    java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(teasession._strCommunity));
    StringBuffer script=new StringBuffer();
    for(int index=0;bigOcc.hasMoreElements();index++)
    {
      int occupation=((Integer)bigOcc.nextElement()).intValue();
      Occupation occ_obj=Occupation.find(occupation);
      out.print("<option value="+occ_obj.getCode()+" >"+occ_obj.getSubject()+"</option>");
      script.append("case '"+occ_obj.getCode()+"':\r\n");
      java.util.Enumeration smallOcc=Occupation.findByFather(occupation);
      for(int smallindex=0;smallOcc.hasMoreElements();smallindex++)
      {
        occupation=((Integer)smallOcc.nextElement()).intValue();
        occ_obj=Occupation.find(occupation);
        script.append("obj.options[obj.options.length]=new Option('"+occ_obj.getSubject()+"','"+occ_obj.getCode()+"');");
      }
      script.append("break;\r\n");
    }
    %>
    <select name="sltOccId_list" ><!-- style="display:none" -->
    <OPTION VALUE="">-----------</OPTION>
    </select>
    <script type="">
    function alteroption(value)
    {
      var obj=form1.sltOccId_list;
      for(var len=obj.length-1;len>0;len--)
      obj.options[len]=null;
      switch(value)
      {
        <%=script.toString()%>
      }
    }
    </script>

          </TR>

          <TR >
            <TD  ><%=r.getString(teasession._nLanguage, "1167460620765")%><!--期望地区--></TD>
            <TD>
              <SELECT NAME="tgt_loc_city_id" >
                <OPTION VALUE="">--------</OPTION>
                <%
                for(int index=0;index<Common.PROVINCE.length;index++)
                {
                  out.print("<option value="+Common.PROVINCE[index]);
                  out.print(">"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[index]));
                }
                %>

            </TD>
          </TR>

          <TR >
            <TD ><%=r.getString(teasession._nLanguage, "1167446517671")%><!--学历--></TD>
            <TD>
            <%//=new tea.htmlx.DegreeSelection("ddlDegree",degree,"finitzzxlbh();")%>
              <SELECT NAME="skr_deg_id">
                <OPTION VALUE="" SELECTED>-------</OPTION>
				        <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="0">博士</OPTION>
<OPTION VALUE="1">MBA</OPTION>
<OPTION VALUE="2">硕士</OPTION>
<OPTION VALUE="3">本科</OPTION>
<OPTION VALUE="4">大专</OPTION>
<OPTION VALUE="5">中专</OPTION>
<OPTION VALUE="6">中技</OPTION>
<OPTION VALUE="7">高中</OPTION>
<OPTION VALUE="8">初中</OPTION>

              </SELECT>
</TD>
          </TR>

          <TR >
            <TD ><%=r.getString(teasession._nLanguage, "1167455197453")%><!--性别--></TD>
            <TD>
              <select name="sex">
                <option value=""><%=r.getString(teasession._nLanguage, "1167460984843")%></option><!--不限-->
                <option value="1" ><%=r.getString(teasession._nLanguage, "1167457951671")%></option><!--男-->
                <option value="0" ><%=r.getString(teasession._nLanguage, "1167457972406")%></option><!--女-->
              </select>
              </TD>
          </TR>
          <TR>
            <TD ><%=r.getString(teasession._nLanguage, "1167461082921")%><!--政治面貌--></TD>
            <TD>
 <%
        tea.html.DropDown select=new tea.html.DropDown("polity","");
        select.addOption("",r.getString(teasession._nLanguage, "1167460984843"));//"--不限--"
        for(int index=0;index<Profile.POLITY_TYPE.length;index++)
        {
          select.addOption(index,r.getString(teasession._nLanguage,Profile.POLITY_TYPE[index]));
        }
        out.print(select.toString());
        %>
              </TD>
          </TR>
          <TR>
            <TD ><%=r.getString(teasession._nLanguage, "1167455221093")%><!--年龄--></TD>
            <TD>
             <select name="age">
          <option value="" selected><%=r.getString(teasession._nLanguage, "1167460984843")%></option><!---不限-->
          <option value="1">18-25</option>
          <option value="2">25-30</option>
          <option value="3">30-35</option>
          <option value="4">35-40</option>
          <option value="5">40-45</option>
          <option value="6">45-50</option>
          <option value="7"><%=r.getString(teasession._nLanguage, "1167461155796")%></option><!--50以上-->
                </select>
            </TD>
          </TR>

          <TR>
            <TD ><%=r.getString(teasession._nLanguage, "1167457783859")%><!--工作经验--></TD>
            <TD>
            <!--INPUT TYPE="text" NAME="skr_wrk_year" MAXLENGTH="2" VALUE=""-->
            <SELECT NAME="skr_wrk_year">
              <OPTION VALUE="" SELECTED><%=r.getString(teasession._nLanguage, "1167460984843")%></OPTION>
				      <!--版本号：0001-->
<!--Action:2-->
<OPTION VALUE="0"><%=r.getString(teasession._nLanguage,"1167448558562")%></OPTION><!-- 一年以下 -->
<OPTION VALUE="1">1<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION><!--  年 -->
<OPTION VALUE="2">2<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="3">3<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="4">4<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="5">5<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="6">6<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="7">7<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="8">8<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="9">9<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>
<OPTION VALUE="10">10<%=r.getString(teasession._nLanguage,"1167448647531")%></OPTION>

            </SELECT>
             </TD>
          </TR>
 <TR >
            <TD ><%=r.getString(teasession._nLanguage, "1167442318656")%><!--姓名--></TD>
            <TD> <INPUT class="edit_input" TYPE="text" NAME="name" MAXLENGTH="20" VALUE="">
</TD>
          </TR>
          <TR>
            <TD ><%=r.getString(teasession._nLanguage, "1167461342281")%><!--关键词--></TD>
            <TD> <INPUT class="edit_input" TYPE="text" NAME="keyword" MAXLENGTH="20" VALUE=""></TD>
          </TR>

          <TR>
            <TD  NOWRAP>&nbsp;</TD>
            <TD COLSPAN="2">
            <!--查询-->
<input name="Input" class="edit_button" type="submit" value="<%=r.getString(teasession._nLanguage, "1167443806359")%>">
<INPUT NAME=""  class="edit_button" TYPE="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back();">
            </TD>
          </TR>
      </TABLE>

        </FORM>


<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</HTML>

