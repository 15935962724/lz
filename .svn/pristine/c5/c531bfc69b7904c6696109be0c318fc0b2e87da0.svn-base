package tea.entity.site;

import java.sql.*;
import java.util.*;
import java.util.Date;
import java.io.*;
import tea.db.*;
import tea.entity.*;


public class CommunityXml extends Entity
{
    private static Cache _cache = new Cache(100);
    private int xmlid;
    private String subject; //
    private String content; //
    private String charset;
    private String community; //
    private boolean exist;

    public CommunityXml(int xmlid) throws SQLException
    {
        this.xmlid = xmlid;
        load();
    }

    public static CommunityXml find(int xmlid) throws SQLException
    {
        CommunityXml objPerform = (CommunityXml) _cache.get(xmlid);
        if(objPerform == null)
        {
            objPerform = new CommunityXml(xmlid);
            _cache.put(xmlid,objPerform);
        }
        return objPerform;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subject,content,charset,community FROM CommunityXml WHERE xmlid=" + xmlid);
            if(db.next())
            {
                subject = db.getString(1);
                content = db.getString(2);
                charset = db.getString(3);
                community = db.getString(4);
                exist = true;
            } else
            {
                exist = false;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public static void create(String subject,String content,String charset,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CommunityXml(subject,content,charset,community) VALUES(" + db.cite(subject) + "," + db.cite(content) + "," + db.cite(charset) + "," + db.cite(community) + " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String subject,String content,String charset,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CommunityXml SET subject=" + db.cite(subject) + ",content=" + db.cite(content) + ",charset=" + db.cite(charset) + ",community=" + db.cite(community) + " WHERE xmlid=" + xmlid);
        } finally
        {
            db.close();
        }
        this.subject = subject;
        this.content = content;
        this.charset = charset;
        _cache.remove(xmlid);
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT xmlid FROM CommunityXml WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  CommunityXml WHERE xmlid=" + xmlid);
        } finally
        {
            db.close();
        }
    }

    public static boolean isSubject(String community,String subject) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("select xmlid from CommunityXml where  community =" + db.cite(community) + " and  subject =" + db.cite(subject));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }


    /**
     * 新建文件
     * @param folderPath String 文件路径及名称 如c:/fqf.txt
     * @param fileName String 文件路径及名称 如c:/fqf.txt
     * @param fileContent String 文件内容
     * @return boolean
     */
    public void newFile(String folderPath,String fileName,String fileContent)
    {
        try
        {
            //如果没有路径创建
            File myFilePath = new File(folderPath);
            if(!myFilePath.exists())
            {
                myFilePath.mkdir();
            }
            //创建文件
            String filePath = folderPath + fileName;
            filePath = filePath.toString();
            File myFilePath1 = new File(filePath);
            if(!myFilePath1.exists())
            {
                myFilePath1.createNewFile();
            }
            //添加文件内容
            PrintWriter myFile = new PrintWriter(myFilePath1,charset);
            String strContent = fileContent;
            myFile.println(strContent);
            myFile.close();

        } catch(Exception e)
        {
            System.out.println("新建目录操作出错");
            e.printStackTrace();

        }

    }

    /**
     * 删除文件
     * @param filePathAndName String 文件路径及名称 如c:/fqf.txt
     * @param fileContent String
     * @return boolean
     */
    public void delFile(String filePathAndName)
    {
        try
        {
            String filePath = filePathAndName;
            filePath = filePath.toString();
            java.io.File myDelFile = new java.io.File(filePath);
            myDelFile.delete();
        } catch(Exception e)
        {
            System.out.println("删除文件操作出错");
            e.printStackTrace();

        }

    }


    public String getSubject()
    {
        return subject;
    }

    public String getCommunity()
    {
        return community;
    }


    public boolean isExist()
    {
        return exist;
    }

    public String getContent()
    {
        return content;
    }

    public String getCharset()
    {
        return charset;
    }
}
