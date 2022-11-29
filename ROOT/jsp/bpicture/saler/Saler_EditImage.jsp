<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%@page import="tea.entity.site.*" %>
<%@ page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);


TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
int node = Integer.parseInt(request.getParameter("node"));
Picture p = Picture.find(node);
Node n = Node.find(node);
Baudit ba = Baudit.find(node);
String picture ="/res/"+teasession._strCommunity+"/picture/"+node+".jpg";
String cls = "";
if(ba.getClassific()!=null){
  String[] clas = ba.getClassific().split("/");
  for(int j = 0; j < clas.length; j++)
  {
    cls +=clas[j];
  }
}
int widthel=0,heightel=0,numel=0;
File exla=new File(application.getRealPath(picture));
if(exla.isFile())
{
  BufferedImage bi = ImageIO.read(exla);
  widthel = bi.getWidth();
  heightel = bi.getHeight();
  ExifReader erel = new ExifReader(application.getRealPath(picture));
  numel =  Integer.parseInt(erel.getResolution());
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/res/<%=teasession._strCommunity%>/cssjs/3js.js" type="" ></SCRIPT>


<script>
function load()////图片用途 显示
{
  var j=1;
  for (i=0;i < aU.length; i++)
  {
    document.form1.image_use.options[j++] = new Option(aU[i][2],aU[i][0]);
  }
}
function image_use_f(Id)////图片用途 点击
{
  var j=1;
  var op= document.form1.image_details.options;
  while(op.length>1)
  {
    op[1]=null;
  }
  var op3= document.form1.image_size.options;
  while(op3.length>1)
  {
    op3[1]=null;
  }

  for (i=0;i < aM.length; i++)
  {
    if(aM[i][1]==Id)//类型
    document.form1.image_details.options[j++] = new Option(aM[i][3],aM[i][0]);
  }
  //  document.getElementById('tr_mailing').style.display="none";
}
function image_details_f(Id)///详细用途 点击
{
  var j=1;
  var op3= document.form1.image_size.options;
  while(op3.length>1)
  {
    op3[1]=null;
  }
  for (i=0;i < aM.length; i++)
  {
    if(aM[i][0]==Id)
    {
      for (k=0;k < aI.length; k++)
      {
        if(aI[k][0]==aM[i][5])//类型
        document.form1.image_size.options[j++] = new Option(aI[k][3],aI[k][1]);
      }
    }
  }
}
function addxianzhi()
{
  var str="";
  for (i=0;i<aU.length;i++)
  {
    if(document.form1.image_use.value==aU[i][0])
    {
      str+=aU[i][2]+",";
    }
  }
  for (i=0;i < aM.length; i++)
  {
    if(document.form1.image_details.value==aM[i][0])
    {
      str+=aM[i][3]+",";
    }
  }
  for (i=0;i<aI.length;i++)
  {
    if(document.form1.image_size.value==aI[i][1])
    {
      str+=aI[i][3]+",";
    }
  }
  document.form1.xianzhi.value=str;
}
function aaaa()
{
  document.form1.deleteid.value="1";
}

</script>
<title>
编辑图片信息
</title>
<style>
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;margin-bottom:10px;}
#table001 td{padding:6px 15px;border-bottom:1px solid #ccc;}
#classific1,#classific2,#classific3,#classific4,#photography1,#photography2,#photography3,#design1,#design2,#design3,#property1,#property2,#property3,#touse1,#touse2,#cutimg1,#cutimg2,#cuted1,#cuted2,#lzj,#delImage,#color1,#color2{border:0;}
#zuo{border-right:1px solid #ccc;}
#you{border-left:1px solid #ccc;line-height:180%;}
#table002 td{background:#eee;border-bottom:1px solid #ccc;height:30px;}
#table002{width:95%;padding:6px;margin-top:20px;}
#lzj_xiao{width:100%;padding:5px 0;}
#lzj_xiao td{border:0;padding:5px 0px;}
#caption,#basickey,#mainkey,#intekey,#intro,#location{width:100%;border:1px solid #7F9DB9;background:#fff;}
#kwd{margin-top:5px;}

