package tea.entity.node;

import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class SmsService extends Entity
{
    public boolean service_edit(String service,int listing,int fee,String beizu) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("SMSServiceEdit " + DbAdapter.cite(service) + ", " + listing + ", " + fee + ", " + DbAdapter.cite(beizu));
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean srv_create(int node,String name,String orderyd,String orderlt,String codeyd,String codelt,int orderydmanul,int orderltmanul,String manager,float Fee) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSservice (node,name,orderyd,orderlt,codeyd,codelt,orderydmanul,orderltmanul,manager,fee)VALUES (" + node + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(orderyd) + ", " + DbAdapter.cite(orderlt) + ", " + DbAdapter.cite(codeyd) + ", " + DbAdapter.cite(codelt) + ", " + orderydmanul + ", " + orderltmanul + ", " + DbAdapter.cite(manager) + ", " + Fee + ")");
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean srv_edit(int id,int node,String name,String orderyd,String orderlt,String codeyd,String codelt,int orderydmanul,int orderltmanul,String manager,float Fee) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE SMSservice SET node=" + node + ",name=" + DbAdapter.cite(name) + ",orderyd=" + DbAdapter.cite(orderyd) + ",orderlt=" + DbAdapter.cite(orderlt) + ",codeyd=" + DbAdapter.cite(codeyd) + ",codelt=" + DbAdapter.cite(codelt) + ",orderydmanul=" + orderydmanul + ",orderltmanul=" + orderltmanul + ",manager=" + DbAdapter.cite(manager) + ",fee=" + Fee + " WHERE id=" + id);
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean subscribe_edit(String service[],String phonenumber,String paynumber) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            for(int i = 0;i < service.length;i++)
            {
                db.executeUpdate("INSERT INTO SMSsubsribe (phonenumber, payphone,service)VALUES(" + DbAdapter.cite(phonenumber) + ", " + DbAdapter.cite(paynumber) + "," + DbAdapter.cite(service[i]) + ")");
            }
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean subscribe_edit(int service,String phonenumber,String paynumber) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO SMSsubsribe (phonenumber, payphone,service)VALUES(" + DbAdapter.cite(phonenumber) + ", " + DbAdapter.cite(paynumber) + "," + (service) + ")");
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean subscribe_delete(int id) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from SMSsubsribe where id=" + id);
            flag = true;
        } catch(Exception exception)
        {
            System.out.print(exception);
            flag = false;
        } finally
        {
            db.close();
        }
        return flag;
    }

    public void getServiceInfo(int listing) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT   service,fee,beizu  from SMSservice WHERE listing= " + listing);
            if(db.next())
            {
                service = db.getString(1);
                fee = db.getInt(2);
                beizu = db.getString(3);
            }
        } finally
        {
            db.close();
        }
    }

    public String getService(int listing) throws SQLException
    {
        getServiceInfo(listing);
        return service;
    }

    public String getbeizu(int listing) throws SQLException
    {
        getServiceInfo(listing);
        return beizu;
    }

    public int getFee(int listing) throws SQLException
    {
        getServiceInfo(listing);
        return fee;
    }

    public void getServiceInfo(String service) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT   listing,fee,beizu  from SMSservice WHERE service like '" + service + "'");
            if(db.next())
            {
                listing = db.getInt(1);
                fee = db.getInt(2);
                beizu = db.getString(3);
            }
        } finally
        {
            db.close();
        }
    }

    public int getListing(String service) throws SQLException
    {
        getServiceInfo(service);
        return listing;
    }

    public String getbeizu(String service) throws SQLException
    {
        getServiceInfo(service);
        return beizu;
    }

    public int getFee(String service) throws SQLException
    {
        getServiceInfo(service);
        return fee;
    }

    public SmsService()
    {
    }

    private int listing;
    private String service;
    private int fee;
    private String beizu;
}
