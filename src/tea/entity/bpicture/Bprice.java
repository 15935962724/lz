package tea.entity.bpicture;


import java.math.*;
import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class Bprice extends  Entity
{

    private String member;
    private String community;
    private BigDecimal price;//剩余资金

    private  boolean exists;




    public Bprice(String member)throws SQLException
    {
        this.member=member;
        load();
    }

    public static Bprice find(String member)throws SQLException
    {
        return new Bprice(member);
    }

    public void load()throws SQLException
    {
        DbAdapter db = new  DbAdapter();
        try
        {
            db.executeQuery("Select member,community,price from Bprice where member= "+db.cite(member));
            if(db.next())
            {
                int j=1;
                member=db.getString(j++);
                community=db.getString(j++);
                price=db.getBigDecimal(j++,2);
                exists=true;
            }
            else
            {
                exists=false;
            }
        }
        finally
        {
            db.close();
        }
    }

    public void set(String member,String community,BigDecimal price) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select member from Bprice where community="+db.cite(community)+" and member=" + db.cite(member));
            if(db.next())
            {
                db.executeUpdate("Update Bprice set  price="+price+" where member="+db.cite(member));
            } else
            {
                db.executeUpdate("Insert into Bprice (member,community,price) values("+db.cite(member)+","+db.cite(community)+","+price+")");
            }
        } finally
        {
            db.close();
        }
    }


    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public boolean isExists()
    {
        return exists;
    }
}