#lzj_table{border:0;}
#lzj_table td{border:0;padding:0;}
.lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
</style>
</head>
<body bgcolor="#ffffff" onLoad="load()" >
<div id="wai">
  <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;编辑图片</div>
  <h1>编辑图片</h1>
  <table border="0" cellspacing="0" cellpadding="0" id="table002">
    <tr>
      <td>B-picture的图片编号：<b><%=ba.getNode()%></b></td>
      <td>您上传的图片名称：<b><%if(p.get_nName()!=null)out.print(p.get_nName());%></b> </td>
    </tr>
  </table>

  　
  <form name="form1" action="/servlet/EditBPicture" method="POST" enctype="multipart/form-data" onSubmit="return check(this);">
  <input id="filevalue" type="hidden" name="filevalue"/>
  <input type="hidden" name="act" value="upone"/>
  <input type="hidden" name="node" value="<%=node%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <input type="hidden" name="xianzhi" value=""/>
  <input type="hidden" name="ids" value="0">
  <input type="hidden" name="deleteid" value="0">
  <table border="0" cellpadding="0" cellspacing="0" id="table001">
    <tr>
      <td width="15%" colspan="2" >身份</td>
      <td width="60" colspan="4">销售</td>
      <td width="25%" rowspan="60" valign="top" id="you"><img src="<%=picture%>" width="360" alt=""  /><br />
        <br />
        <b>网页说明</b> <br />
        <b>强制性的信息</b>-包括标题，关键字，版权类型和摄影师。 <br />
        <b>信息不完整的图片</b>-该图片一些必要信息没有填写好。 <br />
        <b>信息完整的图片</b>-图片必要的相关信息已填写完毕,管理员审核压缩后可以进行销售） 。 <br />
        <b>销售-需要更多的信息</b>-您的图片出售给顾客，而是使之更实用，我们建议您修改您的关键字，并完成所有的信息。 <br />
        <br />
        如果您的图片已经出售，您可以变更，删除或添加到下面的信息，除版权类型外客户在24小时内仍然可见。 </td>
    </tr>
    <tr>
      <td colspan="2">上传日期</td>
      <td colspan="4"><%=p.getDateToString(1)%></td>
    </tr>
    <tr>
      <td colspan="2">删除图片？</td>
      <td colspan="4"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="lzj_table">
        <tr>
          <td width="3%"><input type="checkbox" name="delImage" value="true" id="delImage" onClick="if(confirm('是否删除该图片')){document.form1.submit();}else{return false;}"/></td>
          <td width="97%"><label for="delImage">点击请求删除</label></td>
        </tr>
  </table></td>
    </tr>
    <tr>
      <td colspan="2" valign="top">分类 </td>
      <td colspan="4" valign="top"><input id="classific1" type="checkbox" name="classific" value="1" <%if(cls.contains("1"))out.print("checked");%>>
        <label for="classific1">横图</label>
        <br>
        <input id="classific2" type="checkbox" name="classific" value="2" <%if(cls.contains("2"))out.print("checked");%> >
        <label for="classific2">竖图</label>
        <br>
        <input id="classific3" type="checkbox" name="classific" value="3" <%if(cls.contains("3"))out.print("checked");%> >
        <label for="classific3">正图</label>
        <br>
        <input id="classific4" type="checkbox" name="classific" value="4" <%if(cls.contains("4"))out.print("checked");%> >
        <label for="classific4">全景图</label>    </td>
</tr>
<tr>
  <td colspan="2" valign="top">是否有肖像权? </td>
  <td colspan="4" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="lzj_table">
    <tr>
      <td width="3%"><input id="photography1" type="radio"  value="1" name="photography" onClick="model(this.id);" <%if(ba.getPhotography()==1)out.println("checked");%>/></td>
        <td width="97%"><label for="photography1">有</label></td>
    </tr>
    <tr>
      <td><input id="photography2" type="radio"  value="2" name="photography" onClick="model(this.id);" <%if(ba.getPhotography()==2)out.println("checked");%>/></td>
        <td><label for="photography2">没有</label>        </td>
    </tr>
    <tr>
      <td><input id="photography3" type="radio"  value="3" name="photography" onClick="model(this.id);" <%if(ba.getPhotography()==3)out.println("checked");%>/></td>
        <td><label for="photography3">不需要</label>        </td>
    </tr>
