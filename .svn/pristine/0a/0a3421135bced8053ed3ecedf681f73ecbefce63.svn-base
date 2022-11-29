package tea.entity.member;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;

public class MessageOld extends Entity
{
    private static Cache ht = new Cache(100);
    public static final String STATUS_TYPE[] =
            {"Inbox","Sent","Draft","Trash","预留","已删除"};
    private int message;
    private String community;
    private String fmember;
    private int folder; //发送到那个文件夹中...
    private String tmember;
    private String trole;
    private String tunit;

    private String reader;
    private int hint;
    private boolean feedback; //
    private String url;
    private Date time;
    private int language;
    private String subject;
    private String content;

    public MessageOld(int message) throws SQLException
    {
        this.message = message;
        _htAttachment = new Hashtable();
        load();
    }

    public static MessageOld find(int message) throws SQLException
    {
        MessageOld obj = (MessageOld) ht.get(new Integer(message));
        if(obj == null)
        {
            obj = new MessageOld(message);
            ht.put(new Integer(message),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,folder,fmember,tmember,trole,tunit,reader,hint,feedback,url,language,subject,content,time FROM Message WHERE message=" + message);
            if(db.next())
            {
                community = db.getString(1);
                folder = db.getInt(2);
                fmember = db.getString(3);
                tmember = db.getString(4);
                trole = db.getString(5);
                tunit = db.getString(6);
                reader = db.getString(7);
                hint = db.getInt(8);
                feedback = db.getInt(9) != 0;
                url = db.getString(10);
                language = db.getInt(11);
                subject = db.getString(12);
                content = db.getText(13);
                time = db.getDate(14);
            }
        } finally
        {
            db.close();
        }
    }

    public static int createTempMessage(String community,String fmember) throws SQLException
    {
        int tmp;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT message FROM Message WHERE community=" + DbAdapter.cite(community) + " AND fmember=" + DbAdapter.cite(fmember) + " AND fmember=" + DbAdapter.cite(fmember) + " AND folder=-1");
            if(db.next())
            {
                tmp = db.getInt(1);
            } else
            {
                db.executeUpdate("INSERT INTO Message(community,fmember,folder,reader)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(fmember) + ",-1," + DbAdapter.cite("/" + fmember + "/") + ")");
                tmp = db.getInt("SELECT MAX(message) FROM Message");
            }
        } finally
        {
            db.close();
        }
        return tmp;
    }

    public static int create(String community,String fmember,String tmember,int language,String subject,String content) throws SQLException
    {
        return create(community,5,fmember,tmember,"/","/",0,"",language,subject,content);
    }

    public static int create(String community,int folder,String fmember,String tmember,String trole,String tunit,int hint,String url,int language,String subject,String content) throws SQLException
    {
        if(!tmember.startsWith("/"))
        {
            tmember = "/" + tmember;
        }
        if(!tmember.endsWith("/"))
        {
            tmember = tmember + "/";
        }
        int id = 0;
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        String str = "INSERT INTO Message(community,folder,fmember,tmember,trole,tunit,reader,hint,url,language,subject,content,time)VALUES(" + DbAdapter.cite(community) + "," + folder + "," + DbAdapter.cite(fmember) + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(trole) + "," + DbAdapter.cite(tunit) + ",'/'," + hint + "," + DbAdapter.cite(url) + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + "," + db.cite(time) + " )";
        try
        {
            db.executeUpdate(str);
            id = db.getInt("SELECT MAX(message) FROM Message");
        } finally
        {
            db.close();
        }
        return id;
    }

    public static int count(String community,String member,int folder) throws SQLException
    {
        return count(community,member,folder,"");
    }

    public static int countNew(String community,String member,int folder) throws SQLException
    {
        return count(community,member,folder," AND reader NOT LIKE " + DbAdapter.cite("%/" + member + "/%"));
    }

    private static String getSql(String community,String member,int folder) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append(" FROM Message m WHERE ( ( folder=" + folder + " AND fmember=" + DbAdapter.cite(member) + " ) OR (");
        if(folder == 0)
        {
            sb.append(" NOT EXISTS ( SELECT mr.member FROM MessageReader mr WHERE m.message=mr.message AND mr.member=" + DbAdapter.cite(member) + " )");
            sb.append(" AND folder!=2"); //不显示"草稿箱"中邮件
        } else
        {
            sb.append(" EXISTS ( SELECT mr.member FROM MessageReader mr WHERE m.message=mr.message AND mr.member=" + DbAdapter.cite(member) + " AND mr.folder=" + folder + " )");
        }
        sb.append(" AND (");

