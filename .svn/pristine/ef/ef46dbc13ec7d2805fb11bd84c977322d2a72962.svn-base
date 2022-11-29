package tea.entity.taoism;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;


/**
 * 
 * @author:
 * @开发时间:2014-5-23
 * @描述:皈依弟子信息表
 */
public class Taoism {
	 private static Cache c = new Cache(50);
     public int id;
     /**系统编号*/
     public String sysId;
     /**姓名*/
     public String name;
     /**性别*/
     public int sex;
     /**出生年月*/
     public Date birthday;
     /**年龄*/
     public int age;
     /**名族*/
     public int ethnic;
     /**文化程度*/
     public int educ_lv;
     /**毕业院校*/
     public String school;
     /**所学专业*/
     public String professional;
     /**手机号*/
     public String mobile;
     /**Email*/
     public String email;
     /**QQ*/
     public int qq;
     /**身份证号*/
     public String idCard;
     /**微信号*/
     public String weixinId;
     /**户籍所在地*/
     public String huji_c;
     public String huji_p;
     public String huji_s;
     /**户籍所在地*/
     public String huji_address;
     /**居住地址*/
     public String live_c;
     public String live_p;
     public String live_s;
     /**居住地址*/
     public String live_address;
     /**通信地址*/
     public String communication_c;
     public String communication_p;
     public String communication_s;
     /**通信地址*/
     public String communication_address;
     /**创建时间*/
     public Date time;
     /**师父姓名*/
     public String master_name;
     /**电话*/
     public String phone;
     /**其他联系方式*/
     public String otherway;
     /**联系电话*/
     public String o_mobile;
     
     /**皈依证编号*/
     public String convertId;
     /**从事工作*/
     public String job;
     /**工作单位*/
     public String job_unit;
     /**皈依时间*/
     public String convert_time;
     /**皈依证颁发时间*/
     public String c_time;
     /**特长*/
     public String specialty;
     /**荣获证书*/
     public String certificate;
     /**荣获证书图片*/
     public String c_pic;
     /**教育及工作简历*/
     public String job_resume;
     /**宫观意见*/
     public String temples_opinion;
     /**推荐人*/
     public String t_name;
     /**推荐时间*/
     public String t_time;
     /**备注*/
     public String t_ramark;
     /**道协意见*/
     public String ass_opinion;
     /**推荐人*/
     public String a_name;
     /**推荐时间*/
     public String a_time;
     /**备注*/
     public String a_ramark;
     /**参加学习及培训情况*/
     public String situation;
     /**宫观参访记录*/
     public String g_content;
     /**慈善捐款情况*/
     public String c_content;
     /**学术文章*/
     public String x_content;
     /**法务流通情况*/
     public String f_content;
     /**咨询活动情况*/
     public String z_content;
     /**照片*/
     public String picture;
     public int deleted;
     public static String[] EDUC_LV={"----","博士","硕士","本科","大专","中专和中技","技工学校","高中","初中","小学","文盲","半文盲"};
     public static String[] ETHNIC={"----","汉族","壮族","满族","回族","苗族","维吾尔族","彝族","土家族","蒙古族","藏族","布依族","侗族","瑶族","朝鲜族","白族","哈尼族","黎族","哈萨克族","傣族","畲族","傈僳族","仡佬族","拉祜族","东乡族","佤族","水族","纳西族","羌族","土族","锡伯族","仫佬族","柯尔克孜族","达斡尔族","景颇族","撒拉族","布朗族","毛南族","塔吉克族","普米族","阿昌族","怒族","鄂温克族","京族","基诺族","德昂族","乌孜别克族","俄罗斯族","裕固族","保安族","门巴族","鄂伦春族","独龙族","塔塔尔族","赫哲族","高山族","珞巴族"};
     public Taoism(int id)
     {
         this.id = id;
     }

     public static Taoism find(int id) throws SQLException
     {
    	 Taoism t = (Taoism) c.get(id);
         if(t == null)
         {
             ArrayList al = find(" AND id=" + id,0,1);
             t = al.size() < 1 ? new Taoism(id) : (Taoism) al.get(0);
         }
         return t;
     }
     private static String tab(String sql)
     {
         StringBuilder sb = new StringBuilder();
         if(sql.contains(" AND n."))
             sb.append(" INNER JOIN id n ON n.id=tc.id");

         return sb.toString();
     }

