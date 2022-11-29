<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
TeaSession teasession=new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");

boolean isNew = request.getParameter("NewNode")!=null;

int i = teasession._nNode;

String s1 = teasession._strCommunity;
int j = 0;

AccessMember am = AccessMember.find(teasession._nNode, teasession._rv); //create(j4, rv);
Node node = Node.find(teasession._nNode);
if(!isNew)
{
  if(!node.isCreator(teasession._rv)&&am.getPurview()<2)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  j = node.getType();
} else
{
  j = Integer.parseInt(teasession.getParameter("Type"));
}


if(j == 41)
response.sendRedirect("/jsp/type/files/EditFiles.jsp?"+(isNew?"NewNode=ON&":"")+"Type="+j+"&node=" + i);


boolean flag2 =true;// teasession._rv.isOrganizer(s1);
boolean flag3 = am.isProvider(j);
boolean flag4 = true;//teasession._rv.isWebMaster();

int i1 = 0;


int l1 = Node.getMaxSequence(i) + 10;
Date date = null;
Date date2 = null;
Date date_n=null;
int j2 = 0;
String s2 = "";
String s4 = "";
String text = "";
int len_pic = 0;
String s8 = "";
String s10 = "";
String s11 = "";
String s12 = "";
int j3 = 1;
int k3 = 0;
int l3 = 0;
int style=0,root=0;
int kstyle=2,kroot=0;
int mmslen=0;
long j1 = node.getOptions();
j2 = node.getDefaultLanguage();
String clickurl=null;
String picture=null,voice=null,file=null,mmspath=null;
if(!isNew)//
{
  l1 = node.getSequence();
  date = node.getStartTime();
  date2 = node.getStopTime();
  date_n=node.getTime();
  s2 = HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  s4 = node.getKeywords(teasession._nLanguage);
  text =  HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  s8 = node.getAlt(teasession._nLanguage);
  j3 = node.getAlign(teasession._nLanguage);
  s10 = node.getClickUrl(teasession._nLanguage);
  s11 = node.getSrcUrl(teasession._nLanguage);
  s12 = node.getSrcUrlx(teasession._nLanguage);

  picture=node.getPicture(teasession._nLanguage);
  if(picture!=null&&picture.length()>0)
       {
    int k=picture.lastIndexOf('#');
    if(k!=-1)picture=picture.substring(0,k);
    len_pic=(int)new File(application.getRealPath(picture)).length();
  }

  voice=node.getVoice(teasession._nLanguage);
  if(voice!=null)
  {
    k3=(int)new File(application.getRealPath(voice)).length();
  }

  file=node.getFile(teasession._nLanguage);


  if(file!=null&&file.length()>1)
  {
    l3=(int)new File(application.getRealPath(file)).length();
  }

  mmspath=node.getMms(teasession._nLanguage);
  if(mmspath!=null&&mmspath.length()>0)
  {
    mmslen=(int)new File(application.getRealPath(mmspath)).length();
  }


  style=node.getStyle();
  root=node.getRoot();
  kstyle=node.getKstyle();
  kroot=node.getKroot();
  clickurl=node.getClickUrl(teasession._nLanguage);
}
if(root==0)
root=teasession._nNode;
String nexturlparameter=teasession.getParameter("nexturl");
boolean  nexturlbool=(nexturlparameter!=null&&!nexturlparameter.equals("null"));


String title;
if(j<1024)
{
  title=r.getString(teasession._nLanguage, Node.NODE_TYPE[j]);
}else if(j<65536)
{
  title=Dynamic.find(j).getName(teasession._nLanguage);
}else
{
  title=TypeAlias.find(j).getName(teasession._nLanguage);
}
%>
<html>
<head>
<title><%=title%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=s1%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<script>
function f_load()
{
  form1.Subject.focus();
}
function AccessMembers()
{
  if(form1.NodeOAccessMember.checked)
  {
    form1.NodeONeedLogin.checked=true;
  }
}
function submitdisabled()
{
  form1.GoNext1.disabled=true;
  form1.GoFinish.disabled=true;
  return true;
}
</script>
</head>
<body onLoad="f_load()">

<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 method=POST action="/servlet/EditNode" enctype=multipart/form-data onSubmit="return(submitInteger(this.Sequence, '<%=r.getString(teasession._nLanguage, "InvalidSequence")%>')&&submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitdisabled());">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="Type" value="<%=j%>">
<%
if(nexturlbool)
out.print("<input type='hidden' name=nexturl value="+nexturlparameter+">");
if(isNew)
out.print("<input type='hidden' name=NewNode value=ON >");