</table></td>
</tr>
<tr id="trfile" <%if(ba.getPhotography()==1){out.println("");}else{out.print("style=display:none;");}%>>
  <td colspan="2" valign="top">上传/下载文档：</td>
  <td valign="top" width="80px" nowrap><a style="position:absolute"><img src="/tea/image/netdisk/deplacer.gif" align="absmiddle">添加文档</a>
    <input id="fdoc" type="file" name=fdoc style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onChange="f_click(this)"/>    </td>
    <td colspan="3" id="fi">&nbsp;
    <%
    String wpath = "/res/bigpic/salepic/webmaster/肖像权协议.doc";
    if(ba.getFdoc()!=null){
      wpath = ba.getFdoc();
    }
    out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(wpath,"utf-8")+"&name="+java.net.URLEncoder.encode("肖像权协议","utf-8")+"."+wpath.substring(wpath.lastIndexOf(".")+1)+"><img src=\"/tea/image/netdisk/"+wpath.substring(wpath.lastIndexOf(".")+1)+".gif\" />肖像权协议</a>");
    %></td>
    </tr>
    <tr>
      <td colspan="2" valign="top">是否有物产权?<b>*</b> </td>
      <td colspan="4" valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="lzj_table">
          <tr>
            <td width="3%"><input id="design1" type="radio"  value="1" name="design" <%if(ba.getDesign()==1)out.println("checked");%>/></td>
              <td width="97%"><label for="design1">有</label></td>
          </tr>
          <tr>
            <td><input id="design2" type="radio"  value="2" name="design" <%if(ba.getDesign()==2)out.println("checked");%>/></td>
              <td><label for="design2">没有</label></td>
          </tr>
          <tr>
            <td><input id="design3" type="radio"  value="3" name="design" <%if(ba.getDesign()==3)out.println("checked");%>/></td>
              <td><label for="design3">不需要</label></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td colspan="2" valign="top">授权类型<b>*</b></td>
      <td colspan="4" valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="lzj_table">
          <tr>
            <td width="3%"><input id="property1" type="radio"  value="1" name="property" <%if(ba.getProperty()==1)out.println("checked");%>/></td>
              <td width="97%"><label for="property1">免版税图片 - <font color="#FE8100">RF</font></label></td>
          </tr>
          <tr>
            <td><input id="property2" type="radio"  value="2" name="property" <%if(ba.getProperty()==2)out.println("checked");%>/></td>
              <td><label for="property2">版权管理类图片 - <font color="blue">RM</font></label></td>
          </tr>
        </table>    </td></tr>
        <tr>
          <td colspan="2" valign="top">这是什么图片? <b>*</b></td>
          <td colspan="4" valign="top">
          <select id="medium" name="medium">
          <%

          for(int cnt = 0; cnt<Baudit.MEDIUM.length; cnt++){
            out.print("<option value="+cnt);
            if(ba.getMedium() == cnt){
              out.print(" selected");
            }
            out.print(" >"+Baudit.MEDIUM[cnt]+"</option>");
          }
          %>
          </select>
            </td>
        </tr>
        <tr>
          <td colspan="2" valign="top">这是什么图片? <b>*</b></td>
          <td colspan="4" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
              <tr>
                <td width="3%"><input id="touse1" type="radio"  value="1" name="touse" <%if(ba.getTouse()==1)out.println("checked");%>/></td>
                  <td width="97%"><label for="touse1">照片</label></td>
              </tr>
              <tr>
                <td><input id="touse2" type="radio"  value="2" name="touse" <%if(ba.getTouse()==2)out.println("checked");%>/></td>
                  <td><label for="touse2">插图</label></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td valign="top" colspan="2" class="lzj_wu">色彩</td>
          <td valign="top" colspan="4" class="lzj_input">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
              <tr>
                <td width="3%"><input id="color1" type="radio"  value="1" name="color" <%if(ba.getColor()==1)out.println("checked");%>/></td>
                  <td width="97%"><label for="color1">彩色</label></td>
              </tr>
              <tr>
                <td><input id="color2" type="radio"  value="2" name="color" <%if(ba.getColor()==2)out.println("checked");%>/></td>
                  <td><label for="color2">灰白</label></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td colspan="2" valign="top">这图片是剪切图吗?<b>*</b></td>
          <td colspan="4" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
              <tr>
                <td width="3%"><input id="cutimg1" type="radio"  value="1" name="cutimg" <%if(ba.getCutimg()==1)out.println("checked");%>/></td>
                  <td width="97%"><label for="cutimg1">是</label></td>
              </tr>
              <tr>
                <td><input id="cutimg2" type="radio"  value="2" name="cutimg" <%if(ba.getCutimg()==2)out.println("checked");%>/></td>
                  <td><label for="cutimg2">不是</label></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td colspan="2" valign="top">图片是否经过修改? <b>*</b></td>
          <td colspan="4" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="lzj_table">
              <tr>
                <td width="3%"><input id="cuted1" type="radio"  value="1" name="cuted" <%if(ba.getCuted()==1)out.println("checked");%>/></td>
                  <td width="97%"><label for="cuted1">是</label></td>
              </tr>
              <tr>
                <td><input id="cuted2" type="radio"  value="2" name="cuted" <%if(ba.getCuted()==2)out.println("checked");%>/></td>
                  <td><label for="cuted2">不是</label></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td colspan="2">摄影师<b>*</b></td>
          <td colspan="4">
           <%
           String ename = "";
           if(ba.getMember()!=null){
             Profile pf = Profile.find(ba.getMember());
             ename = pf.getLastName(teasession._nLanguage);
           }

      %>
        <input type="text" id="bpseudonymid" name="bpseudonymid" size="29" value="<%=ename%>" />
            <%-- <select id="bpseudonymid" name="bpseudonymid">
            <option value="0">-------------</option>
            <%
               boolean falgselect=false;
            java.util.Enumeration ee = Bpseudonym.findByCommunity(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString()),0,20);
            for(int k=0;ee.hasMoreElements();k++)
            {
              int idb=Integer.parseInt(String.valueOf(ee.nextElement()));
              Bpseudonym bj = Bpseudonym.find(idb);
              out.print("<option value="+idb);

              String falg =Bpseudonym.getsql(" id  "," and applied=1 and member="+DbAdapter.cite(teasession._rv.toString()));
              String biname=teasession._rv.toString();
              int id=0;
              if(falg!=null && falg.length()>0)
              {
                id= Integer.parseInt(falg);
                Bpseudonym bobj=Bpseudonym.find(id);
                biname = bobj.getName();
              }

              if(ba.getBpseudonymid()==idb)
              {
                out.print(" selected ");
                falgselect=true;
              }
              else  if(biname.equals(bj.getName())&& !falgselect)
              {

                out.print(" selected ");
              }

              out.print(">"+bj.getName()+"</option>");
            }
            %>
            </select>--%>
          </td>
        </tr>
        <tr>
          <td colspan="2" valign="top"> 标题<b>*</b></td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>图片的简单描述 </td>
              <td align="right"><span id="aaa">
                <%if(n.getSubject(1)!=null)out.print(n.getSubject(1).length());%>
