<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %>
<%@page import="tea.entity.site.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.netdisk.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/Dynamic").add("/tea/resource/FileCenter");
String community=teasession._strCommunity;
String nexturl=request.getParameter("nexturl");
int dynamic=Integer.parseInt(request.getParameter("dynamic"));
int dynamictype=Integer.parseInt(request.getParameter("dynamictype"));
String name="",content="",type="text",before="",after="",bindfc=null,width="",height="",columnafter=null;
int sequence=0,defaultvalue=0,filecenter=0,big=0,binding=0,father=0,quantity=1,column=1;
boolean sync=false,multi=false,show=true,need=false,qrc=false,dtfb=false,dtst=false,separate=false,export=false;
Dynamic d=Dynamic.find(dynamic);
if(dynamictype!=0)
{
  DynamicType dt=DynamicType.find(dynamictype);
  name=dt.getName(teasession._nLanguage);
  content=HtmlElement.htmlToText(dt.getContent(teasession._nLanguage));
  type=dt.getType();
  sequence=dt.getSequence();
  before=HtmlElement.htmlToText(dt.getBefore(teasession._nLanguage));
  after=HtmlElement.htmlToText(dt.getAfter(teasession._nLanguage));
  show=dt.isHidden();
  need=dt.isNeed();
  qrc=dt.isQrc();
  defaultvalue=dt.getDefaultvalue();
  filecenter=dt.getFilecenter();
  sync=dt.isSync();
  multi=dt.isMulti();
  binding=dt.getBinding();
  if(binding>0)
  {
    big=DynamicType.find(binding).getDynamic();
  }
  bindfc=d.getBindfc(dynamictype);
  //dtfb=d.getDtfb()==dynamictype;
  dtst=d.getDtst()==dynamictype;
  width=dt.getWidth();
  height=dt.getHeight();
  father=dt.getFather();
  quantity=dt.getQuantity();
  column=dt.getColumns();
  columnafter=dt.getColumnAfter();
  separate=dt.isSeparate();
  export=dt.isExport();
}else
{
  sequence=DynamicType.getMaxSequence(dynamic)+10;
}

out.print("<!-- http://"+request.getServerName()+"/jsp/community/EditDynamicType.jsp?dynamic="+dynamic+"&dynamictype="+dynamictype+" -->");


%><HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_folder(obj)
{
  if(!obj)return;
  var sp1=document.getElementById("sp1");
  if(obj.value=="0")
  {
    sp1.style.display="none";
  }else
  {
    sp1.style.display="";
  }
}
function f_type(obj)
{
  var v=obj.value;
  var upfile=v=="file"||v=="img"||v=="office";
  var tb1=document.getElementById("tb1");
  var tb2=document.getElementById("tb2");
  if(upfile)
  {
    form1.content.disabled=form1.defaultvalue.disabled=true;
    tb1.style.display="none";

    tb2.style.display="";
    form1.file1.disabled=false;
    if(form1.clear)
    {
      form1.clear.disabled=false;
    }
  }else
  {
    form1.content.disabled=form1.defaultvalue.disabled=false;
    tb1.style.display="";

    tb2.style.display="none";
    form1.file1.disabled=true;
    if(form1.clear)
    {
      form1.clear.disabled=true;
    }
  }
  form1.dtst.disabled=v!='date';
  var tb5=document.getElementById("tb5");
  if(v=="folder")
  {
    tb1.style.display=tb2.style.display=tb5.style.display="none";
    tb4.style.display="";
  }else
  {
    tb5.style.display="";
    tb4.style.display="none";
  }
}
function f_upload(obj)
{
  var name=obj.value;
  name=name.substring(name.lastIndexOf("\\")+1);
  var ex=name.substring(name.lastIndexOf(".")+1);
  obj.style.display="none";
  fileinfo.innerHTML+="<span><img src='/tea/image/netdisk/"+ex+".gif' width='16' height='16' align='absbottom'>"+name+"<a href='###' onclick=f_updel(this,'"+obj.name+"')><img src='/tea/image/public/del2.gif'></a>　</span>";
}
function f_updel(obj,f)
{
  if(confirm('确认删除?'))
  {
    obj.parentNode.style.display="none";
    obj=document.all(f);
    if(obj)
    {
      obj.disabled=true;
    }else
    {
      form1.filedel.value+=f+":";
    }
  }
}
function f_big(dv)
{
  var v=form1.big.value;
  var op=form1.binding.options;
  while(op.length>1)
  {
    op[1]=null;
  }
  if(v!="")
  {
    sendx("/servlet/Ajax?act=dynamictype_binding&language=<%=teasession._nLanguage%>&dynamic="+v,function(h)
    {
      eval(h);
      if(dv)
      {
        form1.binding.value=dv;
      }
    });
  }
}
function f_load()
{
  form1.name.focus();
  f_type(form1.type);
  f_folder(form1.folder);
  f_big(<%=binding%>);
}
</script>
</HEAD>

