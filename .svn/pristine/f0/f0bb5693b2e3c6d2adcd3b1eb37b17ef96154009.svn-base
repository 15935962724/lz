<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
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

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  try
  {
    form1.openuri.focus();
  }catch(e)
  {}
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>文档查看</h1>
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
         <TD><%=obj.getCode()%></TD></tr>
         <tr>

        <td>项目名称</td>
         <td nowrap><%=obj.getName()%></td>
       </tr>
       </table>
       <h2>初始化阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
         <%--tr>
           <td>经费申请表</td>
           <td nowrap>
           <%
           if(obj.getOutlayapp()!=null&&obj.getOutlayapp().length()>0)
           {
             out.print("<A href=ItemDownload.jsp?act=outlayapp&item="+item+" >下载</A>");
           }
           %></td>
         </tr--%>
                  <tr>
           <td>计划任务书</td>
           <td>
           <%
         if(obj.getPlantask()!=null&&obj.getPlantask().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=plantask&item="+item+" >"+obj.getPlantaskname()+"</A>");
         }
           %>
           </td>
         </tr>
       </table>
       <h2>开题阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>开题报告</td>
         <td>
         <%
         if(obj.getOpenuri()!=null&&obj.getOpenuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=openuri&item="+item+" >"+obj.getOpenname()+"</A>");
         }
         %>
         </td>
       </tr>
       <tr>
         <td>开题会议纪要</td>
         <TD>
         <%
         if(obj.getSummaryuri()!=null&&obj.getSummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=summaryuri&item="+item+" >"+obj.getSummaryname()+"</A>");
         }
         %>
         </TD>
       </tr>
       <tr><td colspan="2"><hr size="1"  /></td></tr>
       <tr>
         <td>开题会议通知</td>
         <td>
         <%
         if(obj.getInformuri()!=null&&obj.getInformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=informuri&item="+item+" >"+obj.getInformname()+"</A>");
         }
         %>		 </td>
       </tr>
       <tr>
         <td>阶段审核意见</td>
         <td>
         <%
         java.util.Enumeration enumer;
         enumer=Itemfilehistory.find(item,"areporturi_3");
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_3&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
         }
         if(obj.getAreporturi_3()!=null&&obj.getAreporturi_3().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getAreporturi_3()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_3&item="+item+" >"+obj.getAreportname_3()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
         }
         %>
&nbsp;
         </td>
       </tr>
       </table>





