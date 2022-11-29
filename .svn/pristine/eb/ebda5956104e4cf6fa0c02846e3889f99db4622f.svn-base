<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
Http h=new Http(request,response);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
h.member=teasession._rv._strV;

Resource r=new Resource("/tea/resource/NetDisk");

int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
Flowbusiness fb=Flowbusiness.find(flowbusiness);
int filecenter=fb.getFileCenter();
int flow=fb.getFlow();
Flow f=Flow.find(flow);
Flowprocess fp=Flowprocess.find(flow,fb.getStep());


if("POST".equals(request.getMethod()))
{
  Flowview.find(flowbusiness,fp.getFlowprocess(),h.member).setState(2);


  String role=request.getParameter("role");
  String unit=request.getParameter("unit");
  String member=request.getParameter("member");
  member="/"+member.replaceAll("; ","/");
  filecenter=Integer.parseInt(request.getParameter("filecenter"));
  fb.archiving(teasession._rv._strV,filecenter,h);
  filecenter=fb.getFileCenter();
  FileCenterSafety.create(teasession._strCommunity,filecenter,0,1,role,unit,member);
  fb.stop(0);

  //自动启动总公司收文流程
  if(flow==1)//是发文
  {
    Date time = new Date();
    int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
    if(corg>0&&AdminUnitOrg.find(teasession._strCommunity,1)==corg)//是 分子公司发文流程
    {
      //flow:2 收文
      int newfb = Flowbusiness.create(teasession._strCommunity,0,2,flowbusiness,time,corg,teasession._rv._strR,f.getName(teasession._nLanguage) + ":" + Flowbusiness.sdf2.format(time));
      //收文的Word文件
      //String doc = DynamicValue.find( -flowbusiness,teasession._nLanguage,35).getValue();
      DynamicValue.find( -newfb,teasession._nLanguage,53).set(fb.tape2);
      //发文的附件
      Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,37).findMulti("",0,1000);
      DynamicValue dv54 = DynamicValue.find( -newfb,teasession._nLanguage,54);
      while(e.hasMoreElements())
      {
        DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
        dv54.setMulti(0,member,m.getValue());
      }
    }
  }

  //一般签报归档后要返回给拟稿人一个提示
  Profile p=Profile.find(fb.getCreator());
  String str="您好"+p.getName(teasession._nLanguage)+"：<br/><br/>"+
  "您拟稿的"+fb.name+"，于"+MT.f(new Date())+"已归档。<br/>";
  //Email.create(teasession._strCommunity,null,p.getEmail(),fb.name+" 归档提示",str,true);
  Message.create(teasession._strCommunity,5,teasession._rv.toString(),fb.getCreator(),"/","/",0,null,teasession._nLanguage,fb.name+" 归档提示",str);
  //System.out.println("归档:"+fb.getCreator());
  out.print("<script>alert('归档成功，流程已结束!!!'); window.close(); dialogArguments.document.location=dialogArguments.document.all('nexturl').value;</script>");
  return;
}

if(filecenter==0)
{
  filecenter=f.getFilecenter();
}else
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("已经归档,不能重复归档!!!","UTF-8"));
  return;
}

FileCenter fc=FileCenter.find(filecenter);

StringBuilder member=new StringBuilder("; ");
StringBuilder role=new StringBuilder();
StringBuilder unit=new StringBuilder();
Enumeration efc=FileCenterSafety.findByFileCenter(filecenter," AND fcs.filecenter="+filecenter+" AND purview=1");
while(efc.hasMoreElements())
{
  FileCenterSafety s=FileCenterSafety.find(((Integer)efc.nextElement()).intValue());
  member.append(s.getMember().substring(1));
  role.append(s.getRole().substring(1));
  unit.append(s.getUnit().substring(1));
}
//归档默认为: 起草人,起草人所属部门经理,文件管理员 可以查看
String creator=fb.getCreator();
int ar_unit=AdminUsrRole.find(teasession._strCommunity,creator).getUnit();
Enumeration ear=AdminUsrRole.find(teasession._strCommunity," AND( (unit="+ar_unit+" AND classes!='/') OR member IN("+DbAdapter.cite(creator)+","+DbAdapter.cite(fb.getMainTransactor())+"))",0,100);
while(ear.hasMoreElements())
{
  String t=(String)ear.nextElement()+"; ";
  if(member.indexOf("; "+t)==-1)member.append(t);
}
//中途经办的人
Enumeration efv=Flowview.find(flowbusiness,"");
while(efv.hasMoreElements())
{
  Flowview fv=Flowview.find(((Integer)efv.nextElement()).intValue());
  String t=fv.getTransactor()+"; ";
  if(member.indexOf("; "+t)==-1)member.append(t);
}


