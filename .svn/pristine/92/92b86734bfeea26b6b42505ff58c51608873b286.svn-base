<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.db.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String newmember = teasession._rv.toString();
// tea.entity.admin.Citypopedom cpu = Citypopedom.find(newmember);
//          String cityid = cpu.getCityid().replace("/",",").substring(1,cpu.getCityid().length()-1);
Community community = Community.find(teasession._strCommunity);
//    Hostel hobj = Hostel.find(teasession._nNode,teasession._nLanguage);
int father = Integer.parseInt(request.getParameter("father"));
int nodeid = 0;
if (teasession.getParameter("nodeid") != null && teasession.getParameter("nodeid").length() > 0) {
  nodeid = Integer.parseInt(teasession.getParameter("nodeid"));
}

int id =0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
id = Integer.parseInt(request.getParameter("id"));

Node n = Node.find(nodeid);
String act = request.getParameter("act");
if ("sp".equals(act)) {
  n.sethidden(n._nNode, 0);
  n.uphid(n._nNode);
}
if ("qx".equals(act)) {
  n.sethidden(n._nNode, 1);
}
if ("delete".equals(act)) {
  n.delete(teasession._nLanguage);
  Hostel h = Hostel.find(nodeid, teasession._nLanguage);
  h.delete();
}
StringBuffer param = new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&father=").append(father);
StringBuffer sql = new StringBuffer();

StringBuffer param2 = new StringBuffer();
param2.append("?community=").append(teasession._strCommunity);
param2.append("&father=").append(father);
StringBuffer sql2 = new StringBuffer();

param.append("&id=").append(id);
param2.append("&id=").append(id);

java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString())+" and role like "+DbAdapter.cite("%/"+5+"/%"),0,Integer.MAX_VALUE);
if(ae.hasMoreElements()){
  Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
  if(cobj.getCityid()==null )
  {
    response.sendError(403);
    return;
  }
  String cm[] =  cobj.getCityid().split("/");
  sql.append("  and (");
  sql2.append("  and (");
  for(int i=1;i<cm.length;i++)
  {
    if(cobj.getCityid()!=null){
      sql.append("  h.city =").append(Integer.parseInt(cm[i]));
      sql2.append("  h.city =").append(Integer.parseInt(cm[i]));
    }
    if(cm.length-1>i){
      sql.append("  or ");
      sql2.append("  or ");
    }
  }
  sql.append(")");
  sql2.append(")");

}
//sql.append(" and c.cityid like ").append(" ").append(DbAdapter.cite("%/"+hobj.getCity()+"/%"));

param2.append("&father=").append(father);
int count = 0;
int pos = 0;
int pageSize = 5;
if (teasession.getParameter("Pos") != null) {
  pos = Integer.parseInt(teasession.getParameter("Pos"));
}
int count2 = 0;
int pos2 = 0;
int pageSize2 = 10;
if (teasession.getParameter("Pos2") != null) {
  pos2 = Integer.parseInt(teasession.getParameter("Pos2"));
}

String cmember = request.getParameter("cmember");
if (cmember != null && cmember.length() > 0) {
  sql2.append(" AND n.rcreator like " + DbAdapter.cite("%" + cmember + "%"));
  param2.append("&cmember=").append(java.net.URLEncoder.encode(cmember, "UTF-8"));
}
String honame = request.getParameter("honame");
if (honame != null && honame.length() > 0) {
sql2.append(" AND n.node IN(SELECT node FROM Hostel WHERE name like " + DbAdapter.cite("%" + honame + "%") + ")");
  param2.append("&honame=").append(honame);
}

