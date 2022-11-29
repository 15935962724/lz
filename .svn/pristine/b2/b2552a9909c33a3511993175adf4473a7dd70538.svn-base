package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class ListingDetail extends Entity
{
    public static Cache _cache = new Cache(1200);
    private LinkedHashMap _htLayer = new LinkedHashMap();
    public static String SHOW_TYPE[] =
            {"--------","总是显示","显示"};
    public int listing;
    public int type;
    private int language;
    class Layer
    {
        private Layer(int istype,String beforeitem,String afteritem,int sequence,int anchor,int quantity,String options,Date time,int ckhref)
        {
            this.istype = istype;
            this.beforeitem = beforeitem;
            this.afteritem = afteritem;
            this.sequence = sequence;
            this.anchor = anchor;
            this.quantity = quantity;
            this.options = options;
            this.time = time;
            this.ckhref = ckhref;
        }

        public int istype; //0:不显示,1:总是显示,2:显示
        public String beforeitem;
        public String afteritem;
        public int sequence;
        public int anchor;
        private int quantity;
        private String options; //5:图示
        private Date time;
        private int ckhref; // 过滤html标签
    }


    private ListingDetail(int listing,int type,int language) throws SQLException
    {
        this.listing = listing;
        this.type = type;
        this.language = language;
        load(language);
    }

    public int getListing()
    {
        return listing;
    }

    public int getType()
    {
        return type;
    }

    public Iterator keys()
    {
        return _htLayer.keySet().iterator(); //_htLayer.keys();
    }

    public static Enumeration findByListing(int i) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type,itemname,language FROM ListingDetail WHERE listing=" + i);
            while(db.next())
            {
                v.addElement(new Object[]
                             {new Integer(db.getInt(1)),db.getString(2),new Integer(db.getInt(3))});
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getIstype(String itemname) throws SQLException
    {
        Layer obj = getLayer(itemname);
        if(obj == null)
        {
            return 0;
        }
        return obj.istype;
    }

    public String getBeforeItem(String itemname) throws SQLException
    {
        return getLayer(itemname).beforeitem;
    }

    public String getAfterItem(String itemname) throws SQLException
    {
        return getLayer(itemname).afteritem;
    }

    public int getSequence(String itemname)
    {
        return getLayer(itemname).sequence;
    }

    public int getAnchor(String itemname) throws SQLException
    {
        return getLayer(itemname).anchor;
    }

    public int getQuantity(String itemname) throws SQLException
    {
        return getLayer(itemname).quantity;
    }

    public int getLanguage()
    {
        return language;
    }

    public boolean isExists(String itemname)
    {
        return _htLayer.get(itemname) != null;
    }

    public Date getTime(String itemname) throws SQLException
    {
        return getLayer(itemname).time;
    }

    public int getCkhref(String itemname)
    {
        return getLayer(itemname).ckhref;
    }

    public String getOptions(String itemname) throws SQLException
    {
        return getLayer(itemname).options;
    }

    public String getOptionsToHtml2(String itemname,String value,String astr) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        if(value != null)
        {
            int dq = getQuantity(itemname);
            if(dq > 0 && value.length() > dq && !itemname.startsWith("correlation"))
            {
                value = value.substring(0,dq) + "…";
            }

            if(this.getAnchor(itemname) != 0 && astr != null && astr.length() > 0)
            {
                value = astr + value + "</a>";
            }

            sb.append(value);
        }
        return sb.toString();
    }

    public String getOptionsToHtml(String itemname,Node node,String value) throws SQLException
    {
//        if(99863 == node._nNode)
//        {
//            System.out.println("=========");
//        }
        StringBuilder sb = new StringBuilder();
        String op = getOptions(itemname);
        if(value != null)
        {

            int dq = getQuantity(itemname);
            if(dq > 0 && value.length() > dq && !itemname.startsWith("correlation"))
            {
                if(op.indexOf("/7/") != -1) //英文截取字符数量
                {
                    String s = value.substring(0,dq);
                    // System.out.println(s);
                    // System.out.println(value);
                    //  System.out.println((s.substring(s.length()-1,s.length()).equals(" ")));
                    if((s.substring(s.length() - 1,s.length()).equals(" ")))
                    {
                        value = s + "...";
                    } else
                    {

                        int in = s.lastIndexOf(" "); // 最后位置
                        value = s.substring(0,in) + "...";
                    }

                } else
                {
                    try
                    {
                        dq = dq * 2;
                        value = Node.bSubstring(value.toString(),dq) + "...";
                    } catch(Exception e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }

            sb.append(value);
        }

        if(op.indexOf("/5/") != -1)
        {
            String p = node.getPicture(language);
            if(p != null && p.length() > 1)
            {
                sb.append(" <img src='/tea/image/picture.gif'/>");
            }
//            String v = node.getVoice(language);
//            if(v != null && v.length() > 1)
//            {
//                sb.append(" <img src='/tea/image/voice.gif'/>");
//            }
//            String f = node.getFile(language);
//            if(f != null && f.length() > 1)
//            {
//                sb.append(" <img src='/tea/image/file.gif'/>");
//            }
        }
        if(op.indexOf("/6/") != -1)
        {
            //时间间隔一天的时候

            Date times = node.getType() == 39 ? node.getStartTime() : node.getTime();

            Calendar c = Calendar.getInstance();
            int day = c.get(c.DAY_OF_YEAR);
            c.setTime(times);
//			if(node.getType()==39){
//				int cday=c.get(c.DAY_OF_YEAR);
//				if(cday<=day&&cday>(day-7)){新能源修改
//					sb.append(" <img src='/tea/image/public/new.gif'/>");
//				}
//			}else{
            if(day == c.get(c.DAY_OF_YEAR))
            {
                sb.append(" <img src='/tea/image/public/new.gif'/>");
            }
//			}


            //间隔三天
            /*
               java.text.DateFormat df = java.text.DateFormat.getDateInstance();
               Date time = new Date(); //系统时间类
               long l1 = time.getTime(); //把字符串转化为时间
               long l2 = node.getTime().getTime();
               long l3 = 0; //时间间隔
               if(l1 > l2) //判断时间先后
               {
                   l3 = l1 - l2;
               } else
               {
                   l3 = l2 - l1;
               }
               l3 = l3 / (60 * 60 * 24 * 1000);
               String l4 = String.valueOf(l3);

               if(Integer.parseInt(l4) < 1) //从 0 算起，当天是 0
               {
                   sb.append(" <img src='/tea/image/public/new.gif'/>");
               }
             */

        }
        return sb.toString();
    }


    public String getTimeToString(String itemname) throws SQLException
    {
        Date time = getTime(itemname);
        if(time == null)
        {
            return "";
        }
        return sdf.format(time);
    }

//    public boolean getAnchor(int code)
//    {
//        return(anchor | code) != 0;
//    }

    private Layer getLayer(String itemname)
    {
        Layer obj = (Layer) _htLayer.get(itemname);
        if(obj == null)
        {
            obj = new Layer(0,null,null,0,0,0,"/",null,0); //不要放入缓存,见isExists
        }

        return obj;
    }

    public void set(String itemname,int istype,String beforeitem,String afteritem,int sequence,int anchor,int quantity,String options,Date time) throws SQLException
    {
        String sql = "listing=" + listing + " AND type=" + type + " AND language=" + language + " AND itemname=" + DbAdapter.cite(itemname);
        DbAdapter db = new DbAdapter();
        try
        {
            //if(isExists(itemname))
            if(ListingDetail.isExists(listing,type,language,itemname))
            {
                db.executeUpdate("UPDATE ListingDetail SET istype=" + istype + ",beforeitem=' ',afteritem=' ',sequence=" + sequence + ",anchor=" + anchor + ",quantity=" + quantity + ",options=" + DbAdapter.cite(options) + ",time=" + DbAdapter.cite(time) + " WHERE " + sql);
            } else
            {
                db.executeUpdate("INSERT INTO ListingDetail(listing,type,itemname,istype,beforeitem,afteritem,sequence,anchor,quantity,options,language,time)VALUES(" + listing + ", " + type + "," + DbAdapter.cite(itemname) + ", " + istype + ",' ',' '," + sequence + "," + anchor + "," + quantity + "," + DbAdapter.cite(options) + "," + language + "," + DbAdapter.cite(time) + ")");
            }
            db.setText("ListingDetail",new String[]
                       {"beforeitem","afteritem"},new String[]
                       {beforeitem,afteritem},sql);
        } finally
        {
            db.close();
        }
        //_htLayer.put(itemname,new Layer(istype,beforeitem,afteritem,sequence,anchor,quantity,time));
        _cache.remove(listing + ":" + type + ":" + language);
    }

    public void set(String itemname,int istype,String beforeitem,String afteritem,int sequence,int anchor,int quantity,String options,Date time,int ckhref) throws SQLException
    {
        String sql = "listing=" + listing + " AND type=" + type + " AND language=" + language + " AND itemname=" + DbAdapter.cite(itemname);
        String[] arr1 = DbAdapter.split("ListingDetail","beforeitem",beforeitem,sql);
        String[] arr2 = DbAdapter.split("ListingDetail","afteritem",afteritem,sql);
        DbAdapter db = new DbAdapter();
        try
        {
            if(ListingDetail.isExists(listing,type,language,itemname))
            {
                db.executeUpdate(listing,"UPDATE ListingDetail SET istype=" + istype + ",beforeitem=" + DbAdapter.cite(arr1[0]) + ",afteritem=" + DbAdapter.cite(arr2[0]) + ",sequence=" + sequence + ",ckhref=" + ckhref + ",anchor=" + anchor + ",quantity=" + quantity + ",options=" + DbAdapter.cite(options) + ",time=" + DbAdapter.cite(time) + " WHERE " + sql);
            } else
            {
                db.executeUpdate(listing,"INSERT INTO ListingDetail(listing,type,itemname,istype,beforeitem,afteritem,sequence,anchor,quantity,options,language,time,ckhref)VALUES(" + listing + ", " + type + "," + DbAdapter.cite(itemname) + ", " + istype + "," + DbAdapter.cite(arr1[0]) + "," + DbAdapter.cite(arr2[0]) + "," + sequence + "," + anchor + "," + quantity + "," + DbAdapter.cite(options) + "," + language + "," + DbAdapter.cite(time) + "," + ckhref + ")");
            }
            for(int i = 1;i < arr1.length;i++)
                db.executeUpdate(listing,arr1[i]);
            for(int i = 1;i < arr2.length;i++)
                db.executeUpdate(listing,arr2[i]);
        } finally
        {
            db.close();
        }
        //_htLayer.put(itemname,new Layer(istype,beforeitem,afteritem,sequence,anchor,quantity,time));
        _cache.remove(listing + ":" + type + ":" + language);
    }

    public static boolean isExists(int listing,int type,int language,String itemname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("SELECT itemname FROM ListingDetail WHERE listing=" + listing + " AND type=" + type + " AND language=" + language + " AND itemname=" + db.cite(itemname)); // AND istype<>0
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

    public static ListingDetail find(int listing,int type,int language) throws SQLException
    {
        String key = listing + ":" + type + ":" + language;
        ListingDetail obj = (ListingDetail) _cache.get(key);
        if(obj == null)
        {
            obj = new ListingDetail(listing,type,language);
            _cache.put(key,obj);
        }
        return obj;
    }

//    public static ListingDetail find(int listingdetail) throws SQLException
//    {
//        int listing = 0,type = 0,language = 0;
//        String itemname = null;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT listing,type,itemname,language FROM ListingDetail WHERE listingdetail=" + listingdetail);
//            if(db.next())
//            {
//                listing = db.getInt(1);
//                type = db.getInt(2);
//                itemname = db.getString(3);
//                language = db.getInt(4);
//            }
//        } catch(Exception ex)
//        {
//            ex.printStackTrace();
//        } finally
//        {
//            db.close();
//        }
//        return find1111(listing,type,itemname,language);
//    }

    public static void delete(int listing,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,"DELETE FROM ListingDetail WHERE listing=" + listing + " AND type=" + type);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public static void delete(int Listing) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM ListingDetail WHERE listing=" + Listing);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void delete(String itemname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,"DELETE FROM ListingDetail WHERE listing=" + listing + " AND type=" + type + " AND language=" + language + " AND itemname=" + DbAdapter.cite(itemname));
        } finally
        {
            db.close();
        }
        _htLayer.remove(itemname);
    }

    private void load(int j) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT itemname,istype,beforeitem,afteritem,sequence,anchor,quantity,options,time,ckhref FROM ListingDetail WHERE listing=" + listing + " AND type=" + type + " AND language=" + j + " ORDER BY sequence"); // AND istype<>0
            while(db.next())
            {
                String itemname = db.getString(1);
                int istype = db.getInt(2);
                String bi = db.getText(j,language,3);
                String ai = db.getText(j,language,4);
                int sequence = db.getInt(5);
                int a = db.getInt(6);
                int q = db.getInt(7);
                String options = db.getString(8);
                Date t = db.getDate(9);
                int ckhref = db.getInt(10);
                _htLayer.put(itemname,new Layer(istype,bi,ai,sequence,a,q,options,t,ckhref));
            }
        } finally
        {
            db.close();
        }
        if(_htLayer.size() < 1 && j == language)
        {
            j = getLanguage(listing,type,language);
            if(j != -1)
            {
                load(j);
            }
        }
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing,type,language FROM ListingDetail WHERE 1=1" + sql + " GROUP BY listing,type,language",pos,size);
            while(db.next())
            {
                int j = 1;
                ListingDetail ld = new ListingDetail(db.getInt(j++),db.getInt(j++),db.getInt(j++));
                al.add(ld);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static boolean isLoad(int listing,int type,int language,String itemname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("SELECT itemname FROM ListingDetail WHERE istype!=0 and listing=" + listing + " AND type=" + type + " AND language=" + language + " AND  itemname=" + db.cite(itemname)); // AND istype<>0
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


    private static int getLanguage(int listing,int type,int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM ListingDetail WHERE listing=" + listing + " AND type=" + type);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return -1;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }
}
