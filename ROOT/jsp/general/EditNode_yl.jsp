<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
TeaSession teasession=new TeaSession(request);

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
String s4 = "",description="";
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
String picture=null,voice=null,file="|",mmspath=null,accessmembersnode="";
if(!isNew)//
{
  l1 = node.getSequence();
  date = node.getStartTime();
  date2 = node.getStopTime();
  date_n=node.getTime();
  s2 = HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  s4 = node.getKeywords(teasession._nLanguage);
  description=node.getDescription(teasession._nLanguage);
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
  accessmembersnode=node.getAccessmembersnode();
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

Http h=new Http(request,response);
%>
<html>
<head>
<title><%=title%></title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=s1%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditNode" enctype="multipart/form-data" onSubmit="mt.storage(this,true);if(mt.check(this)){mt.show(null,0);up.complete();}return false;">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="Type" value="<%=j%>">
<input type="hidden" name="repository" value="node"/>
<input type="hidden" name="isHidden" value="1"/>
<input type="hidden" name="resize" value="500"/>
<%
if(nexturlbool)
out.print("<input type='hidden' name=nexturl value="+nexturlparameter+">");
if(isNew)
out.print("<input type='hidden' name=NewNode value=ON >");

%>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr class="SubjectTr">
        <td width="126"><%=r.getString(teasession._nLanguage, "Subject")%></td>
        <td><input type="TEXT" class="edit_input"  name=Subject value="<%=s2%>" alt="主题" size=70 maxlength=255></td>
      </tr>
      <tr>
        <td></td>
        <td> <input type="hidden" name="GoNext" disabled="disabled" />
            <%-- <input type=SUBMIT name="GoNext1"  onclick="javascript:form1.GoNext.disabled=false;"  id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>"> --%>
             <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
        </td>
      </tr>
    </table>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr class="RedirectUrlTr">
        <td nowrap width="126"><%=r.getString(teasession._nLanguage, "RedirectUrl")%>：</td>
        <td><input type="TEXT" name="clickurl" value="<%=MT.f(clickurl)%>" size="70" maxlength="255">
        </td>
      </tr>
      <tr class="KeywordsTr">
        <td nowrap width="126"><%=r.getString(teasession._nLanguage, "Keywords")%>：</td>
        <td><input type="TEXT" class="edit_input"  name="Keywords" value="<%=s4%>" size="70" maxlength="255">
      </td>
      </tr>
     <tr class="KeywordBoundTr">
        <td nowrap width="126"><%=r.getString(teasession._nLanguage, "KeywordBound")%>：</td>
        <td>
         <input  id="radio" type="radio" name="kstyle" VALUE=0  checked="checked">  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[0])%>
           <input  id="radio" type="radio" name="kstyle" VALUE=1 <%if(kstyle==1)out.print("checked");%>>  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[1])%>
              <input  id="radio" type="radio" name="kstyle" VALUE=2  <%if(kstyle==2)out.print("checked");%> >  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[2])%>
                <input  id="radio" type="radio" name="kstyle" VALUE=3 <%if(kstyle==3)out.print("checked");%> ><%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[3])%><input type="text" name="kroot" size="5" value="<%=kroot%>"/>
        </td>
      </tr>
      <tr class="DescriptionTr">
        <td nowrap width="126"><%=r.getString(teasession._nLanguage, "Description")%>：</td>
        <td><textarea name="description" cols="60" rows="5"><%=MT.f(description)%></textarea>
      </td>
      </tr>
      <tr class="TextTr">
        <td nowrap width="126"><%=r.getString(teasession._nLanguage, "Text")%>：</td>
        <td>
          <!--
          <input id="radio" type="radio" name=TextOrHtml value=0 <%if((j1 & 0x40) == 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "TEXT")%>
          <input id="radio" type="radio" name=TextOrHtml value=1 <%if((j1 & 0x40) != 0)out.print(" checked");%> >HTML
          -->
          <input type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
          <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
        </td>
      </tr>
      <tr class="ckeditor11Tr">
        <td colspan="2">
          <textarea name="content" rows="12" cols="90" class="ckeditor11"><%=text%></textarea>
          <script>if(mt.isIE6||location.hostname=='www.mzb.com.cn')document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=s1%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");</script>
          <br/><a href="javascript:mt.storage(form1,true)">保存数据</a> <a href="javascript:mt.storage(form1,false)">恢复数据</a>
        </td>
      </tr>
      <tr class="ContentBoundTr"><td><%=r.getString(teasession._nLanguage, "ContentBound")%>：</td>
        <td>
         <input  id="radio" type="radio" name="Style" VALUE=0  checked="checked">  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[0])%>
           <input  id="radio" type="radio" name="Style" VALUE=1 <%if(style==1)out.print("checked");%>>  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[1])%>
              <input  id="radio" type="radio" name="Style" VALUE=2  <%if(style==2)out.print("checked");%> >  <%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[2])%>
                <input  id="radio" type="radio" name="Style" VALUE=3 <%if(style==3)out.print("checked");%> ><%=r.getString(teasession._nLanguage,tea.entity.node.Node.APPLY_STYLE[3])%><input type="text" name="Root" size="5" value="<%=root%>"/>
        </td>
      </tr>
      <tr class="DefaultLanguageTr">
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
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class='nones'>
      <tr class="FrameTemplateTr"><td><%=r.getString(teasession._nLanguage, "FrameTemplate")%>：</td><td>
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
      <tr class="StyleTemplateTr"><td><%=r.getString(teasession._nLanguage, "StyleTemplate")%>：</td><td>
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
            dbadapter.executeQuery("SELECT CssJs.cssjs FROM CssJs,CssJsHide WHERE CssJsHide.cssjs=CssJs.cssjs AND  CssJsHide.node=CssJs.node AND CssJs.node="+temp_obj.getNode()+" AND style<3 AND hiden=0");
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
      <tr class="SequenceTr">
        <td><%=r.getString(teasession._nLanguage, "Sequence")%>：</td>
        <td><input class="edit_input" name="Sequence" value="<%=l1%>" mask="int" alt="顺序"></td>
      </tr>
      <tr class="FileTr">
        <td><%=r.getString(teasession._nLanguage, "File")%>：</td>
        <td colspan=6><input type="hidden" name="file" value="<%=node.getFile(teasession._nLanguage)%>"/><div id="t_member" style="width:400px"><%=Attch.f(node.getFile(teasession._nLanguage))%></div><input id="_attach" type="button" value="添加附件"/></td>
      </tr>
      <tr class="VoiceTr">
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
      <tr class="PictureTr">
        <td><%=r.getString(teasession._nLanguage, "Picture")%>：</td>
        <td COLSPAN=6><input TYPE=FILE NAME=Picture class="edit_input" >
          <%
          if(len_pic > 0)
          {
            out.print("<a href="+picture+" target=_blank style=cursor:pointer>查看原图&nbsp;("+len_pic + r.getString(teasession._nLanguage, "Bytes")+")</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearPicture' onClick='form1.Picture.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
          </td>
      </tr>
      <tr class="MmsTr">
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
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class='nones_2' style="display:block">
      <tr class="OptionsTr">
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
              <A href="/jsp/access/AccessMembers.jsp?node=<%=teasession._nNode%>"  target="_blank"><%=r.getString(teasession._nLanguage, "NodeOAccessMember")%></A>
              &nbsp;跳转节点：<input type="text" name ="accessmembersnode" value="<%if(accessmembersnode!=null)out.println(accessmembersnode);%>" size="4"/>(如果没有权限查看页面，则跳转到此节点上面)
              </span>


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
                  <tr class="CBAddToOptionsTr">
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

	  <tr class="TalkbackOptionsTr">
	<td><%=r.getString(teasession._nLanguage, "TalkbackOptions")%>：</td>
	<td>
	<span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOOpenTB value=null <%if((j1 & 0x8000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOOpenTB")%></span>
        <!--<span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOPerTB value=null <%if((j1 & 0x2000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOPerTB")%></span>-->

        <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOShowTalkback value=null <%if((j1 & 0x200L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowTalkback")%></span>

        <span><input  id="CHECKBOX" type="CHECKBOX" name=NodeOPublicTB value=null <%if((j1 & 0x4000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOPublicTB")%></span>

        <span><input  id="CHECKBOX" type="CHECKBOX" name="NodeOShowTalkbackAuditing"  value=null <%if((j1 & 0x10000000L) != 0)out.print(" checked");%> ><%=r.getString(teasession._nLanguage, "NodeOShowTalkbackAuditing")%></span>		</td></tr>


      <tr class="IssueTimeTr">
        <td nowrap="nowrap"><%=r.getString(teasession._nLanguage, "IssueTime")%>：</td>
        <td><%=new tea.htmlx.TimeSelection("Issue", date_n)%></td>
      </tr>
    </table>
  </form>

<script>
f_editor();
form1.Subject.focus();

function AccessMembers()
{
  if(form1.NodeOAccessMember.checked)
  {
    form1.NodeONeedLogin.checked=true;
  }
}

var up=new Upload($$('_attach'),{resize:1000,fileTypes:"*.doc;*.docx;*.xls;*.xlsx;*.txt;*.pdf;*.jpg;*.gif;*.png;*.zip;*.rar"});
up.fileQueued=function(f)
{
  var t=document.createElement('SPAN');
  t.id=f.id;
  t.data=this;
  t.innerHTML="<img src='/tea/image/ico/"+f.type.substring(1).toLowerCase()+".gif' class='ico' />"+f.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' />";
  this.but.previousSibling.appendChild(t);
};
up.uploadSuccess=function(file,d,responseReceived)
{
  var t=this.but.previousSibling.previousSibling;
  eval('d='+d.substring(d.indexOf('\n')+1));
  t.value+=d.value+'|';
};
up.complete=function()
{
  var file=up.getFile();
  if(file)
  {
    up.start();
    $$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB' + "　正在压缩中...";
    $$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
    return;
  }
  $$('dialog_content').innerHTML="数据提交中,请稍等...";
  form1.submit();
};
</script>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
