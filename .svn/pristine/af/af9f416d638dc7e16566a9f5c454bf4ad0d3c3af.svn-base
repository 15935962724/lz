package tea.ui.node.type.book;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.Http;
import tea.entity.RV;
import tea.entity.node.*;
import tea.entity.sup.SupQualification;
import tea.html.*;
import tea.htmlx.*;
import java.math.*;
import java.text.SimpleDateFormat;
import java.util.*;
import tea.resource.Resource;
import tea.ui.*;
import tea.entity.admin.orthonline.NodePoints;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Logs;
import tea.entity.member.Profile;

public class EditBook extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            Http h=new Http(request);
            if(h.member<1)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
            }
            if("GET".equals(request.getMethod()))
            {
                response.sendRedirect("/jsp/type/book/EditBook.jsp?" + request.getQueryString());
                return;
            }
            Node node = Node.find(h.node);
            Category cat = Category.find(h.node);
            int type = node.getType();
            if(type == 1)
            {
                type = cat.getCategory();
            }
            if(!node.isCreator(new RV(h.username)) && !AccessMember.find(h.node,new RV(h.username)._strV).isProvider(type))
            {
                response.sendError(403);
                return;
            }
            String subject = h.get("subject");
            String content = h.get("content");
            if(node.getType() == 1)
            {
                int sequence = Node.getMaxSequence(h.node) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                h.node = Node.create(h.node,sequence,node.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,options,options1,node.getDefaultLanguage(),null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                node = Node.find(h.node);
            } else
            {
                node.set(h.language,subject,content);
                Logs.create(node.getCommunity(),new RV(h.username),2,h.node,subject);
            }
            String isbn = h.get("isbn");
            //int format = Integer.parseInt(h.get("format"));
            int format =0;
            int amountword = 0;
            try
            {
                amountword = Integer.parseInt(h.get("amountword"));
            } catch(Exception exception1)
            {
            }
            int amountpage = 0;
            try
            {
                amountpage = Integer.parseInt(h.get("amountpage"));
            } catch(Exception exception2)
            {
            }
            int binding = Integer.parseInt(h.get("binding"));
            BigDecimal price = null;
            try
            {
                price = new BigDecimal(h.get("price"));
            } catch(Exception exception3)
            {

            }
            Date publish = TimeSelection.makeTime(h.get("publishYear"),h.get("publishMonth"),h.get("publishDay"),h.get("publishHour"),h.get("publishMonth"));
            int reprint = 0;
            try
            {
                reprint = Integer.parseInt(h.get("reprint"));
            } catch(Exception exception4)
            {
            }
            String subtitle = h.get("subtitle");
            String publisher = h.get("publisher");
            String cipi = h.get("cipi");
            String cipii = h.get("cipii");
            String cipiii = h.get("cipiii");
            String cipiv = h.get("cipiv");
            String reader = h.get("reader");
            String collection = h.get("collection");
            String annotation = h.get("annotation");
            String smallpicture = h.get("smallpicture");
            String edition = h.get("edition");
            int transfer = (Integer.valueOf(h.get("transfer")));
            String authorMsg = h.get("authorMsg");
            String chapterMsg = h.get("chapterMsg");
            int num=0;
            int booktype=(Integer.valueOf(h.get("booktype")));
            int docnode=h.getInt("docnode");
            Date indate=h.getDate("indate");
            Date date=h.getDate("indate");
            int specifications=(Integer.valueOf(h.get("specifications")));
            int inventory=(Integer.valueOf(h.get("inventory")));
            BigDecimal weight=new BigDecimal(h.get("weight"));
            String keyword=h.get("keyword");
            if(h.get("clearsmallpicture") != null)
            {
                smallpicture = "";
            }
            String bigpicture = h.get("bigpicture");
            if(h.get("clearbigpicture") != null)
            {
                bigpicture = "";
            }
            Book book = Book.find(h.node);
            book.set(isbn,format,amountword,amountpage,binding,price,publish,reprint,h.language,subtitle,publisher,cipi,cipii,cipiii,cipiv,reader,collection,annotation,smallpicture,bigpicture,inventory,weight,num,booktype,specifications,keyword,docnode,edition,transfer,authorMsg,chapterMsg);
//			int l1;
//			if (bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
//			{
//				l1 = Node.findCategorySon(h.node, 4);
//			}
            //在线阅读
            int father = 14020177;
            Node n = Node.find(father);
            
            if(h.get("pconv") != null&&h.get("fileName")!=null&&book.getDocnode()<1)
            {
                int sequence = Node.getMaxSequence(father) + 10;
                int options1 = n.getOptions1();
                String community = n.getCommunity();
                long options = n.getOptions();
                int defautllangauge = n.getDefaultLanguage();
                Category cat1 = Category.find(father); //41
                h.node = Node.create(father,sequence,community,new RV(h.username),cat1.getCategory(),(options1 & 2) != 0,options,options1,
                                     defautllangauge,null,null,new java.util.Date(),0,0,node.getKstyle(),0,null,h.language,subject,keyword,"",content,null,"",0,null,"","","","",null,null); // date5);
                node.finished(h.node);
                book.set("docnode", String.valueOf(h.node));
                Node node1 = Node.find(h.node);
                //isnew = true;
                if((options1 & 2) != 0)
                {
                    NodePoints np = NodePoints.get(h.node);
                    Profile profile = Profile.find(node1.getCreator()._strV);
                    profile.addIntegral(np.getSczy(),profile.getProfile());

                    // 加分记录:上传资源加积分
                    IntegralRecord.create(h.community,profile.getMember(),np.getSczy(),5,node1._nNode,profile.getMember());
                }
            } else
            {
                node.set(h.language,subject,content);
            }
            Files obj=null;
            if(h.get("pconv") != null&&h.get("fileName")!=null&&book.getDocnode()<1){
            	obj = Files.find(h.node,h.language);
            }else{
            	obj = Files.find(book.getDocnode(),h.language);
            }
            
            int filecheckbox = 0;
            if(h.get("filecheckbox") != null)
            {
                filecheckbox = 1;
            }
            String name = h.get("fileName");
            String namepath = h.get("file");
            if(filecheckbox > 0) //说明是选中 是填写的路径
            {
                namepath = h.get("file2");
                name = namepath.substring(namepath.lastIndexOf("/") + 1,namepath.length());
            } else if(namepath == null) // 说明是上传的文件
            {
                name = obj.getName();
                namepath = obj.getNamepath();
            }
            if(name!=null){
            	int filesize = (int)new File(Http.REAL_PATH + namepath).length();
                
                int toolbar = 0;
                String[] arr = h.getValues("toolbar");
                if(arr != null)
                {
                    for(int j = 0;j < arr.length;j++)
                        toolbar |= Integer.parseInt(arr[j]);
                }

                int pcount = namepath.equals(obj.getNamepath()) ? obj.pcount : 0;

                obj.set(0,0,String.valueOf(new SimpleDateFormat("yyyyMMddhhmmss").format(new Date())),name,keyword,filesize,0,0,"","","",namepath,filecheckbox,true,false,false,false,pcount,toolbar);
                // ////////
                delete(node);
            }
            
            
            if(h.get("GoBack") != null)
            {
                response.sendRedirect("/servlet/EditNode?node=" + h.node);
            } else if(h.get("GoFinish") != null)
            {
                node.finished(h.node);
                response.sendRedirect("/servlet/Node?node=" + h.node + "&edit=ON");
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/book/EditBook");
    }
}
