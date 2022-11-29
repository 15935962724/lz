package tea.entity.node;

import java.sql.*;
import tea.db.*;
import tea.entity.*;


public class Account extends Entity
{
    public String account;
    public int type;
    public int currency;
    public float balance;
    public float yearbenefit;
    public int term;
    public java.util.Date maturity;
    public int states;
    private boolean exists;
    public Account(String account) throws SQLException
    {
        this.account = account;
        loadBasic();
    }

    public static String create(String account, int type, int currency, float balance, float yearbenefit, int term, java.util.Date maturity, int states) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Account (account,type,currency,balance,yearbenefit,term,maturity,states)VALUES(" + DbAdapter.cite(account) + "," + type + "," + currency + "," + balance + "," + yearbenefit + "," + term + "," + DbAdapter.cite(maturity) + "," + states + ")");
        } finally
        {
            db.close();
        }
        return null;
    }

    public boolean exists()
    {
        return exists;
    }


    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Account (account,type,currency,balance,yearbenefit,term,maturity,states)VALUES(" + DbAdapter.cite(account) + "," + type + "," + currency + "," + balance + "," + yearbenefit + "," + term + "," + maturity + "," + states + ")");
        } finally
        {
            db.close();
        }
        this.account = account;
        this.type = type;
        this.currency = currency;
        this.balance = balance;
        this.yearbenefit = yearbenefit;
        this.term = term;
        this.maturity = maturity;
        this.states = states;
    }

    public String getAccount()
    {
        return account;
    }

    public void setAccount(String account)
    {
        this.account = account;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type,currency,balance,yearbenefit,term,maturity,states FROM Account WHERE account=" + DbAdapter.cite(account) + "");
            if (db.next())
            {
                type = db.getInt(1);
                currency = db.getInt(2);
                balance = db.getInt(3);
                yearbenefit = db.getInt(4);
                term = db.getInt(5);
                maturity = db.getDate(6);
                states = db.getInt(7);
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

    public int getType()
    {
        return type;
    }


    public int getCurrency()
    {
        return currency;
    }


    public float getBalance()
    {
        return balance;
    }

    public float getYearbenefit()
    {
        return yearbenefit;
    }


    public int getTerm()
    {
        return term;
    }


    public java.util.Date getMaturity()
    {
        return maturity;
    }

    public String getMaturityToString()
    {
        if (maturity == null)
        {
            return "";
        }
        return sdf.format(maturity);
    }

    public int getStates()
    {
        return states;
    }

}
