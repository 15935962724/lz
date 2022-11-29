<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.node.*"%><%!
StringBuffer sb[]=new StringBuffer[10];

public void select(int father,int language,int index)throws java.sql.SQLException
{
    sb[index].append("      case "+father+":\r\n");//      var obj"+index+"=document.getElementById('goodstype"+index+"');
    java.util.Enumeration enumer=GoodsType.findByFather(father);
    while(enumer.hasMoreElements())
    {
      GoodsType obj=(GoodsType)enumer.nextElement();
      int id=obj.getGoodstype();
      String name=obj.getName(language).replaceAll("\"","&quot;");
      int count=GoodsType.countByFather(id);
      if(count>0)
      {
        float len=0f;
        for(int j=0;j<name.length();j++)
        {
          char ch=name.charAt(j);
          if(ch=='/'||ch=='l'||ch=='L')
          {
            len++;
          }else
          if(ch>='A'&&ch<='Z')
          {
            len=len+2.4f;
          }else
          if(ch>='a'&&ch<='z'||ch>='0'&&ch<='9')
          {
            len=len+2.4f;
          }else
//          if(ch>255)
          {
            len=len+4;
          }
        }
        StringBuffer name_sb=new StringBuffer(name);
        for(int i=50-(int)len;i>0;i--)
        {
          name_sb.append(" ");
        }
        name_sb.append("»");//&#187;  ► &#9658;
        name=name_sb.toString();
      }
      sb[index].append("obj"+index+".options[obj"+index+".length]=new Option(\""+name+"\",\""+id+"\");");

      if(index<sb.length&&count>0)
      select(id,language,index+1);
    }
    sb[index].append("break;\r\n");
}
%><%request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


