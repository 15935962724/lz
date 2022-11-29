<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="java.io.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.*" %><%@ page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

//word读取html文件时,要在登陆状态////
boolean login=request.getParameter("login")!=null;

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null&&!login)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
int dynamic=Integer.parseInt(request.getParameter("dynamic"));

Flowbusiness fb=Flowbusiness.find(flowbusiness);
int flow=fb.getFlow();

if(flow==42||flow==43)
{
  out.print("<script>var url=parent.location.href; if(url.indexOf('ViewFlow')==-1&&url.indexOf('EditFlow')==-1){ location.replace('/jsp/admin/flow/ViewFlow"+(flow==42?"Receive":"Dispatch")+".jsp'+location.search); }</script>");
}
//if(flow==42)//收文
//{
//  response.sendRedirect("/jsp/admin/flow/ViewFlowReceive.jsp?"+qs);
//  return;
//}else
//if(flow==43)//发文
//{
//  response.sendRedirect("/jsp/admin/flow/ViewFlowDispatch.jsp?"+qs);
//  return;
//}

if(request.getParameter("toword")!=null)
{
  response.setContentType("application/msword");
  response.setHeader("Content-Disposition", "attachment; filename=exp.doc");

  String url=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getRequestURI()+";jsessionid="+session.getId()+"?community="+teasession._strCommunity+"&dynamic="+dynamic+"&flowbusiness="+flowbusiness+"&login=";
  HtmlConvert hc=HtmlConvert.find(url,0);
  byte by[]=hc.getByte();
  if(by!=null)//如果转换失败则输出HTML版的DOC
  {
    OutputStream os= response.getOutputStream();
    os.write(by);
    os.close();
    return;
  }
}


Community c=Community.find(teasession._strCommunity);

