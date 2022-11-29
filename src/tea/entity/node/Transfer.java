package tea.entity.node;

import java.util.Date;

import tea.db.DbAdapter;


public class Transfer
{
    public String account;
    public String chamberlain;
    public String acceptaddress;
    public String acceptbank;
    public String acceptaccount;
    public float money;
    public String capital;
    public String remark;
    private boolean load;
    private boolean exists;
    private String poundage;
    private String state;
    private String type;
    private String purpose;//purpose,type,state,poundage

    private Date date; /*
            public String create(String account, String acceptchamberlain, String acceptaddress, String acceptbank, String acceptaccount, Float money, String capital, String remark) throws CreateException
            {
        this.account = account;
        this.acceptchamberlain = acceptchamberlain;
        this.acceptaddress = acceptaddress;
        this.acceptbank = acceptbank;
        this.acceptaccount = acceptaccount;
        this.money = money;
        this.capital = capital;
        this.remark = remark;
        return null;
            }*/
    public void create()
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Transfer (account,chamberlain,acceptaddress,acceptbank,acceptaccount,money,capital,remark,[date],purpose,type,state,poundage)VALUES(" + DbAdapter.cite(account) + "," + DbAdapter.cite(chamberlain) + "," + DbAdapter.cite(acceptaddress) + "," + DbAdapter.cite(acceptbank) + "," + DbAdapter.cite(acceptaccount) + "," + money + "," + DbAdapter.cite(capital) + "," + DbAdapter.cite(remark) +","+DbAdapter.cite(date) +","+DbAdapter.cite(purpose)+","+DbAdapter.cite(type)+","+DbAdapter.cite(state)+","+(poundage)+")");
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }

    }

    public boolean exists()
    {
        return exists;
    }

    public String getAccount()
    {
        return account;
    }

    public void setAccount(String account)
    {
        this.account = account;
    }

    public String getChamberlain()
    {
        return chamberlain;
    }

    public void setChamberlain(String chamberlain)
    {
        this.chamberlain = chamberlain;
    }

    public String getAcceptaddress()
    {
        return acceptaddress;
    }

    public void setAcceptaddress(String acceptaddress)
    {
        this.acceptaddress = acceptaddress;
    }

    public String getAcceptbank()
    {
        return acceptbank;
    }

    public void setAcceptbank(String acceptbank)
    {
        this.acceptbank = acceptbank;
    }

    public String getAcceptaccount()
    {
        return acceptaccount;
    }

    public void setAcceptaccount(String acceptaccount)
    {
        this.acceptaccount = acceptaccount;
    }

    public float getMoney()
    {
        return money;
    }

    public void setMoney(float money)
    {
        this.money = money;
    }

    private void loadBasic()
    {
        if (!load)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT chamberlain,acceptaddress,acceptbank,acceptaccount,money,capital,remark,purpose,type,state,poundage FROM Transfer WHERE account='" + account + "'");
                if (db.next())
                {
                    chamberlain = db.getString(1);
                    acceptaddress = db.getVarchar(1, 1, 2);
                    acceptbank = db.getVarchar(1, 1, 3);
                    acceptaccount = db.getVarchar(1, 1, 4);
                    money = db.getFloat(5);
                    capital = db.getVarchar(1, 1, 6);
                    remark = db.getVarchar(1, 1, 7);
                    exists = true;
                } else
                    exists = false;
            } catch (Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            load = true;
        }
    }

    public String getCapital()
    {
        return capital;
    }

    public void setCapital(String capital)
    {
        this.capital = capital;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getPoundage()
    {
        return poundage;
    }

    public String getState()
    {
        return state;
    }

    public String getType()
    {
        return type;
    }

    public String getPurpose()
    {
        return purpose;
    }

    public Date getDate()
    {
        return date;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public void setPoundage(String poundage)
    {
        this.poundage = poundage;
    }

    public void setState(String state)
    {
        this.state = state;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public void setPurpose(String purpose)
    {
        this.purpose = purpose;
    }

    public void setDate(Date date)
    {
        this.date = date;
    }
}
