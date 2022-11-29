import java.io.PrintStream;
import java.sql.SQLException;
import javax.jws.WebService;
import tea.db.DbAdapter;

@WebService
public class WestracMember
{
  public String getWmember(String mobile)
    throws SQLException
  {
    StringBuffer xml = new StringBuffer("|");
    if ((mobile != null) && (mobile.length() > 0))
    {
      DbAdapter db = new DbAdapter();
      try
      {
        db.executeQuery(new StringBuilder().append(" select p.code,p.mobile,p.member,pl.firstname,pl.province  from Profile p,ProfileLayer pl  where p.member=pl.member and p.mobile= ").append(DbAdapter.cite(mobile)).toString());
        if (db.next())
        {
          xml.append("3").append("|");
          xml.append(db.getString(1)).append("|");
          xml.append(db.getString(2)).append("|");
          xml.append(db.getString(3)).append("|");
          xml.append(db.getString(4)).append("|");
          if ((db.getString(5) != null) && (db.getString(5).length() > 0))
          {
            xml.append(toStringCity1(Integer.parseInt(db.getString(5)))).append("/");
            xml.append(toStringCity2(Integer.parseInt(db.getString(5)))).append("|");
          }
          else {
            xml.append("").append("|");
          }
        }
        else {
          xml.append("2").append("|");
        }
      }
      catch (Exception e) {
        xml.append("4").append("|");
      }
      finally
      {
        db.close();
      }
    }
    else {
      xml.append("1").append("|");
    }

    return xml.toString();
  }

  public String toStringCity1(int card)
    throws SQLException
  {
    StringBuilder sb = new StringBuilder();
    try
    {
      if (card > 100)
      {
        String str = String.valueOf(card);

        DbAdapter db = new DbAdapter();
        try
        {
          db.executeQuery(new StringBuilder().append("SELECT address FROM Card where card= ").append(Integer.parseInt(str.substring(0, 2))).toString());
          if (db.next())
          {
            sb.append(db.getString(1));
          }
        }
        finally {
          db.close();
        }
      }

    }
    catch (SQLException ex)
    {
      ex.printStackTrace();
    }

    return sb.toString();
  }

  public String toStringCity2(int card) throws SQLException {
    StringBuilder sb = new StringBuilder();
    try
    {
      if (card > 100)
      {
        String str = String.valueOf(card);

        DbAdapter db = new DbAdapter();
        try
        {
          db.executeQuery(new StringBuilder().append("SELECT address FROM Card where card= ").append(Integer.parseInt(str)).toString());
          if (db.next())
          {
            sb.append(db.getString(1));
          }
        }
        finally {
          db.close();
        }
      }

    }
    catch (SQLException ex)
    {
      ex.printStackTrace();
    }

    return sb.toString();
  }

  public static void main(String[] ager)
  {
    try
    {
      WestracMember wobj = new WestracMember();
      System.out.println(wobj.getWmember("13696569859"));
    }
    catch (Exception e) {
      e.getStackTrace();
    }
  }
}