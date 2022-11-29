<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.entity.admin.ig.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String member;
String _strRole=request.getParameter("role");
int role=0;
if(_strRole!=null)
	role=Integer.parseInt(_strRole);
if(role>0)
{
	if(!teasession._rv.isOrganizer(teasession._strCommunity))
	{
		response.sendError(403);
		return;
	}else
	{
		member=Igtab.DEFAULT_MEMBER+role;
	}
}else
{
	member=teasession._rv.toString();
}

int igtab=0;
String _strIgtab=request.getParameter("igtab");
if(_strIgtab!=null)
{
  igtab=Integer.parseInt(_strIgtab);
}

Community community=Community.find(teasession._strCommunity);

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js"></script>
<script>var _IG_time_epoch = (new Date()).getTime();</script>
<script src="/tea/image/ig/ig.js"></script>
<script>
<!--
<%
//如果不是管理员设置角色的默认桌面
if(role<1)
{
	out.print("if(top.location == self.location)top.location=\"/jsp/admin/ig/?community="+teasession._strCommunity+"&node="+teasession._nNode+"\";");
}
%>
var domain = document.location.hostname;
var google_pos = domain.indexOf('.google.');
if (google_pos > -1)
{
  domain = domain.substring(google_pos);
  document.cookie = "TZ=" + (new Date()).getTimezoneOffset()+ ';path=/;domain=' + domain;
}
var igdnd=document.cookie;
if (igdnd.indexOf("IGDND=1")==-1)
{
  if(igdnd.length>0)
  {
    //window.location.reload();
  }
} else
{
  document.cookie="IGDND=0; expires=Thu, 01-Jan-1970 00:00:00 GMT";
}
_et="ruVvFYJA";
_source="";
_uli=true;
_pnlo=false;
_mpnlo=false;
_pl=false;
_mod=true;
_pid="";
_old_html = false;
_cbp=true;
_upc();
var _pl_data = {};
// -->
</script>
<script>
<!--
function save_chkbox_value(hidden_elem_name, checked)
{
  var hidden_elem = document.getElementById(hidden_elem_name);
  hidden_elem.value = checked ? "1" : "0";
}
function RemoteModule(spec_url, id, render_inline, base_iframe_url,caching_disabled)
{
  this.spec_url = spec_url;
  this.id = id;
  this.render_inline = render_inline;
  this.base_iframe_url = base_iframe_url;
  this.caching_disabled = caching_disabled;
  this.old_width = 0;
  this.wants_scaling = false;
  this.is_inlined = function()
  {
    return this.base_iframe_url == "";
};
};
var remote_modules = [];
_IG_RegisterOnloadHandler(function()
{
  for (var i=0;i<remote_modules.length;i++)
  {
    var rm=remote_modules[i];
    var el=_gel("remote_iframe_"+rm.id);
    if(el)
    {
      el.src=rm.base_iframe_url;
    }
  }
});
function ifpc_resizeIframe(iframe_id, height)
{
  var el = document.getElementById(iframe_id);
  if (el)
  {
    el.style.height = height + "px";
  }
}
_IFPC.registerService('resize_iframe', ifpc_resizeIframe);
function ifpc_get_module_id_(iframe_id)
{
  return(iframe_id.split("_")[2]);
}
function ifpc_set_title(iframe_id, title, url, specified_module_id)
{
  title = _hesc(title);
  var module_id = ifpc_get_module_id_(iframe_id);
  if (specified_module_id && typeof(specified_module_id) != "undefined"&& specified_module_id != "undefined")
  {
    module_id = specified_module_id;
  } else
  if (iframe_id != undefined && iframe_id != "" && iframe_id != "undefined")
  {
    module_id = ifpc_get_module_id_(iframe_id);
  } else
  {
    throw new Error("Inline modules must specify their __MODULE_ID__ when using _IG_SetTitle");
  }
  _gel("m_" + module_id + "_title").innerHTML = title;
  if (url && typeof(url) != "undefined"&& url != "undefined")
  {
    var is_valid_url = /https?\:\/\//;
    if (!url.match(is_valid_url))
    {
      url = "http://" + url;
    }
    _gel("m_" + module_id + "_url").href = url;
  } else
  {
    _gel("m_" + module_id + "_url").removeAttribute("href");
  }
}
_IFPC.registerService('set_title', ifpc_set_title);
function _IG_SetTitle(title, url, specified_module_id)
{
  ifpc_set_title("", title, url, specified_module_id);
}
function ifpc_setPref(iframe_id, var_args)
{
  var module_id = ifpc_get_module_id_(iframe_id);
  var prefs = new _IG_Prefs(module_id);
  var keyValues = new Array();
  for (var n = 1; n < arguments.length; n += 2)
  {
    keyValues.push(arguments[n], arguments[n + 1]);
  }
  prefs.set.apply(prefs, keyValues);
}
_IFPC.registerService('set_pref', ifpc_setPref);
// -->
</script>
<%--
<style>
<!--
.modbox .el {display:;}
.modbox .csl, .modbox .es {display:none;}
.modbox_e .el {display:none;}
.modbox_e .csl, .modbox .es {display:;}
.dm {position:relative;width:1px;height:1px;}
.fres {width:expression(_gel("ffresults").offsetWidth+"px");overflow:hidden;}
.panelo {}
.panelc {}
.mod {}
.unmod {}
form {display:inline;}
.c {clear:both;}
.fbox {margin-top:1px;margin-right:6px;display:block;overflow:hidden;width:12px;height:12px;background-image: url('/tea/image/ig/max_dark_blue.gif');background-repeat: no-repeat;cursor:hand;cursor:pointer;}
.fmaxbox {background-image:url('/tea/image/ig/max_dark_blue.gif');}
.fminbox {background-image:url('/tea/image/ig/min_dark_blue.gif');}
a.fmaxbox:hover {background-image:url('/tea/image/ig/max_dark_blue_highlight.gif');}
a.fminbox:hover {background-image:url('/tea/image/ig/min_dark_blue_highlight.gif');}
.f_tbl {font-size:12px;margin-right:2px;margin-left:2px;padding-top:4px;padding-bottom:4px;}
.fr_tbl {margin-right:2px;margin-left:2px;padding-top:4px;padding-bottom:4px;}
.fb {font-size:12px;padding:2px;padding-top:4px;border: 1px solid #d1d3d4;border-top:none;overflow:auto;}
.sftl {border: 1px solid #d1d3d4;border-bottom:none;}
.uftl {border:1px solid white;border-bottom:none;}

-->
</style>
--%>
<link rel="stylesheet" type="text/css" href="/tea/image/ig/ig.css"/>
<%--
<style>
<!--
.dialog .top1, .dialog .top2, .dialog .bot1, .dialog .bot2 {height:0px;margin:0;font-size:1px;background:#CBDCED;}
* html .dialog .bot2 {margin: 0 2px;}
* html .dialog .bot1 {margin: 0 3px;}
.dialog .titlebar {color:black;font-weight:bold;background:#E2EEFA;min-height:14px;padding: 5px 12px 5px 12px;border-top:4px solid #CBDCED;border-left:4px solid #CBDCED;border-right:4px solid #CBDCED;font-size:100%;}
* html .dialog .titlebar {height:14px;}
.dialog .body {background:#FFFFFF;padding: 36px 40px 3px 40px;border-left:4px solid #CBDCED;border-right:4px solid #CBDCED;border-bottom:4px solid #CBDCED;}
.dialog .outerborder {border:1px solid #3A5774;}
.buttontable {width:50%;}
.dialog .buttontable td {text-align:center;padding:24px 2px 10px 2px;}
-->
</style>
--%>
</head>
<body>
<script>_IG_DD_init();</script>
<div id="doc3">
  <div id="nhdrwrap">
    <div id="nhdrwrapinner">
      <div id="nhdrwrapsizer">
        <script>
        <!--
        function qs(el)
        {
          if (window.RegExp && window.encodeURIComponent)
          {
            var qe=encodeURIComponent(document.f.q.value);
            if (el.href.indexOf("q=")!=-1)
            {
              el.href=el.href.replace(new RegExp("q=[^&$]*"),"q="+qe);
            } else
            {
              el.href+="&q="+qe;
            }
          }
          return 1;
        }
        if (document.all)
        {
          _IG_AddDOMEventHandler(window, "focus",function()
          {
            _gel("q").focus();
            _IG_RemoveDOMEventHandler(window, "focus", arguments.callee);
          });
        }else
        {
          //_gel("q").focus();
        }
        // -->
        </script>


        <div id="undel_msg" class="msg" style="display:none;">
          <div id="undel_box" class="msg_box"><span id="undel_title"></span> 部分已删除。<a href="javascript:void(_undel())">取消</a> | <a href="#" class="delbox_u" onClick="_gel('undel_msg').style.display='none';return false;">Close</a></div>
        </div>
        <script>_IG_time.stop("parse_header");</script>
        <div id="new_user_demo" align="center"></div>
    </div>



    <div id="tabs">
      <ul>
        <%
       out.print("<DIV id=label>");
       int igt_i=0;
       Enumeration e=Igtab.findByMember(member);
       for(;e.hasMoreElements();igt_i++)
       {
         int id=((Integer)e.nextElement()).intValue();
         Igtab obj=Igtab.find(id);
         //out.println("<li class=\"tab spacer\">&nbsp;</li>");
         if(igtab==0&&igt_i==0)
         {
        	 igtab=id;
         }
         if(id!=igtab)
         {
           out.println("");
           out.println("<li id=\"tab"+id+"_view\" class=\"tab unselectedtab\" style=\"display:block\" onclick=\"_dlsetp('ct="+id+"&role="+role+"')\"><span class=tableft></span><span class=tabcenter id=\"tab"+id+"_view_title\">"+obj.getName()+"</span><span class=tabright></span></li>");
         }else
         {
           out.println("<script>_igtab="+igtab+";</script>");
           out.println("<li id=\"tab"+id+"_edit\" class=\"tab edittab selectedtab\" style=\"display:none\" onclick=\"_gel('tab"+id+"_title').focus();\" onmouseover=\"_disable_onblur=true;\" onmouseout=\"_disable_onblur=false;\">");
           out.println("<script>_disable_onblur = false;</script>");
           out.println("<form id=\"tab"+id+"_rename_form\" name=\"tab"+id+"_rename_form\" onsubmit=\"return _renameTab();\">");
           out.println("<span>");
           out.println("<input id=\"tab"+id+"_title\" name=\"tab_title\" value=\""+obj.getName()+"\" onblur=\"_disable_onblur ? void(0) : _renameTab();\">");
           out.println("</span>");
           out.println("<a href=\"#\" onclick=\"if(confirm('您确定要删除“TAB_NAME”标签及其所有内容吗？'.replace('TAB_NAME', _editedTabName()))) {_dlsetp('dt="+id+"&role="+role+"');}return false;\">删除</a>");
           out.println("</form>");
           out.println("</li>");
           out.println("<li id=\"tab"+id+"_view\" class=\"tab selectedtab\" style=\"display:block\" onclick=\"_editTab('"+id+"')\" title=\"点击进行重命名或删除操作。\"><span class=tableft></span><span class=tabcenter id=\"tab"+id+"_view_title\">"+obj.getName()+"</span><span class=tabright></span></li>");
           out.println("");
         }
       }
       out.print("</DIV><div id=tiaojia>");
       if(igt_i<6)
       {
         out.print("<li class=\"tab addtab\"><a href=\"#\" onClick=\"_renameTab();_dlsetp('at=&role="+role+"');return false;\" onMouseOver=\"_disable_onblur=true;\" onMouseOut=\"_disable_onblur=false;\">添加标签</a></li>");
       }
       %>
       <li class="tab" id="addstuff"><a href="/jsp/admin/ig/SelectAdminFunction.jsp?community=<%=teasession._strCommunity%>&igtab=<%=igtab%>&role=<%=role%>">添加内容 &raquo;</a> </li>
       </div>
      </ul>
    </div>
  </div>
</div>




<div id="modules">
  <div class="yui-b">
    <div class="yui-gb" id="t_1">
     <div class="yui-u first" id="c_1">


<%
Igtab obj=Igtab.find(igtab);
String mp=obj.getMp();//布局
String mps[]=mp.split(":");
String mz=obj.getMz();//最小化
String mc=obj.getMc();//显示数量;
for(int c=1;c<4;c++)
{
if(c>1)
out.println("<div class=\"yui-u\" id=\"c_"+c+"\">");

for(int i=0;i<mps.length;i++)
{
  //if(popedom.indexOf("/"+id+"/")!=-1)
  if(mps[i].length()>0&&!mps[i].startsWith("_")&&Integer.parseInt(mps[i].substring(mps[i].length()-1))==c)
  {
    int igd=Integer.parseInt(mps[i].substring(0,mps[i].indexOf("_")));
    AdminFunction af_obj = AdminFunction.find(igd);
    if(af_obj.isExists())//是否存在
    {
      out.print("<div id=m_"+igd+" class=modbox>");
      out.print("<h2 class=modtitle>");
      out.print("<a class=delbox href=\"###\" onClick=\" return _del('"+igd+"','"+igtab+"','url=http://biz.163.com/special/b/00021HSF/bizbignews.xml'); \"></a>");

      boolean min=(mz!=null&&mz.indexOf(":"+igd+"_1")!=-1);

      int showcount=3;
      if(mc!=null)
      {
        java.util.regex.Matcher m=java.util.regex.Pattern.compile(":"+igd+"_(\\d+)").matcher(mc);
        if(m.find())
        {
          showcount=Integer.parseInt(m.group(1));
        }
      }
      %>
      <a class="<%=min?"maxbox":"minbox"%>" id="m_<%=igd%>_zippy" href="###" onClick="this.blur();return _zm('<%=igd%>', '<%=igtab%>');return false;"></a>
      <a class=el href="###" onClick="return _edit('<%=igd%>',null);"></a>
      <a class=csl href="###" onClick="return _cedit('<%=igd%>');"></a>
      <a class=help href="###" onClick="window.open('/jsp/site/HelpFrame.jsp?community=<%=teasession._strCommunity%>&type=0&id=<%=igd%>','','width=500,height=550,resizable=1,scrollbars=auto');"></a>
      <div id="m_<%=igd%>_h">
        <a class="mtlink" id="m_<%=igd%>_url" ><span id="m_<%=igd%>_title" class="modtitle_text"><%=af_obj.getName(teasession._nLanguage)%></span></a></div>
              <div class="meditbox">
                <form id="m_<%=igd%>_form" onSubmit="return _fsetp(this,'<%=igd%>',<%=igtab%>);">
                  <div style="white-space:nowrap">显示
                    <select onChange="_uhc('<%=igd%>','val',this.value)">
                    <%
                    for(int j=1;j<10;j++)
                    {
                      out.print("<option value="+j);
                      if(j==showcount)
                      out.print(" selected ");
                      out.print(">"+j);
                    }
                    %>
                    </select>项
                    <input class=submitbtn type=submit value="保存">
                    <input type=button value="取消" onClick="return _cedit('<%=igd%>')">
                  </div>
                </form>
              </div>


              <%
              out.print("</h2>");
              out.print("<div id=\"m_"+igd+"_b\" class=\"modboxin\" style=\"display:"+(min?"none":"block")+"\">");

              String urlig=af_obj.getUrlig();
              if(urlig==null||urlig.length()<1)
            	  urlig="/jsp/admin/ig/IgTrees.jsp";

              if(!teasession._strCommunity.equals(af_obj.getCommunity()))
              {
            		java.util.Enumeration e5=DNS.findByCommunity(af_obj.getCommunity(),teasession._nStatus);
            		if(e5.hasMoreElements())
            		{
            			String param=(urlig.lastIndexOf("?")==-1?"?":"&")+"igd="+igd+"&showcount="+showcount+"&community="+af_obj.getCommunity()+"&jsessionid="+session.getId();
            			String prefix="http://"+(String)e5.nextElement();
            			out.println("　　<img src=/tea/image/public/load.gif>load...");
            			out.println("<script>sendx('/servlet/Ajax?act=sendx&url="+java.net.URLEncoder.encode(prefix+urlig+param,"UTF-8")+"',function aa(html){document.getElementById('m_"+igd+"_b').innerHTML=html;});</script>");
            		}else
            		{
            			out.print("域名不存在");
            		}
              }else
              {
            	  %>
					<jsp:include page="<%=urlig%>">
	            	  <jsp:param name="igd" value="<%=igd%>"/>
	            	  <jsp:param name="showcount" value="<%=showcount%>"/>
	            	  <jsp:param name="community" value="<%=teasession._strCommunity%>"/>
	            	</jsp:include>
            	  <%
              }
           %>
            </div>
		<%
		out.print("</div>");
		}
	}
}

out.println("<div class=\"dm\"></div></div>");
}

%>





      </div>
    </div>
  </div>
</div>

<script>
<!--

_table=_gel("t_1");
_tabs=_gel("tabs");
_pl=true;
_IG_time.stop("upcstart");
_upc();
_IG_time.stop("upcend");
_IG_start_refresh_cycle(1200,600);
_IG_time.stop("domloadstart");
_IG_AddEventHandler("domload", function()
{
  _IG_time.stop("domloadend");
});

_IG_TriggerDelayedEvent("domload");
_IG_AddEventHandler("load", function()
{
  _IG_time.stop("load");
  if (parseInt(Math.random() * 100.0) == 1)
  {
    var url = "dls=" + _IG_time.get("domloadstart") +"&dle=" + _IG_time.get("domloadend") +"&upcs=" + _IG_time.get("upcstart") +"&upce=" + _IG_time.get("upcend") +"&load=" + _IG_time.get("load");
    _sendx("/ig/nop?timing=" + _esc(url), null, false);
  }
});

// -->
</script>

<%=community.getJspAfter(teasession._nLanguage) %>

<%--
<div id="dialog_box" style="position:absolute;z-index:1; display:none; left:-1000px; height:1px; width:1px;">
<img width="90%" height="20px" src="/tea/image/ig/header_gradient_image.gif" ><a class=iframe_close href="javascript:iframe_close();"></a>
<br>
<iframe id=iframe width=100% height=100% frameborder="0" ></iframe>
</div>
<script>
function iframe_open(url)
{
var iframe=document.getElementById('iframe');
iframe.src=url+"&ig=ON&nexturl="+encodeURIComponent("javascript:parent.iframe_close();");

var dialog_box=document.getElementById('dialog_box');
dialog_box.style.display='';
}

function iframe_close()
{
var dialog_box=document.getElementById('dialog_box');
dialog_box.style.display='none';
dialog_box.style.left=-1000;
}
mveaablediv();
</script>
--%>

</body>
</html>


