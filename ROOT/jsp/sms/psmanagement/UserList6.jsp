<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
 return;
}

int groupid=0;
if( request.getParameter("groupid")!=null)
{
  groupid=Integer.parseInt(request.getParameter("groupid"));
}
         //   intRowCount=tea.entity.node.SMSPhoneBook.countByGroup(groupid);

Resource r=new Resource("/tea/resource/Group");

String name=request.getParameter("index");
if(name==null)
name="form1.number";

String field=request.getParameter("field");

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"SelectPersonnel")%></h1>
<div id="head6"><img height="6" src="about:blank" ></div>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
   <td><a href="javascript:fclickall();" ><%=r.getString(teasession._nLanguage,"SelectAll")%></A><td>
   </tr>
   <tr id="tableonetr">
   <td><%=r.getString(teasession._nLanguage,"Name")%></td>
   <td>
   <%
   if(field==null||field.length()<1)
   {
     out.print(r.getString(teasession._nLanguage,"Mobile"));
   }else
   if("email".equals(field)||"member".equals(field))
   {
     out.print("E-Mail");
   }
   %>
   </td>
   </tr>
    <%
    StringBuffer sb=new StringBuffer();
    java.util.Enumeration enumer=tea.entity.node.SMSPhoneBook.findByGroup(groupid);
    while(enumer.hasMoreElements())
    {
      tea.entity.node.SMSPhoneBook smspb=tea.entity.node.SMSPhoneBook.find(((Integer)enumer.nextElement()).intValue());
      tea.entity.member.Profile p = tea.entity.member.Profile.find(smspb.getMemberx());
      if(groupid!=0||(smspb.getPhonenumber().equals(teasession._rv._strV)&&teasession._strCommunity.equals(smspb.getCommunity())))
      {
        String value=null,value2=null;
        if(field==null||field.length()<1)
        {
          if(smspb.getMobile().length()>=11)
          sb.append(smspb.getMobile()).append(";");
          value2=value=smspb.getMobile();
        }else
        if("email".equals(field))
        {
          sb.append(smspb.getEmail()).append(";");
          value2=value=smspb.getEmail();
        }else
        if("member".equals(field))
        {
          sb.append(smspb.getMemberx()+"/"+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)).append(";");
          value=smspb.getMemberx();
          value2=smspb.getEmail();
        }
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td  align=center nowrap><a href="javascript:fclick('<%=smspb.getMobile()+"/"+ p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%>');" ><%=smspb.getName()%></A></td>
          <td  align=center><a href="javascript:fclick('<%=value+"/"+ p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%>');" ><%=value2%></a>&nbsp;</td>
        </tr>
        <%}
      }

      String a[] = sb.toString().split(";");
      String b =";";
      String bb =";";


        for(int i =0;i<a.length;i++)
        {

            String aa[] =  a[i].split("/");
            for(int j =1;j<aa.length;j++)
            {

              b = b+aa[0]+";";
              bb =bb+aa[1]+";";
            }

          }
	%>
  </table>

<div id="head6"><img height="6" src="about:blank"></div>
<br>







<script type="">
var parent_window = window.dialogArguments;
function fclick(theDate)
{
   parent_window.<%=name%>.value=theDate;
   window.close();
}
function fclickall()
{

     parent_window.form1.to.value = '<%=b%>'
   parent_window.<%=name%>.value='<%=bb%>';
   window.close();
}
</script>

