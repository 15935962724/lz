package tea.entity.util;

import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.io.*;

public class Card
{
    public int card;
    public String address;
    public boolean exists;

    public Card(int card) throws SQLException
    {
        this.card = card;
        load();
    }

    public Card(int card,String address) throws SQLException
    {
        this.card = card;
        this.address = address;
        exists = true;
    }

    public static Card find(int card) throws SQLException
    {
        return new Card(card);
    }

    public static int getCid(String address) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select card from Card where address like " + DbAdapter.cite("%" + address + "%"),0,100);
            if(db.next())
            {
                c = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        return c;
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT address FROM Card WHERE card = " + card);
            if(db.next())
            {
                address = db.getString(1);
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

    public static void create(String card,String address) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Card(card,address)VALUES(" + DbAdapter.cite(card) + "," + DbAdapter.cite(address) + ")");
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            return db.next() ? db.getInt(1) : 0;
        } finally
        {
            db.close();
        }
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT card,address FROM Card WHERE 1=1" + sql);
            while(db.next())
            {
                al.add(new Card(db.getInt(1),db.getString(2)));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int findcard(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int card = 0;
        try
        {
            db.executeQuery("SELECT card FROM Card WHERE 1=1 " + sql);
            if(db.next())
            {
                card = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return card;
    }


    public int getCard()
    {
        return card;
    }

    public String getAddress()
    {
        return address;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        try
        {
            if(card > 100)
            {
                String str = String.valueOf(card);
                sb.append(find(Integer.parseInt(str.substring(0,str.length() - 2))).toString()).append(" ");
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        if(card < 1 || card == 1101 || card == 1201 || card == 3101 || card == 5001)
        {} else
            sb.append(address);
        return sb.toString();
    }

    public String toString2()
    {
        StringBuilder sb = new StringBuilder();
        try
        {

            if(card > 100)
            {
                String str = String.valueOf(card);

                sb.append(find(Integer.parseInt(str.substring(0,2))).getAddress()).append("/").append(find(Integer.parseInt(str)).getAddress());
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return sb.toString();
    }


    public String toStringCity1()
    {
        StringBuilder sb = new StringBuilder();
        try
        {

            if(card > 100)
            {
                String str = String.valueOf(card);

                sb.append(find(Integer.parseInt(str.substring(0,2))).getAddress());
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return sb.toString();
    }

    public String toStringCity2()
    {
        StringBuilder sb = new StringBuilder();
        try
        {

            if(card > 100)
            {
                String str = String.valueOf(card);

                sb.append(find(Integer.parseInt(str)).getAddress());
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }

        return sb.toString();
    }

    public static void toJavascript(File f)
    {
        StringBuilder sb[] = new StringBuilder[3];
        try
        {
            PrintWriter fw = new PrintWriter(f,"UTF-8");

            sb[0] = new StringBuilder();
            sb[0].append("var card=new Array(");
            ArrayList al = find(" AND card <100",0,Integer.MAX_VALUE);
            for(int i = 0;i < al.size();i++)
            {
                Card obj2 = (Card) al.get(i);
                if(sb[0].length() > 25)
                {
                    sb[0].append(",");
                }
                sb[0].append("new Array('").append(obj2.getCard()).append("','").append(obj2.getAddress()).append("')");

                sb[1] = new StringBuilder();
                sb[1].append("var card").append(obj2.getCard()).append("=new Array(");
                ArrayList a2 = find(" AND card LIKE '" + obj2.getCard() + "__'",0,Integer.MAX_VALUE);
                for(int j = 0;j < a2.size();j++)
                {
                    Card obj4 = (Card) a2.get(j);
                    if(sb[1].length() > 25)
                    {
                        sb[1].append(",");
                    }
                    sb[1].append("new Array('").append(obj4.getCard()).append("','").append(obj4.getAddress()).append("')");

                    sb[2] = new StringBuilder();
                    sb[2].append("var card").append(obj4.getCard()).append("=new Array(");
                    ArrayList a3 = find(" AND card LIKE '" + obj4.getCard() + "__'",0,Integer.MAX_VALUE);
                    for(int z = 0;z < a3.size();z++)
                    {
                        Card obj6 = (Card) a3.get(z);
                        if(sb[2].length() > 25)
                        {
                            sb[2].append(",");
                        }
                        sb[2].append("new Array('").append(obj6.getCard()).append("','").append(obj6.getAddress()).append("')");
                    }
                    sb[2].append(");\r\n\r\n");
                    fw.write(sb[2].toString());
                }
                sb[1].append(");\r\n\r\n");
                fw.write(sb[1].toString());
            }
            sb[0].append("); \r\n\r\n");
            sb[0].append("function selectcard(s0,s1,s2,dv)                                                                       \r\n");
            sb[0].append("{                                                                       \r\n");
            sb[0].append("	document.write(\"<select name='\"+s0+\"' onchange=\\\"addcard(this.value,'\"+s1+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	if(s1)                                                                       \r\n");
            sb[0].append("	{                                                                       \r\n");
            sb[0].append("	  document.write(\" <select name='\"+s1+\"' onchange=\\\"addcard(this.value,'\"+s2+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	  if(s2)                                                                       \r\n");
            sb[0].append("	     document.write(\" <select name='\"+s2+\"' ><option value=''>--------------</select>\");                                                                       \r\n");
            sb[0].append("	}                                                                       \r\n");
            sb[0].append("	addcard(null,s0,dv);                                                                       \r\n");
            sb[0].append("}                                                                       \r\n");
            sb[0].append("function addcard(father,s,dv)                                                                       \r\n");
            sb[0].append("{                                                                       \r\n");
            sb[0].append("  var ob=document.getElementsByName(s)[0];                                                                       \r\n");
            sb[0].append("  if(ob)                                                                       \r\n");
            sb[0].append("  {                                                                       \r\n");
            sb[0].append("    var op=ob.options;                                                                       \r\n");
            sb[0].append("    while(op.length>1)                                                                       \r\n");
            sb[0].append("    {                                                                       \r\n");
            sb[0].append("      op[1]=null;                                                                       \r\n");
            sb[0].append("    }                                                                       \r\n");
            sb[0].append("    if(father==null||father.length>0)                                                                       \r\n");
            sb[0].append("    {                                                                       \r\n");
            sb[0].append("    	if(father==null)                                                                       \r\n");
            sb[0].append("    	father='';                                                                       \r\n");
            sb[0].append("	    var c=eval('card'+father);                                                                       \r\n");
            sb[0].append("		for(var i=0;i<c.length;i++)                                                                       \r\n");
            sb[0].append("		{                                                                       \r\n");
            sb[0].append("		  op[i+1]=new Option(c[i][1],c[i][0]);                                                                       \r\n");
            sb[0].append("		  if( dv.indexOf(c[i][0])==0 || dv==c[i][1] )                                                                       \r\n");
            sb[0].append("		  {                                                                       \r\n");
            sb[0].append("		    op[i+1].selected=true;                                                                       \r\n");
            sb[0].append("		  }                                                                       \r\n");
            sb[0].append("		}                                                                       \r\n");
            sb[0].append("		if(ob.onchange)ob.onchange();                                                                       \r\n");
            sb[0].append("	}                                                                       \r\n");
            sb[0].append("  }                                                                       \r\n");
            sb[0].append("}                                                                       \r\n");
            fw.write(sb[0].toString());
            fw.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
//三级联动
//Workbook wb=new HSSFWorkbook();
//Sheet ws=wb.createSheet();
//
//int x=78,y=0;
//ArrayList al=Card.find(" AND card<10000 AND card NOT IN(1101,1201,3101,5001) ORDER BY card",0,Integer.MAX_VALUE);
//for(int i=0;i<al.size();i++)
//{
//  Card t=(Card)al.get(i);
//  Row wr=ws.createRow(i);
//  Cell wd=wr.createCell(x);
//  wd.setCellValue(t.address);
//
//  if(t.card==11||t.card==12||t.card==31||t.card==50)t.card=t.card*100+1;
//  ArrayList a2=Card.find(" AND card LIKE "+DbAdapter.cite(t.card+"__")+" ORDER BY card",0,Integer.MAX_VALUE);
//  for(int j=0;j<a2.size();j++)
//  {
//	Card t2=(Card)a2.get(j);
//	wd=wr.createCell(x+j+1);
//	wd.setCellValue(t2.address);
//  }
//  y++;
//  Name name=wb.createName();
//  name.setNameName(t.address);
//  name.setRefersToFormula("Sheet0!$"+aa(x+1)+"$"+y+":$"+aa(x+a2.size())+"$"+y);
//}
//
//
//OutputStream os=new FileOutputStream(application.getRealPath("/row.xls"));
//wb.write(os);
//os.close();
//String aa(int x)
//{
//  char ch=(char)(x%26+'A');
//  return (x/26>0?aa(x/26-1):"")+ch;
//};