     public static ArrayList find(String sql,int pos,int size) throws SQLException
     {
         ArrayList al = new ArrayList();
         DbAdapter db = new DbAdapter();
         try
         {
             java.sql.ResultSet rs = db.executeQuery("SELECT id,sysId,name,sex,birthday,age,ethnic,educ_lv,school,professional,mobile,email,qq,idCard,weixinId,huji_c,huji_p,huji_s,huji_address,live_c,live_p,live_s,live_address,communication_c,communication_p,communication_s,communication_address,time,master_name,phone,convertId,job,job_unit,convert_time,c_time,specialty,certificate,job_resume,temples_opinion,t_name,t_time,t_ramark,ass_opinion,a_name,a_time,a_ramark,situation,g_content,c_content,x_content,f_content,z_content,picture,otherway,o_mobile,c_pic,deleted FROM Taoism t  WHERE 1=1" + sql,pos,size);
             while(rs.next())
             {
                 int i = 1;
                 Taoism t = new Taoism(rs.getInt(i++));
                 t.sysId=rs.getString(i++);
                 t.name = rs.getString(i++);
                 t.sex = rs.getInt(i++);
                 t.birthday = rs.getDate(i++);
                 t.age=rs.getInt(i++);
                 t.ethnic = rs.getInt(i++);
                 t.educ_lv = rs.getInt(i++);
                 t.school = rs.getString(i++);
                 t.professional = rs.getString(i++);
                 t.mobile = rs.getString(i++);
                 t.email = rs.getString(i++);
                 t.qq = rs.getInt(i++);
                 t.idCard = rs.getString(i++);
                 t.weixinId = rs.getString(i++);
                 t.huji_c = rs.getString(i++);
                 t.huji_p = rs.getString(i++);
                 t.huji_s = rs.getString(i++);
                 t.huji_address = rs.getString(i++);
                 t.live_c=rs.getString(i++);
                 t.live_p=rs.getString(i++);
                 t.live_s=rs.getString(i++);
                 t.live_address = rs.getString(i++);
                 t.communication_c = rs.getString(i++);
                 t.communication_p = rs.getString(i++);
                 t.communication_s = rs.getString(i++);
                 t.communication_address = rs.getString(i++);
                 t.time=rs.getDate(i++);
                 t.master_name = rs.getString(i++);
                 t.phone = rs.getString(i++);
                 t.convertId = rs.getString(i++);
                 t.job = rs.getString(i++);
                 t.job_unit = rs.getString(i++);
                 t.convert_time = rs.getString(i++);
                 t.c_time = rs.getString(i++);
                 t.specialty = rs.getString(i++);
                 t.certificate = rs.getString(i++);
                 t.job_resume = rs.getString(i++);
                 t.temples_opinion = rs.getString(i++);
                 t.t_name = rs.getString(i++);
                 t.t_time = rs.getString(i++);
                 t.t_ramark = rs.getString(i++);
                 t.ass_opinion = rs.getString(i++);
                 t.a_name = rs.getString(i++);
                 t.a_time = rs.getString(i++);
                 t.a_ramark = rs.getString(i++);
                 t.situation = rs.getString(i++);
                 t.g_content = rs.getString(i++);
                 t.c_content = rs.getString(i++);
                 t.x_content = rs.getString(i++);
                 t.f_content = rs.getString(i++);
                 t.z_content = rs.getString(i++);
                 t.picture = rs.getString(i++);
                 t.otherway=rs.getString(i++);
                 t.o_mobile=rs.getString(i++);
                 t.c_pic=rs.getString(i++);
                 t.deleted = rs.getInt(i++);
                 
                 c.put(t.id,t);
                 al.add(t);
             }
             rs.close();
         } finally
         {
             db.close();
         }
         return al;
     }

     public static int count(String sql) throws SQLException
     {
         return DbAdapter.execute("SELECT COUNT(*) FROM Taoism t WHERE 1=1" + sql);
     }

