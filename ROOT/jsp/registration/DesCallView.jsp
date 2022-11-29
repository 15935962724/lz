<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");
r.add("/tea/resource/Hostel");
TeaSession teasession = new TeaSession(request);

String abc = request.getParameter("roomprice");
      if(abc == null){
          abc ="-1";
      }
int roomPriceId=Integer.parseInt(abc);
RoomPrice roomPrice = RoomPrice.find(roomPriceId);
String roomcount = request.getParameter("roomcount");
String kipDateFlag = request.getParameter("kipDateFlag");
String leaveDateFlag = request.getParameter("leaveDateFlag");
String eveningarrive = request.getParameter("eveningarrive");
String roomprice = request.getParameter("roomprice");
String txtName = request.getParameter("TxtName");
String sex = request.getParameter("sex");
String handset = request.getParameter("handset");
String phone = request.getParameter("phone");
String paymenttype = "0";
String linkmanname = request.getParameter("linkmanname");
String linkmansex = request.getParameter("linkmansex");
String linkmanhandset = request.getParameter("linkmanhandset");
String linkmanphone = request.getParameter("linkmanphone");
String linkmanmail = request.getParameter("linkmanmail");
String linkmanfax = request.getParameter("linkmanfax");
String linkmanaffirm = request.getParameter("linkmanaffirm");
String otherrequest = request.getParameter("otherrequest");
String otheraddbed = request.getParameter("otheraddbed");
String othersend = request.getParameter("othersend");
String memberid = request.getParameter("memberid");
String newmember = request.getParameter("newmember");
java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd");
     java.util.Date date1=formatter.parse(kipDateFlag);
     java.util.Date date2=formatter.parse(leaveDateFlag);
     long l = date2.getTime() - date1.getTime();
     long d = l/(24*60*60*1000);

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="">
function sub(){
document.form1.action='/servlet/EditTelephonist?node=<%=request.getParameter("nnode") %>';
document.form1.submit();
}
function back(){
document.form1.action='/jsp/registration/EditDestine2.jsp?node=<%=request.getParameter("nnode")%>';
document.form1.submit();
}
</script>
</head>
<body>
<h1>订单资料确认</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form name="form1" action="?" method="POST">
<center>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <TD>入住客人：
    <input type="hidden" name="roomcount" value="<%=roomcount%>"/>
    <input type="hidden" name="kipDateFlag" value="<%=kipDateFlag%>"/>
    <input type="hidden" name="leaveDateFlag" value="<%=leaveDateFlag%>"/>
    <input type="hidden" name="eveningarrive" value="<%=eveningarrive%>"/>
    <input type="hidden" name="roomp" value="<%=roomprice%>"/>
    <input type="hidden" name="sex" value="<%=sex%>"/>
    <input type="hidden" name="phone" value="<%=phone%>"/>
    <input type="hidden" name="paymenttype" value="<%=paymenttype%>"/>
    <input type="hidden" name="linkmanname" value="<%=linkmanname%>"/>
    <input type="hidden" name="linkmansex" value="<%=linkmansex%>"/>
    <input type="hidden" name="linkmanhand" value="<%=linkmanhandset%>"/>
    <input type="hidden" name="linkmanph" value="<%=linkmanphone%>"/>
    <input type="hidden" name="linkmanfax" value="<%=linkmanfax%>"/>
    <input type="hidden" name="linkmanaffirm" value="<%=linkmanaffirm%>"/>
    <input type="hidden" name="otherrequest" value="<%=otherrequest%>"/>
    <input type="hidden" name="otheraddbed" value="<%=otheraddbed%>"/>
    <input type="hidden" name="othersend" value="<%=othersend%>"/>
    <input type="hidden" name="TxtName" value="<%=txtName%>"/>
        <input type="hidden" name="memberid" value="<%=memberid%>"/>
            <input type="hidden" name="newmember" value="<%=newmember%>"/>
    </TD>
    <td><%if(txtName == null)out.print("　");%><%=txtName%></td>
  </tr>
  <tr>
  <td>会员ID：</td>
  <td><%if(memberid.length()==0)out.print("　");%>
  <%=memberid%>
  </td>
  </tr>
  <tr>
    <TD>住宿日期：</TD>
    <td><%=kipDateFlag%> 至<%=leaveDateFlag%>  　共&nbsp;<%=d%>&nbsp;晚</td>
  </tr>

  <tr>
    <TD>房间类型：</TD>
    <td>
   <%
   Hostel hostel = Hostel.find(Integer.parseInt(request.getParameter("nnode")), 1);
if(roomPriceId==0){out.print(hostel.getHousexing());}else if(roomPriceId == -1){out.print("无");}else{out.print(roomPrice.getRoomtype(teasession._nLanguage));}
//   java.util.Enumeration enumeration = RoomPrice.findByNode(Integer.parseInt(request.getParameter("nnode")));
//
//        out.print("<select name=roomprice>");
//        out.print("<option value=0>"+hostel.getHousexing()+"</option>");
//
//        while (enumeration.hasMoreElements()) {
//          int roomprice_enumer = ((Integer) enumeration.nextElement()).intValue();
//          RoomPrice rp_enumer = RoomPrice.find(roomprice_enumer);
//          out.print("<option value=" + roomprice_enumer);
//          if (roomprice_enumer == roomPriceId){
//            out.println(" selected");
//          }
//          out.println(">" + rp_enumer.getRoomtype(teasession._nLanguage));
//
//       }
//        out.print("</select>");
     %>
</td>
  </tr>
  <tr>
    <TD>房间数量：</TD>
    <td><b><%=roomcount%></b> 间</td>
  </tr>
  <tr>
    <TD>付款方式：</TD>
    <td>前台自付</td>
  </tr>
  <tr>
    <TD>抵店时间：</TD>
    <td><%=eveningarrive%> 点</td>
  </tr>
  <tr>
    <TD>价 &nbsp; &nbsp;格：</TD>
    <td>
      单价：<%if(roomPriceId==0){out.print(hostel.getPrice());}else{out.print(roomPrice.getProscenium());}%> 元　　　总价：<%if(roomPriceId==0){out.print(Integer.parseInt(hostel.getPrice())*Integer.parseInt(roomcount)*d);}else{out.print(roomPrice.getProscenium()*Integer.parseInt(roomcount)*d);}%>元</td>

  </tr>
  <tr>
    <TD>联 系 人：</TD>
    <td><%if(linkmanname == null)out.print("　");%><%=linkmanname%> </td>
  </tr>
  <tr>
    <TD>联系电话：</TD>
    <td><%if(linkmanhandset == null)out.print("　");%><%=linkmanhandset%> </td>
  </tr>
  <tr>
    <TD>E-mail：</TD>
    <td><%if(linkmanmail == null)out.print("　");%><%=linkmanmail%></td>
  </tr>
</table>
</center>
<br>
　　　　
<center>
<input type=button value=提交 onclick="sub();">
<input type="button" value="上一步" onclick="back();"/>
</center>
</form>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
