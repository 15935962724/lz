<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%r.add("/tea/ui/node/type/classified/EditClassified");%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<TITLE>21世纪论坛回执单</TITLE>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
</head>
<body style="background-color:transparent ">
<h1><%=r.getString(teasession._nLanguage, "sqsyw")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="/servlet/EditGazetteer" method=post enctype="multipart/form-data" name="form1" onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))">
  <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   java.util.Enumeration enumer= tea.entity.node.Node.findByType(60,node.getCommunity());
   int nodecode=0;
   tea.entity.node.Gazetteer obj=tea.entity.node.Gazetteer.find(0,teasession._nLanguage);;
   while(enumer.hasMoreElements())
   {
     nodecode=((Integer)enumer.nextElement()).intValue();
     if(tea.entity.node.Node.find(nodecode).getCreator().toString().equals(teasession._rv.toString()))
     {
       obj=tea.entity.node.Gazetteer.find(nodecode,teasession._nLanguage);
       if(obj.isExists())
       break;
     }
   }

   if(parambool)
   out.print("<input type='hidden' name=nexturl value="+parameter+">");
   String subject="";
   Date issueDate=null;
   if(!obj.isExists())
   {
     if(request.getParameter("NewNode")!=null)
     {
       out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
     }else
     if(request.getParameter("NewBrother")!=null)
     {
       out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
     }
   }else
   {
     node=tea.entity.node.Node.find(nodecode);
     subject=node.getSubject(teasession._nLanguage);
     teasession._nNode=nodecode;
     //obj=Gazetteer.find(teasession._nNode,teasession._nLanguage);
     issueDate=node.getTime();
   }
    %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <style type="text/css">
<!--
.biaoti {	background-color: #EFF0F4;color:#276A97
}
-->
</style>
  <script language="JavaScript" type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
  <style type="text/css">
<!--
.lunwen {line-height:18pt;border:1px solid #CECECE;background:#F3F3F3;padding:4px;}
.lunwen span{font-size:11pt;color: #cc0000;}
.lunwen talbe{}
.lt {text-align:center;width:100%;background:url(/tea/image/section/13054.jpg) no-repeat 30px center;margin:20px 0}
.lt input{border:1px solid #c00;background:#fff;line-height:15px;}
.hong{color:#CC0000;}
-->
</style>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td valign="top" class="lunwen"><div style="background:#fff;padding:10px;width:100%">
          <div style="float:right;"><span><%=r.getString(teasession._nLanguage, "Iavailableconference")%></span>
            <input name="welcome"  id="radio" type="radio" value="1" checked>
            <%=r.getString(teasession._nLanguage, "Yes")%>
            <input name="welcome"<%=getCheck(obj.getWelcome().equals("0"))%>  id="radio" type="radio" value="0">
            <%=r.getString(teasession._nLanguage, "No")%></div>
          <br />
          <span class="hong">xxx</span><%=r.getString(teasession._nLanguage, "PLEASEFAXBACK")%><br />
          <span class="hong">xxx</span><%=r.getString(teasession._nLanguage, "ACCOMODATIONSANDLOCA")%><br/>
          <table width="100%"  border="0" cellpadding="5" cellspacing="1" bgcolor="#cecece">
            <tr bgcolor="#FFFFFF">
              <td width="130" align="center"><%=r.getString(teasession._nLanguage, "NAME")%></td>
              <td><input type="text" class="text" value="<%=obj.getName()%>" name="name">
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "POSITION")%></td>
              <td><input name="business" value="<%=obj.getBusiness()%>" type="text" class="text">
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "EMPLOYER")%></td>
              <td><span class="biaoti">
                <input name="organise"  value="<%=obj.getOrganise()%>" type="text" class="text">
                </span> </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "PHONE")%></td>
              <td><input type=text  value="<%=obj.getPhone()%>" name=phone></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "FAX")%></td>
              <td><input value="<%=obj.getFax()%>"  type=text name=fax ></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "EMAIL")%></td>
              <td><input type=text name=email value="<%=obj.getEmail()%>" >
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "MAILING")%></td>
              <td><input type=text name=address value="<%=obj.getAddress()%>" >
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "POSTAL")%></td>
              <td><input value="<%=obj.getMobile()%>"  type=text name=mobile>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "MEALREQUEST")%></td>
              <td><input type=text name=leaveflight value="<%=obj.getLeaveFlight()%>" >
                <!--航班班次-->
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "FLIGHT")%></td>
              <td><input type=text name=arrivalflight value="<%=obj.getArrivalFlight()%>" >
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "PAPER")%></td>
              <td><input type=text name=leavetrain value="<%=obj.getLeaveTrain()%>" >
                <!--火车车次-->
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td align="center"><%=r.getString(teasession._nLanguage, "REQUEST")%></td>
              <td><textarea name="remark" cols="50" rows="7" class="text"><%=obj.getRemark()%></textarea>
              </td>
            </tr>
          </table>
        </div>
        <div class="lt"><%=r.getString(teasession._nLanguage, "resumephotographs")%>:　 <%=r.getString(teasession._nLanguage, "Resume")%>
          <input type="file" name="File" value="">
          <%
           if (obj.isExists() &&node.getFileFlag()) //是否有文件
            {
                out.print(new Button(1, "CB", "CBDownload", r.getString(teasession._nLanguage, "CBDownload"), "window.open('/servlet/NodeFile?node=" + nodecode + "', '_self');"));
            }
          %>
          <%=r.getString(teasession._nLanguage, "Photograph")%>
          <input type="file" NAME=Picture value="照片">
          <%
            if (obj.isExists() &&node.getPictureFlag()) //是否有图片
            {
               out.print(new tea.html.Anchor("/servlet/NodePicture?node=" + nodecode,"照片"));
            }
          %>
          <input type="submit" name="Submit" value="　<%=r.getString(teasession._nLanguage, "Submit")%>　">
        </div></td>
    </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

