<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);

String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
Date date = new Date();
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
  CaseCollection.setDiannum(ids);
}
String community = "";
if(teasession.getParameter("community")!=null && teasession.getParameter("community").length()>0)
{
  community = teasession.getParameter("community");
}
else
{
  community = teasession._strCommunity;
}

String zj ="";
if(teasession.getParameter("zj")!=null && teasession.getParameter("zj").length()>0)
{
  zj= teasession.getParameter("zj");
}

CaseCollection ccobj = CaseCollection.find(ids);

int pos = 0, pageSize = 30, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
sql.append(" order by id asc ");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>芬必得骨科病例征集</title>
<script type="">
function sub_find2()
{
  if(form1.mobilephone.value==null || form1.mobilephone.value=="")
  {
    alert("手机号不能为空，请重新填写！");
    return;
  }else if(form1.mobilephone.value.length!=11)
  {
    alert("请输入正确的手机号，请重新填写！");
    return false;
  }
  form1.act.value="updateEditCaseCollection";
  form1.submit();
}

function sub_find()
{
  if(form1.mobilephone.value==null || form1.mobilephone.value=="")
  {
    alert("手机号不能为空，请重新填写！");
    return false;
  }else if(form1.mobilephone.value.length!=11)
  {
    alert("请输入正确的手机号，请重新填写！");
    return false;
  }
  if(form1.casename.value==null || form1.casename.value=="")
  {
    alert("病例分析标题不能为空，请重新填写！");
    return false;
  }
}
function f_xuanze(aa,bb)
{
  window.showModalDialog('/jsp/admin/orthonline/CasePicshow.jsp?ids='+aa+'&str='+bb,self,'edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:1024px;dialogHeight:1208px;');
}
function f_loads()
{
  form1.zj.focus();
}
</script>
</head>


<body id="bodynone_lzj"  <%if(zj!=null&&zj.length()>0){%>onload="f_loads()"<%}%>>
<h1>芬必得骨科病例征集</h1>
<form action="/servlet/EditCaseCollection" name="form1"  method="POST"  enctype="multipart/form-data"><!--/servlet/EditDoctor-->
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="daid" >
<input type="hidden" name="act" value="EditCaseCollection">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_lzj">
<TR bgColor=#ffffff>
    <td>
      <div align="right">*您的姓名：</div>    </td>
    <td><%if(ccobj.getFirstname()!=null)out.print(ccobj.getFirstname());%></td>
  </tr>
    <TR bgColor=#ffffff>
    <td>
      <div align="right">*所在医院：</div>    </td>
    <td><%if(ccobj.getAddress()!=null)out.print(ccobj.getAddress());%></td>
  </tr>

  <TR bgColor=#ffffff>
    <td>
      <div align="right">病例分析标题</div>    </td>
    <td><%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%>    </td>
  </tr>
  <TR bgColor=#ffffff>
    <td><div align="right">病例分析</div></td>
<td>
  患者性别：
<%
for(int i=0;i<CaseCollection.SEXS.length;i++)
{
  if(ccobj.getSex()==i)
  {
    out.print(CaseCollection.SEXS[i]);
  }
}
%>
 年龄： <%if(ccobj.getAge()!=null)out.print(ccobj.getAge());%> 岁</td>
  </tr>
  <TR bgColor=#ffffff>
    <td>
      <div align="right">主诉：</div>    </td>
