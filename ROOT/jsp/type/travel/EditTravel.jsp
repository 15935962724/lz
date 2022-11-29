<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="tea.db.*"%>
<%@page import="tea.html.*"%>
<%@page import="tea.entity.node.*"%>
<%

String community=node.getCommunity();
//out.println("----------"+community+"----------");
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(39))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/Travel");



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="load.js"></script>
</head>
<body onLoad="document.travel.subject.focus();">
<h1><%=r.getString(teasession._nLanguage, "CBNewTravel")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form action="/servlet/EditTravel?node=<%=teasession._nNode%>" method="post" enctype="multipart/form-data" name="travel" onSubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type='hidden' name=Node value="<%=teasession._nNode%>">
<%
     String parameter=teasession.getParameter("nexturl");

    if(parameter!=null)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");

    String text=null,subject=null,keywords=null;
    int counts=20,hostel=0,flight=0,len=0,len1=0;

    int leixing=0;
    java.math.BigDecimal price=new java.math.BigDecimal("0.00");
    java.util.Date leavetime=null,stoptime=null;
    String leavetext=null,priceexplain=null,priceinclude=null,pricenone=null,routing=null,service=null,explain=null,account=null,principal=null,picture=null,picture1=null,zhoubie=null,tj_guojia=null,tj_chengshi=null,tj_jingdian=null,locu=null,daycount=null,airways=null;
            if(request.getParameter("NewNode")!=null)
            {
              text=subject=keywords="";
              leavetext=priceexplain=priceinclude=pricenone=routing=service=explain=principal="";
              account="招商银行一卡通\r\n"+
				"帐　号:\r\n"+
				"户　名:\r\n"+
				"开户行:招商银行广州市分行";
              out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
    	java.util.Calendar c=java.util.Calendar.getInstance();
    	c.set(c.MONTH,c.get(c.MONTH)+1);
    	stoptime=c.getTime();
            }else
              {
                text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
                subject=node.getSubject(teasession._nLanguage);
keywords=node.getKeywords(teasession._nLanguage);

                tea.entity.node.Travel
				obj=tea.entity.node.Travel.find(teasession._nNode,teasession._nLanguage);
                leavetime=obj.getLeavetime();
                leavetext=obj.getLeavetext();
                counts=obj.getCounts();
                price=obj.getPrice();
                priceexplain=obj.getPriceexplain();
                priceinclude=obj.getPriceinclude();
                pricenone=obj.getPricenone();
                routing=obj.getRouting();
                service=obj.getService();
                explain=obj.getExplain();
                account=HtmlElement.htmlToText(obj.getAccount());
                hostel=obj.getHostel();
                flight=obj.getFlight();
                principal=obj.getPrincipal();
                picture=obj.getPicture();
                picture1 = obj.getPicture1();
                locu= obj.getLocu();
                daycount = obj.getDaycount();
                airways = obj.getAirways();
                stoptime=obj.getStoptime();
                leixing = obj.getLeixing();
                zhoubie = obj.getZhoubie();
                tj_guojia=obj.getTj_guojia();
                tj_chengshi =obj.getTj_chengshi();
                tj_jingdian = obj.getTj_jingdian();

                if(picture!=null)
                {
                  len=(int)new java.io.File(application.getRealPath(picture)).length();
                }

                if(picture1!=null)
                {
                	len1=(int)new java.io.File(application.getRealPath(picture1)).length();
                }
              }

            %>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Subject")%> </TD>
      <td><input name="subject" type="text" value="<%=subject%>" size="50"></td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Text")%> </TD>
      <td><textarea style=""  name="text" rows="8" cols="70" class="edit_input"><%=text%></textarea></td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Leavetime")%> </TD>
      <td>
	  <input  id="CHECKBOX" type="CHECKBOX" name="checkbox" onClick="fchick();">
	  <%=new TimeSelection("leavetime", leavetime)%>

		  <input name="leavetext" type="text" value="<%if(leavetext!=null)out.print(leavetext);%>" size="50" >

          <script type="text/javascript">
          function fchick()
          {
            travel.leavetimeYear.disabled=travel.leavetimeMonth.disabled=travel.leavetimeDay.disabled=!travel.checkbox.checked;
            if(travel.checkbox.checked)
            {
              travel.leavetimeYear.style.display=travel.leavetimeMonth.style.display=travel.leavetimeDay.style.display="";
              travel.leavetext.style.display="none";
            }else
            {
              travel.leavetext.style.display="";
              travel.leavetext.focus();
              travel.leavetimeYear.style.display=travel.leavetimeMonth.style.display=travel.leavetimeDay.style.display="none";
            }
          }
          <%if(leavetime==null)
          out.println("travel.checkbox.checked=false;fchick();");
          %>
          </script>
	  </td>
    </tr>
	<tr>

		<td><%=r.getString(teasession._nLanguage,"Jiezhitime")%></td>
		 <td><%=new TimeSelection("stoptime", stoptime)%></td>
	</tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Counts")%></TD>
      <td><input type="text" name="counts" value="<%=counts%>"></td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Price")%> </TD>
      <td><input type="text" name="price" value="<%=price%>"></td>
    </tr>
	<tr>
		<td><%=r.getString(teasession._nLanguage,"Leixing")%></td>
		<td>
			<select name="leixing">
				<option value="0">-----</option>


