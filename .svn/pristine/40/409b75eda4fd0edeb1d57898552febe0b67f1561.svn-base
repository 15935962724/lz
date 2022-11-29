package tea.entity.node;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import java.util.Date;
import tea.entity.admin.*;

//@author 黄愉
public class Hotel_application
{
    private static Cache c = new Cache(100);
    private String member; //登陆id与profile表相关联；
    private String linkmanname; //联系人名称；
    private String phone;
    private String fax;
    private String qq;
    private String msn;
    private String introduce; //申请说明；
    private String documents; //资质文件存放的地址；
    private int manage_type; //1 酒店直营，2 代理商
    private int audit;
    private Date times;
    private boolean exists;
    public Hashtable _htLayer;
    public boolean _blLoaded;
    private static Cache _cache = new Cache(100);
    public Hotel_application(String member,String linkmanname,String phone,String fax,String qq,String msn,String introduce,String documents,int manage_type,int audit) throws SQLException
    {
        this.member = member;
        this.linkmanname = linkmanname;
        this.phone = phone;
        this.fax = fax;
        this.qq = qq;
        this.msn = msn;
        this.introduce = introduce;
        this.documents = documents;
        this.manage_type = manage_type;
        this.audit = audit;
        load();
    }

    public Hotel_application()
    {}

    public static Hotel_application find(String member,String linkmanname,String phone,String fax,String qq,String msn,String introduce,String documents,int manage_type,int audit) throws SQLException
    {
        Hotel_application obj = (Hotel_application) c.get(member + ":" + linkmanname + ":" + phone + ":" + fax + ":" + qq + ":" + msn + ":" + introduce + ":" + documents + ":" + manage_type + ":" + audit);
        if(obj == null)
        {
            obj = new Hotel_application(member,linkmanname,phone,fax,qq,msn,introduce,documents,manage_type,audit);
            c.put(member + ":" + linkmanname + ":" + phone + ":" + fax + ":" + qq + ":" + msn + ":" + introduce + ":" + documents + ":" + manage_type + ":" + audit,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT member,linkmanname,phone,fax,qq,msn,introduce,documents,manage_type,audit,times FROM Hotel_application WHERE member=" + DbAdapter.cite(member));
                if(db.next())
                {
                    member = db.getString(1);
                    linkmanname = db.getString(2);
                    phone = db.getString(3);
                    fax = db.getString(4);
                    qq = db.getString(5);
                    msn = db.getString(6);
                    introduce = db.getString(7);
                    documents = db.getString(8);
                    manage_type = db.getInt(9);
                    audit = db.getInt(10);
                    times = db.getDate(11);
                    exists = true;
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
        } else
        {

            if(linkmanname == null)
            {
                linkmanname = "";
            }
            if(member == null)
            {
                member = "";
            }
            if(introduce == null)
            {
                introduce = "";
            }
            if(documents == null)
            {
                documents = "";
            }
        }
        _blLoaded = true;
    }

    //插入记录(申请酒店管理者)
    public void create(String member,int language,String password,String name,String linkmanname,String phone,String fax,String email,String mobile,String qq,String msn,int cardtype,String card,String introduce,String documents,int manage_type,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        Date times = new Date();
        //DbAdapter d = new DbAdapter(1);
        try
        {

            int i = db.executeUpdate("INSERT INTO hotel_application(member,linkmanname,phone,fax,qq,msn,introduce,documents,manage_type,audit,times)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(linkmanname) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(qq) + "," + DbAdapter.cite(msn) + "," + DbAdapter.cite(introduce) + "," + DbAdapter.cite(documents) + "," + manage_type + ",0," + db.cite(times) + ")");
            Profile.create(member,community,password,mobile,false,card,cardtype,name,email,language,null);
            if(i > 0)
            {
            } else
            {
                db.executeQuery("DELETE  FROM hotel_application WHERE member=" + member);
                Profile.delete(member,language,community);
            }
        } finally
        {
            db.close();
        }
    }

    /**
     * 修改酒店管理员的信息！
     * */
    public void set(String member,int language,String password,String name,String linkmanname,String phone,String fax,String email,String mobile,String qq,String msn,int cardtype,String card,String introduce,String documents,int manage_type,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE hotel_application SET linkmanname=" + DbAdapter.cite(linkmanname) + ",phone=" + DbAdapter.cite(phone) + ",fax=" + DbAdapter.cite(fax) + ",qq=" + DbAdapter.cite(qq) + ",msn=" + DbAdapter.cite(msn) + ",introduce=" + DbAdapter.cite(introduce) + ",documents=" + DbAdapter.cite(documents) + ",manage_type=" + manage_type + ",audit=" + audit + "WHERE member=" + DbAdapter.cite(member));
            Profile.find(member).set(member,community,password,mobile,0,card,cardtype,name,email,language,null);
        } finally
        {
            db.close();
        }
    }

    //更新为管理员  audit 为 1
    public void upById(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE Hotel_application SET audit=1 WHERE member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

//通过id删除不同意的人选信息
    public void deleteById(String member,int language,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Hotel_application WHERE member=" + DbAdapter.cite(member));
           Profile.find(member).delete(member,language,community);
        } finally
        {
            db.close();
        }
    }

    public void delete(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Hotel_application WHERE member=" + DbAdapter.cite(member));
            db.executeUpdate("delete from adminusrrole where member=" + db.cite(member));
        } finally
        {
            db.close();
        }
    }

