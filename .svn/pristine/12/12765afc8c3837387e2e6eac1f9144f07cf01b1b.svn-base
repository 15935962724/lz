<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}

%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource();
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

  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(2))
  {
    response.sendError(403);
    return;
  }


  int is =1;


  String s2="",url="",text="",picture="",file="";
  long j1 =node.getOptions();
  int l3=0;
  int root = 0;
  int len_pic = 0;
  if(!isNew){
    s2 = HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
    text =  HtmlElement.htmlToText(node.getText(teasession._nLanguage));
    root=node.getRoot();
    is= node.getOptions1();
    tea.entity.node.Page pagec = tea.entity.node.Page.find(teasession._nNode);
    url= pagec.getRedirectUrl(teasession._nLanguage);
    picture=node.getPicture(teasession._nLanguage);
    if(picture!=null&&picture.length()>0)
    {
      int k=picture.lastIndexOf('#');
      if(k!=-1)picture=picture.substring(0,k);
      len_pic=(int)new File(application.getRealPath(picture)).length();
    }
    file=node.getFile(teasession._nLanguage);


    if(file!=null&&file.length()>0)
    {
      l3=(int)new File(application.getRealPath(file)).length();
    }
  }


  if(root==0)
  root=teasession._nNode;
  String nexturlparameter=teasession.getParameter("nexturl");
  boolean nexturlbool=(nexturlparameter!=null&&!nexturlparameter.equals("null"));
  %>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/mt.upload.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "Edit")%><%=r.getString(teasession._nLanguage, "Pages")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<FORM name=form1 METHOD=POST action="/servlet/EditPage?repository=node" enctype="multipart/form-data" onSubmit="if(mt.check(this)){mt.show(null,0);up.complete();}return false;">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="Type" value="<%=j%>">
<input type='hidden' name="watermark" value="false"/>
<input type="hidden" name="isHidden" value="1"/>
<input type='hidden' name="act" />
<%
if(nexturlbool)
{
  out.print("<input type='hidden' name=nexturl value="+nexturlparameter+">");
}
  if(isNew){
    out.print("<input type='hidden' name=NewNode value=ON >");
  }

%>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=subject value="<%=(s2)%>" alt="<%=r.getString(teasession._nLanguage,"Subject")%>" size=70 maxlength=255></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Options")%>:</TD>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=PageOLink value=null <%=getCheck((is & 1) != 0)%>>
          <%=r.getString(teasession._nLanguage, "PageOLink")%></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "RedirectUrl")%>:</TD>
        <td><input  name=RedirectUrl type="TEXT" class="edit_input" VALUE="<%if(url!=null)out.print(url);%>" size="50"></td>
      </tr>
       <tr>
        <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
        <td COLSPAN=6><input TYPE=FILE NAME=Picture class="edit_input" >
          <%
          if(len_pic > 0)
          {
            out.print("<a href="+picture+" target=_blank>"+len_pic + r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input id='CHECKBOX' type='checkbox' name='ClearPicture' onClick='form1.Picture.disabled=this.checked;'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
          </td>
      </tr>


  <tr>
    <td><%=r.getString(teasession._nLanguage, "附件")%>:</td>
    <td colspan=6><input type="hidden" name="file" value="<%=node.getFile(teasession._nLanguage)%>"/><div id="t_member" style="width:400px"><%=Attch.f(node.getFile(teasession._nLanguage))%></div><input id="_attach" type="button" value="添加附件"/>
    <%if(new File(application.getRealPath("/res/"+teasession._strCommunity+"/ftp/")).exists())out.print("<input type='button' value='选择附件' onclick=mt.show('/jsp/community/AttchSel.jsp?community="+teasession._strCommunity+"&repository=ftp',2,null,550) />");%>
  </tr>
      <%-- <tr><td><%=r.getString(teasession._nLanguage, "File")%>：</td>
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

       --%>
      <tr>
        <td> </td>
        <td>
          <input id="radio" type="radio" name=TextOrHtml value=0 <%if((j1 & 0x40) == 0)out.print(" checked");%>><%=r.getString(teasession._nLanguage, "TEXT")%>
          <input id="radio" type="radio" name=TextOrHtml value=1 <%if((j1 & 0x40) != 0)out.print(" checked");%> >HTML
          <input type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
          <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
        </td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
        <td>
          <textarea name="content" rows="12" cols="90" class="edit_input"><%=text%></textarea>
          <script>if(mt.isIE6||location.hostname=='www.mzb.com.cn')document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=s1%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
        </td>
      </tr>

    </table>

    <input type="submit" name="back" id="edit_GoBack" onclick="form1.act.value=name" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=SUBMIT name="finish" ID="edit_GoFinish" onclick="form1.act.value=name" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </form>
<script>
var up=new Upload($$('_attach'),{resize:1000,fileTypes:"*.doc;*.docx;*.xls;*.xlsx;*.txt;*.pdf;*.jpg;*.gif;*.png;*.zip;*.rar;*.ppt"});
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
mt.receive=function(v,n,h)
{
  form1.file.value+=v.substring(1);
  $$('t_member').innerHTML+=h;
};
</script>
   <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

