<%@ page contentType="text/html; charset=UTF-8" %><%@ page import="tea.ui.TeaSession"%><%@ page import="tea.db.*"%>
<%@ page import="tea.entity.node.*"%>
<%!
java.util.Random ran=new java.util.Random();
public static final int PAGE_SIZE=15;

//标红,英文字母不区大小写
public String mark(String key,String content)
{
  StringBuffer sb=new StringBuffer(content.length());
  try
  {
    key=key.replaceAll("[\\\\]","").replaceAll("[|]","").replaceAll("[\\\\^]","").replaceAll("\\s+","|");
    java.util.regex.Matcher m=java.util.regex.Pattern.compile(key,java.util.regex.Pattern.CASE_INSENSITIVE).matcher(content);
    int index=0;
    while(m.find())
    {
      sb.append(content.substring(index,m.start()));
      sb.append("<FONT color='red'>"+m.group()+"</FONT>");
      index=m.end();
    }
    sb.append(content.substring(index));
    return sb.toString();
  }catch(Exception e)
  {
    e.printStackTrace();
    return content;
  }
}
%>
<%
String keywords=request.getParameter("keyword");
if(keywords==null)
keywords="";
else
keywords=keywords.trim().replaceAll("  "," ").replaceAll("'","\\'");
/*
if("---关键字---".equals(keywords))
{
  keywords="";
}
*/

long lo=System.currentTimeMillis();
int path=0;
if(request.getParameter("path")!=null)
path=Integer.parseInt(request.getParameter("path"));

int type=0;
if(request.getParameter("type")!=null)
type=Integer.parseInt(request.getParameter("type"));


int pos=0;
if(request.getParameter("pos")!=null)
pos=Integer.parseInt(request.getParameter("pos"));

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=(request.getParameter("community"));
if(community==null)
{
  community=tea.entity.site.Community.find(teasession._nNode)._strCommunity;
}

String timefrom=request.getParameter("timefrom");
String timeto=request.getParameter("timeto");

StringBuffer sql=new StringBuffer();
if(path!=0)
{
  sql.append(" AND n.path LIKE "+DbAdapter.cite("%/"+timefrom+"/%"));
}
if(timefrom!=null&&timefrom.length()>0)
{
  sql.append(" AND n.time>="+DbAdapter.cite(timefrom));
}else
timefrom="";
if(timeto!=null&&timeto.length()>0)
{
  sql.append(" AND n.time<"+DbAdapter.cite(timeto));
}else
timeto="";
if(keywords!=null&&keywords.length()>0)
{
  String temp=keywords.replaceAll(" ","\" OR \"");
  switch(type)
  {
    case 0:
    sql.append(" AND CONTAINS(nl.subject,'\""+(temp)+"\"')");
    break;
    case 1:
    sql.append(" AND CONTAINS(nl.content,'\""+(temp)+"\"')");
    break;
    case 2:
    sql.append(" AND n.rcreator LIKE "+DbAdapter.cite("%"+keywords.replaceAll(" ","%")+"%"));
    break;
  }
}


String keywords_en=java.net.URLEncoder.encode(keywords,"UTF-8");