     public void set() throws SQLException
     {
         DbAdapter db = new DbAdapter();
         try
         {
             int j = db.executeUpdate("INSERT INTO Taoism(id,sysId,name,sex,birthday,age,ethnic,educ_lv,school,professional,mobile,email,qq,idCard,weixinId,huji_c,huji_p,huji_s,huji_address,live_c,live_p,live_s,live_address,communication_c,communication_p,communication_s,communication_address,time,master_name,phone,convertId,job,job_unit,convert_time,c_time,specialty,certificate,job_resume,temples_opinion,t_name,t_time,t_ramark,ass_opinion,a_name,a_time,a_ramark,situation,g_content,c_content,x_content,f_content,z_content,picture,otherway,o_mobile,c_pic,deleted)" +
             		"VALUES(" + id + ","+DbAdapter.cite(sysId)+"," + DbAdapter.cite(name) + "," + sex + "," + DbAdapter.cite(birthday) + "," + age + "," + ethnic + "," + educ_lv + "," + DbAdapter.cite(school) + "," + DbAdapter.cite(professional) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," +qq + "," + DbAdapter.cite(idCard) + "," +  DbAdapter.cite(weixinId) + "," + DbAdapter.cite(huji_c)+ "," + DbAdapter.cite(huji_p)+ "," + DbAdapter.cite(huji_s) + "," +DbAdapter.cite(huji_address)+ "," +DbAdapter.cite(live_c)+ "," +DbAdapter.cite(live_p)+ "," +DbAdapter.cite(live_s)  + "," +DbAdapter.cite(live_address)+
             		"," +DbAdapter.cite(communication_c)  +"," +DbAdapter.cite(communication_p)  +"," +DbAdapter.cite(communication_s)  + "," + DbAdapter.cite(communication_address) + "," + DbAdapter.cite(time)+ "," + DbAdapter.cite(master_name)+ "," + DbAdapter.cite(phone)+ "," + DbAdapter.cite(convertId)+ "," + DbAdapter.cite(job)+ "," + DbAdapter.cite(job_unit)+ "," + DbAdapter.cite(convert_time)+ "," + DbAdapter.cite(c_time)+ "," + DbAdapter.cite(specialty)+ "," + DbAdapter.cite(certificate)+ "," + DbAdapter.cite(job_resume)+ "," + DbAdapter.cite(temples_opinion)+ "," + DbAdapter.cite(t_name)+ "," + DbAdapter.cite(t_time)+
             		"," + DbAdapter.cite(t_ramark) + "," + DbAdapter.cite(ass_opinion) + "," + DbAdapter.cite(a_name)+"," + DbAdapter.cite(a_time) + "," + DbAdapter.cite(a_ramark) + "," + DbAdapter.cite(situation)+"," + DbAdapter.cite(g_content) + "," + DbAdapter.cite(c_content) + "," + DbAdapter.cite(f_content)+"," + DbAdapter.cite(x_content) + "," + DbAdapter.cite(z_content) + "," + DbAdapter.cite(picture)+ "," + DbAdapter.cite(otherway)+ "," + DbAdapter.cite(o_mobile)+ "," + DbAdapter.cite(c_pic)+ "," + deleted+")");
             if(j < 1)
                 db.executeUpdate("UPDATE Taoism SET sysId ="+DbAdapter.cite(sysId)+",name=" + DbAdapter.cite(name) + ",sex=" + sex + ",birthday=" + DbAdapter.cite(birthday) + ",age=" + age + ",ethnic=" + ethnic + ",educ_lv=" + educ_lv + ",school=" + DbAdapter.cite(school) + ",professional=" + DbAdapter.cite(professional) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",qq=" + qq + ",idCard=" +  DbAdapter.cite(idCard) + ",weixinId=" + DbAdapter.cite(weixinId) + ",huji_c=" + DbAdapter.cite(huji_c)+ ",huji_p=" + DbAdapter.cite(huji_p)+ ",huji_s=" + DbAdapter.cite(huji_s) +
                	",huji_address=" + DbAdapter.cite(huji_address) + ",live_c=" + DbAdapter.cite(live_c)+ ",live_p=" + DbAdapter.cite(live_p)+ ",live_s=" + DbAdapter.cite(live_s)+ ",live_address=" + DbAdapter.cite(live_address)+ ",communication_c=" + DbAdapter.cite(communication_c)+ ",communication_p=" + DbAdapter.cite(communication_p)+ ",communication_s=" + DbAdapter.cite(communication_s)+ ",communication_address=" + DbAdapter.cite(communication_address)+ ",master_name=" + DbAdapter.cite(master_name)+ ",phone=" + DbAdapter.cite(phone)+ ",convertId=" + DbAdapter.cite(convertId)+ ",job=" + DbAdapter.cite(job)+ ",job_unit=" + DbAdapter.cite(job_unit)+ ",convert_time=" + DbAdapter.cite(convert_time)+ ",c_time=" + DbAdapter.cite(c_time)+ 
                	",specialty=" + DbAdapter.cite(specialty)+ ",certificate=" + DbAdapter.cite(certificate)+ ",job_resume=" + DbAdapter.cite(job_resume)+ ",temples_opinion=" + DbAdapter.cite(temples_opinion)+ ",t_name=" + DbAdapter.cite(t_name)+ ",t_time=" + DbAdapter.cite(t_time)+ ",t_ramark=" + DbAdapter.cite(t_ramark)+ ",ass_opinion=" + DbAdapter.cite(ass_opinion)+ ",a_name=" + DbAdapter.cite(a_name)+ ",a_time=" + DbAdapter.cite(a_time)+ ",a_ramark=" + DbAdapter.cite(a_ramark)+ 
                	",situation=" + DbAdapter.cite(situation)+ ",g_content=" + DbAdapter.cite(g_content)+ ",c_content=" + DbAdapter.cite(c_content)+ ",f_content=" + DbAdapter.cite(f_content)+ ",x_content=" + DbAdapter.cite(x_content)+ ",z_content=" + DbAdapter.cite(z_content)+ ",picture=" + DbAdapter.cite(picture)+ ",otherway=" + DbAdapter.cite(otherway)+ ",o_mobile=" + DbAdapter.cite(o_mobile)+ ",c_pic=" + DbAdapter.cite(c_pic) + ",deleted=" + deleted + " WHERE id=" + id);
         } finally
         {
         	c.remove(id);
             db.close();
         }

     }

     public void delete() throws SQLException
     {
         DbAdapter.execute("UPDATE Taoism SET deleted=1 WHERE id=" + id);
         c.remove(id);
     }

     public void set(String f,String v) throws SQLException
     {
         DbAdapter.execute("UPDATE Taoism SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
         c.remove(id);
     }
     
     
     
}