</span> /128 </td>
            </tr>
</table>
<textarea id="caption" name="caption" onpropertychange="t_change('caption','aaa');" cols="24" rows="2"><%=n.getSubject(1)%></textarea></td>
        </tr>
        <tr>
          <td colspan="2" valign="top">基本关键字</td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>最相关的单词和短语</td>
              <td align="right"><span id="bbb">
                <%if(ba.getBasicKey()!=null)out.print(ba.getBasicKey().length());%>
</span>/50 </td>
            </tr>
</table>
<textarea id="basickey" name="basickey" onpropertychange="t_change('basickey','bbb');" cols="32" rows="3"><%if(ba.getBasicKey()!=null)out.print(ba.getBasicKey());%>
</textarea>
<br><input name="button" type="button" id="kwd" onClick="oc('basickey',basickey);" value="关键字"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top">主要关键字</td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>下一个最相关的单词和短语</td>
              <td align="right"><span id="ccc" >
                <%if(ba.getMainKey()!=null)out.print(ba.getMainKey().length());%>
</span>/300 </td>
            </tr>
</table>
<textarea id="mainkey" name="mainkey" onpropertychange="t_change('mainkey','ccc');" cols="32" rows="5"><%if(ba.getMainKey()!=null)out.print(ba.getMainKey());%></textarea>
<br>
<input name="button" type="button" class="lzj_001" id="kwd" onClick="oc('mainkey',mainkey);" value="关键字"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top">综合关键字</td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>任何其他的单词和词组</td>
              <td align="right"><span id="ddd">
                <%if(ba.getInteKey()!=null)out.print(ba.getInteKey().length());%>
</span> /856 </td>
            </tr>
</table>
<textarea id="intekey" name="intekey" onpropertychange="t_change('intekey','ddd');" cols="32" rows="5"><%if(ba.getInteKey()!=null)out.print(ba.getInteKey());%>
</textarea>
<br />
<input name="button" type="button" id="kwd" onClick="oc('intekey',intekey);" value="关键字"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top"> 说明</td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>解释此图片的相关信息</td>
              <td align="right"><span id="eee" >
                <%if(ba.getIntro()!=null)out.print(ba.getIntro().length());%>
