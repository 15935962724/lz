package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;

public class Ticket extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
    private String name;
    private String logo;
    private int language;

    public Ticket(int node,int language)
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    private void loadBasic()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT name,logo FROM Ticket   WHERE node=" + node + " AND language=" + this.language);
            if(db.next())
            {
                this.name = db.getVarchar(language,language,1);
                this.logo = db.getString(2);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Ticket WHERE node=" + this.node + " AND language=" + this.language);
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static Ticket find(int node,int language)
    {
        Ticket ticket = (Ticket) _cache.get(node + ":" + language);
        if(ticket == null)
        {
            ticket = new Ticket(node,language);
            _cache.put(node + ":" + language,ticket);
        }
        return ticket;
        // return new Ticket(node, language);
    }

    public void set()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Ticket SET name=" + DbAdapter.cite(this.name) + ",logo=" + DbAdapter.cite(this.logo) + " WHERE node=" + node + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Ticket(node,name,logo,language)VALUES (" + node + "," + DbAdapter.cite(this.name) + "," + DbAdapter.cite(this.logo) + "," + (this.language) + ")");
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public int getNode()
    {
        return node;
    }

    public String getName()
    {
        return name;
    }

    public String getLogo()
    {
        return logo;
    }

    public int getLanguage()
    {
        return language;
    }

    public void setNode(int node)
    {
        this.node = node;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setLogo(String logo)
    {
        this.logo = (logo);
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }
}
