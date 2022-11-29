<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();


StringBuffer jsu=new StringBuffer("var jsu=new Array(new Array('----------','')");
StringBuffer jsm=new StringBuffer();

Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit au=(AdminUnit)e.nextElement();
  int id=au.getId();
  if(au.isExists())
  {
    if(au.getFather()==0)id=0;
    jsu.append(",new Array(\""+au.getPrefix()+au.getName()+"\",\""+id+"\")");

    //me.append("group=document.createElement('OPTGROUP'); group.label=\""+au.getPrefix()+au.getName()+"\"; sel.appendChild(group);");
    jsm.append("var jsm"+id+"=new Array('----------'");
    Enumeration e2=AdminUnitSeq.findByCommunity(teasession._strCommunity,id,true);
    while(e2.hasMoreElements())
    {
      String member=(String)e2.nextElement();
      jsm.append(",\""+member+"\"");
    }
    jsm.append("); \r\n\r\n");
  }
}
jsu.append(");");

/////////////////我的组/////
StringBuffer jscg=new StringBuffer("var jscg=new Array(new Array('-----我的所有组-----','0')");
StringBuffer jscm=new StringBuffer();
e=CGroup.find(teasession._rv._strV,"",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  CGroup cg=CGroup.find(id);
  jscg.append(",new Array(\""+cg.getName(teasession._nLanguage)+"\",\""+id+"\")");

  jscm.append("var jscm"+id+"=new Array('----------'");
  Enumeration e2=Contact.find(id,"",0,Integer.MAX_VALUE);
  while(e2.hasMoreElements())
  {
    Contact c=(Contact)e2.nextElement();
    jscm.append(",\""+c.getMember()+"\"");
  }
  jscm.append("); \r\n\r\n");
}
jscg.append(");");

String tmember=request.getParameter("member");
String tunit=request.getParameter("unit");
String tname=request.getParameter("name");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
<%=jsu.toString()%>
<%=jsm.toString()%>
<%=jscg.toString()%>
<%=jscm.toString()%>


var id=opener.document.<%=tmember%>;
var unit=opener.document.<%=tunit%>;
var name=opener.document.<%=tname%>;
function f_submit()
{
  var sid="",sname="";
  var op=form1.sel3.options;
  if(form1.type[0].checked)//默认分类
  {
    for(var i=0;i<op.length;i++)
    {
      sid=sid+op[i].value+"/";
      sname=sname+op[i].text+"; ";
    }
    if(form1.show0[0].checked)
    {
      id.value=id.value+sid;
    }else
    {
      unit.value=unit.value+sid;
    }
    name.value=name.value+sname.replace(/├/g,"").replace(/　/g,"");
  }else//个性化分类
  {
    for(var i=0;i<op.length;i++)
    {
      if(form1.show1[0].checked)
      {
        sid=sid+op[i].value+"/";
      }else
      {
        //组转会员////
        var me=eval("jscm"+op[i].value);
        for(var j=1;j<me.length;j++)
        {
          sid=sid+me[j]+"/";
        }
      }
      sname=sname+op[i].text+"; ";
    }
    id.value=id.value+sid;
    name.value=name.value+sname;
  }
  window.close();
}

function f_load(init)
{
  f_clear(form1.sel3.options);

  if(form1.type[0].checked)//默认分类
  {
    tr0.style.display="none";
    tr1.style.display="none";
    tr00.style.display="";
    tr11.style.display="none";

    if(form1.show0[0].checked)
    {
      f_unit(form1.sel1);
      f_member(form1.sel1,form1.sel2);
      tr00.style.display="";
    }else
    {
      f_unit(form1.sel2);
      tr00.style.display="none";
    }
  }else//个性化分类
  {
    tr0.style.display="none";
    tr1.style.display="";
    tr00.style.display="none";
    tr11.style.display="";

    if(form1.show1[0].checked)
    {
      f_cgroup(form1.sel4,true);
      f_cmember(form1.sel4,form1.sel2);
      tr11.style.display="";
    }else
    {
      f_cgroup(form1.sel2,false);
      tr11.style.display="none";
    }
  }
}

//加载部门///
function f_unit(s1)
{
  var op=s1.options;
  f_clear(op);
  for(var i=1;i<jsu.length;i++)
  {
    op[op.length]=new Option(jsu[i][0],jsu[i][1]);
  }
}