<%
    	java.util.Enumeration e =TravelType.find(teasession._strCommunity,"");
    	 while(e.hasMoreElements())
    	 {
    	 	int enumer_id =((Integer)e.nextElement()).intValue();
    	 	out.print("<OPTION VALUE="+enumer_id);
    	 	if(enumer_id==leixing)
    	 	{
    	 		out.print(" selected");
    	 	}
    	 	out.print(">"+TravelType.find(enumer_id).getName()+"</option>");
      	 }
    %>


			</select>

<input type="button" value="管理" onclick="javascript:window.showModalDialog('/jsp/type/travel/TravelTypes.jsp',self,'edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:557px;');"/>
		</td>
	</tr>

	<tr>
		<td><%=r.getString(teasession._nLanguage,"Zhoubie")%></td>
		<td>
			<select name="zhoubie">
				<option value="">-------</option>
	<%
        for(int i=0;i<Travel.ZHOUBIE_TYPE.length;i++)
        {
            out.print("<option value="+r.getString(teasession._nLanguage,Travel.ZHOUBIE_TYPE[i]));
            if(r.getString(teasession._nLanguage,Travel.ZHOUBIE_TYPE[i]).equals(zhoubie)){
    	 		out.print(" selected");
    	 	}
            out.println(" >"+r.getString(teasession._nLanguage,Travel.ZHOUBIE_TYPE[i])+"</option>");
       	}
   %>

			</select>
		</td>
	</tr>
	 <tr>
	 	<td><%=r.getString(teasession._nLanguage,"Tujing")%>-<%=r.getString(teasession._nLanguage,"Guojia")%></td>
		<td><input type="text" name="guojia" size="15" value="<%if(tj_guojia!=null)out.print(tj_guojia);%>"></td>
	 </tr>
	  <tr>
	 	<td><%=r.getString(teasession._nLanguage,"Tujing")%>-<%=r.getString(teasession._nLanguage,"Chengshi")%></td>
		<td><input type="text" name="chengshi" size="15" value="<%if(tj_chengshi!=null)out.print(tj_chengshi); %>"></td>
	 </tr>
	  <tr>
	 	<td><%=r.getString(teasession._nLanguage,"Tujing")%>-<%=r.getString(teasession._nLanguage,"Jingdian")%></td>
		<td><input type="text" name="jingdian" size="15" value="<%if(tj_jingdian!=null)out.print(tj_jingdian); %>"></td>
	 </tr>
	    <tr>
     	 <TD> <%=r.getString(teasession._nLanguage,"Hostel")%></TD>
      <td>
      <select name="hostel">
      <option value="0">---------</option>
      <%
