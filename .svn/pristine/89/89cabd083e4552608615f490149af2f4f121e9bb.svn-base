package tea.entity.util;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class Postcode
{
    private String postcode;
    private String province;
    private String region;
    private String telecode;
    private boolean exists;

    public Postcode(String postcode) throws SQLException
    {
        this.postcode = postcode;
        load();
    }

    public Postcode(String postcode,String province,String region,String telecode) throws SQLException
    {
        this.postcode = postcode;
        this.province = province;
        this.region = region;
        this.telecode = telecode;
        this.exists = true;
    }

    public static Postcode find(String postcode) throws SQLException
    {
        return new Postcode(postcode);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT province,region,telecode FROM postcode WHERE postcode=" + DbAdapter.cite(postcode));
            if(db.next())
            {
                province = db.getString(1);
                region = db.getString(2);
                telecode = db.getString(3);
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

    public static void create(String postcode,String province,String region,String telecode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO postcode(postcode,province,region,telecode)VALUES(" + DbAdapter.cite(postcode) + "," + DbAdapter.cite(province) + "," + DbAdapter.cite(region) + "," + DbAdapter.cite(telecode) + ")");
        } finally
        {
            db.close();
        }
    }


    public static void move() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            Enumeration e = find("",0,Integer.MAX_VALUE);
            while(e.hasMoreElements())
            {
                Postcode obj = (Postcode) e.nextElement();
                db.executeUpdate("INSERT INTO postcode(postcode,province,region,telecode)VALUES(" +
                                 DbAdapter.cite(obj.getPostcode()) + "," + DbAdapter.cite(obj.getProvince()) + "," + DbAdapter.cite(obj.getRegion()) + "," + DbAdapter.cite(obj.getTelecode()) + ")");
                System.out.println(obj.getPostcode());
            }
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT postcode,province,region,telecode FROM postcode WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                String postcode = db.getString(1);
                String province = db.getString(2);
                String region = db.getString(3);
                String telecode = db.getString(4);
                v.addElement(new Postcode(postcode,province,region,telecode));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static java.util.Enumeration findProvince() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT province FROM postcode GROUP BY province");
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPostcode()
    {
        return postcode;
    }

    public String getProvince()
    {
        return province;
    }

    public String getRegion()
    {
        return region;
    }

    public String getTelecode()
    {
        return telecode;
    }

    /*
     * public String toString() { StringBuilder sb = new StringBuilder(); if (card > 0) { String str = String.valueOf(card); try { sb.append(Card.find(Integer.parseInt(str.substring(0, 2))).getAddress()).append(" "); sb.append(Card.find(Integer.parseInt(str.substring(0, 4))).getAddress()).append(" ");
     * sb.append(Card.find(Integer.parseInt(str.substring(0, 6))).getAddress()).append(" "); } catch (Exception ex) { } } return sb.append(name).toString(); }
     */


    public static void toJavascript(java.io.File f)
    {
        StringBuilder sb[] = new StringBuilder[3];
        try
        {
            java.io.PrintWriter fw = new java.io.PrintWriter(f,"UTF-8");

            sb[0] = new StringBuilder();
            sb[0].append("var card=new Array(");
            java.util.Enumeration e2 = find(" ORDER BY telecode",0,Integer.MAX_VALUE);
            while(e2.hasMoreElements())
            {
                Postcode obj2 = (Postcode) e2.nextElement();
                if(sb[0].length() > 25)
                {
                    sb[0].append(",");
                }
                sb[0].append("new Array('").append(obj2.getTelecode()).append("','").append(obj2.getProvince()).append("')");

                sb[1] = new StringBuilder();
                sb[1].append("var card").append(obj2.getTelecode()).append("=new Array(");
                java.util.Enumeration e4 = find(" AND card LIKE '" + obj2.getTelecode() + "__'",0,Integer.MAX_VALUE);
                while(e4.hasMoreElements())
                {
                    Card obj4 = (Card) e4.nextElement();
                    if(sb[1].length() > 25)
                    {
                        sb[1].append(",");
                    }
                    sb[1].append("new Array('").append(obj4.getCard()).append("','").append(obj4.getAddress()).append("')");
                }
                sb[1].append(");\r\n\r\n");
                fw.write(sb[1].toString());
            }
            sb[0].append("); \r\n\r\n");
            sb[0].append("function selectcard(s0,s1,s2,dv)                                                                       \r\n");
            sb[0].append("{                                                                       \r\n");
            sb[0].append("	document.write(\"<select name='\"+s0+\"' onchange=\\\"addcard(this.value,'\"+s1+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	addcard(null,s0,dv);                                                                       \r\n");
            sb[0].append("	if(s1)                                                                       \r\n");
            sb[0].append("	{                                                                       \r\n");
            sb[0].append("	  document.write(\"<select name='\"+s1+\"' onchange=\\\"addcard(this.value,'\"+s2+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	  if(s2)                                                                       \r\n");
            sb[0].append("	     document.write(\"<select name='\"+s2+\"' ><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	}                                                                       \r\n");
            sb[0].append("}                                                                       \r\n");
            sb[0].append("function addcard(father,s,dv)                                                                       \r\n");
            sb[0].append("{                                                                       \r\n");
            sb[0].append("  var ob=document.all(s);                                                                       \r\n");
            sb[0].append("  var op=ob.options;                                                                       \r\n");
            sb[0].append("  while(op.length>1)                                                                       \r\n");
            sb[0].append("  {                                                                       \r\n");
            sb[0].append("    op[1]=null;                                                                       \r\n");
            sb[0].append("  }                                                                       \r\n");
            sb[0].append("  if(father==null||father.length>0)                                                                       \r\n");
            sb[0].append("  {                                                                       \r\n");
            sb[0].append("  	if(father==null)                                                                       \r\n");
            sb[0].append("  	father='';                                                                       \r\n");
            sb[0].append("	    var c=eval('card'+father);                                                                       \r\n");
            sb[0].append("		for(var i=0;i<c.length;i++)                                                                       \r\n");
            sb[0].append("		{                                                                       \r\n");
            sb[0].append("		  op[i+1]=new Option(c[i][1],c[i][0]);                                                                       \r\n");
            sb[0].append("		  if( dv.indexOf(c[i][0])==0 || dv==c[i][1] )                                                                       \r\n");
            sb[0].append("		  {                                                                       \r\n");
            sb[0].append("		    op[i+1].selected=true;                                                                       \r\n");
            sb[0].append("		    // ob.onchange();                                                                       \r\n");
            sb[0].append("		  }                                                                       \r\n");
            sb[0].append("		}                                                                       \r\n");
            sb[0].append("	}                                                                       \r\n");
            sb[0].append("}                                                                       \r\n");
            fw.write(sb[0].toString());
            fw.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
