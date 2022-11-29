package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.db.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import java.text.*;
import tea.resource.Resource;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.ui.TeaServlet;
import tea.ui.member.profile.newcaller;

import java.sql.SQLException;
import jxl.write.*;

public class EditWorkreport extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Workreport");
    }

    // Process the HTTP Get teasession
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try
        {
            //TeaSession teasession = new TeaSession(request);
        	Http h=new Http(request);
            if(h.username == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
            }
            String nexturl = h.get("nexturl");
            String action = h.get("act");
            PrintWriter out = response.getWriter();
            out.print("<script>var mt=parent.mt;</script>");
            if(action == null)
            {
                action = h.get("action");
            }
            if("editworkproject".equals(action))
            {
                int workproject = Integer.parseInt(h.get("workproject"));
                String tel = h.get("tel");
                String fax = h.get("fax");
                String url = h.get("url");
                String email = h.get("email");
                String name = h.get("name");
                String content = h.get("content");
                int type = Integer.parseInt(h.get("type"));
                int employee = Integer.parseInt(h.get("employee"));
                int calling = Integer.parseInt(h.get("calling"));
                String earning = h.get("earning");
                String country = h.get("country");
                String country2 = h.get("country2");
                String postcode = h.get("postcode");
                String postcode2 = h.get("postcode2");
                String state = h.get("state");
                String state2 = h.get("state2");
                String city = h.get("city");
                String city2 = h.get("city2");
                String street = h.get("street");
                String street2 = h.get("street2");

                if(workproject < 1)
                {
                    workproject = Workproject.create(h.community,h.username.toString(),tel,fax,url,email,name,content,type,employee,calling,earning,country,postcode,state,city,street,country2,postcode2,
                            state2,city2,street2);
                } else
                {
                    Workproject obj = Workproject.find(workproject);
                    obj.set(tel,fax,url,email,name,content,type,employee,calling,earning,country,postcode,state,city,street,country2,postcode2,state2,city2,street2);
                }
                if(h.get("newnext") != null) // 保存并新建
                {
                    response.sendRedirect("/jsp/admin/workreport/EditWorkproject.jsp?community=" + h.community + "&workproject=0&nexturl=" + nexturl);
                    return;
                }
                if(h.get("xiayibu") != null) //下一步 创建客户的项目
                {
                    response.sendRedirect("/jsp/admin/workreport/Flowitem.jsp?workproject=" + workproject);
                    return;
                }
            } else if("deleteworkproject".equals(action))
            {
                int workproject = Integer.parseInt(h.get("workproject"));
                Workproject obj = Workproject.find(workproject);
                Flowitem.delete(workproject);
                obj.delete();
            } else if("editworklinkman".equals(action)) ///////////////////////////////////////////////
            {
                // int worklinkman =
                // Integer.parseInt(h.get("worklinkman"));
                String member = h.get("member");
                String email = h.get("email");
                if(h.get("newmember") != null)
                {
                    if(Profile.isExisted(member))
                    {
                        response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您添加的用户名已存在，请选择用户！","UTF-8") + "&nexturl=/jsp/admin/workreport/Worklinkmans.jsp");
                        //response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("", "UTF-8"));
                        return;
                    }
                    String password = h.get("password");
                    String sn = request.getServerName() + ":" + request.getServerPort();
                    Profile.create(member,password,h.community,email,sn);
                }
                Profile p = Profile.find(member);
                String firstname = h.get("firstname");
                p.setFirstName(firstname,h.language);
                String lastname = h.get("lastname");
                p.setLastName(lastname,h.language);
                boolean sex = "true".equals(h.get("sex"));
                p.setSex(sex);
                Date birthday = null;
                try
                {
                    birthday = Worklinkman.sdf.parse(h.get("birthday"));
                    p.setBirth(birthday);
                } catch(ParseException ex1)
                {
                }
                String fpostcode = h.get("fpostcode");
                p.setZip(fpostcode,h.language);
                String worktel = h.get("worktel");
                p.setTelephone(worktel,h.language);
                String mobile = h.get("mobile");
                p.setMobile(mobile);
                int workproject = Integer.parseInt(h.get("workproject"));
                String ftel = h.get("ftel");
                String qicq = h.get("qicq");
                String msn = h.get("msn");
                String blog = h.get("blog");
                String name = h.get("name");
                String job = h.get("job");
                String love = h.get("love");
                String faddress = h.get("faddress");
                String content = h.get("content");

                int origin = 0;
                if(h.get("origin") != null && h.get("origin").length() > 0)
                {
                    origin = Integer.parseInt(h.get("origin"));
                }
                String hometel = h.get("hometel");
                String othertel = h.get("othertel");
                String fax = h.get("fax");
                String unit = h.get("unit");
                String assistant = h.get("assistant");
                String assistanttel = h.get("assistanttel");

                // /////////邮寄地址
                String country = h.get("country");
                String postcode = h.get("postcode");
                String state = h.get("state");
                String city = h.get("city");
                String street = h.get("street");
                // /////////其他地址
                String country2 = h.get("country2");
                String postcode2 = h.get("postcode2");
                String state2 = h.get("state2");
                String city2 = h.get("city2");
                String street2 = h.get("street2");

                //origin,hometel,othertel,unit,assistant,assistanttel
                //,country,postcode,state,city,street,country2,postcode2,state2,city2,street2
                Worklinkman obj = Worklinkman.find(h.community,member);
                if(!obj.isExists())
                {
                    Worklinkman.create(workproject,h.community,member,sex,birthday,fpostcode,worktel,ftel,mobile,email,qicq,msn,blog,name,job,love,faddress,content,origin,hometel,othertel,unit,assistant,assistanttel,country,postcode,state,city,street,country2,postcode2,state2,city2,street2,fax);
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=" + nexturl);
                    //response.sendRedirect("/jsp/admin/workreport/EditWorklinkman.jsp");
                    return;
                } else
                {

                    obj.set(workproject,sex,birthday,fpostcode,worktel,ftel,mobile,email,qicq,msn,blog,name,job,love,faddress,content,origin,hometel,othertel,unit,assistant,assistanttel,country,postcode,state,city,street,country2,postcode2,state2,city2,street2,fax);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("修改成功！","UTF-8") + "&nexturl=" + nexturl);
                    return;
                }

            } else if("deleteworklinkman".equals(action))
            {
                String member = h.get("member");
                Worklinkman obj = Worklinkman.find(h.community,member);
                obj.delete();
            } else if("editworktype".equals(action))
            {
                int worktype = Integer.parseInt(h.get("worktype"));
                String name = h.get("name");
                if(worktype < 1)
                {
                    Worktype.create(h.community,name);
                } else
                {
                    Worktype obj = Worktype.find(worktype);
                    obj.set(name);
                }
            } else if("deleteworktype".equals(action))
            {
                int worktype = Integer.parseInt(h.get("worktype"));
                Worktype obj = Worktype.find(worktype);
                obj.delete();
            } else if("editworklog".equals(action)) //添加工作日志
            {
                String _strTime = h.get("time");
                Date time = null;
                try
                {
                    time = Worklog.sdf2.parse(_strTime + " " + h.get("hour") + ":" + h.get("minute"));
                } catch(ParseException ex1)
                {
                    time = new java.util.Date();
                }
                for(int j=1;j<=20;j++){
                	if(h.get("worklog"+j)!=null){
                		int worklog=h.getInt("worklog"+j,0);
                		int workproject=h.getInt("workproject"+j);
                        String worklinkman = h.get("worklinkman"+j);
                		boolean publicity = h.get("publicity"+j) != null;
                        //if sumupreport
                        boolean sumupreport = h.get("sumupreport"+j) != null;
                        boolean problemreport = h.get("problemreport"+j) != null;
                        //
                        int worktype = Integer.parseInt(h.get("worktype"+j));
                        String content = h.get("content"+j);
                        String expand;
                        String path = null,accessories = null;
                        byte by[] = null;
                        boolean clearfile = h.get("ClearFile"+j) == null;
                        if(clearfile)
                        {
                            accessories=h.get("accessories"+j);
                            if(accessories != null)
                            {
                                path = accessories;
                            }
                        }
                        if(content != null && content.length() > 3000)
                        {
                            content = content.substring(0,3000);
                        }
                        int states = Integer.parseInt(h.get("states"+j));
                        boolean tomember_check = h.get("tomember_check"+j) != null;
                        String tomember = null;
                        if(tomember_check)
                        {
                            tomember = h.get("tomember"+j);
                        }
                        //耗时的接受参数
                        int wearhours = h.getInt("wearhours"+j,0); //小时
                        int wearminutes = h.getInt("wearminutes"+j,0); //分钟
                        if(worklog < 1)
                        {
                            worklog = Worklog.create(h.community,h.username,workproject,worklinkman,worktype,time,publicity,content,states,tomember,accessories,path,sumupreport,problemreport,wearhours,wearminutes);
                        } else
                        {
                            Worklog obj = Worklog.find(worklog);
                            String to = obj.getToMember();
                            if(tomember != null)
                            {
                                to = obj.getToMember() + ";" + tomember;
                            }
                            obj.set(workproject,worklinkman,worktype,time,publicity,content,states,to,sumupreport,problemreport,wearhours,wearminutes);
                            if(!clearfile || by != null)
                            {
                                obj.set(accessories,path);
                            }
                        }
                        if(tomember_check && tomember.length() > 0)
                        {
                            String tms[] = tomember.split(";");
                            for(int i = 0;i < tms.length;i++)
                            {
                                if(tms[i].length() > 0)
                                {
                                    Profile p_to = Profile.find(tms[i]);
                                    if(p_to.getEmail().indexOf("@") != -1)
                                    {
                                        // String _strTime = Worklog.sdf.format(time);
                                        Profile p = Profile.find(h.username);
                                        //String url = "http://" + request.getServerName() + ":" + request.getServerPort() + "/jsp/admin/workreport/Worklogs_4.jsp;jsessionid=" + request.getSession().getId()                                           + "?member=" + java.net.URLEncoder.encode(h.username, "UTF-8") + "&tomember=" + java.net.URLEncoder.encode(tms[i], "UTF-8") + "&worklog=" + worklog;
                                        String str = content(h.community,h.language,tms[i],new String[]
                                                {h.username},new int[]
                                                {worklog},null);
        								Email.create(h.community,null,p_to.getEmail(),p.getName(h.language) + " 于 " + _strTime + " 工作日志",str);
                                    }
                                }
                            }
                        }
                        
                	}
                	
                    
                }
                /*String worklogs[]=h.getValues("worklog");
                String workprojects[]=h.getValues("workproject");
                String worklinkmans[] = h.getValues("worklinkman");
                String publicitys[]=h.getValues("publicity");
                String sumupreports[]=h.getValues("sumupreport");
                String problemreports[]=h.getValues("problemreport");
                String worktypes[]=h.getValues("worktype");
                String contents[]=h.getValues("content");
                String ClearFiles[]=h.getValues("ClearFile");
                String statess[]=h.getValues("states");
                String wearhourss[]=h.getValues("wearhours");
                String wearminutess[]=h.getValues("wearminutes");
                if(workprojects!=null){
                	for(int i=0;i<worklogs.length;i++){
                		int workproject = Integer.parseInt(workprojects[i]);
                		int states = Integer.parseInt(statess[i]);
                		int worktype = Integer.parseInt(worktypes[i]);
                		String content=contents[i];
                		String worklinkman=worklinkmans[i];
                		int wearhours=Integer.parseInt(wearhourss[i]);
                		int wearminutes=Integer.parseInt(wearminutess[i]);
                		int worklog=Integer.parseInt(worklogs[i]);
                		if(worklog < 1)
                        {
                            worklog = Worklog.create(h.community,h.username,workproject,worklinkman,worktype,time,false,content,states,"","","",false,false,wearhours,wearminutes);
                        } else
                        {
                            Worklog obj = Worklog.find(worklog);
                            String to = obj.getToMember();
                            if(tomember != null)
                            {
                                to = obj.getToMember() + ";" + tomember;
                            }
                            obj.set(workproject,worklinkman,worktype,time,false,content,states,to,false,false,wearhours,wearminutes);
                            if(!clearfile || by != null)
                            {
                                obj.set(accessories,path);
                            }
                        }
                	}
                	
                }*/
               RobotSendWorklog.activateRobot();
                out.print("<script>mt.show('操作成功！',1,'"+nexturl+"');</script>");
                return;
            } else if("deleteworklog".equals(action))
            {
                int worklog = Integer.parseInt(h.get("worklog"));
                Worklog obj = Worklog.find(worklog);
                obj.delete();
//                out.print("<script>mt.show('操作成功！',1,'"+nexturl+"');</script>");
//                return;
            } else if("deleteAccessories".equals(action))
            {
                int worklog = Integer.parseInt(h.get("worklog"));
                Worklog obj = Worklog.find(worklog);
                obj.set(null,null);
            } else if("exportworklogs".equals(action))
            {
                //2009-9-18 zhangjinshu 修改程序

                String sql = request.getParameter("sql");
                String files = "工作日志";

                response.setContentType("application/x-msdownload");
                response.reset();
                response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode(files + ".xls","UTF-8"));
                
                javax.servlet.ServletOutputStream os = response.getOutputStream();

                WritableWorkbook ww = jxl.Workbook.createWorkbook(os);
                WritableSheet ws = ww.createSheet(files,0);
                WritableCellFormat wcf = new WritableCellFormat(new WritableFont(WritableFont.TIMES,9,WritableFont.BOLD,false));
                wcf.setAlignment(jxl.format.Alignment.CENTRE);
                ws.setColumnView(0,12);
                ws.setColumnView(1,80);
                ws.setColumnView(2,30);
                ws.setColumnView(3,15);
                try
                {
                    int i = 0;
                    Enumeration e;
                    String worklogs[] = h.getValues("worklog");
                    if(worklogs == null) // s说明是全部 导出日志
                    {
                        e = Worklog.find(h.community,sql.toString(),0,Integer.MAX_VALUE);
                    } else
                    {
                        Vector v = new Vector();
                        for(int is = 0;is < worklogs.length;is++)
                        {
                            v.add(Integer.parseInt(worklogs[is]));
                        }
                        e = v.elements();
                    }

                    ws.addCell(new jxl.write.Label(0,i,"提交时间",wcf));
                    ws.addCell(new jxl.write.Label(1,i,"日志内容",wcf));
                    ws.addCell(new jxl.write.Label(2,i,"客户或项目",wcf));
                    ws.addCell(new jxl.write.Label(3,i,"联系人",wcf));
                    ws.addCell(new jxl.write.Label(4,i,"工作类型",wcf));
                    ws.addCell(new jxl.write.Label(5,i,"用户",wcf));
                    ws.addCell(new jxl.write.Label(6,i,"耗时",wcf));
					ws.getSettings().setVerticalFreeze(++i);

                    for(int index = 1;e.hasMoreElements();index++,i++)
                    {

                        int worklog = ((Integer) e.nextElement()).intValue();
                        Worklog obj = Worklog.find(worklog);
                        int flow = obj.getWorkproject();

                        Flowitem fobj = Flowitem.find(flow);
//							//联系人
//							Worklinkman wkmobj = Worklinkman.find(h.community,obj.getWorklinkman());
                        Worktype wyobj = Worktype.find(obj.getWorktype());
                        String hs = String.valueOf(obj.getWearHours()) + "小时" + String.valueOf(obj.getWearMinutes()) + "分";
                        ws.addCell(new jxl.write.Label(0,i,obj.getTimeToString()));
                        ws.addCell(new jxl.write.Label(1,i,obj.getContent(h.language)));
                        ws.addCell(new jxl.write.Label(2,i,fobj.getName(h.language)));
                        ws.addCell(new jxl.write.Label(3,i,obj.getWorklinkman()));
                        ws.addCell(new jxl.write.Label(4,i,wyobj.getName(h.language)));
                        ws.addCell(new jxl.write.Label(5,i,Profile.find(obj.getMember()).getName(h.language)));
                        ws.addCell(new jxl.write.Label(6,i,hs));
                    }
                    ww.write();
                    ww.close();
                    os.close();
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                    response.sendError(500,ex.toString());
                }

