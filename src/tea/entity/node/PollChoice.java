package tea.entity.node;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.util.Enumeration;

public class PollChoice implements Cloneable
{
    public int id;
    public int poll;
    private String choice;
    private static Cache _cache = new Cache(100);
    //添加新的字段： 修改时间 2008年9月8日16:08:45
    //大图。//小图：//简介：//个人信息：//姓名： //联系方式2008年9月10日10:01:44
    private String bigPicture;
    private String smallPicture;
    private String pollinfo;
    private String memberinfo;
    private String firstname;
    private String title;
    private String linkman;
    private int sequence; //顺序
    private int sorting; //结果字段


    public PollChoice(int id)
    {
        this.id = id;
        loadBasic();
    }

    public void set(int poll,String choice,String pollinfo,String memberinfo,String firstname,String title,String bigPicture,String smallPicture,String linkman,int sequence)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("PollChoiceEdit " + id + "," + poll + "," + DbAdapter.cite(choice));
            db.executeQuery("SELECT id FROM PollChoice WHERE id=" + id);
            if(db.next())
            {
                db.executeUpdate("UPDATE PollChoice SET sequence=" + sequence + ", poll=" + poll + ", choice=" + DbAdapter.cite(choice) + ",  pollinfo =" + DbAdapter.cite(pollinfo) + ",  memberinfo =" + DbAdapter.cite(memberinfo) + ",  firstname  =" + DbAdapter.cite(firstname) + ",title=" + DbAdapter.cite(title) + ",linkman=" + DbAdapter.cite(linkman) + " WHERE id=" + id);
            } else
            {
                db.executeUpdate("INSERT PollChoice(poll,choice,pollinfo,memberinfo,firstname,title,bigPicture,smallPicture,linkman,sequence) VALUES(" + poll + "," + DbAdapter.cite(choice) + "," + DbAdapter.cite(pollinfo) + "," + DbAdapter.cite(memberinfo) + "," + DbAdapter.cite(firstname) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(bigPicture) + "," + DbAdapter.cite(smallPicture) + "," + DbAdapter.cite(linkman) + "," + sequence + ")");
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(id < 1)
            {
				db.executeUpdate("INSERT PollChoice(poll,choice,pollinfo,memberinfo,firstname,title,bigPicture,smallPicture,linkman,sequence) VALUES(" + poll + "," + DbAdapter.cite(choice) + "," + DbAdapter.cite(pollinfo) + "," + DbAdapter.cite(memberinfo) + "," + DbAdapter.cite(firstname) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(bigPicture) + "," + DbAdapter.cite(smallPicture) + "," + DbAdapter.cite(linkman) + "," + sequence + ")");
				id = db.getInt("SELECT MAX(id) FROM PollChoice");
            }else
                db.executeUpdate("UPDATE PollChoice SET sequence=" + sequence + ", poll=" + poll + ", choice=" + DbAdapter.cite(choice) + ",  pollinfo =" + DbAdapter.cite(pollinfo) + ",  memberinfo =" + DbAdapter.cite(memberinfo) + ",  firstname  =" + DbAdapter.cite(firstname) + ",title=" + DbAdapter.cite(title) + ",linkman=" + DbAdapter.cite(linkman) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }


    public boolean isID() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("SELECT id FROM PollChoice WHERE id=" + id);
            if(db.next())
            {
                f = true;
            }

        } finally
        {
            db.close();
        }
        return f;

    }

    public static PollChoice find(int id)
    {
        PollChoice poll = (PollChoice) _cache.get(new Integer(id));
        if(poll == null)
        {
            poll = new PollChoice(id);
            _cache.put(new Integer(id),poll);
        }
        return poll;
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM PollChoice  WHERE id=" + this.id);
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static java.util.Enumeration findWeek(int poll,int langu,int top)
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder sb = new StringBuilder();
            db.executeQuery("SELECT answer FROM PollResult  WHERE PollResult.poll=" + poll + " AND PollResult. language =" + langu + " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000))) + " group by answer order by COUNT(PollResult.poll) desc");
            int id;
            for(int i = 0;(top == 0 || i < top) && db.next();i++)
            {
                id = db.getInt(1);
                vector.addElement(new Integer(id));
                sb.append(id + ",");
            }
            if(vector.size() < top || top <= 0)
            {
                db.executeQuery("SELECT id FROM PollChoice WHERE poll=" + poll + " AND language=" + langu + " and id not in(SELECT answer FROM PollResult  WHERE PollResult.poll=" + poll + " AND PollResult. language =" + langu + " )"); // "SELECT id FROM PollChoice WHERE node=" + node + " AND language=" + langu + ""); //ORDER BY
                while(db.next())
                {
                    id = db.getInt(1);
                    vector.addElement(new Integer(id));
                    sb.append(id + ",");
                }
            }
            if(sb.length() > 0)
            {
                sb.setLength(sb.length() - 1);
                sb.insert(0," AND id in(");
                sb.append(") ");
            }
            db.executeQuery("SELECT id FROM PollChoice WHERE poll=" + poll + " AND language=" + langu + sb.toString() + " ORDER BY choice");
            vector.clear();
            for(int i = 0;(top == 0 || i < top) && db.next();i++)
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //只显示结果总的显示
    public static String getResults_ZJG(int poll_id,int poll_choice_id,int d,int language) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        Poll poll_obj = Poll.find(poll_id);
//        System.out.println(poll_id);
//        if(poll_obj.getType() == 3)
//        {
//            sb.append("<span id='PollIDresult'>");
//            Enumeration e = PollResult.find(" AND poll=" + poll_id + " ORDER BY pollresult",0,500);
//            while(e.hasMoreElements())
//            {
//                PollResult pp = PollResult.find((Integer) e.nextElement());
//                sb.append(pp.getMember()._strR + "：" + pp.getText(language) + "<br/>");
//            }
//            sb.append("</span>");
//            return sb.toString();
//        }
        int sum = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeQuery("SELECT COUNT(id)  FROM PollChoice  WHERE poll=" + poll_id);
            db.executeQuery("SELECT sum(sorting)  FROM PollChoice  WHERE poll=" + poll_id);
            if(db.next())
            {
                sum = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        PollChoice pc = new PollChoice(poll_choice_id);
        int to = pc.getSorting();

        if(d != 1)
        {
            sb.append("<SPAN id=\"PollIDAllRequest\"><div style=\"width:" + PollResult.getResult(poll_id,language,poll_choice_id,d,true) + "%; background: url(" + poll_obj.getPicture() + ") repeat-x left;\"></div></SPAN>");
            sb.append("<SPAN ID=PollIDBallot_1>" + to + "</SPAN>");
        }

        float p = (float) to / sum;
        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
        nf.setMinimumFractionDigits(0); // 小数点后保留几位
        String str = nf.format(p); // 要转化的数

        if(p > 0)
        {
            sb.append("<SPAN ID=PollIDBallot_2>" + str + "</SPAN>");
        } else
        {
            sb.append("<SPAN ID=PollIDBallot_2>0%</SPAN>");
        }
        return sb.toString();
    }

    //显示投票结果 显示的是月，日的功能
    public static String getResults(int poll_id,int poll_choice_id,int d,int language) throws SQLException
    {
        Poll poll_obj = null;

        try
        {
            poll_obj = tea.entity.node.Poll.find(poll_id);
        } catch(SQLException ex)
        {
        }
        int getTop = Integer.MAX_VALUE;
        //计算总价 v
        //	java.util.Enumeration es = PollChoice.find(poll_id,getTop,d,"",0,Integer.MAX_VALUE);
        int sum = 0;
        //	while(es.hasMoreElements())
        //	{
        //	int id = ((Integer) es.nextElement()).intValue();
        //	sum = sum + PollResult.getResult(poll_id,language,id,d,false);
        //}



        String timeSql;
        //DbAdapter db=new DbAdapter();
        switch(d)
        {
        case 1: //总
            timeSql = "";
            break;
        case 2: //月
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (30L * 24L * 60L * 60L * 1000L)));
            break;
        default: //周
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000)));
        }

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(poll)  FROM PollResult  WHERE poll=" + poll_id + timeSql);
            if(db.next())
            {
                sum = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        StringBuilder sb = new StringBuilder();
        //java.util.Enumeration enumeration = PollChoice.find(poll_id,getTop,d,"",10,Integer.MAX_VALUE);
        //	while(enumeration.hasMoreElements())
        //{
        //int id = ((Integer) enumeration.nextElement()).intValue();
        //if(poll_choice_id == id)
        //{
        PollChoice pc = new PollChoice(poll_choice_id);
        int to = PollResult.getResult(poll_id,language,poll_choice_id,d,false);
        sb.append("<SPAN id=\"PollIDAllRequest\"><div style=\"width:" + PollResult.getResult(poll_id,language,poll_choice_id,d,true) + "%; background: url(" + poll_obj.getPicture() + ") repeat-x left;\"></div></SPAN>");
        sb.append("<SPAN ID=PollIDBallot_1>" + to + "</SPAN>");

        float p = (float) to / sum;
        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
        nf.setMinimumFractionDigits(0); // 小数点后保留几位
        String str = nf.format(p); // 要转化的数

        if(p > 0)
        {
            sb.append("<SPAN ID=PollIDBallot_2>" + str + "</SPAN>");
        } else
        {
            sb.append("<SPAN ID=PollIDBallot_2>0%</SPAN>");
        }
        //}
        //}
        return sb.toString();

    }

    public static java.util.Enumeration findWeek(int poll,int langu) throws SQLException
    {
        return findWeek(poll,langu,0); // Poll.find(node, langu).getTop());
    }

    public static java.util.Enumeration find(int poll,int top,int time,String sql,int PollChoicePos,int PollChoiceSize)
    {
        String timeSql;
        switch(time)
        {
        case 1: // 总
            timeSql = "";
            break;
        case 2: // 月
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (30L * 24L * 60L * 60L * 1000L)));
            break;
        default: // 周
            timeSql = " AND time>=" + DbAdapter.cite(new Date(System.currentTimeMillis() - (7 * 24 * 60 * 60 * 1000)));
        }
        return find_2(poll,top,timeSql,sql,PollChoicePos,PollChoiceSize);
    }

    public static java.util.Enumeration find_2(int poll,int top,String sqlWhereTime,String sql,int PollChoicePos,int PollChoiceSize)
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder sb = new StringBuilder();
            db.executeQuery("SELECT answer FROM PollResult WHERE poll=" + poll + sqlWhereTime + " group by answer order by COUNT(poll) desc");
            /// System.out.println("SELECT answer FROM PollResult  WHERE PollResult.poll=" + poll + sqlWhereTime + " group by answer order by COUNT(PollResult.poll) desc");
            // COUNT(PollResult.node) desc");
            int id;
            if(!" order by sorting desc ".equals(sql))
            { //如果不是显示前几名的
                for(int i = 0;(top == 0 || i < top) && db.next();i++)
                {
                    id = db.getInt(1);
                    vector.addElement(new Integer(id));
                    sb.append(id + ",");
                }
                if(vector.size() < top || top <= 0)
                {
                    if(vector.size() < top)
                    {
                        top = top - vector.size();
                    }
                    db.executeQuery("SELECT id FROM PollChoice WHERE poll=" + poll + " AND id not in(SELECT answer FROM PollResult  WHERE PollResult.poll=" + poll + sqlWhereTime + " )");
                    for(int i = 0;(top == 0 || i < top) && db.next();i++)
                    {
                        id = db.getInt(1);
                        vector.addElement(new Integer(id));
                        sb.append(id + ",");
                    }
                }
                vector.clear();
            }
            if(sb.length() > 0)
            {
                sb.setLength(sb.length() - 1);
                sb.insert(0," AND id in(");
                sb.append(") ");
            }
            db.executeQuery("SELECT id FROM PollChoice WHERE poll=" + poll + sb.toString() + sql,PollChoicePos,PollChoiceSize); //ORDER BY choice order by sequence asc
            while(db.next())
            {
                vector.addElement(Integer.valueOf(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByPoll(int _nPoll)
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollChoice WHERE poll=" + _nPoll);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int countByPoll(int _nPoll)
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM PollChoice WHERE poll=" + _nPoll);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM PollChoice WHERE 1=1 " + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int sumCount(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int sum = 0;

        try
        {

            db.executeQuery("SELECT sum(sorting)  FROM PollChoice  WHERE 1=1 " + sql);
            if(db.next())
            {
                sum = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        return sum;
    }

    public static int countByPoll(int _nPoll,String sql)
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM PollChoice WHERE poll=" + _nPoll + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return j;
    }

    public static java.util.Enumeration findByPoll(int _nPoll,int pos,int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollChoice WHERE  poll=" + _nPoll + " order by sequence asc ",pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find(String sql,int pos,int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM PollChoice WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find(int poll,int time) throws SQLException
    {
        return find(poll,0,time,"",0,Integer.MAX_VALUE); // Poll.find(node, langu).getTop());
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public void setBigPicture(String bigPicture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" Update PollChoice set bigPicture=" + db.cite(bigPicture) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public void setSmallPicture(String smallPicture) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" Update PollChoice set smallPicture=" + db.cite(smallPicture) + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

//修改投票字段
    public void setSorting(int sorting) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" Update PollChoice set sorting=" + sorting + " where id=" + id);
        } finally
        {
            db.close();
        }
        this.sorting = sorting;
        _cache.remove(new Integer(id));
    }

    public int getId()
    {
        return id;
    }

    public int getPoll()
    {
        return poll;
    }

    public String getChoice()
    {
        if(choice == null)
        {
            return "";
        }
        return choice;
    }

    public String getTitle()
    {
        return title;
    }

    public String getSmallPicture()
    {
        return smallPicture;
    }

    public String getPollinfo()
    {
        return pollinfo;
    }

    public String getMemberinfo()
    {
        return memberinfo;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public String getBigPicture()
    {
        return bigPicture;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getSorting()
    {
        return sorting;
    }

    private void loadBasic()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT poll,choice,bigPicture,smallPicture,pollinfo,memberinfo,firstname,title,linkman,sequence,sorting FROM PollChoice WHERE id=" + id + " order by sequence asc");
            if(db.next())
            {
                poll = db.getInt(1);
                choice = db.getVarchar(1,1,2);
                bigPicture = db.getString(3);
                smallPicture = db.getString(4);
                pollinfo = db.getString(5);
                memberinfo = db.getString(6);
                firstname = db.getString(7);
                title = db.getString(8);
                linkman = db.getString(9);
                sequence = db.getInt(10);
                sorting = db.getInt(11);

            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public PollChoice clone() throws CloneNotSupportedException
    {
        PollChoice t = (PollChoice)super.clone();
        t.id = 0;
        return t;
    }

}