<body onload="f_load()">

<h1><%=r.getString(teasession._nLanguage, "AddAttribute")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" METHOD=POST action="/servlet/EditDynamicType" enctype="multipart/form-data" onsubmit="return submitText(this.name,'无效-名称.');" >
<input type='hidden' name="nexturl" value="<%=nexturl%>"/>
<input type='hidden' name="community" VALUE="<%=community%>"/>
<input type="hidden" name="repository" value="dynamic"/>
<input type='hidden' name="dynamic" VALUE="<%=dynamic%>">
<input type='hidden' name="dynamictype" VALUE="<%=dynamictype%>">
<input type='hidden' name="filedel" value=":">


<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
<%
Enumeration e=DynamicType.findByDynamic(dynamic,"folder");
if(e.hasMoreElements())
{
  out.print("<tr><td>上级</td><td><select name='folder' onchange='f_folder(this);'><option value='0'>---------------");
  while(e.hasMoreElements())
  {
    int dtid=((Integer)e.nextElement()).intValue();
    DynamicType dt=DynamicType.find(dtid);
    out.print("<option value="+dtid);
    if(father==dtid)
    {
      out.print(" selected='true'");
    }
    out.print(">"+dt.getName(teasession._nLanguage));
  }
  out.print("</select>");
}
%>
      <tr>
        <td>*<%=r.getString(teasession._nLanguage, "Name")%>:</td>
        <td><input name="name" value="<%=name%>" type="text" class="edit_input" size="40" ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
        <td><select name="type" onchange="f_type(this);">
        <%
        for(int i=0;i<DynamicType.INPUT_TYPE.length;i++)
        {
          out.print("<option value="+DynamicType.INPUT_TYPE[i]);
          if(DynamicType.INPUT_TYPE[i].equals(type))
          out.print(" SELECTED ");
          out.print(">"+r.getString(teasession._nLanguage, "input."+DynamicType.INPUT_TYPE[i]));
        }
        %></select>
        </td>
      </tr>
      <tbody id="tb1">
        <tr>
          <td><%=r.getString(teasession._nLanguage, "默认值")%>:</td>
          <td>
            <textarea name="content" cols="40" rows=""><%=content%></textarea>
            <select name="defaultvalue" onchange="f_onchange();">
            <%
            for(int i=0;i<DynamicType.DEFAULTVALUE_TYPE.length;i++)
            {
              out.print("<option value="+i);
              if(i==defaultvalue)
              out.print(" selected='' ");
              out.print(">"+DynamicType.DEFAULTVALUE_TYPE[i]);
            }
            %>
            </select>
          </td>
        </tr>
      </tbody>
      <tbody id="tb2" style="display:none">
      <tr><td>
          <input type="button" value="上传文件" style='position:absolute'/>
          <%
          for(int i=50;i>0;i--)
          {
            out.print("<input name='file"+i+"' type='file' style='position:absolute;width:10;cursor:hand;filter:alpha(opacity=0)' onchange='f_upload(this)'>");
          }
          %>
          <br>
        </td>
        <td>
          <%
          String ps[]=content.split(":");
          for(int i=0;i<ps.length;i++)
          {
            if(ps[i].length()>0)
            {
              File f=new File(application.getRealPath(ps[i]));
              int len=(int)f.length();
              String fname=f.getName();
              out.print("<span><a href='"+ps[i]+"' ><img src='/tea/image/netdisk/"+fname.substring(fname.lastIndexOf('.')+1)+".gif' width='16' height='16' align='absbottom'>"+fname+"</a><a href='###' onclick=\"f_updel(this,'"+ps[i]+"')\"><img src='/tea/image/public/del2.gif'></a>　</span>");
            }
          }
          %>
          <span id="fileinfo"></span></td>
      </tr>
      <tr>
        <td>归档:</td>
        <td><input type="text" name="filecenter" value="<%if(filecenter>0)out.print(filecenter);%>" size="5" mask="int"></td>
      </tr>
      <tr>
        <td nowrap="nowrap">附件选项:</td>
        <td>
          <input type="checkbox" name="sync" <%if(sync)out.print(" checked");%>>数据是否同步
          <input type="checkbox" name="multi" <%if(multi)out.print(" checked");%>>用户可上传多个
        </td>
      </tr>
      </tbody>
      <tbody id="tb4" style="display:none">
      <tr>
        <td>数量:</td><td><input type="text" name="quantity" mask="int" value="<%=quantity%>"></td>
      </tr>
      <tr>
        <td>列:</td><td><input type="text" name="column" mask="int" value="<%=column%>"></td>
      </tr>
      <tr>
        <td>列之间:</td><td><input type="text" name="columnafter" value="<%if(columnafter!=null)out.print(columnafter);%>"></td>
      </tr>
      </tbody>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "大小")%>:</td>
        <td>
          宽:<input name="width" value="<%=width%>" type="text" class="edit_input" size="20">
          高:<input name="height" value="<%=height%>" type="text" class="edit_input" size="20">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
        <td><input name="sequence" value="<%=sequence%>" type="text" class="edit_input" size="20" mask="int"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Before")%>:</td>
        <td><textarea name="before" cols="70" rows="6" class="edit_input"><%=before%></textarea>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "After")%>:</td>
        <td><textarea name="after" cols="70"  rows="6" class="edit_input"><%=after%></textarea>
        </td>
      </tr>
      <tbody id="tb5">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
        <td>
          <input name="show" <%if(show)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "Show")%>
          <input name="need" <%if(need)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "Need")%>
          <input name="qrc" <%if(qrc)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "QRCode")%>
          <!--事务名称-->
          <%--
          <input name="dtfb" <%if(dtfb)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "1218512944875")%>
          --%>
          <!--期限-->
          <input name="dtst" <%if(dtst)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "1218695400578")%>
          <span id="sp1" style="display:none"><input type="checkbox" name="separate" <%if(separate)out.print("checked");%>>区分会员</span>
          <input name="export" <%if(export)out.print("checked");%> id="checkbox" type="checkbox" class="edit_input"><%=r.getString(teasession._nLanguage, "导出")%>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "1218516903875")%>:</td>
        <td>
        <select name="big" onchange="f_big()">
        <option value="">-----------------</option>
        <%
        Enumeration e2 = Dynamic.findByCommunity(community,-1);
        while( e2.hasMoreElements())
        {
          int id = ((Integer)e2.nextElement()).intValue();
          if(id!=dynamictype)
          {
            out.print("<option value="+id);
            if(id==big)
            {
              out.print(" selected ");
            }
            out.print(">"+Dynamic.find(id).getName(teasession._nLanguage));
          }
        }
        %>
        </select>
        <select name="binding" onchange="trbt.style.display=value=='0'?'none':''">
          <option value="0">-----------------</option>
        </select>
        </td>
      </tr>
<%--
      <tr id="trbt" style="<%if(binding==0)out.print("display:none");%>">
        <td><%=r.getString(teasession._nLanguage, "1220348392453")%>:</td>
        <td><select name="bindtype">
        <%
        for(int i=0;i<DynamicType.BIND_TYPE.length;i++)
        {
          out.print("<option value="+i);
          if(i==bindtype)
          {
            out.print(" selected ");
          }
          out.print(">"+DynamicType.BIND_TYPE[i]);
        }
        %>
        </select>
        </td>
      </tr>
--%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "1218516903876")%>:</td>
        <td>
        <select name="bindfc">
        <%
        for(int i=0;i<FileCenter.FIELD_TYPE.length;i++)
        {
          String field=FileCenter.FIELD_TYPE[i].substring(11);
          out.print("<option value="+field);
          if(field.equals(bindfc))
          {
            out.print(" selected='' ");
          }
          out.print(">"+r.getString(teasession._nLanguage, FileCenter.FIELD_TYPE[i])+"</option>");
        }
        %>
        </select>
        </td>
      </tr>
      </tbody>
    </table>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back()">
    <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" class="edit_button" id="edit_submit" name="submit">
  </form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
