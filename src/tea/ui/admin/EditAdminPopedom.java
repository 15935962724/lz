package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import tea.resource.Common;
import jxl.Sheet;
import jxl.Workbook;


//bian ji yong hu quan xian
public class EditAdminPopedom extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request,response);
        if(h.member < 1)
        {
            response.sendRedirect("/servlet/StartLogin?community=" + h.community);
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            String action = h.get("act");
            String nexturl = h.get("nexturl");
            // //菜单////////////////////////////////////////////////////////////////////////////////////////////////
            if("editfunction".equals(action)) // ////添加菜单
            {
                int id = Integer.parseInt(h.get("id"));
                AdminFunction af_obj = AdminFunction.find(id);
                int sub = h.getInt("sub");
                if(sub == 1) //同级
                {
                    af_obj.father = af_obj.getFather();
                    af_obj.id = 0;
                    sub = 3;
                } else if(sub == 2) //子菜单
                {
                    af_obj.father = af_obj.id;
                    af_obj.id = 0;
                    sub = 3;
                }
                af_obj.target = h.get("target");
                af_obj.type = h.getInt("menutype");
                af_obj.remind = h.getInt("remind");
                af_obj.url = h.get("url");
                if(af_obj.type == 2)
                {
                    try
                    {
                        int nid = Integer.parseInt(h.get("url_node"));
                        if(!Node.isExisted(nid))
                        {
                            throw new NumberFormatException("");
                        }
                        af_obj.url = String.valueOf(nid);
                    } catch(NumberFormatException ex1)
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("无效节点号","UTF-8"));
                        return;
                    }
                }
                af_obj.setAction(h);
                af_obj.sequence = h.getInt("sequence");
                int sort = 0; // Integer.parseInt(h.get("sort"));
                af_obj.hidden = h.get("hidden") == null;
                af_obj.urlig = h.get("urlig");
                af_obj.urlim = h.get("urlim");
                af_obj.tipoffilepath = h.get("tipoffilepath");
                af_obj.icon = h.get("icon");
                if(af_obj.icon == null)
                {
                    af_obj.icon = h.get("iconpath");
                }
                switch(sub)
                {
                case 3: //编辑
                    af_obj.set();
                    af_obj.setLayer(h.language,h.get("name"),af_obj.url,h.get("content"));
                    break;
                case 4: //
                    af_obj.delete();
                    id = af_obj.getFather();
                    break;
                case 5:
                    int newclone = Integer.parseInt(h.get("clone"));
                    boolean isCloneSon = h.get("sonclone") != null;
                    if(isCloneSon && AdminFunction.find(newclone).isSon(id))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"无效菜单ID-不能把父菜单复制到子菜单中"),"UTF-8"));
                        return;
                    }
                    AdminFunction af = AdminFunction.find(newclone);
                    af.clone(id,h.community,h.status,isCloneSon);
                    break;
                case 6:
                    int newfather = Integer.parseInt(h.get("move"));

                    // 判断 不能把节点移动到自已的子节点中
                    if(af_obj.isSon(newfather))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(h.language,"无效菜单ID-不能移动到自已的子菜单中"),"UTF-8"));
                        return;
                    }
                    af_obj.move(h.community,newfather,h.status);
                    break;
                case 7:
                    id = af_obj.createGroup(h.get("name7"));
                    break;
                case 8:
                    String rows[] = request.getParameterValues("rows");
                    if(rows == null)
                    {
                        out.print("<script>alert(\"无效选择!\");history.back();</script>");
                        return;
                    }
                    int last = 0; //子菜单ID
                    int prev = 0; //上一行菜单的父菜单ID

                    Workbook wb = Workbook.getWorkbook(new File(Common.REAL_PATH + "/jsp/admin/popedom/Menu.xls"));
                    try
                    {
                        Sheet s = wb.getSheet(h.status);
                        int max = s.getRows();
                        for(int i = 1;i < max;i++)
                        {
                            String str = s.getCell(0,i).getContents();
                            if(str.length() < 1)
                            {
                                last = prev = id;
                            }
                            String name = s.getCell(1,i).getContents();
                            String url = s.getCell(2,i).getContents();
                            String content = s.getCell(3,i).getContents();
                            if(str.equals("↑")) //同级菜单
                            {
                            } else if(str.equals("→")) //子菜单
                            {
                                prev = last;
                            } else if(str.startsWith("←")) //上级
                            {
                                for(int j = 0;j < str.length();j++)
                                {
                                    prev = AdminFunction.find(prev).getFather();
                                }
                            }
                            for(int r = 0;r < rows.length;r++)
                            {
                                if(Integer.parseInt(rows[r]) == i)
                                {
                                    last = AdminFunction.create(h.community,prev,h.status,url.length() > 0 ? 1 : 0,url,0,i,true,"m","","",null,1,name,content,null);
                                    break;
                                }
                            }
                        }
                    }
                    finally
                    {
                        wb.close();
                    }
                }
                if(nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    out.print("<script>window.open('/jsp/admin/popedom/AdminFunctionTree.jsp?community=" + h.community + "&id=" + id + "','function_funlist'); window.open('/jsp/admin/popedom/EditAdminFunction.jsp?community=" + h.community + "&id=" + id + "','_self');</script>");
                }
                // response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&MenuId="+strid);
                return;
            } else if("action".equals(action))
            {
                ArrayList al = AdminFunction.find(" AND type=1",0,Integer.MAX_VALUE);
                for(int i = 0;i < al.size();i++)
                {
                    AdminFunction af = (AdminFunction) al.get(i);
                    af.setAction(h);
                    af.set("action",af.action);
                }
                out.print("<script>alert('操作执行成功！');</script>");
                return;
            } else if("editadminrole".equals(action)) //添加角色
            {
                String name = h.get("name");
                int type = h.getInt("type");
                int levels = 0;
                if(h.get("levels") != null && h.get("levels").length() > 0)
                {
                    levels = Integer.parseInt(h.get("levels"));
                }

                Date startdate = new Date();
                int id = h.getInt("adminrole");
                if(id == 0)
                {
                    id = AdminRole.create(h.community,h.status,type,startdate,null,name);
                    AdminRole.find(id).setLevels(levels);
                    //授创建者角色
                    AdminUsrRole aur = AdminUsrRole.find(h.community,h.username);
                    aur.setRole(aur.getRole() + id + "/");
                } else
                {
                    AdminRole obj = AdminRole.find(id);
                    obj.set(name,type,startdate,null,h.community);
                    obj.setLevels(levels);
                }
            } else if("deleteadminrole".equals(action))
            {
                int id = h.getInt("adminrole");
                AdminRole obj = AdminRole.find(id);
                obj.delete();
            } else if("editadminrole2".equals(action)) //权限设置
            {
                AdminRole r = AdminRole.find(h.getInt("adminrole"));
                int len = r.distinguish ? 2 : 1;
                for(int i = 0;i < len;i++)
                {
                    StringBuilder sb = new StringBuilder("|");
                    String[] arr = h.getValues("menu" + i);
                    if(arr != null)
                    {
                        for(int j = 0;j < arr.length;j++)
                        {
                            sb.append(arr[j] + ":" + h.get("menu" + i + "_" + arr[j],"|").substring(1).replace('|',',') + "|");
                        }
                    }
                    r.set(i == 0 ? "adminfunction" : "ethernet",sb.toString());
                }
            } else if("editadminunit".equals(action)) // 部门编辑
            {
                int id = h.getInt("adminunit");
                int pid = h.getInt("pid");
                String name = h.get("name");
                String ename = h.get("ename");
                String linkmanname = h.get("linkmanname");
                String tel = h.get("tel");
                String fax = h.get("fax");
                String address = h.get("address");
                String content = h.get("content");
                boolean hiddenorg = h.get("hiddenorg") != null;
                int father = Integer.parseInt(h.get("father"));
                if(father != 0 && id == father) // 部门的上级不能是自已
                {
                    father = 0;
                }
                boolean usepic = h.get("usepic") != null;
                AdminUnit obj_au = AdminUnit.find(id);
                String picture = obj_au.getPicture();
                String tmp = h.get("picture");
                if(tmp != null)
                {
                    picture = tmp;
                } else if(h.get("clear") != null) // 清空
                {
                    picture = "";
                }
                int adminunittype = 0;
                if(h.get("adminunittype") != null && h.get("adminunittype").length() > 0)
                {
                    adminunittype = Integer.parseInt(h.get("adminunittype"));
                }

                int adminunitorg = 0;

                if(h.get("adminunitorg") != null && h.get("adminunitorg").length() > 0)
                {
                    adminunitorg = Integer.parseInt(h.get("adminunitorg"));
                }
                obj_au.set(father,name,ename,pid,1,linkmanname,tel,fax,h.community,h.username,address,obj_au.getZip(),
                           content,picture,usepic,obj_au.getOther(),obj_au.getOther2(),adminunittype,adminunitorg);
                obj_au.upHiddenOrg(hiddenorg);
                SEQ = 0;
                //ref_dept(h.community,AdminUnit.getRootId(h.community));
                AdminUnit.ref(0);
            } else if("deleteadminunit".equals(action)) // 删除部门
            {
                int id = Integer.parseInt(h.get("adminunit"));
                AdminUnit obj_au = AdminUnit.find(id);
                obj_au.delete();
                AdminUnit.ref(0);
            } else if("moveadminunit".equals(action))
            {
                int id = Integer.parseInt(h.get("adminunit"));
                AdminUnit au = AdminUnit.find(id);
                boolean bool = "true".equals(h.get("sequence"));
                // int seq = au.getSequence();
                // if (bool)
                // {
                // seq = seq - 3; // 向上
                // } else
                // {
                // seq = seq + 3; // 向下
                // AdminUnit.countByCommunity(h.community," AND ");
                // }
                // au.setSequence(seq);

                Enumeration e = AdminUnit.findByCommunity(h.community," AND father=" + au.getFather());
                for(int i = 0;e.hasMoreElements();i = i + 2)
                {
                    au = (AdminUnit) e.nextElement();
                    if(id == au.getId())
                    {
                        au.setSequence(i + (bool ? -3 : 3));
                    } else
                    {
                        au.setSequence(i);
                    }
                }
                SEQ = 0;
                ref_dept(h.community,AdminUnit.getRootId(h.community));
                response.sendRedirect(nexturl);
                return;
            } else
            // 用户授权//////////////////////////////////////////////////////
            if("editadminusrrole".equals(action))
            {
                String member = h.get("newmember");
                String password = h.get("password");
                String email = h.get("email");
                Profile p = null;
                if(member != null) // �½���̨�û�
                {
                    member = member.trim().toLowerCase();
                    if(Profile.isExisted(member))
                    {
                        out.print(new tea.html.Script("alert('" + r.getString(h.language,"1169525543109") + "');history.back();"));
                        return;
                    }
                    p = Profile.create(member,password,h.community,email,request.getServerName() + ":" + request.getServerPort());
                } else
                {
                    member = h.get("member");
                    p = Profile.find(member);
                    p.setEmail(email);
                }

                boolean sex = "true".equals(h.get("sex"));
                String firstname = h.get("firstname");
                String lastname = h.get("lastname");
                int rclass = Integer.parseInt(h.get("rclass"));
                int wagetype = 0;
                try
                {
                    wagetype = Integer.parseInt(h.get("wagetype"));
                } catch(NumberFormatException ex)
                {
                }
                String role = h.get("role");
                String classes = h.get("classes");
                String dept = h.get("dept");
                String bbs = h.get("bbs");
                String nomanager = h.get("nomanager2");
                if(nomanager != null && nomanager.trim().length() > 0)
                {
                    p.setNomanager(Integer.parseInt(nomanager));
                }
                //System.out.println(bbs);
                int unitid = Integer.parseInt(h.get("adminunit"));
                String options[] = h.get("options").split("/");
                if(!"********".equals(password))
                {
                    p.setPassword(password);
                }
                p.setType(1);
                //默认添加为高级用户---俱乐部会员使用
                p.setMembertype(1);
                p.setSex(sex);
                p.setFirstName(firstname,h.language);
                p.setLastName(lastname,h.language);
                p.setRclass(rclass); // 考勤排班
                p.setWagetype(wagetype); // 工资标准
                // ////
                String job = h.get("job");
                String title = h.get("title");
                String tmp = h.get("birth");
                Date birth = null;
                if(tmp != null && tmp.length() > 0)
                {
                    try
                    {
                        birth = p.sdf.parse(tmp);
                    } catch(Exception ex)
                    {
                        // 如果没有月
                        try
                        {
                            birth = p.sdf3.parse(tmp + "-01 00:00:01");
                        } catch(Exception ex2)
                        {
                        }
                    }
                }
                String fax = h.get("fax");
                String etime = h.get("etime");
                String telephone = h.get("telephone");
                String mobile = h.get("mobile");
                String functions = h.get("functions");
                String address = h.get("address");
                String degree = h.get("degree");
                int polity = Integer.parseInt(h.get("polity"));
                // 大照片
                String photopath2 = p.getPhotopath2(h.language);
                tmp = h.get("photopath2");
                if(tmp != null)
                {
                    // BufferedImage bi = ImageIO.read(new
                    // ByteArrayInputStream(by));
                    // if (bi.getWidth() <= 128 && bi.getHeight() <= 180)
                    {
                        // response.sendRedirect("/jsp/info/Alert.jsp?info=" +
                        // URLEncoder.encode("图像大小不符合系统要求", "UTF-8"));
                        // return;
                        photopath2 = tmp;
                    }
                } else if(h.get("clear") != null)
                {
                    photopath2 = "";
                }
                p.set(etime,h.language,job,title,functions,photopath2);
                p.setBirth(birth);
                p.setFax(fax,h.language);
                p.setTelephone(telephone,h.language);
                p.setMobile(mobile);
                p.setAddress(address,h.language);
                p.setDegree(degree,h.language);
                p.setPolity(polity);
                p.set(h.username,new Date());
                //

                AdminUsrRole aur_obj = AdminUsrRole.find(h.community,member);
                aur_obj.setRole(role);
                aur_obj.setUnit(unitid);
                aur_obj.setDept(dept);
                aur_obj.setClasses(classes);
                aur_obj.setBbs(bbs);

                p.setBbspermissions(bbs);

                String str = aur_obj.getOptions();
                for(int i = 1;i < options.length;i++)
                {
                    int id = Integer.parseInt(options[i]);
                    boolean bool = h.get("option" + id) != null;
                    str = str.replaceFirst("/" + id + "/","/");
                    if(bool)
                    {
                        str = str + id + "/";
                    }
                }
                aur_obj.setOptions(str);
                // 同步部门排序///
                AdminUnitSeq.refresh(h.community);

                // 在所属社区中加入
                RV rv = new RV(member);
                Subscriber s = Subscriber.find(h.community,rv);
                if(!s.isExists())
                {
                    Subscriber.create(h.community,rv,0);
                }
            } else if("clearpassword".equals(action))
            {
                String member = h.get("member");
                Profile obj = Profile.find(member);
                obj.setPassword("");
            } else if("deleteadminusrrole".equals(action))
            {
                String member = h.get("member");
                AdminUsrRole aur = AdminUsrRole.find(h.community,member);
                aur.setRole("/");
                //删除流程中的经办人
                Enumeration e = Flowprocess.find(0," AND member LIKE " + DbAdapter.cite("%/" + member + "/%"));
                while(e.hasMoreElements())
                {
                    Flowprocess fp = Flowprocess.find((Integer) e.nextElement());
                    fp.setMember(fp.getMember().replaceAll("/" + member + "/","/"),fp.getExtend());
                }
//                aur.delete();
//                Profile p = Profile.find(member);
//                p.delete();
            } else if("setadminroleconsign".equals(action))
            {
                int adminrole = Integer.parseInt(h.get("adminrole"));
                String consign = h.get("consign");
                AdminRole ar = AdminRole.find(adminrole);
                ar.setConsign(consign);
            } else if("moveadminusrrole".equals(action))
            {
                String member = h.get("member");
                boolean sequence = "true".equals(h.get("sequence"));
                int adminunit = Integer.parseInt(h.get("adminunit"));
                Enumeration e = AdminUnitSeq.findByCommunity(h.community,adminunit);
                for(int i = 0;e.hasMoreElements();i = i + 2)
                {
                    String _member = (String) e.nextElement();
                    AdminUnitSeq au = AdminUnitSeq.find(adminunit,_member);
                    if(member.equals(_member))
                    {
                        au.setSequence(i + (sequence ? -3 : 3));
                    } else
                    {
                        au.setSequence(i);
                    }
                }
                // Enumeration e =
                // AdminUsrRole.findByCommunity(h.community, " AND
                // unit=" + adminunit);
                // for (int i = 0; e.hasMoreElements(); i = i + 2)
                // {
                // String _member = (String) e.nextElement();
                // AdminUsrRole au = AdminUsrRole.find(h.community,
                // _member);
                // if (member.equals(_member))
                // {
                // au.setSequence(i + (sequence ? -3 : 3));
                // } else
                // {
                // au.setSequence(i);
                // }
                // }
                response.sendRedirect(nexturl);
                return;
            }
            response.sendRedirect(nexturl);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    int SEQ;
    public void ref_dept(String community,int father) throws Exception
    {
        Enumeration e = AdminUnit.findByCommunity(community," AND father=" + father);
        for(int j = 0;e.hasMoreElements();j++)
        {
            AdminUnit obj = (AdminUnit) e.nextElement();
            //设置排序///////////
            SEQ = SEQ + 2;
            int seq = obj.getSequence();
            if(seq != SEQ)
            {
                obj.setSequence(SEQ);
            }
            //
            if(!obj.isEnds())
            {
                ref_dept(community,obj.getId());
            }
        }
    }

}
