<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%

  TeaSession teasession = new TeaSession(request);
  String kipDateFlag, leaveDateFlag;
  int destine=0;
  Expenserecord exp=new Expenserecord();
  if(teasession.getParameter("destine")!=null){
    destine = Integer.parseInt(teasession.getParameter("destine"));
  }
  kipDateFlag = "";
  leaveDateFlag = "";
   int paymenttype=5;

  if(teasession.getParameter("flag")!=null){
     DbAdapter db=new DbAdapter();
  try {db.executeQuery("select * from expenserecord where destine="+destine);
  if(teasession.getParameter("flag").equals("2")){
   if( db.next()){
    exp.setKipdate(db.getString(2).substring(0,10));
    exp.setLeavedate(db.getString(3).substring(0,10));
    exp.setRoomcount(db.getInt(5));
    exp.setRoomprice(db.getInt(4));
    exp.setMoney(db.getFloat(6));

   }
  }
   }catch(Exception e){
           e.printStackTrace();
    }
    finally{
           db.close();
  }

  }else{
    DbAdapter db=new DbAdapter();
   try {
     db.executeQuery("select kipdate,leavedate ,roomprice ,roomcount ,paymenttype from destine where destine="+destine);
     if(db.next()){
       exp.setKipdate(db.getString(1).substring(0,10));
       exp.setLeavedate(db.getString(2).substring(0,10));
       exp.setRoomprice(db.getInt(3));
       exp.setRoomcount(db.getInt(4));

       paymenttype=db.getInt(5);
     }
   }catch(Exception e){
           e.printStackTrace();
    }
    finally{
           db.close();
  }
     db=new DbAdapter();
     try{

       String sql="select retail,proscenium,net,weekend from RoomPrice where roomprice="+exp.getRoomprice();
       long l=Date.valueOf(exp.getLeavedate()).getTime();
       long k=Date.valueOf(exp.getKipdate()).getTime();
       int day=(int)((l-k)/(1000*60*60*24));
       if(day==0){
         day=1;
       }
       db.executeQuery(sql);
       //db.getFloat(paymenttype);
      if( db.next()) {
        exp.setMoney(db.getFloat(paymenttype+1)*day*exp.getRoomcount());
      }

     }
     catch(Exception e){
     e.printStackTrace();
     }finally{
     db.close();
     }
  }



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body bgcolor="#ffffff">
<form action="/servlet/EditExp" name="form1"  method="POST">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


  <tr>
    <td align="right">房间数量：</td>
    <td>
      <input type="hidden" name="opt" value="exp"/>

      <input type="hidden" name="destine" value="<%=destine%>"/>
      <input type="text" name="roomcount" value="<%=exp.getRoomcount()%>"/>
       <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>

   <TD align="right">住店日期：</TD>
   <td>
   <%
   if(exp.getKipdate()==null){
     exp.setKipdate("");
   }
   if(exp.getLeavedate()==null){
     exp.setLeavedate("");
   }

   %>
     <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%=exp.getKipdate()%>" name="kipDateFlag" ID="Text3" onchange="f_ajax(this)">
      <span id="span_kipDateFlag"></span>
      &nbsp;
       <A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
       &nbsp;
      <font color="#1EA817">※</font>
     </td>
     </tr>
     <tr>
     <td align="right"> 离开日期：</td>
     <td>
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%=exp.getLeavedate()%>" name="leaveDateFlag" ID="Text4" >
      <span id="span_leaveDateFlag"></span>
      &nbsp;
    <A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
      &nbsp;&nbsp;
      <font color="#1EA817">※</font>
    </td>
    </tr>
  <tr>
    <td align="right">房间类型：</td>
    <td>
      <select name="roomtype">
      <%
        DbAdapter db = new DbAdapter();
        try {
          String sql = "select node from Destine where destine = " + destine;
          db.executeQuery(sql);

          if (db.next()) {
            int node = db.getInt(1);
            System.out.println(node);
            db.executeQuery("select roomtype,roomprice from RoomPriceLayer where RoomPrice in(select roomprice from roomprice where node=" + node + ")");
            while (db.next()) {

              String roomtype = db.getString(1);
              int RoomPrice = db.getInt(2);
              out.print("<option value="+RoomPrice);
              if(RoomPrice== exp.getRoomprice())
              out.print(" selected");
              out.print(">"+roomtype);

        }
        }
        } catch (SQLException sp) {
          sp.printStackTrace();
        }
        finally {
          db.close();
        }
      %>
      </select>
    </td>
  </tr>
  <tr>
    <td align="right">金额:</td>
    <td>
      <input type="text" name="money" value="<%=exp.getMoney()%>"/>
       <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <td>    </td>
    <td>
      <input type="button" value="提交" onclick="dosubmit()"/>
    </td>
  </tr>
</table>

</form>
</body>
</html>
<script type="text/javascript">


function dosubmit(){
 var roomcount = document.getElementById("roomcount").value
 var kipDateFlag=document.getElementById("kipDateFlag").value
 var leaveDateFlag = document.getElementById("leaveDateFlag").value
 var money=document.getElementById("money").value
  if(roomcount ==""){
	 alert("房间数字符不能为空");
         return;
	}
        if(/^[0-9]*$/g.test(roomcount)){

	}else{
		alert("请输入正确格式的数值如 123  !");
		return;
	}
          if(/^[0-9]+(\.)?[0-9]*$/g.test(money)){

	}else{
		alert("请输入正确格式的金额数值如 123.5!");
		return;
	}

        if(kipDateFlag ==""){
	 alert("入住是日期不能为空");
         return;
	}

        if(leaveDateFlag ==""){
	 alert("离开日期不能为空");
         return;
	}
        if(kipDateFlag > leaveDateFlag){
        alert("离开日期不可以提前于入住日期");
        return;
        }
  if(money==""){
    alert("金额字符不能为空");
    return;
  }


   form1.submit();
}
</script>