    //判断是否存在
    public static boolean isExist(String member) throws SQLException
    {
        boolean flag = false;
        {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM Profile WHERE member =" + DbAdapter.cite(member));
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery(sb.toString());
                flag = db.next();
            } finally
            {
                db.close();
            }
            return flag;
        }
    }

    public static boolean isLayerExist(String member) throws SQLException
    {
        boolean flag = false;
        {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM ProfileLayer WHERE member =" + DbAdapter.cite(member));
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery(sb.toString());
                flag = db.next();
            } finally
            {
                db.close();
            }
            return flag;
        }

    }

//判断是否审核
    public static boolean isExistAudit(String member) throws SQLException
    {
        boolean flag = false;
        {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM Hotel_application WHERE audit = 1 and member =" + DbAdapter.cite(member));
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery(sb.toString());
                flag = db.next();
            } finally
            {
                db.close();
            }
            return flag;
        }
    }

    /**
     * Hotel_application
     *
     * @param string String
     * @param i int
     * @param string1 String
     * @param string2 String
     * @param i1 int
     */
    //查询所有没有经过审批和经过审批的人，通过int audit 来查询 返回 Enumeration 的对象   @author 黄愉
    //查询酒店的名字, pos:开始记录，size:每页条数 师傅写的：
    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM Hotel_application WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                String member = db.getString(1);
                String linkmanname = db.getString(2);
                String phone = db.getString(3);
                String fax = db.getString(4);
                String qq = db.getString(5);
                String msn = db.getString(6);
                String introduce = db.getString(7);
                String documents = db.getString(8);
                int manage_type = db.getInt(9);
                int audit = db.getInt(10);
                Hotel_application obj = Hotel_application.find(member,linkmanname,phone,fax,qq,msn,introduce,documents,manage_type,audit);
                v.addElement(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Hotel_application WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    //mofang:
    private Hotel_application(String member) throws SQLException
    {
        this.member = member;
        _htLayer = new Hashtable();
        load();
    }

    //mo fang:
    public static Hotel_application find(String member) throws SQLException
    {
        Hotel_application obj = (Hotel_application) c.get(member);
        if(obj == null)
        {
            obj = new Hotel_application(member);
            c.put(member,obj);
        }
        return obj;
    }

    //
    //查询符合条件的条数
    public static int countByAudit(int audit) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Hotel_application WHERE audit=" + audit);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    //通过用户名和酒店名字查询：memberid
//    public static Enumeration findByIdName(String memberid) throws SQLException
//    {
//        Vector v = new Vector();
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT * FROM Hotel_application WHERE member=" + DbAdapter.cite(memberid));
//            //
//            while (db.next())
//            {
//                String member = db.getString(1);
//                String linkmanname = db.getString(2);
//                String phone = db.getString(3);
//                String fax = db.getString(4);
//                String qq = db.getString(5);
//                String msn = db.getString(6);
//                String introduce = db.getString(7);
//                String documents = db.getString(8);
//                int manage_type = db.getInt(9);
//                int audit = db.getInt(10);
//                Hotel_application obj = new Hotel_application(member, linkmanname, phone, fax, qq, msn, introduce, documents, manage_type, audit);
//                v.addElement(obj);
//            }
//        } finally
//        {
//            db.close();
//        }
//        return v.elements();
//    }

    public int getAudit()
    {
        return audit;
    }

    public Cache getC()
    {
        return c;
    }


    public boolean isExists()
    {
        return exists;
    }

    public String getDocuments()
    {
        return documents;
    }

    public String getIntroduce()
    {
        return introduce;
    }

    public int getManage_type()
    {
        return manage_type;
    }

    public String getMember()
    {
        return member;
    }

    public String getFax()
    {
        return fax;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getQq()
    {
        return qq;
    }

    public String getMsn()
    {
        return msn;
    }

    public String getLinkmanname()
    {
        return linkmanname;
    }

    public String getLinkManName()
    {
        return linkmanname;
    }

    public void setLinkManName(String linkmanname)
    {
        this.linkmanname = linkmanname;
    }

    public void setMember(String member)
    {
        this.member = member;
    }

    public void setManage_type(int manage_type)
    {
        this.manage_type = manage_type;
    }

    public void setIntroduce(String introduce)
    {
        this.introduce = introduce;
    }

    public void setDocuments(String documents)
    {
        this.documents = documents;
    }

    public void setExists(boolean exists)
    {
        this.exists = exists;
    }

    public void setC(Cache c)
    {
        this.c = c;
    }

    public void setAudit(int audit)
    {
        this.audit = audit;
    }

    public void setFax(String fax)
    {
        this.fax = fax;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public void setQq(String qq)
    {
        this.qq = qq;
    }

    public void setMsn(String msn)
    {
        this.msn = msn;
    }

    public void setLinkmanname(String linkmanname)
    {
        this.linkmanname = linkmanname;
    }

    public Date getTimes()
    {
        return times;
    }

}
