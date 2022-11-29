<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%>
<%
DbAdapter db1 = new DbAdapter(1);
TeaSession teasession = new TeaSession(request);
String name = teasession._rv._strV;
db1.executeQuery("select count(*) from storecarte where member='" + name + "'");
String strPage=request.getParameter("strPage");
int intPage;
if(strPage==null){
  intPage=1;}
  else
  intPage=Integer.parseInt(strPage);

  int pageSizes=10;
  int counts=1;
  int pageCounts=1;
  if(db1.next()){
    counts=Integer.parseInt(db1.getString(1));}
    db1.close();

    %>
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
    <script type="text/javascript" src="/tea/load.js"></script>
    <SCRIPT language=javascript type="text/javascript">
    function checkall()
    {
      var objForm = document.form1;
      var objLen = objForm.length;
      for (var elcount = 0; elcount < objLen; elcount++)
      {
        if (objForm.elements[elcount].type == "checkbox" && objForm.elements[elcount].disabled==false)
        {
          objForm.elements[elcount].checked = true;
        }
      }
    }
    function f_c(obj,v,n)
{
  var url=new Array("CompanyBasicinfo1.jsp","CompanySynopsis.jsp","CompanyTalkback.jsp","../../../im/SendImMessage.jsp","EonCall1.jsp");

//alert(obj.nextSibling);
  obj.parentNode.parentNode.nextSibling.src="/jsp/type/company/windows/"+url[v]+"?node="+n+"&to=webmaster";
  var cn=obj.parentNode.childNodes;
  for(var i=0;i<cn.length;i++)
  {
 	//cn[i].style.color=(v!=i?"":"#FFFFFF");
  	cn[i].style.background=(v!=i?"":"URL(/res/lib/u/0805/080565361.jpg) no-repeat");
  }
}
function show(n)
{
  //<a href="javascript:f_c(1,'+n+');">推荐产品</a>
  var title='<span id="company_menu"><a href=javascript:; onclick="f_c(this,0,'+n+');">名 片</a><a href=javascript:; onclick="f_c(this,1,'+n+');">企业简介</a><a href=javascript:; onclick="f_c(this,2,'+n+');">给我留言</a><a href=javascript:; onclick="f_c(this,3,'+n+');">在线洽谈</a><a href=javascript:; onclick="f_c(this,4,'+n+');">免费通话</a></span>';
  var footer=location.host+"浏览统计0次 | <a href=/servlet/AddToFavorite?node="+n+" target=_blank>收藏</a>";
  showDialog(title,"/jsp/type/company/windows/CompanyBasicinfo.jsp?node="+n,footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
  //parent.f_c(0,n);
}
    function clearall()
    {
      var objForm = document.form1;
      var objLen = objForm.length;
      for (var elcount = 0; elcount < objLen; elcount++)
      {
        if (objForm.elements[elcount].type == "checkbox")
        {
          objForm.elements[elcount].checked = false;
        }
      }
    }
    function check(){
    for(var i = 0; i < document.form1.elements.length; i++)
        {
          var e = document.form1.elements[i];
          if((e.type == 'checkbox') && (e.checked == true) )
          {
            document.form1.action="/servlet/DeleCarte";
            document.form1.submit();
            return true;
          }
          }
             alert("请至少选择一项进行删除！");
             return false;

        }
    function c_jax(me)
    {
      //  currentPos = "show_"+me;
      location.href='/jsp/profile/EditCarteOper.jsp?cid='+me;
      //send_request("/jsp/profile/EditCarteOper.jsp?cid="+me);
    }
    </script>
    <title>receivecarte</title>
    </head>
    <body bgcolor="#ffffff">
    <h1 align="center">收到的名片</h1>
    <form action="/servlet/DeleCarte" name="form1">

<%
 int pos = 0;
 int pageSize = 20;
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy.MM.dd");
DbAdapter db = new DbAdapter(1);
java.util.Enumeration e = tea.entity.member.InCarteMethod.findCarte(pos, pageSize, name);

db.executeQuery("SELECT Cid, member, operate, company, Idate FROM storecarte where member=" + db.cite(name) + "order by idate desc");
%>


	  <div id="anniu">
        <input type="button" value="全选" onClick="checkall();" class="dax"/>
        <input type="button" value="全不选" onClick="clearall();" class="dax"/>
        <input type="button" value="删除" onClick="check();" class="dax"/>
      </div>
<table border="0" cellpadding="0" cellspacing="0" id="jcfw" class="xiangdui">

  <tr id="mptuob">
    <td align="center">选择</td>
    <td align="center">日期</td>
    <td align="center">对方名片</td>
    <td align="center">操作</td>
	</tr>

	<tr><td colspan="4" height="10px"></td></tr>
  </tr>
  <%
  if(counts%pageSizes==0){pageCounts=counts/pageSizes;}
  else{pageCounts=counts/pageSizes+1;}
  int i=(intPage-1)*pageSizes;
  for( int  j=0; j<i ; j++)
  db.next();
  i=0;
   if (!e.hasMoreElements()) {
                            out.print("<tr><td align=center colspan=4>没有收到任何名片</td></tr>");
                          }
DbAdapter db2 = new DbAdapter(1);
  while(db.next()&&i<pageSizes){
    %>
    <tr>
      <td align="center">
        <%if (db.getInt(3) == 0) {          %>
        <input type="checkbox" id="operate" name="oper" value="<%=db.getInt(1)%>"/>
        <%} else {          %>
        <input type="checkbox" id="operate" name="oper" value="<%=db.getInt(1)%>" disabled/>
        <%}     %>
      </td>
      <td align="center"><%=sdf.format(db.getDate(5)) %>          </td>
      <%
     int id = InCarteMethod.findNode(db.getString(4));
%>
        <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:show(<%=id %>)"><%=db.getString(4) %></a>          </td>

      <td id="show_<%=db.getInt(1)%>" align="left">
      <%
      if (db.getInt(3) == 0) {
        out.print("<span id=tianj><input type=button value='添加至公司名片库' onclick=\"c_jax('" + db.getInt(1) + "')\"/></span>");
      }
      else {
        out.print("已加至公司名片库中");
      }
      %>
      </td>
    </tr>
    <%i ++;}

      db.close();      %>
    <tr id="dibu">
      <td colspan="4" align="right" height="20" valign="bottom">

        <%
        if(pageCounts > 0){
        if(intPage>1){%>
        <a href="/jsp/profile/receivecarte.jsp?strPage=<%=intPage-1%>">上一页</a><%} %>第<%=intPage%>页/共<%=pageCounts%>页<%
        if(intPage<pageCounts){
          %><a href="/jsp/profile/receivecarte.jsp?strPage=<%=intPage+1%>">下一页</a><%}} %>
          &nbsp;&nbsp;</td>
    </tr>

</table>

    </form>
    </body>
    </html>
