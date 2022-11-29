<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.confab.*" %>
<%@page  import="tea.resource.Resource" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

int sort =0;
if(request.getParameter("sort")!=null && request.getParameter("sort").length()>0)
     sort = Integer.parseInt(request.getParameter("sort"));
boolean _bFather=request.getParameter("father")!=null;
int father=0;
if(_bFather)
father=Integer.parseInt(request.getParameter("father"));

DCommunity dc=DCommunity.find(community);
if(father==0)
{
  father=dc.getNode();
}

int dynamic=0;//Integer.parseInt(request.getParameter("dynamic"));
String tmp=request.getParameter("dynamic");
if(tmp!=null && tmp.length()>0)
{
  dynamic=Integer.parseInt(tmp);
}
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();


boolean _bCount=request.getParameter("count")!=null;

Dynamic dcobj = Dynamic.find(dynamic);




//先把列放到数组中,以备后面的循环
ArrayList al=new ArrayList();
Enumeration e=DynamicType.findByDynamic(dynamic," AND dynamic="+dynamic+" AND qrc=1",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  al.add(e.nextElement());
}

String strid=request.getParameter("id");


int show = 0;
if(request.getParameter("show")!=null && request.getParameter("show").length()>0)
  show = Integer.parseInt(request.getParameter("show"));

int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}


StringBuffer sql=new StringBuffer();
sql.append(" AND community=").append(DbAdapter.cite(community));
if(dynamic>0)
{
  sql.append(" AND type=").append(dynamic);
}

//权限///
AdminUsrRole aur=AdminUsrRole.find(community,teasession._rv._strV);
String rs[]=aur.getRole().split("/");
String us[]=aur.getClasses().split("/");
int unit=aur.getUnit();
sql.append(" AND ( node NOT IN ( SELECT node FROM DynamicSafety ) OR node IN ( SELECT node FROM DynamicSafety WHERE");
sql.append(" unit LIKE ").append(DbAdapter.cite("%/"+unit+"/%"));
for(int i=1;i<rs.length;i++)
{
  sql.append(" OR role LIKE ").append(DbAdapter.cite("%/"+rs[i]+"/%"));
}
for(int i=1;i<us.length;i++)
{
  sql.append(" OR unit LIKE ").append(DbAdapter.cite("%/"+us[i]+"/%"));
}
sql.append("))");

StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
param.append("&dynamic=").append(dynamic);
param.append("&id=").append(strid);

StringBuffer search=new StringBuffer();
StringBuffer title=new StringBuffer();

for(int i=0;i<al.size();i++)
{
  int id=((Integer)al.get(i)).intValue();
  DynamicType obj=DynamicType.find(id);

  String vlaue=request.getParameter("dynamictype"+id);
  search.append("<SPAN ID=search"+id+">"+obj.getName(teasession._nLanguage));
  if("radio".equals(obj.getType())||"select".equals(obj.getType()))
  {
    search.append(obj.getText(teasession));
    //如果默认值是5的话,将会有两个下接菜单.
    String dt2=request.getParameter("dt2"+id);
    if(dt2!=null)
    {
      param.append("&dt2").append(id).append("=").append(dt2);
      search.append("<script>form1.dt2"+id+".value=\"").append(dt2).append("\";</script>");
    }
  }else if("date".equals(obj.getType()))
  {
    String start=request.getParameter("start"+id);
    String end=request.getParameter("end"+id);
    //开始时间//////
    search.append("<input name=start"+id);
    if(start!=null&&start.length()>0)
    {
      sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value>=").append(DbAdapter.cite(start)).append(" ) ");
      param.append("&start").append(id).append("=").append(start);
      search.append(" value=").append(start);
    }
    search.append(" readonly size=11><a href=### onclick=showCalendar(\"document.all('start" + id + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
    //结束时间//////
    search.append("<input name=end"+id);
    if(end!=null&&end.length()>0)
    {
      sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value<").append(DbAdapter.cite(end)).append(" ) ");
      param.append("&end").append(id).append("=").append(end);
      search.append(" value=").append(end);
    }
    search.append(" readonly size=11><a href=### onclick=showCalendar(\"document.all('end" + id + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
  }else
  {
    search.append("<input name=dynamictype"+id+">");
  }

  title.append("<td>"+obj.getName(teasession._nLanguage));
  if(vlaue!=null&&vlaue.length()>0)
  {
    sql.append(" AND node IN ( SELECT DISTINCT node FROM DynamicValue WHERE dynamictype=").append(id).append(" AND value LIKE ").append(DbAdapter.cite("%"+vlaue+"%")).append(")");
    param.append("&dynamictype").append(id).append("=").append(java.net.URLEncoder.encode(vlaue,"UTF-8"));
    search.append("<script>form1.dynamictype"+id+".value=\"").append(vlaue).append("\";</script>");
  }
  search.append("</SPAN>");
}




