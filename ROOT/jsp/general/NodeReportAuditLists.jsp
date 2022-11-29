<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>

<%@page import="tea.entity.admin.orthonline.*" %>

<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>

<%@page import="java.net.*" %>
<%@page import="tea.entity.Entity" %>

<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/AdminList");
r.add("/tea/resource/Report");

if("POST".equals(request.getMethod()))
{
  String ns[]=request.getParameterValues("nodes");
  String act=request.getParameter("act");
  String nexturl=request.getParameter("nexturl");
  int father=Integer.parseInt(request.getParameter("father"));
  int options=Integer.parseInt(request.getParameter("options"));
  int ok=0,err=0;
  if("clone".equals(act))//复制
  {
    for(int i=0;i<ns.length;i++)
    {
      ok+= Node.clone(Integer.parseInt(ns[i]),father,true,true,options,teasession._rv,null);
    }
  }else if("move".equals(act))//移到
  {
    Node node=Node.find(Integer.parseInt(ns[0]));
    Node node1=Node.find(father);
    if(node1.getPath().startsWith(node.getPath()))
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNewFather"),"UTF-8"));
      return;
    }
    for(int i=0;i<ns.length;i++)
    {
      node=Node.find(Integer.parseInt(ns[i]));
      ok+= node.move(father,options==2);
    }
  }else if("delete".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      int pur=n.isCreator(teasession._rv)?3:AccessMember.find(nid,teasession._rv._strV).getPurview();
      if(pur>2)
      {
        n.delete(teasession._nLanguage);
        Node.delete(nid, n.getType(),teasession._nLanguage);
        ok++;
      }else
      {
        err++;
      }
    }
  }else if("hidden_s".equals(act))//审核
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      if(n.isCreator(teasession._rv)?true:AccessMember.find(nid,teasession._rv._strV).isAuditing())
      {
        if(n.isHidden())
        {
          n.setHidden(false);
        }else
        {
          n.setHidden(true);
        }
        n.setUpdatetime(new Date());

        ok++;
      }else
      {
        err++;
      }
    }
  }
  else if("point".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
     float scwz=teasession.getParameter("scwz")==""?0:Float.parseFloat(teasession.getParameter("scwz"));
     float llwz=teasession.getParameter("llwz")==""?0:Float.parseFloat(teasession.getParameter("llwz"));
     float sczy=teasession.getParameter("sczy")==""?0:Float.parseFloat(teasession.getParameter("sczy"));
     float xzzy=teasession.getParameter("xzzy")==""?0:Float.parseFloat(teasession.getParameter("xzzy"));
     float wzbll=teasession.getParameter("wzbll")==""?0:Float.parseFloat(teasession.getParameter("wzbll"));
     float zybxz=teasession.getParameter("zybxz")==""?0:Float.parseFloat(teasession.getParameter("zybxz"));
     if(!NodePoints.isExist(nid))
     NodePoints.create(nid,scwz,llwz,sczy,xzzy,wzbll,zybxz);
     else
      NodePoints.set(nid,scwz,llwz,sczy,xzzy,wzbll,zybxz);

    }
  }else if("grant".equals(act)||"deny".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      if(n.isHidden()&&AccessMember.find(nid,teasession._rv._strV).isAuditing())
      {
        if("deny".equals(act))
        {
          n.deny();
        }else
        {
          n.setHidden(false);
        }
        ok++;
      }else
      {
        err++;
      }
    }
  }else if("recommend".equals(act))//手动列举
  {
    String ls[] = teasession.getParameter("listing").split("/");
    for(int i = 0;i < ns.length;i++)
    {
      for(int j = 1;j < ls.length;j++)
      {
        Listed.create(Integer.parseInt(ns[i]),Integer.parseInt(ls[j]),null);
      }
    }
  }//act
  StringBuilder sb=new StringBuilder();
  if(err==0)
  {
    sb.append(r.getString(teasession._nLanguage,"UpdateSuccessful"));
  }else
  {
    sb.append("操作成功:").append(ok).append("\\n");
    sb.append("操作失败:").append(err);
  }
  out.print("<script>alert('"+sb.toString()+"'); location.replace('"+nexturl+"');</script>");
  //response.sendRedirect(nexturl);
  return;
}

String strid=request.getParameter("id");
String tmp=request.getParameter("type");
int type=tmp==null?-1:Integer.parseInt(tmp);

