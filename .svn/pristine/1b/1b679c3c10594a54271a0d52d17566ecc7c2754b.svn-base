<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String subject=node.getSubject(teasession._nLanguage);
String community=node.getCommunity();
tea.entity.node.Cebbank cebbankobj= tea.entity.node.Cebbank.find(node._nNode);
String code="";

String keywords="";//主合同编号
if(node.getType()!=1025)
try
{
  int nodeid=Integer.parseInt(node.getKeywords(teasession._nLanguage));
  DbAdapter dbadapter = new DbAdapter();
  try
  {
    dbadapter.executeQuery("SELECT dv.value FROM DynamicValue dv,DynamicType dt  WHERE dv.node="+nodeid+" AND dt.type='code' AND dt.dynamictype=dv.dynamictype AND NOT dv.value IS NULL");
    if (dbadapter.next())
    {
      keywords=dbadapter.getString(1);
    }
  } catch (Exception exception)
  {
    exception.printStackTrace();
  } finally
  {
    dbadapter.close();
  }
}catch(java.lang.Exception e)
{}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="/tea/CssJs/<%//=community%>.css" rel="stylesheet" type="text/css" />
<style>
*{font-size:9pt;}
img{border:0px;}
span {white-space: nowrap;}
body{margin: 0px;text-align:center}
div#language{margin-top:15px; padding-top:10px; }
form{margin: 0px;	padding: 0px;}
p{ margin:0px; padding:5px 0px 5px 0px}
</style>
</head>
<body >
<input type="hidden" name="keywords" value="<%=keywords%>"/>
<%
java.util.Enumeration enumeration=DynamicType.findByDynamic(node.getType());
int id=0;
     while(enumeration.hasMoreElements())
     {
       id=((Integer)enumeration.nextElement()).intValue();
       tea.entity.site.DynamicType obj=tea.entity.site.DynamicType.find(id);
//if("code".equals(obj.getType()))
//{
//}


       if(obj.isHidden())
       {
         out.print(obj.getBefore(teasession._nLanguage).replaceAll("<script>document\\.write\\(document\\.all\\(\"code\"\\)\\.innerText\\);</script>",code).replaceAll("<script>document\\.write\\(document\\.all\\(\"keywords\"\\)\\.value\\)</script>",keywords));
         tea.entity.node.DynamicValue av = tea.entity.node.DynamicValue.find(node._nNode, teasession._nLanguage, id);
         if("radio".equals(obj.getType()))
         {
           StringBuffer sb = new StringBuffer();
           java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(obj.getContent(teasession._nLanguage), "/");
           for(int index = 0; tokenizer.hasMoreTokens(); index++)
           {
                String str = tokenizer.nextToken();
                boolean bool=str.equals(av.getValue());// || index == 0;
                tea.html.Radio select = new tea.html.Radio("dynamictype" + id, str,bool);
                select.setDisabled(!bool);
                String strid = String.valueOf(id) + "_" + index;
                select.setId(strid);
                sb.append(select + "<label for=" + strid + ">" + str + "</label> ");
           }
           out.print(sb.toString());
         }else
         if("file".equalsIgnoreCase(obj.getType()))
         {
           out.print("<U>下载:<A href="+av.getValue()+" >"+obj.getName(teasession._nLanguage)+"</A></U>");
         }else
         if("code".equalsIgnoreCase(obj.getType()))
         {
           code=av.getValue();
           out.print("<U><SPAN ID="+obj.getType()+" >"+av.getValue()+"</SPAN></U>");
         }else
         {
           out.print("<U>"+av.getValue()+"</U>");
         }
         out.print(obj.getAfter(teasession._nLanguage).replaceAll("<script>document\\.write\\(document\\.all\\(\"code\"\\)\\.innerText\\);</script>",code).replaceAll("<script>document\\.write\\(document\\.all\\(\"keywords\"\\)\\.value\\)</script>",keywords));
       }
     }%>
</body>
</html>

