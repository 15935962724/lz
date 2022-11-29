package tea.entity.eon;

import java.io.*;
import java.math.*;
import java.sql.SQLException;
import java.util.*;
import sun.net.*;
import sun.net.ftp.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.site.CommunityOption;

public class EonTeleset extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String member;
    private boolean secret; //true:将号码显示给对方
    private BigDecimal balance;
    private boolean automessage;
    private String message[] = new String[10];
    private boolean exists;
    public EonTeleset(String community, String member) throws SQLException
    {
        this.community = community;
        this.member = member;
        load();
    }

    public static EonTeleset find(String community, String member) throws SQLException
    {
        EonTeleset obj = (EonTeleset) _cache.get(community + ":" + member);
        if (obj == null)
        {
            obj = new EonTeleset(community, member);
            _cache.put(community + ":" + member, obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT secret,balance,automessage,message0,message1,message2,message3,message4,message5,message6,message7,message8,message9 FROM EonTeleset WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            if (db.next())
            {
                secret = db.getInt(1) != 0;
                balance = db.getBigDecimal(2, 2);
                automessage = db.getInt(3) != 0;
                for (int i = 0; i < 10; i++)
                {
                    message[i] = db.getString(4 + i);
                }
                exists = true;
            } else
            {
                secret = true;
                CommunityOption co = CommunityOption.find(community);
                balance = new BigDecimal(co.getInt("eonbalance"));
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(String community, String member, boolean secret, BigDecimal balance, boolean automessage, String message[]) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO EonTeleset(community, member, secret, balance,automessage,message0,message1,message2,message3,message4,message5,message6,message7,message8,message9) VALUES (" +
                             DbAdapter.cite(community) + ", " + DbAdapter.cite(member) + ", " + DbAdapter.cite(secret) + "," + balance + "," + DbAdapter.cite(automessage) + "," + DbAdapter.cite(message[0]) + "," + DbAdapter.cite(message[1]) + "," + DbAdapter.cite(message[2]) + "," + DbAdapter.cite(message[3]) + "," + DbAdapter.cite(message[4]) + "," + DbAdapter.cite(message[5]) + "," + DbAdapter.cite(message[6]) + "," + DbAdapter.cite(message[7]) + "," + DbAdapter.cite(message[8]) + "," + DbAdapter.cite(message[9]) + ")");
        } finally
        {
            db.close();
        }
    }


    public void set(boolean secret, boolean automessage) throws SQLException, IOException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE EonTeleset SET secret=" + DbAdapter.cite(secret) + ",automessage=" + DbAdapter.cite(automessage) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        if (j < 1)
        {
            create(community, member, secret, balance, automessage, message);
        }
        this.secret = secret;
        this.automessage = automessage;
        this.exists = true;
    }

    public void setMessage(int i, String name) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE EonTeleset SET message" + i + "=" + DbAdapter.cite(name) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        message[i] = name;
        if (j < 1)
        {
            create(community, member, secret, balance, automessage, message);
        }
    }

    public void setMessage(int i, String name, byte by[]) throws SQLException, IOException
    {
        setMessage(i, name);
        CommunityOption co = CommunityOption.find(community);
        String eonip = co.get("eonip");
        String eonuser = co.get("eonuser");
        String eonpwd = co.get("eonpwd");
        String dir = "" + Profile.find(member).getProfile();
        //
        FtpClient ftp = new FtpClient(eonip);
        ftp.login(eonuser, eonpwd);
        ftp.binary();
        try
        {
            ftp.sendServer("MKD " + dir + "\r\n");
            ftp.closeServer();
            ftp = new FtpClient(eonip);
            ftp.login(eonuser, eonpwd);
            ftp.binary();
        } catch (IOException ex)
        {
            //ex.printStackTrace();
        }
        if (by != null)
        {
            TelnetOutputStream tos = ftp.put("/" + dir + "/" + i + ".vox");
            tos.write(by);
            tos.close();
        } else
        {
            ftp.sendServer("/" + dir + "/" + i + ".vox\r\n");
        }
        ftp.closeServer();
    }

    public void setBalance(BigDecimal balance) throws SQLException, IOException
    {
        int j = 0;
        balance = this.balance.add(balance);
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE EonTeleset SET balance=" + balance + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        this.balance = balance;
        if (j < 1)
        {
            create(community, member, secret, balance, automessage, message);
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM EonTeleset WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + member);
    }

    public boolean isSecret()
    {
        return secret;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getBalance()
    {
        return balance;
    }

    public String[] getMessage()
    {
        try
        {
            CommunityOption co = CommunityOption.find(community);
            String eonip = co.get("eonip");
            String eonuser = co.get("eonuser");
            String eonpwd = co.get("eonpwd");
            String dir = "" + Profile.find(member).getProfile();
            //
            FtpClient ftp = new FtpClient(eonip);
            ftp.login(eonuser, eonpwd);
            ftp.binary();
            ftp.cd(dir);
            TelnetInputStream tis = ftp.list();
            byte bt[] = new byte[tis.available()];
            tis.read(bt);
            tis.close();
            ftp.closeServer();
            //
            String str = new String(bt);
            String ss[] = str.split("\r\n");
            for (int i = 0; i < ss.length; i++)
            {
                ss[i] = ss[i].substring(ss[i].lastIndexOf(" ") + 1);
            }
            for (int i = 2; i < ss.length; i++)
            {
                int j = Integer.parseInt(ss[i].substring(0, 1));
                if (message[j] == null)
                {
                    setMessage(j, ss[i]);
                }
            }
        } catch (FileNotFoundException fnfe)
        {} catch (Exception ex)
        {
            ex.printStackTrace();
        }
        return message;
    }

    public String getBalanceToString()
    {
        return df.format(balance);
    }

    public boolean isAutoMessage()
    {
        return automessage;
    }

}


class MyFtpClient extends FtpClient
{

    public MyFtpClient()
    {
    }

    public void open() throws IOException
    {
        openServer("eon.redcome.com");
        login("ednadmin", "redcome");
        binary();
    }

    public void mkd(String name)
    {
        try
        {
            open();
            sendServer("MKD " + name + "\r\n");
            closeServer();
        } catch (IOException ex)
        {
            //ex.printStackTrace();
        }
    }

    public void dele(String file) throws IOException
    {
        open();
        sendServer("DELE " + file + "\r\n");
        closeServer();
    }

    public void write(String file, byte by[]) throws IOException
    {
        open();
        TelnetOutputStream tos = put(file);
        tos.write(by);
        tos.close();
        closeServer();
    }

    public String[] list(String dir) throws IOException
    {
        open();
        cd(dir);
        TelnetInputStream tis = list();
        byte bt[] = new byte[tis.available()];
        tis.read(bt);
        tis.close();
        String str = new String(bt);
        String ss[] = str.split("\r\n");
        for (int i = 0; i < ss.length; i++)
        {
            ss[i] = ss[i].substring(ss[i].lastIndexOf(" ") + 1);
        }
        closeServer();
        return ss;
    }

    public int issueCommand(String cmd) throws IOException
    {
        return super.issueCommand(cmd);
    }

    public void issueCommandCheck(String cmd) throws IOException
    {
        super.issueCommandCheck(cmd);
    }
}