int pos=0,size=30;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Node n=Node.find(teasession._nNode);
String path=n.getPath();
if(path==null)
{
  response.setStatus(404);
  return;
}

String member=teasession._rv._strV;


int tatype=type;
if(tatype>65534)
{
  tatype=TypeAlias.find(tatype).getType();
}
CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,tatype);
String fs[]=cal.getField().split("/");

boolean me="true".equals(request.getParameter("me"));

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?node=").append(teasession._nNode);
if(type!=-1)
{
  sql.append(" AND n.path LIKE ").append(DbAdapter.cite(path+"_%"));
  sql.append(" AND n.type=").append(type);
  par.append("&type=").append(type);
}else
{
  sql.append(" AND n.father=").append(teasession._nNode);
}
par.append("&id=").append(strid);
if(me)
{
  sql.append(" AND n.vcreator=").append(DbAdapter.cite(member));
  par.append("&me=").append(me);
}
int father=-1;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  sql.append(" AND n.path LIKE ").append(DbAdapter.cite("%/"+father+"/%"));
}else
{
  father=teasession._nNode;
}

String subject=request.getParameter("subject");
String content=request.getParameter("content");
String t39_media = request.getParameter("t39_media");
//媒体名称
String medianame = request.getParameter("medianame");
if((subject!=null&&subject.length()>0 )|| (content!=null&&content.length()>0))
{//
  sql.append(" AND EXISTS ( SELECT nl.node FROM NodeLayer nl WHERE n.node=nl.node AND nl.language=").append(teasession._nLanguage);
  if(subject!=null&&subject.length()>0)
  {
    sql.append(" AND nl.subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    par.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
  }
  if(content!=null&&content.length()>0)
  {
    sql.append(" AND nl.content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    par.append("&content=").append(URLEncoder.encode(content,"UTF-8"));
  }
  sql.append(")");
}
//创建会员
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0)
{
	membername = membername.trim();
	sql.append(" and n.rcreator like ").append(DbAdapter.cite("%"+membername+"%"));
	par.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));
}



//审核
int audits = -1;
if(teasession.getParameter("audits")!=null && teasession.getParameter("audits").length()>0)
{
	audits =  Integer.parseInt(teasession.getParameter("audits"));
}
if(audits>=0)
{
	sql.append(" and n.audits = ").append(audits);
	par.append("&audits=").append(audits);
}

if(tatype==39)
{


	sql.append(AccessMember.getRole(teasession._strCommunity,teasession._nNode,teasession._rv.toString()));
}



//创建位置
int source = 0;
if(teasession.getParameter("source")!=null && teasession.getParameter("source").length()>0)
{
	source = Integer.parseInt(teasession.getParameter("source"));
}
if(source>0)
{
	sql.append(" and n.source = ").append(source);
	par.append("&source=").append(source);
}

//创建时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c+" 00:00"));
  par.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d+" 23:59"));
  par.append("&time_d=").append(time_d);
}
//稿件类别
int manuscripttype = -1;
if(teasession.getParameter("manuscripttype")!=null && teasession.getParameter("manuscripttype").length()>0)
{
	manuscripttype = Integer.parseInt(teasession.getParameter("manuscripttype"));
}
if(manuscripttype>=0){
	sql.append(" and r.manuscripttype = ").append(manuscripttype);
	par.append("&manuscripttype=").append(manuscripttype);
}


if(t39_media!=null&& t39_media.length()>0)
{
  sql.append(" and  n.node  in (select node from Report where media=").append(t39_media+")");
  par.append("&t39_media=").append(URLEncoder.encode(t39_media,"UTF-8"));
}

if(medianame!=null && medianame.length()>0)
{
	sql.append(" and n.node in (select node from Report where media in (select media from MediaLayer where name like "+DbAdapter.cite("%"+medianame+"%")+"))");
	 par.append("&medianame=").append(URLEncoder.encode(medianame,"UTF-8"));
}
par.append("&pos=");
if(tatype==-1)
{
  tatype=n.getType()==1?Category.find(teasession._nNode).getCategory():0;
}

String order=teasession.getParameter("order");
if(order==null)
{
	if(tatype==39)
	{
		order="r.issuetime";
	}else
	{
		order="n.time";
	}
}
boolean asc="true".equals(teasession.getParameter("asc"));

