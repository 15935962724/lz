<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.resource.Resource"%><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession"%><%!
public String tab(String s)
{
  StringBuffer sb=new StringBuffer(s);
  for(int i=s.length();i<18;i++)
  sb.append("　");
  return sb.toString();
}%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}


Resource r=new Resource();


Http h=new Http(request);

int count=h.getInt("count",Integer.MAX_VALUE);//最多选择个数

String tmember=request.getParameter("member");
String tunit=request.getParameter("unit");
String tname=request.getParameter("name");
String notnull=request.getParameter("notnull");
String enabled=request.getParameter("enabled");//只有那些人员可供选择


String _sql="";
if(enabled!=null)
  _sql=" AND "+DbAdapter.cite(enabled)+" LIKE '%/'+member+'/%'";


HashMap flen=new HashMap();
int flast=0;
StringBuffer jsu=new StringBuffer("var jsu=new Array(new Array('----------','')");
StringBuffer jsm=new StringBuffer();
Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity," ORDER BY sequence DESC",0,200);
while(e.hasMoreElements())
{
  AdminUnit au=(AdminUnit)e.nextElement();
  int id=au.getId();
  if(au.getFather()==0)id=0;
  int len=0;//当前部门人数
  jsm.append("var jsm"+id+"=new Array('----------'");
  Enumeration e2=AdminUnitSeq.findByCommunity(teasession._strCommunity,id,true);
  while(e2.hasMoreElements())
  {
    String member=(String)e2.nextElement();
    if("mobile".equals(notnull))
    {
      Profile p=Profile.find(member);
      String mobile=p.getMobile();
      if(mobile==null||mobile.length()<1)continue;
    }
    if(enabled!=null&&enabled.indexOf("/"+member+"/")==-1)continue;
    jsm.append(",\""+member+"\"");
    len++;
  }
  jsm.append("); \r\n\r\n");
  //计算人数 含子
  int plen=au.getPrefix().length();
  flen.put(Integer.valueOf(plen),Integer.valueOf(MT.f(flen.get(Integer.valueOf(plen)),0)+len));
  if(flast>plen)len=MT.f(flen.remove(Integer.valueOf(flast)),0);
  flast=plen;
  jsu.append(",new Array(\""+tab(au.getPrefix()+au.getName())+len+"\",\""+id+"\")");
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
  Enumeration e2=Contact.find(id,_sql,0,999);
  while(e2.hasMoreElements())
  {
    Contact c=(Contact)e2.nextElement();
    jscm.append(",\""+c.getMember()+"\"");
  }
  jscm.append("); \r\n\r\n");
}
jscg.append(");");



StringBuffer sql = new StringBuffer();
boolean isSel = false;//是否查询
String upname = request.getParameter("upname");
String showtype = request.getParameter("showtype");
if(upname!=null&&upname.length()>0){
  isSel = true;
  if("1".equals(showtype)){
    sql.append(" AND name like '%"+upname+"%'");//部门
  }else{
    sql.append(" AND member like '%"+upname+"%'");//人员
  }
}

%><html>
<head>
<title>添加收件人</title>
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
var fname=opener.document.<%=tname%>;

function f_submit()
{
  var sid="",sname="";
  var op=form1.sel3.options;
  <%
  if(count==1)out.print("id.value='/';unit.value='/';name.value='';");
  %>
  if(form1.type[0].checked)//默认分类
  {
    var old=form1.show0[0].checked?id.value:unit.value;
    for(var i=0;i<op.length;i++)
    {
      if(old.indexOf('/'+op[i].value+'/')!=-1)continue;//已经存在
      sid=sid+op[i].value+"/";
      sname=sname+op[i].text+"; ";
    }
    if(form1.show0[0].checked)
      id.value=id.value+sid;
    else
      unit.value=unit.value+sid;
    fname.value=fname.value+sname;
  }else//个性化分类
  {
    var old=id.value;
    for(var i=0;i<op.length;i++)
    {
      if(form1.show1[0].checked)
      {
        if(old.indexOf('/'+op[i].value+'/')!=-1)continue;
        sid=sid+op[i].value+"/";
      }else
      {
        //组转会员////
        var me=eval("jscm"+op[i].value);
        for(var j=1;j<me.length;j++)
        {
          if(old.indexOf('/'+me[j]+'/')!=-1)continue;
          sid=sid+me[j]+"/";
        }
      }
      sname=sname+op[i].text+"; ";
    }
    id.value=id.value+sid;
    fname.value=fname.value+sname;
  }
  window.opener=null;
  window.close();
}

