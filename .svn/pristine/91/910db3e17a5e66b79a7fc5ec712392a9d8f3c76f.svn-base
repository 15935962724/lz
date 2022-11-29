package tea.service;

import tea.entity.*;
import tea.db.*;
import javax.mail.*;

public class TimeSend extends Service implements Runnable
{
    int _nNode;
    String fromEmail;
    javax.mail.Session session;
    public TimeSend(int x,int y,int _nNode)
    {
        super(x,y); //位置
        this._nNode = _nNode;
//        tea.entity.node.Node node=tea.entity.node.Node.find(_nNode) ;
        try
        {
            tea.entity.site.Community community = tea.entity.site.Community.find(_nNode);
            java.util.Properties properties = System.getProperties();
            properties.put("mail.smtp.host",community.getSmtp());
            properties.put("mail.smtp.auth","true");
            fromEmail = community.getEmail();
            final String smtpuser = community.getSmtpUser();
            final String password = community.getSmtpPassword();
            session = Session.getDefaultInstance(properties,new Authenticator()
            {
                public PasswordAuthentication getPasswordAuthentication()
                {
                    return new PasswordAuthentication(smtpuser,password);
                }
            });
        } catch(Exception ex)
        {
            addLog(ex.toString());
        }
    }

    public void run()
    {
        while(Robot._blStarted)
        {
            tea.db.DbAdapter db = new tea.db.DbAdapter();
            try
            {
                java.lang.Thread.sleep(1000 * 60 * 60 * 24);
                addLog("Start");
                tea.entity.node.Job.stop(); //把已过有效期的职位，暂停（隐藏）

                java.util.Calendar calendar = java.util.Calendar.getInstance();
                calendar.set(5,calendar.get(5) - 1);
                db.executeQuery("SELECT email FROM ProfileLayer WHERE member IN (SELECT member FROM Resume WHERE node IN (SELECT resumenode FROM Apply WHERE corpnode IN(SELECT node FROM Job WHERE CONVERT(varchar(10),validitydate,120)='" + new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()) + "' AND node IN(SELECT node FROM Node WHERE community='Test'))))");
                while(db.next())
                {
                    try
                    {
                        javax.mail.internet.MimeMessage mimemessage = new javax.mail.internet.MimeMessage(session);
                        mimemessage.setFrom(new javax.mail.internet.InternetAddress(fromEmail));
                        mimemessage.setSentDate(new java.util.Date());
                        mimemessage.setSubject("中国海洋石油总公司人力资源部");
                        mimemessage.setContent("本公司招募人才工作承蒙大力支持，非常感谢。如果一个月内我们没有在此联系您，说明该岗位已有合适的人选。但我们已经将您的资料列入储备人才档案，如果有合适的职位，我们将及时同您联系。期待有机会邀请您加盟中国海洋石油事业！最后对您应征本公司的热诚致以诚挚的谢意。<BR>中国海洋石油总公司人力资源部","text/html;charset=gb2312");
                        mimemessage.setRecipient(javax.mail.Message.RecipientType.TO,new javax.mail.internet.InternetAddress(db.getString(1)));
                        javax.mail.Transport.send(mimemessage);
                    } catch(Exception ex1)
                    {
                        addLog(ex1.toString());
                    }
                }
                addLog("Stop");
            } catch(Exception ex)
            {
                addLog(ex.toString());
            } finally
            {
                db.close();
            }
        }
    }

    public void finalize()
    {
    }
}
/*****************************************
 select
    a.email
 from
    ProfileLayer a
 inner join
    Resume b
 on
    a.member = b.member
 inner join
    Apply c
 on
    b.node = c.resumenode
 inner join
    Job d
 on
    c.corpnode = d.node
 inner join
    Node e
 on
    d.node = e.node
 where
    convert(char(10),d.validitydate,120)='2005-02-03'
    and
    e.community='Test'
 group by
    a.email

 -----------------------------------

 select
     a.email
 from
     ProfileLayer a,
     Resume b,
     Apply c,
     Job d,
     Node e
 where
     a.member = b.member
     and
     b.node = c.resumenode
     and
     c.corpnode = d.node
     and
     d.node = e.node
     and
     convert(char(10),d.validitydate,120)='2005-02-03'
     and
     e.community='Test'
 group by
     a.email

 ***********************************/
