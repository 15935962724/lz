<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%
TeaSession teasession = new TeaSession(request);

//
//out.print(teasession._nNode);

int nd = 2198116;

if(request.getParameter("nodes")!=null){
  nd = Integer.parseInt(request.getParameter("nodes"));
}

%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>图片上传信息</title>

  <script language="JavaScript" type="">
  function selectallf()
  {
    var a = document.getElementsByTagName("input");
    if(form1.selectall.checked==true)
    {
      for (var i=0; i<a.length; i++)
      {
        if (a[i].type == "checkbox" &&  (a[i].checked == false))
        {
          a[i].checked = true;
        }
      }
    }
    else
    {
      for (var i=0; i<a.length; i++)
      if (a[i].type == "checkbox" &&  (a[i].checked == true))
      {
        a[i].checked = false;
      }
    }
  }


  function subimtfalg()
  {
    var a = document.getElementsByTagName("input");
    for (var i=0; i<a.length; i++)
    {
      if (a[i].type == "checkbox" &&  (a[i].checked == false))
      {
       alert(a[i].cc+"，未被选中！");
       return false;
      }
    }
  }
  </script>

<style>
#table002{background:#F6F6F6;border-bottom:5px solid #eee;padding:6px;border-top:5px solid #eee;width:90%;}
#table002 input{background:#fff;}
#submit,.Button,.submit{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding-bottom:0;}
.lightbox{width:350px;border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:150%;}
.bg8 td{background:#eee;border-bottom:1px solid #ccc;}
.1{border:0;}
#table002 td{padding:0;line-height:180%;}
</style>
</head>




<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;上传图片</div>
<h1>上传图片</h1>


<form name="form1" action="/jsp/bpicture/saler/EditPicture_new.jsp"  method="GET">
<input  type="hidden" name="NewNode" value="ON" />
<input  type="hidden" name="Type" value="40" />
<input  type="hidden" name="node" value="<%=nd%>" />
<table border="0" align="center" cellpadding="0" cellspacing="0" id="table002">
  <tr>
    <td height="15" colspan="3"></td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;使用下面的清单，以确认你准备提交的图片.</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传您的文件或文件夹的使用JPEG图片<font title="该网站的应用程序将上传您的图片。">B-picture上传</font> 下一步.</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如需要查看上传图片信息，请点击<a title="链接工具。追踪您的图片作为我们处理控制它们。"  href="/jsp/bpicture/saler/My_submissions.jsp">图片上传信息</a>.</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我们需要这方面的信息。</td>
  </tr>
  <tr>
    <td height="55" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;<b>图片提交清单</b></td>
  </tr>
  <tr>
    <td width="48%" rowspan="3" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;请证实您编辑了您的图片，并且检查以下几项：：</td>
    <td align="center"><input type="checkbox" name="charm"  class="1"/></td>
    <td width="52%">&nbsp;无色情信息</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="logo" class="1"/></td>
    <td>&nbsp;如果您将图片定义为RF，其中将不能包含商标</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="series" class="1"/></td>
    <td>&nbsp;一组（系列）相似的图片不能超过五幅。</td>
  </tr>
  <tr>
    <td height="10" colspan="3" valign="top"></td>
  </tr>
  <tr>
    <td rowspan="5" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;请证实您检查了图象质量，并且检查以下几项： </td>
    <td align="center"><input type="checkbox" name="guide"  class="1"/></td>
    <td>&nbsp;恰当地朝向和排列。</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="pretty" class="1"/></td>
    <td>&nbsp;图片中不能有污点</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="film" class="1"/></td>
    <td>&nbsp;不要用图片处理软件中的淲镜功能来改变图片</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="fff" class="1"/></td>
    <td>&nbsp;图片不要过度锐化。</td>
  </tr>
  <tr>
    <td height="10" colspan="3" valign="top"></td>
  </tr>
  <tr>
    <td rowspan="9" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;请检查您的图片符合我们的技术标准，并检查以下几项： </td>
    <td align="center"><input type="checkbox" name="rgb"  class="1"/></td>

    <td>&nbsp;图片的格式请用RGB，不要用CMYK。</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="hightjpg" class="1"/></td>
    <td>&nbsp;最佳的JPEG文件(在Photoshop中存储，压缩品质请选择10)。</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="colorspace" class="1"/></td>
    <td>&nbsp;图片色域空间，选择Adobe RGB 1998</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="passpage" class="1" /></td>
    <td>&nbsp;图片请选择8位/通道</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="min" class="1" /></td>
    <td>&nbsp;图片未经压缩不得小于30MB,RF（版权管理）图不得小于50M 。(在photoshop中打开的大小)</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="max" class="1"/></td>
    <td>&nbsp;压缩文件最大不得超过25MB，(在文件属性中看到的大小）</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="overjpg" class="1"/></td>
    <td>&nbsp;只接收jpeg格式的图片文件，并且文件是以‘.jpg’命名结尾。</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="saveinfo" class="1"/></td>
    <td>&nbsp;请保留数码相机的信息</td>
  </tr>
  <tr>
    <td align="center"><input type="checkbox" name="selectall" onClick="selectallf();" class="1"></td>
    <td>&nbsp;所有-我的图片满足所有B-picture的要求。</td>
  </tr>
  <tr>
    <td height="10" colspan="3" valign="top"></td>
    </tr>
  <tr>
    <td height="35" colspan="3" align="center"><input id=“submit” name="submit"  class="submit" type="submit" onClick="return subimtfalg();"  value="下一步"/>    </td>
  </tr>
</table>
</form>
</div></body>
</html>