function f_load(init)
{
  f_clear(form1.sel3.options);

  if(form1.type[0].checked)//默认分类
  {
    tr0.style.display="";
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
  if(s1.size<1)op[0]=new Option("-------------------","0");
  for(var i=jsu.length-1;i>0;i--)
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
  var o1=s1.options;//部门
  var o2=s2.options;//备选
  f_clear(o2);
  var x=-1,seq=0;
  var si=s1.selectedIndex;
  for(var i=Math.max(si,1);i<o1.length;i++)
  {
    var y=o1[i].text.indexOf("├");
    if(i!=si && x>=y && si>0)//不是子级部门，跳出
      break;
    if(i==si)x=y;
    var me=eval("jsm"+o1[i].value);
    for(var j=1;j<me.length;j++)
    {
      if(f_exists(o2,me[j]))continue;
      o2[o2.length]=new Option(me[j],me[j]);
    }
  }
}

function f_exists(a,b)
{
  for(var x=0;x<a.length;x++)
  {
    if(a[x].value==b)return true;
  }
  return false;
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
    op[0]=null;
}
function f_move_count()
{
  move(form1.sel2,form1.sel3,false);
  var op=form1.sel3.options;
  while(op.length><%=count%>)
    op[0]=null;
}

function paspar()
{
  var upname = document.form1.upname.value;
  var showtype;
  var obj = document.getElementsByName('show0');
  for(i = 0;i < obj.length; i++)
  {
    if(obj[i].checked)showtype = obj[i].value;
  }
  var url = encodeURI('/jsp/user/list/SelMembers2.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.unit&name=form1.name&enabled="<%=enabled%>"&upname='+upname+'&showtype='+showtype);
  window.location.href=url;
}


</script>
</head>
<body <%if(!isSel){%>onload="f_load();"<%}%>>

<form name="form1" onSubmit="f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td></td>
  <td>
    <input name="type" type="radio" value="0" onclick="f_load()" id="t0" checked><label for="t0">默认分类</label>
    <input name="type" type="radio" value="1" onclick="f_load()" id="t1"><label for="t1">个性化分类</label>
    <a href="/jsp/user/list/TeamManage.jsp?community=<%=teasession._strCommunity%>&member=form1.to&unit=form1.tunit&name=form1.name" target="_self" >管理</a>
  </td>
</tr>
<tr id="tr0">
  <td>类型</td>
  <td>
    <input name="show0" type="radio" value="0" id="s00" <%if(!isSel){out.print("onclick=f_load() checked");}else{if("0".equals(showtype))out.print(" checked");}%> ><label for="s00">按人员</label>
    <input name="show0" type="radio" value="1" id="s01" <%if(!isSel){%>onclick="f_load()"<%}else{if("1".equals(showtype))out.print(" checked");}%>><label for="s01">按部门</label>
    　　名称&nbsp;<input type="text" name="upname" value="<%if(upname!=null)out.print(upname);%>" size="15" onkeydown="if(event.keyCode==13)document.getElementById('sun').click();return false;"/>&nbsp;<input id="sun" type="button" value="GO" onclick="paspar();"/>
  </td>
</tr>
<tr id="tr1" style="display:none">
  <td>类型</td>
  <td>
    <input name="show1" type="radio" value="0" onclick="f_load()" id="s10" checked><label for="s10">按人员</label>
    <input name="show1" type="radio" value="1" onclick="f_load()" id="s11"><label for="s11">按组</label>
  </td>
</tr>
<tr id="tr00" <%if(isSel)out.print("style=display:none;");%>><td>部门</td><td><select name="sel1" onchange="f_member(this,form1.sel2);"></select></td></tr>
<tr id="tr11" style="display:none"><td>组</td><td><select name="sel4" onchange="f_cmember(this,form1.sel2);"></select></td></tr>
<tr>
  <td>选择</td>
  <td>
  <table cellpadding="0" cellspacing="0">
  <tr><td>备选</td><td></td><td>已选</td>
  <tr><td>
  <select name="sel2" size="12" multiple style="width:120px " ondblclick="f_move_count()">
  <%
  if(isSel){
    if("1".equals(showtype)){
      Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,sql.toString());
      while(enumer.hasMoreElements())
      {
        AdminUnit obj=(AdminUnit)enumer.nextElement();
        out.print("<option value="+obj.getId()+" >"+obj.getName()+"</option>");
      }
    }else{
      Enumeration enumer1 =tea.entity.member.Profile.findByCommunityMem(teasession._strCommunity,sql.toString(),true);
      while(enumer1.hasMoreElements())
      {
        String member =(String)enumer1.nextElement();
        out.print("<option value="+member+" >"+member+"</option>");
      }
    }
  }
  %>
  </select>
  </td>
  <td>
<!-- <input type="button" value="&gt;&gt;| " onclick="move2(form1.sel2,form1.sel3,false);"><br> -->
<input type="button" value=" &gt;&gt; " onclick="f_move_count()"><br><br>
<input type="button" value=" &lt;&lt; " onclick="move(form1.sel3,form1.sel2,true);"><br>
<!-- <input type="button" value=" |&lt;&lt;" onclick="move2(form1.sel3,form1.sel2,true);">-->
  </td>
  <td>
  <select name="sel3" size="12" multiple style="width:120px" ondblclick="move(form1.sel3,form1.sel2,true);">
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

