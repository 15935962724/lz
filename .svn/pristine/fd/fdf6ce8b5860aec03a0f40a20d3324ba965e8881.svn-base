package tea.ui.cio;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.cio.*;
import jxl.*;
import jxl.write.*;

public class EditCioPart extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        int ciocompany = 0;
        TeaSession teasession = new TeaSession(request);
        String tmp = teasession.getParameter("ciocompany");
        String act = teasession.getParameter("act");
        if(act.equals("cioclerk") || act.equals("CioClerklist"))
        {

        } else
        {
            if(tmp != null)
            {
                ciocompany = Integer.parseInt(tmp);
            }

            if(ciocompany > 0 && teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
                return;
            }
        }
        String nu = request.getParameter("nexturl");
        try
        {
            if(act.equals("edit"))
            {
                int ciopart = Integer.parseInt(request.getParameter("ciopart"));
                String name = request.getParameter("name");
                boolean sex = "true".equals(request.getParameter("sex"));
                String job = request.getParameter("job");
                String mobile = request.getParameter("mobile");
                String tel = request.getParameter("tel");
                String dept = request.getParameter("dept");
                String email = request.getParameter("email");
                String fax = request.getParameter("fax");
                String address = request.getParameter("address");
                String zip = request.getParameter("zip");
                boolean talk = "true".equals(request.getParameter("talk"));
                //boolean tourism = "true".equals(request.getParameter("tourism"));
                boolean room = "true".equals(request.getParameter("room"));
                boolean shuttle = "true".equals(request.getParameter("shuttle"));
                StringBuilder sb = new StringBuilder("/");
                String ts[] = request.getParameterValues("tourism");
                if(ts != null)
                {
                    for(int i = 0;i < ts.length;i++)
                    {
                        sb.append(ts[i]).append("/");
                    }
                }
                if(ciopart == 0 || request.getParameter("add") != null)
                {
                    CioPart.create(ciocompany,name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,sb.toString(),room,shuttle);

                } else
                {
                    CioPart cp = CioPart.find(ciopart);
                    cp.set(name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,sb.toString(),room,shuttle);
                }
            } else if(act.equals("delete"))
            {
                int ciopart = Integer.parseInt(request.getParameter("ciopart"));
                CioPart cc = CioPart.find(ciopart);
                cc.delete();
            } else if(act.equals("trip")) //行程
            {
                String cometrain = request.getParameter("cometrain");
                String backtrain = request.getParameter("backtrain");
                //到港/到站日期极时刻
                Date cometime = null;
                String strcometime = request.getParameter("cometime");
                int cth = Integer.parseInt(request.getParameter("cth"));
                int ctm = Integer.parseInt(request.getParameter("ctm"));
                if(strcometime != null && strcometime.length() > 0)
                {
                    cometime = CioPart.sdf2.parse(strcometime + " " + cth + ":" + ctm);
                }
                //离港/发车时间
                Date backtime = null;
                int bth = Integer.parseInt(request.getParameter("bth"));
                int btm = Integer.parseInt(request.getParameter("btm"));
                //退房日期
                Date backroom = null;
                String strbackroom = request.getParameter("backroom");
                if(strbackroom != null && strbackroom.length() > 0)
                {
                    backtime = backroom = CioPart.sdf2.parse(strbackroom + " " + bth + ":" + btm);
                }
                String cps[] = request.getParameterValues("ciopart");
                for(int i = 0;i < cps.length;i++)
                {
                    int ciopart = Integer.parseInt(cps[i]);
                    CioPart cp = CioPart.find(ciopart);
                    cp.set(cometrain,cometime,backroom,backtrain,backtime);
                }
//                int hour = Integer.parseInt(request.getParameter("hour"));
//                int minute = Integer.parseInt(request.getParameter("minute"));
//                String cometrain = request.getParameter("cometrain");
//                Date backroom = CioPart.sdf.parse(request.getParameter("backroom"));
//                Date cometime = CioPart.sdf2.parse(request.getParameter("cometime") + " " + hour + ":" + minute);
//                String backtrain = request.getParameter("backtrain");
//                Date backtime = CioPart.sdf.parse(request.getParameter("backtime"));
//                String cps[] = request.getParameterValues("ciopart");
//                for(int i = 0;i < cps.length;i++)
//                {
//                    int ciopart = Integer.parseInt(cps[i]); //request.getParameter("ciopart")
//                    CioPart cp = CioPart.find(ciopart);
//                    cp.set(cometrain,cometime,backroom,backtrain,backtime);
//                }
            } else if(act.equals("shuttle"))
            {
                int sname = 0;
                if(request.getParameter("sname") != null && request.getParameter("sname").length() > 0)
                {
                    sname = Integer.parseInt(request.getParameter("sname"));
                }

                String stel = teasession.getParameter("stel");
                String cps[] = teasession.getParameterValues("ciopart");
                if(cps != null)
                {
                    for(int i = 0;i < cps.length;i++)
                    {
                        int ciopart = Integer.parseInt(cps[i]);
                        CioPart cc = CioPart.find(ciopart);
                        cc.set(sname,stel);
                    }
                }
            } else if(act.equals("root"))
            {
                String rname = request.getParameter("rname");
                String rchamber = request.getParameter("rchamber");
                Date rstime = CioPart.sdf.parse(request.getParameter("rstime"));
                Date retime = CioPart.sdf.parse(request.getParameter("retime"));
                String cps[] = request.getParameterValues("ciopart");
                if(cps != null)
                {
                    for(int i = 0;i < cps.length;i++)
                    {
                        int ciopart = Integer.parseInt(cps[i]);
                        CioPart cc = CioPart.find(ciopart);
                        cc.set(rname,rchamber,rstime,retime);
                    }
                }
            } else if(act.equals("ciocustomlist"))
            {
                StringBuilder strs = new StringBuilder(",");
                String pagelist = teasession.getParameter("pagelist");
                String listname = teasession.getParameter("listname");
                String cpslist[] = request.getParameterValues("checkbox");
                int lists = 0;
                String changelists = "";
                if(cpslist != null)
                {
                    if("showlist".equals(listname))
                    {
                        for(int i = 0;i < cpslist.length;i++)
                        {
                            lists = Integer.parseInt(cpslist[i]);
                            strs.append(lists).append(",");
                        }
                    } else if("changelist".equals(listname))
                    {
                        for(int i = 0;i < cpslist.length;i++)
                        {
                            changelists = (cpslist[i]).toString();
                            strs.append(changelists).append(",");
                        }
                    }
                }
                CioCustomList pp = CioCustomList.find(pagelist);
                if(pp.isExists())
                {
                    CioCustomList.Setlist(listname,pagelist,strs.toString());
                } else
                {
                    CioCustomList.create(teasession._strCommunity,"","",pagelist);
                    CioCustomList.Setlist(listname,pagelist,strs.toString());
                }
                return;
            } else if(act.equals("cioclerk"))
            {
                String sname = teasession.getParameter("sname");
                String stel = teasession.getParameter("stel");

                int cioclerk = 0;
                if(teasession.getParameter("cioclerk") != null && teasession.getParameter("cioclerk").length() > 0)
                {
                    cioclerk = Integer.parseInt(teasession.getParameter("cioclerk"));
                    if(cioclerk == 0)
                    {
                        CioClerk.create(sname,stel);
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("添加成功！","UTF-8") + "&nexturl=/jsp/cio/CioClerk.jsp");
                        return;
                    } else
                    {
                        CioClerk.set(cioclerk,sname,stel);
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("修改成功！","UTF-8") + "&nexturl=/jsp/cio/CioClerk.jsp");
                        return;
                    }
                }

            }
            if(act.equals("CioClerklist"))
            {
                int ciopart = 0;
                if(teasession.getParameter("ccid") != null && teasession.getParameter("ccid").length() > 0)
                {
                    ciopart = Integer.parseInt(teasession.getParameter("ccid"));
                }
                int sname = 0;
                if(teasession.getParameter("sname") != null && teasession.getParameter("sname").length() > 0)
                {
                    sname = Integer.parseInt(teasession.getParameter("sname"));
                }
                CioPart cc = CioPart.find(ciopart);
                cc.set(sname,"");
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("添加成功！","UTF-8") + "&nexturl=/jsp/cio/EditShuttleCioPart.jsp");
                return;
            }
            if(act.equals("resethouse"))
            {
                String ciopart = request.getParameter("ciopart");
                String rchamber = request.getParameter("rchamber");
                int ciop = 0;
                if(ciopart != null)
                {
                    ciop = Integer.parseInt(ciopart);
                }
                CiopCount.upResetHouse(ciop,rchamber);
            }
            if(act.equals("rername"))
            {
                String[] chb = request.getParameterValues("chb");
                String rname = request.getParameter("rname");
                int cpid=0;
                if(chb!=null&&chb.length>0){
                    for(int i = 0; i < chb.length; i++)
                    {
                        cpid = Integer.parseInt(chb[i]);
                        CiopCount.upResetRname(cpid,rname);
                    }
                }
            }
            if(act.equals("upperson"))
            {
                int ciopart = Integer.parseInt(request.getParameter("ciopart"));
                String name = request.getParameter("name");
                boolean sex = "true".equals(request.getParameter("sex"));
                String job = request.getParameter("job");
                String mobile = request.getParameter("mobile");
                String tel = request.getParameter("tel");
                String dept = request.getParameter("dept");
                String email = request.getParameter("email");
                String fax = request.getParameter("fax");
                String address = request.getParameter("address");
                String zip = request.getParameter("zip");
                boolean talk = "true".equals(request.getParameter("talk"));
                //boolean tourism = "true".equals(request.getParameter("tourism"));
                StringBuilder sb = new StringBuilder("/");
                String ts[] = request.getParameterValues("tourism");
                if(ts != null)
                {
                    for(int i = 0;i < ts.length;i++)
                    {
                        sb.append(ts[i]).append("/");
                    }
                }
                boolean room = "true".equals(request.getParameter("room"));
                boolean shuttle = "true".equals(request.getParameter("shuttle"));
                boolean bd = "true".equals(request.getParameter("bd"));
                boolean vip = "true".equals(request.getParameter("vip"));
                boolean seat = "true".equals(request.getParameter("seat"));

                String cometrain = request.getParameter("cometrain");
                int cler = Integer.parseInt(request.getParameter("sname"));

                if(!shuttle)
                {
                    cler=0;
                }
                String backtrain = request.getParameter("backtrain");
                //到港/到站日期极时刻
                Date cometime = null;
                String strcometime = request.getParameter("cometime");
                int cth = Integer.parseInt(request.getParameter("cth"));
                int ctm = Integer.parseInt(request.getParameter("ctm"));
                if(strcometime != null && strcometime.length() > 0)
                {
                    cometime = CioPart.sdf2.parse(strcometime + " " + cth + ":" + ctm);
                }
                //离港/发车时间
                Date backtime = null;
                int bth = Integer.parseInt(request.getParameter("bth"));
                int btm = Integer.parseInt(request.getParameter("btm"));
                //退房日期
                Date backroom = null;
                Date rstime = null;
                boolean st = "true".equals(request.getParameter("st"));
                String strbacktime = request.getParameter("backtime");
                String strstime = request.getParameter("rstime");
                String strbtime = request.getParameter("backroom");
                if(strbacktime != null && strbacktime.length() > 0)
                {
                    backtime = CioPart.sdf2.parse(strbacktime + " " + bth + ":" + btm);
                }
                String rname = request.getParameter("rname");
                String rchamber = request.getParameter("rchamber");
                if(strstime != null && strstime.length() > 0)
                {
                    rstime = CioPart.sdf.parse(strstime);
                }
                if(strbtime != null && strbtime.length() > 0)
               {
                   backroom = CioPart.sdf.parse(strbtime);
               }

                int isetRow = 0,isetCol = 0;

                String setRow = request.getParameter("seatrow");
                if(setRow != null && setRow.length() > 0)
                {
                    isetRow = Integer.parseInt(setRow);
                }

                String setCol = request.getParameter("seatcol");
                if(setCol != null && setCol.length() > 0)
                {
                    isetCol = Integer.parseInt(setCol);
                }

                CioPart cp = CioPart.find(ciopart);
                cp.set(name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,sb.toString(),room,shuttle);
                cp.set(cometrain,cometime,backroom,backtrain,backtime);
                cp.set(rname,rchamber,rstime);

                cp.set1(bd,vip,seat,cler);

                if(st&&!seat)
                {
                CioSeatSet.del(ciopart);
                }
                if(st!=seat){
                    if(st)
                    {
                        CioSeatSet.upProSeat(isetRow,isetCol,ciopart);
                    } else
                    {
                        CioSeatSet.createSeat(ciopart,isetRow,isetCol);
                    }
                }
                response.sendRedirect("/jsp/cio/OkCioCompany3.jsp");
                return;

            }

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }
}