param.append("&sort=").append(sort);
param.append("&father=").append(father);
param.append("&show=").append(show);
param.append("&pos=");

//String sql=" AND type>=1024 AND community="+DbAdapter.cite(community)+" AND path LIKE "+DbAdapter.cite("%/"+father+"/%")+" AND type IN ( SELECT dynamic FROM Dynamic WHERE sort="+sort+")";
sql.append(" AND type>=1024 AND community=").append(DbAdapter.cite(community)).append("  AND path LIKE ").append(DbAdapter.cite("%/"+father+"/%"));//.append(" AND type IN ( SELECT dynamic FROM Dynamic WHERE sort=").append(sort).append(")");
int count=Node.count(sql.toString());





//out.print("<!--"+sql.toString()+"-->");


%>
<!--
参数说明:
type: 类别,及动态类的ID
father: 父亲节点
count: 数量(布尔),有此参数表示只能创建一条
-->
<HTML>
<HEAD>
<title><%=dcobj.getName(teasession._nLanguage)%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>

<h1><%=dcobj.getName(teasession._nLanguage)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form name="form1" action="?" method="POST">
<input style="width:80" type="hidden" name="dynamic" value="<%=dynamic%>">
<input style="width:80" type="hidden" name="id" value="<%=strid%>">
<input type ="hidden"  name="father" value="<%=father%>">
<input type="hidden" name="sort"  value="<%=sort%>">
<input style="width:80" type="hidden" name="community" value="<%=community%>">

<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr><td><%=search.toString()%><td><input type="submit" value="查询"/></tr>
</table>
<h2><%=r.getString(teasession._nLanguage,"名片列表")%>( <%=count%> )</h2>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
 <td width="30" nowrap>序号</td>
  <%=title.toString()%>
  <td  nowrap>操作</td>
</tr>


<%
int sum=pos;//序号