%>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td align="right"><%=r.getString(teasession._nLanguage, "Subject")%>：</td>
        <td><input type="TEXT" class="edit_input"  name=Subject value="<%=(s2)%>" size=70 maxlength=255></td>
      </tr>
      <tr>

      <tr>
  <td align="right"><%=r.getString(teasession._nLanguage, "Category")%>：</td>
  <td>

 	 <select name="categorytype">
 	 <%
 	 String sp_category = AccessMember.find(teasession._nNode,teasession._rv._strV).getCategory();
 	Category category = Category.find(teasession._nNode);
 	CLicense cobj=CLicense.find(node.getCommunity());
 	if(sp_category!=null && sp_category.length()>0)
 	{
	 	 for(int ci=1;ci<sp_category.split("/").length;ci++)
	 	 {

	 		 int cc = 0;
	 		 if(sp_category.split("/")[ci]!=null && sp_category.split("/")[ci].length()>0)
	 		 {
	 			 cc = Integer.parseInt(sp_category.split("/")[ci]);
	 		 }

	 		 if(cobj.getType()!=null && cobj.getType().indexOf("/"+cc+"/")!=-1)//判断社区中是否勾选
	 		 {
		 		 out.print("<option value ="+cc);
		 		 if(cc==category.getCategory())
	 			 {
	 				 out.println(" selected ");
	 			 }
		 		 if(cc<1024)
		 		 {

		 			out.print(">"+r.getString(teasession._nLanguage,Node.NODE_TYPE[cc]));
		 		 }else
		 		 {
		 			Dynamic d=Dynamic.find(cc);

		 			 out.print(">"+d.getName(teasession._nLanguage));
		 		 }
		 		 out.print("</option>");
	 		 }
	 	 }
 	}
 	// System.out.println(AccessMember.find(teasession._nNode,teasession._rv._strV).getType());
 	 	//for(int i=1;i<)
 	 //	out.print("<option value= ");
 	 %>
 	 </select>
  </td>
