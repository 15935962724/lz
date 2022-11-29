package tea.ui.node.type.bbs;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.*;
import tea.entity.RV;
import tea.entity.admin.AdminUsrRole;
import tea.entity.bbs.BBSAttach;
import tea.entity.bbs.BBSForum;
import tea.entity.member.Profile;
import tea.entity.member.ProfileBBS;
import tea.entity.node.AccessMember;
import tea.entity.node.*;
import tea.entity.node.Category;
import tea.entity.node.Forum;
import tea.entity.node.Node;
import tea.entity.site.Community;
import tea.entity.site.Subscriber;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import jxl.write.*;
import jxl.format.*;
import tea.entity.bbs.*;
import tea.entity.site.Html;
import java.util.regex.Pattern;
import tea.entity.site.Communitybbs;


public class EditBBS extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("/tea/resource/BBS");
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        HttpSession session = request.getSession(true);
        String act = h.get("act","");
        if("activityexp".equals(act))
        {
            try
            {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment; filename=" + new String("导出.xls".getBytes("GBK"),"ISO-8859-1"));
                Node node = Node.find(h.node);
                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = wwb.createSheet("工作表",0);
                ws.setColumnView(0,20);
                ws.setColumnView(1,20);
                ws.setColumnView(2,20);
                ws.setColumnView(3,20);
                ws.setRowView(0,500);
                ws.mergeCells(0,0,4,0);
                WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                ws.addCell(new Label(0,0,node.getSubject(h.language),cf));
                int j = 0;
                cf = new WritableCellFormat();
                cf.setBackground(Colour.GRAY_25);
                ws.addCell(new Label(j++,1,"申请者",cf));
                ws.addCell(new Label(j++,1,"联系方式",cf));
                ws.addCell(new Label(j++,1,"留言",cf));
                ws.addCell(new Label(j++,1,"每人花销",cf));
                ws.addCell(new Label(j++,1,"申请时间",cf));
                ws.addCell(new Label(j++,1,"状态",cf));
                Iterator it = BBSActivity.find(" AND node=" + h.node,0,Integer.MAX_VALUE).iterator();
                for(int i = 2;it.hasNext();i++)
                {
                    BBSActivity t = (BBSActivity) it.next();
                    j = 0;
                    ws.addCell(new Label(j++,i,t.member));
                    ws.addCell(new Label(j++,i,t.contact));
                    ws.addCell(new Label(j++,i,t.remark));
                    ws.addCell(new Label(j++,i,t.payment == 0 ? "自费" : t.cost + "元"));
                    ws.addCell(new Label(j++,i,MT.f(t.time,1)));
                    ws.addCell(new Label(j++,i,t.STATE_TYPE[t.state]));
                }
                wwb.write();
                wwb.close();
            } catch(Exception ex)
            {}
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            //屏蔽广告机////
            String phone = h.get("phone");
            if("021-88765832".equals(phone))
                return;
            TeaSession teasession = new TeaSession(request);
            if("poll".equals(act)) //投票
            {
                if(teasession._rv == null)
                {
                    out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                    return;
                }
                BBS b = BBS.find(h.node,h.language);
                b.setVote(++b.vote);
                String[] arr = h.getValues("question");
                for(int i = 0;i < arr.length;i++)
                {
                    BBSPoll bp = BBSPoll.find(Integer.parseInt(arr[i]));
                    bp.member += teasession._rv.toString() + "|";
                    bp.hits++;
                    bp.set();
                }
            } else if("activityadd".equals(act)) //活动
            {
                if(teasession._rv == null)
                {
                    out.print("<script>mt.show('对不起，您还未登录，无法进行此操作。',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                    return;
                }
                BBSActivity a = new BBSActivity(0);
                a.node = h.node;
                a.member = teasession._rv.toString();
                a.payment = h.getInt("payment");
                if(a.payment == 1)
                    a.cost = h.getFloat("cost");
                a.contact = h.get("contact");
                a.remark = h.get("remark");
                a.time = new Date();
                a.set();
            } else if("activity".equals(act))
            {
                Node node = Node.find(h.node);
                if(!node.isCreator(teasession._rv))
                {
                    out.print("<script>mt.show('对不起，您没有此权限，无法进行此操作。',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                    return;
                }
                BBSForum bf = BBSForum.find(node.getFather());
                String op = h.get("op");
                String[] arr = h.getValues("bbsactivity");
                for(int i = 0;i < arr.length;i++)
                {
                    BBSActivity ba = BBSActivity.find(Integer.parseInt(arr[i]));
                    if("del".equals(op))
                        ba.delete();
                    else
                    {
                        ba.set("state","1");
                        //更新积分
                        BBSPoint bp = new BBSPoint(0);
                        bp.member = ba.member;
                        bp.point = bf.ajoin;
                        bp.node = h.node;
                        bp.type = 10;
                        bp.set();
                    }
                }
            } else if("edit".equals(act))
            {
                Node node = Node.find(h.node);
                boolean NewNode = h.get("NewNode") != null;
                if(NewNode)
                {
                    if(node.getType() == 57)
                    {
                        node = Node.find(node.getFather());
                        h.node = node._nNode;
                    }
                }
                h.username = teasession._rv != null ? teasession._rv._strR : null;
                int forum = NewNode ? node._nNode : node.getFather(); //坛子的ID
                BBSForum bf = BBSForum.find(forum);
                int point = 0;

                Forum fc = Forum.find(node.getCommunity());
                if((node.getOptions1() & 1) == 0)
                {
                    if(teasession._rv == null)
                    {
                        out.print("<script>window.open('/servlet/StartLogin?node=" + h.node + "','_parent');</script>");
                        return;
                    }
                    // !创建者 && 提供者57 && 当前论坛要审核 && 当前会员审核
                    if(!node.isCreator(teasession._rv) && !AccessMember.find(h.node,teasession._rv._strV).isProvider(57) && fc.getAuditing() != null && fc.getAuditing().indexOf("/" + node._nNode + "/") != -1 && Subscriber.find(node.getCommunity(),teasession._rv).getOptions() != 2)
                    {
                        out.print("<script>mt.show('您无权在本论坛发贴!');</script>");
                        return;
                    }
                    Profile pobj = Profile.find(teasession._rv._strR);

                    if((pobj.getBbspermissions() != null) && pobj.getBbspermissions().length() > 0 && (pobj.getBbspermissions().indexOf("/" + h.node + "/") == -1)) // &&
                    // (     //  AdminUsrRole.find(h.community, teasession._rv._strR).getBbs()!=null &&
                    //AdminUsrRole.find(h.community, teasession._rv._strR).getBbs().length()>0 &&
                    //	AdminUsrRole.find(h.community, teasession._rv._strR).getBbs().indexOf("/" + Node.find(h.node).getFather() + "/") == -1))
                    {
                        out.print("<script>mt.show('您没有权限在这个版块发贴.');</script>");
                        return;
                    }

                    // 邮箱验证
                    String valid = fc.getValidate();
                    if(valid != null && valid.indexOf("/" + node._nNode + "/") != -1)
                    {
                        ProfileBBS pb = ProfileBBS.find(h.community,teasession._rv._strR);
                        if(!pb.isValidate())
                        {
                            String info = r.getString(h.language,"BBSEmailNoValidate") + new tea.html.Break().toString() + new tea.html.Break().toString() + new tea.html.Button("newsend",r.getString(h.language,"NewSend"),"window.location='" + request.getContextPath() + "/servlet/EditProfileBBS?node=" + h.node + "&sendaffirmemail=ON';").toString();
                            info = URLEncoder.encode(info,"UTF-8");
                            out.print("<script>window.open('/jsp/info/Alert.jsp?info=" + info + "','_parent');</script>");
                            return;
                        }
                    }
                    if(fc.getWait() > 0)
                    {
                        Profile profile = Profile.find(teasession._rv._strR);
                        if((System.currentTimeMillis() - profile.getTime().getTime()) < fc.getWait() * 60 * 1000)
                        {
                            out.print("<script>mt.show('" + fc.getWait() + r.getString(h.language,"WaitCannotAppear") + "');</script>");
                            return;
                        }
                    }
                } else if(teasession._rv == null)
                {
                    teasession._rv = RV.ANONYMITY;
                }
                //验证码
                String vertify = fc.getVertify();
                if(vertify != null && vertify.indexOf("/" + node._nNode + "/") != -1)
                {
                    String v = (String) session.getAttribute("sms.vertify");
                    session.removeAttribute("sms.vertify");
                    if(v == null || !v.equalsIgnoreCase(h.get("vertify")))
                    {
                        out.print("<script>mt.show('验证码错误！');</script>");
                        return;
                    }
                }

                ///////////////////
                String subject = h.get("Subject");
                if(subject == null || subject.length() == 0)
                {
                    out.print("<script>mt.show('您上传的贴子，需要填写主题。');</script>");
                    return;
                }
                String text = h.get("content");
                if(text == null || text.length() == 0)
                {
                    out.print("<script>mt.show('您上传的贴子，需要填写内容。');</script>");
                    return;
                }
                //
                if(text.getBytes().length == text.length() && text.split("<A HREF=").length > 20)
                {
                    out.print("<script>mt.show('链接太多,怀疑是广告!');</script>");
                    return;
                }

                //添加附件
                byte[] by = teasession.getBytesParameter("fdoc");

                String fileName = null;
                if(by != null)
                {
                    if(node.getFileName(1) != null && node.getFileName(1).length() > 0)
                    {
                        new File(getServletContext().getRealPath(node.getFileName(1))).delete();
                    }
                    String value = h.get("file");
                    String ex = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
                    fileName = write(h.community,"BBS/" + teasession._rv + "_" + subject,by,"." + ex);
                    String errPath = getServletContext().getRealPath(fileName);
                    if(new File(errPath).length() / 1024 / 1024 > 5)
                    {
                        new File(errPath).delete();
                        fileName = null;
                        System.out.println("不合标准附件删除成功");
                    }

                }

                ////////
                Community community = Community.find(node.getCommunity());
                if(Pattern.compile(community.filtrate.replace(',','|')).matcher(text).find())
                {
                    out.print("<script>mt.show('内容中含有敏感字符! 请重新填写!');</script>");
                    return;
                }

                if(h.get("nonuse") != null)
                {
                    text = text.replaceAll("\r\n","<br/>");
                }

                if(NewNode)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = node.getOptions1();
                    long options = node.getOptions();
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(h.node);
                    h.node = Node.create(h.node,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,h.language,subject,"","",text,null,"",0,null,"","","",fileName,null,null);
                    node = Node.find(h.node);
                    node.finished(h.node);

                    //更新论坛附件的ID
                    point += BBSAttach.setBbsid(false,h.username != null ? h.username : session.getId(),h.node) * bf.attach;
                } else
                {
                    node.set(h.language,subject,text,fileName);
                }
                String tmp = h.get("Hint");
                int hint = tmp == null ? 0 : Integer.parseInt(tmp);
                String ip = Entity.getIpAddr(request); //request.getRemoteAddr();
                tmp = h.get("special");
                int special = tmp == null ? 0 : Integer.parseInt(tmp);
                //投票
                boolean multiple = h.get("multiple") != null;
                tmp = h.get("expiration");

                int expiration = tmp == null ? 0 : (tmp.length() < 1 ? 7 : Integer.parseInt(tmp));
                boolean visibility = h.get("visibility") != null;
                boolean overt = h.get("overt") != null;
                Iterator it = BBSPoll.find(" AND node=" + h.node,0,20).iterator();
                while(it.hasNext())
                {
                    BBSPoll bp = (BBSPoll) it.next();
                    bp.question = h.get("question" + bp.bbspoll);
                    if(bp.question == null)
                        bp.delete();
                    else
                        bp.set();
                }
                String[] arr = h.getValues("question");
                if(arr != null)
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        if(arr[i].length() < 1)
                            continue;
                        BBSPoll t = new BBSPoll(0);
                        t.node = h.node;
                        t.question = arr[i];
                        t.set();
                    }
                }
                //活动
                Date starttime = h.getDate("starttime");
                String place = h.get("place");
                String category = h.get("category");
                float cost = h.getFloat("cost");
                String city = h.get("city");
                int number = h.getInt("number");
                int sex = h.getInt("sex");
                Date exptime = h.getDate("exptime");
                //招聘
                int wage = h.getInt("wage");
                int icity = h.getInt("icity1",h.getInt("icity0"));
                String professional = h.get("professional");
                String requires = h.get("requires");
                //求职
                int age = h.getInt("age");
                int experience = h.getInt("experience");
                int jobtype = h.getInt("jobtype");
                int jobmodel = h.getInt("jobmodel");

                //留言板
                String name = h.get("name");
                String email = h.get("email");
                String area = h.get("area");
                String address = h.get("address");
                if(NewNode)
                {
                    BBS.create(h.node,h.language,hint,ip,name,phone,email,area,address,special,multiple,expiration,visibility,overt,starttime,place,category,cost,city,number,sex,exptime,wage,icity,professional,requires,age,experience,jobtype,jobmodel);
                    BBS.find(h.node,h.language).setSearch(0);
                    //发贴数量+1
                    ProfileBBS pb = ProfileBBS.find(h.community,teasession._rv._strR);
                    pb.set("post",String.valueOf(pb.post + 1));

                    //更新积分
                    BBSPoint bp = new BBSPoint(0);
                    bp.member = teasession._rv._strR;
                    bp.point = special == 2 ? bf.activity : bf.topic;
                    bp.node = h.node;
                    bp.type = special == 2 ? 9 : 1;
                    bp.set();
                    if(point > 0) //上传附件
                    {
                        bp = new BBSPoint(0);
                        bp.member = teasession._rv._strR;
                        bp.point = point;
                        bp.node = h.node;
                        bp.type = 7;
                        bp.set();
                    }
                } else
                {
                    BBS bbs = BBS.find(h.node,h.language);
                    bbs.set(hint,ip,name,phone,email,area,address,teasession._rv._strR,special,multiple,expiration,visibility,overt,starttime,place,category,cost,city,number,sex,exptime,wage,icity,professional,requires,age,experience,jobtype,jobmodel);
                }
                delete(node);
            } else
            {
                int node = h.getInt("node");
                String[] nodes = node > 0 ? new String[]
                                 {String.valueOf(node)}
                                 : h.getValues("nodes"); //BBSManage.jsp
                if(nodes != null)
                {
                    boolean isS = teasession._rv._strR.equals(Communitybbs.find(teasession._strCommunity).getSuperhost()); //超级版主
                    String forums = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getBbsHost();
                    for(int index = 0;index < nodes.length;index++)
                    {
                        int nid = Integer.parseInt(nodes[index]);
                        Node n = Node.find(nid);

                        boolean isD = isS || forums.indexOf("/" + n.getFather() + "/") != -1;

                        Profile p = Profile.find(n.getCreator()._strR);
                        if("del".equals(act))
                        {
                            h.node = n.getFather();
                            //更新积分
                            BBSPoint bp = new BBSPoint(0);
                            bp.member = p.getMember();
                            bp.point = -BBSForum.find(h.node).del;
                            bp.node = nid;
                            bp.type = 3;
                            bp.set();
                            //删除
                            n.delete(h.language);
                        } else
                        {
                            if(!isD)
                            {
                                out.print("<script>alert('抱歉，您无权执行该操作！');</script>");
                                return;
                            }
                            if("locking".equals(act))
                            {
                                BBS obj = BBS.find(nid,h.language);
                                obj.setLocking(!obj.locking);
                            } else if("parktop".equals(act))
                            {
                                BBS obj = BBS.find(nid,h.language);
                                obj.setParktop(!obj.isParktop());
                                //更新积分
                                if(obj.isParktop())
                                {
                                    BBSPoint bp = BBSPoint.find(nid,17);
                                    bp.member = p.getMember();
                                    bp.point = BBSForum.find(n.getFather()).parktop;
                                    bp.node = nid;
                                    bp.type = 17;
                                    bp.set();
                                }
                            } else if("quintessence".equals(act))
                            {
                                BBS obj = BBS.find(nid,h.language);
                                obj.setQuintessence(!obj.isQuintessence());
                                //更新积分
                                if(obj.isQuintessence())
                                {
                                    BBSPoint bp = BBSPoint.find(nid,5);
                                    bp.member = p.getMember();
                                    bp.point = BBSForum.find(n.getFather()).qui;
                                    bp.node = nid;
                                    bp.type = 5;
                                    bp.set();
                                }
                            } else if("move".equals(act))
                            {
                                int forum = Integer.parseInt(request.getParameter("forum"));
                                if(forum == n.getFather())
                                    continue;
                                //
                                n.move(forum,false);
                                //更新积分
                                BBSPoint bp = new BBSPoint(0);
                                bp.member = p.getMember();
                                bp.point = -BBSForum.find(n.getFather()).move;
                                bp.node = nid;
                                bp.type = 4;
                                bp.set();
                            } else if("hidden_s".equals(act)) //审核
                            {
                                if(n.isHidden())
                                {
                                    n.setHidden(false);
                                } else
                                {
                                    n.setHidden(true);
                                }
                                n.setUpdatetime(new Date());
                                delete(n);
                            } else if("search".equals(act)) // 查阅
                            {
                                BBS obj = BBS.find(nid,h.language);
                                obj.setSearch(1);
                                obj.setSearch(teasession._rv._strR,new java.util.Date());
                            } else if("custom".equals(act))
                            {
                                BBSPoint bp = new BBSPoint(0);
                                bp.member = p.getMember();
                                bp.point = h.getInt("point");
                                bp.node = nid;
                                bp.type = 16;
                                bp.content = h.get("content");
                                bp.set();
                            }
                        }
                    }
                }
            }
            String nexturl = h.get("nexturl");
            if(nexturl == null)
                nexturl = "/html/" + h.community + "/bbs/" + h.node + "-" + h.language + ".htm";
            out.print("<script>window.open('" + nexturl + "','_parent');</script>");
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