e =   Node.findByType(48,community);
while(e.hasMoreElements())
{
 int enumer_id=((Integer) e.nextElement()).intValue();
  out.print("<OPTION VALUE="+enumer_id);
  if(enumer_id==hostel)
  out.print("  selected ");
  out.print(">"+Node.find(enumer_id).getSubject(teasession._nLanguage));
}
      %>
      </select>

      </td>
    </tr>
	    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Flight")%> </TD>
      <td>            <select name="flight">
      <option value="0">---------</option>
      <%
e=Node.findByType(49,community);
while(e.hasMoreElements())
{
 int enumer_id=((Integer) e.nextElement()).intValue();
  out.print("<OPTION VALUE="+enumer_id);
  if(enumer_id==flight)
  out.print(" selected ");
  out.print(">"+Node.find(enumer_id).getSubject(teasession._nLanguage));
}
      %>
      </select>
      </td>
    </tr>
  <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Principal")%> </TD>
      <td><input type="text" name="principal" value="<%if(principal!=null)out.print(principal);%>"></td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Locu")%> </TD><!-- 出发地点 -->
      <td><input type="text" name="locu" value="<%if(locu!=null)out.print(locu); %>"></td>
    </tr>
     <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Daycount")%> </TD><!-- 行程天数 -->
      <td><input type="text" name="daycount" value="<%if(daycount!=null)out.print(daycount); %>"></td>
    </tr>
     <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Keywords")%> </TD><!-- Key=关键词 -->
      <td><input type="text" name="keywords" value="<%if(keywords!=null)out.print(keywords); %>" maxlength="255" ></td>
    </tr>
     <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Airways")%> </TD><!-- Airways=航空公司   -->
      <td><input type="text" name="airways" value="<%if(airways!=null)out.print(airways); %>"></td>
    </tr>
      <!--小图 -->
 <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Picture")%></TD>
	<td><input type="file" name="picture" onDblClick="window.open('<%=picture%>');">
        <%
      if(len>0)
      {
      %>
        <%=len%><%=r.getString(teasession._nLanguage,"Bytes")%>
        <input  id="CHECKBOX" type="CHECKBOX" name="clear" onClick="travel.picture.disabled=this.checked;"/>
        <%=r.getString(teasession._nLanguage,"Clear")%>
        <%}%>
      </td>
    </tr>
    <!-- 大图 -->
    <tr>
      <TD> 大<%=r.getString(teasession._nLanguage,"Picture")%></TD>
      <td><input type="file" name="picture1" onDblClick="window.open('<%=picture1%>');">
        <%
      if(len1>0)
      {
      %>
        <%=len1%><%=r.getString(teasession._nLanguage,"Bytes")%>
        <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="travel.picture1.disabled=this.checked;"/>
        <%=r.getString(teasession._nLanguage,"Clear")%>
        <%}%>
      </td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Priceexplain")%> </TD>
      <td><textarea style=""  name="priceexplain" rows="3" cols="70" class="edit_input"><%if(priceexplain!=null)out.print(priceexplain);%></textarea></td>
    </tr>
    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Priceinclude")%> </TD>
      <td><textarea style=""  name="priceinclude" rows="3" cols="70" class="edit_input"><%if(priceinclude!=null)out.print(priceinclude);%></textarea>
</td>
    </tr>
	    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Pricenone")%> </TD>
      <td><textarea style=""  name="pricenone" rows="3" cols="70" class="edit_input"><%if(pricenone!=null)out.print(pricenone);%></textarea>
</td>
    </tr>
	    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Routing")%> </TD>
      <td><textarea style=""  name="routing" rows="3" cols="70" class="edit_input"><%if(routing!=null)out.print(routing);%></textarea>
</td>
    </tr>    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Service")%> </TD>
      <td><textarea style=""  name="service" rows="3" cols="70" class="edit_input"><%if(service!=null)out.print(service);%></textarea></td>
    </tr>
	    <tr>
      <TD> <%=r.getString(teasession._nLanguage,"Explain")%> </TD>
      <td> <textarea style=""  name="explain" rows="4" cols="70" class="edit_input"><%if(explain!=null)out.print(explain);%></textarea>
	  </td>
    </tr>

  </table>
  <input type=SUBMIT name="GoBackSuper" id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">

  <input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>">
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