</span> /2000 </td>
            </tr>
</table>
<textarea id="intro" name="intro" onpropertychange="t_change('intro','eee');" cols="32" rows="5"><%if(ba.getIntro()!=null)out.print(ba.getIntro());%>
</textarea></td>
        </tr>
        <tr>
          <td colspan="2" valign="top"> 位置</td>
          <td colspan="4" valign="top"><table cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td>街道名称，镇，市，州，省，国家等</td>
              <td align="right"><span id="fff" >
                <%if(ba.getLocation()!=null)out.print(ba.getLocation().length());%>
</span> /100 </td>
            </tr>
</table>
<br>
<input id="location" type="text" onpropertychange="t_change('location','fff');" size="32" name="location" value="<%if(ba.getLocation()!=null)out.print(ba.getLocation());%>"/>
<br></td>
        </tr>
        <tr>
          <td colspan="2" valign="middle"> 采用日期</td>
          <td colspan="4" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="lzj_xiao">
            <tr>
              <td colspan="2"><input type="text" readonly="readonly" size="29" name="adopDate" value="<%if(ba.getAdopDate()!=null)out.print(ba.getAdopDateToString());%>"/>
                <img id="adopDate_image" class="bdplButton " alt="" onclick="new Calendar('2006', '2010', 0,'yyyy-MM-dd').show(adopDate);" <%--onClick="showCalendar(adopDate,'');"--%> src="/tea/image/bpicture/date.gif"  border="0" /></td>

            </tr>
</table>
          </td>
        </tr>
        <tr>
          <td rowspan="2" colspan="2" id="zuo"> 最大规模<br />
            分辨率300 </td>
            <td align="center" valign="top">文件大小</td>
            <td align="center" valign="top">象素</td>
            <td align="center" valign="top">厘米</td>
            <td align="center" valign="top">英寸</td>
        </tr>
        <tr>
          <td align="center" nowrap><%=((int)((widthel*heightel*3F/(1024*1024))*100))/100F%>MB</td>
          <td align="center" nowrap><%=widthel%> X <%=heightel%> </td>
          <td align="center" nowrap><%=((int)((widthel*1F/119)*100))/100F%> × <%=((int)((heightel*1F/119)*100))/100F%></td>
          <td align="center" nowrap><%=((int)((widthel*1F/302)*100))/100F%> × <%=((int)((heightel*1F/302)*100))/100F%> </td>
        </tr>
        <tr>
          <td rowspan="<%
          if((1+Blimit.count("",""))<4)
          {
            out.print("8");
          }else
          {
            out.print(1+Blimit.count("","")+5);
          }
          %>" valign="top" id="zuo"> 选择限制 </td>
          <td colspan="5">设置详细说明：只能设置版权管理类和权利保护的图片限制，然后按一下‘添加限制’。新的限制将列在页面底部。</td>
        </tr>

        <tr>
          <td align=right nowrap="nowrap">图片用途</td>
          <td colspan="4"><select name="image_use" onChange="image_use_f(document.form1.image_use.options[document.form1.image_use.selectedIndex].value)">
            <option selected value="0">-------</option>
</select>    </td>
        </tr>
        <tr>
          <td align=right>详细用途</td>
          <td colspan="4"><select name="image_details" onChange="image_details_f(document.form1.image_details.options[document.form1.image_details.selectedIndex].value)">
            <option selected value="0">-------</option>
</select>    </td>
        </tr>
        <tr>
          <td align=right>产品行业</td>
          <td colspan="4"><select name="image_size">
            <option selected value="0">--------</option>
</select>    </td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
          <td colspan="4"><input name="submit3" type="submit" class="lzj_001" onClick="addxianzhi()" value="添加限制" />    </td>
        </tr>
        <tr>
          <td rowspan="<%=1+Blimit.count("","")%>" valign="top" nowrap id="zuo">当前限制</td>
          <td colspan="5">如要删除限制，只需要选择一个或多个选项并点击删除按钮即可</td>
        </tr>
        <%
        java.util.Enumeration ebl = Blimit.findByCommunity(teasession._strCommunity," and  node ="+node,0,Integer.MAX_VALUE);
        for(int i=0;ebl.hasMoreElements();i++)
        {
          int idx = ((Integer) ebl.nextElement()).intValue();
          Blimit bb = Blimit.find(idx);
          %>
          <tr>
            <td colspan="5"><input type="checkbox" name="xianzhiid<%=i%>" value="<%=idx%>" id="lzj"/>
              <label id="xinxi" ><%=bb.getShowinfo()%></label></td>
          </tr>
          <%
          }
          %>
          <tr>
            <td colspan="4">&nbsp;<input name="submit2"  type="submit" class="lzj_001"  onClick="aaaa()" value="删除限制"/></td>

          </tr>
