<%@page import="tea.entity.admin.mov.MemberOrder"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>

<%@page import="tea.entity.admin.orthonline.*" %>

<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>

<%@page import="java.net.*" %>
<%@page import="tea.entity.Entity" %>
<%@page import="tea.html.Image"%>

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
  String sbstr = r.getString(teasession._nLanguage,"UpdateSuccessful");
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

      }else
      {
        err++;
      }
    }
  }else if("hidden_s".equals(act))//批量审核
  {
	  tea.entity.integral.CommunityPoints cp= tea.entity.integral.CommunityPoints.find(tea.entity.integral.CommunityPoints.getIgid(teasession._strCommunity));
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n = Node.find(nid);
      if(n.getAudit()==1)
      {
		Report robj = Report.find(nid);

        n.set("audits",String.valueOf(n.audits=2));
        robj.set("editmember",teasession._rv._strR,teasession._nLanguage);
		n.setHidden(false);
		//修改发生时间
		//robj.setIssuetime(new Date());
		n.set("auditmember",String.valueOf(n.auditmember = teasession._rv._strR));
        n.set("audittime",n.audittime = new Date());
        n.set("starttime", n.getTime());

			//添加积分
			Profile p = Profile.find(n.getCreator()._strR);

			p.setIntegral(p.getIntegral() +cp.getCyjf());
			p.setContributeintegral(p.getContributeintegral() + cp.getCyjf());
      }else
      {
    	  sbstr = "审核文章中有已审核或退稿的，系统只针对未审核文章";
    	  break;
      }
		    ok++;

    }

    tea.ui.TeaServlet.delete_html_community(teasession._strCommunity);
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
    sb.append(sbstr);
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



Node n=Node.find(teasession._nNode);
String path=n.getPath();
if(path==null)
{
  response.setStatus(404);
  return;
}

String member=teasession._rv._strV;


int tatype=type;


boolean me="true".equals(request.getParameter("me"));

StringBuffer sql=new StringBuffer(" and n.type=39 and r.cbutors = 1 and n.audits!=0 and n.audits!=4 ");
StringBuffer par=new StringBuffer();
par.append("?node=").append(teasession._nNode);

String auditmember = teasession.getParameter("auditmember");
if(auditmember!=null && auditmember.length()>0)
{

	sql.append(" AND  n.auditmember = ").append(DbAdapter.cite(auditmember));
	par.append("&auditmember=").append(URLEncoder.encode(auditmember, "UTF-8"));


}

if(n.getType()==0)
{
	sql.append(" and n.path like ").append(DbAdapter.cite("%/"+teasession._nNode+"/%"));
}else{
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


String divid = "cnlistid1";//默认最新投稿
if(teasession.getParameter("divid")!=null && teasession.getParameter("divid").length()>0)
{
	divid = teasession.getParameter("divid");
	par.append("&divid=").append(divid);
}
String membertypeid = "membertypeclass0";//默认最新投稿
if(teasession.getParameter("membertypeid")!=null && teasession.getParameter("membertypeid").length()>0)
{
	membertypeid = teasession.getParameter("membertypeid");
	par.append("&membertypeid=").append(membertypeid);
}


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
//投稿时间
	String time_c = teasession.getParameter("time_c");
	if(time_c!=null && time_c.length()>0)
	{
	  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c+" 00:00 "));
	  par.append("&time_c=").append(time_c);
	}
	String time_d = teasession.getParameter("time_d");
	if(time_d!=null && time_d.length()>0)
	{
	  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d+" 23:59"));
	  par.append("&time_d=").append(time_d);
	}

//审核状态
int audits=1;
if(teasession.getParameter("audits")!=null && teasession.getParameter("audits").length()>0)
{
	audits = Integer.parseInt(teasession.getParameter("audits"));
}

if(audits>0 && audits<=4 && auditmember==null)
{
	sql.append(" and n.audits = ").append(audits);

}
par.append("&audits=").append(audits);

String membertype = teasession.getParameter("membertype");
if("membertypeclass0".equals(divid))
{
	membertype = "0";
}