%>
<%!
Resource r=new Resource();
private String f(String a)
{
  return Http.enc(a).replaceAll("%2F","/").replaceAll("%3F","?");
}
private String dthtml(TeaSession teasession,int id,int flowbusiness,int seqid)throws Exception
{
  DynamicType obj=DynamicType.find(id);
  if(!obj.isHidden())return "";
  int dyn=obj.getDynamic();

  StringBuilder h=new StringBuilder();
  String width=obj.getWidth();
  String height=obj.getHeight();
  String type=obj.getType();
  h.append(obj.getBefore(teasession._nLanguage));
  //h.append("<b style=color:red>"+id+"</b>");
  DynamicValue av = DynamicValue.find(flowbusiness, teasession._nLanguage, id);
  int def=obj.getDefaultvalue();
  String value="";
  if(obj.getFather()==0)
  {
    value=av.getValue();
  }else
  {
    if(def==12)//隐藏下一步待办人的下接菜单
    {
      return "";
    }
    Enumeration e;
    if (obj.isSeparate())
    {
      e = DynamicType.findByDynamic(obj.getDynamic(), " AND father=" + obj.getFather() + " AND type='select' AND defaultvalue=12", 0, 1);
      if (e.hasMoreElements())
      {
        int id12 = ( (Integer) e.nextElement()).intValue();
        e = DynamicValue.find(flowbusiness, teasession._nLanguage, id12).findMulti("", seqid, 1);
        if (e.hasMoreElements())
        {
          String member = ( (DynamicValue.Multi) e.nextElement()).getValue();
          e = av.findMulti(" AND member=" + DbAdapter.cite(member), 0, 1);
        }
      }
    } else
    {
      e = av.findMulti("", seqid, 1);
    }
    if (e.hasMoreElements())
    {
      DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
      value = m.getValue();
    }
  }
  if(def==5||def==10&&value!=null)//5:信息类别,10:分类
  {
    try
    {
      value=Node.find(Integer.parseInt(value)).getSubject(teasession._nLanguage);
    }catch(NumberFormatException ex)
    {}
  }
  if("img".equals(type)||"sign".equals(type)||"cachet".equals(type))
  {
    if(value!=null&&value.length()>0)
    {
      if(value.startsWith("/res/"))
      {
        h.append("<img src=\""+f(value)+"\"");
        if(!"".equals(width))h.append(" width='"+width+"'");
        if(!"".equals(height))h.append(" height='"+height+"'");
        h.append(" oncontextmenu='return false' />");
      }else
      h.append("<span style='font-size:24px'>"+value+"</span>");//不存在签名图，显示其名
    }
  }else if("file".equals(type))
  {
    if(obj.isMulti())
    {
      Enumeration e_av = av.findMulti("",0,1000);
      if(e_av.hasMoreElements())
      {
        h.append("<table class='filemulti'>");
        for(int i=1;e_av.hasMoreElements();i++)
        {
          DynamicValue.Multi dvm = (DynamicValue.Multi) e_av.nextElement();
          String member = dvm.getMember();
          String path = dvm.getValue();
          String name=value = path.substring(path.lastIndexOf('/') + 1);
          int j=value.lastIndexOf('.');
          if(j!=-1)
          {
            name=value.substring(0,j);
          }
          //<img src='/tea/image/netdisk/" + value.substring(value.lastIndexOf('.') + 1).toLowerCase() + ".gif' width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'; />
          h.append("<tr><td>"+i+"、<a href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(path, "UTF-8") + "&amp;name=" + java.net.URLEncoder.encode(value, "UTF-8") + "'>"+name+"</a></td>");
          //h.append("<td>"+member+"</td>");
          h.append("</tr>\r\n");
        }
        h.append("</table>");
      }
    }else if(value!=null&&value.length()>0)
    {
      String name = value.substring(value.lastIndexOf('/') + 1);
      h.append(r.getString(teasession._nLanguage, "Download")+":<a href='/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(value, "UTF-8")+ "&amp;name=" + java.net.URLEncoder.encode(name, "UTF-8")+"'>"+obj.getName(teasession._nLanguage)+"</a>");
    }
  }else if("office".equals(type))
  {
    h.append("<input type=button name=dynamictype_button" + id+" value=\""+obj.getName(teasession._nLanguage)+"\"");
    if(value!=null&&value.length()>0)
    {
      h.append(" onclick=window.open('/jsp/community/CommunityOfficeView.jsp?community=" + teasession._strCommunity + "&file=" + java.net.URLEncoder.encode(value,"UTF-8") + "','','width=880,height=600,resizable=yes');");
    }else
    {
      //h.append("<center>跳过</center>");
      h.append(" disabled style=background:#CCCCCC");
    }
    h.append(">");
  }else if("folder".equals(type))
  {
    //列
    int qu = obj.getQuantity();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT COUNT(*) FROM DynamicValueMulti WHERE dynamictype IN(SELECT dynamictype FROM DynamicType WHERE father=" + id + ") AND node=" + flowbusiness + " GROUP BY dynamictype,node,language ORDER BY COUNT(*) DESC",0,1);
      if (db.next())
      {
        qu = Math.max(qu, db.getInt(1));
      }
    } finally
    {
      db.close();
    }
    int columns=obj.getColumns();
    if (columns > 1)
    {
      while (qu % columns != 0)
      {
        qu++;
      }
    }
    ArrayList al = new ArrayList();
    Enumeration e = DynamicType.findByDynamic(obj.getDynamic(), " AND father=" + id, 0, Integer.MAX_VALUE);
    while (e.hasMoreElements())
    {
      al.add(e.nextElement());
    }
    for (int i = 0; i < qu; i++)
    {
      if (i > 0 && i % columns == 0)
      {
        h.append(obj.getColumnAfter());
      }
      //块
      for (int j = 0; j < al.size(); j++)
      {
        int dtid = ( (Integer) al.get(j)).intValue();
        h.append(dthtml(teasession,dtid, flowbusiness,i));
      }
    }
  }else
  {
    if(value==null||value.length()<1)
    {
      value="　　　";
    }
    if("radio".equals(type))
    {
//      StringBuffer sb = new StringBuffer();
//      java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(obj.getContent(teasession._nLanguage), "/");
//      for(int index = 0; tokenizer.hasMoreTokens(); index++)
//      {
//        String str = tokenizer.nextToken();
//        boolean bool=str.equals(value);// || index == 0;
//        tea.html.Radio select = new tea.html.Radio("dynamictype" + id, str,bool);
//        select.setDisabled(!bool);
//        String strid = String.valueOf(id) + "_" + index;
//        select.setId(strid);
//        sb.append(select).append("<label for=" ).append( strid ).append( ">" ).append( str ).append( "</label> ");
//      }
//      h.append(sb.toString());
      h.append(value);
    }else if("code".equals(type))
    {
      h.append("<SPAN id="+type+" >"+value+"</SPAN>");
    }else if("csign".equals(type))//会签/////////
    {
//      Enumeration e2=DynamicCsign.find(flowbusiness);
//      if(e2.hasMoreElements())
//      {
//        Flowbusiness fb = Flowbusiness.find(Math.abs(flowbusiness));
//        StringBuilder hattach = new StringBuilder();
//        hattach.append("<table cellspacing='0' cellpadding='0' id='tablecsignattach'><tr><td colspan='2' style='text-align:center;font-weight:bold;font-size:15.0pt;line-height:150%;font-family:宋体;border:0px;margin-bottom:20px;'>文件签发/会签单（附页）</td></tr>");
//        hattach.append("<tr><td colspan='2'><table cellspacing='0' cellpadding='0' id='tablebottom_01'><tr><td  class='wenj_name'>文件题目</td><td class='wenj_td'>" + fb.getName(teasession._nLanguage) + "</td></tr></table></td></tr>");
//        hattach.append("<tr><td  class='pings_xg'>评<br/>审<br/>修<br/>改<br/>意<br/>见<br/>栏</td><td class='pings_right'><table cellspacing='0' cellpadding='0' id='table_nei_01'>");
//        h.append("<table cellspacing='0' cellpadding='0' id='tablecsign'><tr><td class='csigntitle' colspan='5' align='center'>会签意见栏</td></tr><tr><td>送签时间</td><td>会签部门/人员</td><td>会签意见</td><td>签名</td><td>签出日期</td></tr>");
//        boolean flag=false;
//        while(e2.hasMoreElements())
//        {
//          String member=(String)e2.nextElement();
//          DynamicCsign dc=DynamicCsign.find(flowbusiness,member);
//          String csign=dc.getSign();
//          int comment=dc.getComment();
//          h.append("<tr>");
//          h.append("<td>"+dc.getStartTimeToString());
//          h.append("<td>"+member+"同志");
//          h.append("<td>"+DynamicCsign.COMMENT_TYPE[comment]);
//          h.append("<td>&nbsp;");
//          if(csign!=null&&csign.length()>0)
//          {
//            h.append("<img src="+csign+" height='30' oncontextmenu='return false'>");
//          }
//          h.append("<td>"+dc.getEndTimeToString());
//          if(comment==2)//附页
//          {
//            String content = dc.getContent();
//            String unit = "--";
//            AdminUnit au = AdminUnit.find(AdminUsrRole.find(teasession._strCommunity, member).getUnit());
//            if (au.isExists())
//            {
//              unit = au.getName();
//            }
//            hattach.append("<tr><td><table cellspacing='0' cellpadding='0' class='tablebottom_001'><tr><td colspan='2' class='tdtext'>" + (content != null ? content.replaceAll("<", "&lt;").replaceAll("\r\n", "<br/>") : "") + "</td></tr><tr><td class='huiq_bum'>会签部门：" + unit + "</td>");
//            hattach.append("<td class='huiq_rm'>会签人（签名/日期）：");
//            if (csign != null && csign.length() > 0)
//            {
//              hattach.append("<img src='" + csign + "' height='30' oncontextmenu='return false' />");
//            }
//            hattach.append(dc.getEndTimeToString());
//            hattach.append("</td></tr></table></td></tr>");
//            flag=true;
//          }
//        }
//        h.append("</table>");
//        hattach.append("</table></td></tr></table>");
//        if(flag)
//        {
//          h.append(hattach.toString());
//        }
//      }
      if(dyn!=1033&&dyn!=1032)
      {

      }
      Flowbusiness fb = Flowbusiness.find(Math.abs(flowbusiness));
      Enumeration e2=DynamicCsign.find(flowbusiness,id);
      if(e2.hasMoreElements())
      {
        while(e2.hasMoreElements())
        {
          DynamicCsign dc=(DynamicCsign)e2.nextElement();
          String csign=dc.getSign();
          int comment=dc.getComment();
          String cont=MT.f(comment<2?DynamicCsign.COMMENT_TYPE[comment]:dc.getContent(),"无").replaceAll("\r\n","<br/>");
          if(dyn==1033||dyn==1032)//xny 收文,来文
          {
            h.append("<div>"+cont+"</div><div class='csign'>");//会签意见
            if(csign!=null&&csign.length()>0)//会签人
            h.append(csign.startsWith("/res/")?"<img src='"+f(csign)+"' oncontextmenu='return false'>":"<span style='font-size:24px'>"+csign+"</span>");
            h.append("<span class='time'>"+dc.getEndTimeToString()+"</span></div>");//会签日期
            continue;
          }
          h.append("<tr>");
          h.append("<td>"+cont);//会签意见
          h.append("<td class='csign'>");
          if(csign!=null&&csign.length()>0)//会签人
          h.append(csign.startsWith("/res/")?"<img src='"+f(csign)+"' oncontextmenu='return false'>":"<span style='font-size:24px'>"+csign+"</span>");
          h.append("<span class='time'>"+dc.getEndTimeToString()+"</span>");//会签日期
        }
      }else
      {
        if(dyn!=1033&&dyn!=1032)
        h.append("<tr><td>");
      }
    }else
    {
      h.append(value.replaceAll("<","&lt;").replaceAll("\r\n","<br/>"));
    }
  }
  h.append(obj.getAfter(teasession._nLanguage));
  return h.toString();
}

%>
<html>
<head>
<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/">
<style>
<%=c.getCss()%>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script>
window.onbeforeprint=function()
{
  div_print.style.display="none";
}
window.onafterprint=function()
{
  div_print.style.display="";
}
window.onerror=function()
{
  return true;
}
var url=document.location.href;
if(url.indexOf("http")!=0||url.indexOf(".jsp?")==-1)
{
  document.write("<style>#div_print{display:none; }</style>");
}
function f_load()
{
  var view=parent.document.getElementById("view");
  if(view)
  {
    $('but_back').style.display='none';
    if(document.body.scrollHeight>0)
    {
      view.height=document.body.scrollHeight+20;
      view.width=document.body.scrollWidth+20;
      return;
    }
    setTimeout(f_load,20);
  }
}
</script>
</head>
<body onLoad="f_load();" id="noline">
<%

String shead=fb.HEAD_TYPE[fb.head];
out.print(shead.length()>1&&shead.charAt(0)=='<'?shead:"");

Enumeration e=DynamicType.findByDynamic(dynamic);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  out.print(dthtml(teasession,id,-flowbusiness,0));
}
%>

<div id="div_print">
<input type="button" value="保存到HTML" onClick="document.execCommand('SaveAs',true,'Save.htm');">
<input type="button" value="保存到Word" onClick="window.open(location.href+'&toword=','_self');">
<input type="button" value="打印" onClick="window.print();">
<input type="button" value="返回" id="but_back" onclick="history.back()"/>
</div>

</body>
</html>
