package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;
import java.util.Calendar;
import java.sql.SQLException;

public class Books extends Entity
{
    private int id;
    private int unit;
    private String bookname;
    private int booksort;
    private String author;
    private String numeral;
    private String concern;
    private Date times;
    private String locus;
    private int amount;
    private float price;
    private String content;
    private int bound;
    private String human;
    private String remark;
    private int fettle;

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Books(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    //public static Duty find(int did) throws SQLException
    //{
//		return new Duty(did);
    //}
    public static Books find(int id) throws SQLException
    {
        return new Books(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT unit,bookname,booksort,author,numeral,concern,times,locus,amount,price,content,bound,human,remark,fettle from Books where id = " + id);
            if (db.next())
            {
                unit = db.getInt(1);
                bookname = db.getVarchar(1, 1, 2);
                booksort = db.getInt(3);
                author = db.getVarchar(1, 1, 4);
                numeral = db.getString(5);
                concern = db.getVarchar(1, 1, 6);
                times = db.getDate(7);
                locus = db.getVarchar(1, 1, 8);
                amount = db.getInt(9);
                price = db.getFloat(10);
                content = db.getVarchar(1, 1, 11);
                bound = db.getInt(12);
                human = db.getVarchar(1, 1, 13);
                remark = db.getVarchar(1, 1, 14);
                fettle = db.getInt(15);

                this.exists = true;
            } else
            {
                this.exists = false;
            }} finally
        {
            db.close();
        }
    }

    public static int create(int unit, String bookname, int booksort, String author, String numeral, String concern, Date times, String locus, int amount, float price, String content, int bound, String human, String remark, String community, RV _rv, int fettle) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Books(unit,bookname,booksort,author,numeral,concern,times,locus,amount,price,content,bound,human,remark,community,member,fettle)values(" + unit + "," + DbAdapter.cite(bookname) + "," + booksort + "," + DbAdapter.cite(author) + "," + DbAdapter.cite(numeral) + "," + DbAdapter.cite(concern) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(locus) + "," + amount + "," + price + "," + DbAdapter.cite(content) + "," + bound + "," + DbAdapter.cite(human) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + fettle + ") ");
            id = db.getInt("SELECT MAX(id) FROM Books");} finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(int unit, String bookname, int booksort, String author, String numeral, String concern, Date times, String locus, int amount, float price, String content, int bound, String human, String remark, int fettle) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Books SET unit=" + unit + ", bookname=" + DbAdapter.cite(bookname) + ",booksort=" + booksort + ",author=" + DbAdapter.cite(author) + ",numeral=" + DbAdapter.cite(numeral) + ",concern=" + DbAdapter.cite(concern) + ",times=" + DbAdapter.cite(times) + ",locus=" + DbAdapter.cite(locus) + ",amount=" + amount + ",price=" + price + ",content=" + DbAdapter.cite(content) + ",bound=" + bound + ",human=" + DbAdapter.cite(human) + ",remark=" + DbAdapter.cite(remark) + ",fettle=" + fettle + "  where id =" + id);} finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Books WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }} finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException, SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Books WHERE id =" + id);} finally
        {
            db.close();
        }
    }

    public int getUnit()
    {
        return unit;
    }

    public String getBookname()
    {
        return bookname;
    }

    public int getBooksort()
    {
        return booksort;
    }

    public String getAuthor()
    {
        return author;
    }

    public String getNumber()
    {
        return numeral;
    }

    public String getConcern()
    {
        return concern;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getLocus()
    {
        return locus;
    }

    public int getAmount()
    {
        return amount;
    }

    public float getPrice()
    {
        return price;
    }

    public String getContent()
    {
        return content;
    }

    public int getBound()
    {
        return bound;
    }

    public String getHuman()
    {
        return human;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getFettle()
    {
        return fettle;
    }
}
