<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@ page import="tea.resource.*"%>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String member=request.getParameter("member");
if(request.getMethod().equals("POST"))
{
  if(Profile.isExisted(member))
  {
    AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,member);
    StringBuffer sb=new StringBuffer();
    boolean selectall=request.getParameter("selectall")!=null;
    if(selectall)
    {
      sb.append("/0/");
      java.util.Enumeration ar_enumer=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
      while(ar_enumer.hasMoreElements())
      {
        int ar_id=((Integer)ar_enumer.nextElement()).intValue();
        sb.append(ar_id).append("/");
      }
    }else
    {
        sb.append(request.getParameter("brand"));
    }
    aur_obj.setBrand(sb.toString());
  }
  response.sendRedirect(request.getRequestURI()+"?community="+teasession._strCommunity);
  return;
}
Community communitys=Community.find(teasession._strCommunity);
Resource r=new Resource();
r.add("/tea/resource/deptuser");

%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT language="JavaScript">
function CheckForm()
{
  if(!submitText(document.form1.member,"<%=r.getString(teasession._nLanguage, "InvalidName")%>"))
  {
    return (false);
  }
  var v="/";
  var op=document.form1.to.options;
  for (var i=0; i<op.length; i++)
  {
    v=v+op[i].value+"/";
  }
  form1.brand.value=v;
}

function f_click(t)
{
  form1.to.disabled=t;
  form1.from.disabled=t;
  document.getElementById('selectbrand').disabled=t;
}

function func_up(select2,select1)
{
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
</head>
<BODY id="bodynone" onLoad="try{ document.form1.member.focus(); }catch(e){} f_click(form1.selectall.checked);">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<h1><%=r.getString(teasession._nLanguage, "UserManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage, "AddUser")%></h2>

<FORM name="form1" method="post">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="brand" value="/">
  <TABLE cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <TR>
      <TD noWrap class="huititable" ><%=r.getString(teasession._nLanguage, "ID")%>：</TD>
      <TD  noWrap class="huititable"><%
          if(member!=null)
          {
            out.print("　<input value="+member+" disabled ><input type=hidden name=member value="+member+">");
          }else
          {
            out.print("　<input name=member >");
          %>
	       <select onChange="form1.member.value=this.options[this.selectedIndex].value;form1.member.focus();">
		          <option value="" selected>-----------</option>
                          <%
                          java.util.Enumeration enumer=tea.entity.member.Profile.findByCommunity(teasession._strCommunity);
                          while(enumer.hasMoreElements())
                          {
                            String value=enumer.nextElement().toString();
                            out.println("<option VALUE="+value+">"+value+"</option>");
                          }
                         %>
		        	  </select><%}%>
&nbsp; </TD>
    </TR>
    <TR>

      <TD class="huititable" noWrap ><%=r.getString(teasession._nLanguage, "Brand")%>：
        <input  type="hidden" size="1000" name="optionsvalue"></TD>
      <TD colspan="3"  align="left" noWrap class="huititable">
        <table cellSpacing="0" cellPadding="0" border="0" id="selectbrand" >
          <tr align="center">
            <td width="140" ><%=r.getString(teasession._nLanguage, "SelectBrand")%></td>
            <td width="50" >&nbsp;</td>
            <td width="140" ><%=r.getString(teasession._nLanguage, "StandbyBrand")%></td>
          </tr>
          <tr>
            <td width="140" height="182" >
              <select name="to" size="12" multiple style="WIDTH:140px;" ondblclick="move(form1.to,form1.from,true);" >
                <%
                String brand=null;
                if(member!=null)
                {
                  AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,member);
                  brand=aur_obj.getBrand();
                }
                if(member!=null&&brand!=null)
                {
                  java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(brand,"/");
                  while(tokenizer_obj.hasMoreTokens())
                  {
                    int id=Integer.parseInt((String)tokenizer_obj.nextElement());
                    Brand b=Brand.find(id);
                    if(b.isExists())
                    out.print("<option value="+id+" >"+b.getName(teasession._nLanguage));
                  }
                }
                %>
              </select></td>
            <td width="50" align="center"  >
			<input onClick="move(form1.from,form1.to,true);" type="button" value=" ← ">
              <br>
              <input onClick="move(form1.to,form1.from,true);" type="button" value=" → " >
              <br>
              <input onClick="func_up(form1.from,form1.to);" type="button" value=" ↑ ">
              <br>
              <input onClick="func_down(form1.from,form1.to);" type="button" value=" ↓ ">
              <br>
            </td>
            <td   width="140">
              <select name="from" multiple ondblclick="move(form1.from,form1.to,true);" style="WIDTH:140px;" size="12" >
                <%
                java.util.Enumeration ar_enumer=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                while(ar_enumer.hasMoreElements())
                {
                  int ar_id=((Integer)ar_enumer.nextElement()).intValue();
                  Brand b=Brand.find(ar_id);
                  if(b.isExists())
                  out.println("<option value="+ar_id+" >"+b.getName());
                }
                %>
              </select>
              <script type="">
              for(var i=0;i<form1.to.length;i++)
              {
                for(var j=0;j<form1.from.length;j++)
                {
                  if(form1.to[i].value==form1.from[j].value)
                  {
                    form1.from.remove(j);
                    break;
                  }
                }
              }
              </script>
            </td>
          </tr>
        </table>
      	<input name="selectall" type="checkbox" onclick="f_click(this.checked);" <%if(brand!=null&&brand.startsWith("/0/"))out.print(" CHECKED ");%> >全选
      </TD>
    </TR>
    <tr align="center">
      <TD colSpan="6" noWrap class="TableControl" ><INPUT class="BigButton" title="" type="submit" onClick="return CheckForm();" value="<%=r.getString(teasession._nLanguage,"Add")%>" name="add">
      </TD>
    </TR>
  </TABLE>
  <h2><%=r.getString(teasession._nLanguage,"UserManage")%> </h2>
  <input type="hidden" name="act" value=""/>
  <TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter" >
    <TR id="tableonetr">
      <TD ><%=r.getString(teasession._nLanguage, "ID")%></TD>
      <TD ><%=r.getString(teasession._nLanguage, "Name")%></TD>
      <TD ><%=r.getString(teasession._nLanguage, "Brand")%></TD>
      <TD ><%=r.getString(teasession._nLanguage, "operation")%></TD>
    </TR>
    <%
    java.util.Enumeration pfbyu_enumer=AdminUsrRole.findByBrand(teasession._strCommunity,0);
    for(int iCount=1;pfbyu_enumer.hasMoreElements();iCount++)
    {
      String member_temp=(String)pfbyu_enumer.nextElement();
      Profile pf_obj_temp=Profile.find(member_temp);
      AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,member_temp);
      brand=aur_obj.getBrand();
          %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <TD ><%=member_temp%></TD>
      <TD ><%=pf_obj_temp.getFirstName(teasession._nLanguage)%>　</TD>
      <TD ><%=brand.startsWith("/0/")?"全部":brand.split("/").length-1+"个"%></TD>
      <TD ><input type="button" onclick="window.open('<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&member=<%=member_temp%>','_self');" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>">
        <input type="button" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){form1.member.value='<%=member_temp%>';while(document.form1.to.options.length>0)document.form1.to[0]=null; form1.selectall.selected=true; form1.submit();}" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>">
    </TR>
    <%}%>
  </TABLE>
</FORM>
 <div id="head6"><img height="6" src="about:blank"></div>
 </div>
<br/>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</BODY>
</html>