if(membertype!=null && membertype.length()>0 && "2".equals(membertype) &&!"membertypeclass0".equals(divid))
{
	//订报会员查询
	sql.append(" and  exists (select member from MemberOrder m where n.rcreator=m.member and m.membertype="+membertype+" )");
	par.append("&membertype=").append(membertype);
}

if(membertype!=null && membertype.length()>0 && "3".equals(membertype))
{
	//订报会员查询
	sql.append(" and  exists (select member from AdminUsrRole ar where n.rcreator=ar.member and ar.role like "+DbAdapter.cite("%/13/%")+" )");
	par.append("&membertype=").append(membertype);
}


//

if(tatype==-1)
{
  tatype=n.getType()==1?Category.find(teasession._nNode).getCategory():0;
}

int pos=0,size=20;
if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }

int count=Node.countReport(teasession._strCommunity,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
	o="n.time";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
par.append("&o=").append(o).append("&aq=").append(aq);



//下拉菜单////
int fsize=0,flen=path.split("/").length+1;
StringBuffer fsb=new StringBuffer();


String url=tatype==0?"/jsp/general/EditNode.jsp":tatype<1024?"/jsp/type/"+Node.NODE_TYPE[tatype].toLowerCase()+"/Edit"+Node.NODE_TYPE[tatype]+".jsp":"/jsp/type/dynamicvalue/EditDynamicValue.jsp";

n=Node.find(father);

AccessMember am=AccessMember.find(father,member);

//out.println(sql.toString());

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
<script src="/tea/mt.js" type="text/javascript" ></script>
<script src="/res/<%=teasession._strCommunity%>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script src="/tea/Calendar.js" type="text/javascript"></script>



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





//修改投稿人信息
function f_cm(igd)
{
	  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:230px;';
	  var url = '/jsp/type/report/contributors/ContributorsMember.jsp?nid='+igd+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);
}
function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }
//审核
function f_audit(igd)
{
	mt.show("您确定要审核记录吗？",2);
	mt.ok=function(){
		sendx("/servlet/EditContributors?node="+igd+"&act=audit&nexturl="+form2.nexturl.value,
				 function(data)
				 {
				   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
				   {
						mt.show(data);
						mt.ok=function(){
							window.location.reload();
						};

				   }
				 }
			);
	};
	/* if(confirm('您确定要审核记录吗？'))
	{

	 } */
	/*
	form2.act.value="audit";
	form2.node.value=igd;
	form2.nexturl.value=location.pathname+location.search;
	form2.action="/servlet/EditContributors";
	form2.submit();
*/
}
//隐藏
function f_hidden(id,b)
{
  mt.show("状态：<input type='radio' name='_state' id='_state0' "+(b?"":"checked")+" /><label for='_state0'>显示</label> <input type='radio' name='_state' id='_state1' "+(b?"checked":"")+" /><label for='_state1'>隐藏</label>",2,"mt.post('/servlet/EditContributors?node="+id+"&act=state&nexturl=location.reload()&state='+($('_state0').checked?0:1))");
}
//
function f_rejection(igd)
{
	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:200px;';
	  var url = '/jsp/type/report/contributors/Rejection.jsp?nid='+igd+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);

	  if(rs==1)
	  {
		  window.location.reload();
	  }
}
function f_rejection2()
{
	if(!submitCheckbox(form2.nodes,'<%=r.getString(teasession._nLanguage, "请选中操作数据")%>'))return;
	var igd = '/';
	for (var i=0; i< form2.nodes.length; i++)
		    {
		      if (form2.nodes[i].checked)
		      {
			      igd = igd+form2.nodes[i].value+"/"
			  }
		    }

	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:200px;';
	  var url = '/jsp/type/report/contributors/Rejection.jsp?nid='+igd+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);

	  if(rs==1)
	  {
		  window.location.reload();
	  }
}