//                Enumeration e;
//                Resource r = new Resource("/tea/resource/Workreport");
//                String worklogs[] = h.getValues("worklog");
//                if(worklogs == null)
//                {
//                    //response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"1168833595335"),"UTF-8")); // 无效选择
//                    //return;
//                    StringBuffer sql = new StringBuffer();
//                    sql.append(" AND member=").append(DbAdapter.cite(h.username));
//                    String tmp = request.getParameter("workproject");
//                    if(tmp != null && tmp.length() > 0)
//                    {
//                        sql.append(" AND workproject=").append(Integer.parseInt(tmp));
//                    }
//                    String worklinkman = request.getParameter("worklinkman");
//                    if(worklinkman != null && worklinkman.length() > 0)
//                    {
//                        sql.append(" AND worklinkman=").append(DbAdapter.cite(worklinkman));
//                    }
//                    tmp = request.getParameter("worktype");
//                    if(tmp != null && tmp.length() > 0)
//                    {
//                        sql.append(" AND worktype=").append(Integer.parseInt(tmp));
//                    }
//                    String time_s = request.getParameter("time_s");
//                    String time_e = request.getParameter("time_e");
//                    if(time_s != null && (time_s = time_s.trim()).length() > 0)
//                    {
//                        try
//                        {
//                            java.util.Date time = Worklog.sdf.parse(time_s);
//                            sql.append(" AND time>=").append(DbAdapter.cite(time));
//                        } catch(Exception pe)
//                        {}
//                    }
//                    if(time_e != null && (time_e = time_e.trim()).length() > 0)
//                    {
//                        try
//                        {
//                            java.util.Date time = Worklog.sdf.parse(time_e);
//                            sql.append(" AND time<").append(DbAdapter.cite(time));
//                        } catch(Exception pe)
//                        {}
//                    }
//                    String content = request.getParameter("content");
//                    if(content != null && (content = content.trim()).length() > 0)
//                    {
//                        sql.append(" AND content LIKE ").append(DbAdapter.cite("%" + content + "%"));
//                    }
//                    String order = request.getParameter("order");
//                    if(order == null)
//                    {
//                        order = "time";
//                    }
//                    String desc = request.getParameter("desc");
//                    if(desc == null)
//                    {
//                        desc = "desc";
//                    }
//                    sql.append(" ORDER BY ").append(order).append(" ").append(desc);
//                    e = Worklog.find(h.community,sql.toString(),0,Integer.MAX_VALUE);
//                } else
//                {
//                    Vector v = new Vector();
//                    for(int i = 0;i < worklogs.length;i++)
//                    {
//                        v.add(Integer.parseInt(worklogs[i]));
//                    }
//                    e = v.elements();
//                }