int count=0;
if(tatype==39){
	count=Node.countReport(teasession._strCommunity,sql.toString());
}else
{
	count=Node.count(sql.toString());
}
sql.append(" ORDER BY ").append(order).append(" ").append(asc?"ASC":"DESC");



//下拉菜单////
int fsize=0,flen=path.split("/").length+1;
StringBuffer fsb=new StringBuffer();


String url=tatype==0?"/jsp/general/EditNode.jsp":tatype<1024?"/jsp/type/"+Node.NODE_TYPE[tatype].toLowerCase()+"/Edit"+Node.NODE_TYPE[tatype]+".jsp":"/jsp/type/dynamicvalue/EditDynamicValue.jsp";

n=Node.find(father);

AccessMember am=AccessMember.find(father,member);



%>
<!--
参数说明:
me: true|false 选填
type:  有:此类型的所有节点(包括孙子节点),无:列出所有子节点
-->
<html>
<head>
<script src="/tea/layer.js" type="text/javascript" ></script>
<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/res/<%=teasession._strCommunity%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script>
function f_gd(id)
{
  selectValue(form2.nodes,id);
  form2.nexturl.value=location.pathname+location.search;
  form2.action="/servlet/GrantNodeRequests";
}
function f_new()
{
  form2.nexturl.value=location.pathname+location.search;
  form2.submit();
}
function f_load()
{

}
function f_act(act)
{
  if(!submitCheckbox(form2.nodes,'<%=r.getString(teasession._nLanguage, "请选中操作数据")%>'))return;
  if(act=="clone"||act=="move")
  {
    var rs=window.showModalDialog('/jsp/general/SelNode.jsp?info='+encodeURIComponent(act=='clone'?'复制到':'移动到'),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
    if(!rs)return;
    var arr=rs.split(",");
    form2.father.value=arr[0];
    form2.options.value=arr[1];
  }else if(act=="delete")
  {
    var rs=window.confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>');
    if(!rs)return;
  }else if(act=="recommend")
  {
    var t;
    var ns=form2.nodes;
    if(!ns.length)ns=new Array(ns);
    for(var i=0;i<ns.length;i++)
    {
      var j=parseInt(ns[i].getAttribute('ntype'));
      if(i!=0&&t!=j)
      {
        t=255;
        break;
      }
      t=j;
    }
    var d=window.showModalDialog('/jsp/listing/SelListing.jsp?type='+t+'&info='+encodeURIComponent("<%=r.getString(teasession._nLanguage,"CBRecommend")%>"),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:420px;');
    if(!d)return;
    eval("d="+d);
    if((d.listing+d.node).length<3)return;
    form2.listing.value=d.listing;
  }else if(act=="point")
  {
    var ns=form2.nodes;
    var nodeid="";
    var count=0;
    for (var i=0; i< ns.length; i++)
    {
      if (ns[i].checked){
       count++;
       nodeid=i;
      }
    }
  var nid=0;
   if (count==1)
    nid=ns[nodeid].value;
    var rs=window.showModalDialog('/jsp/orth/SetPoints.jsp?nodeid='+nid,self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
    if(!rs)return;
    var arr=rs.split(",");
    form2.scwz.value=arr[0];
    form2.llwz.value=arr[1];
    form2.sczy.value=arr[2];
    form2.xzzy.value=arr[3];
    form2.wzbll.value=arr[4];
    form2.zybxz.value=arr[5];
  }else if(act=="hidden_s")
  {
        var rs=window.confirm('<%=r.getString(teasession._nLanguage, "您确定要审核吗？")%>');
    if(!rs)return;
  }
  form2.nexturl.value=location.pathname+location.search;
  form2.act.value=act;
  form2.submit();
}

//添加版面信息
function f_page()
{
	  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:180px;';
	  var url = '/jsp/general/subscribe/Pageinform.jsp?node='+form1.node.value+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);
	  //if(rs==1)
	  //{
	    //window.open('/jsp/type/perform/PerformStreak.jsp?community='+form1.community.value+'&node='+form1.node.value,'_self ');
		 // document.location.reload();
	 // }
}

//媒体
function f_gz2()
{

  if (event.keyCode==38||event.keyCode==40)return;

  sendx("/jsp/type/media/Media_Ajax.jsp?act=searchAllM&cxxw="+encodeURIComponent(form1.medianame.value),
	  function(data)
	  {

	    document.getElementById("cxshow").innerHTML=data;
	  }
  );

}
function f_trdw(igd,iid)
{
  form1.medianame.value=igd;
  document.getElementById("xilidiv").style.display='none';//隐藏div
}
function f_yinyin()
{}
function f_showx()
{}




//修改投稿人信息
function f_cm(igd)
{
	  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:180px;';
	  var url = '/jsp/type/report/contributors/ContributorsMember.jsp?nid='+igd+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);
}

//审核
function f_audit(igd,igd2)
{
	  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:450px;dialogHeight:230px;';
	  var url = '/jsp/general/NodeReportAudit.jsp?node='+form1.node.value+'&nid='+igd+'&community='+form1.community.value+'&act='+igd2;
	  var rs = window.showModalDialog(url,self,y);
	  window.location.reload();
}
</script>
<style type="text/css">
#gzd{position:absolute;position: relative;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 81px;margin-top: 5px;margin-left:-143;z-index:1;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 140px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
<!--#cxshow{position:absolue;width:100}-->
</style>
</head>

<body>
<h1><%=n.getSubject(teasession._nLanguage)%>
<%

if(type==-1)
{
  out.print(n.getAncestor(teasession._nLanguage,"_blank"));
  out.print("<style type='text/css'>#NodeListsIDfather{display:none}</style>");
}

%>
</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="me" value="<%=me%>">
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="asc" value="<%=asc%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td nowrap align="right">主题：</td>
  <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  <td nowrap align="right">内容：</td>
  <td><input type="text" name="content" value="<%if(content!=null)out.print(content);%>"/></td>
  <%//if(fsize>1)out.print(fsb.toString());%>
  </tr>
<tr>
 <td nowrap align="right">创建位置：</td>
  <td>
  <select name="source">
  <option value="0">--选择创建位置--</option>
	<%
		for(int i=1;i<Node.SOURCE_TYPE.length;i++)
		{
			out.print("<option value = "+i);
			if(source==i)
				out.print(" selected ");
			out.print(">"+Node.SOURCE_TYPE[i]);
			out.print("</option>");
		}
	%>
</select>
</td>

  <td nowrap align="right">创建会员：</td>
  <td><input type="text" name="membername" value="<%=Node.getNULL(membername) %>"/></td>
  </tr>


  <tr>
  	<td nowrap align="right">创建时间： </td>
  	<td >
  	  从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />



    </td>

    <%if(n.getType()==1){//说明是类别  %>
  <td nowrap align="right" >新闻来源： </td>
  	<td valign="middle">
  	  <input type="text" name="medianame" id="medianame" value="<%if(medianame!=null)out.print(medianame);%>" onKeyUp="f_gz2();" autoComplete="off" >
  	  <span id="cxshow" style="display:none;"></span>
    </td>

  	<%} %>


</tr>


<%
  	if(n.getType()==1)//说明是类别
  	{

  %>

<tr>
  		<td align="right">稿件类别：</td>
  	<td nowrap>
      <select  name="manuscripttype">
      <option value="-1">------</option>
        <%

        for(int i=0;i<Report.MANUSCRIPT_TYPE.length;i++)
        {

          out.print("<option value="+i);
          if(manuscripttype==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Report.MANUSCRIPT_TYPE[i]+"</option>");
        }
        %>
        </select>

    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>

</tr>





  <%}%>

  <%
  if(tatype==39){
  %>
  <tr>
  <td nowrap align="right">审核状态：</td>
  <td>
  <select name="audits">
  <option value="">--审核状态--</option>
  <option value="0" <%if(audits==0){out.println(" selected ");} %>>等待一级初审</option>
  <option value="1" <%if(audits==1){out.println(" selected ");} %>>等待一级终审</option>
  <option value="2" <%if(audits==2){out.println(" selected ");} %>>等待二级初审</option>
  <option value="3" <%if(audits==3){out.println(" selected ");} %>>等待二级终审</option>

</select>
</td>

  </tr>
  <%} %>
  <tr>

    <td colspan="10" align="center"><input type="submit" value="GO"/></td>
    </tr>

</table>
</form>

<h2><%=r.getString(teasession._nLanguage, "列表")%>　(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条数据&nbsp;)　
<%
boolean isC=n.isCreator(teasession._rv);
int pur=isC?3:am.getPurview();
out.print("<span style='text-align:right;'>");
if(pur>0)//有创建的权限
{
  if(n.getType()==0)
  {
    if(isC||am.isProvider(0))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNewFolder")+" onclick=window.open('/jsp/general/EditNode.jsp?NewNode=ON&Type=0&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
    if(isC||am.isProvider(1))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNewCategory")+" onclick=window.open('/jsp/general/EditNode.jsp?NewNode=ON&Type=1&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
   //显示报纸发行按钮
   if(n.getCategoryosubscribe()!=null && n.getCategoryosubscribe().indexOf("/0/")!=-1)
   {
	 out.println("<input type=\"button\" value=\"报纸设置\" onclick=\"f_page();\">");
   }
   if(n.getCategoryosubscribe()!=null && n.getCategoryosubscribe().indexOf("/1/")!=-1)
   {
     out.println("<input type=\"button\" value=\"报纸导入\" onclick=window.open('/jsp/type/newspaper/run1.jsp?father="+teasession._nNode+"','_self');  >");
   }
   if(n.getCategoryosubscribe()!=null && n.getCategoryosubscribe().indexOf("/2/")!=-1)
   {
	 out.println("<input type=button value=策略设置 onclick=window.open('/jsp/general/subscribe/Tactics.jsp?node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
   }
   if(n.getCategoryosubscribe()!=null && n.getCategoryosubscribe().indexOf("/3/")!=-1)
   {
     out.println("<input type=button value=套餐设置 onclick=window.open('/jsp/general/subscribe/Subscribe.jsp?node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
   }
  }else
  if(n.getType()==1)
  {
    Category c=Category.find(teasession._nNode);
    if(isC||am.isProvider(c.getCategory()))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNew")+" onclick=window.open('"+url+"?NewNode=ON&Type="+type+"&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
  }
}
out.print("</span>");

%>
排序:<select id="s_order" onchange="form1.order.value=value;form1.submit();">

<%if(tatype==39){
	out.print("<option value=\"r.issuetime\">发生时间</option>");
}else
{
	out.print("<option value=\"n.time\">创建时间</option>");
}
%>
<option value="sequence">顺序</option>
</select>

<select id="s_asc" onchange="form1.asc.value=value;form1.submit();"><option value="true">升序<option value="false">降序</select>
</h2>
<script>
$('s_order').value=form1.order.value;
$('s_asc').value=form1.asc.value;
</script>
<form name="form2" action="?" method="post">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="nexturl">
<input type='hidden' name="father" value="0">
<input type='hidden' name="act">
<input type='hidden' name="options" value="0">
<input type='hidden' name="listing">
<input type='hidden' name="scwz">
<input type='hidden' name="llwz">
<input type='hidden' name="sczy">
<input type='hidden' name="xzzy">
<input type='hidden' name="wzbll">
<input type='hidden' name="zybxz">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td width="1" title="全选"><%out.println("<input type='checkbox' onclick='selectAll(form2.nodes,checked)'   style=cursor:pointer>");//"+r.getString(teasession._nLanguage,"SelectAll")+" %></td>
<%
for(int i=1;i<fs.length;i++)
{
  String name;
  if("/father/time/subject/content/".indexOf(fs[i])!=-1)
  {
    name="Node";
  }else
  {
    name=(type<1024?Node.NODE_TYPE[type]:"Dynamic");
  }
  if(n.getType()==1&&"time".equals(fs[i]))
  {
	  out.print("<td id=NodeListsID"+fs[i]+" nowrap='nowrap' >"+r.getString(teasession._nLanguage,"发生时间")+"</td>");
  }else{
	  out.print("<td id=NodeListsID"+fs[i]+" nowrap='nowrap' >"+r.getString(teasession._nLanguage,name+"."+fs[i])+"</td>");
  }


}
out.print("<td id=NodeListsIDmember nowrap='nowrap' >创建会员</td>");
out.print("<td id=NodeListsIDsource nowrap='nowrap' >创建位置</td>");
if(tatype==39){
	out.print("<td id=NodeListsIDsource nowrap='nowrap' >审核状态</td>");
}

out.print("<td>&nbsp;</td>");
out.print("</tr>");


Enumeration e;
if(tatype==39)
{
	e = Node.findReport(teasession._strCommunity,sql.toString()+"  ,  n.node  desc",pos,size);
}else
{
   e=Node.find(sql.toString(),pos,size);
}


if(!e.hasMoreElements())
{
  out.println("<tr><td colspan=30 align=center>暂无记录</td></tr>");
}else
{
  boolean auditing=false;
  for(int x=pos+1;e.hasMoreElements();x++)
  {
    int nodeid=((Integer)e.nextElement()).intValue();
    Node nobj=Node.find(nodeid);
    AccessMember amobj=AccessMember.find(nodeid,member);

    int nt=nobj.getType();
    int nc=nt!=1?0:Category.find(nodeid).getCategory();
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; id=trid_"+nodeid+" >");
    out.print("<td  width=1><input name='nodes'   style=cursor:pointer type='checkbox' ntype='"+nt+"' ncategory='"+nc+"' value='"+nodeid+"' /></td>");

    for(int i=1;i<fs.length;i++)
    {
      out.print("<td  nowrap='nowrap' id=NodeListsID"+fs[i]+">&nbsp;");
      //out.print("<td>");
      if(fs[i].equals("father"))
      {
        out.print("<a href='/servlet/Node?node="+nobj.getFather()+"' target='_blank'>"+Node.find(nobj.getFather()).getSubject(teasession._nLanguage)+"</a>");

      }else if(fs[i].equals("time"))
      {
    	 if(nobj.getType()==39){
        		Report obj=Report.find(nodeid);
    		 out.print(obj.getIssueTimeToString());
    	 }else
    	 {
    		 out.print(nobj.getTimeToString());
    	 }
      }else if(fs[i].equals("subject"))
      {
        out.print(nobj.getAnchor(teasession._nLanguage));
      }else if(fs[i].equals("content"))
      {
        out.print(nobj.getText2(teasession._nLanguage));
      }else if(fs[i].equals("publisher"))
      {
        Report obj=Report.find(nodeid);
        out.print(obj.getAuthor(teasession._nLanguage));
      }else
      {
        switch(type)
        {
          case 39:
          {
            Report obj=Report.find(nodeid);
            if(fs[i].equals("media_id"))
            {
              int _nMedia = obj.getMedia();
              if(_nMedia>0)
              {
                out.print(Media.find(_nMedia).getName(teasession._nLanguage));
              }
            }else if(fs[i].equals("class_id"))
            {
              int _nClass = obj.getClasses();
              if(_nClass>0)
              {
                out.print(Classes.find(_nClass).getName());
              }
            }else if(fs[i].equals("picture"))
            {
              out.print("<img src=\""+obj.getPicture(teasession._nLanguage)+"\">");
            }else if(fs[i].equals("locus"))
            {
              out.print(obj.getLocus(teasession._nLanguage));
            }else if(fs[i].equals("logograph"))
            {
              out.print(obj.getLogograph(teasession._nLanguage));
            }else if(fs[i].equals("issuetime"))
            {
              out.print(obj.getIssueTimeToString());
            }else if(fs[i].equals("subhead"))
            {
              out.print(obj.getSubhead(teasession._nLanguage));
            }else if(fs[i].equals("author"))
            {
              out.print(obj.getAuthor(teasession._nLanguage));
            }
          }
          break;

        }
      }

    }
    //会员
    out.print("<td id=NodeListsIDmember>"+nobj.getCreator()+"</td>");
    //创建位置
    out.print("<td id=NodeListsIDsource>"+Node.SOURCE_TYPE[nobj.getSource()]+"</td>");

	//状态
	if(nobj.getType()==39)
	{
		Report robj = Report.find(nodeid);
	   out.print("<td>");
	   out.print("<font color=");
	   if(nobj.getAudit()==4){out.print("green");}else{out.print("red");}
	   out.print(">");
		out.println(nobj.getAudit_str(nobj.getAudit(),robj));
	  out.print("</font>");

	  if( Report.find(nodeid).getIseditreport()==1)
      {
    	  out.println("(已编辑过)");
      }
	  out.print("</td>");
	}

    out.print("<td nowrap='nowrap'>");
    isC=nobj.isCreator(teasession._rv);
    if(isC||amobj.isProvider(nt))
    {
      pur=isC?3:amobj.getPurview();
      if(pur>1)
      {
	      Node nobj2  =   Node.find(nodeid);
	       if(nobj2.getType()==0||nobj2.getType()==1)
	       {
	          out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('/jsp/general/EditNode.jsp?node="+nodeid+"&EditNode=ON&nexturl='+encodeURIComponent(location.href),'_self');>");
	       }else{
	         out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('/servlet/EditNode?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>");
	       }
      }


      if(nobj.getType()==39  && AccessMember.isAudit(nobj.getFather(), teasession._rv.toString(), teasession._strCommunity, nobj.getAudit()))
      {
    	  out.println("<input type=button value='审核' onclick=f_audit('"+nodeid+"','');>");
      }

      if(pur>2 && nobj.isLayerExisted(teasession._nLanguage)){

    	  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + nodeid + "&language=" + teasession._nLanguage + "&nexturl='+encodeURIComponent(location.href),'_self');}\">");
      }
      if(nobj.getType()==39)
      {
    		Report robj = Report.find(nodeid);
	      //审批意见
	      int ace = nobj.getAudit();
	      if(nobj.getAudit()>0)
	      {
	    	  ace=  nobj.getAudit()-1;
	      }

	      if(robj.isAudits(nodeid))
	      {
	    	  out.println("<input type=button value='审核意见' onclick=f_audit('"+nodeid+"','See');>");
	      }

      }
      if(amobj.isAuditing()&&nobj.isHidden())
      {
       // out.print("<input type=submit name=Grant value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_gd('"+nodeid+"');>");
      //  out.print("<input type=submit name=Deny value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_gd('"+nodeid+"');>");
        auditing=true;
      }

      //如果是投稿新闻 则 显示投稿的姓名
      if(Report.find(nodeid).getCbutors()==1)
      {
    	  out.println("<input type=button value=投稿人信息 onclick=f_cm('"+nodeid+"');>");
      }
    }

  }

  out.println("<tr><td  width=1  title=全选><input type='checkbox' onclick='selectAll(form2.nodes,checked)'  style=cursor:pointer /></td>");
  out.println("<td colspan='7'>");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBClone")+"' onclick=f_act('clone'); >");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBMove")+"' onclick=f_act('move');>");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBDelete")+"' onclick=f_act('delete');>");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBRecommend")+"' onclick=f_act('recommend');>");
  out.println("<input id=PointsSet type='button' value='积分设置' onclick=f_act('point');>");

  if(auditing)
  {
    //out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_act('grant');>");
    //out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_act('deny');>");
	  out.println("<input type='button' value='审核/隐藏'     onclick=f_act('hidden_s');>");
  }
  out.println("</td></tr>");
  if(count>size)
  {
 	out.print("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)+"</td></tr>");
  }
}
out.print("</table>");
%>


<%
e=Listing.find(" AND node="+teasession._nNode+" AND(type=3 OR pick=0)",0,Integer.MAX_VALUE);
if(e.hasMoreElements())
{
  out.print("<h2>"+r.getString(teasession._nLanguage, "一稿多投")+" - "+count+"</h2>");
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr id='tableonetr'><td>&nbsp;</td><td>一稿多投 "+r.getString(teasession._nLanguage,"Node.subject")+"<td>"+r.getString(teasession._nLanguage,"Node.time")+"<td>");
  while(e.hasMoreElements())
  {
    int lid=((Integer)e.nextElement()).intValue();
    Listing ll=Listing.find(lid);
    int ect=ll.getEctypal();
    if(ect>0)lid=ect;
    out.print("<tr><td colspan='4'><h2>"+ll.getName(teasession._nLanguage)+"</h2>");
    Enumeration e2=Listed.find(" AND listing="+lid+" order by stoptime desc ",0,ll.getQuantity());
    for(int i=1;e2.hasMoreElements();i++)
    {
      Listed l=(Listed)e2.nextElement();
      int nid=l.getNode();
      n=Node.find(nid);
      if(n.getTime()==null)continue;
      pur=n.isCreator(teasession._rv)?3:AccessMember.find(nid,member).getPurview();
      out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; ><td>"+i++);
      out.print("<td>"+n.getAnchor(teasession._nLanguage));
      out.print("<td>"+Entity.sdf2.format(n.getTime()));
      out.print("<td colspan=3>");
      if(pur>1)out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('/servlet/EditNode?node="+nid+"&nexturl='+encodeURIComponent(location.href),'_self');>");
      out.print("<input type='button' value="+r.getString(teasession._nLanguage,"CBDeleteItems")+" onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteTree") + "')){window.open('/servlet/DeleteFromBriefcase?node=" + nid + "&listed=" + l.getListed() + "&nexturl='+encodeURIComponent(location.href),'_self');}\">");
    }
  }
  out.print("</td></tr></table>");
}
%>
</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