//
function f_delete(igd)
{
	if(confirm('确实要删除吗？'))
	{
			 sendx("/servlet/EditContributors?node="+igd+"&act=ContributorsNodeLists&nexturl="+form2.nexturl.value,
			 function(data)
			 {
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
			   {
					alert(data);
					window.location.reload();
			   }
			 }
			);
		 }
}
//状态搜索
function f_s(igd,igd2)
{
	form1.audits.value=igd;
	form1.divid.value=igd2;
	form1.action="?";
	form1.submit();
}
//会员类型搜索
function f_mt(igd,igd2)
{
	form1.membertype.value=igd;
	form1.membertypeid.value=igd2;
	if(igd==-1)
	{
		form1.audits.value=1;
		form1.divid.value='cnlistid1';
	}
	form1.action="?";
	form1.submit();
}


//禁止投稿
function f_prohibition(igd)
{
 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:550px;dialogHeight:300px;';

	 var url = '/jsp/type/report/contributors/RejectionMember.jsp?member='+encodeURIComponent(igd)+'&t='+new Date().getTime();

	 var rs = window.showModalDialog(url,self,y);

	 if(rs==1){

		 window.location.reload();

	 }
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
<h1>

<%
	if(n.getType()==0)
	{
		out.println("投稿管理--综合投稿的所有栏目");
	}else
	{

%>
<div id="pathdiv">投稿管理--<%
String ns = n.getAdminAncestor(teasession._nLanguage).replaceAll("id=\"PathID1\">>", "id=\"PathID1\">当前栏目：");
ns = ns.substring(ns.indexOf("</span><span id=\"PathID2\">"),ns.length()).replaceAll("id=\"PathID2\">>", "id=\"PathID1\">当前栏目：");;
out.println(ns);

%></div>
<%} %>
</h1>


<h2>查询</h2>
<form name="form1" action="?data=<%=new Date() %>">

<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="me" value="<%=me%>">
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="audits" value="<%=audits %>"/>
<input type="hidden" name="divid" value="<%=divid %>"/>
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="membertypeid" value="<%=membertypeid %>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td nowrap align="right">主题：</td>
  <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  <td nowrap align="right">内容：</td>
  <td><input type="text" name="content" value="<%if(content!=null)out.print(content);%>"/></td>

  </tr>
<tr>
 <td nowrap align="right">投稿会员：</td>
  <td><input type="text" name="membername" value="<%=Node.getNULL(membername) %>"/></td>
 <td nowrap align="right">投稿时间：</td>
  <td>
 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly" style="cursor:pointer"  onclick="new Calendar().show('form1.time_c');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly" style="cursor:pointer" onClick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

</td>

<td><input type="submit" value="GO"/></td>
  </tr>
</table>


</form>


<div  class="cnlistclass" style="clear:both;">
<div>
<%
out.print("<span id=cnlistRight style='clear:both;display:block;float:left;'>");

	out.print("<a href=### onclick=f_mt('-1','membertypeclass0'); class=membertypeclass0");
	if("membertypeclass0".equals(membertypeid))
	{
		out.print(" id ="+membertypeid);
	}
	out.print(">全部稿件</a>");

	out.print("<a href=### onclick=f_mt('2','membertypeclass2'); class=membertypeclass2");
	if("membertypeclass2".equals(membertypeid))
	{
		out.print(" id ="+membertypeid);
	}
	out.print(">订报会员来稿</a>");

	out.print("<a href=### onclick=f_mt('3','membertypeclass3'); class=membertypeclass3");
	if("membertypeclass3".equals(membertypeid))
	{
		out.print(" id ="+membertypeid);
	}
	out.print(">理事会来稿</a>");

	/*
	out.print("<a href=### onclick=f_mt('0','membertypeclass0'); class=membertypeclass0");
	if("membertypeclass0".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">全部稿件</a>");
	*/


	out.print("</span>");
	%>
   </div>
<%
	out.println("<span class=cnlistCenclass style='clear:both;display:block;'>");
	out.print("<a href=### onclick=f_s('1','cnlistid1'); class=cnlistclass1");
	if("cnlistid1".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(" >最新来稿</a>");


	out.println("<a href=### onclick=f_s('2','cnlistid2'); class=cnlistclass2");
	if("cnlistid2".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">已发稿</a>");
	out.print("<a href=### onclick=f_s('3','cnlistid3'); class=cnlistclass3");
	if("cnlistid3".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">已退稿</a>");


	out.print("<span id=cnlistCen>目前共有&nbsp;<font color=#000000 size=3>"+count+"</font>&nbsp;篇稿子</span>");

	out.print("</span>");



%>



</div>

<form name="form2" action="?" method="post">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
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
if(n.getType()==0){
  	  out.print("<td id=NodeListsIDfather nowrap>栏目名称</td>");
}
  	  out.print("<td id=NodeListsIDsubject nowrap>主题</td>");
  	out.print("<td id=NodeListsIDmember nowrap='nowrap' >投稿会员</td>");
  	out.print("<td id=NodeListsIDState nowrap='nowrap' >收费状态</td>");
	  out.print("<td id=NodeListsIDissuetime nowrap  >");
	  out.print("<a href=\"javascript:f_order('n.time');\">");
	  out.print(r.getString(teasession._nLanguage,"投稿时间"));

	  if(o.equals("n.time"))
	  {
	    if(aq)
	    out.print("&nbsp;<img src=\"/tea/image/pic_time_1.gif\" >");
	    else
	  	  out.print("&nbsp;<img src=\"/tea/image/pic_time_0.gif\" >");
	  }

	  out.print("</a>");
	  out.print("</td>");


	out.print("<td id=NodeListsIDsource nowrap >处理人员</td>");
	out.print("<td nowrap>处理状态</td>");
	out.print("<td nowrap>操作</td>");
	out.print("</tr>");


Enumeration e = Node.findReport(teasession._strCommunity,sql.toString(),pos,size);



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
    Report robj = Report.find(nodeid);
    Profile pobj = Profile.find(nobj.getCreator()._strR);
    MemberOrder moobj =MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity, nobj.getCreator()._strR));

    int nt=nobj.getType();
    int nc=nt!=1?0:Category.find(nodeid).getCategory();
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; id=trid_"+nodeid+" >");
    out.print("<td  width=1><input name='nodes'   style=cursor:pointer type='checkbox' ntype='"+nt+"' ncategory='"+nc+"' value='"+nodeid+"' /></td>");

    //栏目名称
    if(n.getType()==0){
      out.print("<td>");
        out.print("<a href='/servlet/Node?node="+nobj.getFather()+"' target='_blank'>"+Node.find(nobj.getFather()).getSubject(teasession._nLanguage)+"</a>");
	  out.print("</td>");
    }
	  //主题
      out.print("<td>");
      String s1 = nobj.getSubject(teasession._nLanguage);

      String p=MT.f(nobj.getPicture(teasession._nLanguage))+MT.f(robj.getPicture(teasession._nLanguage));
      if(p.length()>0)
      {
        s1 = s1 + new Image("/tea/image/picture.gif");
      }

      String f = nobj.getFile(teasession._nLanguage);
      if(f != null && f.length() > 2)
      {
        s1 = s1 + new Image("/tea/image/file.gif");
      }
      out.print(s1);
      out.print("</td>");
      //会员
      out.print("<td id=NodeListsIDmember><a href=###  onclick=f_cm('"+nodeid+"');>"+nobj.getCreator()+"</a>");

      out.print("</td>");
      out.print("<td id='NodeListsIDState'>");
      if(moobj.getMembertype()==2)
      {
        boolean fff = false;
        if(moobj.getBecometime()!=null&&!"null".equals(moobj.getBecometime())&&String.valueOf(moobj.getBecometime()).length()>0  )//数字报会员的有效期
        {

        			int d =1;
        			if(!fff){
        				d = Entity.countDays(Entity.sdf.format(new Date()),Entity.sdf.format(moobj.getBecometime()));
        			}

        			if(d>=1){
        				out.println("&nbsp;[<font color=Green>已交费<font>]");

        			}else
        			{
        				out.println("&nbsp;[<font color=red>未交费<font>]");
        			}
        		}else
        		{
        			out.println("&nbsp;[<font color=red>未交费<font>]");
        		}
        }else
        {
        	out.println("&nbsp;[<font color=red>未交费<font>]");
        }

        out.println("</td>");
        //创建时间
      out.print("<td>");
       out.print(Entity.sdf2.format(nobj.getTime()));
      out.print("</td>");

    //处理人员
    out.print("<td id=NodeListsIDsource>"+Entity.getNULL(nobj.getAuditmember())+"</td>");