String type = request.getParameter("type");
if (type != null && type.length() > 0 && !("-1".equals(type))) {
sql2.append(" AND n.hidden="+type);
  param2.append("&type=").append(type);
}
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body id="bodynone">
  <script type="">
  function f_sp(igd)
  {
    if(confirm('您确实要执行操作吗！'))
    {
      form1.nodeid.value=igd;
      form1.act.value="sp";
      form1.action='?';
      form1.submit();
    }
  }
  function f_qx(igd)
  {
    if(confirm('您确实要执行操作吗！'))
    {
      form1.nodeid.value=igd;
      form1.act.value="qx";
      form1.action='?';
      form1.submit();
    }
  }
  function f_delete(igd)
  {
    if(confirm('您确实要拒绝此记录吗'))
    {
      form1.nodeid.value=igd;
      form1.act.value="delete";
      form1.action='?';
      form1.submit();
    }
  }
  function cancel(mem){
    if(confirm('确定取消该酒店吗？')){
      window.location.href='/jsp/registration/canceled.jsp?node='+mem;

    }
  }
  </script>
  <div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%></div>
  <div id="tablebgnone" class="register">
    <h1>酒店审核</h1>
    <div id="head6">
      <img height="6" src="about:blank">
    </div>
    <FORM name="form1" METHOD="POST" action="/jsp/demo/hotelaudits.jsp">
      <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
      <input type="hidden" name="father" value="<%=father%>"/>
      <input type="hidden" name="act"/>
      <input type="hidden" name="id" value="<%=id%>"/>
      <input type="hidden" name="nodeid" value=""/><h2>待批准的申请</h1>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap>申请人</td>
          <td nowrap>酒店名称</td>
          <td nowrap>申请类型</td>
          <td>状态</td>
          <td nowrap>操作</td>

        </tr>
        <%
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try {
          count = db.getInt("SELECT DISTINCT COUNT( n.node ) FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden=1" + sql.toString());
          //out.println("SELECT DISTINCT COUNT( n.node ) FROM Node n,Citypopedom c,Hostel h WHERE n.rcreator = c.member and n.node=h.node and n.father=" + father + " and n.hidden<>0" + sql.toString());
          db.executeQuery("SELECT n.node FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden=1" + sql.toString());
          //out.print("SELECT n.node FROM Node n,Citypopedom c,Hostel h WHERE n.rcreator = c.member and n.node=h.node and n.father=" + father + " and n.hidden<>0" + sql.toString());
          for (int index = 0; index < pos + pageSize && db.next(); index++) {
            if (index >= pos) {
              int j = db.getInt(1);

                Node node1 = Node.find(j);
                Profile p = Profile.find(node1.getCreator()._strR);
                Hotel_application h = Hotel_application.find(node1.getCreator()._strR);

                //p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)
                %>
                <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td nowrap>
                    <a href="/jsp/registration/ProfileView.jsp?node=2221&member=<%=java.net.URLEncoder.encode(node1.getCreator()._strR,"UTF-8")%>"><%=node1.getCreator()._strR%>        </a>
                  </td>
                  <td>
                    <a href="/jsp/registration/HostelView.jsp?node=<%=node1._nNode%>"><%=node1.getSubject(teasession._nLanguage) %>        </a>
                  </td>
                  <%
                  String managertype="";
                  int manager = h.getManage_type();
                  if(manager==1)
                  {
                    managertype = "酒店直营";
                  }
                  else
                  {
                    managertype = "代理商";
                  }
                  %>
                  <td><%=managertype %>      </td>
                  <td>
                  <%

                  out.print("待审批");
                  %>
                  </td>
                  <td>
                    <input type="button" value="审批" onClick="f_sp('<%=node1._nNode%>')"/>
                    <input type="button" value="拒绝" onClick="f_delete('<%=node1._nNode%>');"/>
                  </td>

                </tr>
                <%
              }
            }
          } catch (Exception e) {}
          finally {
            db.close();
          }
          %>
          <tr>
            <td>&nbsp;</td>
            <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%>      </td> <td>&nbsp;</td> <td>&nbsp;</td><td>&nbsp;</td>
          </tr>
      </table>
      <h2>已批准的申请</h2><br>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td>        申请人：
              <input type="text" name="cmember" value="<%if(cmember!=null)out.print(cmember);%>"/>
              &nbsp;&nbsp;&nbsp;
              酒店名称：
              <input type="text" name="honame" value="<%if(honame!=null)out.print(honame);%>"/>
              &nbsp;&nbsp;&nbsp;&nbsp;

              &nbsp;&nbsp;&nbsp;
              申请类型：
              <select name="type" >
              <option value="-1">全部</option>
              <option value="0">已审批</option>
              <option value="3">已取消</option>
              </select>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" value=" GO "/>
            </td>
          </tr>
          </table><br />
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap>申请人</td>
          <td nowrap>酒店名称</td>
          <td nowrap>申请类型</td>
          <td>状态</td>
          <td nowrap>操作</td>

        </tr>
        <%
        tea.db.DbAdapter db2 = new tea.db.DbAdapter();
        try {
          //      count2 = db2.getInt("SELECT DISTINCT COUNT( node ) FROM Node WHERE father=" + father + " and hidden<>1" + sql2.toString());
          //      db2.executeQuery("SELECT node FROM Node WHERE father=" + father + " and hidden<>1" + sql2.toString());

//          count2 = db2.getInt("SELECT DISTINCT COUNT( n.node ) FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden<>1 " + sql2.toString());

          count2 = db2.getInt("SELECT DISTINCT COUNT( n.node ) FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden<>1 " + sql2.toString());

          db2.executeQuery("SELECT n.node FROM Node n,Hostel h WHERE n.node=h.node and n.father=" + father + " and n.hidden<>1 " + sql2.toString());

          for (int index2 = 0; index2 < pos2 + pageSize2 && db2.next(); index2++) {
            if (index2 >= pos2) {
              int j2 = db2.getInt(1);
              Node node12 = Node.find(j2);
                Profile p2 = Profile.find(node12.getCreator()._strR);
                Hotel_application h2 = Hotel_application.find(node12.getCreator()._strR);
                //p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)
                %>
                <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
                  <td nowrap>
                    <a href="/jsp/registration/ProfileView.jsp?member=<%=java.net.URLEncoder.encode(node12.getCreator()._strR,"UTF-8")%>"><%=node12.getCreator()._strR%>        </a>
                  </td>
                  <td>
                    <a href="/jsp/registration/HostelView.jsp?node=<%=node12._nNode%>"><%=node12.getSubject(teasession._nLanguage) %>        </a>
                  </td>
                  <%
                  String managertype="";
                  int manager = h2.getManage_type();
                  if(manager==1)
                  {
                    managertype = "酒店直营";
                  }
                  else
                  {
                    managertype = "代理商";
                  }
                  int q = node12.hidden(j2);
                  %>
                  <td><%=managertype %>      </td>
                  <td>
                  <%

                  if(q == 0){
                    out.print("已审批");
                  }else{
                    out.print("已取消");
                  }
                  %>
                  </td>
                  <td>
                    <%if(q==0){%>
                    <input type="button" value="取消" onClick="cancel(<%=j2 %>)"/>
                    <% }else{out.print("　");}%>


                  </td>
                </tr>
                <%
              }
            }
          } catch (Exception e) {}
          finally {
            db2.close();
          }
          %>
          <tr>
            <td>&nbsp;</td>
            <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param2.toString() + "&Pos2=", pos2, count2,pageSize2)%>      </td> <td>&nbsp;</td> <td>&nbsp;</td><td>&nbsp;</td>
          </tr>
      </table>
    </FORM>
    <div id="head6">
      <img height="6" src="about:blank">
    </div>
  </div>
  <div id="jspafter" style="display:none"><%=community.getJspAfter(teasession._nLanguage)%></div>
  <script>
  if(top.location==self.location)
  {
    jspbefore.style.display='';
    jspafter.style.display='';
  }
  </script>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script language="JavaScript">
  anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
  </body>
</html>
