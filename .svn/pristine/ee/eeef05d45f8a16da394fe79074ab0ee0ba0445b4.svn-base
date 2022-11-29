package tea.ui.node.type.file;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.db.DbAdapter;
import tea.entity.RV;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.admin.orthonline.NodePoints;
import tea.entity.integral.*;

public class Filess extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        ServletContext application = this.getServletContext();
        Http h = new Http(request,response);
        String act = h.get("act");
        try
        {
            if("paper".equals(act))
            {
                //System.out.println(request.getRequestURI() + "?" + request.getQueryString());
                //System.out.println("REF:" + request.getHeader("referer"));//GG:网页路径 IE,FF:SWF文件路径
                //Files obj = Files.find(h.node,h.language);
                int page = h.getInt("page");
                String url = "/res/" + h.community + "/paper/" + (h.node / 10000) + "-" + h.language + "/" + h.node + (page > 0 ? "_" + page : "") + ".swf";
                if(request.getSession().isNew() || request.getHeader("referer") == null || request.getHeader("accept-language") == null || request.getHeader("accept-encoding") == null || !new File(application.getRealPath(url)).exists())
                    url = "/tea/applet/paper.swf";
                application.getRequestDispatcher(url).forward(request,response);
                return;
            } else if("down".equals(act))
            {
                if(h.member < 1)
                {
                    response.sendRedirect("/servlet/StartLogin?community=" + h.community);
                    return;
                }
                Files f = Files.find(h.node,h.language);
                String path = f.getNamepath();
                response.setHeader("Cache-Control","private");
                response.addHeader("Content-Disposition","attachment;filename=" + Http.enc(path.substring(path.lastIndexOf('/') + 1)));
                //
                if(FDown.count(" AND node=" + h.node + " AND member=" + h.member + " AND time>" + DbAdapter.cite(new Date(),true)) < 1)
                {
                    FDown d = new FDown(0);
                    d.node = h.node;
                    d.member = h.member;
                    d.ip = request.getRemoteAddr();
                    if(d.ip.startsWith("127."))
                        d.ip = request.getHeader("X-Forwarded-For");
                    d.time = new Date();
                    d.set();
                }
                application.getRequestDispatcher(path).forward(request,response);
                return;
            }
        } catch(IOException ex)
        {
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
        PrintWriter out = response.getWriter();
        try
        {
            if("json".equals(act))
            {
                Files t = Files.find(h.node,h.language);
                out.print(t.ptext);
            } else if("edit".equals(act))
            {
                boolean isnew = false;
                Node n = Node.find(h.node);
                int father = h.node;

                String subject = h.get("subject");
                String content = h.get("content");
                boolean srccopy = h.get("srccopy") != null;
                if(srccopy)
                {
                    content = copy(h.community,content);
                }

                String picture = h.get("picture");
                String keywords = h.get("keywords");
                boolean newnode = h.get("NewNode") != null;
                if(newnode)
                {
                    n = n.clone();
                    int options1 = n.getOptions1();

                    Category cat = Category.find(h.node);
                    n.father = h.node;
                    n.member = h.member;
                    n.creator = new RV(h.username);
                    n.type = cat.getCategory(); //41
                    n.hidden = (options1 & 2) != 0;
                    n.defaultLanguage = h.language;
                    n.time = new Date();
                    n.sequence = Node.getMaxSequence(h.node) + 10;

                    isnew = true;
                }
                if(h.getBool("clear"))
                    picture = "";
                n.set();
                n.setLayer(h.language,subject,keywords,n.getDescription(h.language),content,picture,null,0,null,null,null,null,null,n.getFile(h.language),null);
                h.node = n._nNode;

                if(newnode && (n.getOptions1() & 2) != 0)
                {
                    NodePoints np = NodePoints.get(h.node);
                    Profile profile = Profile.find(h.member);
                    profile.addIntegral(np.getSczy(),profile.getProfile());

                    // 加分记录:上传资源加积分
                    IntegralRecord.create(h.community,profile.getMember(),np.getSczy(),5,h.node,profile.getMember());
                }
                // /////////////////

                Files obj = Files.find(h.node,h.language);

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
                int classes = h.getInt("classes");
                int classesc = h.getInt("classesc");
                String code = h.get("code");
                int filesize = (int)new File(Http.REAL_PATH + namepath).length();
                int grade = h.getInt("grade");
                int pointlimit = h.getInt("pointlimit");
                String author = h.get("author");
                String unitname = h.get("unitname");
                String linkurl = h.get("linkurl");
                String note = h.get("note");
                //
                boolean pconv = h.get("pconv") != null;
                boolean outline = h.get("outline") != null;
                boolean copy = h.get("copy") != null;
                boolean prints = h.get("prints") != null;
                int toolbar = 0;
                String[] arr = h.getValues("toolbar");
                if(arr != null)
                {
                    for(int j = 0;j < arr.length;j++)
                        toolbar |= Integer.parseInt(arr[j]);
                }

                int pcount = namepath.equals(obj.getNamepath()) ? obj.pcount : 0;

                obj.set(classes,classesc,code,name,keywords,filesize,grade,pointlimit,author,linkurl,note,namepath,filecheckbox,pconv,outline,copy,prints,pcount,toolbar,unitname);
                // ////////
                n.finished(h.node);
                delete(n);
                String nu = h.get("nexturl");
                if("back".equals(act))
                {
                    response.sendRedirect("/jsp/general/EditNode.jsp?node=" + h.node);
                    return;
                }
                if(nu != null)
                {
                    String my = h.get("my");
                    if(my != null)
                        if(isnew && my.equals("on"))
                            request.getSession().setAttribute("tea.isnew","on");
                    response.sendRedirect(nu);
                    return;
                }

                if(h.get("newfilebutton") != null)
                {
                    nu = "/jsp/type/files/EditFiles.jsp?NewNode=ON&node=" + father;
                } else
                {
                    nu = "/html/files/" + h.node + "-" + h.language + ".htm";
                }
                response.sendRedirect(nu);
            }else if("delete".equals(act))
            {
            	Node n = Node.find(h.node);
            	Files obj = Files.find(h.node,h.language);
            	
            	//图片路径
            	String pictureUrl = n.getPicture(h.language);
            	//文件路径
            	String fileUrl = obj.getNamepath();
        		File oldImgFile = new File(Http.REAL_PATH + pictureUrl);
        		if(oldImgFile.exists()){
        			//删除attch
        			//图片记录attch
                	Attch oldImgAttch = (Attch)Attch.find(" AND path="+pictureUrl, 0, 1).get(0);
                	oldImgAttch.delete();
                	//文件记录attch
                	Attch oldFileAttch = (Attch)Attch.find(" AND path="+fileUrl, 0, 1).get(0);
                	oldFileAttch.delete();
        		}
            	n.delete_nodeid(h.language);
            }
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
