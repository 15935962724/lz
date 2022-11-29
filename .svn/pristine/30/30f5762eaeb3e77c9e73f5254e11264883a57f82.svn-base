package tea.ui.node.type.Logo;

import tea.ui.TeaServlet;
import javax.servlet.ServletException;
import java.util.regex.Pattern;
import tea.entity.node.Logo;
import tea.entity.util.ZoomOut;
import tea.entity.member.Logs;
import tea.entity.node.AccessMember;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
import tea.entity.node.Category;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import javax.imageio.ImageIO;
import tea.entity.node.Node;
import tea.entity.admin.map.GMap;
import tea.entity.RV;
import java.io.File;
import tea.entity.node.SeatEditor;
import java.util.regex.Matcher;
import java.awt.image.BufferedImage;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.*;
import jxl.write.WriteException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.*;
import javax.servlet.http.HttpSession;

public class EditLogo extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    private int rows = 0;
    private void tree1(jxl.write.WritableSheet ws,int nodecode,int step,int language,String path) throws SQLException,WriteException
    {

        for(Enumeration enumeration = tea.entity.node.Node.findSons(nodecode);enumeration.hasMoreElements();)
        {
            int j = ((Integer) enumeration.nextElement()).intValue();
            tea.entity.node.Node node1 = tea.entity.node.Node.find(j);
            ws.addCell(new jxl.write.Label(step,rows,node1.getSubject(language))); // node1.getAnchor(language, path).toString()
            ws.addCell(new jxl.write.Number(step + 1,rows,j));
            ++rows;
            tree1(ws,j,++step,language,path);
            step--;
        }
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String act = teasession.getParameter("act");
        Node node = Node.find(teasession._nNode); //这个号码是如何得到的
//        if("exportExcel".equals(teasession.getParameter("act"))){//导出EXCEL
//			try
//			{
//				javax.servlet.ServletOutputStream out = response.getOutputStream();
//				jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(out);
//				response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(node.getSubject(teasession._nLanguage) + ".xls", "UTF-8"));
//				jxl.write.WritableSheet ws = wwb.createSheet(node.getSubject(teasession._nLanguage), 0);
//				rows = 0;
//				tree1(ws, teasession._nNode, 0, teasession._nLanguage, request.getContextPath());
//				wwb.write();
//				wwb.close();
//				out.close();
//				//response.sendRedirect("/jsp/type/logo/LogoManage.jsp");
//				return;
//			} catch (WriteException ex)
//			{
//				ex.printStackTrace();
//			} catch (IOException ex)
//			{
//				ex.printStackTrace();
//			} catch (SQLException ex)
//			{
//				ex.printStackTrace();
//			}
//		}
        PrintWriter out = response.getWriter();
        try
        {
            Category category = Category.find(teasession._nNode);
            String nexturl = teasession.getParameter("nexturl");

            //EDN删除商标 不用
            if("delete".equals(act))
            {
                int nid = Integer.parseInt(teasession.getParameter("node")); // teasession.getParameter("node");
                Node nobj = Node.find(nid);
                nobj.delete(teasession._nLanguage);
                Logo lobj = Logo.find(nid);
                lobj.delete();
                response.sendRedirect(nexturl);
                return;
            }
            int type = node.getType();
            if(type == 1)
            {
                type = category.getCategory();
            }
            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(type))
                {
                    response.sendError(403);
                    return;
                }
            } else if(teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY; //
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/logo/EditLogo.jsp?" + request.getQueryString());
                return;
            } else
            {
                if("edit".equals(act)) //修改
                {
                    String subject = teasession.getParameter("subject"); //商标名称
                    if(subject == null || subject.length() < 1)
                    {
                        outText(teasession,response,r.getString(teasession._nLanguage,"错误的商标名"));
                        return;
                    }
                    String content = teasession.getParameter("content"); //商标简介
                    boolean srccopy = teasession.getParameter("srccopy") != null; //源网站的图片贴入本地
                    if(srccopy)
                    {
                        content = copy(teasession._strCommunity,content);
                    }
                    boolean textorhtml = "1".equals(teasession.getParameter("TextOrHtml")); //使用HTML
                    if(node.getType() == 1) ///在父节点下创建新的商标
                    {
                        int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                        long options = node.getOptions();
                        int options1 = node.getOptions1();
                        String community = node.getCommunity();
                        if(textorhtml)
                        {
                            options |= 0x40;
                        }
                        int defautllangauge = node.getDefaultLanguage();
                        Category cat = Category.find(teasession._nNode); //39
                        teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,null,"",content,null,"",0,null,"","","","",null,null);
                        //入NODE表
                        node = Node.find(teasession._nNode);
                    } else
                    {
                        node.set(teasession._nLanguage,subject,content); //修改NODE表
                        long options = node.getOptions();
                        if(textorhtml)
                        {
                            options |= 0x40;
                        }
                        node.setOptions(options);
                        Logs.create(node.getCommunity(),teasession._rv,2,teasession._nNode,subject);
                    }

                    //图片
                    String np = node.getPicture(teasession._nLanguage);
                    if(np == null || np.length() < 1 || np.endsWith("#auto"))
                    {
                        Pattern P_PIC = Pattern.compile("<img[^<>]+src=[\"']?([^\"']+)[\"']?[^<>]+>",Pattern.CASE_INSENSITIVE);
                        Matcher m = P_PIC.matcher(content);
                        String newv = m.find() ? m.group(1) + "#auto" : "";
                        if(!newv.equals(np))
                        {
                            node.setPicture(newv,teasession._nLanguage);
                        }
                    }

                    Logo obj = Logo.find(teasession._nNode);
                    String logotype = teasession.getParameter("logotype");

                    String logoimage = teasession.getParameter("logoimage");

                    if(teasession.getParameter("logoimage") != null && teasession.getParameter("logoimage").length() > 0)
                    {

                    } else
                    if(teasession.getParameter("clearlogoimage") != null)
                    {
                        logoimage = "";
                    } else
                    {
                        logoimage = obj.getLogoimage();
                    }

                    String logouse = teasession.getParameter("logouse");
                    String regnum = teasession.getParameter("regnum");
                    //String logointroduce = teasession.getParameter("content");
                    String regdate = teasession.getParameter("regdate");
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = null;
                    if(regdate != null && !regdate.equals(""))
                    {
                        try
                        {
                            date = format.parse(regdate);
                        } catch(ParseException e)
                        {
                            e.printStackTrace();
                        }
                    }

                    //////
                    if(obj.isExists())
                    {
                        obj.set(logotype,logoimage,logouse,regnum,date);
                    } else
                    {
                        Logo.create(teasession._nNode,logotype,logoimage,logouse,regnum,date,teasession._strCommunity);
                    }

                    delete(node);

                    node.finished(teasession._nNode);
                    if(nexturl.length() < 1)
                        nexturl = "/servlet/Node?node=" + teasession._nNode;

                    if(category.getClewtype() != 0)
                    {
                        response.setContentType("text/html;charset=UTF-8");
                        out.print("<script>parent.showDialog('" + category.getClewcontent() + "','<a href=/servlet/Node?node=" + teasession._nNode + " class=bag>确定</a>　<a href=javascript:dialog_close(); class=trade>取消</a>');</script>");
                    } else
                    {
                        out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
                    }
                } else if("import".equals(act))
                { //集佳导入到Logo表
                    Logo logo2 = new Logo();
                    ArrayList ar = logo2.getAll();
                    for(int i = 0;i < ar.size();i++)
                    {
                        //System.out.println((i+1) + ":"  + node._nNode);
                        Logo logo3 = (Logo) ar.get(i);
                        ///////////////////
                        String subject = logo3.getLogoname();
                        String content = "";
                        String logotype = logo3.getLogotype();
                        String logoimage = logo3.getLogoimage();
                        String logouse = logo3.getLogouse();
                        String regnum = logo3.getRegnum();
                        Date regdate = logo3.getRegdate();
                        int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                        long options = node.getOptions();
                        int options1 = node.getOptions1();
                        String community = node.getCommunity();
                        boolean srccopy = teasession.getParameter("srccopy") != null; //源网站的图片贴入本地
                        if(srccopy)
                        {
                            content = copy(teasession._strCommunity,content);
                        }
                        boolean textorhtml = "1".equals(teasession.getParameter("TextOrHtml")); //使用HTML

                        if(textorhtml)
                        {
                            options |= 0x40;
                        }
                        int defautllangauge = node.getDefaultLanguage();
                        Category cat = Category.find(teasession._nNode); //39
                        HttpSession session = request.getSession();
                        int father = Integer.parseInt(session.getAttribute("fnode").toString());
                        teasession._nNode = Node.create(father,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,null,"",content,null,"",0,null,"","","","",null,null);
                        //入NODE表
                        delete(node);
                        node.finished(teasession._nNode);
                        Logo.create(teasession._nNode,logotype,logoimage,logouse,regnum,regdate,teasession._strCommunity);
                    }
                    if(nexturl != null && !("").equals(nexturl))
                    {
                        response.sendRedirect(nexturl);
                        return;
                    }
                }
            }
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

}
