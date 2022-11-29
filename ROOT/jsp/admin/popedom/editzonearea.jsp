<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
int unitid=Integer.parseInt(request.getParameter("UnitId"));
if(unitid==0)
{%>
<center><h1>请先选择左边的业务处</h1></center>
<%
  return;
}
if(request.getMethod().equals("POST"))
{

  tea.entity.admin.ZoneArea.delete(unitid);
  String toareaList[]=  request.getParameterValues("toareaList");
  if(toareaList!=null)
  for(int index=0;index<toareaList.length;index++)
  {
    tea.entity.admin.ZoneArea.create(unitid,Integer.parseInt(toareaList[index]));
  }

  response.sendRedirect(request.getRequestURI()+"?UnitId="+unitid);
  return ;
}

tea.entity.admin.AdminZone az_obj=tea.entity.admin.AdminZone.find(unitid);
%>




<%!
String path;
private void  tree1(java.io.Writer jw,int nodecode,int step)throws Exception
{
    for(java.util.Enumeration enumeration = tea.entity.admin.Area.findByFather(nodecode); enumeration.hasMoreElements(); )
    {
        int j = ((Integer)enumeration.nextElement()).intValue();
        tea.entity.admin.Area node1 = tea.entity.admin.Area.find(j);
        jw.write("<option value="+j+">");
        for(int loop=1;loop<step;jw.write("│&nbsp;&nbsp;"),loop++);
        if(step>0)jw.write("├─");
        jw.write(node1.getName());
        tree1(jw,j,++step);
        step--;
    }
//    jw.flush();
//    jw.print(sb.toString());
}

%>






<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--#include file="../public.inc"-->
<html>
<head>
<TITLE>用户管理</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="../style.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="../STYLE.CSS" type="text/css">
<link href="../../css/css.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript">
				function CheckForm()
				{
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
			option_text=select2.options(select2.selectedIndex).text;
			option_value=select2.options(select2.selectedIndex).value;

                        for(index=0;index<select1.length;index++)
                        {
                          if(select1.options(index).value==select2.options(select2.selectedIndex).value)
                          {
                            alert('不能添加重复的地区');
                            return false;
                          }
                        }
			found=0;
			/*
			for (i=0; i< select1.options.length; i++)
			{
			alert(select1.options(i).value);
				if(select1.options(i).value==option_value)
				{
				found=1;
				break;
				}
			}
			  */
			if(found==0)
			{
				var my_option = document.createElement("OPTION");
				my_option.text=option_text;
				my_option.value=option_value;


				if(select1.selectedIndex==-1)
				{
				select1.add(my_option);
				new_index=select1.options.length-1;
				}
				else
				{
				new_index=select1.selectedIndex+1;
				select1.add(my_option,new_index);
				}

				select1.selectedIndex=new_index;
				//select2.remove(select2.selectedIndex);
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
<META content="MSHTML 6.00.2600.0" name="GENERATOR">
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
<BODY>
<table class="small" cellSpacing="0" cellPadding="3" width="100%" border="0">
  <TBODY>
    <tr>
      <td >　<img src="../images/huiyuan.jpg" width="33" height="33">&nbsp;&nbsp; 区域管理 （<%=az_obj.getName()%>） </td>
    </tr>
    <tr>
      <td height=6 bgcolor="#CB9966"></td>
    </tr>
  </TBODY>
</TABLE>
<form name="form1"  method="post">
  <table cellSpacing="０" cellPadding="０" width="90%" align="center" border="0">
    <TBODY>
      <tr>
        <%/*
					strquery="select roleid,(select rolename from tabrole where tabrole.roleid=TabUsrRole.roleid) as roleiddes from TabUsrRole where UsrId='" & yhm + "'"
					set rssr=server.CreateObject ("ADODB.Recordset")
					rssr.CursorLocation = 3
					rssr.Open strquery , conn
					strquery="select roleid,rolename from TabRole where roleid not in (select roleid from TabUsrRole where UsrId='" & yhm + "')"
					set rssur=server.CreateObject ("ADODB.Recordset")
					rssur.CursorLocation = 3
					rssur.Open strquery , conn*/

java.util.Enumeration ar_enumer=tea.entity.admin.ZoneArea.findByZone(unitid);
java.util.Enumeration az_enumer=tea.entity.admin.Area.findByCommunity(node.getCommunity()) ;
%>
        <td width="12%">区域:</td>
        <td width="47%"><table cellSpacing="0" borderColorDark="#ffffff" cellPadding="0" align="left" borderColorLight="#666666" border="1">
            <tr align="center">
              <td width="140" valing=middle>选定区域</td>
              <td width="50"  valing=middle>&nbsp;</td>
              <td width="140"  valing=middle>备选区域</td>
            </tr>
            <tr>
              <td width="140" height="182" valing=bottom><select name="toareaList"  size="15" multiple style="border-width:0px; WIDTH: 140px; HEIGHT: 180px"  ondblclick="func_delete(form1.fromareaList,form1.toareaList);" width="100%" >
                  <%
                                                while(ar_enumer.hasMoreElements())
                                                {
                                                  int id=((Integer)ar_enumer.nextElement()).intValue();
                                                  tea.entity.admin.Area a_obj=tea.entity.admin.Area.find(tea.entity.admin.ZoneArea.find(unitid,id).getArea());

                                                  %>
                  <option value="<%=a_obj.getId()%>"><%=a_obj.getName()%></option>
                  <%
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
                  <%--
						while(az_enumer.hasMoreElements()){
                                                  int ar_id=((Integer)az_enumer.nextElement()).intValue();
						%>
                  <option value=<%=ar_id%>><%=tea.entity.admin.AdminZone.find(ar_id).getName()%></option>
                  <%
						/*rssur.MoveNext
						wend*/}
						--%>
                                                <%tree1(out,0,0);%>
                </select>
                <!--script type="">
                                                for(index=0;index<form1.toList.length;index++)
                                                {
                                                  for(i=0;i<form1.fromList.length;i++)
                                                  {
                                                   if( form1.toList[index].value==form1.fromList[i].value)
                                                   {
                                                     form1.fromList.remove(i);
                                                   }
                                                  }
                                                }
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
                                                </script-->
</td>
            </tr>
          </table></td>
      </tr>
      <tr align="center">
        <td colSpan="4" noWrap class="TableControl" valing=middle><hr color="#CB9966" size="2">
          <input class="BigButton" title="添加用户" type="submit" onClick="return CheckForm();" value="添加" name="add">
        </td>
      </tr>
    </TBODY>
  </TABLE>

</FORM>
</BODY>
</html>