//处理状态
	out.print("<td>");
	//out.println(nobj.getAudit());

		if(nobj.getAudit()==1)//待审核
		{
			out.print("<font color=red>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==2)//审核通过
		{
			out.print("<font color=#00cc00>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==3)//已经退稿
		{
			if( NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),11)){
				out.print("<font color=#666666><a href=### onclick=f_rejection('"+nodeid+"');>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</a></font>");
			}else
			{
				out.print("<font color=#666666>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
			}
		}
		//out.print("<font color=#666666>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		//out.print("<font color=#00cc00>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
	 out.print("</td>");


         out.print("<td nowrap>");
         if(nobj.getAudit()==1 && NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),8))
         {
           out.print("<a href=### onclick=f_audit('"+nodeid+"');>审核</a>&nbsp;");
           out.print("<a href=### onclick=f_hidden("+nodeid+","+nobj.isHidden()+");>隐藏</a>&nbsp;");
         }
         if(NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),2))
         {
       	   out.print("<a href=### onclick=window.open('/servlet/EditNode?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>编辑</a>&nbsp;");
       	   out.print("<a href='/jsp/type/report/contributors/ContributorsShow.jsp?node="+nodeid+"' target='_blank'>预览</a>&nbsp;");
         }


         if(nobj.getAudit()==1&& NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),11)){
         	out.print("<a href=### onclick=f_rejection('"+nodeid+"');>退稿</a>&nbsp;");
         }

         if( NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),3)){
         	out.print("<a href=### onclick=f_delete("+nodeid+");>删除</a>&nbsp;");
         }
         if(nobj.getAudit()==1 && NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),8))
         {
         	out.print("&nbsp;<a href=### title=禁止用户投稿 onclick=f_prohibition('"+nobj.getCreator()+"');><img src=/tea/image/lock.png></a>");
         }
        // out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('/servlet/EditNode?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>");
       // out.print("<input type=button value=" +r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + nodeid + "&language=" + teasession._nLanguage + "&nexturl='+encodeURIComponent(location.href),'_self');}\">");
      //  out.print("<input type=submit name=Grant value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_gd('"+nodeid+"');>");
        auditing=true;

  }

  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,4)
		  || NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,5)
		  || NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,6)
		  ||NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,7)){
	  out.println("<tr><td  width=1  title=全选><input type='checkbox' onclick='selectAll(form2.nodes,checked)'  style=cursor:pointer /></td>");
	  out.println("<td colspan='6'>");
	  //out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNew")+" onclick=window.open('/jsp/type/report/contributors/Contributors.jsp?adminact=admin&nexturl='+encodeURIComponent(location.href),'_self');>");

	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,4)){
	  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBClone")+"' onclick=f_act('clone'); >");
	  }
	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,5)){
	  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBMove")+"' onclick=f_act('move');>");
	  }
	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,6)){
	  	//out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBDelete")+"' onclick=f_act('delete');>");
		  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBRecommend")+"' onclick=f_act('recommend');>");
	  }
	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,7)){
	 	 out.println("<input id=PointsSet type='button' value='积分设置' onclick=f_act('point');>");
	  }
	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,13)){
		 	 out.println("<input id=PointsSet type='button' value='批量审核' onclick=f_act('hidden_s');>");
	  }
	  if(NodeRole.isRole(teasession._strCommunity,teasession._rv.toString(),teasession._nNode,9)){
		 	 out.println("<input id=PointsSet type='button' value='批量退稿' onclick=f_rejection2();>");
		  }
	 // out.println("<input type='button' value='审核/隐藏'     onclick=f_act('hidden_s');>");
	 // if(auditing)
	 // {//批准拒绝
	  //  out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_act('grant');>");
	  //  out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_act('deny');>");
	  //}
	  out.println("</td></tr>");
  }
  if(count>size)
  {
 	out.print("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos=",pos,count,size)+"</td></tr>");
  }
}
out.print("</table>");
%>

</form>

</body>
</html>
