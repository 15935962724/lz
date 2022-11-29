<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

//String price_from=request.getParameter("price_from");
//String price_to=request.getParameter("price_to");
//
//String goodstype=request.getParameter("goodstype");
//String goodstype2=request.getParameter("goodstype2");
//
//String _strBrand=request.getParameter("brand");
int goodstype = 0;
if(request.getParameter("goodstype")!=null && request.getParameter("goodstype").length()>0)
    goodstype = Integer.parseInt(request.getParameter("goodstype"));

String names = request.getParameter("names");
String cj = request.getParameter("cj");
String time_s = request.getParameter("time_s");
String time_k = request.getParameter("time_k");

%>

<script src="/res/<%=teasession._strCommunity%>/script/brand_<%=teasession._nLanguage%>.js"></script>
<script language="javascript" src="/tea/tea.js"  type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<form name="form4" method="GET" action="/servlet/Node?node=8646&language=1" onsubmit="return sub();" >
<input type="hidden" name="editgoodstype" value="ON"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<div id="gongyss">
    <div id="leixing">类型　<select name="goodstype">
    <option value="1">-------------</option>
    <%
    int root = GoodsType.getRootId(teasession._strCommunity);
       java.util.Enumeration e = GoodsType.findByFather(root);
       while(e.hasMoreElements())
       {
         GoodsType node = (GoodsType)e.nextElement();
         out.print("<option value="+node.getGoodstype());
         if(goodstype==node.getGoodstype())
            out.print(" selected ");
         out.print(">"+node.getName(teasession._nLanguage));
         out.print("</option>");
       }
    %>
</select>

</div>
    <div id="mingcheng">名称　<input type="text" name="names" value="<%if(names!=null)out.print(names);%>" /></div>
    <div id="changjia">供应商　<input type="text" name="cj" value="<%if(cj!=null)out.print(cj);%>" /></div>
	<div id="fbshijian"><span class="fb1">发布时间　
	<%--<input name="time_s" size="7"  value="<%if(time_s!=null)out.print(time_s);%>"></span><span class="fb2"><A href="###"><img onclick="showCalendar('form4.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --%>
	 <input id="" name="time_s" size="7"  value="<%if(time_s!=null)out.print(time_s);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form4.time_s');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form4.time_s');" />
	</span>
<span class="fb1">　到　<%--<input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"></span><span class="fb2"><A href="###"><img onclick="showCalendar('form4.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a> --%>
	<input id="" name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form4.time_k');"> 
  <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form4.time_k');" />
	
</span></div>



 <div id="shuoshou"><input type="submit" value="搜索" id="jians"/></div></div>


</form>