boolean f = true;
if(count>0)
{
  Enumeration e2= Node.find(sql.toString(),pos,10);
  //out.print(sql.toString());
  while(e2.hasMoreElements())
  {
    int node_id=((Integer)e2.nextElement()).intValue();
   // out.print(node_id+"<br>");
    Node node_obj=Node.find(node_id);
    Dynamic d_obj=Dynamic.find(node_obj.getType());
    Category c=Category.find(node_id);

//       if(f)
//       {
//         out.print("  <td nowrap>序号</td>");
//       }
//
//       java.util.Enumeration de = DynamicType.findByDynamic(d_obj.getDynamic(),"",0,Integer.MAX_VALUE);
//
//       while(de.hasMoreElements())
//       {
//         int did =((Integer)de.nextElement()).intValue();
//         DynamicType dobj = DynamicType.find(did);
//         if(dobj.isQrc())
//         {
//           /// DynamicValue dvobj = DynamicValue.find(node_id,teasession._nLanguage,dobj.getDynamictype());
//           if(f){
//             out.print("<td nowrap align=center>"+ dobj.getName(teasession._nLanguage)+"</td>");
//
//           }
//         }
//       }
//       if(f)
//       {
//         out.print("<td nowrap>操作</td>");
//       }
//
//           f = false;


   // DynamicValue av = DynamicValue.find(node_id,teasession._nLanguage);
    //out.print(av.getValue());



    out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
    out.print("<td width=20 align=center>"+(++sum)+"</td>");//序号
    Category c_obj=Category.find(node_id);
    Dynamic dobj=Dynamic.find(dynamic);
    /**********************************************////////////循环动态类的内容******////
    java.util.Enumeration de2 = DynamicType.findByDynamic(d_obj.getDynamic(),"",0,Integer.MAX_VALUE);
    for(int j = 0;de2.hasMoreElements();j++)
    {
      int did2 =((Integer)de2.nextElement()).intValue();

      DynamicType dobj2 = DynamicType.find(did2);
      if(dobj2.isQrc())
      {

        DynamicValue dvobj2 = DynamicValue.find(node_id,teasession._nLanguage,dobj2.getDynamictype());
        int defv = dobj2.getDefaultvalue();
        out.print("<td ");
        if(j==0)
        {
          out.print(" align=left");
        }else
        {
          out.print(" align=center ");
        }
        out.print("id= dynamictype"+did2+">");
        if(j==0)
        {
          out.print("<a href=/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?community=roadbridge&node="+node_id+">");
        }
        String value=dvobj2.getValue();
        if (defv == 5 || defv == 6 || defv == 10)
        {
          try
          {
            value = Node.find(Integer.parseInt(value)).getSubject(teasession._nLanguage);
          } catch (Exception ex)
          {}
        }
        out.print(value);
        if(j==0)
        out.print("</a>");
        out.print("</td>");
      }
    }

    /********************************------------------********************************************/


    // Dynamic d_obj=Dynamic.find(c_obj.getCategory());
    //String code=dv.getValue();
    //if(code==null||code.length()<1)
    {
      out.print("<td align=center nowrap><input type=button onclick=\" window.open('/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node="+node_id+"&community="+community+"','_blank');\" value=详细内容> ");
      if(show>=0)
      {
        out.println("<input type=BUTTON value=\"编辑\" onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?community="+community+"&Type="+dynamic+"&node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); \"  > ");
        out.println("<input type=BUTTON VALUE="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDeleteTree")+"')){window.open('/servlet/DeleteNode?node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"', '_self');this.disabled=true;}\" >");
        out.println("<input type=BUTTON VALUE="+r.getString(teasession._nLanguage, "权限")+" onClick=window.open('/jsp/community/EditDynamicSafety.jsp?community="+community+"&node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');>");
      }
      out.print("</td>");
    }//else
    {
     // out.print("<td>　</td>");
    }
    // out.print("<input type=button value="+r.getString(teasession._nLanguage,"胸卡")+" onclick=window.open('/jsp/confab/ConfabQrcView.jsp?node="+nodeobj._nNode+"','','width=500px,height=300px');>");
  }
  if(count>10)
  out.print("<tr><td colspan=25 align=center>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)+"</td></tr>");
}else
{
  out.print("<tr><td colspan=25 align=center>暂无记录</td></tr>");
}
out.print("</table><BR/>");

if(show>=0)
{
  if(!_bCount || sum<1)
  {
    if(_bFather)
    {
      Dynamic d_obj=Dynamic.find(dynamic);
      // if(d_obj.getSort()==sort){
        out.println("<input type=button value=创建-"+d_obj.getName(teasession._nLanguage)+" onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?NewNode=ON&community="+community+"&Type="+dynamic+"&node="+father+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\" >");
        //  }
      }else
      {
        java.util.Enumeration enumeration=Node.findAllSons(dc.getNode());
        while(enumeration.hasMoreElements())
        {
          int node_id=((Integer)enumeration.nextElement()).intValue();
          Category c_obj=Category.find(node_id);
          if(c_obj.getCategory()>=1024)
          {
            Dynamic d_obj=Dynamic.find(c_obj.getCategory());
            if(d_obj.getSort()==sort)
            {
              out.println("<input type=button value=创建-"+d_obj.getName(teasession._nLanguage)+" onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?NewNode=ON&community="+community+"&Type="+c_obj.getCategory()+"&node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\" >");
            }
          }
        }
      }
    }
}
%>
</tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<script language="JavaScript">
 anole('',1,'','','','');
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
