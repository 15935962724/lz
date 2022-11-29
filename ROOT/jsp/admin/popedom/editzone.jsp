<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
int strid=Integer.parseInt(request.getParameter("MenuId"));

if(request.getMethod().equals("POST"))
{
  int sub=Integer.parseInt(request.getParameter("sub"));
  tea.entity.admin.AdminZone af_obj=tea.entity.admin.AdminZone.find(strid);
   String name=request.getParameter("name");
   StringBuffer area_sb=new StringBuffer("/");
   String toareaList[]=request.getParameterValues("toareaList");
   if(toareaList!=null)
   for(int index=0;index<toareaList.length;index++)
   {
     area_sb.append(toareaList[index]+"/");
   }
   int sequence=Integer.parseInt(request.getParameter("sequ"));
   switch(sub)
   {
     case 1://添加兄弟
     tea.entity.admin.AdminZone.create(af_obj.getFather(),sequence,name,node.getCommunity(),area_sb.toString());
     break;
     case 2://添加子
     tea.entity.admin.AdminZone.create(strid,sequence,name,node.getCommunity(),area_sb.toString());
     break;
     case 3://修改
     af_obj.set(af_obj.getFather(),sequence,name,node.getCommunity(),area_sb.toString());
     break;
     case 4://删除
     af_obj.delete();
     strid=af_obj.getFather();
     break;
   }
  response.sendRedirect(request.getRequestURI()+"?MenuId="+strid);
  return;
}

String name=null,area;
int sequ=0;
if(strid!=0)
{
  tea.entity.admin.AdminZone af_obj=tea.entity.admin.AdminZone.find(strid);
  name=af_obj.getName();
  sequ=af_obj.getSequence();
  area=af_obj.getArea();
}else
{
  area=name="";
}
%>

<html>
<head>
<title>DeskTop</title>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">

