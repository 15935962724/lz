package tea.entity.member;

import java.util.*;
import javax.mail.*;
import tea.db.DbAdapter;
import tea.entity.*;
import javax.mail.internet.*;
import java.sql.SQLException;
import java.io.UnsupportedEncodingException;
import java.io.FileInputStream;
import javax.activation.DataHandler;
import java.io.File;
import tea.resource.Common;
import tea.http.ByteArrayDataSource;

public class EmailBox extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final int POP3O_AUTODELETE = 1;
    public static final int POP3O_AUTOPASSWD = 2;
    public static final int POP3O_AUTOCHECK = 4;
    private int emailbox;
    private String community;
    private String member;
    private String email;
    private String pop3server;
    private int pop3port = 110;
    private String smtpserver;
    private int smtpport = 25;
    private String pop3user;
    private String pop3passwd;
    private int _nPop3Options;
    private Store _store;
    private Folder _folder;

    private EmailBox(int emailbox) throws SQLException
    {
        this.emailbox = emailbox;
        load();
    }

    public String getPop3Passwd()
    {

        return pop3passwd;
    }

    public Folder openFolder() throws SQLException
    { // String strPop3User, String strPop3Passwd
        load();
        try
        {
            java.util.Properties properties = System.getProperties();
            Session session = Session.getDefaultInstance(properties,null);
            _store = session.getStore("pop3");
            _store.connect(pop3server,pop3port,pop3user,pop3passwd);
            _folder = _store.getDefaultFolder();
            _folder = _folder.getFolder("INBOX");
            _folder.open(2); // Folder.READ_ONLY
        } catch(Exception ex)
        {
            ex.printStackTrace();
            return null;
        }
        return _folder;
    }


    public void set(String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE EmailBox  SET pop3passwd=" + DbAdapter.cite(s) + " WHERE emailbox=" + emailbox);
        } finally
        {
            db.close();
        }
        pop3passwd = s;
    }


    public static void create(int emailbox,String community,String s,String email,String smtpserver,int smtpport,String s2,int i,String s3,String s4,int j) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(emailbox > 0)
            {
                db.executeUpdate("UPDATE EmailBox SET email=" + DbAdapter.cite(email) + ",smtpserver=" + DbAdapter.cite(smtpserver) + ",smtpport=" + smtpport + ",pop3server=" + DbAdapter.cite(s2) + ",pop3port=" + i + ",pop3user=" + DbAdapter.cite(s3) + ",pop3passwd=" + DbAdapter.cite(s4) + ",pop3options=" + j + " WHERE emailbox=" + emailbox);
            } else
            {
                db.executeUpdate("INSERT INTO EmailBox (community,member, email, smtpserver,smtpport,pop3server, pop3port, pop3user, pop3passwd, pop3options)VALUES (" + DbAdapter.cite(community) + "," + DbAdapter.cite(s) + ", " + DbAdapter.cite(email) + "," + DbAdapter.cite(smtpserver) + "," + smtpport + "," + DbAdapter.cite(s2) + ", " + i + ", " + DbAdapter.cite(s3) + "," + DbAdapter.cite(s4) + ", " + j + ") ");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(emailbox);
    }

    public int getPop3Port()
    {

        return pop3port;
    }

    public String getPop3Server()
    {

        return pop3server;
    }

    public String getEmail()
    {

        return email;
    }

    public static boolean isExisted(String community,String member,String email) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM EmailBox WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND emailbox=" + DbAdapter.cite(email));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,member,email,pop3server,pop3port,smtpserver,smtpport,pop3user,pop3passwd,pop3options FROM EmailBox WHERE emailbox=" + emailbox);
            if(db.next())
            {
                community = db.getString(1);
                member = db.getString(2);
                email = db.getString(3);
                pop3server = db.getString(4);
                pop3port = db.getInt(5);
                smtpserver = db.getString(6);
                smtpport = db.getInt(7);
                pop3user = db.getString(8);
                pop3passwd = db.getString(9);
                _nPop3Options = db.getInt(10);
            }
        } finally
        {
            db.close();
        }

    }

    public String getPop3User()
    {
        return pop3user;
    }

    public String getSmtpServer()
    {

        return smtpserver;
    }

    public int getSmtpPort()
    {

        return smtpport;
    }

    public int getPop3Options()
    {

        return _nPop3Options;
    }

    public void closeFolder()
    {
        try
        {
            if(_folder != null)
            {
                _folder.close(false);
            }
            if(_store != null)
            {
                _store.close();
            }
        } catch(Exception _ex)
        {
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM EmailBox WHERE emailbox=" + emailbox);
        } finally
        {
            db.close();
        }
        _cache.remove(emailbox);
    }

    public static EmailBox find(int emailbox) throws SQLException
    {
        EmailBox obj = (EmailBox) _cache.get(emailbox);
        if(obj == null)
        {
            obj = new EmailBox(emailbox);
            _cache.put(emailbox,obj);
        }
        return obj;
    }

    public static Enumeration find(String community,String member) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT emailbox FROM EmailBox WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static String decode(String str) throws UnsupportedEncodingException
    {
        if(str == null || str.length() == 0)
        {
            return "----------";
        }
        if(str.indexOf("=?") != -1)
        {
            str = str.replaceAll(" ","_").replaceAll("\r\n","_");
            str = MimeUtility.decodeText(str);
        } else
        {
            for(int i = 0;i < str.length();i++)
            {
                int j = str.charAt(i);
                if((j > 127 && j < 160) || (j > 190 && j < 256))
                {
                    str = new String(str.getBytes("ISO-8859-1"),"GBK");
                    break;
                }
            }
        }
        return str;
    }

    //
    public boolean send(String to,int message) throws SQLException
    {
        Properties p = System.getProperties();
        p.put("mail.smtp.host",smtpserver);
        p.put("mail.smtp.port",smtpport);
        p.put("mail.smtp.auth","true");
        final String fu = pop3user,fp = pop3passwd;
        Session session = Session.getInstance(p,new Authenticator()
        {
            public PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication(fu,fp);
            }
        });
        Message obj = Message.find(message);
        MimeMessage mm = new MimeMessage(session);
        try
        {
            mm.setFrom(new InternetAddress(email));
            mm.addRecipients(javax.mail.Message.RecipientType.TO,to);

            mm.setSubject(obj.subject,"UTF-8");
            mm.setSentDate(new Date());
            if(obj.attch.length() < 2)
            {
                mm.setContent(obj.content,"text/html; charset=UTF-8");
            } else
            {
                MimeMultipart mmp = new MimeMultipart();
                MimeBodyPart mbp = new MimeBodyPart();
                mbp.setContent(obj.content,"text/html;charset=UTF-8");
                mmp.addBodyPart(mbp);
                String[] arr = obj.attch.split("[|]");
                for(int i = 1;i < arr.length;i++)
                {
                    Attch a = Attch.find(Integer.parseInt(arr[i]));
                    //
                    File f = new File(Common.REAL_PATH + a.path);
                    byte by[] = new byte[(int) f.length()];
                    FileInputStream fis = new FileInputStream(f);
                    fis.read(by);
                    fis.close();
                    //
                    mbp = new MimeBodyPart();
                    ByteArrayDataSource bads = new ByteArrayDataSource(by,a.name);
                    mbp.setDataHandler(new DataHandler(bads));
                    mbp.setFileName(bads.getName());
                    mmp.addBodyPart(mbp);
                }
                mm.setContent(mmp);
            }
            Transport.send(mm);
            return true;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            return false;
        }
    }

}
