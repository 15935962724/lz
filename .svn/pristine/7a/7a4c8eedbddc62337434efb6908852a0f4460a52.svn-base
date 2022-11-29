package tea.entity.member;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
//购物象网,申请印象卡
public class RequestCard extends Entity
{
  public static Cache _cache = new Cache(100);
  public static final String STATUS_TYPE[] =
          {"--------------", "批准", "拒绝"};
  private int requestcard;
  private String community;
  private String member; //选填,
  private String name;
  private int city;
  private String address;
  private String postcode;
  private String email;
  private String telephone;
  private int status;
  private Date time;
  private boolean exists;

  public RequestCard(int requestcard) throws SQLException
  {
    this.requestcard = requestcard;
    load();
  }

  private void load() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT community,member,name,city,address,postcode,email,telephone,status,time FROM requestcard WHERE requestcard=" + requestcard);
      if (db.next())
      {
        community = db.getString(1);
        member = db.getString(2);
        name = db.getString(3);
        city = db.getInt(4);
        address = db.getString(5);
        postcode = db.getString(6);
        email = db.getString(7);
        telephone = db.getString(8);
        status = db.getInt(9);
        time = db.getDate(10);
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

  public static RequestCard find(int requestcard) throws SQLException
  {
    RequestCard obj = (RequestCard) _cache.get(new Integer(requestcard));
    if (obj == null)
    {
      obj = new RequestCard(requestcard);
      _cache.put(new Integer(requestcard), obj);
    }
    return obj;
  }

  public static void create(String community, String member, String name, int city, String address, String postcode, String email, String telephone) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("INSERT INTO requestcard(community,member,name,city,address,postcode,email,telephone,status,time)VALUES(" +
                       DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + city + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(postcode) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(telephone) + ",0," + db.citeCurTime() + ")");
	} finally
    {
      db.close();
    }
  }

  public static java.util.Enumeration find(String community, String sql, int pos, int pagesize) throws SQLException
  {
    Vector v = new Vector();
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeQuery("SELECT requestcard FROM requestcard WHERE community=" + DbAdapter.cite(community) + sql);
      for (int l = 0; l < pos + pagesize && db.next(); l++)
      {
        if (l >= pos)
        {
          v.addElement(new Integer(db.getInt(1)));
        }
      }
    } catch (Exception exception1)
    {
      throw new SQLException(exception1.toString());
    } finally
    {
      db.close();
    }
    return v.elements();
  }

  public static int count(String community, String sql) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      return db.getInt("SELECT COUNT(*) FROM requestcard WHERE community=" + DbAdapter.cite(community) + sql);
	} finally
    {
      db.close();
    }
  }

  public void set(String name) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("UPDATE requestcard SET name=" + DbAdapter.cite(name) + " WHERE requestcard=" + requestcard);
	} finally
    {
      db.close();
    }
  }


  public void delete() throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("DELETE FROM requestcard WHERE requestcard=" + requestcard);
    } catch (Exception exception1)
    {
      throw new SQLException(exception1.toString());
    } finally
    {
      db.close();
    }
  }


  public String getCommunity()
  {
    return community;
  }

  public boolean isExists()
  {
    return exists;
  }

  public int getStatus()
  {
    return status;
  }

  public String getTelephone()
  {
    return telephone;
  }

  public Date getTime()
  {
    return time;
  }

  public int getRequestcard()
  {
    return requestcard;
  }

  public String getPostcode()
  {
    return postcode;
  }

  public String getName()
  {
    return name;
  }

  public String getEmail()
  {
    return email;
  }

  public int getCity()
  {
    return city;
  }

  public String getAddress()
  {
    return address;
  }

  public String getMember()
  {
    return member;
  }

  public void setStatus(int status) throws SQLException
  {
    DbAdapter db = new DbAdapter();
    try
    {
      db.executeUpdate("UPDATE requestcard SET status=" + status + " WHERE requestcard=" + requestcard);
    } catch (Exception exception1)
    {
      throw new SQLException(exception1.toString());
    } finally
    {
      db.close();
    }
    this.status = status;
  }
}
