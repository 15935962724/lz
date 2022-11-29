<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));


Resource r=new Resource();


Item obj=Item.find(item);

java.text.DateFormat df=java.text.DateFormat.getDateTimeInstance();

java.util.Enumeration enumer;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<body onLoad="">

<h1>历史文件查看</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="open"/>
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><%=obj.getCode()%></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><%=obj.getName()%></td>
       </tr>
       </table>


       <h2>初始化阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
           <td>计划任务书</td>
           <td nowrap>
           <%
           enumer=Itemfilehistory.find(item,"plantask");
           while(enumer.hasMoreElements())
           {
             int itemfilehistory=((Integer)enumer.nextElement()).intValue();
             Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
             java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
             out.print("<A href=ItemDownload.jsp?act=plantask&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
           }
           %>
           </td>
         </tr>
       </table>


       <h2>开题阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>开题报告</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"openuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=openuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
         </td>
       </tr>
       <tr>
         <td>开题会议纪要</td>
         <TD>
         <%
enumer=Itemfilehistory.find(item,"summaryuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=summaryuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
         </TD>
       </tr>
       <tr><td colspan="2"><hr /></td></tr>
       <tr>
         <td>开题会议通知</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"informuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=informuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}



         %>		 </td>
       </tr>
</table>



<%--
<h2>起草阶段</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>起草阶段文档</td>
    <td nowrap>
    <%
    enumer=Itemfilehistory.find(item,"drafturi");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=drafturi&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }
    %>
    </td>
  </tr>
</table>

--%>


<h2>征求意见阶段</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>征求意见稿</td>
    <td nowrap>
    <%
    enumer=Itemfilehistory.find(item,"ideauri");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=ideauri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }
    %>
    </td>
  </tr>

  <tr>
    <td>征求意见稿编制说明</td>
    <TD>
    <%
    enumer=Itemfilehistory.find(item,"explainuri");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=explainuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }
    %>
    </TD>
  </tr>

  <tr>
    <td>技术背景研究报告</td>
    <TD>
    <%
    enumer=Itemfilehistory.find(item,"backdropuri");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=backdropuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }

    %>
    </TD>
  </tr>
  <tr><td colspan="2"><hr /></td></tr>
  <tr>
    <td>征求意见-征求通知</td>
    <td nowrap>
    <%
    enumer=Itemfilehistory.find(item,"ideainformuri");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=ideainformuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }

    %>		&nbsp; </td>
    </tr>
      <tr>
    <td>征求意见-征求单位</td>
    <td nowrap>
    <%
    enumer=Itemfilehistory.find(item,"ideainform2uri");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=ideainform2uri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }

    %>		&nbsp; </td>
    </tr>
    <%--
    <tr>
      <td>意见反馈汇总表</td>
      <td nowrap>
      <%
      enumer=Itemfilehistory.find(item,"feedbackuri");
      while(enumer.hasMoreElements())
      {
        int itemfilehistory=((Integer)enumer.nextElement()).intValue();
        Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
        java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
        out.print("<A href=ItemDownload.jsp?act=feedbackuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
      }
      %>
      &nbsp;
      </td>
    </tr>
--%>








       </table><h2>送审阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>标准送审稿</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"formulatinguri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=formulatinguri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}


         %>
		 </td>
       </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"fexplainuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=fexplainuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}

         %>
              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD>
              <%
enumer=Itemfilehistory.find(item,"fideauri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=fideauri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}


         %>
              </TD>
</tr>
 <tr>
	          <td>技术背景研究报告</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"fbackdropuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=fbackdropuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}


         %>
              </TD>
</tr>
<tr>
	          <td>送审会会议纪要</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"fsummaryuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=fsummaryuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}


         %>
              </TD>
</tr>
           <tr><td colspan="2"><hr /></td></tr>
           <tr>
         <td>送审会通知<!--征求意见--></td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"finformuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=finformuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>		&nbsp; </td>
       </tr>

       <%--
           <tr>
         <td>送审会通知-征求单位</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"finform2uri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=finform2uri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>		&nbsp; </td>
       </tr>
--%>
 </table>




 <h2>报批阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>报批稿</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"leveluri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=leveluri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}

         %>
		 </td>
       </tr>

	        <tr>
	          <td>报批稿编制说明</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"lexplainuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lexplainuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}

         %>
              </TD>
</tr>

	        <tr>
	          <td>报批稿技术背景研究报告</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"lbackdropuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lbackdropuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
              </TD>
</tr>
<tr>
         <td>征求意见汇总处理表</td>
         <td nowrap><%

enumer=Itemfilehistory.find(item,"lweaveuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}

         %></td>
       </tr>
<tr><td colspan="2"><hr /></td></tr>

	        <tr>
	          <td>局长专题会议通知</td>
              <TD><%
enumer=Itemfilehistory.find(item,"lsinformuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lsinformuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %></TD>
</tr>

	        <tr>
	          <td>局长专题会议纪要</td>
              <TD><%
enumer=Itemfilehistory.find(item,"lssummaryuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lssummaryuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}

         %></TD>
</tr>
	        <tr>
	          <td>总局局务会议通知</td>
              <TD><%
enumer=Itemfilehistory.find(item,"lginformuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lginformuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %></TD>
</tr>
       <tr>
         <td>总局局务会议纪要</td>
         <td nowrap><%
enumer=Itemfilehistory.find(item,"lgsummaryuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=lgsummaryuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>		&nbsp; </td>
       </tr>






              </table><h2>发布阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


       <tr>
         <td>标准布稿</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"standarduri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=standarduri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
		 </td>
       </tr>

	        <tr>
	          <td>标准编制说明</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"sweaveuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=sweaveuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
              </TD>
</tr>

<%--	        <tr>
	          <td>标准技术报告</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"sbackdropuri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=sbackdropuri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>
              </TD>
</tr>
--%>









       </table><h2>其它阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
         <td>其它文件1</td>
         <td nowrap>
         <%
enumer=Itemfilehistory.find(item,"otheruri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=otheruri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>		 </td>
       </tr>

	        <tr>
	          <td>其它文件2</td>
              <TD>
                       <%
enumer=Itemfilehistory.find(item,"other2uri");
while(enumer.hasMoreElements())
{
  int itemfilehistory=((Integer)enumer.nextElement()).intValue();
  Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
  java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
  out.print("<A href=ItemDownload.jsp?act=other2uri&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
}
         %>              </TD>
</tr>


  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


