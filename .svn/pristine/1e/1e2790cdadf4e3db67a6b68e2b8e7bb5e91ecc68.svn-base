package tea.entity.csvclub;


import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class Csvdogdvuser extends Entity
{
    private int id ;
    private String username;
    private String userpassword;
    private String useremail;
    private int usersex;
    private String userquesion;
    private String useranswer;
    private boolean isExist;

    public Csvdogdvuser(String member) throws SQLException
    {
        this.username = member;
        load();
    }

    public static Csvdogdvuser find (String member)throws SQLException
    {
        return new Csvdogdvuser(member);
    }

    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select username,userpassword,useremail,usersex,userquesion,useranswer,id from Dv_User where username = "+DbAdapter.cite(username));
            if(db.next())
            {
                username = db.getString(1);
                userpassword = db.getString(2);
                useremail = db.getString(3);
                usersex = db.getInt(4);
                userquesion = db.getString(5);
                useranswer = db.getString(6);
                id = db.getInt(7);
                isExist = true;
            }
            else
            {
                isExist = false;
            }
        }
        finally
        {
            db.close();
        }
    }

    public static void create(String username,String userpassword,String useremail,int usersex,String userquesion,String useranswer)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Dv_User (username,userpassword,useremail,usersex,userquesion,useranswer) values ("+DbAdapter.cite(username)+" ,"+DbAdapter.cite(userpassword)+" ,"+DbAdapter.cite(useremail)+" ,"+usersex+","+DbAdapter.cite(userquesion)+" ,"+DbAdapter.cite(useranswer)+")");
        }
        finally
        {
        db.close();
        }
    }


    public static void updatepassword(String username,String password ) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Dv_user set password = "+DbAdapter.cite(password)+ " where username = "+DbAdapter.cite(username));
        }
        finally
        {
            db.close();
        }
    }

    public String getUseranswer()
    {
        return useranswer;
    }

    public String getUseremail()
    {
        return useremail;
    }

    public String getUsername()
    {
        return username;
    }

    public String getUserpassword()
    {
        return userpassword;
    }

    public String getUserquesion()
    {
        return userquesion;
    }

    public int getUsersex()
    {
        return usersex;
    }

    public boolean isIsExist()
    {
        return isExist;
    }


}
