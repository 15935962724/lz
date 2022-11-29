<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %><%@page import="tea.html.*" %><%@ page import="tea.htmlx.Languages"%><%@ page import="tea.ui.TeaSession"%><%@ page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@ page import="tea.http.RequestHelper"%><%@ page import = "tea.resource.Resource" %><%@ page import = "tea.entity.node.Sms" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="java.io.*" %><%@page import="tea.db.*"%><%@page import="tea.entity.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r = new Resource();

String nexturl=request.getParameter("nexturl");

int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  teasession._nNode=Integer.parseInt(teasession.getParameter("nodes"));
}


Node node=Node.find(teasession._nNode);
//out.print(teasession._nNode);

String subject =null,website=null,content=null;
String picpath=null,picname=null;
int newstype =0,father=teasession._nNode,industrytype2=0,city=0,term=0,maplen=0;
if(node.getType()>1)
{
  Supply sobj = Supply.find(teasession._nNode);
  subject = sobj.getSubject();
  newstype = sobj.getNewstype();
  father =node.getFather(); //sobj.getIndustrytype1();
  industrytype2= sobj.getIndustrytype2();
  city = sobj.getCity();
  term = sobj.getTerm();
  website = sobj.getWebsite();
  content = sobj.getContent();
  picname=sobj.getPicname();
  picpath=sobj.getPicpath();
  if(picpath!=null)
  {
    maplen=(int)new java.io.File(application.getRealPath(picpath)).length();
  }
}


int last=0;
StringBuffer f1=new StringBuffer();
StringBuffer f2=new StringBuffer();
DbAdapter db = new DbAdapter();
try
{
  db.executeQuery("SELECT node FROM Node WHERE path LIKE '/"+Community.find(teasession._strCommunity).getNode()+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=32) ORDER BY father");
 // out.print("SELECT node FROM Node WHERE path LIKE '/"+Community.find(teasession._strCommunity).getNode()+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=32) ORDER BY father");
  while(db.next())
  {
    int nid = db.getInt(1);
    Node n=Node.find(nid);
    int fid=n.getFather();
    String ns=n.getSubject(teasession._nLanguage);
    if(last!=fid)
    {
      last=fid;
      f1.append("<option value='"+fid+"'");
      System.out.println(nid+"---"+father);
      if(nid==father)//Node.find(father).getFather()
      {
        f1.append(" selected='true'");
      }
      f1.append(">").append(Node.find(fid).getSubject(teasession._nLanguage));
      f2.append("break;\r\n");
      f2.append("case ").append(fid).append(":");
    }
    f2.append("op[op.length]=new Option(\""+n.getSubject(teasession._nLanguage)+"\","+nid+");");
  }
}finally
{
  db.close();
}


%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
<script type="">
function CheckForm()
{
  if(form1.subject.value=='')
  {
    alert("标题不能为空!");
    return false;
  }
  if(form1.father.value==0)
  {
    alert("所属行业不能为空!");
    return false;
  }
  if(form1.city.value==0)
  {
    alert("所属地区不能为空!");
    return false;
  }
}
</script>
  <h1><span id="a1youb">供应信息添加</span>  <span id="a1zuob"><input type=button value="已发布的信息" onClick="window.open('<%=nexturl%>','_self');"></span></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


    <FORM name=form1 METHOD=POST action="/servlet/EditSupplys"  enctype="multipart/form-data" onSubmit="return CheckForm();">
     <input type="hidden" name="act" value="EditSupply"/>
     <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
     <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
      <%
      if(nexturl!=null)
      {
        out.print("<input type='hidden' name='nexturl' value="+nexturl+">");
      }
      %>
      <div id="hengx1"></div>
      <table border="0" cellpadding="0" cellspacing="0" id="tjgy">
        <tr>
          <td>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题</td>
          <td class="chdu"><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"> </td>
        </tr>
        <tr>
          <td>信息类别</td>
          <td id="wu">
          <%
          for(int i=0;i<Supply.NEWS_TYPE.length;i++)
          {
            out.print("<input type=radio name=newstype value="+i);
            if(newstype==i)
            out.print(" checked=checked");
            out.print(">"+Supply.NEWS_TYPE[i]);
          }
          %>


          </td>
        </tr>
        <tr>
          <td>所属行业：</td>
          <td>
            <select name="big" onchange="f_ch()">
              <option value="0">------</option>
              <%=f1.toString()%>
            </select>
            <select name="father" >
              <option value="0">------</option>
            </select>
            <script type="">
            function f_ch()
            {
              var op=form1.father.options;
              while(op.length>1)
              {
                op[1]=null;
              }
              switch(parseInt(form1.big.value))
              {
                case 0:
                <%=f2.toString()%>
                break;
              }
            }
            f_ch();
            form1.father.value="<%=father%>";
            </script>
          </td>
        </tr>
        <tr>
          <td>所属地区：</td>
          <td>   <script type="">selectcard("city1","city",null,"<%=city%>");</script></td>
        </tr>
        <tr>
          <td>有&nbsp;&nbsp;效&nbsp;&nbsp;期：</td>
          <td id="wu">
          <%
          for(int i=0;i<Supply.TERM.length;i++)
          {
            out.print("<input type=radio name=term value="+i);
            if(term==i)
            out.print("  checked=checked");
            out.print(">"+Supply.TERM[i]);
          }
          %>

          </td>
        </tr>

        <tr>
          <td>图片上传：</td>
          <td class="chdu"><input type="file" name="picpath" value="" >
          <%
          if(maplen>0)
          {
            out.print("<a href="+picpath+" target='_blank'>"+picname+"</a>");
            out.print("<input type='CHECKBOX' name='clear1' onClick='form1.picpath.disabled=this.checked;'/>清空");
          }
          %>
          </td>
        </tr>
        <tr>
          <td>连接网站：</td>
          <td class="chdu"><input type="text" name="website" value="<%if(website!=null)out.print(website);%>" ></td>
        </tr>
        <tr>
          <td>内&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;容：</td>
          <td><textarea name="content" cols="50" rows="3" id="nrkuang"><%if(content!=null)out.print(content); %></textarea><td>
        </tr>
      <tr><td align="center" colspan="2">
      <div id="xians"><input type="submit" value="提交" />&nbsp;&nbsp;<input type=button value="返回" onClick="javascript:history.back()"></div></td></tr>
    </table>
    </FORM>





<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
