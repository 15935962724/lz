<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.ui.*,tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%DbAdapter db = new DbAdapter(1);
DbAdapter db1 = new DbAdapter(1);
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

String name = teasession._rv._strV;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>
  cartewarehouse
  </title>
  <SCRIPT language=javascript type="text/javascript">
  function f_c(obj,v,n)
{
  var url=new Array("CompanyBasicinfo.jsp","CompanySynopsis.jsp","CompanyTalkback.jsp","../../../im/SendImMessage.jsp","EonCall1.jsp");

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
    showDialog(title,"/jsp/type/company/windows/CompanyBasicinfo1.jsp?node="+n,footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
    //parent.f_c(0,n);
  }
  function dosubmit(myvar){
    if(myvar == 'add'){
      window.open('/jsp/profile/addcard.jsp','anyname','width=500,height=200');
    }
    if(myvar == 'upname'){

      for(var i = 0; i < document.form1.elements.length; i++)
      {

        var e = document.form1.elements[i];
        if((e.type == 'radio') && (e.checked == true) )
        {
          window.open('/jsp/profile/upname.jsp?cid='+ e.value,'anyname','width=500,height=200');
          return true;
        }
      }
      alert('请选择需要重命名的名片夹！');
      return false;
    }
    if(myvar == 'uplocation'){
      var radio_fag = 0;
      var check_fag = 0;
      for(var i = 0; i < document.form1.elements.length; i++)
      {
        var e = document.form1.elements[i];
        if((e.type == 'radio') && (e.checked == true)){
          radio_fag = 1;
          break;
        }
        }
        if (radio_fag == 0) {
      alert("请选择一个名片夹进行移动操作！");
      return false;
      }

        if(radio_fag == 1){
        for(var j = 0; j < document.form1.elements.length; j++){
          var e1 = document.form1.elements[j];
          if((e1.type == 'checkbox') && (e1.checked == true))
          {
            check_fag = 1;
            break;
          }
        }
        }
        if(check_fag == 0){
        alert('请至少选择一张名片进行移动操作！');
        return false;
      }
      if(radio_fag == 1 && check_fag == 1){
        document.form1.action="/servlet/UpLocation";
        document.form1.submit();
        return true;
      }
    }
    if(myvar == 'del'){
      for(var i = 0; i < document.form1.elements.length; i++)
      {
        var e = document.form1.elements[i];
        if((e.type == 'checkbox') && (e.checked == true) )
        {
          document.form1.action="/servlet/DeleCarte1";
          document.form1.submit();
          return true;
        }
        if((e.type == 'radio') && (e.checked == true) )
        {

          document.form1.action="/servlet/DeleCarteHouse";
          if(confirm('提示：删除此名片夹，名片夹中所有名片将全部删除！')){
            document.form1.submit();
            return true;
          }else{
            return false;
          }

        }
      }
      alert("请选择一个名片夹或至少一张名片进行删除！");
      return false;

    }

  }
  </script>
  </head>
  <body bgcolor="#ffffff">
  <h1 align="center">公司名片库</h1>
  <div id="jspbefore" style="display:none">

  </div>
  <div id="anniu">
    <input type="button" value="创建名片夹" onClick="dosubmit('add')" class="dax"/>
    <input type="button" value="重命名" onClick="dosubmit('upname')" class="dax"/>
    <input type="button" value="移 至" onClick="dosubmit('uplocation')" class="dax"/>
    <input type="button" value="删除" onClick="dosubmit('del')" class="dax"/>
  </div>
  <form action="" name="form1">
  <div  class="xiangdui1">
    <table border="0" cellpadding="0" cellspacing="0" id="jcfw1">

      <tr id="mptuob">
        <td align="center" width="30%">名片夹</td>
        <td align="center" width="50%">名片列表</td>
        <td align="center" width="20%">日期</td>
      </tr>
      <tr><td style="background-color:#F2F2F2;"></td><td height="10px" colspan="2"></td></tr>

      <tr><td style="background-color:#F2F2F2;vertical-align:top;">
        <div id="mpkz">
        <%
        db.executeQuery("select cardtypeid, cardtypename from cartewarehouse where member='1'");
        while(db.next()){
          %>

          <div>　　<a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=db.getInt(1)%>"><%=db.getString(2) %></a></div>


          <%
          }
          %>
          <%
          db.executeQuery("select cardtypeid, cardtypename from cartewarehouse where member=" + db.cite(name));
          while(db.next()){
            %>
            <div>  <input type="radio" id="operate" name="oper1" value="<%=db.getInt(1)%>"/><a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=db.getInt(1)%>"><%=db.getString(2) %></a></div>

            <%
            }

            %>
            </div>
</td><td colspan="2">
  <div id="mpyoub">

    <table border="0" cellpadding="0" cellspacing="0" id="mpky" width="100%">
    <%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy.MM.dd");
    int pos = 0;
    int pageSize = 20;
    java.util.Enumeration all = tea.entity.member.InCarteMethod.findCarte(pos, pageSize, name);
    java.util.Enumeration nokind = tea.entity.member.InCarteMethod.noKind(pos, pageSize, name);
    String cardtypeid = request.getParameter("cardtypeid");
    String down = request.getParameter("down");
    if("1".equals(down)){
      if(cardtypeid == null || "1".equals(cardtypeid)){
        if (!nokind.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select t2.cid, t2.company, t2.idate from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=1 and t2.operate=1 and t2.member="+db.cite(name)+" order by t2.idate asc;");
        db1.executeQuery("select count(t2.cid) from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=1 and t2.operate=1 and t2.member=" + db.cite(name));
      }else if("2".equals(cardtypeid)){
        if (!all.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select cid, company, idate from storecarte where operate=1 and member="+db.cite(name)+" order by idate asc;");
        db1.executeQuery("select count(cid) from storecarte where operate=1 and member="+db.cite(name));
      }else{
        int intCardTypeID = Integer.parseInt(cardtypeid);
        java.util.Enumeration e = tea.entity.member.InCarteMethod.findCbInfo(pos, pageSize, intCardTypeID);
        if (!e.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select t2.cid, t2.company, t2.idate from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t2.operate=1 and t1.cardtypeid=" + intCardTypeID + "and t2.member="+db.cite(name)+" order by t2.idate asc;");
        db1.executeQuery("select count(t2.cid) from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t2.operate=1 and t1.cardtypeid=" + intCardTypeID + " and t2.member=" + db.cite(name));
      }
    }else{
      if(cardtypeid == null || "1".equals(cardtypeid)){
        if (!nokind.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select t2.cid, t2.company, t2.idate from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=1 and t2.operate=1 and t2.member="+db.cite(name)+" order by t2.idate desc;");
        db1.executeQuery("select count(t2.cid) from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t1.cardtypeid=1 and t2.operate=1 and t2.member=" + db.cite(name));
      }else if("2".equals(cardtypeid)){
        if (!all.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select cid, company, idate from storecarte where operate=1 and member="+db.cite(name)+" order by idate desc;");
        db1.executeQuery("select count(cid) from storecarte where operate=1 and member="+db.cite(name));
      }else{
        int intCardTypeID = Integer.parseInt(cardtypeid);
        java.util.Enumeration e = tea.entity.member.InCarteMethod.findCbInfo(pos, pageSize, intCardTypeID);
        if (!e.hasMoreElements()) {
          out.print("<tr><td align=center colspan=2>此名片夹中无名片</td></tr>");
        }
        db.executeQuery("select t2.cid, t2.company, t2.idate from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t2.operate=1 and t1.cardtypeid=" + intCardTypeID + "and t2.member="+db.cite(name)+" order by t2.idate desc;");
        db1.executeQuery("select count(t2.cid) from cartewarehouse t1 right join storecarte t2 on t1.cardtypeid = t2.cartypeid where t2.operate=1 and t1.cardtypeid=" + intCardTypeID + " and t2.member=" + db.cite(name));
      }
    }
    String strPage=request.getParameter("strPage");
    int intPage;
    if(strPage==null){
      intPage=1;}
      else
      intPage=Integer.parseInt(strPage);

      int pageSizes=7;
      int counts=1;
      int pageCounts=1;
      if(db1.next()){
        counts=Integer.parseInt(db1.getString(1));}
        db1.close();

        if(counts%pageSizes==0){pageCounts=counts/pageSizes;}
        else{pageCounts=counts/pageSizes+1;}
        int i=(intPage-1)*pageSizes;
        for( int  j=0; j<i ; j++)
        db.next();
        i=0;
        while(db.next()&&i<pageSizes){
          int id = InCarteMethod.findNode(db.getString(2));
          %>
          <tr>
            <td width="70%"><input type="checkbox" id="operate" name="oper2" value="<%=db.getInt(1)%>"/><a href="javascript:show(<%=id %>)"><%=db.getString(2) %></a></td>
              <td width="30%"><%=sdf.format(db.getDate(3)) %></td>
          </tr><%
          i++;}db.close();
          %>
          <tr><td colspan="2" height="10px"></td></tr>
          <tr id="feiy" class="dibu2">
            <td colspan="2" align="left"><a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=cardtypeid%>&strPage=<%=strPage!=null?strPage : "1"%>&down=0">升序/</a><a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=cardtypeid%>&strPage=<%=strPage!=null?strPage : "1"%>&down=1">降序</a>
</td>
          </tr></table></div></td></tr>
    </table>
    <div id="dibu">

      <input type="hidden" name="cardtypeid" value="<%=cardtypeid%>"/>
      <input type="hidden" name="strPage" value="<%=strPage%>"/>
      <%

      if(pageCounts > 0){
        if(intPage>1){%>
        <a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=cardtypeid!=null?cardtypeid:"1"%>&strPage=<%=intPage-1%>&down=<%=down!=null&&down!="0"? "1" : "0" %>">上一页</a><%} %>
        第<%=intPage%>页/共<%=pageCounts%>页
        <%
        if(intPage<pageCounts){
          %><a href="/jsp/profile/cartewarehouse.jsp?cardtypeid=<%=cardtypeid!=null?cardtypeid:"1"%>&strPage=<%=intPage+1%>&down=<%=down!=null&&down!="0"? "1" : "0" %>">下一页</a><%} }


          %>

          &nbsp;&nbsp;</div>


  </div>

  </form>


  </body>
</html>