</tr>

       <tr>
        <td nowrap  align="right"><%=r.getString(teasession._nLanguage, "Keywords")%>：</td>
        <td><input type="TEXT" class="edit_input"  name="Keywords" value="<%=s4%>" size="70" maxlength="255">
        </td>
      </tr>

       <tr >
        <td align="right"><%=r.getString(teasession._nLanguage, "Sequence")%>：</td>
        <td><input type="TEXT" class="edit_input"  name="Sequence" value="<%=l1%>"></td>
      </tr>
      <tr>
        <td align="right"><%=r.getString(teasession._nLanguage, "Picture")%>：</td>
        <td COLSPAN=6><input TYPE=FILE NAME=Picture class="edit_input" >
          <%
          if(len_pic > 0)
          {
            out.print("<a href="+picture+" target=_blank   style=cursor:pointer>查看原图&nbsp;("+len_pic + r.getString(teasession._nLanguage, "Bytes")+")</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearPicture' onClick='form1.Picture.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>&nbsp;<input type="checkbox" name="tbn" checked="checked"/>自动缩小图片&nbsp;&nbsp;
          </td>
      </tr>

      <tr>
        <td nowrap align="right"><%=r.getString(teasession._nLanguage, "Text")%>：</td>
        <td>
          <input type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
          <input type="checkbox" name="srccopy"/>源网站的图片贴入本地&nbsp;
          <input type="button" name="Pictureview" id="Pictureview" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
        </td>
      </tr>

       <tr>
        <td colspan="2">
          <textarea name="content" rows="12" cols="90" class="edit_input"><%=text%></textarea>
          <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=s1%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
        </td>
      </tr>


        <td></td>
        <td> <input type="hidden" name="GoNext" disabled="disabled" />

             <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
               <input type="button" name="reset" value="返回" onClick="javascript:history.go(-1)">
        </td>
      </tr>
    </table>





<table border="0" cellpadding="0" cellspacing="0" id="tablecenter"  style="display:none">
  <tr>
    <td nowrap width="126"><%=r.getString(teasession._nLanguage, "RedirectUrl")%>：</td>
    <td><input type="TEXT" name="clickurl" value="<%if(clickurl!=null)out.print(clickurl);%>" size="70" maxlength="255">
    </td>
  </tr>
  <tr style="display:none">
    <td nowrap width="126" ><%=r.getString(teasession._nLanguage, "KeywordBound")%>：</td>
    <td>
      <input  id="radio" type="radio" name="kstyle" VALUE=0  checked="checked">  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[0])%>
        <input  id="radio" type="radio" name="kstyle" VALUE=1 <%if(kstyle==1)out.print("checked");%>>  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[1])%>
          <input  id="radio" type="radio" name="kstyle" VALUE=2  <%if(kstyle==2)out.print("checked");%> >  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[2])%>
            <input  id="radio" type="radio" name="kstyle" VALUE=3 <%if(kstyle==3)out.print("checked");%> ><%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[3])%><input type="text" name="kroot" size="5" value="<%=kroot%>"/>
    </td>
  </tr>

     <tr style="display:none"><td><%=r.getString(teasession._nLanguage, "ContentBound")%>：</td>
        <td>
         <input  id="radio" type="radio" name="Style" VALUE=0  checked="checked">  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[0])%>
           <input  id="radio" type="radio" name="Style" VALUE=1 <%if(style==1)out.print("checked");%>>  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[1])%>
              <input  id="radio" type="radio" name="Style" VALUE=2  <%if(style==2)out.print("checked");%> >  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[2])%>
                <input  id="radio" type="radio" name="Style" VALUE=3 <%if(style==3)out.print("checked");%> ><%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[3])%><input type="text" name="Root" size="5" value="<%=root%>"/>
        </td>
      </tr>
      <tr style="display:none">
        <td><%=r.getString(teasession._nLanguage, "DefaultLanguage")%>：</td>
        <td><%
        int l4 = License.getInstance().getWebLanguages();
        for(int i5 = 0; i5 < Common.LANGUAGE.length; i5++)
        if((l4 & 1 << i5) != 0)
        {
        	out.print("<input id='radio' type='radio' name=DefaultLanguage value="+i5);
        	if(j2 == i5)out.print(" checked");
        	out.println(">"+r.getString(teasession._nLanguage, Common.LANGUAGE[i5]));
        }%>
        </td>
      </tr>
    </table>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"  style="display:none">
      <tr><td><%=r.getString(teasession._nLanguage, "FrameTemplate")%>：</td><td>
      <%
      DropDown dropdown = new DropDown("frametemplate", i1);
      dropdown.addOption("0", "-------------------");
      java.util.Enumeration enumeration_template=Template.findByPath(node.getPath());
      while(enumeration_template.hasMoreElements())
      {
        int template_id=((Integer)enumeration_template.nextElement()).intValue();
        Template template_obj=Template.find(template_id);
        dropdown.addOption(template_obj.getNode(), template_obj.getName());
      }
      out.println(dropdown);
%></td></tr>
      <tr><td><%=r.getString(teasession._nLanguage, "StyleTemplate")%>：</td><td>
      <select name="styletemplate_big" onChange="fonchange(this);">
      <option value="0">-------------------</option>
      <%
      StringBuffer script=new StringBuffer();
      DbAdapter dbadapter=new DbAdapter();
      try
      {
        java.util.Enumeration enumer=Template2.findByCommunity(s1);
        while(enumer.hasMoreElements())
        {
          int temp_id=((Integer)enumer.nextElement()).intValue();
          Template2 temp_obj=Template2.find(temp_id);
          if(isNew||temp_obj.getNode()!=teasession._nNode)
          {
            out.print("<option value="+temp_id);
            out.print(" >"+temp_obj.getName());

            script.append("case "+temp_id+":\r\n");
            dbadapter.executeQuery("SELECT CssJs.cssjs FROM CssJs,CssJsHide WHERE CssJsHide.cssjs=CssJs.cssjs AND  CssJsHide.node=CssJs.node AND CssJs.node="+temp_id+" AND style<3 AND hiden=0");
            while(dbadapter.next())
            {
              int cssjs=dbadapter.getInt(1);
              CssJs cj_obj=CssJs.find(cssjs);
              script.append("form1.styletemplate.options[form1.styletemplate.options.length]=new Option('"+cj_obj.getName(teasession._nNode)+"',"+cssjs+");");
            }
            script.append("break;\r\n");
          }
        }
      }finally
      {
        dbadapter.close();
      }
      %>
