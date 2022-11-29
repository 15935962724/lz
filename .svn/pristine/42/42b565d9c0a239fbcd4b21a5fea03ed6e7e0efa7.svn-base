<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>

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
  String str ="操作成功";
  if("clone".equals(act))//复制
  {

    for(int i=0;i<ns.length;i++)
    {

    	if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),4,Integer.parseInt(ns[i])))//复制
    	{
      		ok+= Node.clone(Integer.parseInt(ns[i]),father,true,true,options,teasession._rv,null);

    	}else
    	{
    		str="系统只能复制有权限的记录!";
    		continue;
    	}

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
	    	 if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),5,Integer.parseInt(ns[i])))//移动
	    	 {
			      node=Node.find(Integer.parseInt(ns[i]));

			      ok+= node.move(father,options==2);
	    	  }else{
    			str="系统只能移动有权限的记录!";
    			continue;
	    	 }
	    }



  }else if("delete".equals(act))
  {

    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);

      if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),3,Integer.parseInt(ns[i])))//移动
 	 {
       //n.delete(teasession._nLanguage);
      // Node.delete(nid, n.getType(),teasession._nLanguage);
		  n.setAudit(4);
		  Report.find(nid).setEditmember(teasession._rv._strR,teasession._nLanguage);
          n.setHidden(true);
         ok++;
 	 }else{
			str="系统只能删除有权限的记录!";
			continue;
    	 }

    }

  }else if("hidden_s".equals(act))//审核
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),8,Integer.parseInt(ns[i])))//审核
  	  {
      //int pur=n.isCreator(teasession._rv)?3:AccessMember.find(nid,teasession._rv._strV).getPurview();
     // if(pur>2)
      //{
        if(n.isHidden())//审核通过
        {
         	 n.setHidden(false);
          	 n.setAudit(2);
			Report.find(n._nNode).setEditmember(teasession._rv._strR, teasession._nLanguage);

        }else//隐藏新闻
        {
          n.setHidden(true);
          n.setAudit(1);
		  Report.find(n._nNode).setEditmember(teasession._rv._strR, teasession._nLanguage);

        }
        ok++;
     // }else
      //{
        //err++;
     //}
  	 }else{
			str="系统只能审核有权限的记录!";
			continue;
    	 }
    }
  }
  else if("point".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
    	  if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),7,Integer.parseInt(ns[i])))//积分设置
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
    	  	}else{
    			str="系统只能设置有权限的记录!";
    			continue;
        	 }

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
    	  if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,Node.find(Integer.parseInt(ns[i])).getFather(),6,Integer.parseInt(ns[i])))//积分设置
 	  	 {
     		   Listed.create(Integer.parseInt(ns[i]),Integer.parseInt(ls[j]),null);
 	  	}else{
			str="系统只能手动列举有权限的记录!";
			continue;
    	 }
      }
    }
  }//act
  StringBuilder sb=new StringBuilder();
  if(err==0)
  {
    //sb.append(r.getString(teasession._nLanguage,"UpdateSuccessful"));
    sb.append(str);
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

String member=teasession._rv._strV;


int tatype=type;


CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,tatype);

String fs[]=cal.getField().split("/");

boolean me="true".equals(request.getParameter("me"));

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?node=").append(teasession._nNode);

sql.append(" AND n.type=39 ");



//查询  审核处理会员
String desktop = teasession.getParameter("desktop");

String auditmember = teasession.getParameter("auditmember");
if(auditmember!=null && auditmember.length()>0)
{
	if("desktop".equals(desktop))
	{
		sql.append(" and (n.audits=2 or n.audits=3 ) ");
		par.append("&desktop=").append(desktop);
	}

	sql.append(" AND  n.auditmember = ").append(DbAdapter.cite(auditmember));
	par.append("&auditmember=").append(URLEncoder.encode(auditmember, "UTF-8"));


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
//创建位置
int source = 0;
if(teasession.getParameter("source")!=null && teasession.getParameter("source").length()>0)
{
	source = Integer.parseInt(teasession.getParameter("source"));
}
boolean fa = true;

//创建时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0&&!"null".equals(time_c))
{
  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c));
  par.append("&time_c=").append(time_c);
  fa = false;
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0&&!"null".equals(time_d))
{
  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d));
  par.append("&time_d=").append(time_d);
  fa = false;
}

//审核状态
int audits=-1;
if(teasession.getParameter("audits")!=null && teasession.getParameter("audits").length()>0)
{
	audits = Integer.parseInt(teasession.getParameter("audits"));
}

