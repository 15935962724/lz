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
CaseCollection ccobj = CaseCollection.find(ids);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>芬必得骨科病例征集</title>

</head>


<body id="bodynone_lzj">
<h1>芬必得骨科病例征集</h1>
<form action="?" name="form1"  method="POST"  enctype="multipart/form-data"><!--/servlet/EditDoctor-->

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
      <div align="right">病例分析标题：</div>    </td>
      <td><%if(ccobj.getCasename()!=null)out.print(ccobj.getCasename());%>    </td>
  </tr>
  <TR bgColor=#ffffff>
    <td><div align="right">病例分析：</div></td>
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
      <div align="right">病史：</div>    </td>
      <td>
        <%if(ccobj.getChief()!=null)out.print(ccobj.getChief());%></td>
  </tr>

  <TR >
    <td><div align="right">体格检查：</div>    </td>
    <td><%if(ccobj.getOtheryichang()!=null)out.print(ccobj.getOtheryichang());%>
  </tr>

  <tr>
    <td>
      <div align="right">影像学检查：</div>    </td>
      <td>（请注明何种影像学检查，最好提供影像学资料，如实在没有，可出具结果）<BR>
        <%if(ccobj.getYingxiang()!=null)out.print(ccobj.getYingxiang());%>
        <DIV id=logoimg></DIV> 上传的影像学资料：&nbsp; <!--font color="red"><a onClick="f_xuanze(<%=ids%>,'first')">点击查看</a></font-->
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
    <td><div align="right">结果：</div></td><!--有异常的实验室检查-->
    <td><%if(ccobj.getYichang()!=null)out.print(ccobj.getYichang());%>
  </tr>
  <TR >
    <td><div align="right">讨论：</div></td><!--初步诊断-->
    <td>
      <%if(ccobj.getChubuzhenduan()!=null)out.print(ccobj.getChubuzhenduan());%>
  </tr>
  <TR >
    <td>
      <div align="right">参考文献：</div>    </td><!--诊治经过（如有使用NSAIDs类药物，请注明使用剂量、用法和疗程）-->
      <td><%if(ccobj.getZzjingguo()!=null)out.print(ccobj.getZzjingguo());%>  </td>
  </tr>



  <TR >
    <td>
      <div align="right">补充说明：</div>    </td>
      <td>
        有使用NSAIDs类药物的病例，请注意：<br>
        1．既往史中如有心脑血管病史、胃肠道疾病史或其他特殊病史或服药史请在病例中注明.<br>
        2．在病例中写出NSAIDs类药物的具体剂量、用法和疗程.<br>
        3．治疗前后疼痛的程度：<br>
        &nbsp;&nbsp;治疗前：(无痛)0 1 2 3 4 5 6 7 8 9 10 (极痛)&nbsp;

        <%

        for(int i=0;i<CaseCollection.NUM.length;i++)
        {
          if(ccobj.getGjttnumfrist()==i)
          {
            out.print(i);
          }
        }
        %>
        <br>
        &nbsp;&nbsp;治疗后：(无痛)0 1 2 3 4 5 6 7 8 9 10 (极痛)&nbsp;
        <%
        for(int i=0;i<CaseCollection.NUM.length;i++)
        {
          if(ccobj.getGjttnumlast()==i)
          {
            out.print(i);
          }
        }
        %>
        </td>
  </tr>

  <TR >
    <td><div align="right">英雄语录(您执业生涯中的感言)：</div></td>
    <td><%if(ccobj.getTaolun()!=null)out.print(ccobj.getTaolun());%></td>
  </tr>

</TABLE>
</FORM>
</body>
</html>