</select>
  <select name="styletemplate">
    <option value="0">-------------------</option>
  </select>

  <script type="">
  function fonchange(obj)
  {
    while(form1.styletemplate.options.length>1)
    {
      form1.styletemplate.options[1]=null;
    }
    switch(parseInt(obj.value))
    {
      <%=script.toString()%>
    }
  }
  </script>
      </td></tr>

        <tr><td><%=r.getString(teasession._nLanguage, "File")%>：</td>
        <td colspan=6><input type=FILE name=File class="edit_input">
          <%
          if(l3>0)
          {
            out.print("<a href="+file+" target=_blank>"+l3+r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearFile' onClick='form1.File.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Voice")%>：</td>
        <td colspan=6><input type=FILE name=Voice class="edit_input">
          <%
          if(k3 > 0)
          {
            out.print("<a href="+voice+" target=_blank>"+k3 + r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearVoice' onClick='form1.Voice.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
          <a href="/tea/html/0/recorder.html" target="_blank"> <%=r.getString(teasession._nLanguage,"Record")%> </a></td>
      </tr>

      <tr>
        <td>MMS:</td>
        <td COLSPAN=6>
          <input TYPE=FILE NAME=Mms class="edit_input">
          <%
          if(mmslen > 0)
          {
            out.print("<a href="+mmspath+" target=_blank>"+mmslen + r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearMms' onClick='form1.Mms.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
        </td>
      </tr>
<%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "ClickUrl")%>:</td>
        <td><input type="text" name="ClickUrl" size="40" MAXLENGTH="255"  class="edit_input" value="<%=s10%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SrcUrl")%>:</td>
        <td><input type="text" NAME=SrcUrl VALUE="<%=s11%>" size="40" MAXLENGTH="255" class="edit_input" ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "SrcUrlx")%>:</td>
        <td><input type="text" NAME=SrcUrlx VALUE="<%=s12%>" size="40" MAXLENGTH="255" class="edit_input" ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Alt")%>:</td>
        <td><input type="text" NAME=Alt size="40" MAXLENGTH="255" value="<%=s8%>" class="edit_input" ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Align")%>:</td>
        <td><input  id="radio" type="radio" NAME=Align VALUE=0 <%=getCheck(j3==0)%>><%=r.getString(teasession._nLanguage, "Default")%>
          <input  id="radio" type="radio" NAME=Align VALUE=1 <%=getCheck(j3==1)%>><%=r.getString(teasession._nLanguage, "Left")%>
          <input  id="radio" type="radio" NAME=Align VALUE=2 <%=getCheck(j3==2)%>><%=r.getString(teasession._nLanguage, "Center")%>
          <input  id="radio" type="radio" NAME=Align VALUE=3 <%=getCheck(j3==3)%>><%=r.getString(teasession._nLanguage, "Right")%>
          <input  id="radio" type="radio" NAME=Align VALUE=4 <%=getCheck(j3==4)%>><%=r.getString(teasession._nLanguage, "Top")%>
          <input  id="radio" type="radio" NAME=Align VALUE=5 <%=getCheck(j3==5)%>><%=r.getString(teasession._nLanguage, "Bottom")%>
        </td>
      </tr>
--%>
    </table>

    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter"  style="display:none">
      <tr>
        <td rowspan="2"><%=r.getString(teasession._nLanguage, "Options")%>：</td>
        <td><%
        if(j == 0 || j == 1 || flag2 || flag3 || flag4)
        {%>
          <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowHeader1 value=null <%if((j1 & 0x40000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowHeader")%>  </span><!--span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowAd value=null <%if((j1 & 0x20000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowAd")%>
          </span-->
          <%--<span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowHeader2 value=null <%=getCheck((j1 & 0x10000000) != 0)%> ><%=r.getString(teasession._nLanguage, "NodeOShowHeader2")%>
          </span>--%>
          <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowBodyLeft value=null <%if((j1 & 0x8000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowBodyLeft")%>          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowBodyRight value=null <%if((j1 & 0x4000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowBodyRight")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowFooter value=null <%if((j1 & 0x2000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowFooter")%>
          <% }%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowPath value=null <%if((j1 & 0x1000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowPath")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowFather value=null <%if((j1 & 0x40000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowFather")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowSons value=null <%if((j1 & 0x800000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowSons")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowGrandsons value=null <%if((j1 & 0x100000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowGrandsons")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowSubject value=null <%if( (j1 & 0x400000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowSubject")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowBriefing value=null <%if((j1 & 0x80L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowBriefing")%>
          </span><span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowCreator value=null <%if((j1 & 0x200000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "NodeOShowCreator")%>
          </span>
          <%if(Node.allowSon(j))
          {%>
          <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOAllowSub value=null <%if((j1 & 0x400L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOAllowSub")%></span>
          <%}
%>
    <input  id="CHECKBOX" type="CHECKBOX" name="DeleteFormat" <%if((j1 & 0x80000000L) != 0)out.print(" checked");%>/><%=r.getString(teasession._nLanguage,"DeleteFormat")%>

    <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeONeedLogin value=null <%if((j1 & 0x1000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "NodeONeedLogin")%></span>

      <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeONeedAuditing value=null <%if((j1 & 0x20L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "NodeONeedAuditing")%></span>

        <span><input   id="CHECKBOX" type="CHECKBOX" onClick="AccessMembers()" name=NodeOAccessMember value=null <%if((j1 & 0x100) != 0)out.print(" checked");%>>
              <A href="/jsp/access/AccessMembers.jsp?node=<%=teasession._nNode%>"  target="_blank"><%=r.getString(teasession._nLanguage, "NodeOAccessMember")%></A></span>
<%--
 <span style="display:none">ID:
               <input type="hidden" class="edit_input"  name=Members value="<%
               String s22 = "";
               for(Enumeration enumeration = AccessMember.findByNode(i); enumeration.hasMoreElements();)
               {
                 AccessMember am_temp=AccessMember.find(((Integer)enumeration.nextElement()).intValue());

                 RV rv1 = am_temp.getRV();
                 if(s22.length() != 0)
                 s22 = s22 + ", ";
                 if(rv1._strR.equals(rv1._strV))
                 s22 = s22 + rv1._strR;
                 else
                 s22 = s22 + rv1._strR + "/" + rv1._strV;
               }
               out.print(s22);
%>" size="25" maxlength="255">
--%>
<!--
          <span><input  id="CHECKBOX" type="CHECKBOX" name=MsgOSendMessage value=null><%=r.getString(teasession._nLanguage, "MsgOSendMessage")%></span>
		  <span><input  id="CHECKBOX" type="CHECKBOX" name=MsgOSendEmail value=null><%=r.getString(teasession._nLanguage, "MsgOSendEmail")%></span>		  </span>
-->
        </td>
                  </tr>
                  <tr>
                    <td>
 <input id="CHECKBOX" type="CHECKBOX" name=CBAddToBriefcase value=null <%if((j1 & 0x100000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBAddToBriefcase")%>
 <input id="CHECKBOX" type="CHECKBOX" name=CBAddToFavorites value=null <%if((j1 & 0x200000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBAddToFavorites")%>
 <input id="CHECKBOX" type="CHECKBOX" name=CBAddToContact value=null <%if((j1 & 0x400000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBAddToContact")%>
 <input id="CHECKBOX" type="CHECKBOX" name=CBAddToReminder value=null <%if((j1 & 0x800000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBAddToReminder")%>
 <!-- 准许投票  已经移到 列举中  <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOPoll value=null <%if((j1 & 0x20000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOPoll")%></span>-->
 <%--
 //已移至到列举中了
  <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOChatRoom value=null <%if((j1 & 0x10000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOChatRoom")%></span>
 <input id="CHECKBOX" type="CHECKBOX" name=CBForward value=null <%if((j1 & 0x1000000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBForward")%>
 <input id="CHECKBOX" type="CHECKBOX" name=CBReplyToCreator value=null <%if((j1 & 0x2000000000L) != 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "CBReplyToCreator")%></td>
 --%>
      </tr>

	  <tr>
	<td><%=r.getString(teasession._nLanguage, "TalkbackOptions")%>：</td>
	<td>
	<span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOOpenTB value=null <%if((j1 & 0x8000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOOpenTB")%></span>
        <!--<span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOPerTB value=null <%if((j1 & 0x2000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOPerTB")%></span>-->

        <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowTalkback value=null <%if((j1 & 0x200L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowTalkback")%></span>

        <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOPublicTB value=null <%if((j1 & 0x4000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOPublicTB")%></span>

        <span><input  id="CHECKBOX" type="CHECKBOX" name="NodeOShowTalkbackAuditing"  value=null <%if((j1 & 0x10000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowTalkbackAuditing")%></span>		</td></tr>


      <tr>
        <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "IssueTime")%>：</td>
        <td><%=new tea.htmlx.TimeSelection("Issue", date_n)%></td>
      </tr>
    </table>
  </form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
