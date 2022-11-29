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


<%



TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
 
 Resource r = new Resource("tea/htmlx/HtmlX");
DbAdapter db=new DbAdapter(3);

try 
{
 // db.executeQuery(" select email,name,password,gender,age,city,country,industry,job,information,createdate,newsletter,abstracts from WO_USERINFO ");
  db.executeQuery(" SELECT userid,country,email,content,createtime FROM WO_FEEDBACK ");
  int i =1;
  while(db.next())
  { 
	 
	 		String name = db.getString(1);//用户名
	 		String country = db.getString(2);//姓名
	 		String email = db.getString(3);//密码
	 		String content = db.getString(4);
	 		Date createtime = db.getDate(5);
	 		
	 		teasession._nNode = 121;  
	 		  
	 		 Node node = Node.find(teasession._nNode);

            String subject = country;
            String text =content;
            
            
            if(node.getType() == 1)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                int options1 = node.getOptions1();
                int defautllangauge = node.getDefaultLanguage();
                Category obj = Category.find(teasession._nNode);
                teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,obj.getCategory(),(options1 & 2) != 0,node.getOptions(),options1,defautllangauge,null,null,createtime,0,0,0,0,"","",teasession._nLanguage,subject,null,text,null,"",null,0,null,"","","","",null,null);
            } else
            {  
               // node.set(teasession._nLanguage,subject,text);
            }
            int hint = 0;
            
            String phone = request.getParameter("phone");
            String mobile = request.getParameter("mobile");
           
             
            String ip = null;
            MessageBoard obj = MessageBoard.find(teasession._nNode,teasession._nLanguage);
            obj.set(hint,phone,mobile,email,name,ip);
         
 
            node.finished(teasession._nNode);
            

            System.out.println("i:"+i+"--"+name);
            i++;
          
        }
	 		
	 		

	 		

}finally
{
  db.close();
}

%>

