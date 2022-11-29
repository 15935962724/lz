package tea.ui.node.general;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.*;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.node.AccessMember;
import tea.entity.node.Category;
import tea.entity.node.CssJs;
import tea.entity.node.Node;
import tea.entity.site.TypeAlias;
import tea.entity.util.ZoomOut;
import tea.htmlx.TimeSelection;
import tea.resource.Common;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.util.Caiji;

public class EditNode extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);
        TeaSession teasession = new TeaSession(request);
        ServletContext application = getServletContext();
        try
        {
            String act = h.get("act");
            if("upload".equals(act))
            {
                int battch = h.getInt("file.attch");
                if(battch > 0)
                {
                    Attch a = Attch.find(battch);
                    a.set("content",a.content = h.get("content"));
                    PrintWriter out = response.getWriter();
                    out.print(a.toString3());
                    out.close();
                }
                return;
            }

            AccessMember am = AccessMember.find(h.node,teasession._rv);
            int j = 0;
            Node node = Node.find(h.node);
            boolean isNew = h.get("NewNode") != null;
            if(!isNew)
            {
                if(!node.isCreator(teasession._rv) && am.getPurview() < 2)
                {
                    outLogin(request,response,h);
                    return;
                }
                j = node.getType();
            } else
            {
                j = Integer.parseInt(h.get("Type"));
                if(!am.isProvider(j))
                {
                    outLogin(request,response,h);
                    return;
                }
            }
            String s = request.getRequestURI();

            String s1 = node.getCommunity();
            int l = isNew ? h.node : node.getFather();
            Node node1 = Node.find(l);
            int i1 = 0;
            Node node2 = null;
            i1 = node.getTemplate(l);
            if(isNew && (node1.getType() == 1 || node1.getType() == 0))
            {
                node2 = Node.find(i1);
            }
            if("GET".equals(request.getMethod()))
            {
                String qs = request.getQueryString();
                if(s.endsWith("NewNode"))
                {
                    qs += "&NewNode=ON";
                }
                int rt = node.getType();
                if(rt == 1)
                {
                    rt = Category.find(h.node).getCategory();
                }
                if(rt > 65534)
                {
                    rt = TypeAlias.find(rt).getType();
                }
                String url = rt == 0 ? "/jsp/general/EditNode.jsp" : rt < 1024 ? "/jsp/type/" + Node.NODE_TYPE[rt].toLowerCase() + "/Edit" + Node.NODE_TYPE[rt] + ".jsp" : "/jsp/type/dynamicvalue/EditDynamicValue.jsp";
                response.sendRedirect(url + "?" + qs);
                return;
            }
            boolean flag7;
            flag7 = false;
            if(isNew || !node1.isCreator(teasession._rv))
            {
                // break MISSING_BLOCK_LABEL_4779;
                /*
                 * if (node1.getType() != 1) { flag7 = true; // break MISSING_BLOCK_LABEL_4779; } else
                 */
                {
                    if((node1.getOptions1() & 1) == 0)
                    {
                        // response.sendError(403);
                        // return;
                    }
                    if((node1.getOptions1() & 2) != 0)
                    {
                        flag7 = true;
                    }
                }
            }
            RV rv = teasession._rv;
            if(rv == null)
            {
                rv = new RV("<" + request.getRemoteAddr() + ">");
            }
            long k1 = 0;
            //  if(j == 0 || j == 1)//2010-02-10zhangjinshu注释
            //      {
            if(h.get("NodeOShowHeader1") != null)
            {
                k1 |= 0x40000000L;
            }
            if(h.get("NodeOShowAd") != null)
            {
                k1 |= 0x20000000L;
            }
            // 是否审核高见
            if(h.get("NodeOShowTalkbackAuditing") != null) // NodeOShowHeader2
            {
                k1 |= 0x10000000L;
            }
            if(h.get("NodeOShowBodyLeft") != null)
            {
                k1 |= 0x8000000L;
            }
            if(h.get("NodeOShowBodyRight") != null)
            {
                k1 |= 0x4000000L;
            }
            if(h.get("NodeOShowFooter") != null)
            {
                k1 |= 0x2000000L;
            }
            //  } else
            //  {
            //     k1 = node.getOptions() & 0x7e000000L;
            // }
            if(h.get("DeleteFormat") != null)
            {
                k1 |= 0x80000000L;
            }
            if(h.get("NodeOShowPath") != null)
            {
                k1 |= 0x1000000L;
            }
            if(h.get("NodeOShowSons") != null)
            {
                k1 |= 0x800000L;
            }
            if(h.get("NodeOShowSubject") != null)
            {
                k1 |= 0x400000L;
            }
            if(h.get("NodeOShowBriefing") != null)
            {
                k1 |= 0x80L;
            }
            if(h.get("NodeOShowCreator") != null)
            {
                k1 |= 0x200000L;
            }
            if(h.get("NodeOShowGrandsons") != null)
            {
                k1 |= 0x100000L;
            }
            if(h.get("NodeOShowLogin") != null)
            {
                k1 |= 0x80000L;
            }
            if(h.get("NodeOShowFather") != null)
            {
                k1 |= 0x40000L;
            }
            if(h.get("NodeOPoll") != null)
            {
                k1 |= 0x20000L;
            }
            if(h.get("NodeOChatRoom") != null)
            {
                k1 |= 0x10000L;
            }
            if(h.get("NodeOOpenTB") != null)
            {
                k1 |= 0x8000L;
            }
            if(h.get("NodeOPublicTB") != null)
            {
                k1 |= 0x4000L;
            }
            if(h.get("NodeOPerTB") != null)
            {
                k1 |= 0x2000L;
            }
            if(h.get("NodeOShowTalkback") != null)
            {
                k1 |= 0x200L;
            }
            if(h.get("NodeONeedLogin") != null)
            {
                k1 |= 0x1000L;
            }
            if(h.get("NodeONeedAuditing") != null) // ////////
            {
                k1 |= 0x20L;
            }
            if(h.get("NodeOPrevNext") != null)
            {
                k1 |= 0x800L;
            }
            if(h.get("NodeOAllowSub") != null)
            {
                k1 |= 0x400L;
            }
            if(h.get("NodeOAccessMember") != null)
            {
                k1 |= 0x100L;
            }
//            if(h.get("TextOrHtml").equals("1"))
//            {
//                k1 |= 0x40L;
//            }
            if(h.get("CBAddToBriefcase") != null)
            {
                k1 |= 0x100000000L;
            }
            if(h.get("CBAddToFavorites") != null)
            {
                k1 |= 0x200000000L;
            }
            if(h.get("CBAddToContact") != null)
            {
                k1 |= 0x400000000L;
            }
            if(h.get("CBAddToReminder") != null)
            {
                k1 |= 0x800000000L;
            }
            if(h.get("CBForward") != null)
            {
                k1 |= 0x1000000000L;
            }
            if(h.get("CBReplyToCreator") != null)
            {
                k1 |= 0x2000000000L;
            }
            int i2 = 0;
            //时、分
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("HH"); //时
            SimpleDateFormat sdf2 = new SimpleDateFormat("mm"); //时
            //System.out.println(sdf.format(d));
            ///跳转节点
            String accessmembersnode = h.get("accessmembersnode");
            try
            {
                i2 = Integer.parseInt(h.get("Sequence"));
            } catch(Exception exception2)
            {
            }
            Date date1 = null;
            Date date3 = null;
            try
            {
                //  date1 = TimeSelection.makeTime(h.get("StartYear"),h.get("StartMonth"),h.get("StartDay"),h.get("StartHour"),h.get("StartMinute"));
                // date3 = TimeSelection.makeTime(h.get("StopYear"),h.get("StopMonth"),h.get("StopDay"),h.get("StopHour"),h.get("StopMinute"));
                date1 = TimeSelection.makeTime(h.get("StartYear"),h.get("StartMonth"),h.get("StartDay"),sdf.format(d),sdf2.format(d));
                date3 = TimeSelection.makeTime(h.get("StopYear"),h.get("StopMonth"),h.get("StopDay"),sdf.format(d),sdf2.format(d));

            } catch(Exception ex)
            {
            }
            int j2 = 1;
            try
            {
                j2 = Integer.parseInt(h.get("DefaultLanguage"));
            } catch(NumberFormatException ex1)
            {
            }
            int l2 = Integer.parseInt(h.get("frametemplate"));
            String s3 = h.get("Subject");
            String s5 = h.get("Keywords");
            String description = h.get("description");
            String content = h.get("content");
            boolean srccopy = h.get("srccopy") != null;
            if(srccopy)
            {
                content = Caiji.img(h,content);
            }
            String s9 = h.get("Alt");
            int j3 = 0; // Integer.parseInt(h.get("Align"));
            String s13 = h.get("ClickUrl");
            String s14 = h.get("SrcUrl");
            String s15 = h.get("SrcUrlx");
            //
            String picture = h.get("Picture");
            if(h.getBool("ClearPicture"))
                picture = "";
            //
            String voice = h.get("Voice");
            if(h.getBool("ClearVoice"))
                voice = "";
            //
            String file = h.get("file");
            String mms = h.get("Mms");
            if(mms != null)
            {
                File f1 = new File(application.getRealPath(mms));
                mms = "/res/" + h.community + "/netdiskmms/node/" + System.currentTimeMillis() + ".wmv";
                File f2 = new File(application.getRealPath(mms));
                f2.getParentFile().mkdirs();
                f1.renameTo(f2);
                //mms = write(node.getCommunity(),"netdiskmms/node",Filex.read(mms),".wmv");
            } else if(h.get("ClearMms") != null)
            {
                mms = "";
            }
            Date date5 = TimeSelection.makeTime(h.get("IssueYear"),h.get("IssueMonth"),h.get("IssueDay"),sdf.format(d),sdf2.format(d));
            //TimeSelection.makeTime(h.get("IssueYear"),h.get("IssueMonth"),h.get("IssueDay"),h.get("IssueHour"),h.get("IssueMinute"));
            int style = Integer.parseInt(h.get("Style"));
            int root = Integer.parseInt(h.get("Root"));
            int kstyle = Integer.parseInt(h.get("kstyle"));
            int kroot = Integer.parseInt(h.get("kroot"));
            String clickurl = h.get("clickurl");
            if(s3.length() == 0)
            {
                s3 = "(No subject)";
            }
            if(!isNew) //修改
            {
                if(clickurl.indexOf("=" + h.node) != -1) // 如果,重定向到当前节点上.把url清空.
                {
                    clickurl = "";
                }
                node.set(i2,k1,j2,node.getStartTime(),date3,h.language,s3.trim(),s5,description,content,picture,s9,j3,voice,clickurl,s14,s15,"",file,date5,style,root,kstyle,kroot,mms);
                node.setTemplate(h.node,l2);
                Logs.create(s1,rv,2,h.node,s3);
                node.set("accessmembersnode",String.valueOf(node.accessmembersnode = accessmembersnode));
                //添加类别
                int categorytype = 0; //Integer.parseInt(h.get("categorytype"));
                if(h.get("categorytype") != null && h.get("categorytype").length() > 0)
                {
                    categorytype = Integer.parseInt(h.get("categorytype"));
                }
                if(node.getType() == 1 && categorytype > 0) //说明是类别
                {
                    Category category = Category.find(h.node);
                    category.set(categorytype,0,0,null,0);
                }
            } else //添加
            {
                int k4 = i1 != 0 ? node2.getOptions1() : 0;
                h.node = Node.create(l,i2,s1,rv,j,flag7,k1,k4,j2,date1,date3,date5,style,root,kstyle,kroot,null,h.language,s3,s5,description,content,picture,s9,j3,voice,clickurl,s14,s15,"",file,mms);
                node.setTemplate(h.node,l2);
                Node n = Node.find(h.node);
                n.set("accessmembersnode",n.accessmembersnode = accessmembersnode);
                int categorytype = 0;
                if(h.get("categorytype") != null && h.get("categorytype").length() > 0)
                {
                    categorytype = Integer.parseInt(h.get("categorytype"));
                }
                //添加类别
                if(n.getType() == 1 && categorytype > 0) //说明是类别
                {
                    Category category = Category.find(h.node);
                    category.set(categorytype,0,0,null,0);
                }
                //判断是否传过来 “隐藏” 的值  --医疗粒子
                String isHidden = h.get("isHidden","");
                if(isHidden!=null&&isHidden.length()>0)
                	n.set("hidden", isHidden);
            }

            if(l2 != 0)
            {
                Node.clone(l2,h.node,true,true, -1,teasession._rv,null);
            }
            int styletemplate = Integer.parseInt(h.get("styletemplate"));
            if(styletemplate != 0)
            {
                Enumeration enumeration = CssJs.findByNode(h.node);
                while(enumeration.hasMoreElements())
                {
                    int cssjs_id = ((Integer) enumeration.nextElement()).intValue();
                    CssJs cssjs_obj = CssJs.find(cssjs_id);
                    for(int i = 0;i < Common.LANGUAGE.length;i++)
                    {
                        cssjs_obj.delete(i);
                    }
                }
                CssJs cssjs_obj = CssJs.find(styletemplate).clone();
                cssjs_obj.styletype = 2;
                cssjs_obj.stylecategory = 255;
                cssjs_obj.node = h.node;
                cssjs_obj.set();
            }
            delete(node);
            String s24 = "<a href='/servlet/Node?node=" + h.node + "'>" + s3 + "</a><br>" + h.get("Text");
            String s25 = "<a href='http://" + request.getServerName() + "/servlet/Node?node=" + h.node + "'>" + s3 + "</a><br>" + h.get("Text");
            boolean flag9 = h.get("MsgOSendMessage") != null;
            boolean flag10 = h.get("MsgOSendEmail") != null;
            int i5 = 0;
            // if (flag9)
            // {
            // if (flag10)
            // {
            // i5 = Message.create(h.community, teasession._rv, null, false, 0, 2, 0, s20, null, null, null, null, h.language, s3, s25, picture, voice, filename, file);
            // } else
            // {
            // i5 = Message.create(h.community, teasession._rv, null, false, 0, 0, 0, s20, null, null, null, null, h.language, s3, s25, picture, voice, filename, file);
            // }
            // } else if (flag10)
            // {
            // i5 = Message.create(h.community, null, s26, false, 0, 2, 0, s20, null, null, null, null, h.language, s3, s25, picture, voice, filename, file);
            // }
            if(flag10)
            {
                // try
                // {
                // Robot.activateRobot(i5);
                // } catch (Exception exception3)
                // {
                // }
            }
            if(h.get("GoNext") != null)
            {
                String fname;
                if(j >= 1024)
                {
                    fname = "DynamicValue";
                } else
                {
                    fname = Node.NODE_TYPE[j];
                }
                java.io.File f = new File(getServletContext().getRealPath("/jsp/type/" + fname.toLowerCase() + "/Edit" + fname + ".jsp"));
                if(f.exists())
                {
                    response.sendRedirect("/jsp/type/" + fname.toLowerCase() + "/Edit" + fname + ".jsp?node=" + h.node);
                } else
                {
                    switch(j)
                    {
                    case 3: // 投票
                        response.sendRedirect("/jsp/type/poll/EditPoll.jsp?node=" + h.node);
                        return;
                    case 30: // 融资信息
                        response.sendRedirect("/jsp/type/financing/EditFinancing.jsp?node=" + h.node);
                        return;
                    case 34: // 物品
                        response.sendRedirect("/jsp/type/goods/EditGoods.jsp?node=" + h.node);
                        return;
                    case 42: // 招聘
                        response.sendRedirect("/jsp/type/application/EditApp.jsp?node=" + h.node);
                        return;
                    case 50: // job
                        String copynode;
                        if(h.get("copynode") != null)
                        {
                            copynode = "&copynode=" + h.get("copynode");
                        } else
                        {
                            copynode = "";
                        }
                        response.sendRedirect("/jsp/type/job/EditJob.jsp?node=" + h.node + copynode);
                        return;
                    case 51: // 投资信息
                        response.sendRedirect("/jsp/type/investor/EditInvestor.jsp?node=" + h.node);
                        return;
                    case 52: // 简历Resume
                    }
                }
                return;
            }
            node.finished(h.node);
            String nexturl = h.get("nexturl");
            if(nexturl != null && !nexturl.equals("null"))
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("Node?node=" + h.node);
            }
        } catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/EditNode");
    }
}