<td>
  <%if(ccobj.getChief()!=null)out.print(ccobj.getChief());%></td>
  </tr>
 <TR bgColor=#ffffff>
    <td rowspan="3"><div align="right">现病史：</div></td>
    <td>疼痛情况：
      <%if(ccobj.getGjttpain()!=null)out.print(ccobj.getGjttpain());%></td>
  </tr>


  <TR >
    <td>活动受限情况：<%if(ccobj.getDoingsxbw()!=null)out.print(ccobj.getDoingsxbw());%></td>
  </tr>
  <TR >
    <td>其他情况：<%if(ccobj.getGjttother()!=null)out.print(ccobj.getGjttother());%></td>
  </tr>
  <TR >
    <td rowspan="4"><div align="right">既往史：  </div>    </td>
    <td>心脑血管病史：<%if(ccobj.getHeartpain()!=null)out.print(ccobj.getHeartpain());%></td>
  </tr>


  <TR >
    <td>胃肠道疾病史：<%if(ccobj.getWeichangdao()!=null)out.print(ccobj.getWeichangdao());%></td>
  </tr>
  <TR >
    <td>其他特殊病史或服药史 ：</td>
  </tr>
  <TR >
    <td>
      <%if(ccobj.getOtherpain()!=null)out.print(ccobj.getOtherpain());%>    </td>
  </tr>
  <TR >
    <td rowspan="3"><div align="right">体格检查：</div>    </td>
    <td>畸形情况：<%if(ccobj.getJointjixingbw()!=null)out.print(ccobj.getJointjixingbw());%></td>
  </tr>
  <tr>
    <td>压痛情况：<%if(ccobj.getJointyatongbw()!=null)out.print(ccobj.getJointyatongbw());%></td>
  </tr>
  <tr>
    <td>其他异常：<BR><%if(ccobj.getOtheryichang()!=null)out.print(ccobj.getOtheryichang());%></td>
  </tr>

  <tr>
    <td>
      <div align="right">影像学检查：</div>    </td>
    <td>（请注明何种影像学检查，最好提供影像学资料，如实在没有，可出具结果）<BR>
      <%if(ccobj.getYingxiang()!=null)out.print(ccobj.getYingxiang());%>
      <DIV id=logoimg></DIV> 上传影像学资料 <!--font color="red"><a onClick="f_xuanze(<%=ids%>,'first')">点击查看</a></font--><br>
      <%
      if(ccobj.getYxfirstpath()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=1&str=first&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxfirstpathname()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxfirstpath2()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=2&str=first&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxfirstpathname2()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxfirstpath3()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=3&str=first&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxfirstpathname3()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxfirstpath4()!=null)
      {
        %>
        <a target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=4&str=first&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxfirstpathname4()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxfirstpath5()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=5&str=first&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxfirstpathname5()%>"></a>　
        <%
      }
      %>
    </td>
  </tr>
  <TR >
    <td><div align="right">有异常的实验室检查</div></td>
    <td><BR><%if(ccobj.getYichang()!=null)out.print(ccobj.getYichang());%> </td>
  </tr>
  <tr>
    <td nowrap="nowrap"><div align="right">治疗前患者关节疼痛程度总体评估：<br>（请根据疼痛程度打分）</div></td>
    <td>（无痛）0 1 2 3 4 5 6 7 8 9 10 （极痛）：

      <%
      for(int i=0;i<CaseCollection.NUM.length;i++)
      {
        if(ccobj.getGjttnumfrist()==i)
        {
          out.print(i);
        }
      }
      %></td>
  </tr>
  <TR >
    <td><div align="right">初步诊断：</div></td>
    <td>
      <%if(ccobj.getChubuzhenduan()!=null)out.print(ccobj.getChubuzhenduan());%>    </td>
  </tr>
  <TR >
    <td>
      <div align="right">诊治经过：</div>    </td>
    <td>
      （请注意写明NSAIDs类药物的使用剂量、用法和疗程）<BR><%if(ccobj.getZzjingguo()!=null)out.print(ccobj.getZzjingguo());%>    </td>
  </tr>
  <TR >
    <td>
      <div align="right">预后：</div>    </td>
    <td>治疗后患者关节疼痛程度总体评估：（无痛）0 1 2 3 4 5 6 7 8 9 10 （极痛） :
      <%
      for(int i=0;i<CaseCollection.NUM.length;i++)
      {
         if(ccobj.getGjttnumlast()==i)
        {
          out.print(i);
        }
      }
      %>
      <DIV id=logoimg2></DIV>  此处上传治疗后影像学资料   <!--font color="red"><a onClick="f_xuanze(<%=ids%>,'last')">点击查看</a></font-->  <br>
      <%
      if(ccobj.getYxlastpath()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=1&str=last&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxlastpathname()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxlastpath2()!=null)
      {
        %>
        <a target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=2&str=last&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxlastpathname2()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxlastpath3()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=3&str=last&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxlastpathname3()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxlastpath4()!=null)
      {
        %>
        <a  target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=4&str=last&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxlastpathname4()%>"></a>　
        <%
      }
      %>
       <%
      if(ccobj.getYxlastpath5()!=null)
      {
        %>
        <a target="black" href="/jsp/admin/orthonline/CasePicshow3.jsp?shownum=5&str=last&ids=<%=ids%>"><img src="/tea/image/picture.gif" alt="<%=ccobj.getYxlastpathname5()%>"></a>　
        <%
      }
      %> </td>
  </tr>
  <TR >
    <td><div align="right">结论：</div></td>
    <td><%if(ccobj.getTaolun()!=null)out.print(ccobj.getTaolun());%>    </td>
  </tr>
 <TR >
    <td><div align="right">参考文献：<input type="hidden" name="zj" value=""></div> </td>
    <td>  <%if(ccobj.getDocuments()!=null)out.print(ccobj.getDocuments());%>  </td>
  </tr>

  <TR >
    <td><div align="right">英雄语录：<input type="hidden" name="zj" value=""></div></td>
    <td> <%if(ccobj.getAna()!=null)out.print(ccobj.getAna());%>  </td>
  </tr>
  <%
  if(ccobj.getZhuanjiadp()!=null)
  {
  %>

  <TR >
    <td>
      <div align="right">评论：<input type="hidden" name="zj" value=""></div>
      <div align="right"><font color="#ed0087"><%if(ccobj.getZjyy()!=null)out.print(ccobj.getZjyy());%></font></div>
      <div align="right"><font color="#ed0087"><%if(ccobj.getZjname()!=null)out.print(ccobj.getZjname());%></font></div>
    </td>
    <td>  <%if(ccobj.getZhuanjiadp()!=null)out.print(ccobj.getZhuanjiadp());%>    </td>
  </tr>
 


  <%
  }
  %>
</TABLE>
</FORM>
</body>
</html>
