<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.member.WomenOptions"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String code = teasession.getParameter("code");


String member = Profile.getMember(code);
Profile p = Profile.find(member);

if(!p.isExisted(member))
{
	//如果不存在

	out.println("您的用户编号不存在，请确认是否正确");
	return;
}




%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


</head>

<body>

<h1>来电信息</h1>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

 <tr>
      <td align="right"><span id="btid">*</span>&nbsp;会员编号：</td>
      <td>
        <%=Entity.getNULL(p.getCode()) %>
      </td>
    </tr>
     <tr>
      <td align="right">E-mail：</td>
      <td><%=Entity.getNULL(p.getEmail()) %></td>
    </tr>

    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;用户名：</td>
      <td>
        <%=Entity.getNULL(member) %>
      </td>
    </tr>

	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
       <%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;性别：</td>
      <td><%if(!p.isSex()){out.println("男");} %><%if(p.isSex()){out.println("女");} %></td>
    </tr>

     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;身份证号：</td>
      <td><%=p.getCard() %>    </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机：</td>
      <td><%=p.getMobile() %></td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;生日：</td>
      <td><%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %></td>
    </tr>
       <tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>


      <td><%

      tea.entity.util.Card cobj = tea.entity.util.Card.find(p.getProvince(teasession._nLanguage));
  	   out.print(cobj.toString2());
      %></td>

    </tr>

      <tr>
      <td></td>
      <td>

      	用户的详细信息

      </td>

    </tr>


   <tr>
   	<td align="right">从何得知履友联盟？</td>
   	<td><%=Profile.SOURCE_TYPE[p.getSource()] %>

   		<span id="trainid" <%if(p.getSource()==1){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			哪次培训：<%=Entity.getNULL(p.getTraintime()) %>
   			培训地点：<%=Entity.getNULL(p.getTrainaddress()) %>
   			培训时间：<%=Entity.getNULL(p.getTraintime()) %>
   		</span>
   		<span id="tjmemberid" <%if(p.getSource()==2){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   		推荐人会员编号或用户名：<%=Entity.getNULL(p.getTjmember()) %>


   		</span>
   		<span id="belsellid" <%if(p.getSource()==3){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			销售员姓名：<%=Entity.getNULL(p.getBelsell()) %>
   		</span>
   	</td>
   </tr>



     <tr>
      <td align="right">民族：</td>
      <td><%=Entity.getNULL(p.getZzracky()) %>
      </td>
    </tr>

	<tr>
      <td align="right">固定电话：</td>
      <td><%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>
      </td>
    </tr>
     <tr>
      <td align="right">家庭所在地：</td>
      <td><%
      if(p.getZzhkszd(teasession._nLanguage)!=null && p.getZzhkszd(teasession._nLanguage).length()>0){

      tea.entity.util.Card cobj2 = tea.entity.util.Card.find(Integer.parseInt(p.getZzhkszd(teasession._nLanguage)));
  	   out.print(cobj2.toString2());
      }
      %>



    详细地址:<%=Entity.getNULL(p.getPAddress(teasession._nLanguage)) %>
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
      <%
      if(p.getState(teasession._nLanguage)!=null && p.getState(teasession._nLanguage).length()>0){
      tea.entity.util.Card cobj3 = tea.entity.util.Card.find(Integer.parseInt(p.getState(teasession._nLanguage)));
  	   out.print(cobj3.toString2());
      }
      %>


    详细地址:<%=Entity.getNULL(p.getOrganization(teasession._nLanguage)) %>
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td><%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>
      </td>
    </tr>

    <tr>
      <td align="right">QQ：</td>
      <td><%=Entity.getNULL(p.getMsnID()) %>
      </td>
    </tr>


      <tr>
      <td  align="right">是否有上岗证：</td>
      <td>
      <%if(p.getSfshanggang()==0){out.println("是");} %>
       <%if(p.getSfshanggang()==1){out.println("否");} %>
      </td>

    </tr>

      <tr>
      <td align="right">发证机关：</td>
      <td><%=Entity.getNULL(p.getFazhengjiguan()) %>
      </td>
    </tr>
     <tr>
      <td align="right">操作年限：</td>
      <td><%=Entity.getNULL(p.getCaozuonianxian()) %>
      </td>
    </tr>
     <tr>
      <td align="right">现操作机型：</td>
      <td>品牌：<%=Entity.getNULL(WomenOptions.find(p.getXpinpai(),teasession._nLanguage).getWoname())%>&nbsp;型号：<%=Entity.getNULL(WomenOptions.find(p.getXxinghao(),teasession._nLanguage).getWoname())%>


      </td>
    </tr>
     <tr>
      <td align="right">曾操作机型：</td>
        <td>品牌：<%=Entity.getNULL(WomenOptions.find(p.getCpinpai(),teasession._nLanguage).getWoname())%>&nbsp;型号：<%=Entity.getNULL(WomenOptions.find(p.getCxinghao(),teasession._nLanguage).getWoname())%>
 			其他: <%=Entity.getNULL(p.getCqita()) %>
      </td>
    </tr>

     <tr>
      <td align="right">机主相关：</td>
      <td>
 			姓名:<%=Entity.getNULL(p.getJzname()) %>
 			型号:<%=Entity.getNULL(p.getJzxinghao()) %>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
 			序列号:<%=Entity.getNULL(p.getJzxuliehao()) %>
      </td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td>
 			联系方式:<%=Entity.getNULL(p.getJzlianxi()) %>
      </td>
    </tr>
     <tr>
     <td align="right">爱好：</td>
      <td><%=Entity.getNULL(p.getAihao()) %>
      </td>
    </tr>
  </table>
  <br>
  <%
  	if("wms".equals(teasession.getParameter("act")))
  	{
  %>
 <input type="button" value="关闭"  onClick="javascript:window.close();">
 <br>
  <%} %>


</body>
</html>