//Goods obj=Goods.find(teasession._nNode);
String nodetype =  teasession.getParameter("nodetype");
int root=GoodsType.getRootId(teasession._strCommunity);
int count=GoodsType.countByFather(root);
if(request.getMethod().equals("POST")||count<1)
{
  StringBuffer param=new StringBuffer("/jsp/type/goods/EditGoods.jsp?node=");
  param.append(teasession._nNode);
  param.append("&nodetype=").append(nodetype);
  param.append("&community=");
  param.append(teasession._strCommunity);
  param.append("&goodstype=/");
  param.append(root);
  param.append("/");
  for(int index=0;index<sb.length;index++)
  {
    String temp=teasession.getParameter("goodstype"+index);
    if(temp!=null)
    param.append(temp+"/");
    else
    break;
  }
  String newnode=teasession.getParameter("NewNode");
  if(newnode!=null)
  param.append("&NewNode="+newnode);

  String type=teasession.getParameter("Type");
  if(type!=null)
  param.append("&Type="+type);

  String typealias=teasession.getParameter("TypeAlias");
  if(typealias!=null)
  param.append("&TypeAlias="+typealias);

  String nexturl=teasession.getParameter("nexturl");
  if(nexturl!=null)
  param.append("&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));

  response.sendRedirect(param.toString());
  return;
}
tea.resource.Resource r=new tea.resource.Resource("/tea/resource/fun");





File file=new File(application.getRealPath("/res/"+teasession._strCommunity+"/cssjs/Cache_GoodsType.js"));
if(!file.exists())
{
  for(int i=0;i<sb.length;i++)
  {
    sb[i]=new StringBuffer();
  }
  select(root,teasession._nLanguage,0);

  PrintWriter fos=new PrintWriter(file,"UTF-8");
  fos.write("  function fchange(value,index)          ");
  fos.write("  {                                      ");
  fos.write("    for(var i=index;i<50;i++)            ");
  fos.write("    {                                    ");
  fos.write("      var obj=document.getElementById('goodstype'+i); ");
  fos.write("      while(obj&&obj.length>0)           ");
  fos.write("      {                                  ");
  fos.write("        obj.options[0]=null;             ");
  fos.write("      }                                  ");
  fos.write("    }                                    ");
  fos.write("    fun.submit.disabled=true;            ");
  fos.write("    switch(index)                        ");
  fos.write("    {                                    ");

  for(int index=0;index<sb.length;index++)
  {
    if(sb[index].length()>0)
    {
      fos.write(" case "+index+":               ");
      fos.write(" var obj"+index+"=document.getElementById('goodstype"+index+"');");
      fos.write(" if(obj"+index+")              ");
      fos.write(" switch(parseInt(value))       ");
      fos.write(" {                             ");
      fos.write(sb[index].toString());
      fos.write("   default:fun.submit.disabled=false;");
      fos.write(" }break;                       ");
    }else
    {
      fos.write(" default:fun.submit.disabled=false;");
      break;
    }
  }
  fos.write("}}");
  fos.write("function fonload()                                         ");
  fos.write("{                                                          ");
  for(int index=0;index<sb.length;index++)
  {
    if(sb[index].length()>0)
    {
      fos.write("  document.getElementById('goodstype"+index+"').style.display='';");
    }
  }
  fos.write("}                                                          ");
  fos.close();
}










%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT language="JavaScript">
function addsubmit()
{
  if((document.fun.oldname.value==document.fun.name.value))
  {
    alert("<%=r.getString(teasession._nLanguage, "CannotAddHomonymyManage")%>");
    return false;
  }
  return editsubmit();
}

function editsubmit()
{
  return submitText(fun.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitInteger(fun.sequence,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}

function deletesubmit()
{
  return (confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'));
}

function fedit(value)
{
  var values=value.split("/");
  for(var index=2;index<values.length;index++)
  {
    var obj=document.getElementById('goodstype'+(index-2));
    fchange(values[index],index-1);
    for(var i=0;obj&&i<obj.options.length;i++)
    {
      if(obj.options[i].value==values[index])
      {
        obj.options[i].selected=true;
        break;
      }
    }
  }
}

function fload()
{
  fonload();
  fchange(<%=root%>,0);
  <%
  String goodstype=teasession.getParameter("goodstype");
  if(goodstype!=null)
  out.println("fedit('"+goodstype+"');");
  %>
}
</SCRIPT>
<script src="/res/<%=teasession._strCommunity%>/cssjs/Cache_GoodsType.js"></script>
</head>
<body onLoad="fload();fun.goodstype0.focus();">
<h1><%=r.getString(teasession._nLanguage, "MenuManage")%></h1>
<div id="head6"><img height="6" alt=""></div>
<h2><%=r.getString(teasession._nLanguage, "ChoiceMenus")%></h2>


<form method="post" name="fun" id="fun" action="<%=request.getRequestURI()%>">

<%
String newnode=teasession.getParameter("NewNode");
if(newnode!=null)
out.println("<input type=hidden name=NewNode value="+newnode+" >");

String type=teasession.getParameter("Type");
if(type!=null)
out.println("<input type=hidden name=Type value="+type+" >");

String typealias=teasession.getParameter("TypeAlias");
if(typealias!=null)
out.println("<input type=hidden name=TypeAlias value="+typealias+" >");

String nexturl=teasession.getParameter("nexturl");
if(nexturl!=null)
out.println("<input type=hidden name=nexturl value="+nexturl+" >");

%>
<input type="hidden" name="nodetype" value="<%=nodetype%>"/>
<input type="hidden" name="root" value="<%=root%>">
<INPUT  type="hidden" name="Node" value="<%=teasession._nNode%>">
<INPUT  type="hidden" name="community" value="<%=teasession._strCommunity%>">
<TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
  <%--
  if(obj.getGoodstype()!=null)
  {
    String separator[]=obj.getGoodstype().split("#");
    for(int index=0;index<separator.length;index++)
    {
      out.print("<tr>");
      String goodstype[]=separator[index].split("/");
      for(int i=1;i<goodstype.length;i++)
      {
        GoodsType gt=GoodsType.find(Integer.parseInt(goodstype[i]));
        out.print("<td>"+gt.getName(teasession._nLanguage)+"</td>");
      }
      String value=obj.getGoodstype().replaceFirst(separator[index]+"#","");
      out.print("<td><input type=button onclick=\"fun.goodstype.value='"+value+"';fedit('"+separator[index]+"');\" value="+r.getString(teasession._nLanguage,"CBEdit")+" ><input name=delete onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){fun.goodstype.value='"+value+"';return true;}else return false;\" type=submit value="+r.getString(teasession._nLanguage,"CBDelete")+" ></td>");
      out.print("</tr>");
    }
  }
  --%>


    <TR>
    <%
    for(int index=0;index<sb.length;index++)
    {
      out.print("<TD><select style=\"display:none\" name=goodstype"+index+" id=goodstype"+index+" size=15 style=width:180px onchange=\"fchange(this.value,"+(index+1)+");\"></select></TD>");
      //out.print("<TD><div style=\"display:none\" name=goodstype"+index+" id=goodstype"+index+" style=\"width:180px;height:220px;\" ></div></TD>"); //onchange=\"fchange(this.value,"+(index+1)+")\">
    }

    %>
    </TR>

    <TR>
      <TD height="40" colspan="4"   align="center">
        <INPUT id="submit" disabled="disabled" type="submit" onClick="" value="<%=r.getString(teasession._nLanguage, "Submit")%>" name="submit">

        <INPUT type="button" onClick="history.back();" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" name="Submit1">
        </td>
    </TR>
  </TABLE>

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
