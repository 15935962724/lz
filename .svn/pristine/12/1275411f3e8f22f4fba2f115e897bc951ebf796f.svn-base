<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.db.DbAdapter"%><%@page import="tea.entity.admin.*"%><%@page import="tea.ui.*"%><%!

public String write(String community,byte by[],String ex)
{
  ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
  java.io.File f = new java.io.File(getServletContext().getRealPath("/tea/image/type/" + community + "/"));
  if (!f.exists())
  {
    f.mkdirs();
  }
  try
  {
    f = java.io.File.createTempFile("000", ex, f);
    bytestream.write(by);
    OutputStream file = new FileOutputStream(f);
    bytestream.writeTo(file);
    file.close();
    bytestream.close();
    return "/tea/image/type/" + community + "/" + f.getName();
  } catch (Exception e)
  {
    e.printStackTrace();
  }
  return null;
}

int index=0;
StringBuffer sb=new StringBuffer();
public void outputToJava(java.io.Writer jw,int father,int language,int step,String community)throws Exception
{
  Enumeration enumeration = GoodsType.findByFather(father);
  if(enumeration.hasMoreElements())
  {
    index++;
    jw.write("}");
    jw.write("private int id_"+index+";");
    sb.append("auto_"+index+"();");
    jw.write("private static void auto_"+index+"()");
    jw.write("{");
    while(enumeration.hasMoreElements())
    {
      int j = ((Integer)enumeration.nextElement()).intValue();
      GoodsType obj = GoodsType.find(j);
      jw.write("id_"+index+" = create(id_"+step+",0,community,"+language+",\""+obj.getName(language)+"\",\""+ obj.getPicture(language)+"\");");
      outputToJava(jw,j,language,index,community);
    }
  }
}
%>
<%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Goods");

String community=teasession.getParameter("community");
int strid=Integer.parseInt(teasession.getParameter("goodstype"));
GoodsType af_obj=GoodsType.find(strid);

if(request.getMethod().equals("POST"))
{
  if(teasession.getParameter("output")!=null)
  {
    outputToJava(out,GoodsType.getRootId(community),teasession._nLanguage,0,community);
    out.println(sb.toString());
  }else if(teasession.getParameter("js")!=null)
  {
    GoodsType.toJavascript(community,teasession._nLanguage);
  }else
  {
    String name=teasession.getParameter("name");
    int typeState = 0;
    if(teasession.getParameter("typeState")!=null && teasession.getParameter("typeState").length()>0)
        typeState  = Integer.parseInt(teasession.getParameter("typeState"));
    int sequence=Integer.parseInt(teasession.getParameter("sequence"));
    String picture;
    if(teasession.getParameter("clear")==null)
    picture=null;
    else
    {
      byte by[]=teasession.getBytesParameter("picture");
      if(by!=null)
      {
        picture=write(community,by,".gif");
      }else
      {
        picture=af_obj.getPicture(teasession._nLanguage);
      }
    }
    if(teasession.getParameter("Submit1")!=null)//添加兄弟
    strid=GoodsType.create(af_obj.getFather(),sequence,community,teasession._nLanguage,name,picture,typeState);
    else
    if(teasession.getParameter("Submit2")!=null)//添加子
    strid=GoodsType.create(strid,sequence,community,teasession._nLanguage,name,picture,typeState);
    else
    if(teasession.getParameter("Submit3")!=null)//修改
    af_obj.set(sequence,teasession._nLanguage,name,picture,typeState);

    else
    if(teasession.getParameter("Submit4")!=null)//删除
    {
      DbAdapter db=new DbAdapter();
      try
      {  
        int count=db.getInt(" select count(*) from Node where community="+DbAdapter.cite(teasession._strCommunity)+" and node in (select node from Goods where goodstype like '%/"+strid+"/%')");
        if(count>0)
        { //不能被删除,请先删除依赖在本类别上的商品.
          response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1170753991906"),"UTF-8"));
          return;
        }
      }finally
      {
        db.close();
      }
      af_obj.delete();
      strid=af_obj.getFather();
    }
    //删除缓存
    new java.io.File(application.getRealPath("/res/"+community+"/cssjs/Cache_GoodsType.js")).delete();

    out.print("<script>window.open('?node="+teasession._nNode+"&community="+community+"&goodstype="+strid+"','_self');      window.open('/jsp/type/goods/GoodsTypeList.jsp?node="+teasession._nNode+"&community="+community+"&goodstype="+strid+"','function_funlist');</script>");
  }
  return;
}

