<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%
//审核并压缩图片
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


StringBuffer sql = new StringBuffer(" and property is not null");
StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);

String act = request.getParameter("acts");

if(act!=null)
{
  File file = new File(application.getRealPath("/res/"+teasession._strCommunity+"/picture/"+(request.getParameter("nodes")+".jpg")));
  Baudit.delete(teasession._strCommunity, Integer.parseInt(request.getParameter("nodes")),file);
}

String update= "";
if(request.getParameter("update")!=null&&request.getParameter("update").length()>0)
{
  update = request.getParameter("update");

  sql.append(" and datediff(day,received,"+DbAdapter.cite(update)+")=0");
  param.append("&update=").append(update);
}

String member= "";
if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
{
  member = teasession.getParameter("member");
  sql.append(" and  member like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}

String firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname = teasession.getParameter("firstname");
  sql.append(" and member in (select member from profilelayer where firstname like "+DbAdapter.cite("%"+firstname+"%")+")");
  param.append("&firstname=").append(java.net.URLEncoder.encode(firstname,"UTF-8"));
}

String pg = "-1";
if(teasession.getParameter("yncompression")!=null && teasession.getParameter("yncompression").length()>0 && !teasession.getParameter("yncompression").equals("-1"))
{
  teasession.getSession().setAttribute("",null);
  pg = teasession.getParameter("yncompression");
  if(pg.equals("0")){
    sql.append(" and (yncompression=0 or yncompression is null)");
  }else{
    sql.append(" and yncompression="+pg);
  }
  param.append("&yncompression=").append(pg);
}

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count=Baudit.count(teasession._strCommunity,sql.toString());


%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title></title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  .lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
  </style>
  <script type="">
  function check(){
   var check_fag = 0;
        for(var j = 0; j < document.form1.elements.length; j++){
          var e1 = document.form1.elements[j];
          if((e1.type == 'checkbox') && (e1.checked == true))
          {
            check_fag =1;
            return true;
          }
        }
        focus();
        if(check_fag == 0){
        alert('请至少选择一张图片片进行压缩！');
        return false;
      }
  }
  </script>
</HEAD>
<body style="margin:0;">
<div id="wai">
  <h1>压缩供应商图片</h1>
  <form action="?" method="POST">

<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
    <!--<td>上传日期</td>
    <td><input type="text" name="update" value="<%if(update!=null)out.print(update);%>" readonly="readonly" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(this);"/></td>-->
      <td>会员ID</td>
      <td><input type="text"  name="member" size="27" value="<%=member%>"/></td>
      <!--  <td>姓名</td>
        <td><input type="text"  name="firstname" size="27" value="<%=firstname%>"/></td>-->
        <td>压缩情况</td>
        <td>
          <select name="yncompression">
            <option value="-1" <%if(pg.equals("-1"))out.print("selected");%>>-------</option>
            <option value="0" <%if(pg.equals("0"))out.print("selected");%>>未压缩</option>
            <option value="1" <%if(pg.equals("1"))out.print("selected");%>>已压缩</option>

          </select>

        </td>
     <td width=160><input type="submit" value="查询"/></td>
    </tr>

  </table>
  </form>
  <form name="form1" action="/servlet/EditBPicture" method="POST" onsubmit="return check();">
  <input type="hidden" name="act" value="compression"/>

  <h2>图片信息列表(<%=count%>)</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="3%"></td><td>会员ID</td><td>BP图片名称</td><td>原始图片名称</td><td>版权类型</td><td>状态</td>
    </tr>
    <%
    java.util.Enumeration enumers = Baudit.findByCommunity(teasession._strCommunity,sql.toString()+" order by received desc",pos,10);
    if(!enumers.hasMoreElements())
    {
      %>
      <tr>
        <td colspan="10" align="center">暂无信息</td>
      </tr>
      <%
      }
      for(int i=0;enumers.hasMoreElements();i++)
      {
        int ee=Integer.parseInt(enumers.nextElement().toString());
        Node node = Node.find(ee);
        Baudit baudit = Baudit.find(ee);
        Picture p = Picture.find(ee);
        %>
        <tr>
          <td><input type="checkbox" <%if(baudit.getYncompression()==1){out.print("disabled");}%> name="yncompression" value="<%=ee%>"/></td>
          <td><%=baudit.getMember()%></td>
          <td><%=ee%></td>
          <td><%=p.get_nName()%></td>
          <td><%if(baudit.getProperty()==1){out.print("免版税图片　(<font color=#FE8100>RF</font>)");}else if(baudit.getProperty()==2){out.print("版权管理类图片  (<font color=blue>RM</font>)");}%></td>
          <td><%if(baudit.getYncompression()==1){out.print("已压缩");}else{out.print("未压缩");}%></td>
          <%-- <td><input type="button" class="lzj_001"  onclick="window.open('/jsp/bpicture/EditAuditPicture.jsp?update=<%=update%>&member=<%=member%>&firstname=<%=firstname%>&passpage=<%=pg%>&nodes=<%=ee%>&pos=<%=pos%>','_self')" value="审核" />&nbsp;

          <%
          if(Bimage.falgfind(" node ="+node._nNode))
          {
            %>
            <input type="button" value="删除" class="lzj_001" onClick="if(confirm('此图片已销售，如要删除请慎重考虑！')){window.open('/jsp/bpicture/AuditPicture.jsp?nodes=<%=ee%>&acts=del', '_self');this.disabled=true;};" >
            <%
            }else
            {
              %>
              <input type="button" value="删除" class="lzj_001" onClick="if(confirm('确认删除会员图片！')){window.open('/jsp/bpicture/AuditPicture.jsp?nodes=<%=ee%>&acts=del', '_self');this.disabled=true;};" >
              <%
              }
              %>
              </td>--%>
        </tr>
        <%
        }
        %>
        <tr>
          <td colspan="11" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
          </td>
        </tr>
        <tr>
        <td colspan="11" align="center"><input type="submit" value="压缩"/></td>
        </tr>
  </table>
  </form>
</div>
 <%--<%@include file="/jsp/include/Canlendar4.jsp" %>--%>
</body>
</html>