//加载组///
function f_cgroup(s1,bool)
{
  var op=s1.options;
  f_clear(op);
  for(var i=bool?0:1;i<jscg.length;i++)
  {
    op[op.length]=new Option(jscg[i][0],jscg[i][1]);
  }
}

//部门-加载会员
function f_member(s1,s2)
{
  var o1=s1.options;
  var o2=s2.options;
  f_clear(o2);
  var x=-1;
  var si=s1.selectedIndex;
  for(var i=si;i<o1.length;i++)
  {
    var y=o1[i].text.indexOf("├");
    if(i!=si && x>=y)
    {
      break;
    }
    if(i==si)
    {
      x=y;
    }
    var me=eval("jsm"+o1[i].value);
    for(var j=1;j<me.length;j++)
    {
      o2[o2.length]=new Option(me[j],me[j]);
    }
  }
}
//组-加载会员
function f_cmember(s1,s2)
{
  var o1=s1.options;
  var o2=s2.options;
  f_clear(o2);
  if(s1.value=="0")
  {
    for(var i=1;i<o1.length;i++)
    {
      var me=eval("jscm"+o1[i].value);
      for(var j=1;j<me.length;j++)
      {
        o2[o2.length]=new Option(me[j],me[j]);
      }
    }
  }else
  {
    var me=eval("jscm"+s1.value);
    for(var j=1;j<me.length;j++)
    {
      o2[o2.length]=new Option(me[j],me[j]);
    }
  }
}

function f_clear(op)
{
  while(op.length>0)
  {
    op[0]=null;
  }
}
function f_sel(sel)
{
  var op=sel.options;
  for(var i=0;i<op.length;i++)
  {
    op[i].selected=true;
  }
}

</script>
</head>
<body onload="f_load();">


<form name="form1" onSubmit="f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr style="display:none">
  <td></td>
  <td>
    <input name="type" type="radio" value="0" onclick="f_load()" checked>默认分类
    <input name="type" type="radio" value="1" onclick="f_load()">个性化分类
    <a href="/jsp/message/CGroups.jsp?community=<%=teasession._strCommunity%>" target="_blank" >管理</a>
  </td>
</tr>
<tr id="tr0" style="display:none">
  <td>类型</td>
  <td>
    <input name="show0" type="radio" value="0" onclick="f_load()" checked>按人员
    <input name="show0" type="radio" value="1" onclick="f_load()">按部门
  </td>
</tr>
<tr id="tr1" style="display:none">
  <td>类型</td>
  <td>
    <input name="show1" type="radio" value="0" onclick="f_load()" checked>按人员
    <input name="show1" type="radio" value="1" onclick="f_load()">按组
  </td>
</tr>
<tr id="tr00"><td>部门</td><td><select name="sel1" onchange="f_member(this,form1.sel2);"></select></td></tr>
<tr id="tr11" style="display:none"><td>组</td><td><select name="sel4" onchange="f_cmember(this,form1.sel2);"></select></td></tr>
<tr>
  <td>选择</td>
  <td>
  <table>
  <tr><td>
  <select name="sel2" size="12" multiple style="width:150px " ondblclick="move(form1.sel2,form1.sel3,false);">
  </select>
  </td>
  <td>
<input type="button" value="&gt;&gt;| " onclick="move2(form1.sel2,form1.sel3,false);"><br>
<input type="button" value=" &gt;&gt; " onclick="move(form1.sel2,form1.sel3,false);"><br><br>
<input type="button" value=" &lt;&lt; " onclick="move(form1.sel3,form1.sel2,true);"><br>
<input type="button" value=" |&lt;&lt;" onclick="move2(form1.sel3,form1.sel2,true);">
  </td>
  <td>
  <select name="sel3" size="12" multiple style="width:150px " ondblclick="move(form1.sel3,form1.sel2,true);">
  </select>
   </td></tr>
  </table>
  </td>
</tr>
</table>

<input type="submit" value="确定" onclick=""/>
<input type="button" value="关闭" onclick="window.close();"/>

</form>

</body>
</html>
<!--
参数说明:
type
0:通迅录人员
1:内部人员(可以进后台的)

field:
没有:手机号
email:邮箱
member:会员ID
-->

