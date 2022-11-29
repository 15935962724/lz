package tea.entity.admin;

import java.util.ArrayList;
import java.util.List;
import tea.db.*;
import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import java.text.*;
import java.util.Calendar;

public class ConsigneeAddress extends Entity {
    //查询收货地址记录
         public static  List getConsigneeAddress(String username)throws SQLException{
         ConsigneeAddress cons=null;
         List li=new ArrayList();
         String sql="select consigneeid,consignee,nowarea,streetaddress,postcode,homephone" +
         ",phone,state from consignee where username='"+username+"' order by state desc";
         DbAdapter db=new DbAdapter();
         try {
         db.executeQuery(sql);
         while(db.next()){
                 cons=new ConsigneeAddress();
                cons.setConsigneeid(db.getInt(1));
                cons.setConsignee(db.getString(2));
                cons.setNowarea(db.getString(3));
                cons.setStreetaddress(db.getString(4));
                cons.setPostcode(db.getString(5));
                cons.setHomephone(db.getString(6));
                cons.setPhone(db.getString(7));
                cons.setState(db.getString(8));
                li.add(cons);
         }
         } finally{
         db.close();
         }
         return li;
         }

        // 增加一条收货地址记录
        public static boolean create(String username, String consignee,
                        String nowarea, String streetaddress, String postcode,
                        String homephone, String phone) throws SQLException{
                boolean falg=false;
                String sql = "insert into consignee(username,consignee,nowarea,streetaddress,postcode,homephone,phone,state)"
                                + "  values('"
                                + username
                                + "','"
                                +consignee
                                + "','"
                                + nowarea
                                + "','"
                                + streetaddress
                                + "','"
                                + postcode
                                + "','"
                                + homephone
                                + "','" + phone + "','" + 0 + "')";




                DbAdapter db = new DbAdapter();
                try {
                        db.executeUpdate(sql);
                        falg=true;
                }  finally {
                        db.close();
                }
                return falg;
        }


        //获取当前用户记录数
        public static boolean getCount(String username) throws SQLException
        {
                boolean falg=false;
                int count=0;
                DbAdapter db = new DbAdapter();
                try
                {
                        db.executeQuery("select count(*) from consignee where username='"+username+"'");
                                while (db.next())
                                {
                                        count=db.getInt(1);
                                }
                    if(count<5){
                        falg=true;
                    }
                }  finally
                {
                        db.close();
                }
                return falg;
        }

    //	修改用户首选项
        public static boolean setOne(String id,String username) throws  SQLException
        {
                boolean falg=false;
                DbAdapter db = new DbAdapter();
                String sql="update consignee set state='0'  where state='1' and username='"+username+"'";
                try
                {
                        db.executeUpdate(sql);
                        db.executeUpdate("update consignee set state='1' where consigneeid="+id);
                        falg=true;
                } finally
                {
                        db.close();
                }
                return falg;
        }
    //删除一条收货地址记录
        public static boolean del(String id) throws SQLException
        {
                boolean falg=false;
                DbAdapter db = new DbAdapter();
                String sql="delete from consignee where consigneeid="+id;
                try
                {
                        db.executeUpdate(sql);
                        falg=true;
                }  finally
                {
                        db.close();
                }
                return falg;
        }


    //	获取用户
        public static ConsigneeAddress load(String id) throws SQLException
        {
                ConsigneeAddress cs=null;
                boolean falg=false;
                int count=0;
                DbAdapter db = new DbAdapter();
                String sql="select consigneeid,consignee,nowarea,streetaddress,postcode,homephone" +
         ",phone  from consignee where consigneeid="+id;
                try
                {
                        db.executeQuery(sql);
                                while (db.next())
                                {
                                        cs=new ConsigneeAddress();
                                        cs.setConsigneeid(db.getInt(1));
                                        cs.setConsignee(db.getString(2));
                                        cs.setNowarea(db.getString(3));
                                        cs.setStreetaddress(db.getString(4));
                                        cs.setPostcode(db.getString(5));
                                        cs.setHomephone(db.getString(6));
                                        cs.setPhone(db.getString(7));
                                }
                }finally
                {
                        db.close();
                }
                return cs;
        }

    //修改收货地址记录
        public static boolean set(String id,String consignee,
                        String nowarea, String streetaddress, String postcode,
                        String homephone, String phone)throws SQLException {

                boolean falg=false;
                String sql = "update consignee "
                            + "set consignee='"
                            +consignee
                                + "',nowarea='"
                                + nowarea
                                + "',streetaddress='"
                                + streetaddress
                                + "',postcode='"
                                + postcode
                                + "',homephone='"
                                + homephone
                                + "',phone='"
                                + phone + "'" +
                             " where consigneeid="+id;

                DbAdapter db = new DbAdapter();
                try {
                        db.executeUpdate(sql);
                        falg=true;
                } finally {
                        db.close();
                }
                return falg;
        }


    //	获取首选收货地址记录
        public static ConsigneeAddress loadFirst(String username) throws SQLException
        {
                ConsigneeAddress cs=null;
                boolean falg=false;
                int count=0;
                DbAdapter db = new DbAdapter();
                String sql="select consignee,nowarea,streetaddress,postcode,homephone,phone,state   from consignee where username='"+username+"' and state='1'";

                try
                {
                        db.executeQuery(sql);
                                if (db.next())
                                {
                                        cs=new ConsigneeAddress();
                                        cs.setConsignee(db.getString(1));
                                        cs.setNowarea(db.getString(2));
                                        cs.setStreetaddress(db.getString(3));
                                        cs.setPostcode(db.getString(4));
                                        cs.setHomephone(db.getString(5));
                                        cs.setPhone(db.getString(6));
                                        cs.setState(db.getString(7));

                                }
                } finally
                {
                        db.close();
                }
                return cs;
        }

        public String getConsignee() {
                return consignee;
        }

        public void setConsignee(String consignee) {
                this.consignee = consignee;
        }

        public int getConsigneeid() {
                return consigneeid;
        }

        public void setConsigneeid(int consigneeid) {
                this.consigneeid = consigneeid;
        }

        public String getHomephone() {
                return homephone;
        }

        public void setHomephone(String homephone) {
                this.homephone = homephone;
        }

        public String getNowarea() {
                return nowarea;
        }

        public void setNowarea(String nowarea) {
                this.nowarea = nowarea;
        }

        public String getPhone() {
                return phone;
        }

        public void setPhone(String phone) {
                this.phone = phone;
        }

        public String getPostcode() {
                return postcode;
        }

        public void setPostcode(String postcode) {
                this.postcode = postcode;
        }

        public String getState() {
                return state;
        }

        public void setState(String state) {
                this.state = state;
        }

        public String getStreetaddress() {
                return streetaddress;
        }

        public void setStreetaddress(String streetaddress) {
                this.streetaddress = streetaddress;
        }

        public String getUsername() {
                return username;
        }

        public void setUsername(String username) {
                this.username = username;
        }
        private int consigneeid;

        private String username;

        private String consignee;

        private String nowarea;

        private String streetaddress;

        private String postcode;

        private String homephone;

        private String phone;

        private String state;

}