//                response.setContentType("application/x-msdownload");
//                response.setHeader("Content-Disposition","attachment; filename=" + System.currentTimeMillis() + ".xls");
//                java.io.OutputStream os = response.getOutputStream();
//                WritableWorkbook ww = jxl.Workbook.createWorkbook(os);
//                WritableSheet ws = ww.createSheet("SHEET",0);
//                WritableCellFormat wcf = new WritableCellFormat(new WritableFont(WritableFont.TIMES,9,WritableFont.BOLD,false));
//                wcf.setAlignment(jxl.format.Alignment.CENTRE);
//                ws.setColumnView(0,12);
//                ws.setColumnView(1,80);
//                ws.setColumnView(2,30);
//                ws.setColumnView(3,15);
//                ws.addCell(new Label(0,0,r.getString(h.language,"Time"),wcf));
//                ws.addCell(new Label(1,0,r.getString(h.language,"Text"),wcf));
//                ws.addCell(new Label(2,0,r.getString(h.language,"1168584443703"),wcf)); // 客户或项目
//                ws.addCell(new Label(3,0,r.getString(h.language,"1168584403266"),wcf)); // 联系人
//                ws.addCell(new Label(4,0,r.getString(h.language,"1168592903313"),wcf)); // 工作类型
//                ws.addCell(new Label(5,0,r.getString(h.language,"1168595223953"),wcf)); // 是否对外
//                for(int i = 0;e.hasMoreElements();i++)
//                {
//                    int worklog = ((Integer) e.nextElement()).intValue();
//                    Worklog obj = Worklog.find(worklog);
//                    ws.addCell(new Label(0,i + 1,obj.getTimeToString()));
//                    ws.addCell(new Label(1,i + 1,obj.getContent(h.language)));
//                    if(obj.getWorkproject() > 0)
//                    {
//                        ws.addCell(new Label(2,i + 1,Workproject.find(obj.getWorkproject()).getName(h.language))); // 客户或项目
//                    }
//                    if(obj.getWorklinkman() != null)
//                    {
//                        ws.addCell(new Label(3,i + 1,obj.getWorklinkman())); // 联系人
//                    }
//                    if(obj.getWorktype() > 0)
//                    {
//                        ws.addCell(new Label(4,i + 1,Worktype.find(obj.getWorktype()).getName(h.language))); // 工作类型
//                    }
//                    ws.addCell(new Label(5,i + 1,obj.isPublicity() ? "√" : "X")); // 是否对外
//                }
//                ww.write();
//                ww.close();
//                os.close();
//                return;
            } else if("exportworklogs_2".equals(action)) //查看工作日志时候的 导出功能
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition","attachment; filename=" + "exp" + ".xls");

                Resource r = new Resource("/tea/resource/Workreport");
                StringBuffer sql = new StringBuffer();
                String worklogs[] = h.getValues("worklog");
                if(worklogs != null)
                {
                    sql.append(" AND worklog IN(0");
                    for(int i = 0;i < worklogs.length;i++)
                    {
                        sql.append(",").append(worklogs[i]);
                    }
                    sql.append(")");
                }
                sql.append(" AND ( member=").append(DbAdapter.cite(h.username));
                ////////按部门和项目
                AdminUsrRole aur = AdminUsrRole.find(h.community,h.username);
                String str = aur.getClasses();
                if(str.length() > 2)
                {
                    str = str.substring(1,str.length() - 1).replace('/',',');
                    sql.append(" OR member IN (SELECT member FROM AdminUsrRole WHERE community=").append(DbAdapter.cite(h.community)).append(" AND unit IN (").append(str).append(") )").append(" or workproject IN (select workproject from worklinkman where member =" + DbAdapter.cite(h.username) + " )");
                }
                sql.append(")");
                sql.append(" ORDER BY time DESC");
                //
                java.io.OutputStream os = response.getOutputStream();
                WritableWorkbook ww = jxl.Workbook.createWorkbook(os);
                WritableSheet ws = ww.createSheet("SHEET",0);
                WritableCellFormat wcf = new WritableCellFormat(new WritableFont(WritableFont.TIMES,9,WritableFont.BOLD,false));
                wcf.setAlignment(jxl.format.Alignment.CENTRE);
                ws.setColumnView(0,12);
                ws.setColumnView(1,80);
                ws.setColumnView(2,30);
                ws.setColumnView(3,15);
                ws.addCell(new Label(0,0,r.getString(h.language,"Time"),wcf));
                ws.addCell(new Label(1,0,r.getString(h.language,"Text"),wcf));
                ws.addCell(new Label(2,0,r.getString(h.language,"1168584443703"),wcf)); // 客户或项目
                ws.addCell(new Label(3,0,r.getString(h.language,"1168584403266"),wcf)); // 联系人
                ws.addCell(new Label(4,0,r.getString(h.language,"1168592903313"),wcf)); // 工作类型
                ws.addCell(new Label(5,0,r.getString(h.language,"1168595223953"),wcf)); // 是否对外
                java.util.Enumeration enumer = Worklog.find(h.community,sql.toString(),0,Integer.MAX_VALUE);
                for(int i = 1;enumer.hasMoreElements();i++)
                {
                    int worklog = ((Integer) enumer.nextElement()).intValue();
                    Worklog obj = Worklog.find(worklog);
                    ws.addCell(new Label(0,i,obj.getTimeToString()));
                    ws.addCell(new Label(1,i,obj.getContent(h.language)));
                    if(obj.getWorkproject() > 0)
                    {
                        ws.addCell(new Label(2,i,Workproject.find(obj.getWorkproject()).getName(h.language))); // 客户或项目
                    }
                    if(obj.getWorklinkman() != null)
                    {
                        ws.addCell(new Label(3,i,obj.getWorklinkman())); // 联系人
                    }
                    if(obj.getWorktype() > 0)
                    {
                        ws.addCell(new Label(4,i,Worktype.find(obj.getWorktype()).getName(h.language))); // 工作类型
                    }
                    ws.addCell(new Label(5,i,obj.isPublicity() ? "√" : "X")); // 是否对外
                }
                ww.write();
                ww.close();
                os.close();
                return;

            } else if("sendworklog".equals(action))
            {
                String tmps[] = h.getValues("worklog");
                int worklogs[] = new int[tmps.length];
                for(int i = 0;i < tmps.length;i++)
                {
                    worklogs[i] = Integer.parseInt(tmps[i]);
                }
                String inbox = h.get("inbox_up") + ";" + h.get("inbox_colleague") + ";" + h.get("inbox_member") + ";"
                               + h.get("inbox_email");
                String subject = h.get("subject");
                java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(inbox,";");
                for(int i = 0;tokenizer.hasMoreTokens();i++)
                {
                    String email = inbox = tokenizer.nextToken();
                    if(inbox.indexOf("@") == -1)
                    {
                        email = Profile.find(inbox).getEmail();
                    }
                    String html = content(h.community,1,inbox,new String[]
                                          {h.username},worklogs,null);
					Email.create(h.community,null,email,subject,html);
                }
            } else if("editwrtrade".equals(action))
            {
                String member = h.get("member");
                int goods = Integer.parseInt(h.get("goods"));
                // java.util.Date time =
                // Goods.sdf.parse(h.get("time"));
                int squantity = Integer.parseInt(h.get("squantity"));
                java.util.Enumeration e = Commodity.findByGoods(goods);
                if(!e.hasMoreElements())
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有创建供货商.","UTF-8"));
                    return;
                }
                int commodity_id = ((Integer) e.nextElement()).intValue();
                // Commodity commodity_obj = Commodity.find(commodity_id);
                java.util.Enumeration e2 = BuyPrice.find(commodity_id);
                if(!e2.hasMoreElements())
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有创建价格.","UTF-8"));
                    return;
                }
                RV rv_worklinkman = new RV(member,h.community);
                BuyPrice buyprice = BuyPrice.find(commodity_id,((Integer) e2.nextElement()).intValue());
                Buy.create(h.community,rv_worklinkman,goods,commodity_id,buyprice.getConvertCurrency(),buyprice.getPrice(),squantity);
            } else if("editwrtrade2".equals(action))
            {
                String member = h.get("member"); // 客户,消费者
                String vendor = h.get("vendor");
                String content = h.get("content");
                int currency = Integer.parseInt(h.get("currency"));
                java.util.Vector vector = new java.util.Vector();
                String _strBuy;
                for(int i = 0;(_strBuy = h.get("Buy" + i)) != null;i++)
                {
                    vector.addElement(new Integer(_strBuy));
                }
                /*
                     Profile b = Profile.find(member);
                     String trade_id = Trade.createByBuys(h.community,new tea.entity.RV(vendor), new tea.entity.RV(member, h.community), vector.elements(), false,
                  h.language, b.getEmail(), b.getFirstName(h.language), b.getLastName(h.language), b.getOrganization(h.language), b
                    .getAddress(h.language), b.getCity(h.language), b.getState(h.language), b.getZip(h.language), b
                    .getCountry(h.language), b.getTelephone(h.language), b.getFax(h.language), b.getEmail(), b.getFirstName(h.language), b
                    .getLastName(h.language), b.getOrganization(h.language), b.getAddress(h.language), b.getCity(h.language), b
                    .getState(h.language), b.getZip(h.language), b.getCountry(h.language), b.getTelephone(h.language), b
                    .getFax(h.language), currency, 0, java.math.BigDecimal.ZERO, java.math.BigDecimal.ZERO, 0, java.math.BigDecimal.ZERO, h.language, "", null,
                  java.math.BigDecimal.ZERO, java.math.BigDecimal.ZERO, java.math.BigDecimal.ZERO, java.math.BigDecimal.ZERO, 0, h.community);
                     Trade trade_obj = Trade.find(trade_id);
                     trade_obj.set(7, h.language, content, false, null);
                 */
            } else
            // /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if("editworktel".equals(action))
            {
                int worktel = Integer.parseInt(h.get("worktel"));
                Date time = null;
                try
                {
                    time = Worktel.sdf.parse(h.get("time"));
                } catch(ParseException ex1)
                {
                    time = new java.util.Date();
                }
                int workproject = Integer.parseInt(h.get("workproject"));
                String worklinkman = h.get("worklinkman");
                boolean teltype = "true".equals(h.get("teltype"));
                String imember = (h.get("imember"));
                String telephone = (h.get("telephone"));
                String content = h.get("content");
                if(content != null && content.length() > 2000)
                {
                    content = content.substring(0,2000);
                }
                if(worktel < 1)
                {
                    worktel = Worktel.create(h.community,h.username,workproject,worklinkman,teltype,telephone,content,imember,time);
                } else
                {
                    Worktel obj = Worktel.find(worktel);
                    obj.set(workproject,worklinkman,teltype,telephone,content,imember,new java.util.Date());
                }
                if(h.get("sendmail") != null)
                {
                    if(imember != null)
                    {
                        StringBuilder inbox = new StringBuilder();
                        String is[] = imember.split("/");
                        for(int i = 0;i < is.length;i++)
                        {
                            if(is[i].length() > 0)
                            {
                                String email = Profile.find(is[i]).getEmail();
                                if(email.indexOf("@") != -1)
                                {
                                    inbox.append(email).append(";");
                                }
                            }
                        }
                        if(inbox.length() > 0)
                        {
                            String subject = r.getString(h.language,"1170218830203") + "(" + Worktel.sdf.format(new java.util.Date()) + ")";
                            String url = "http://" + request.getServerName() + ":" + request.getServerPort() + "/jsp/admin/workreport/Worktels_4.jsp;jsessionid=" + request.getSession().getId()
                                         + "?community=" + h.community + "&worktel=" + worktel;
                            content = (String) Entity.open(url); // =
                            // h.get("content");
							Email.create(h.community,null,inbox.toString(),subject,content);
                        }
                    }
                }
            } else if("deleteworktel".equals(action))
            {
                int worktel = Integer.parseInt(h.get("worktel"));
                Worktel obj = Worktel.find(worktel);
                obj.delete();
            } else if("exportworktels".equals(action))
            {
                String worktels[] = h.getValues("worktel");
                if(worktels == null)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"1168833595335"),"UTF-8")); // 无效选择
                    return;
                }
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition","attachment; filename=" + System.currentTimeMillis() + ".xls");
                java.io.OutputStream os = response.getOutputStream();
                WritableWorkbook ww = jxl.Workbook.createWorkbook(os);
                WritableSheet ws = ww.createSheet("SHEET",0);
                ws.addCell(new Label(0,0,r.getString(h.language,"Time")));
                ws.addCell(new Label(1,0,r.getString(h.language,"Text")));
                ws.addCell(new Label(2,0,r.getString(h.language,"1168584443703"))); // 客户或项目
                ws.addCell(new Label(3,0,r.getString(h.language,"1168584403266"))); // 联系人
                ws.addCell(new Label(4,0,r.getString(h.language,"1168584722562"))); // 工作电话
                ws.addCell(new Label(5,0,r.getString(h.language,"1168592903313"))); // 工作类型
                ws.addCell(new Label(6,0,r.getString(h.language,"1170213683406"))); // 1170213683406=需要通知的人员
                ws.addCell(new Label(7,0,r.getString(h.language,"1170217759890"))); // 1170217759890=是否修改过/修改时间
                for(int i = 0;i < worktels.length;i++)
                {
                    int worktel = Integer.parseInt(worktels[i]);
                    Worktel obj = Worktel.find(worktel);
                    ws.addCell(new Label(0,i + 1,obj.getCtimeToString()));
                    ws.addCell(new Label(1,i + 1,obj.getContent(h.language)));
                    if(obj.getWorkproject() > 0)
                    {
                        ws.addCell(new Label(2,i + 1,Workproject.find(obj.getWorkproject()).getName(h.language))); // 客户或项目
                    }
                    if(obj.getWorklinkman() != null)
                    {
                        ws.addCell(new Label(3,i + 1,obj.getWorklinkman())); // 联系人
                    }
                    ws.addCell(new Label(4,i + 1,obj.getTelephone())); // 工作电话
                    ws.addCell(new Label(5,i + 1,r.getString(h.language,obj.isTeltype() ? "1170212958984" : "1170212966468"))); // 工作类型
                    ws.addCell(new Label(6,i + 1,obj.getImember())); // 需要通知的人员
                    if(obj.getCtime().getTime() - obj.getUtime().getTime() != 0)
                    {
                        ws.addCell(new Label(7,i + 1,obj.getUtimeToString())); // 是否修改过/修改时间
                    }
                }
                ww.write();
                ww.close();
                os.close();
                return;
            } else if("sendworktel".equals(action))
            {
                String inbox = h.get("inbox");
                String subject = h.get("subject");
                String url = h.get("url");
                String content = (String) Entity.open(url); // =
                // h.get("content");
				Email.create(h.community,null,inbox,subject,content);
            } else if("manualsendworklog".equals(action))
            {
                String _strTime = h.get("timeYear") + "-" + h.get("timeMonth") + "-" + h.get("timeDay");
                RobotSendWorklog.activateRobot();
                new RobotSendWorklog().send(_strTime);
            } else if("revertquestion".equals(action))
            {
                int worklog = Integer.parseInt(h.get("worklog"));
                String revertquestion = h.get("revertquestion"); //回复问题
                //将答案存入数据库
                if(worklog > 1 && revertquestion != null)
                {
                    Worklog obj = Worklog.find(worklog);
                    Profile pro = Profile.find(obj.getMember());
                    Profile pro1 = Profile.find(h.username.toString());
                    pro.getEmail();
                    String strs1 = null;
                    //发送到邮箱
                    if(h.get("checkbox1") != null && h.get("checkbox1").length() > 0)
                    {
						Email.create(h.community,null,pro.getEmail(),pro1.getName(h.language) + "对您的工作报告反馈",obj.getContent(h.language) + "<hr>" + "回复：" + revertquestion);
                    }
                    String strs2 = null;
                    //内部的短消息
                    if(h.get("checkbox2") != null && h.get("checkbox2").length() > 0)
                    {
                        //tea.entity.member.Message.create(h.community,h.username,obj.getMember(),h.language,"工作报告反馈",obj.getContent(h.language)+"<hr>"+revertquestion);
                    }
                    obj.set(revertquestion,worklog,h.username.toString());
                }
            }
            response.sendRedirect("/jsp/info/Succeed.jsp?community=" + h.community + "&nexturl=" + nexturl);
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }


    public static String content(String community,int language,String tomember,Object members[],int worklogs[],String _strTime) throws SQLException,UnsupportedEncodingException
    {
        Resource r = new Resource("/tea/resource/Workreport");
        String dn = null;
        Enumeration e3 = DNS.findByCommunity(community,0);
        if(e3.hasMoreElements())
        {
            dn = (String) e3.nextElement();
        }
//        String tomember = request.getParameter("tomember");
//        String members[] = request.getParameterValues("member");
//        String worklogs[] = request.getParameterValues("worklog");
//        String _strTime = request.getParameter("time");
//        String sn = request.getServerName();

        Community c = Community.find(community);
        StringBuilder h = new StringBuilder();
        try
        {
            h.append("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><base href='http://" + dn + "/'/><style>" + c.getCss() + "</style></head><body>");
        } catch(IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        h.append("<DIV ID=worktitle ><SPAN ID=worktomember >");
        //1173460497109=尊敬的 {0}
        boolean isMember = tomember.indexOf("@") == -1;
        if(isMember)
        {
            Profile to_p = Profile.find(tomember);
            h.append(MessageFormat.format(r.getString(language,"1173460497109"),new String[]
                                          {to_p.getName(language) + " " + " " + (to_p.isSex() ? "先生" : "女士")}));
        } else
        {
            h.append(MessageFormat.format(r.getString(language,"1173460497109"),new String[]
                                          {tomember}));
        }
        h.append(":</SPAN></DIV><BR>");

        for(int i = 0;i < members.length;i++)
        {
            if(_strTime != null)
            {
                h.append(format((String) members[i],_strTime,worklogs,community,language,r,dn));
            } else
            {
                StringBuilder sql = new StringBuilder();
                sql.append("SELECT DISTINCT ").append(DbAdapter.format("time",10)).append(" FROM Worklog WHERE worklog IN(");
                for(int j = 0;j < worklogs.length;j++)
                {
                    sql.append(worklogs[j]);
                    if(j + 1 != worklogs.length)
                    {
                        sql.append(",");
                    }
                }
                sql.append(") AND community=").append(DbAdapter.cite(community));
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery(sql.toString());
                    while(db.next())
                    {
                        h.append(format((String) members[i],db.getString(1),worklogs,community,language,r,dn));
                    }
                } finally
                {
                    db.close();
                }
            }
        }
        if(!isMember) //是email
        {
            //1173459913875=欢迎您使用怡康科技/EDN-ERP 1.0系统,如果您还不是系统的会员,请点击 <a href="{0}">这里</a> 进行注册.
            String href = "http://" + dn + "/jsp/user/register.jsp?node=" + c.getNode();
            h.append("<br/><br/>");
            h.append(MessageFormat.format(r.getString(language,"1173459913875"),new String[]
                                          {href}));
        }
        h.append("</body></html>");
        return h.toString();
    }

    private static boolean bool = true;
    private static String format(String members,String _strTime,int worklogs[],String community,int language,Resource r,String sn) throws SQLException,UnsupportedEncodingException
    {
        Profile p = Profile.find(members);
        String name = p.getName(language);

        StringBuilder sql = new StringBuilder();
        sql.append(" AND member=").append(DbAdapter.cite(members));
        if(_strTime != null)
        {
            sql.append(" AND DATEDIFF(dd,time,").append(DbAdapter.cite(_strTime)).append(")=0"); //
        }
        if(worklogs != null)
        {
            sql.append(" AND worklog IN(");
            for(int j = 0;j < worklogs.length;j++)
            {
                sql.append(worklogs[j]);
                if(j + 1 != worklogs.length)
                {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        sql.append(" ORDER BY workproject");

        StringBuilder html = new StringBuilder();

        html.append("<DIV ID=workbody");
        if(bool = !bool)
        {
            html.append(" style=\"background-color:#F0F0F0;\" ");
        }
        html.append(">");

        String photo = p.getPhotopath(language);
        if(photo == null || photo.length() < 1)
        {
            photo = "http://" + sn + ":" + 80 + "/jsp/type/bbs/default_bbsphoto/index.jpg";
        } else if(!photo.startsWith("http://"))
        {
            photo = "http://" + sn + ":" + 80 + photo;
        }
        html.append("<DIV ID=workphoto><img style=\"float:left;\" src=\"").append(photo).append("\" onerror=\"if(this.src.indexOf('/index.jpg')==-1)this.src='http://").append(sn).append("/jsp/type/bbs/default_bbsphoto/index.jpg';\" onload=\"if(this.width>60||this.height>60)if(this.width>this.height)this.width=60; else this.height=60;\" ></DIV>");

        html.append("<DIV ID=workheader>------------------------------------------------------------------------<BR>");
        html.append(MessageFormat.format(r.getString(language,"1173248201671"),new String[]
                                         {"<SPAN id=workmember >" + name + "</SPAN>","<SPAN id=worktime >" + _strTime + "</SPAN>"}));
        html.append("</DIV>");

        html.append("<DIV ID=workcontent>");

        int workproject = 0;
        java.util.Enumeration e = Worklog.find(community,sql.toString(),0,Integer.MAX_VALUE);
        boolean ul = false;
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            Worklog obj = Worklog.find(id);
            if(workproject != obj.getWorkproject())
            {
                workproject = obj.getWorkproject();
                Flowitem wp = Flowitem.find(workproject);
                if(ul) //如果是第一次,就不输入</ul>
                {
                    html.append("</UL>\r\n");
                } else
                {
                    ul = true;
                }
                html.append("<UL><SPAN id=workproject >").append(wp.getName(language)).append(" ").append(r.getString(language,"1173249338984")).append("</SPAN>");
            }
            //状态
            html.append("<LI>").append(obj.getContent(language).replaceAll(" ","&nbsp;").replaceAll("\r\n","<br>")).append(" [").append(r.getString(language,"1173241008125")).append(":").append(r.getString(language,Worklog.STATES_TYPE[obj.getStates()]));
            //时间
            html.append(" ").append(r.getString(language,"Time")).append(":").append(obj.getTimeToString2());
            //联系人
            if(obj.getWorklinkman() != null && obj.getWorklinkman().length() > 0)
            {
                Profile p_wl = Profile.find(obj.getWorklinkman());
                html.append(" ").append(r.getString(language,"1168584403266")).append(":").append(p_wl.getName(language));
            }
            //抄送
            if(obj.getToMember() != null && obj.getToMember().length() > 0)
            {
                html.append(" ").append(r.getString(language,"1173249885265")).append(":");
                String tms[] = obj.getToMember().split(";");
                for(int j = 0;j < tms.length;j++)
                {
                    if(tms[j].length() > 0)
                    {
                        Profile p_tm = Profile.find(tms[j]);
                        html.append(p_tm.getName(language)).append("; ");
                    }
                }
            }
            html.append("]</LI>\r\n");
        }

        html.append("</UL></DIV>");
        html.append("<DIV ID=workfooter>------------------------------------------------------------------------<BR>");

        //1173250961875=如果您对 {0} 工作日志有疑问,请点击 <a href="{1}">这里</a> 进行回复与沟通.
        String href = "http://" + sn + "/jsp/message/NewMessage2.jsp?tomember=" + java.net.URLEncoder.encode(members,"UTF-8");
        html.append(MessageFormat.format(r.getString(language,"1173250961875"),new String[]
                                         {href,"mailto:" + p.getEmail(),name}));

        html.append("</DIV><BR></DIV>");

        return html.toString();
    }

}
