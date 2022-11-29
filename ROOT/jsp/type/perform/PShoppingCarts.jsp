<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
java.util.Vector vector=PShoppingCarts.findByMember(teasession._rv.toString(),false);
int sum=vector.size();
java.util.Enumeration enumeration=vector.elements();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</head>
<body>
<DIV ID="edit_BodyDiv">
  <div id="pathdiv">
<%=node.getAncestor(teasession._nLanguage)%></div>
<TABLE width=538 align=center cellspacing="1" bgcolor="#F9F9F9"   class="section">

    <TR bgcolor="#EAF2F2" class="my">

                  <TD width=141> <DIV align=center><font color="#003399"><strong>票品名称</strong></font></DIV></TD>
                  <TD width=90> <DIV align=center><font color="#003399"><strong>活动时间</strong></font></DIV></TD>
                  <TD width=63> <DIV align=center><font color="#003399"><strong>数量</strong></font></DIV></TD>
                  <TD width=84> <DIV align=center><font color="#003399"><strong>价格</strong></font></DIV></TD>
                  <TD width=40> <DIV align=center><font color="#003399"><strong>合计</strong></font></DIV></TD>
                  <TD width=99> <DIV align=center><font color="#003399"><strong>操作</strong></font></DIV></TD>
                </TR>
         <%int nodecode;
         while(enumeration.hasMoreElements())
         {nodecode=((Integer)enumeration.nextElement()).intValue();

       PShoppingCarts objPShoppingCarts=PShoppingCarts.find(nodecode);
       Node objnode=Node.find(objPShoppingCarts.getNode());
         %>
              <form method="post" action="/servlet/EditPShoppingCarts" name=form11>
                <TR bgcolor="#F3F8F8">
                  <TD bgcolor="#F3F8F8"><font color=#0000ff>
                    <a href="/servlet/Perform?node=<%=objnode._nNode%>"><%=objnode.getSubject(teasession._nLanguage)%></a>
          <input type=hidden name="Node" value="<%=objnode._nNode%>" >
        </font></TD>
                  <TD><%=objPShoppingCarts.getTime()%><input type="hidden" name="time" value="<%=objPShoppingCarts.getTime()%>" />
          </TD>
                  <TD>
                      <input type="text" class="edit_input"   name="counts" value="<%=objPShoppingCarts.getCounts()%>"   size="2"  onblur='if (isNaN(counts.value)) {counts.value="<%=objPShoppingCarts.getCounts()%>";alert("数量应是0-9的数字！");counts.focus();}'>
                    </TD>
                  <TD> <input type="hidden" name="price" value="<%=objPShoppingCarts.getPrice()%>" />
<%=objPShoppingCarts.getPrice()%>
                  </TD>
                  <TD> <%=objPShoppingCarts.getPrice()*objPShoppingCarts.getCounts()%></TD>
                  <TD>
                      <input type="submit" name="edit" value="修改" class="CB" >
                      <input type="submit" name="delete" value="删除" class="CB" onclick="if(!confirm('确认删除?')){return false;}">
                    </TD>
                </TR>
			  </form>
                <%}%>
              <TR>
                <TD colSpan=6> <div align="right"><font color=#0000ff>

                    你的购物车有
                    <%=sum%>
                    笔订单,合计<%=PShoppingCarts.sumByMember(teasession._rv.toString())%>元 </font> </div></TD>
              </TR>

            </TABLE>
            <input type="button" value="清空购物车" class="CB" onclick="if(confirm('确认清空购物车?')){window.open('/servlet/EditPShoppingCarts?clear=ON', '_self');}" />
            <input type="button" value="我要结账" class="CB" onclick="window.open('EditOrders.jsp', '_self');" />
             <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
</body>
</html>

