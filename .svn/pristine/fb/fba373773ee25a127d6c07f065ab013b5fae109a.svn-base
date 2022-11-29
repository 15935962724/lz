package tea.entity.site;

import java.net.*;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class License extends Entity
{ // public static final String ROOTSITE = "www.trendscape.com";
    public static final int WEBO_ENABLELEAGUE = 2;
    public static final int WEBO_AUTHORIZED = 32768;
    private static License _instance;
    private String _strLicense;
    private String _strWebSite; // 站点地图的域名
    private String _strWebName;
    private String _strWebMaster;
    private String _strWebSupport;
    private String _strSmtpServer;
    private int _nWebOptions;
    private int _nWebLanguages;
    private String _strSerialNumber;
    private Date _registrationDate;
    private Date _expirationDate;
    private int _nNumberOfCommunity;
    private String listenertype; //启动定时器开关
    public License()
    {
        _strLicense = null;
        _strWebSite = null;
        _strWebName = null;
        _strWebMaster = null;
        _strWebSupport = null;
        _strSmtpServer = null;
        _nWebOptions = 0;
        _nWebLanguages = 0;
        _strSerialNumber = null;
        _registrationDate = null;
        _expirationDate = null;
        _nNumberOfCommunity = 0;
    }

    public void set(String license,String webSite,String webName,String webMaster,String webSupport,String smtpServer,int webOptions,int webLanguages,String ltype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(0,"UPDATE License SET license=" + DbAdapter.cite(license) + ",website=" + DbAdapter.cite(webSite) + ", webname=" + DbAdapter.cite(webName) + ",webmaster=" + DbAdapter.cite(webMaster) + ", websupport=" + DbAdapter.cite(webSupport) + ",smtpserver=" + DbAdapter.cite(smtpServer) + ",options=" + webOptions + "," + " languages=" + webLanguages + " ,listenertype= " + DbAdapter.cite(ltype));
            if(j < 1)
            {
                db.executeUpdate(0,"INSERT INTO License(license,website,webname,webmaster,websupport,smtpserver,options,languages,listenertype)VALUES (" + DbAdapter.cite(license) + "," + DbAdapter.cite(webSite) + "," + DbAdapter.cite(webName) + "," + DbAdapter.cite(webMaster) + "," + DbAdapter.cite(webSupport) + "," + DbAdapter.cite(smtpServer) + "," + webOptions + "," + webLanguages + "," + DbAdapter.cite(ltype) + " )");
            }
        } finally
        {
            db.close();
        }
        _strLicense = license;
        _strWebSite = webSite;
        _strWebName = webName;
        _strWebMaster = webMaster;
        _strWebSupport = webSupport;
        _strSmtpServer = smtpServer;
        _nWebOptions = webOptions;
        _nWebLanguages = webLanguages;
        listenertype = ltype;
    }

    public void set(String serialnumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE License SET serialnumber=" + DbAdapter.cite(serialnumber));
        } finally
        {
            db.close();
        }
        _strSerialNumber = serialnumber;
    }


    public String getWebSupport() throws SQLException
    {
        load();
        return _strWebSupport;
    }

    public boolean isWebMaster(String s) throws SQLException
    {
        return s.equals(getWebMaster());
    }

    public String getWebSite() throws SQLException
    {
        load();
        return _strWebSite;
    }

    private void load() throws SQLException
    {
        if(_strWebSite == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT license,website,webname,webmaster,websupport,smtpserver,options,languages,serialnumber," +
                                "registrationdate,expirationdate,numberofcommunity,listenertype  FROM License ");
                if(db.next())
                {
                    _strLicense = db.getString(1);
                    _strWebSite = db.getString(2);
                    _strWebName = db.getString(3);
                    _strWebMaster = db.getString(4);
                    _strWebSupport = db.getString(5);
                    _strSmtpServer = db.getString(6);
                    _nWebOptions = db.getInt(7);
                    _nWebLanguages = db.getInt(8);
                    _strSerialNumber = db.getString(9);
                    _registrationDate = db.getDate(10);
                    _expirationDate = db.getDate(11);
                    _nNumberOfCommunity = db.getInt(12);
                    listenertype = db.getString(13);
                }
                if(_strWebSite == null || _strWebSite.length() < 1)
                {
                    _strWebSite = "center.redcome.com";
                }
            } finally
            {
                db.close();
            }
        }
    }

    public int getWebOptions() throws SQLException
    {
        load();
        return _nWebOptions;
    }

    public void clear() throws SQLException
    {
        long l = System.currentTimeMillis();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Log  WHERE type=" + 1 + " AND time<=" + DbAdapter.cite(new Date(l - 0x240c8400L)));
            db.executeUpdate("DELETE FROM Listed  WHERE stoptime<" + db.citeCurTime());
            db.executeUpdate("DELETE FROM Meeting  WHERE time<" + DbAdapter.cite(new Date(l - 0x493e0L)));
        } finally
        {
            db.close();
        }
    }

    public String getSmtpServer() throws SQLException
    {
        load();
        return _strSmtpServer;
    }

    public int getWebLanguages() throws SQLException
    {
        load();
        return _nWebLanguages;
    }

    public String getSerialNumber() throws SQLException
    {
        load();
        return _strSerialNumber;
    }

    public Date getRegistrationDate() throws SQLException
    {
        load();
        return _registrationDate;
    }

    public Date getExpirationDate() throws SQLException
    {
        load();
        return _expirationDate;
    }

    public int getNumberOfCommunity() throws SQLException
    {
        load();
        return _nNumberOfCommunity;
    }

    public static License getInstance()
    {
        if(_instance == null)
        {
            _instance = new License();
        }
        return _instance;
    }

    public String getWebName() throws SQLException
    {
        load();
        return _strWebName;
    }

    public String getWebMaster() throws SQLException
    {
        load();
        return _strWebMaster;
    }

    public String getListenertype() throws SQLException
    {
        load();
        return listenertype;
    }

    public String getLicense() throws SQLException
    {
        load();
        return _strLicense;
    }
}
