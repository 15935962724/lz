<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.cfw.*"%>

<%

TeaSession teasession=new TeaSession(request);

response.setHeader("Content-Disposition", "attachment; filename=exp.doc");

int mrid = 0;
if(teasession.getParameter("mrid")!=null && teasession.getParameter("mrid").length()>0)
{
	mrid = Integer.parseInt(teasession.getParameter("mrid"));	
}

MemberRegister mrobj = MemberRegister.find(mrid);

 
%>
<html>
<head>
<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/"/>

<title>中国书画艺术沙龙会员登记表</title>
</head>
<body bgcolor="#ffffff">
<h1>中国书画艺术沙龙会员登记表</h1>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" width="854">
    <tr>
	      <td colspan="2" class="td">姓　　名/Name:<%if(mrobj.getNames()!=null)out.print(mrobj.getNames()); %></td>
    </tr>
     <tr>
	      <td class="td">性　　别/Gender:
	      	<%if(mrobj.getGender()==1)out.println(" 男 "); %>
	      	<%if(mrobj.getGender()==2)out.println(" 女 "); %>
	 
	      </td> 
	      <td class="td02">出生日期/Birth date:<%if(mrobj.getBirthdate()!=null)out.print(mrobj.getBirthdateToString()); %>
        </td>
    </tr> 
     
      <tr>
	      <td class="td">职　　业/Occupation:<%if(mrobj.getOccupation()!=null)out.print(mrobj.getOccupation()); %></td>
	      <td class="td">所属机构/Conporation:<%if(mrobj.getConporation()!=null)out.print(mrobj.getConporation()); %></td>
    </tr>
      <tr>
	      <td class="td">移动电话/Mobile No:<%if(mrobj.getMobile()!=null)out.print(mrobj.getMobile()); %></td>
	      <td class="td">固定电话/Tel No:<%if(mrobj.getTel()!=null)out.print(mrobj.getTel()); %></td>
    </tr>
      <tr>
	      <td class="td">电子邮箱/E-mail:<%if(mrobj.getEmail()!=null)out.print(mrobj.getEmail()); %></td>
	      <td class="td">传　　真/Fax:<%if(mrobj.getFax()!=null)out.print(mrobj.getFax()); %></td>
    </tr>
      <tr>
	      <td colspan="2" class="td01">邮寄地址/Mailing address:<%if(mrobj.getAddress()!=null)out.print(mrobj.getAddress()); %></td>
    </tr>
      <tr>
	      <td colspan="2" class="td03">邮编/Postal code:<%if(mrobj.getPostalcode()!=null)out.print(mrobj.getPostalcode()); %></td>
    </tr>
      <tr>
	      <td  colspan="2" class="td04">喜爱的艺术家/Favorite artists:<%if(mrobj.getFavorite()!=null)out.print(mrobj.getFavorite()); %></td>
	 
    </tr>
     <tr>
	      <td colspan="2" class="td05">
           <table width="100%"><tr><td colspan="2">您最期望中国书画艺术沙龙举办什么样的活动?(请打"√")</td></tr>
         <tr><td colspan="2">Which kind of Art Salon activity will interest you the most?</td></tr>
         
    <% 

   
    	for(int i=0;i<MemberRegister.ACTIVITY_TYPE.length;i++)
    	{
    		if(i%2==0)
    		{
    			out.print("<tr>");
    			
    		}
    		out.print("<td>");
    		
    		if(mrobj.getActivity()!=null && mrobj.getActivity().indexOf("/"+i+"/")!=-1)
    		{
    			out.print(" √ ");
    		}
    
    		out.print("&nbsp;"+MemberRegister.ACTIVITY_TYPE[i]);
    		
    		out.print("</td>");
    		if(i%2==1)
    		{
    			out.print("</tr>");
    			
    		}
    		
    	}
    %>
    </table>
    </td></tr>
      <tr>
	      <td class="td06">会员签名/Signature menbers:<%if(mrobj.getMembersignature()!=null)out.print(mrobj.getMembersignature()); %></td>
	      <td class="td02">日期/Date:<%if(mrobj.getSignatureToString()!=null)out.print(mrobj.getSignatureToString()); %></td>
    </tr>
    </table> 
      <div class="ArtsSalon">以下由艺术沙龙秘书处填写/The following fill in the Secretariat by the Arts Salon::
 <table border="0" cellpadding="0" cellspacing="0"  id="tablecenter02" width="854">
     <tr>
	      <td class="td01">会员标准：&nbsp;<span>800元</span></td>
	      <td class="td01">卡号：&nbsp;</td>
    </tr>
    <tr>
	      <td colspan="2" class="td02">有效日期：&nbsp;年  月  日 至 年 月 日</td>
    </tr>
    
     <tr>
	      <td colspan="2">          
          <table border="0" cellpadding="0" cellspacing="0"  width="100%">
          <tr><td class="td03">经办人：&nbsp;</td><td class="td04">财务确认：&nbsp;</td><td class="td05">主任意见：&nbsp;</td>
    		</tr>  
        </table>  
    </td> 
</tr>
  </table>

</body>
</html>
