package tea.ui.admin;

import java.util.*;
import java.net.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.service.Robot;
import tea.entity.admin.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;

public class RobotSendWorklog extends Thread
{
    public static boolean _blStarted = false;

    public RobotSendWorklog()
    {
    }

    public static void activateRobot() throws Exception
    {
        if(!_blStarted)
        {
            System.out.println("自动发工作日志线程被激活....");
            RobotSendWorklog rsw = new RobotSendWorklog();
            _blStarted = true;
            rsw.start();
        }
    }

    public void run()
    {
        int language = 1;
        while(true)
        {
            Calendar c = Calendar.getInstance();
            c.setTimeInMillis(System.currentTimeMillis());
            int hour = c.get(c.HOUR_OF_DAY);
            if(hour == 21) // )
            {
                String _strTime = Entity.sdf.format(c.getTime());
                send(_strTime);
            }

            try
            {
                Thread.sleep(1000L * 60L * 60L);
            } catch(InterruptedException ex1)
            {
            }
        }
    }

    public void send(String _strTime)
    {
        Filex.logs("Worklog.txt",this.getName() + "开始发信(" + _strTime + ")....");
        try
        {
            Calendar c = Calendar.getInstance();
            c.setTime(Entity.sdf.parse(_strTime));
            Date from = c.getTime();
            c.set(11,0);
            c.set(12,0);
            c.set(13,0);
            c.set(14,0);
            c.set(c.DAY_OF_MONTH,c.get(c.DAY_OF_MONTH) + 1);
            Date to = c.getTime();

            Enumeration e = Worklog.findCommunity();
            while(e.hasMoreElements())
            {
                String community = (String) e.nextElement();
                System.out.println("COMMUNITY:" + community);
                // //////查找出部门管理员////////////
                StringBuilder sb = new StringBuilder();
                Enumeration efi = Flowitem.find(community,"");
                while(efi.hasMoreElements())
                {
                    int fid = ((Integer) efi.nextElement()).intValue();
                    String manager = Flowitem.find(fid).getManager();
                    String[] managers = manager.split("/");
                    for(int i = 1;i < managers.length;i++)
                    {
                        sb.append(Profile.find(managers[i]).getProfile() + "/");
                    }
                }
                Enumeration e2 = AdminUsrRole.find(community," AND( classes!='/' OR member IN('" + sb.toString().replaceAll("/","','") + "') )",0,Integer.MAX_VALUE);
                while(e2.hasMoreElements())
                {
                    String tomember = (String) e2.nextElement();
                    Profile p_to = Profile.find(tomember);
                    AdminUsrRole aur_to = AdminUsrRole.find(community,p_to.getProfile());
                    String email = p_to.getEmail();
                    String classes = aur_to.getClasses();
                    if(email != null && email.length() > 0)
                    {
                        StringBuilder sql = new StringBuilder();
                        ArrayList al = new ArrayList();
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            sql.append("SELECT DISTINCT wl.member FROM Worklog wl ");
                            sql.append(" WHERE wl.time>=").append(DbAdapter.cite(from)).append(" AND wl.time<").append(DbAdapter.cite(to)).append(" AND wl.community=").append(DbAdapter.cite(community));
                            sql.append(" AND (1=0");
                            //项目
                            db.executeQuery("SELECT workproject,member FROM Flowitem WHERE community=" + DbAdapter.cite(community) + " AND manager LIKE " + DbAdapter.cite("%/" + tomember + "/%") + " AND member!='/'");
                            while(db.next())
                            {
                                int wp = db.getInt(1);
                                String ms = db.getString(2);
                                sql.append(" OR(wl.workproject=" + wp + " AND wl.member IN('" + ms.substring(1,ms.length() - 1).replaceAll("/","','") + "'))");
                            }
                            //
                            if(classes != null && classes.length() > 1)
                            {
                                sql.append(" OR wl.member in (SELECT pf.member FROM Profile pf INNER JOIN AdminUsrRole aur ON aur.member=pf.profile WHERE aur.community=").append(DbAdapter.cite(community)).append(" AND aur.unit IN(").append(classes.substring(1,classes.length() - 1).replace('/',',')).append("))"); //职位级别
                            }
                            sql.append(")");
                            //
                            //System.out.println(sql.toString());
                            db.executeQuery(sql.toString());
                            while(db.next())
                            {
                                al.add(db.getString(1));
                            }
                        } finally
                        {
                            db.close();
                        }
                        if(al.size() > 0)
                        {
                            //System.out.println("FROM:" + al.toString() + "\tTO:" + tomember + " ( " + email + " )");
                            String str = EditWorkreport.content(community,1,tomember,al.toArray(),null,_strTime);
                            try
                            {
                                tea.service.SendEmaily se = new tea.service.SendEmaily(community);
                                se.sendEmail(email,_strTime + " 的工作日志",str);

                            } catch(Exception ex)
                            {
                                System.out.println("工作日志: " + "error");
                            }
                        }
                    }
                }
            }
        } catch(Throwable ex)
        {
            Filex.logs("Worklog.txt",ex);
            ex.printStackTrace();
        }
    }

    /*public static void main(String args[])
    {
        new RobotSendWorklog().send("2008-01-01");
    }*/
}