r.add("/tea/ui/member/community/EditCommunity");

String picture=af_obj.getPicture(teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function addsubmit()
{
  if((document.fun.oldname.value==document.fun.name.value))
  {
    alert("<%=r.getString(teasession._nLanguage, "Goods.cannotaddhomonymytype")%>");
    return false;
  }
  return editsubmit();
}
function editsubmit()
{
   //return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sequence,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
   if(fun.name.value=='')
   {
     alert('<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
     return false;
   }
    if(fun.sequence.value=='')
    {
     alert('<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
     return false;
   }
}
function deletesubmit()
{
  return (confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));
}
</SCRIPT>
</head>
<body onLoad="fun.name.focus();">
<h1><%=r.getString(teasession._nLanguage, "Goods.typemanage")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="fun" method="post" enctype="multipart/form-data" id="fun" action="<%=request.getRequestURI()%>">
<INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
<INPUT type="hidden" name="community" value="<%=community%>">
<INPUT type="hidden" name="goodstype" value="<%=strid%>">

<TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "Goods.cannotaddhomonymytype")%>：</TD>
    <TD><%//strid%><%=af_obj.getName(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "Name")%>：</TD>
    <TD>
      <INPUT id="oldname" type="hidden" name="oldname" value="<%=af_obj.getName(teasession._nLanguage)%>">
        <INPUT id="name" type="text" name="name" size="40" maxlength="50" value="<%=af_obj.getName(teasession._nLanguage)%>">
    </TD>
  </TR>
 <TR>
   <TD><%=r.getString(teasession._nLanguage,"类型")%>:</TD>
   <TD><INPUT id="sequence" type="text" name="typeState" value="<%=af_obj.getTypeState()%>" onkeypress="inputInteger();"></TD>
 </TR>
<%//if(GoodsType.findTypeState(af_obj.getGoodstype())!=null){out.print(GoodsType.findTypeState(af_obj.getGoodstype()));}%>

<TR>
  <TD><%=r.getString(teasession._nLanguage, "Sequence")%>：</TD>
  <TD><INPUT id="sequence" type="text" name="sequence" value="<%=af_obj.getSequence()%>">
  </TD>
</TR>
<TR>
  <TD><%=r.getString(teasession._nLanguage, "File")%>：</TD>
  <TD>
    <input type="file" name="picture" />
    <%
    if(picture!=null)
    {
      long lo=new java.io.File(application.getRealPath(picture)).length();
      if(lo>0)
      {
        out.print("<a href="+picture+" target=_blank>"+lo+r.getString(teasession._nLanguage,"Bytes")+"</a>");
        out.print("<input type=checkbox name=clear onClick=fun.picture.disabled=this.checked;>"+r.getString(teasession._nLanguage, "Clear"));
      }
    }
    %>
  </TD>
</TR>

<TR>
  <TD height="40" colspan="4" align="center" >
    <INPUT id="Submit1" type="submit" onClick="return addsubmit();" value="<%=r.getString(teasession._nLanguage, "Goods.addmate")%>" name="Submit1">
    <INPUT id="Submit2" type="submit" onClick="return addsubmit();" value="<%=r.getString(teasession._nLanguage, "Goods.addsub")%>" name="Submit2">
    <INPUT id="Submit3" type="submit" onClick="return editsubmit();" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" name="Submit3">
    <%
    if(strid!=GoodsType.getRootId(community))
    out.print("<INPUT type=submit onClick=\"return deletesubmit();\" value="+r.getString(teasession._nLanguage, "CBDelete")+" name=Submit4 >");
    %>
    </TD>
  </TR>
</TABLE>

<!-- <input type="submit" value="导出" name="output"/>-->
<!--
<input type="submit" value="生成CACHE" name="js"/>
-->

</form>
<input type="button" onClick="window.open('/jsp/community/EditAttribute.jsp?node=<%=teasession._nNode%>&community=<%=community%>&goodstype=<%=strid%>','_self');" value="<%=r.getString(teasession._nLanguage, "AttributeManage")%>" />
<input type="button" onClick="window.open('/jsp/type/goods/SetGoodsTypeBrand.jsp?node=<%=teasession._nNode%>&community=<%=community%>&goodstype=<%=strid%>','_self');" value="品牌" />
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
