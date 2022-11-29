<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%!


String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}

%>
<%

TeaSession teasession = new TeaSession(request);
Resource r = new Resource();

boolean _bNew=request.getParameter("NewNode")!=null;
r.add("/tea/resource/Company");


   String act = teasession.getParameter("act");

   int role = 0;
   if(teasession.getParameter("role")!=null && teasession.getParameter("role").length()>0)
   {
      role = Integer.parseInt(teasession.getParameter("role"));
   }

teasession._nNode = Node.getNC(teasession._strCommunity,teasession._rv.toString());


String community = teasession.getParameter("community");
 String nexturl = request.getRequestURI()+"?community="+community+request.getContextPath();//teasession.getParameter("nexturl");

int father = 8739;
//StringBuffer sql=new StringBuffer();
//
//if(teasession.getParameter("father")!=null && teasession.getParameter("father").length()>0){
//  father  = Integer.parseInt(teasession.getParameter("father"));
//  teasession._nNode=father;
//  sql.append(" and n.father =").append(father);
//}else{
//   teasession._nNode=father;
//  sql.append(" and n.father =").append(father);
//}

int father1 = 0,father2=0;
int last = 0;
StringBuffer f1=new StringBuffer();
StringBuffer f2=new StringBuffer();
DbAdapter db = new DbAdapter();
try
{  //"+Community.find(teasession._strCommunity).getNode()+"
  db.executeQuery("SELECT node FROM Node WHERE path LIKE '/"+Community.find(teasession._strCommunity).getNode()+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
  // out.print("SELECT node FROM Node WHERE path LIKE '/"+Community.find(teasession._strCommunity).getNode()+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
  while(db.next())
  {

    int nid = db.getInt(1);
    Node nodeobj=Node.find(nid);
    int fid=nodeobj.getFather();
    String ns=nodeobj.getSubject(teasession._nLanguage);
    if(last!=fid)
    {
      last=fid;
      if(Node.find(fid).getSubject(teasession._nLanguage)!=null && Node.find(fid).getSubject(teasession._nLanguage).length()>0){
        f1.append("<option value='"+fid+"'");
        if(nid==father)//Node.find(father).getFather()
        {
          f1.append(" selected='true'");
        }
        f1.append(">").append(Node.find(fid).getSubject(teasession._nLanguage));
      }

      f2.append("break;\r\n");
      f2.append("case ").append(fid).append(":");
    }
    f2.append("op[op.length]=new Option(\""+nodeobj.getSubject(teasession._nLanguage)+"\","+nid+");");
  }
}finally
{
  db.close();
}

  Node node=Node.find(teasession._nNode);
Company obj;
String name;
String text;
String license=null,logo=null,picture=null;
int sequence;
int len=0,logolen=0,picturelen=0;

if(_bNew)
{
  obj = Company.find(0);
  name="";
  text="";
  sequence= Node.getMaxSequence(teasession._nNode) + 10;
}else
{

  obj=Company.find(teasession._nNode);
  name=node.getSubject(teasession._nLanguage);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));

  license=obj.getLicense(teasession._nLanguage);
  if(license!=null)
  len=(int)new File(application.getRealPath(license)).length();

  logo=obj.getLogo(teasession._nLanguage);
  if(logo!=null)
  logolen=(int)new File(application.getRealPath(logo)).length();

  picture=obj.getPicture(teasession._nLanguage);
  if(picture!=null)
  picturelen=(int)new File(application.getRealPath(picture)).length();
  sequence=node.getSequence();
}

