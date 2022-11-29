package tea.entity.node;

import java.util.Date;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Bargaining extends tea.entity.Entity
{

    private String account;
    private Date time;
    private float adopt;
    private float memory;
    private float balance;
    private String explains;

    public Bargaining(String account)
    {
        this.account = account;
        // load();
    }

    public static void create(String account,Date time,float adopt,float memory,float balance,String explains) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Bargaining(account,time,adopt,memory,balance,explains) values(" + DbAdapter.cite(account) + "," + DbAdapter.cite(time) + "," + adopt + "," + memory + "," + balance + "," + DbAdapter.cite(explains) + ")");
        } finally
        {
            db.close();
        }
    }

    public String getAccount()
    {
        return account;
    }

    public Date getDate()
    {
        return time;
    }

    public float getAdopt()
    {
        return adopt;
    }

    public float getMemory()
    {
        return memory;
    }

    public float getBalance()
    {
        return balance;
    }

    public String getExplain()
    {
        return explains;
    }

}
