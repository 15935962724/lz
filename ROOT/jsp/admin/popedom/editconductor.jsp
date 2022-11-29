<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%@page import="tea.entity.admin.*" %>
<%
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
if(request.getMethod().equals("POST"))
{
  String member=request.getParameter("member");
  tea.entity.member.Profile pf_obj=null;
  if(request.getParameter("cre")!=null)//新建后台用户
  {
    if( tea.entity.member.Profile.isExisted(member))
    {
      out.print(new tea.html.Script("alert('用户已经存在.');history.back();"));
      return;
    }
    String pw=request.getParameter("pw");
    String email=request.getParameter("email");
	String sn=request.getServerName()+":"+request.getServerPort();
    pf_obj= tea.entity.member.Profile.create(member,pw,community,email,sn);
  }else
  {
    Conductor aur_obj=Conductor.find(member,community);
    if(request.getParameter("del")!=null)
    {
      aur_obj.delete();//删除
    }else//编辑
    {
      pf_obj=tea.entity.member.Profile.find(member);
      pf_obj.setPassword(request.getParameter("pw"));
      StringBuffer area_sb=new StringBuffer("/");
      String toareaList[]=request.getParameterValues("toareaList");
      if(toareaList!=null)
      for(int index=0;index<toareaList.length;index++)
      {
        area_sb.append(toareaList[index]+"/");
      }
      aur_obj.set(Integer.parseInt(request.getParameter("sex"))!=0,request.getParameter("name"),request.getParameter("address"),area_sb.toString());
    }
  }
  response.sendRedirect(request.getRequestURI()+"?member="+member+"&community="+community+"&node="+teasession._nNode);
  return ;
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--#include file="../public.inc"-->
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function CheckForm()
{
  //alert("SS");
  if(document.form1.member.value=="")
  { alert("用户名不能为空！");
  document.form1.member.focus();
  return (false);
}

if(document.form1.name.value=="")
{ alert("真实姓名不能为空！");
document.form1.name.focus();
return (false);
}

for (i=0; i< form1.toareaList.options.length; i++)
{
  form1.toareaList[i].selected=true;
  //                                          options_value=select1.options(i).value;
  //                                          fld_str+=options_value+",";
}
//alert(fld_str);
//document.forms[0].optionsvalue.value= fld_str;
}
function func_insert(select2,select1)
{
  //select2= eval('document.forms[0].fromList');
  //select1= eval('document.forms[0].toList');
  if(select2.selectedIndex!=-1)
  {
    option_text=select2.options[select2.selectedIndex].text;
    option_value=select2.options[select2.selectedIndex].value;

    option_text

    select1.options[select1.length]=new Option(option_text,option_value);//my_option;


    select1.selectedIndex=select1.length-1;
    select2.options[select2.selectedIndex]=null;
  }

}

function func_delete(select2,select1)
{
  //select2= eval('document.forms[0].fromList');
  //select1= eval('document.forms[0].toList');
  if(select1.selectedIndex!=-1)
  {
    option_text=select1.options(select1.selectedIndex).text;
    option_value=select1.options(select1.selectedIndex).value;
    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;
    select2.add(my_option);

    select1.remove(select1.selectedIndex);
  }
}


function func_up(select2,select1)
{
  //select2= eval('document.forms[0].fromList');
  //select1= eval('document.forms[0].toList');
  if(select1.selectedIndex!=-1 && select1.selectedIndex!=0)
  {
    option_text=select1.options(select1.selectedIndex).text;
    option_value=select1.options(select1.selectedIndex).value;

    var my_option = document.createElement("OPTION");
    my_option.text=option_text;
    my_option.value=option_value;

    new_index=select1.selectedIndex-1;
    select1.remove(select1.selectedIndex);
    select1.add(my_option,new_index);
    select1.selectedIndex=new_index;
    }
  }


  function func_down(select2,select1)
  {
    //select2= eval('document.forms[0].fromList');
    //select1= eval('document.forms[0].toList');
    if(select1.selectedIndex!=-1 && select1.selectedIndex!=(select1.options.length-1))
    {
      option_text=select1.options(select1.selectedIndex).text;
      option_value=select1.options(select1.selectedIndex).value;

      var my_option = document.createElement("OPTION");
      my_option.text=option_text;
      my_option.value=option_value;

      new_index=select1.selectedIndex+1;
      select1.remove(select1.selectedIndex);
      select1.add(my_option,new_index);
      select1.selectedIndex=new_index;
    }
  }

  </SCRIPT>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
    </style>
</head>
<BODY onLoad="document.form1.name.focus();">
<%
String member=request.getParameter("member");
String name=null,pw=null,address=null;
boolean sex=true;
if(member!=null)
{
  tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(member);
  Conductor con=Conductor.find(member,community);
  name=con.getName();
  sex=con.isSex();
  pw=pf_obj.getPassword();
  address=con.getAddress();
}else
{
  address=pw=name="";
}
%>
<h1>添加用户
</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>选择已经存在的会员:
<select name="all_list" onChange="window.location='?member='+value">
  <option value="">---------请选择--------</option>
  <%
  java.util.Enumeration all_member=tea.entity.member.Profile.findByCommunity(community);
  while(all_member.hasMoreElements())
  {
    String member_temp=(String)all_member.nextElement();
    out.print("<option value="+member_temp);
//    if(member_temp.equals(member))
//    {
//      out.print(" selected");
//    }
    out.print(">"+member_temp);
  }
  %>
</select>
</h2>
<form name="form1" method="post">
<input type="hidden" name="community" value="<%=community%>" >
<input type="hidden" name="node" value="<%=teasession._nNode%>" >

<table cellspacing="０" cellpadding="０" border="0" id="tablecenter">
  <tr>
    <td width="16%" nowrap class="huititable" >用户名：</td>
    <td width="25%"  nowrap class="huititable"><%if(member!=null)out.print(member+"<input type=hidden value='"+member+"'  name=member>");else out.print("<input type=text  name=member>");%>
    </td>
    <td width="12%"  nowrap class="huititable">性别：</td>
    <td width="47%"  nowrap class="huititable"><select class="BigSelect" name="sex">
        <option value="1" selected>男</option>
        <option value="0" <%if(!sex)out.print(" selected ");%>>女</option>
      </select>
    </td>
  </tr>
  <tr>
    <td  nowrap class="huititable">真实姓名：</td>
    <td  nowrap class="huititable"><input class="SmallInput" maxlength="10" size="10" name="name" value="<%=getNull(name)%>">
&nbsp; </td>
    <td  nowrap class="huititable">地址：</td>
    <td  nowrap class="huititable"><input type="text" name="address" value="<%=getNull(address)%>"></td>
  </tr>
  <tr>
    <td  nowrap class="huititable">密码：</td>
    <td  nowrap class="huititable"><input class="SmallInput" type="password" maxlength="10" size="10" name="pw" value=<%=pw%>>
&nbsp; </td>
    <td  nowrap class="huititable">　</td>
    <td  nowrap class="huititable">　</td>
  </tr>
  <tr>
    <%/*strquery="select roleid,(select rolename from tabrole where tabrole.roleid=TabUsrRole.roleid) as roleiddes from TabUsrRole where UsrId='" & yhm + "'"
      set rssr=server.CreateObject ("ADODB.Recordset")
      rssr.CursorLocation = 3
      rssr.Open strquery , conn
      strquery="select roleid,rolename from TabRole where roleid not in (select roleid from TabUsrRole where UsrId='" & yhm + "')"
      set rssur=server.CreateObject ("ADODB.Recordset")
      rssur.CursorLocation = 3
      rssur.Open strquery , conn*/

java.util.Enumeration ar_enumer=AdminRole.findByCommunity(community,teasession._nStatus);
java.util.Enumeration az_enumer=AdminZone.findByFather(AdminZone.getRootId(community)) ;

String zone=null;
if(member!=null)
{
  Conductor aur_obj=Conductor.find(member,community);
  zone=aur_obj.getZone();
}

if(zone==null)
{
  zone="";
}					%>
    <td>管辖业务处:</td>
    <td colspan="3"><table cellspacing="0" bordercolordark="#ffffff" cellpadding="0" align="left" bordercolorlight="#666666" border="1">
        <tr align="center">
          <td width="140" valing=middle>选定业务处</td>
          <td width="50"  valing=middle>&nbsp;</td>
          <td width="140"  valing=middle>备选业务处</td>
        </tr>
        <tr>
          <td width="140" height="182" valing=bottom><select name="toareaList"  size="15" multiple style="border-width:0px; WIDTH: 140px; HEIGHT: 180px"  ondblclick="func_delete(form1.fromareaList,form1.toareaList);" width="100%" >
          <%
          //java.util.Enumeration ar_enumer=AdminRole.findByCommunity(node.getCommunity());
          //while not rssr.EOF
          if(member!=null)
          {
            java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer( zone,"/");
            while(tokenizer_obj.hasMoreTokens())
            {
              int id=Integer.parseInt((String)tokenizer_obj.nextElement());
              //                                                  Area az_obj=Area.find(id);
              AdminZone az_obj=AdminZone.find(id);
              %>
              <option value="<%=id%>"><%=az_obj.getName()%></option>
              <%

            }
          }
          %>
          </select></td>
          <td width="50" align="center"  valing=middle><input onClick="func_insert(form1.fromareaList,form1.toareaList);" type="button" value=" ← " id=button1 name=button1>
            <br>
            <input onClick="func_delete(form1.fromareaList,form1.toareaList);" type="button" value=" → " id=button2 name=button2>
            <br>
              <input onClick="func_up(form1.fromareaList,form1.toareaList);" type="button" value=" ↑ " id=button3 name=button3>
              <br>
              <input onClick="func_down(form1.fromareaList,form1.toareaList);" type="button" value=" ↓ " id=button4 name=button4>
          </td>
          <td  valing=middle width="140"><select ondblclick="func_insert(form1.fromareaList,form1.toareaList);" width="100%" style="WIDTH: 140px; HEIGHT: 180px" size="15" name="fromareaList" >
          <%
          while(az_enumer.hasMoreElements())
          {
            int ar_id=((Integer)az_enumer.nextElement()).intValue();
            out.print("<option value="+ar_id+" >"+AdminZone.find(ar_id).getName()+"</option>");

            java.util.Enumeration az2_enumer=AdminZone.findByFather(ar_id);
            while(az2_enumer.hasMoreElements())
            {
              int ar2_id=((Integer)az2_enumer.nextElement()).intValue();
              out.print("<option value="+ar2_id+" >├"+AdminZone.find(ar2_id).getName()+"</option>");
            }

          }%>
          </select>
          <script type="">
          for(index=0;index<form1.toareaList.length;index++)
          {
            for(i=0;i<form1.fromareaList.length;i++)
            {
              if( form1.toareaList[index].value==form1.fromareaList[i].value)
              {
                form1.fromareaList.remove(i);
              }
            }
          }
          </script>
          </td>
        </tr>
    </table></td>
  </tr>
  <tr align="center">
    <td colspan="4" nowrap class="TableControl" valing=middle></td>
  </tr>
</table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>
  <%if(member!=null){%>
  <input class="BigButton" title="添加用户" type="submit" onClick="return CheckForm();" value="修改" name="add">
  <input class="BigButton" title="添加用户" type="submit" onClick="return confirm('确认删除');" value="删除" name="del">
  <%}else{%>
  <input class="BigButton" title="创建用户" type="submit" onClick="return CheckForm();" value="创建" name="cre">
  <%}%>

  <input type="hidden" name="act" value=""/>
</FORM>
<br/>
</BODY>
</html>