function sub1()
{
	if((document.fun.name.value=='<%=name%>'))
	{
		alert("不能添加同名业务处！");
                document.fun.name.focus();
		return false;
	}
	else
	{
		fun.action="editzone.jsp?sub=1"
	}
}
function sub2()
{
	if((document.fun.name.value=='<%=name%>'))
	{
		alert("不能添加同名业务处！");
                document.fun.name.focus();
		return false;
	}
	else
	{
		fun.action="editzone.jsp?sub=2"
	}
}
function sub3()
{
	fun.action="editzone.jsp?sub=3"
}
function sub4()
{
  fun.action="editzone.jsp?sub=4";
return (confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'));
}
		</SCRIPT>
                <SCRIPT language="JavaScript">
				function CheckForm()
				{
                                        for (i=0; i< fun.toareaList.options.length; i++)
					{
                                          fun.toareaList[i].selected=true;

					}

				}
			function func_insert(select2,select1)
			{

			if(select2.selectedIndex!=-1)
			{
			var option_text=select2.options[select2.selectedIndex].text;
			var option_value=select2.options[select2.selectedIndex].value;

			found=0;


			if(found==0)
			{
				var my_option = document.createElement("OPTION");
				my_option.text=option_text;
				my_option.value=option_value;



                                  select1.options[select1.options.length]=(my_option);
                                  new_index=select1.options.length-1;

                                select1.selectedIndex=new_index;
                                select2.remove(select2.selectedIndex);
                              }
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body >

<h1>业务处管理
</h1>
	<div id="head6"><img height="6" src="about:blank"></div>
<h2>请选择左侧业务处列表
</h2>
<form id="fun" name="fun" method="post" onsubmit="CheckForm()">

  <table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
                  <tr>

                    <td nowrap class="huititable"><br>
                    当前选中业务处：</td>
                    <td class="huititable"><br>
                      <%=strid%>:<%=name%>
                      <input id="bh" type="hidden" name="MenuId" value="<%=strid%>">
                    </td>

                  </tr>
                  <tr>
                    <td nowrap class="huititable">业务处名称：</td>
                    <td class="huititable">
                      <input id="mc" type="text" name="name" value="<%=name%>"></td>

                  </tr>
                  <tr>
                    <td nowrap class="huititable">业务处顺序号：</td>
                    <td class="huititable">
                      <input  type="text" name="sequ" value="<%=sequ%>">
                    </td>

                  </tr><tr><td nowrap>区域:
                  <td>
				  <table cellspacing="0" bordercolordark="#ffffff" cellpadding="0" align="left" bordercolorlight="#666666" border="1">
            <tr align="center">
              <td width="140" valing=middle>选定区域</td>
              <td width="50"  valing=middle>&nbsp;</td>
              <td width="140"  valing=middle>备选区域</td>
            </tr>
            <tr>
              <td width="140" height="182" valing=bottom><select name="toareaList"  size="15" multiple style="border-width:0px; WIDTH: 140px; HEIGHT: 180px"  ondblclick="func_delete(fun.fromareaList,fun.toareaList);" width="100%" >
                  <%
                                                  java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer( area,"/");
                                                while(tokenizer_obj.hasMoreTokens())
                                                {
                                                  int id=Integer.parseInt((String)tokenizer_obj.nextElement());
                                                  tea.entity.admin.Area az_obj=tea.entity.admin.Area.find(id);
                                                  %>
                  <option value="<%=id%>"><%=az_obj.getName()%></option>
                  <%
                                              }
						%>
              </select></td>
              <td width="50" align="center"  valing=middle><input onClick="func_insert(fun.fromareaList,fun.toareaList);" type="button" value=" ← " id=button1 name=button1>
                  <br>
                  <input onClick="func_delete(fun.fromareaList,fun.toareaList);" type="button" value=" → " id=button2 name=button2>
                  <br>
                  <input onClick="func_up(fun.fromareaList,fun.toareaList);" type="button" value=" ↑ " id=button3 name=button3>
                  <br>
                  <input onClick="func_down(fun.fromareaList,fun.toareaList);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td  valing=middle width="140"><select ondblclick="func_insert(fun.fromareaList,fun.toareaList);" width="100%" style="WIDTH: 140px; HEIGHT: 180px" size="15" name="fromareaList" >
                  <%
                  java.util.Enumeration az_enumer=tea.entity.admin.Area.findByFather(tea.entity.admin.Area.getRootId(node.getCommunity()));
                  while(az_enumer.hasMoreElements())
                  {
                    int ar_id=((Integer)az_enumer.nextElement()).intValue();
                    %>
                  <option value=<%=ar_id%>><%=tea.entity.admin.Area.find(ar_id).getName()%></option>
                  <%
                  java.util.Enumeration az_enumer_son=tea.entity.admin.Area.findByFather(ar_id);
                  while(az_enumer_son.hasMoreElements())
                  {
                    ar_id=((Integer)az_enumer_son.nextElement()).intValue();

                     %>
                  <option value=<%=ar_id%>>├<%=tea.entity.admin.Area.find(ar_id).getName()%></option>
                  <%
                  java.util.Enumeration az_enumer_son_son=tea.entity.admin.Area.findByFather(ar_id);
                  while(az_enumer_son_son.hasMoreElements())
                  {
                    ar_id=((Integer)az_enumer_son_son.nextElement()).intValue();
                  %>
                  <option value=<%=ar_id%>>│&nbsp;├<%=tea.entity.admin.Area.find(ar_id).getName()%></option>
                  <%}}
              }%>
                </select>
                  <script type="">
                  for(index=0;index<fun.toareaList.length;index++)
                  {
                    for(i=0;i<fun.fromareaList.length;i++)
                    {
                      if( fun.toareaList[index].value==fun.fromareaList[i].value)
                      {
                        fun.fromareaList.remove(i);
                      }
                    }
                  }
                  </script>
              </td>
            </tr>
        </table>

  </TABLE>
					<br>
					<div id="head6"><img height="6" src="about:blank"></div>

				    <br>
				    <input id="Submit1" type="submit" onclick="return sub1()" value="增加同级业务处" name="Submit1">
                      <input id="Submit2" type="submit" onclick="return sub2()" value="增加子业务处" name="Submit2">
                      <input id="Submit2" type="submit" onclick="return sub3()" value="修改" name="Submit2">
                      <input id="Submit2" type="submit" onclick="return sub4()" value="删除" name="Submit2">
                      <br>
                      <br>
</form>
<SCRIPT language="JavaScript">
function clickMenu(ID)
{

    targetelement=document.all(ID);
    if (targetelement.style.display=="none")
        targetelement.style.display='';
    else
        targetelement.style.display="none";

    parent.dept_user.location="dept_user.asp?UnitId="+ID;
}
		</SCRIPT>
</body>
</html>