int sum=0;
java.util.Vector vector=new java.util.Vector();
  tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
  try
  {
    System.out.println("SELECT TOP "+((pos+1)*PAGE_SIZE)+" n.node FROM Node n,NodeLayer nl WHERE n.node=nl.node AND n.community="+DbAdapter.cite(community)+" AND nl.language="+teasession._nLanguage+sql.toString());
    sum=dbadapter.getInt("SELECT COUNT(n.node) FROM Node n,NodeLayer nl WHERE n.node=nl.node AND n.community="+DbAdapter.cite(community)+" AND nl.language="+teasession._nLanguage+" AND n.type NOT IN(0,1) "+sql.toString());
    dbadapter.executeQuery("SELECT TOP "+((pos+1)*PAGE_SIZE)+" n.node FROM Node n,NodeLayer nl WHERE n.node=nl.node AND n.community="+DbAdapter.cite(community)+" AND nl.language="+teasession._nLanguage+" AND n.type NOT IN(0,1) "+sql.toString());
    for(int index=0;dbadapter.next();index++)
    {
      if(index>=pos)
      vector.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }catch (Exception ex)
  {
    ex.printStackTrace();
  }finally
  {
    dbadapter.close();
  }
  java.util.Enumeration enumer=vector.elements();



tea.resource.Resource r=new tea.resource.Resource();
r.add("tea/resource/Lucene");


%>







<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function fclick(node)
{
searchform1.keyword.focus();
}
</script>
</head>

<body onLoad="fclick('<%=path%>');">


<form name="searchform1" action="<%=request.getRequestURI()%>" method=get>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>

     <td id="searchmenu">
	 <input name="path" type="radio" id="radio_path_0" value="0" checked="checked"><label for=radio_path_0><%=r.getString(teasession._nLanguage,"All")%></label>
         <input name="path" type="radio" id="radio_path_1" value="1" <%if(path==1)out.print(" CHECKED ");%> ><label for=radio_path_1>北京故宫</label>
	 <input name="path" type="radio" id="radio_path_2" value="2" <%if(path==2)out.print(" CHECKED ");%> ><label for=radio_path_2>万里长城</label>
	 <input name="path" type="radio" id="radio_path_3" value="3" <%if(path==3)out.print(" CHECKED ");%> ><label for=radio_path_3>北京颐和园</label>
     </td>
  </tr>
</table>
<table width="100%" border="0"  cellpadding="0" cellspacing="0"  bgcolor=#F0F0F0>

  <INPUT type="hidden" value="<%=community%>" name="community">
  <tr>
    <td align="left" valign="middle" id=searchform>
	关键字:<input class="ibox" value="<%=keywords%>" type="text" size=49 name="keyword">

	时间:<input type=text name="timefrom" value="<%=timefrom%>" size="8" ><input type=button value="..." onClick="ShowCalendar('searchform1.timefrom');">-<input type=text name="timeto" value="<%=timeto%>" size="8" ><input type=button value="..." onClick="ShowCalendar('searchform1.timeto');">
      <input type="submit" value="<%=r.getString(teasession._nLanguage,"Search")%>"/>
      结果数:<%=sum%>
    </td>
  </tr>
  <tr>
    <td>
      <input name="type" type="radio" id="radio_type_0" value="0" checked="checked"><label for=radio_type_0><%=r.getString(teasession._nLanguage,"Subject")%></label>
        <input name="type" type="radio" id="radio_type_1" value="1" <%if(type==1)out.print(" CHECKED ");%>><label for=radio_type_1><%=r.getString(teasession._nLanguage,"Text")%></label>
          <input name="type" type="radio" id="radio_type_2" value="2" <%if(type==2)out.print(" CHECKED ");%>><label for=radio_type_2><%=r.getString(teasession._nLanguage,"Author")%></label>
</td>
</tr>
</table>
</form>













<%







{
  StringBuffer sb=new StringBuffer("<div id=searchdiv ><table  border=0>");

    try
    {


  if(sum==0)
  {
    sb.append("<tr><td ><br><br><br>"+tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"NotMatch"),keywords)+"<br/><br/>"+r.getString(teasession._nLanguage,"Suggestions")+
    "<br>"+
    "</td></tr>");
  }else
  {
    String keys[]=keywords.split(" ");
    if(keys.length==1)
    {
      tea.entity.util.Keywords k=tea.entity.util.Keywords.find(community,keywords);
      k.set(sum);
    }

                while(enumer.hasMoreElements())
                {
                  int node=((Integer)enumer.nextElement()).intValue();
                  Node obj=Node.find(node);
                  String urlpath="/servlet/Node?node="+node;
                  String subject=obj.getSubject(teasession._nLanguage);
                  String time=obj.getTimeToString();
                  String desc=obj.getText(teasession._nLanguage);


                  int index=desc.indexOf(keys[0]);
                  int len=desc.length();
                  if(index==-1&&len>512)
                  {
                    index=ran.nextInt(len-200);
                  }else
                  if(index>40)
                  index=index-30;
                  int endindex=len;
                  if(endindex>index+200)
                  {
                    endindex=index+200;
                  }
                  if(endindex>index+1)
                  desc=desc.substring(index+1,endindex);

                  int start = desc.indexOf("<");
                  while (start != -1 && start <= 200)
                  {
                    int end = desc.indexOf(">", start);
                    if (end != -1)
                    {
                      desc = desc.substring(0, start) + desc.substring(end + 1);
                    } else
                    {
                      desc = desc.substring(0, start);
                    }
                    start = desc.indexOf("<");
                  }
                  desc = desc.replaceAll("&nbsp;", "").replaceAll("　", "");


/*
        int beginindex=desc.indexOf(keys[0]);
        int endindex=desc.length();
        if(beginindex==-1&&endindex>512)
        {
          beginindex=ran.nextInt(endindex-100);
        }else
        if(beginindex>40)
        beginindex=beginindex-30;
        if(endindex>beginindex+100)
        {
          endindex=beginindex+100;
        }
        desc=desc.substring(beginindex+1,endindex);
*/
        subject=mark(keywords,subject);
        desc=mark(keywords,desc);


        sb.append("  <tr>"+
        "    <td id=searchsubject ><A href="+urlpath+" target=_blank>"+subject+"</A></td>"+
        "  </tr>"+
        "  <tr>"+
        "    <td id=searchcontent >"+(desc)+"</td>"+
        "  </tr>"+
        "  <tr>"+
        "    <td id=searchdetail  ><font color=#00CC00 >"+urlpath+"&nbsp;&nbsp;"+r.getString(teasession._nLanguage,"Time")+":"+time+"</font></td>"+
        "  </tr>"+
        "  <tr>"+
        "    <td>&nbsp;</td>"+
        "  </tr>");
      }

      java.util.Enumeration correlationenumer=tea.entity.util.Keywords.findByKeywords(community,keywords,10);
      if(correlationenumer.hasMoreElements())
      {
        sb.append("<tr><td id=searchcorrelation  >"+r.getString(teasession._nLanguage,"Correlation")+":");
        while(correlationenumer.hasMoreElements())
        {
          String k=(String)correlationenumer.nextElement();
          sb.append("<A href="+request.getRequestURI()+"?keyword="+java.net.URLEncoder.encode(k,"UTF-8")+"&community="+community+"&path=0&type=0 >"+k+"</A> ");
        }
      }
  }
    }catch(Exception e)
    {
      e.printStackTrace();
    }
  sb.append("</table></div><div align=center>"+new tea.htmlx.FPNL(1,request.getRequestURI()+"?keyword="+keywords_en+"&community="+community+"&path="+path+"&type="+type+"&pos=",pos,sum,PAGE_SIZE)+"</div>");

/*
  if(sum>-1)
  {
    java.io.File pf=file.getParentFile();
    if(!pf.exists())
    {
      pf.mkdirs();
    }
    java.io.FileWriter fw=new java.io.FileWriter(file);
    fw.write(sb.toString());
    fw.close();
  }*/
  out.print(sb.toString());
}


// out.print("<script>document.getElementById('time').innerHTML='"+((System.currentTimeMillis()-lo)/1000f)+"';</script>");
%>