        sb.append(" ( tmember='/' AND trole='/' AND tunit='/' AND time>" + DbAdapter.cite(Profile.find(member).getTime()) + " ) OR"); //不填代表所有人可以查看///
        sb.append(" tmember LIKE ").append(DbAdapter.cite("%/" + member + "/%"));
        AdminUsrRole aur = AdminUsrRole.find(community,member);
        //role////
        String rs[] = aur.getRole().split("/");
        for(int i = 1;i < rs.length;i++)
        {
            sb.append(" OR trole LIKE ").append(DbAdapter.cite("%/" + rs[i] + "/%"));
        }
        //unit////
        String us[] = (aur.getUnit() + aur.getClasses()).split("/");
        for(int i = 0;i < us.length;i++)
        {
            sb.append(" OR tunit LIKE ").append(DbAdapter.cite("%/" + us[i] + "/%"));
        }
        sb.append(" ) ) ) AND fmember NOT IN( SELECT black FROM Blacklist WHERE member=" + DbAdapter.cite(member) + ")");
        return sb.toString();
    }

    public static int count(String community,String member,int folder,String sql) throws SQLException
    {
        sql = "SELECT COUNT(message)" + getSql(community,member,folder) + sql;

        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static ArrayList find(String community,String member,int folder,String sql,int pos,int size) throws SQLException
    {
        sql = "SELECT message" + getSql(community,member,folder) + sql;
        //System.out.println(sql);
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql,pos,size);

            while(db.next())
            {
                al.add(db.getInt(1));


            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Iterator find(String community,String member,int folder,int pos,int size) throws SQLException
    {
        return find(community,member,folder,"message",true,pos,size);
    }

    public static Iterator find(String community,String member,int folder,String order,boolean asc,int pos,int size) throws SQLException
    {
        return find(community,member,folder," ORDER BY " + order + " " + (asc ? "DESC" : "ASC"),pos,size).iterator();
    }

    public void set(int folder,String tmember,String trole,String tunit,int hint,int language,String subject,String content,boolean feedback) throws SQLException
    {
        this.time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Message SET folder=" + folder + ",tmember=" + DbAdapter.cite(tmember) + ",trole=" + DbAdapter.cite(trole) + ",tunit=" + DbAdapter.cite(tunit) + ",hint=" + hint + ",feedback=" + DbAdapter.cite(feedback) + ",language=" + language + ",subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",time=" + db.cite(time) + " WHERE message=" + message);
        } finally
        {
            db.close();
        }
        this.folder = folder;
        this.tmember = tmember;
        this.trole = trole;
        this.tunit = tunit;
        this.hint = hint;
        this.feedback = feedback;
        this.language = language;
        this.subject = subject;
        this.content = content;
    }

    public void setReader(String member) throws SQLException
    {
        if(reader.indexOf("/" + member + "/") == -1)
        {
            reader = reader + member + "/";
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Message SET reader=" + db.cite(reader) + " WHERE message=" + message);
            } finally
            {
                db.close();
            }
            if(feedback && !fmember.equals(member)) //自动给发送回馈 && 发件人和收件人不能是同一人
            {
                MessageOld.create(community,member,fmember,language,"[系统消息] " + member + "已查看了“" + subject + "”","于 " + sdf2.format(new Date()) + member + "已查看了<a href=/jsp/message/Message.jsp?community=" + community + "&message=" + message + ">" + subject + "</a>邮件.");
            }
        }
    }

    //发件人更改文件夹
    public void setFolder(int folder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Message SET folder=" + folder + " WHERE message=" + message);
        } finally
        {
            db.close();
        }
        this.folder = folder;
    }

    public String getTUnit()
    {
        return tunit;
    }

    public int getHint()
    {
        return hint;
    }

    public boolean isFeedback()
    {
        return feedback;
    }