if(audits>0)
{

		sql.append(" and n.audits = ").append(audits);


}
par.append("&audits=").append(audits);
if(source>0)
{
	sql.append(" and n.source = ").append(source);
	par.append("&source=").append(source);
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


int pos=0,size=30;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

//如果是是审核才显示这个
if(fa)
{
	String nodecountsql = NodeRole.getRole3(teasession._strCommunity,teasession._rv.toString(), 8,sql.toString());
	if(nodecountsql!=null)
	{
		sql.append("and (");
		sql.append(nodecountsql);
		sql.append(")");

	}
	sql.append(" AND r.cbutors=0  AND  n.audits!=4  and  n.audits!=0 ");
}
int count=Node.countReport(teasession._strCommunity,sql.toString());


String o=request.getParameter("o");
if(o==null)
{
		o="r.issuetime";

}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
par.append("&o=").append(o).append("&aq=").append(aq);

boolean asc="true".equals(teasession.getParameter("asc"));



//下拉菜单////
int fsize=0;
StringBuffer fsb=new StringBuffer();


String url=tatype==0?"/jsp/general/EditNode.jsp":tatype<1024?"/jsp/type/"+Node.NODE_TYPE[39].toLowerCase()+"/Edit"+Node.NODE_TYPE[39]+".jsp":"/jsp/type/dynamicvalue/EditDynamicValue.jsp";

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
    var rs=window.showModalDialog('/jsp/general/AdminSelNode.jsp?info='+encodeURIComponent(act=='clone'?'复制到':'移动到'),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
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
	if(confirm('您确定要审核记录吗？'))
	{
			 sendx("/servlet/EditContributors?node="+igd+"&act=audit&nexturl="+form2.nexturl.value,
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
	/*
	form2.act.value="audit";
	form2.node.value=igd;
	form2.nexturl.value=location.pathname+location.search;
	form2.action="/servlet/EditContributors";
	form2.submit();
*/
}
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

function f_rejection(igd)
{
	 var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:550px;dialogHeight:180px;';
	  var url = '/jsp/type/report/contributors/Rejection.jsp?nid='+igd+'&community='+form1.community.value;
	  var rs = window.showModalDialog(url,self,y);

	  if(rs==1)
	  {
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
<h1><%if(n.getSubject(teasession._nLanguage)!=null&&n.getSubject(teasession._nLanguage).length()>0)
{
	out.print(n.getSubject(teasession._nLanguage));
}else
{
	out.print("今日上传文章");
}
%>
<%

if(type==-1)
{
  out.print(n.getAncestor(teasession._nLanguage,"_blank"));
  out.print("<style type='text/css'>#NodeListsIDfather{display:none}</style>");
}

%>
</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="me" value="<%=me%>">
<input type="hidden" name="time_c" value="<%=time_c%>">
<input type="hidden" name="time_d" value="<%=time_d%>">

<input type="hidden" name="asc" value="<%=asc%>"/>

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">

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
  	<td nowrap align="right">审核状态 </td>
  	<td valign="middle">
  	 <select name="audits">
  	 <option value="-1">-状态-</option>
  	 	<%
  	 		for(int i=1;i<Node.AUDIT_TYPE.length;i++)
  	 		{
  	 			out.print("<option value="+i);
  	 			if(audits==i)out.print(" selected ");
  	 			out.print(">"+Node.AUDIT_TYPE[i]);
  	 			out.print("</option>");
  	 		}
  	 	%>
  	 </select>
    </td>
    <td nowrap align="right">审核管理员：</td>
  <td><input type="text" name="auditmember" value="<%=Node.getNULL(auditmember) %>"/></td>
   </tr>
   <tr>

      <td align="center" colspan="10"><input type="submit" value="查询"/></td>
</tr>


</table>
</form>

<h2><%=r.getString(teasession._nLanguage, "列表")%>(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;条数据&nbsp;)</h2>

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
out.print("<td>栏目</td>");
	 out.print("<td>主题</td>");
	  out.print("<td id=NodeListsID1 nowrap='nowrap' >");
	  out.print("<a href=\"javascript:f_order('r.issuetime');\">");
	  out.print(r.getString(teasession._nLanguage,"发生时间"));
	  if(o.equals("r.issuetime"))
	  {
	    if(aq)
	    out.print("&nbsp;<img src=\"/tea/image/pic_time_1.gif\" >");
	    else
	  	  out.print("&nbsp;<img src=\"/tea/image/pic_time_0.gif\" >");
	  }

	  out.print("</a>");
	  out.print("</td>");




out.print("<td id=NodeListsIDmember nowrap='nowrap' >创建会员</td>");
out.print("<td id=NodeListsIDsource nowrap='nowrap' >创建位置</td>");
out.print("<td id=NodeListsIDzt>状态</td>");
out.print("<td id=NodeListsIDcz>操作</td>");
out.print("</tr>");
//out.println(sql.toString());
Enumeration e = Node.findReport(teasession._strCommunity,sql.toString(),pos,size);
if(!e.hasMoreElements())
{
  out.println("<tr><td colspan=30 align=center>暂无记录</td></tr>");
}else
{
	AdminUsrRole arobj = AdminUsrRole.find(n.getCommunity(),teasession._rv._strR);
  for(int x=pos+1;e.hasMoreElements();x++)
  {


    int nodeid=((Integer)e.nextElement()).intValue();

    if(AdminRole.isEx2(arobj.getRole(),nodeid)){


    Node nobj=Node.find(nodeid);
    AccessMember amobj=AccessMember.find(nodeid,member);

    int nt=nobj.getType();
    int nc=nt!=1?0:Category.find(nodeid).getCategory();
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; id=trid_"+nodeid+" >");
    out.print("<td  width=1><input name='nodes' id='nodes'   style=cursor:pointer type='checkbox' ntype='"+nt+"' ncategory='"+nc+"' value='"+nodeid+"' /></td>");
    out.print("<td>"+Node.find(nobj.getFather()).getSubject(teasession._nLanguage)+"</td>");

    for(int i=1;i<fs.length;i++)
    {
      out.print("<td  id=NodeListsID"+fs[i]+">&nbsp;");
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
      }

    }
    //会员
    out.print("<td id=NodeListsIDmember>"+nobj.getCreator()+"</td>");
    //创建位置
    out.print("<td id=NodeListsIDsource>"+Node.SOURCE_TYPE[nobj.getSource()]+"</td>");

  //处理状态
	out.print("<td nowrap>");

		if(nobj.getAudit()==1)//待审核
		{
			out.print("<font color=red>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==2)//审核通过
		{
			out.print("<font color=#00cc00>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
		}else if(nobj.getAudit()==3)//已经退稿
		{
			if( NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,teasession._nNode,11,nodeid)){
				out.print("<font color=#666666><a href=### onclick=f_rejection('"+nodeid+"');>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</a></font>");
			}else
			{
				out.print("<font color=#666666>"+Node.AUDIT_TYPE[nobj.getAudit()]+"</font>");
			}
		}else if(nobj.getAudit()==4)
		{
			out.print("<font color=#00cc00>已发布</font>");
		}

	    out.print("</td>");


       out.print("<td nowrap>");

      Node nobj2  =   Node.find(nodeid);

      //预览

      	out.print("<a href=### onclick=window.open('/jsp/type/report/contributors/ContributorsShow.jsp?node="+nodeid+"','_blank');>预览</a>&nbsp;");

      //审核

	//out.println(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),8,nodeid));
       if(nobj.getAudit()==1&&NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),8,nodeid)){
      	  out.print("<a href=### onclick=f_audit('"+nodeid+"');>审核</a>&nbsp;");
       }
      //编辑
      if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),2,nodeid)){
	       if(nobj2.getType()==0||nobj2.getType()==1)
	       {
	    	  out.print("<a href=### onclick=window.open('/jsp/general/EditNode.jsp?node="+nodeid+"&EditNode=ON&nexturl='+encodeURIComponent(location.href),'_self');>编辑</a>&nbsp;");

	       }else{//具体指新闻
	    	   out.print("<a href=### onclick=window.open('/servlet/EditNode?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>编辑</a>&nbsp;");
	          //out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('/servlet/EditNode?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>");
	       }
      }
      //退稿

      if(nobj.getAudit()==1&& NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),11,nodeid)){
       	out.print("<a href=### onclick=f_rejection('"+nodeid+"');>退稿</a>&nbsp;");
       }

	//删除
	  if(NodeRole.isRole3(teasession._strCommunity,teasession._rv._strR,nobj.getFather(),2,nodeid)){


		  if(nobj2.getType()==0||nobj2.getType()==1)
	       {
			  out.print("<a href=### onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "确定要删除这个记录吗？") + "')){window.open('/servlet/DeleteNode?node=" + nodeid + "&language=" + teasession._nLanguage + "&nexturl='+encodeURIComponent(location.href),'_self');}\">删除</a>");

	       }else{//具体指新闻
	    	   out.print("<a href=###  onclick=f_delete('"+nodeid+"');>删除</a>&nbsp;");
	       }
	  }



	}


  }

  }

  out.println("<tr><td  width=1  title=全选><input type='checkbox' onclick='selectAll(form2.nodes,checked)'  style=cursor:pointer /></td>");
  out.println("<td colspan='20'>");


//复制

  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBClone")+"' onclick=f_act('clone'); >");


  //移动

  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBMove")+"' onclick=f_act('move');>");

  //删除

  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBDelete")+"' onclick=f_act('delete');>");

  //推荐

  	out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBRecommend")+"' onclick=f_act('recommend');>");

  //积分设置

  	out.println("<input id=PointsSet type='button' value='积分设置' onclick=f_act('point');>");

  //审核

 // 	out.println("<input type='button' value='审核/隐藏'     onclick=f_act('hidden_s');>");


  out.println("</td></tr>");
  if(count>size)
  {
 	out.print("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos=",pos,count,size)+"</td></tr>");
  }

out.print("</table>");
%>

</form>

</body>
</html>
