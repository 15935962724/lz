<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%

Http h=new Http(request);

int gid=h.getInt("gid");
int count=h.getInt("count",10);

String str;
File f=new File(application.getRealPath("/res/tmp/weibo_"+gid+".cache"));
if(f.lastModified()<System.currentTimeMillis()-60000L)//缓1分钟
{
  str=(String)Entity.open("http://q.weibo.com/ajax/mblog/groupfeed?gid="+gid+"&page=1&has_repost=1&has_pic=1&has_video=1&has_audio=1&only_text=1&key_word=&time_start=&time_end=&new=1&count=10&since_id=0&max_id=0&pre_page=1&end_id=0&is_search=0&pagebar=0&uid=0&me=0&mids=&_k=13146141102812&_t=0");
  //System.out.println(str.substring(j,str.lastIndexOf("\",\"")).replaceAll("\\\\\"","\"").replaceAll("\\\\/","/"));
  Filex.write(f.getPath(),str,"UTF-8");
}else
  str=Filex.read(f.getPath(),"UTF-8");

%>
//<script>
var t=<%=str%>.data.html;

//删除：正在加载中，请稍候...……
t=t.substring(0,t.lastIndexOf('<div'));

//更换为绝对路径
t=t.replace(/href="\//g,'target=_blank href="http://q.weibo.com/');
t=t.replace(/href='\//g,"target=_blank href='http://q.weibo.com/");

//固定条数
for(var i=<%=count%>;i<10;i++)
{
  var j=t.lastIndexOf('<dl mid="');
  if(j==-1)break;
  t=t.substring(0,j);
}

//删除：无法点击的链接
t=t.replace(/<a.+>(转发|回复)<\/a>/g,"");
t=t.replace(/<a[^>]+>举报<\/a>/g,"");
t+="<style>.W_vline{display:none}</style>";

document.write(t);

//</script>
