<%@page contentType="text/html;charset=UTF-8" %>
<!--input type=hidden name=keywords value=""-->
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String key=node.getKeywords(teasession._nLanguage);
if(key!=null&&key.length()>0)
{
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer (key," ");
  while(tokenizer.hasMoreTokens())
  {
String value=    tokenizer.nextToken();
out.println("<SPAN id=Nodekeywords><input type=checkbox value="+value+" onClick=fkeywordsfonclick(this)>"+value+"</SPAN>") ;
  }
}
%>
<script>
function fkeywordsfonclick(obj)
{
  var key=  document.all['keywords'];
  if(obj.checked)
  key.value=key.value+" "+obj.value;
  else
  {
    var index=key.value.indexOf(" "+obj.value);
    var len=(" "+obj.value).length;
    key.value=key.value.substring(0,index)+key.value.substring(index+len);
  }
  //alert(key.value);
}
</script>

