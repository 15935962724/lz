package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Entity;
import tea.entity.MT;
import tea.entity.site.Community;
import tea.entity.yl.shop.EmailMessage;

import javax.mail.*;
import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.*;

public class Email extends Entity
{
    private static Cache ht = new Cache(100);
    private String email;
    private String emailbox;
    private String fmail;
    private String tmail;
    private String cc;
    private String bcc;
    private boolean reader;
    private Date time;
    private int language;
    private String subject;
    private String content;
    private boolean exists;
    public Email(String email) throws SQLException
    {
        this.email = email;
        load();
    }

    public static Email find(String email) throws SQLException
    {
        Email obj = (Email) ht.get(email);
        if(obj == null)
        {
            obj = new Email(email);
            ht.put(email,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT emailbox,fmail,tmail,cc,bcc,reader,time,subject,content FROM Email WHERE email=" + db.cite(email));
            if(db.next())
            {
                emailbox = db.getString(1);
                fmail = db.getString(2);
                tmail = db.getString(3);
                cc = db.getString(4);
                bcc = db.getString(5);
                reader = db.getInt(6) != 0;
                time = db.getDate(7);
                subject = db.getString(8);
                content = db.getText(9);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(final String community,final String from,final String to,final String subject,final String content,boolean sync)
    {
        new Thread()
        {
            public void run()
            {
                try
                {
                    Email.create(community,from,to,subject,content);
                } catch(SQLException ex)
                {}
            }
        }.start();
    }

    public static boolean create(String community,String from,String to,String subject,String content) throws SQLException
    {
        final Community c = Community.find(community);
        Properties p = System.getProperties();
        p.put("mail.smtp.host",c.getSmtp());
        p.put("mail.smtp.auth","true");
        Session session = Session.getInstance(p,new Authenticator()
        {
            public PasswordAuthentication getPasswordAuthentication()
            {
				System.out.println(c.getSmtpUser()+","+c.getSmtpPassword());
                return new PasswordAuthentication(c.getSmtpUser(),c.getSmtpPassword());
            }
        });
        MimeMessage mm = new MimeMessage(session);
        try
        {
            List<EmailMessage> emailMessages = EmailMessage.find(" AND email=" + Database.cite(to) + " AND time=" + Database.cite(MT.f(new Date())), 0, Integer.MAX_VALUE);
            if(emailMessages.size()==5){//发邮件不能多于5次
                return false;
            }else {
                EmailMessage em = EmailMessage.find(0);
                em.setEmail(to);
                em.setTime(MT.f(new Date()));
                em.set();

                if (from == null) {
                    mm.setFrom(new InternetAddress(c.getSmtpUser(), c.getSmtpName()));
                } else {
                    mm.setFrom(new InternetAddress(from));
                }
                to = to.replace(',', ';');
                StringTokenizer stringtokenizer = new StringTokenizer(to, "; ");
                int l = stringtokenizer.countTokens();

                InternetAddress ainternetaddress[] = new InternetAddress[l];
                for (int k1 = 0; stringtokenizer.hasMoreTokens(); k1++) {
                    String s12 = stringtokenizer.nextToken();
                    ainternetaddress[k1] = new InternetAddress(s12);
                }
                mm.addRecipients(Message.RecipientType.TO, ainternetaddress);

                mm.setSubject(subject, "UTF-8");
                mm.setSentDate(new Date());
                mm.setContent(content, "text/html; charset=UTF-8");
                // 发送附件/////////////////
                // Matcher m = Pattern.compile("src=\"([^>\"]+)\"", Pattern.CASE_INSENSITIVE).matcher(content);
                // java.util.Hashtable h = new java.util.Hashtable();
                // int cid_len = 0;
                // while (m.find())
                // {
                // String url = m.group(1);
                // // System.out.println(url);
                // String cid_url = url.replace('/', '_').replace(':', '_');
                // try
                // {
                // if (h.get(url) == null)
                // {
                // java.net.URL u = new java.net.URL(url);
                // java.net.HttpURLConnection conn = (HttpURLConnection) u.openConnection();
                // conn.setConnectTimeout(5000);
                // java.io.InputStream is = conn.getInputStream();
                // byte by[] = new byte[conn.getContentLength()];
                // is.read(by);
                // is.close();
                //
                // FileOutputStream fos = new FileOutputStream("d:/aa_" + cid_len + ".jpg");
                // fos.write(by);
                // fos.close();
                //
                // MimeBodyPart mbp = new MimeBodyPart();
                // ByteArrayDataSource bytearraydatasource = new ByteArrayDataSource(by, u.getFile());
                // mbp.setDataHandler(new DataHandler(bytearraydatasource));
                // mbp.setFileName(bytearraydatasource.getName());
                // mbp.setHeader("Content-id", cid_url);
                // h.put(url, mbp);
                // }
                // content = content.substring(0, m.start(1) + cid_len) + "cid:" + cid_url + content.substring(m.end(1) + cid_len);
                // cid_len = cid_len + 4;
                // } catch (IOException ioe)
                // {
                // }
                // }
                // MimeBodyPart mbp = new MimeBodyPart();
                // mbp.setContent("﻿<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\"></HEAD><BODY>" + decode(content), "text/html;charset=UTF-8");
                //
                // MimeMultipart mm = new MimeMultipart("related");
                // mm.addBodyPart(mbp);
                //
                // java.util.Enumeration e = h.elements();
                // while (e.hasMoreElements())
                // {
                // mm.addBodyPart((MimeBodyPart) e.nextElement());
                // }
                // mm.setContent(mm);
                Transport.send(mm);
                return true;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            return false;
        }
    }

    public static String create(String emailbox,Message msg) throws Exception
    {
        String fmail = Email.addressToString(msg.getFrom());
        Date time = msg.getSentDate();
        int size = msg.getSize();
        //id
        String mids[] = msg.getHeader("message-id");
        String email = (mids != null ? mids[0] : time + "." + size + "." + fmail);
        Email obj = Email.find(email);
        if(!obj.isExists())
        {
            String subject = EmailBox.decode(msg.getSubject());
            String content = null;
            String tmail = Email.addressToString(msg.getRecipients(Message.RecipientType.TO));
            String cc = Email.addressToString(msg.getRecipients(Message.RecipientType.CC));
            String bcc = Email.addressToString(msg.getRecipients(Message.RecipientType.BCC));
            String str = "INSERT INTO Email(email,emailbox,fmail,tmail,cc,bcc,reader,time,subject,content)VALUES(" + DbAdapter.cite(email) + "," + DbAdapter.cite(emailbox) + "," + DbAdapter.cite(fmail) + "," + DbAdapter.cite(tmail) + "," + DbAdapter.cite(cc) + "," + DbAdapter.cite(bcc) + ",0," + DbAdapter.cite(time) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + " )";
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate(str);
            } finally
            {
                db.close();
            }
            ht.remove(email);
        }
        return email;
    }

    public void setReader() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Email SET reader=" + 1 + " WHERE email=" + db.cite(email));
        } finally
        {
            db.close();
        }
        this.reader = true;
    }

    public String getTMail()
    {
        return tmail;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "--";
        }
        return sdf2.format(time);
    }

    public String getSubject()
    {
        return subject;
    }

    public boolean isReader()
    {
        return reader;
    }

    public String getFMail()
    {
        return fmail;
    }

    public String getEmailbox()
    {
        return emailbox;
    }

    public String getEmail()
    {
        return email;
    }

    public String getContent()
    {
        return content;
    }

    public String getCc()
    {
        return cc;
    }

    public String getBcc()
    {
        return bcc;
    }

    public boolean isExists()
    {
        return exists;
    }

    public static String addressToString(Address add[]) throws UnsupportedEncodingException
    {
        StringBuilder sb = new StringBuilder();
        InternetAddress ias[] = (InternetAddress[]) add;
        if(ias != null)
        {
            for(int k = 0;k < ias.length;k++)
            {
                String name = ias[k].getPersonal();
                String email = ias[k].getAddress();
                name = name == null ? email : EmailBox.decode(name);
                if(k > 0)
                {
                    sb.append(", ");
                }
                sb.append(name).append(" ").append("<").append(email).append(">");
            }
        }
        return sb.toString();
    }

    public static String stringToAnchor(String str)
    {
        StringBuilder sb = new StringBuilder();
        if(str.length() > 0)
        {
            String as[] = str.substring(0,str.length() - 1).split(">, ");
            for(int k = 0;k < as.length;k++)
            {
                int j = as[k].lastIndexOf(" <");
                String name = as[k].substring(0,j);
                String email = as[k].substring(j + 2);
                sb.append("<a href='/jsp/message/NewEmail.jsp?act=re&amp;to=" + email + "' target='_blank'>" + name + "</a>　");
            }
        }
        return sb.toString();
    }
}
