<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
//if(teasession._rv == null)
//{
  //  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  //  return;
  //}

  tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");
  StringBuffer sb = new StringBuffer();
  StringBuffer par = new StringBuffer();
  //SupplierMember sm=SupplierMember.find(teasession._strCommunity,teasession._rv._strV);

  String locid = teasession.getParameter("locid");
  String all  = teasession.getParameter("all");
  String orgid = teasession.getParameter("orgid");

  if(locid!=null&&locid.length()>0){
    sb.append(" and j.locid like '%/"+locid+"/%'");
    par.append("&locid=").append(locid);
  }

  if(orgid!=null && orgid.length()>0){
    sb.append(" and j.orgid=").append(orgid);
    par.append("&orgid=").append(orgid);
  }

  if(all!=null&& all.length()>0){
    sb.append(" and n.node in (select node from nodelayer where subject like '%"+all+"%')");
    par.append("&all=").append(java.net.URLEncoder.encode(all,"utf-8"));
  }

  int count = 0;
  int pos=0,pagesize=25;
  String tmp=request.getParameter("pos");
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }

  java.util.Vector vector2=new java.util.Vector();
  DbAdapter db = new DbAdapter();
  try
  {
    count=db.getInt("SELECT COUNT(n.node) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(teasession._strCommunity)+sb.toString());
    db.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(teasession._strCommunity)+sb.toString()+" ORDER BY n.sequence");
    // out.print("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.type=50 AND n.community="+db.cite(community)+sb2.toString()+" ORDER BY n.sequence");
    for (int l = 0; l < pos + pagesize && db.next(); l++)
    {
      if (l >= pos)
      {
        vector2.addElement(Integer.valueOf(db.getInt(1)));
      }
    }
  } finally
  {
    db.close();
  }
  java.util.Enumeration enumeration=vector2.elements();


  %>

  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>

  <FORM NAME=foEdit METHOD=GET ACTION="?">

    <INPUT TYPE="HIDDEN" NAME="id" VALUE="947"/>
    <table border="0" cellpadding="0" cellspacing="0" id="lzjcx1">
      <tr>
        <td align="right" class="lzj_yi">选择职位地区</td>
        <td class="lzj_er"><SELECT NAME="locid" STYLE="width:150px;">
          <OPTION VALUE="" SELECTED >——选择城市或地区——</OPTION>
          <%

          java.util.Enumeration e=Jobcity.findByFather(Jobcity.getRootId(teasession._strCommunity));
          while(e.hasMoreElements())
          {
            int occ=((Integer)e.nextElement()).intValue();
            Jobcity occ_obj=Jobcity.find(occ);
            out.print("<option value="+occ_obj.getCode());
            if(occ_obj.getCode().equals(locid))
            out.print(" selected");
            out.print(">"+occ_obj.getSubject());
            out.print("</option>");
          }
          %>
        </SELECT></td>

        <td align="right" class="lzj_yi">选择招聘机构</td>
        <td class="lzj_san"><jsp:include flush="true" page="/jsp/type/job/AllCorp.jsp"/></td>
      </tr>
      <tr>
        <td align="right">查找职位</td>
        <td><input type=text name="all" value="<%if(all!=null)out.print(all);%>" style="width:150px;"/></td>
        <td align="center"><input type="SUBMIT" value="查询"  style="margin:2px 4px 6px 3px;" id="jians"/></td>
        <td>&nbsp;</td>
      </tr>
    </table>
  </FORM>
<div class="ProductsList_top" style="border:0;">最新职位</div>
  <table border="0" cellpadding="0" cellspacing="0" id="lzjcx">
  <tr>
    <td nowrap>招聘职位</td><td nowrap>招聘机构</td><td nowrap>截止日期</td><td nowrap>工作地区</td>
  </tr>
  <%
  while(enumeration.hasMoreElements())
  {
    int node_id =((Integer)enumeration.nextElement()).intValue();
    Job job=Job.find(node_id,teasession._nLanguage);

    Node node=Node.find(node_id);
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap><A href="/servlet/Job?node=<%=node_id%>&language=<%=teasession._nLanguage%>" target="_blank"><%=node.getSubject(teasession._nLanguage)%></A></td>
      <td nowrap><A href="/servlet/Company?node=<%=job.getOrgId()%>&language=<%=teasession._nLanguage%>"><%=Node.find(job.getOrgId()).getSubject(1)%></A></td>
      <td nowrap><%=job.getValidityDateToString()%></td>
      <td nowrap><%=job.getLocIdToHtml()%></td>
    </tr>
    <%}%>
    <tr>
      <td colspan="10">
        <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+par.toString()+"&pos=",pos,count)%>
      </td>
    </tr>
  </table>
