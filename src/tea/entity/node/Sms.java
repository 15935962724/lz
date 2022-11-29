package tea.entity.node;

import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Sms extends Entity
{
    public boolean user_create(String PhoneNumber,String RealName,String NickName,String Email,int IDType,String IDNumber,int ad) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SmsUserCreate " + DbAdapter.cite(PhoneNumber) + ", " + DbAdapter.cite(RealName) + ", " + DbAdapter.cite(NickName) + ", " + DbAdapter.cite(Email) + ", " + IDType + ", " + DbAdapter.cite(IDNumber) + ", " + ad + ", " + DbAdapter.cite(password()));
            flag = true;
        } catch(Exception exception)
        {
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean user_delete(String PhoneNumber) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from SMSuser where phonenumber like " + DbAdapter.cite(PhoneNumber));
            flag = true;
        } catch(Exception exception)
        {
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String password() throws SQLException
    {
        String s = "";
        for(int j = 0;j < 6;j++)
        {
            int i = (int) (Math.random() * 10);
            Integer ii = new Integer(i);
            s += ii.toString();
        }
        return s;
    }

    public void phonebook_create(String phonenumber,String name,String mobile,String telephone,int groupid,String email) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("PhoneBookCreate " + DbAdapter.cite(phonenumber) + ", "
            // + DbAdapter.cite(name) + ", " + DbAdapter.cite(mobile) + ", " +
            // DbAdapter.cite(telephone) + ", " + groupid + ", " + DbAdapter.cite(Email));
            db.executeUpdate(" INSERT INTO SMSphonebook (phonenumber,name ,mobile,telephone,groupid,email)  VALUES (" + DbAdapter.cite(phonenumber) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(telephone) + "," + groupid + "," + DbAdapter.cite(Email) + ") ");
        } finally
        {
            db.close();
        }
    }

    public void mms_create(String id,byte abyte0[]) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into mms values(  " + DbAdapter.cite(id) + "," + DbAdapter.cite(abyte0) + ")");
        } finally
        {
            db.close();
        }
    }

    public void phonebook_edit(int id,String phonenumber,String name,String mobile,String telephone,int groupid,String email) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SMSphonebookEdit " + id + ", " + DbAdapter.cite(phonenumber) + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(mobile) + ",  " + DbAdapter.cite(telephone) + ", " + groupid + ", " + DbAdapter.cite(Email));
            System.out.println("SMSphonebookEdit " + id + ", " + DbAdapter.cite(phonenumber) + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(mobile) + ",  " + DbAdapter.cite(telephone) + ", " + groupid + ", " + DbAdapter.cite(Email));
        } finally
        {
            db.close();
        }
    }

    public void phonebook_delete(String id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from SMSphonebook where id =" + id);
        } finally
        {
            db.close();
        }
    }

    public void PhoneGroupcreate(String phonenumber,String name,String discript) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("PhoneGroupCreate " + DbAdapter.cite(phonenumber) + "," +
            // " " + DbAdapter.cite(name) + ", " + DbAdapter.cite(discript));
            db.executeUpdate(" INSERT INTO SMSgroup(phonenumber,name ,discript) VALUES (" + DbAdapter.cite(phonenumber) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(discript) + ") ");
        } finally
        {
            db.close();
        }
    }

    public void PhoneGroupedit(int id,String phonenumber,String name,String discript) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SMSphonegroupEdit " + id + ", " + DbAdapter.cite(phonenumber) + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(discript));
        } finally
        {
            db.close();
        }
    }

    public void user_edit(String PhoneNumber,String RealName,String NickName,String Email,int IDType,String IDNumber,int ad) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SmsUserEdit " + DbAdapter.cite(PhoneNumber) + ", " + DbAdapter.cite(RealName) + ", " + DbAdapter.cite(NickName) + ", " + DbAdapter.cite(Email) + ", " + IDType + ", " + DbAdapter.cite(IDNumber) + ", " + ad);
        } finally
        {
            db.close();
        }
    }

    public boolean exist(String s1) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT phonenumber FROM SMSuser   WHERE phonenumber like '" + s1 + "'");
            if(db.next())
            {
                flag = true;
            }
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String getpassword(String s1) throws SQLException
    {
        String s = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT password FROM SMSuser   WHERE phonenumber like '" + s1 + "'");
            if(db.next())
            {
                s = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return s;
    }

    public String GetPassword(String s1) throws SQLException
    {
        String s = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT password FROM Profile WHERE mobile like '" + s1 + "'");
            if(db.next())
            {
                s = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return s;
    }

    public boolean exist(String s1,String s2) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT phonenumber FROM SMSuser   WHERE phonenumber like '" + s1 + "' and password like '" + s2 + "'");
            if(db.next())
            {
                flag = true;
            }
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean isPassword(String s,String s1) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" SELECT member FROM Profile  WHERE mobile=" + DbAdapter.cite(s) + "AND password=" + DbAdapter.cite(s1));
            flag = db.next();
        } catch(Exception exception1)
        {
            throw new SQLException(exception1.toString());
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean changepwd(String s1,String s2,String s3) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT phonenumber FROM SMSuser   WHERE phonenumber like '" + s1 + "' and password like '" + s2 + "'");
            if(db.next())
            {
                flag = true;
            } else
            {
                return(false);
            }
            if(flag)
            {
                db.executeUpdate("update SMSuser set password ='" + s3 + "'   WHERE phonenumber like '" + s1 + "' ");
            }
        } finally
        {
            db.close();
        }
        return flag;
    }

    public void mobile_edit(String s1,String s2) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("MobileEdit " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2));
        } finally
        {
            db.close();
        }
    }

    public void SmsRecordCreate(String s1,String s2,String pass,int i1,String s3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SmsRecordCreate " + DbAdapter.cite(s1) + ", " + DbAdapter.cite(s2) + ", " + i1 + ", " + DbAdapter.cite(s3));
        } finally
        {
            db.close();
        }
    }

    public void SubscribeCreate(String s1,String pass,int i1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SubscribeCreate " + DbAdapter.cite(s1) + ", " + i1);
        } finally
        {
            db.close();
        }
    }

    public Sms(int i)
    {
        _nNode = i;
    }

    public Sms()
    {
    }

    public int getSubcriber(String s1) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subscribe FROM Subscribe   WHERE number like " + s1);
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

    public void deleteSubcribe(String s1,String password,int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("delete FROM Subscribe   WHERE number like " + s1 + " and subscribe= " + i);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
    }

    public int getSendSms(String s1) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Sms_record   WHERE subscribe like " + s1);
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

    public void SendSms() throws SQLException
    {

    }

    public Date getCreateTime() throws SQLException
    {
        Date date = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT create_time  FROM sms   WHERE node=" + _nNode);
            if(db.next())
            {
                date = db.getDate(1);
            }
        } finally
        {
            db.close();
        }
        return date;
    }

    public static Sms find(int i)
    {
        Sms Sms = (Sms) _cache.get(new Integer(i));
        if(Sms == null)
        {
            Sms = new Sms(i);
            _cache.put(new Integer(i),Sms);
        }
        return Sms;
    }

    public void getUserInfo(String phonenumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT realname,nickname,email,idtype,idnumber,ad  from SMSuser WHERE phonenumber like '" + phonenumber + "'");
            if(db.next())
            {
                RealName = db.getString(1);
                NickName = db.getString(2);
                Email = db.getString(3);
                IDType = db.getInt(4);
                IDNumber = db.getString(5);
                ad = db.getInt(6);
            }
        } finally
        {
            db.close();
        }
    }

    public String getPhoneNumber()
    {
        return PhoneNumber;
    }

    public String getRealName()
    {
        return RealName;
    }

    public String getNickName()
    {
        return NickName;
    }

    public String getEmail()
    {
        return Email;
    }

    public String getIDNumber()
    {
        return IDNumber;
    }

    public int getIDType()
    {
        return IDType;
    }

    public int getAd()
    {
        return ad;
    }

    public Sms(String phonenumber) throws SQLException
    {

        getUserInfo(phonenumber);
    }

    private int _nNode;
    private String PhoneNumber = "";
    private String RealName = "";
    private String NickName = "";
    private String Email = "";
    private int IDType = 0;
    private String IDNumber = "";
    private int ad = 0;

    private static Cache _cache = new Cache(100);

}
