<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.Entity"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import ="java.sql.SQLException" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.admin.mov.*" %>
<%!
public static String getPath(DbAdapter db, int nNode) throws SQLException
{
    int nFather = 0;
    db.executeQuery("SELECT father FROM Node WHERE node=" + nNode);
    if (db.next())
    {
        nFather = db.getInt(1);
    }
    if (nFather == 0)
    {
        return "/" + nNode + "/";
    } else
    {
        return getPath(db, nFather) + nNode + "/";
    }
}
public static String Html2Text(String inputString)
{
    String htmlStr = inputString; //含html标签的字符串
    String textStr = "";
    java.util.regex.Pattern p_script;
    java.util.regex.Matcher m_script;
    java.util.regex.Pattern p_style;
    java.util.regex.Matcher m_style;
    java.util.regex.Pattern p_html;
    java.util.regex.Matcher m_html;
    
    
    java.util.regex.Pattern p_a;
    java.util.regex.Matcher m_a;
    
    

    try
    {
        String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
        String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> }
        String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式
        
        String regEx_a = "<a\\s.*?href=\"([^\"]+)\"[^>]*>(.*?)</a>";//定义a 连接 
        
        p_a = Pattern.compile(regEx_a,Pattern.CASE_INSENSITIVE);
        m_a=p_a.matcher(htmlStr);
        htmlStr = m_a.replaceAll(""); //过滤a标签

        p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
        m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll(""); //过滤script标签
        
       
        

        p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);
        m_style = p_style.matcher(htmlStr);
        htmlStr = m_style.replaceAll(""); //过滤style标签

        p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);
        m_html = p_html.matcher(htmlStr);
        htmlStr = m_html.replaceAll(""); //过滤html标签
        
        

        textStr = htmlStr.replaceAll("&nbsp;","");

    } catch(Exception e)
    {
        System.err.println("Html2Text: " + e.getMessage());
    }

    return textStr; //返回文本字符串
}

public static String stripHtml(String content) { 
	// <p>段落替换为换行 
	content = content.replaceAll("<p .*?>", "\r\n"); 
	// <br><br/>替换为换行 
	content = content.replaceAll("<br\\s*/?>", "\r\n"); 
	// 去掉其它的<>之间的东西 
	content = content.replaceAll("\\<.*?>", ""); 
	// 还原HTML 
	// content = HTMLDecoder.decode(content); 
	return content; 
	}

%>

<% 
TeaSession teasession=new TeaSession(request);


//修改媒体名称有html代码的
DbAdapter db = new DbAdapter();
try
{
	db.executeQuery("select name,media from MediaLayer ");
	int i=1;
	while(db.next())
	{
			String name =db.getString(1);
			int media = db.getInt(2);
			Media mobj = Media.find(media);
			
			String cn = Html2Text(name);
			if(cn!=null && cn.length()>0)
			{
				cn = cn.trim();
				mobj.set(1,cn,null);
				out.println(i+"--"+media+"--"+cn+"<br>");
				i++;
			}else
			{
				out.print("空的："+cn);
			}
			
			
	}
}finally
{
	db.close();	
}


/*

DbAdapter db1 = new DbAdapter();
DbAdapter db2 = new DbAdapter();
DbAdapter db3 = new DbAdapter();
try
{
   
       
        db1.executeQuery("SELECT node FROM Node ORDER BY node");
        while (db1.next())
        {
            int nNode = db1.getInt(1);
            db2.executeUpdate("UPDATE Node SET path=" + DbAdapter.cite(getPath(db3, nNode)) + " WHERE node=" + nNode);
            System.err.print(nNode + "\r");
        }

} catch (Exception e)
{
    e.printStackTrace();
} finally
{
    db1.close();
    db2.close();
    db3.close();
}

*/


/*
Enumeration e = Node.find(" and type = 0 and father =1 ",0,Integer.MAX_VALUE);
int i =1;
while(e.hasMoreElements()) 
{
	int nid =((Integer)e.nextElement()).intValue();
	Node nobj = Node.find(nid);
	
	DbAdapter db = new DbAdapter();
	try  
	{
		db.executeUpdate("update Node set path ="+DbAdapter.cite("/1/"+nid+"/")+" where  node =  "+nid);
	}finally 
	{ 
		db.close(); 
	}
	out.println((i++)+":"+nobj.getSubject(1)+"<br>");	
}
*/





%> 