</table>
<input type="submit" class="lzj_001" value="保存更改"/>　
<input type="button" class="lzj_001" onClick="history.back();" value="返回"/>

  </form>

  <%@include file="/jsp/include/Canlendar4.jsp" %>
  <script type="">
  function model(obj)
  {
    if(obj == 'photography1')
    {
      document.getElementById('trfile').style.display='';
    }else
    {
      document.getElementById('trfile').style.display='none';
    }
  }
  function t_change(obj1,obj2)
  {
    document.getElementById(obj2).innerHTML = document.getElementById(obj1).value.length;
  }
  function check(form)
  {
    if(document.getElementById('classific1').checked==false&&document.getElementById('classific2').checked==false&&document.getElementById('classific3').checked==false&&document.getElementById('classific4').checked==false)
    {
      alert("请选择图片分类");
      document.getElementById('classific1').focus();
      return false;
    }
    if(document.getElementById('photography1').checked==false&&document.getElementById('photography2').checked==false&&document.getElementById('photography3').checked==false)
    {
      alert("请选择是否有肖像权");
      document.getElementById('photography1').focus();
      return false;
    }
    if(document.getElementById('design1').checked==false&&document.getElementById('design2').checked==false&&document.getElementById('design3').checked==false)
    {
      alert("请选择是否有物产权");
      document.getElementById('design1').focus();
      return false;
    }
    if(document.getElementById('property1').checked==false&&document.getElementById('property2').checked==false&&document.getElementById('property3').checked==false)
    {
      alert("请选择授权类型");
      document.getElementById('property1').focus();
      return false;
    }
    if(document.getElementById('color1').checked==false&&document.getElementById('color2').checked==false)
    {
      alert("请选择色彩");
      document.getElementById('color1').focus();
      return false;
    }
    if(document.getElementById('touse1').checked==false&&document.getElementById('touse2').checked==false)
    {
      alert("请选择图片类型");
      document.getElementById('touse1').focus();
      return false;
    }
    if(document.getElementById('cutimg1').checked==false&&document.getElementById('cutimg2').checked==false)
    {
      alert("请选择是否为剪切图");
      document.getElementById('cutimg1').focus();
      return false;
    }
    if(document.getElementById('cuted1').checked==false&&document.getElementById('cuted2').checked==false)
    {
      alert("请选择是否修改过");
      document.getElementById('cuted1').focus();
      return false;
    }
    if(document.getElementById('caption').value.length==0)
    {
      alert('无效-标题');
      document.getElementById('caption').focus();
      return false;
    }
    if(document.getElementById('bpseudonymid').value.length==0)
    {
      alert('无效-摄影师');
      document.getElementById('bpseudonymid').focus();
      return false;
    }

    return true;
  }
  function oc(obj,obj1)
  {

    var vl=window.showModalDialog(encodeURI('/jsp/bpicture/saler/BkeyWord.jsp?filename='+obj+"&mv="+obj1.value),'_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');

    if(vl==undefined)
    {
      vl=document.getElementById(obj).value;
    }
    document.getElementById(obj).value=vl;
  }

  function f_click(obj)
  {
    if(!obj)obj=this;

    //
    var td = document.getElementById("fi");
    var path=obj.value;
    var name=path.substring(path.lastIndexOf("\\")+1);
    var ex=name.substring(name.lastIndexOf(".")+1);
    td.innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name+"　<a href=javascript:f_del();><b>移除</b></a>";
    document.form1.filevalue.value = path;
  }
  function f_del()
  {
    var obj = document.getElementById("fdoc");
    obj.outerHTML = obj.outerHTML;
    var obj1 = document.getElementById("filevalue");
    obj1.outerHTML = obj1.outerHTML;
    document.getElementById("fi").innerHTML="&nbsp;";
  }
  </script>
  </div>
</body>
</html>