<h2>起草阶段</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>起草阶段文档</td>
    <td>
    <%
    enumer=Itemfilehistory.find(item,"drafturi");
    while(enumer.hasMoreElements())
    {
      int itemfilehistory=((Integer)enumer.nextElement()).intValue();
      Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
      java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
      out.print("<A href=ItemDownload.jsp?act=drafturi&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
    }
    if(obj.getDrafturi()!=null&&obj.getDrafturi().length()>0)
    {
      java.io.File file=new java.io.File(application.getRealPath(obj.getDrafturi()));
      out.print("<A href=ItemDownload.jsp?act=drafturi&item="+item+" >"+obj.getDraftname()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
    }
    %>
    </td>
  </tr>
</table>





              <h2>征求意见阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>征求意见稿</td>
         <td>
         <%
         if(obj.getIdeauri()!=null&&obj.getIdeauri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideauri&item="+item+" >"+obj.getIdeaname()+"</A>");
         }
         %>
         </td>
       </tr>

       <tr>
         <td>征求意见稿编制说明</td>
         <TD>
         <%
         if(obj.getExplainuri()!=null&&obj.getExplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=explainuri&item="+item+" >"+obj.getExplainname()+"</A>");
         }
         %>
         </TD>
       </tr>

       <tr>
         <td>技术背景研究报告</td>
         <TD>
         <%
         if(obj.getBackdropuri()!=null&&obj.getBackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=backdropuri&item="+item+" >"+obj.getBackdropname()+"</A>");
         }
         %>
              </TD>
                </tr>
                       <tr><td colspan="2"><hr size="1"  /></td></tr>
                <tr>
         <td>征求意见-征求通知</td>
         <td>
         <%
         if(obj.getIdeainformuri()!=null&&obj.getIdeainformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainformuri&item="+item+" >"+obj.getIdeainformname()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
        <tr>
         <td>征求意见-征求单位</td>
         <td>
         <%
         if(obj.getIdeainform2uri()!=null&&obj.getIdeainform2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainform2uri&item="+item+" >"+obj.getIdeainform2name()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
       <%--
       <tr>
         <td>意见反馈汇总表</td>
         <td>
         <%
         if(obj.getFeedbackuri()!=null&&obj.getFeedbackuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=feedbackuri&item="+item+" >"+obj.getFeedbackname()+"</A>");
         }
         %></td>
       </tr>
       --%>
       <tr>
         <td>阶段审核意见</td>
         <td>
         <%
         enumer=Itemfilehistory.find(item,"areporturi_4");
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_4&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
         }
         if(obj.getAreporturi_4()!=null&&obj.getAreporturi_4().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getAreporturi_4()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_4&item="+item+" >"+obj.getAreportname_4()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
         }
         %>
&nbsp;
         </td>
       </tr>
</table>



<h2>送审阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>标准送审稿</td>
         <td>
         <%

         if(obj.getFormulatinguri()!=null&&obj.getFormulatinguri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=formulatinguri&item="+item+" >"+obj.getFormulatingname()+"</A>");
         }
         %>
		 </td>
       </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD>
                       <%
         if(obj.getFexplainuri()!=null&&obj.getFexplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fexplainuri&item="+item+" >"+obj.getFexplainname()+"</A>");
         }
         %>
              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD>
              <%
         if(obj.getFideauri()!=null&&obj.getFideauri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fideauri&item="+item+" >"+obj.getFideaname()+"</A>");
         }
         %>
              </TD>
</tr>
 <tr>
	          <td>技术背景研究报告</td>
              <TD>
                       <%
         if(obj.getFbackdropuri()!=null&&obj.getFbackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fbackdropuri&item="+item+" >"+obj.getFbackdropname()+"</A>");
         }
         %>
              </TD>
</tr>
<tr>
	          <td>送审会会议纪要</td>
              <TD>
                       <%
         if(obj.getFsummaryuri()!=null&&obj.getFsummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fsummaryuri&item="+item+" >"+obj.getFsummaryname()+"</A>");
         }
         %>
              </TD>
</tr>
           <tr><td colspan="2"><hr size="1"  /></td></tr>
           <tr>
         <td>送审会通知<!--征求意见--></td>
         <td>
         <%
         if(obj.getFinformuri()!=null&&obj.getFinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=finformuri&item="+item+" >"+obj.getFinformname()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
       <%--
       <tr>
         <td>送审会通知-征求单位</td>
         <td>
         <%
         if(obj.getFinform2uri()!=null&&obj.getFinform2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=finform2uri&item="+item+" >"+obj.getFinform2name()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
       --%>
       <tr>
         <td>阶段审核意见</td>
         <td>
         <%
         enumer=Itemfilehistory.find(item,"areporturi_5");
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_5&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
         }
         if(obj.getAreporturi_5()!=null&&obj.getAreporturi_5().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getAreporturi_5()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_5&item="+item+" >"+obj.getAreportname_5()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
         }
         %>
&nbsp;
         </td>
       </tr>
</table>









<h2>报批阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>报批稿</td>
         <td>
         <%
         if(obj.getLeveluri()!=null&&obj.getLeveluri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=leveluri&item="+item+" >"+obj.getLevelname()+"</A>");
         }
         %>
		 </td>
       </tr>

	        <tr>
	          <td>报批稿编制说明</td>
              <TD>
                       <%
         if(obj.getLexplainuri()!=null&&obj.getLexplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lexplainuri&item="+item+" >"+obj.getLexplainname()+"</A>");
         }
         %>
              </TD>
</tr>

	        <tr>
	          <td>报批稿技术背景研究报告</td>
              <TD>
                       <%
         if(obj.getLbackdropuri()!=null&&obj.getLbackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lbackdropuri&item="+item+" >"+obj.getLbackdropname()+"</A>");
         }
         %>
              </TD>
</tr>
   <tr>
         <td>征求意见汇总处理表</td>
         <td><%
         if(obj.getLweaveuri()!=null&&obj.getLweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+" >"+obj.getLweavename()+"</A>");
         }
         %></td>
       </tr>

<tr><td colspan="2"><hr size="1"  /></td></tr>

	        <tr>
	          <td>局长专题会议通知</td>
              <TD><%
         if(obj.getLsinformuri()!=null&&obj.getLsinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lsinformuri&item="+item+" >"+obj.getLsinformname()+"</A>");
         }
         %></TD>
</tr>

	        <tr>
	          <td>局长专题会议纪要</td>
              <TD><%
         if(obj.getLssummaryuri()!=null&&obj.getLssummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lssummaryuri&item="+item+" >"+obj.getLssummaryname()+"</A>");
         }
         %></TD>
</tr>
	        <tr>
	          <td>总局局务会议通知</td>
              <TD><%
         if(obj.getLginformuri()!=null&&obj.getLginformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lginformuri&item="+item+" >"+obj.getLginformname()+"</A>");
         }
         %></TD>
</tr>
       <tr>
         <td>总局局务会议纪要</td>
         <td><%
         if(obj.getLgsummaryuri()!=null&&obj.getLgsummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lgsummaryuri&item="+item+" >"+obj.getLgsummaryname()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
       <tr>
         <td>阶段审核意见</td>
         <td>
         <%
         enumer=Itemfilehistory.find(item,"areporturi_6");
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_6&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　　");
         }
         if(obj.getAreporturi_6()!=null&&obj.getAreporturi_6().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getAreporturi_6()));
           out.print("<A href=ItemDownload.jsp?act=areporturi_6&item="+item+" >"+obj.getAreportname_6()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
         }
         %>
&nbsp;
         </td>
       </tr>
</table>



<h2>发布阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


       <tr>
         <td>标准布稿</td>
         <td>
         <%
         if(obj.getStandarduri()!=null&&obj.getStandarduri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=standarduri&item="+item+" >"+obj.getStandardname()+"</A>");
         }
         %>
		 </td>
       </tr>

	        <tr>
	          <td>标准编制说明</td>
              <TD>
                       <%
         if(obj.getSweaveuri()!=null&&obj.getSweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sweaveuri&item="+item+" >"+obj.getSweavename()+"</A>");
         }
         %>
              </TD>
</tr>

<%--	        <tr>
	          <td>标准技术报告</td>
              <TD>
                       <%
         if(obj.getSbackdropuri()!=null&&obj.getSbackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sbackdropuri&item="+item+" >"+obj.getSbackdropname()+"</A>");
         }
         %>
              </TD>
</tr>
--%>
</table>





<h2>其它阶段</h2>
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
         <td>其它文件1</td>
         <td>
         <%
         if(obj.getOtheruri()!=null&&obj.getOtheruri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=otheruri&item="+item+" >"+obj.getOthername()+"</A>");
         }
         %>		 </td>
       </tr>

       <tr>
         <td>其它文件2</td>
         <TD>
         <%
         if(obj.getOther2uri()!=null&&obj.getOther2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=other2uri&item="+item+" >"+obj.getOther2name()+"</A>");
         }
         %>              </TD>
         </tr>
         </table>

         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>经费申请表</td>
         <TD>
         <%
         enumer=ItemBudget.find(community," AND i.item="+item+" AND DATALENGTH(ib.outlayapp)>0",0,Integer.MAX_VALUE);
         while(enumer.hasMoreElements())
         {
           int ib_id=((Integer)enumer.nextElement()).intValue();
           ItemBudget ib_obj=ItemBudget.find(ib_id);
           java.io.File file=new java.io.File(application.getRealPath(ib_obj.getOutlayapp()));
           out.print("<A href=ItemDownload.jsp?act=outlayapp&item="+item+"&itembudget="+ib_id+" >"+ib_obj.getOutlayappname()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")　<br/>");
         }
         %>
         </TD>
         </tr>

  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
</body>
</html>