//  public void setStatus(String member, int status) throws SQLException
//  {
//    StringBuilder sql = new StringBuilder();
//    sql.append("UPDATE Message SET ");
//    if (member.equals(tmember))
//    {
//      sql.append("tstatus=").append(status);
//      this.tstatus = status;
//    }
//    if (member.equals(fmember))
//    {
//      // 有可以发件人就是收件人
//      if (sql.length() > 25)
//      {
//        sql.append(",");
//      }
//      sql.append("folder=").append(status);
//      this.folder = status;
//    }
//    sql.append(" WHERE message=" + message);
//    DbAdapter db = new DbAdapter();
//    try
//    {
//      db.executeUpdate(sql.toString());
//    } finally
//    {
//      db.close();
//    }
//  }

    //收信人更改文件夹
    public void setFolder(String member,int folder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(folder == 0)
            {
                db.executeUpdate("DELETE FROM MessageReader WHERE message=" + message + " AND member=" + DbAdapter.cite(member));
            } else
            {
                int j = db.executeUpdate("UPDATE MessageReader SET folder=" + folder + " WHERE message=" + message + " AND member=" + DbAdapter.cite(member));
                if(j < 1)
                {
                    db.executeUpdate("INSERT INTO MessageReader(message,member,folder)VALUES(" + message + "," + DbAdapter.cite(member) + "," + folder + ")");
                }
            }
        } finally
        {
            db.close();
        }
        if(member.equals(fmember)) //如果发件人和收件人是同一个人则
        {
            setFolder(folder);
        }
    }

//  public void delete(String member)
//  {
//    if (member.equals(fmember))
//    {
//      folder = 5;
//    } else if (member.equals(tmember))
//    {
//      tstatus = 5;
//    } else
//    {
//      return;
//    }
//    if (folder == 3 && tstatus == 3)
//    {
//      // /
//    }
//  }

    public int getMessage()
    {
        return message;
    }

    public String getFMember()
    {
        return fmember;
    }

    public String getTMember()
    {
        return tmember;
    }

    public String getTo(int language) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        if(tmember.length() > 1)
        {
            sb.append(tmember.replaceAll("/","；").substring(1));
        }
        String tus[] = tunit.split("/");
        for(int j = 1;j < tus.length;j++)
        {
            AdminUnit au = AdminUnit.find(Integer.parseInt(tus[j]));
            if(au.isExists())
            {
                sb.append(au.getName()).append("; ");
            }
        }
        return sb.toString();
    }

    public int getFolder()
    {
        return folder;
    }

    public String getSubject(int language)
    {
        return subject;
    }

    public String getContent(int language)
    {
        return content;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return sdf2.format(time);
    }

    public boolean isReader(String member)
    {
        return reader.indexOf("/" + member + "/") != -1;
    }

    public int getLanguage()
    {
        return language;
    }

    // 附件////////////////
    private Hashtable _htAttachment;

    class Attachment
    {
        Attachment()
        {

        }

        public String filename;
        public String filepath;
    }


    public void createAttachment(int i,String filename,String filepath) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO MessageAttachment(message, part, filename, filepath) VALUES(" + message + ", " + i + ", " + DbAdapter.cite(filename) + ", " + DbAdapter.cite(filepath) + ")");
        } finally
        {
            db.close();
        }
    }

    private Attachment getAttachment(int part)
    {
        Attachment obj = (Attachment) _htAttachment.get(new Integer(part));
        if(obj == null)
        {
            obj = new Attachment();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT filename,filepath FROM MessageAttachment WHERE message=" + message + " AND part=" + part);
                if(db.next())
                {
                    obj.filename = db.getString(1);
                    obj.filepath = db.getString(2);
                }
            } catch(Exception exception)
            {
            } finally
            {
                db.close();
            }
            _htAttachment.put(new Integer(part),obj);
        }
        return obj;
    }

    public String getAttachmentFilePath(int part) throws SQLException
    {
        return getAttachment(part).filepath;
    }

    public String getAttachmentFileName(int part,int j) throws SQLException
    {
        return tea.translator.Translator.getInstance().translate(getAttachment(part).filename,j,j);
    }

    public int countAttachment() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(part) FROM MessageAttachment WHERE message=" + message);
        } finally
        {
            db.close();
        }
        return i;
    }

    public Enumeration findAttachment() throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeQuery("SELECT part FROM MessageAttachment (NOLOCK)
            // WHERE message=" + _nMessage);
            db.executeQuery("SELECT part FROM MessageAttachment WHERE message=" + message);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public int getMaxPart() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT part FROM MessageAttachment WHERE message=" + message + " ORDER BY part DESC");
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public void deleteAttachmentPart(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MessageAttachment WHERE message=" + message + " AND part=" + i);
        } finally
        {
            db.close();
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public String getUrl()
    {
        return url;
    }

    public String getTRole()
    {
        return trole;
    }
}
