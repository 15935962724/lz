<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.convert.*"%>
<%@page import="com.jacob.com.*"%><%

Http h=new Http(request,response);
//TeaSession ts=new TeaSession(request);
//if(ts._rv==null)
//{
//  out.print("<script>top.location='/servlet/StartLogin'</script>");
//  return;
//}

Dispatch dp=Paper.P2F.getProperty("DefaultProfile").toDispatch();
Conf co=Conf.find(h.community);


%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>阅读器设置</h1>

<form name="form1" action="/Papers.do?repository=paper" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="profile"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="InterfaceOptions" value="0" usemap="<%=Dispatch.get(dp,"InterfaceOptions")%>"/>
<input type="hidden" name="ThumbnailFileName" value="%name%_%page%.jpg" usemap="<%=Dispatch.get(dp,"ThumbnailFileName")%>"/>
<input type="hidden" name="MetaDataFileName" value="%name%.xml" usemap="<%=Dispatch.get(dp,"MetaDataFileName")%>"/>

<h2>保护</h2>
<table id="tablecenter">
  <tr>
    <td>选项</td>
    <td usemap="<%=Dispatch.get(dp,"ProtectionOptions")%>">
    <%
    int pp=co.getInt("ProtectionOptions");
    String[] PROTECTION_OPTION={"禁止打印","禁止复制","启用API接口","禁止通过接口复制"};
    for(int i=0,j=1;i<PROTECTION_OPTION.length;i++,j+=j)
    {
      out.print("<input type='checkbox' name='ProtectionOptions' value='"+j+"'");
      if((pp&j)!=0)out.print(" checked");
      out.print(" />"+PROTECTION_OPTION[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>域名</td>
    <td><input name="RestrictionDomains" value="<%=co.get("RestrictionDomains")%>" usemap="<%=Dispatch.get(dp,"RestrictionDomains")%>"/>多个用逗号分隔</td>
  </tr>
</table>


<h2>水印</h2>
<table id="tablecenter">
  <tr>
    <td>图片</td>
    <td><input type="file" name="WatermarkImage"/>
      <%//=Dispatch.get(dp,"WatermarkImage").getString()
      String tmp=co.get("WatermarkImage");
      if(tmp!=null)out.print("　<a href=### onclick=mt.img('"+tmp+"')>查看</a>　<input type='checkbox' name='clear'>清空");
      %></td>
  </tr>
  <tr>
    <td>缩放</td>
    <td><input name="WatermarkScale" value="<%=co.get("WatermarkScale")%>" usemap="<%=Dispatch.get(dp,"WatermarkScale")%>"/>%</td>
  </tr>
  <tr>
    <td>透明度</td>
    <td><input name="WatermarkTransparency" value="<%=co.get("WatermarkTransparency")%>" usemap="<%=Dispatch.get(dp,"WatermarkTransparency")%>"/> 0-255</td>
  </tr>
  <tr>
    <td>位置</td>
    <td>
      <select name="WatermarkAnchor">
      <option value="0">中心
      <option value="1">左则中心
      <option value="2">右则中心
      <option value="16">顶部中心
      <option value="32">底部中心
      <option value="17">左上角
      <option value="18">右上角
      <option value="33">左下角
      <option value="34">右下角
      </select>
    </td>
  </tr>
  <tr>
    <td>X轴偏移</td>
    <td><input name="WatermarkXOffset" value="<%=co.get("WatermarkXOffset")%>" usemap="<%=Dispatch.get(dp,"WatermarkXOffset")%>"/><select><option value="px">px<option value="%">%</select></td>
  </tr>
  <tr>
    <td>Y轴偏移</td>
    <td><input name="WatermarkYOffset" value="<%=co.get("WatermarkYOffset")%>" usemap="<%=Dispatch.get(dp,"WatermarkYOffset")%>"/><select><option value="px">px<option value="%">%</select></td>
  </tr>
</table>

<h2>优化</h2>
<table id="tablecenter">
  <tr>
    <td>兼容性</td>
    <td usemap="<%=Dispatch.get(dp,"FlashVersion")%>">
    <%
    int ver=co.getInt("FlashVersion");
    for(int i=7;i<12;i++)
    {
      out.print("<input type='radio' name='FlashVersion' value='"+i+"'");
      if(ver==i)out.print(" checked");
      out.print(" />Flash "+i+"及以上　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>图片</td>
    <td><input type="checkbox" name="UseJpeg"/>使用JPEG压缩</td>
  </tr>
  <tr>
    <td>压缩质量</td>
    <td><input name="JpegQuality" value="<%=co.get("JpegQuality")%>" usemap="<%=Dispatch.get(dp,"JpegQuality")%>"/></td>
  </tr>
</table>


<h2>链接</h2>
<table id="tablecenter">
  <tr>
    <td>选项</td>
    <td><input type="checkbox" name="ParseLinks"/>识别链接</td>
  </tr>
  <tr>
    <td>扩展</td>
    <td usemap="<%=Dispatch.get(dp,"ExtractLinks")%>">
    <%
    int el=co.getInt("ExtractLinks");
    String[] APPLICATIONTYPE={"Excel","Word","PowerPoint","Acrobat"};
    for(int i=0,j=1;i<APPLICATIONTYPE.length;i++,j+=j)
    {
      out.print("<input type='checkbox' name='ExtractLinks' value='"+j+"'");
      if((el&j)!=0)out.print(" checked");
      out.print(" />"+APPLICATIONTYPE[i]+"　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>目标</td>
    <td><input type="checkbox" name="LinkTargetAuto"/>目标自动</td>
  </tr>
  <tr>
    <td>目标</td>
    <td><input name="LinkTarget" value="<%=co.get("LinkTarget")%>" usemap="<%=Dispatch.get(dp,"LinkTarget")%>"/></td>
  </tr>
</table>

<h2>缩略图</h2>
<table id="tablecenter">
  <tr>
    <td>图片</td>
    <td><input name="ThumbnailPageRange" value="<%=co.get("ThumbnailPageRange")%>" usemap="<%=Dispatch.get(dp,"ThumbnailPageRange")%>"/>1,3,5-12</td>
  </tr>
  <tr>
    <td>格式</td>
    <td usemap="<%=Dispatch.get(dp,"ThumbnailFormat")%>">
    <%
    int tf=co.getInt("ThumbnailFormat");
    String[] IMAGEFORMAT={"","JPG","PNG"};
    for(int i=1;i<IMAGEFORMAT.length;i++)
    {
      out.print("<input type='radio' name='ThumbnailFormat' value='"+i+"' id='tf"+i+"'");
      if(tf==i)out.print(" checked");
      out.print(" /><label for='tf"+i+"'>"+IMAGEFORMAT[i]+"</label>　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>压缩质量</td>
    <td><input name="ThumbnailJpegQuality" value="<%=co.get("ThumbnailJpegQuality")%>" usemap="<%=Dispatch.get(dp,"ThumbnailJpegQuality")%>"/></td>
  </tr>
  <tr>
    <td>宽</td>
    <td><input name="ThumbnailImageWidth" value="<%=co.get("ThumbnailImageWidth")%>" usemap="<%=Dispatch.get(dp,"ThumbnailImageWidth")%>"/></td>
  </tr>
  <tr>
    <td>高</td>
    <td><input name="ThumbnailImageHeight" value="<%=co.get("ThumbnailImageHeight")%>" usemap="<%=Dispatch.get(dp,"ThumbnailImageHeight")%>"/></td>
  </tr>
</table>

<h2>文档内容</h2>
<table id="tablecenter">
  <tr>
    <td></td>
    <td><input type="checkbox" name="CreateMetaDataFile"/>生成文档内容</td>
  </tr>
  <tr>
    <td>格式</td>
    <td usemap="<%=Dispatch.get(dp,"MetaDataFileFormat")%>">
    <%
    int mf=co.getInt("MetaDataFileFormat");
    String[] METADATAPORMAT={"","XML","TXT"};
    for(int i=1;i<METADATAPORMAT.length;i++)
    {
      out.print("<input type='radio' name='MetaDataFileFormat' value='"+i+"' id='mf"+i+"'");
      if(mf==i)out.print(" checked");
      out.print(" /><label for='mf"+i+"'>"+METADATAPORMAT[i]+"</label>　");
    }
    %>
    </td>
  </tr>
</table>

<br/>
<input class="but2" type="submit" value="提　交"/> <input class="but2" type="button" value="重　置" onclick="mt.reset()"/>
</form>

<script>
form1.nexturl.value=location.pathname+location.search;
form1.UseJpeg.usemap=<%=Dispatch.get(dp,"UseJpeg")%>;
form1.UseJpeg.checked=<%=co.get("UseJpeg")%>;

form1.WatermarkAnchor.usemap=<%=Dispatch.get(dp,"WatermarkAnchor")%>;
form1.WatermarkAnchor.value=<%=co.get("WatermarkAnchor")%>;

form1.ParseLinks.checked=<%=Dispatch.get(dp,"ParseLinks")%>;
form1.ParseLinks.checked=<%=co.get("ParseLinks")%>;

form1.LinkTargetAuto.checked=<%=Dispatch.get(dp,"LinkTargetAuto")%>;
form1.LinkTargetAuto.checked=<%=co.get("LinkTargetAuto")%>;

form1.CreateMetaDataFile.checked=<%=Dispatch.get(dp,"CreateMetaDataFile")%>;
form1.CreateMetaDataFile.checked=<%=co.get("CreateMetaDataFile")%>;

mt.reset=function()
{
  var arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i].getAttribute('usemap');
    if(arr[i].type=='text')
    arr[i].value=t;
  }
};
mt.focus();
</script>
</body>
</html>