ArrayList al=new ArrayList();

%><html>
<head>
<title>文件归档</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>

function f_load()
{
  form1.role1.focus();
}
function f_submit(form1)
{
  var v="/";
  var op=form1.role1.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.role.value=v;

  v="/";
  op=form1.unit1.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.unit.value=v;
}
</script>
</head>
<body onLoad="f_load()">

<h1><%=r.getString(teasession._nLanguage, "归档后文件的权限")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?" method="POST" onsubmit="return f_submit(this);">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="act" value="safety">
<input type="hidden" name="role" value="/">
<input type="hidden" name="unit" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>角色</td>
<td>
<table>
  <tr>
      <td>已选</td>
      <td></td>
      <td>备选</td>
  <tr><td>
    <select name="role1" size="8" style="width:150px" multiple ondblclick="move(form1.role1,form1.role2,true)">
    <%
    String rs[]=role.toString().split("/");
    for(int i=1;i<rs.length;i++)
    {
      if(al.indexOf(rs[i])==-1)
      {
        AdminRole ar=AdminRole.find(Integer.parseInt(rs[i]));
        if(ar.isExists())
        {
          out.print("<option value="+rs[i]+">"+ar.getName());
        }
        al.add(rs[i]);
      }
    }
    %>
    </select></td>
    <td><input type="button" value=" &lt;&lt; " onclick="move(form1.role2,form1.role1,true)"><br><input type="button" value=" &gt;&gt; " onclick="move(form1.role1,form1.role2,true)"></td>
      <td><select name="role2" size="8" style="width:150px"  multiple ondblclick="move(form1.role2,form1.role1,true)">
      <%
      Enumeration e=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        if(role.indexOf("/"+id+"/")==-1)
        {
          AdminRole ar=AdminRole.find(id);
          out.print("<option value="+id+">"+ar.getName());
        }
      }
      %>
</select>
</table>
</td>
</tr>
<tr>
<td>部门</td>
<td>
<table>
<tr><td>
  <select name="unit1" size="8" style="width:150px" multiple ondblclick="move(form1.unit1,form1.unit2,true)">
  <%
  al.clear();
  String us[]=unit.toString().split("/");
  for(int i=1;i<us.length;i++)
  {
    if(al.indexOf(us[i])==-1)
    {
      AdminUnit au=AdminUnit.find(Integer.parseInt(us[i]));
      if(au.isExists())
      {
        out.print("<option value="+us[i]+">"+au.getName());
      }
      al.add(us[i]);
    }
  }
  %>
  </select></td>
<td><input type="button" value=" &lt;&lt; " onclick="move(form1.unit2,form1.unit1,false)"><br><input type="button" value=" &gt;&gt; " onclick="move(form1.unit1,form1.unit2,true)"></td>
<td><select name="unit2" size="8" style="width:150px" multiple ondblclick="move(form1.unit2,form1.unit1,false)">
<%
e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit ar=(AdminUnit)e.nextElement();
  int id=ar.getId();
  //if(unit.indexOf("/"+id+"/")==-1)
  {
    out.print("<option value="+id+">"+ar.getPrefix()+ar.getName());
  }
}
%>
  </select>
  </table>
</td>
</tr>
<tr>
  <td>会员</td>
  <td><input name="member" type="text" size="40" value="<%=member.substring(2)%>" readonly>
    <input type="button" value="添加" onclick="window.open('/jsp/user/list/SelMembers.jsp?input=form1.member','_blank','width=600,height=500,scrollbars=1');">
    <input type="button" value="清空" onclick="form1.member.value='';">
  </td>
</tr>
<tr>
<td>文件归档位置:</td>
<td>
<%
out.print("<select name='filecenter'>");
e=FileCenter.findByFather(teasession._strCommunity,fc.getFather(),null,false);
while(e.hasMoreElements())
{
  int fid=((Integer)e.nextElement()).intValue();
  fc=FileCenter.find(fid);
  out.print("<option value="+fid);
  if(filecenter==fid)
  out.print(" selected");
  out.print(">"+fc.getSubject());
}
out.print("</select>");
%>
</td>
</tr>
</table>
<input type="submit" value="提交">
<input type="button" value="关闭" onClick="window.close();">
</form>

</body>
</html>
