<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%



String member=teasession._rv.toString();

Blog blog = Blog.find(teasession._strCommunity, member);
node=tea.entity.node.Node.find(blog.getHome());

tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(member);
String nickname=bp.getNickname(teasession._nLanguage);
String picture=bp.getPicture();
if(picture==null)
{

  tea.entity.site.BLOGCommunity bc=  tea.entity.site.BLOGCommunity.find(teasession._strCommunity);
  picture=bc.getPicture();
}
picture=picture;

tea.entity.member.Profile profile=tea.entity.member.Profile.find(member);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" src="/tea/CssJs/CnoocAreaCityDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
<script type="">
function fonchange()
{
  fform111net.picturebrowse.style.width="auto";
  fform111net.picturebrowse.style.height="auto";
  fform111net.picturebrowse.src=fform111net.picture.value;
  width=fform111net.picturebrowse.width;
  height=fform111net.picturebrowse.height;
  if(widTD>180||height>120)
  {
    if(width/180>height/120)
    {
      height=parseInt(height/(width/180));
      width=180;
    }else
    {
      width=parseInt(width/(height/120));
      height=120;
    }
  }
  fform111net.width.value=width;
  fform111net.height.value=height;
  fform111net.picturebrowse.width=width;
  fform111net.picturebrowse.height=height;
  fform111net.picturebrowse.style.width="";
  fform111net.picturebrowse.style.height="";
}
</script>
</head>
<body>
<h1>基本信息设置</h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <form action="/servlet/EditWeblog" method="post" name="fform111net" enctype="multipart/form-data" >
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="webloginfo" value="ON"/>


    <h2>BLOG标题更改 </h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td nowrap>BLOG标题： </TD>
        <td><INPUT maxLength=24 value="<%=node.getSubject(teasession._nLanguage)%>" name="subject"></td>
        <td>最多24个字符(包括24)或12个汉字，为您的BLOG空间命名。</td>
      </tr>
    </table>
<br>
    <h2>更改基本资料</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td nowrap>昵称：</TD>
        <td><INPUT class=input_title  maxLength=16 value="<%if(nickname!=null)out.print(nickname);%>" name="nickname"></td>
        <td>4-16个字符(包括4、16)或汉字2-8个，此昵称为您在王府BLOG使用的笔名。</td>
      </tr>
      <tr>
        <td nowrap>邮箱地址：</TD>
        <td><INPUT class=input_title maxLength=40 value="<%=profile.getEmail()%>" name="email"></td>
        <td>填写正确的邮箱地址，以便我们为您提供更好的服务</td>
      </tr>
      <tr>
        <td nowrap>性别：</TD>
        <td><INPUT id=gender1  id="radio" type="radio" CHECKED value="true" name="sex"><LABEL for=gender1>男</LABEL>
          <INPUT id=gender2  id="radio" type="radio" value="false" <%if(!profile.isSex())out.print(" CHECKED ");%> name="sex"><LABEL for=gender12>女</LABEL>
</td>
<td>此处可更改您的性别。</td>
      </tr>
      <tr>
        <td nowrap>生日：</TD>
        <td><%=new TimeSelection("birthday", profile.getBirth())%></td>
        <td>填写正确的生日信息，或许可以获得意外的惊喜！</td>
      </tr>
      <tr>
        <td nowrap>所在城市：</TD>
        <td><select id="State" name="State"> </select>
<select class="edit_input" id="City" style="WIDTH: 160px"   name="City"> </select>

		<script language="javascript" type="">
/*期望工作地区*/
var expectStateObj=document.all['State'];
var srcExpectCityObj=document.all['City'];
if(typeof(expectStateObj)=="object") expectStateObj.onchange=function()
{
    onChangeProvince(document.all['State'],document.all['City']);
}



// if(typeof(expectStateObj)=="object" && typeof(srcExpectCityObj)=="object" && typeof(expectCityObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    initProvince(expectStateObj,srcExpectCityObj,"");
    //initCityNodes(expectCityObj,"");
}




for (index=0;index<expectStateObj.length;index++)
{
  if('<%=(profile.getState(teasession._nLanguage))%>'==expectStateObj.options[index].value)
  {
    expectStateObj.selectedIndex=index;
    expectStateObj.onchange();
    break;
  }
}
for(index=0;index<srcExpectCityObj.length;index++)
{
  if('<%=(profile.getCity(teasession._nLanguage))%>'==srcExpectCityObj.options[index].value)
  {
    srcExpectCityObj.selectedIndex=index;
    break;
  }
}
    </script>
</td>
        <td>填写目前所在地信息。</td>
      </tr>
      <tr>
        <td nowrap>&nbsp;</TD>
        <td><table width="180" height="120" border="1">
            <tr>
              <td align="center"><img src="<%=picture%>" width="<%=bp.getWidth()%>" height="<%=bp.getHeight()%>" name="picturebrowse" alt="" style="width:">
                <input type="hidden" name="width" value="<%=bp.getWidth()%>">
                <input type="hidden" name="height" value="<%=bp.getHeight()%>">
              </td>
            </tr>
          </table></td>
        <td> BLOG个人首页个性图片。 <br>
          温馨提示：为了您页面的美观，上传图片的宽和高请处理为180象素*120象素，大小不要超过30K，并且为.gif或.jpg格式。 </td>
      </tr>
      <tr>
        <td nowrap>更改图片：</TD>
        <td><input type="file" name="picture" onChange="fonchange();">
        </td>
        <td>注：此处上传图片会覆盖当前使用的个性图片。</td>
      </tr>
    </table>

    <input type="submit" value="提交">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <br>
</body>
</html>