%><HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<script type="">
function f_edit()
{
   if(form1.Node.value==0)
   {
     alert("请选择类型！");
     return false
   }
  if(form1.Name.value=='')
  {
    alert("请填写单位名称！");
    return false;
  }
   checkPic(form1);



 if(form1.Contact.value=='')
 {
   alert("请填写联系人!");
   return false;
 }
  if(form1.Email.value=='')
 {
   alert("请填写电子信箱!");
   return false;
 }

 if(form1.Telephone.value=='')
 {
   alert("请填写电话!");
   return false;
 }
  if(form1.Address.value=='')
 {
   alert("请填写地址!");
   return false;
 }

}
function checkPic(picForm){
  var location=picForm.logo.value;
if(<%=logolen%>>0){
    location ='<%=logo%>';
}

if(location.length!=0){
  var point = location.lastIndexOf(".");
  var type = location.substr(point);
  if(type==".jpg"||type==".gif"||type==".JPG"||type==".GIF"){
        } else{
          alert("只能输入jpg或者gif格式的图片");
          return false;
        }
      }else
      {
        alert("请上传logo!");
        return false;
      }
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>

<div id="head6" style="clear:both;"><img height="6" src="about:blank"></div>
<div  id="pathdiv" style="clear:both;"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM  enctype="multipart/form-data"  name=form1 METHOD=POST action="/servlet/EditSimpleCompany" onSubmit="return f_edit(this);">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");

if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
%>
    <tr>
      <td>*&nbsp;<%=r.getString(teasession._nLanguage, "Type")%>:</td>
       <td>
            <select name="father1" onchange="f_ch()">
              <option value="0">------</option>
              <%=f1.toString()%>
            </select>
            <select name="Node" >
              <option value="0">------</option>
            </select>
            <script type="">
            function f_ch()
            {
              var op=form1.Node.options;
              while(op.length>1)
              {
                op[1]=null;
              }
              switch(parseInt(form1.father1.value))
              {
                case 0:
                <%=f2.toString()%>
                break;
              }
            }
            f_ch();
            form1.Node.value="<%=father2%>";
            </script>
          </td>
    </tr>

<%
}else{
  out.print("<input type=hidden name=Node value="+teasession._nNode+">");
}

%>  <tr >
      <td >*&nbsp;单位名称:</td>
      <td colspan="2"><input type="TEXT" class="edit_input"  name="Name" size="40" MAXLENGTH="255" VALUE="<%=(name)%>"></td>
    </tr>
    <tr>
      <td>*&nbsp;logo:</td>
      <td colspan="2">
        <input type=file  name=logo >
          <%
          if(logolen>0)
          {
            out.print("<a href="+logo+" target=_blank>"+logolen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input type=checkbox name=logoClear onclick='form1.logo.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>(图片格式：.jpg和.gif)
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td colspan="2">
         <input type=file  name=picture onChange="changesrc(this)">
          <%
          if(picturelen>0)
          {
            out.print("<a href="+picture+" target=_blank>"+picturelen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input type=checkbox name=pictureClear onclick='form1.picture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "上级单位")%>:</td>
      <td colspan="2"><select name="superior">
          <option value=0 >--------------</option>
          <%
          java.util.Enumeration enumer=Node.findByType(21,community);
          int nodecode;
          while(enumer.hasMoreElements())
          {
                nodecode=((Integer)enumer.nextElement()).intValue();
                if( nodecode!=teasession._nNode)
                {
                    out.print("<option ");
                    if(nodecode==obj.getSuperior(teasession._nLanguage))
                    out.print("SELECTED ");
                    out.print("value="+nodecode+">"+tea.entity.node.Node.find(nodecode).getSubject(teasession._nLanguage));
                }
           }

           %>
        </select></td>
    </tr>
          <tr>
        <td><%=r.getString(teasession._nLanguage, "公司简介")%>:</td>
        <td>
          <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%=text%></textarea>
          <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=community%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
        </td>
      </tr>

    <tr>
      <td>*&nbsp;<%=r.getString(teasession._nLanguage, "Contact")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Contact VALUE="<%=getNull(obj.getContact(teasession._nLanguage))%>">
    </tr>

    <tr>
      <td>*&nbsp;<%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=getNull(obj.getEmail(teasession._nLanguage))%>"></td>
    </tr>
      <tr>
      <td>*&nbsp;<%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(obj.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(obj.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
      <tr>
      <td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
      <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(obj.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
       <tr>
      <td><%=r.getString(teasession._nLanguage, "省份")%>:</td>
      <td><script>selectcard('State','City',null,'<%=obj.getCity(teasession._nLanguage)%>');</script></td>
    </tr>
    <tr>
      <td>*&nbsp;<%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td colspan="2"><TEXTAREA name=Address  class="edit_input" ROWS=1 COLS=42><%=HtmlElement.htmlToText(getNull(obj.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
    </tr>




    <tr>
      <td><%=r.getString(teasession._nLanguage, "公司网址")%>:</td>
      <td colspan="2"><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=getNull(obj.getWebPage(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
    </tr>


  </table>
    <%--<input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">--%>
     <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
