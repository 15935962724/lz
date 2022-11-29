package tea.ui.node.type.page;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.entity.node.Page;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.admin.orthonline.*;
import tea.entity.member.*;
import tea.entity.*;


public class EditPage extends TeaServlet
{


    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            Http h = new Http(request,response);
            if(h.member < 1)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
            }
            String act = h.get("act");
            if("upload".equals(act))
            {
                int battch = h.getInt("file.attch");
                if(battch > 0)
                {
                    Attch a = Attch.find(battch);
                    a.set("content",a.content = h.get("content"));
                    out.print(a.toString3());
                }
                return;
            }

            Node node = Node.find(h.node);
            if(!node.isCreator(h.member) && !AccessMember.find(node._nNode,h.username).isProvider(2))
            {
                response.sendError(403);
                return;
            }

            int i = node.getOptions1();
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/page/EditPage.jsp?node=" + h.node);
            } else
            {
                i &= -2;
                if(h.get("PageOLink") != null)
                {
                    i |= 1;
                }
                boolean isNew = h.get("NewNode") != null;

                Category category = Category.find(h.node);
                int type = node.getType();
                boolean isnew = false;
                if(type == 1)
                {
                    type = category.getCategory();
                }

                String subject = h.get("subject");
                String content = h.get("content");

                String picture = h.get("Picture");
                if(h.get("ClearPicture") != null) //删除图片
                {
                    picture = "";
                } else if(picture != null)
                {
                } else
                {
                    picture = node.getPicture(h.language);
                }

                String filename = "|";

                /**String filename = h.get("FileName");
                                 String file = h.get("File");
                                 if(h.get("ClearFile") != null)//删除图片
                                 {
                 filename = "";
                 file="";
                     } else if(filename != null)
                     {
                     } else
                     {
                      filename=node.getFileName(h.language);
                      file=node.getFile(h.language);
                     }**/
                String file = h.get("file");
                String keywords = h.get("keywords");
                boolean srccopy = h.get("srccopy") != null;
                boolean textorhtml = "1".equals(h.get("TextOrHtml"));
                if(srccopy)
                {
                    content = copy(h.community,content);
                }
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    long options = node.getOptions();
                    int options1 = node.getOptions1();
                    String community = node.getCommunity();
                    if(textorhtml)
                    {
                        options |= 0x40;
                    }

                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(h.node); //39
                    h.node = Node.create(h.node,sequence,community,new RV(h.username),cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,h.language,subject,keywords,"",content,picture,"",0,null,"","","",filename,file,null);
                    node = Node.find(h.node);
                } else
                {
                    node.set(h.language,subject,content);
                    node.setPicture(picture,h.language);
                    long options = node.getOptions();
                    if(textorhtml)
                    {
                        options |= 0x40;
                    }
                    node.setOptions(options);
                    node.setKeywords(keywords,h.language);
                    node.setFileName(filename,h.language);
                    node.setFile(file,h.language);
                    Logs.create(node.getCommunity(),new RV(h.username),2,h.node,subject);
                }
                if(isNew){
                	//判断是否传过来 “隐藏” 的值  --医疗粒子
                    String isHidden = h.get("isHidden","");
                    if(isHidden!=null&&isHidden.length()>0)
                    	node.set("hidden", isHidden);
                }

                Page page = Page.find(h.node);

                node.setOptions1(i);
                page.set(h.language,h.get("RedirectUrl"));

                delete(node);

                String nexturl = h.get("nexturl");
                if("back".equals(act))
                {
                    response.sendRedirect("/jsp/general/EditNode.jsp?node=" + h.node);
                } else if("finish".equals(act))
                {
                    node.finished(h.node);
                    if(nexturl != null)
                    {
                        response.sendRedirect(nexturl);
                        return;
                    } else
                    {
                        response.sendRedirect("Page?node=" + h.node + "&edit=ON");
                    }
                }
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        // super.r.add("tea/ui/node/type/page/EditPage");
    }
}
