package tea.entity.admin.orthonline;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.io.*;

public class Doctor extends Entity
{
    private int doctorid; //主键id
    private String xingming; //姓名
    private String xingbie; //性别
    private String youxiaozhengjian; //有效证件
    private String youxiaozhengjianhao; //有效证件号码
    private Date chushengnianyue; //出生年月
    private String gerenzhaopianname; //个人照片名称
    private String gerenzhaopianpath; //个人照片地址
    private String yszigezheng; //医师资格证
    private Date yszigezhengtime; //获取时间---医师资格证
    private String yszhiyezheng; //医师执业证
    private Date yszhiyezhengtime; //获取时间---医师执业证
    private int jishuzhicheng1; //技术职称 1
    private int jishuzhicheng2; //技术职称 2
    private int jishuzhicheng3; //技术职称 3
    private int xingzhengzhicheng; //现任行政职务1
    private int xingzhengzhicheng2; //现任行政职务2
    private int sheng; //所属省份
    private int shi; //市（县）
    private int gongzuodanwei; //工作单位
    private String gongzuodanwei2; //请您填写您的单位名称:
    private String yyjibie; //医院级别
    private String yyxingzhi; //医院性质
    private String suoshukeshi; //所属科室
    private String danweidizhi; //单位地址
    private String youbian; //邮编编码
    private String danweidianhua; //单位电话1
    private String danweidianhua2; //单位电话2
    private String shoujihao; //手 机 号
    private String email; //Email地址1
    private String email2; //Email地址2
    private int zhuanyefangxiang1; //专业方向 第一专业
    private int zhuanyefangxiang2; //专业方向  第二专业
    private int zhuanyefangxiang3; //专业方向 第三专业
	private String zyfx1;// 专业方向的--其他1
	private String zyfx2;// 专业方向的--其他2
	private String zyfx3;// 专业方向的--其他3
    private String biyeyuanxiao1; //毕业院校名称--国内
    private String biyeyuanxiao2; //毕业院校名称--国外
    private Date biyeshijian1; //毕业或肄业时间--国内
    private Date biyeshijian2; //毕业或肄业时间--国外
    private String zuigaoxuewei1; //最高学位--国内
    private String zuigaoxuewei2; //最高学位--国外
    private String zuigaoxueli1; //最高学历--国内
    private String zuigaoxueli2; //最高学历--国外
    private String gerenjianli; //个人简历(从参加工作起)
    private String jizhiqingkuang; //学会或社会兼职情况
    private String community; //社区
    private Date times; //添加时间

	private int gongzuodanwei2s;
    private boolean exists;
	                                                // 院士、 主任医师、副主任医师、主治医师、住院医师、教授、副教授、讲师、助教、 研究员、副研究员、助理研究员、实习研究员、高级技师、技师、技术员。
	public static final String JISHU_ZHICHENG[]={"","院士","主任医师","副主任医师","主治医师","住院医师","教授","副教授","讲师","助教","研究员","副研究员","助理研究员","实习研究员","高级技师","技师","技术员"};//技术职称
    public static final String XINGZHENG_ZHICHENG[]={"","院长","副院长","外科主任","外科副主任","骨科主任","骨科副主任","校长","副校长"};
	public static final String ZHUANYE_FANGXIANG[] ={"","脊柱外科","关节外科","骨创伤","骨肿瘤","足踝外科","骨质疏松","关节镜","大骨科","小儿骨科","运动医学","基础研究","中医骨科","中西医结合","其他"};//专业方向



    public Doctor(int doctorid) throws SQLException
    {
        this.doctorid = doctorid;
        load();
    }

    public static Doctor find(int doctorid) throws SQLException
    {
        return new Doctor(doctorid);
    }

    public static Doctor find(String xingming,String zhengjianhao) throws SQLException
    {  int  doctorid=0;

    StringBuilder sb = new StringBuilder();
    sb.append("SELECT doctorid from doctor  WHERE xingming=");
    sb.append(DbAdapter.cite(xingming));
    sb.append("AND youxiaozhengjianhao=").append(DbAdapter.cite(zhengjianhao));
    DbAdapter db = new DbAdapter(1);
    try
    {
        db.executeQuery(sb.toString());
        if(db.next())
        {
        	doctorid=db.getInt(1);
        }
    } finally
    {
        db.close();
    }
        return new Doctor(doctorid);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT xingming, xingbie, youxiaozhengjian, youxiaozhengjianhao, chushengnianyue, gerenzhaopianname, " +
                            " gerenzhaopianpath, yszigezheng, yszigezhengtime,yszhiyezheng, yszhiyezhengtime,jishuzhicheng1, xingzhengzhicheng, " +
                            " sheng,shi,gongzuodanwei, gongzuodanwei2, yyjibie, yyxingzhi, suoshukeshi,danweidizhi,youbian,danweidianhua,shoujihao," +
                            " email,zhuanyefangxiang1,zhuanyefangxiang2,zhuanyefangxiang3,biyeyuanxiao1,biyeyuanxiao2,biyeshijian1,biyeshijian2,zuigaoxuewei1," +
                            " zuigaoxuewei2,zuigaoxueli1,zuigaoxueli2,gerenjianli,jizhiqingkuang,community,times,gongzuodanwei2s,jishuzhicheng2,jishuzhicheng3,"+
						   "  xingzhengzhicheng2,danweidianhua2,email2,zyfx1,zyfx2,zyfx3,doctorid FROM Doctor WHERE doctorid =" + doctorid);
            if(db.next())
            {
                 xingming = db.getString(1);
                 xingbie = db.getString(2);
                 youxiaozhengjian = db.getString(3);
                 youxiaozhengjianhao = db.getString(4);
                 chushengnianyue = db.getDate(5);
                 gerenzhaopianname = db.getString(6);
                 gerenzhaopianpath = db.getString(7);
                 yszigezheng = db.getString(8);
                 yszigezhengtime = db.getDate(9);
                 yszhiyezheng = db.getString(10);
                 yszhiyezhengtime = db.getDate(11);
                 jishuzhicheng1 = db.getInt(12);
                 xingzhengzhicheng = db.getInt(13);
                 sheng = db.getInt(14);
                 shi = db.getInt(15);
                 gongzuodanwei = db.getInt(16);
                 gongzuodanwei2 = db.getString(17);
                 yyjibie = db.getString(18);
                 yyxingzhi = db.getString(19);
                 suoshukeshi = db.getString(20);
                 danweidizhi = db.getString(21);
                 youbian = db.getString(22);
                 danweidianhua = db.getString(23);
                 shoujihao = db.getString(24);
                 email = db.getString(25);
                 zhuanyefangxiang1 = db.getInt(26);
                 zhuanyefangxiang2 = db.getInt(27);
                 zhuanyefangxiang3 = db.getInt(28);
                 biyeyuanxiao1 = db.getString(29);
                 biyeyuanxiao2 = db.getString(30);
                 biyeshijian1 = db.getDate(31);
                 biyeshijian2 = db.getDate(32);
                 zuigaoxuewei1 = db.getString(33);
                 zuigaoxuewei2 = db.getString(34);
                 zuigaoxueli1 = db.getString(35);
                 zuigaoxueli2 = db.getString(36);
                 gerenjianli = db.getText(37);
                 jizhiqingkuang = db.getText(38);
                 community = db.getString(39);
                 times = db.getDate(40);
				 gongzuodanwei2s=db.getInt(41);
				 jishuzhicheng2=db.getInt(42);
				 jishuzhicheng3=db.getInt(43);
				 xingzhengzhicheng2=db.getInt(44);
				 danweidianhua2=db.getString(45);
				 email2=db.getString(46);
				 zyfx1=db.getString(47);
				 zyfx2=db.getString(48);
				 zyfx3=db.getString(49);
				 doctorid=db.getInt(50);
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

    public static int create(String xingming,String xingbie,String youxiaozhengjian,String youxiaozhengjianhao,Date chushengnianyue,String gerenzhaopianname,String gerenzhaopianpath,
                              String yszigezheng,Date yszigezhengtime,String yszhiyezheng,Date yszhiyezhengtime,int jishuzhicheng1,int xingzhengzhicheng,int sheng,int shi,int gongzuodanwei,
                              String gongzuodanwei2,String yyjibie,String yyxingzhi,String suoshukeshi,String danweidizhi,String youbian,String danweidianhua,String shoujihao,String email,
                              int zhuanyefangxiang1,int zhuanyefangxiang2,int zhuanyefangxiang3,String biyeyuanxiao1,String biyeyuanxiao2,Date biyeshijian1,Date biyeshijian2,String zuigaoxuewei1,
                              String zuigaoxuewei2,String zuigaoxueli1,String zuigaoxueli2,String gerenjianli,String jizhiqingkuang,String community,int gongzuodanwei2s,
			 int jishuzhicheng2,int jishuzhicheng3,int xingzhengzhicheng2,String danweidianhua2,String email2,String zyfx1,String zyfx2,String zyfx3,Date times) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        //Date times = new Date();
		int i = 0;
        try
        {
       
        	
            db.executeUpdate("INSERT INTO Doctor (xingming, xingbie, youxiaozhengjian, youxiaozhengjianhao, chushengnianyue, gerenzhaopianname," +
                             " gerenzhaopianpath, yszigezheng, yszigezhengtime,yszhiyezheng, yszhiyezhengtime,jishuzhicheng1, xingzhengzhicheng, " +
                             " sheng,shi,gongzuodanwei, gongzuodanwei2, yyjibie, yyxingzhi, suoshukeshi,danweidizhi,youbian,danweidianhua,shoujihao," +
                             " email,zhuanyefangxiang1,zhuanyefangxiang2,zhuanyefangxiang3,biyeyuanxiao1,biyeyuanxiao2,biyeshijian1,biyeshijian2,zuigaoxuewei1," +
                             " zuigaoxuewei2,zuigaoxueli1,zuigaoxueli2,gerenjianli,jizhiqingkuang,community,times,gongzuodanwei2s,jishuzhicheng2,jishuzhicheng3,xingzhengzhicheng2,danweidianhua2,email2,"+
					         " zyfx1,zyfx2,zyfx3) " +
                             "VALUES (" + db.cite(xingming) + "," + db.cite(xingbie) + "," + db.cite(youxiaozhengjian) + "," + db.cite(youxiaozhengjianhao) + "," + db.cite(chushengnianyue) + "," + db.cite(gerenzhaopianname) + "," + db.cite(gerenzhaopianpath) + "," +
                             " " + db.cite(yszigezheng) + " ," + db.cite(yszigezhengtime) + "," + db.cite(yszhiyezheng) + "," + db.cite(yszhiyezhengtime) + "," + (jishuzhicheng1) + "," + xingzhengzhicheng + "," + sheng + "," + shi + "," +
                             " " + (gongzuodanwei) + " ," + db.cite(gongzuodanwei2) + "," + db.cite(yyjibie) + "," + db.cite(yyxingzhi) + "," + db.cite(suoshukeshi) + "," + db.cite(danweidizhi) + "," + db.cite(youbian) + "," + db.cite(danweidianhua) + "," +
                             " " + db.cite(shoujihao) + " ," + db.cite(email) + "," + zhuanyefangxiang1 + "," + zhuanyefangxiang2 + "," + zhuanyefangxiang3 + "," + db.cite(biyeyuanxiao1) + "," + db.cite(biyeyuanxiao2) + "," + db.cite(biyeshijian1) + "," +
                             " " + db.cite(biyeshijian2) + " ," + db.cite(zuigaoxuewei1) + "," + db.cite(zuigaoxuewei2) + "," + db.cite(zuigaoxueli1) + "," + db.cite(zuigaoxueli2) + "," + db.cite(gerenjianli) + "," + db.cite(jizhiqingkuang) + "," + db.cite(community) + "," +
                             " " + db.cite(times) + ", "+gongzuodanwei2s+","+jishuzhicheng2+","+jishuzhicheng3+","+xingzhengzhicheng2+","+db.cite(danweidianhua2)+","+db.cite(email2)+" ,"+db.cite(zyfx1)+","+db.cite(zyfx2)+","+db.cite(zyfx3)+" " +
                             "  )");
			  i = db.getInt("SELECT MAX(doctorid) FROM Doctor");
        } finally
        {
            db.close();
        }
		return i;
    }
	public static int create(String xingming,String xingbie,String youxiaozhengjian,String youxiaozhengjianhao,Date chushengnianyue,String gerenzhaopianname,String gerenzhaopianpath,
								 String yszigezheng,Date yszigezhengtime,String yszhiyezheng,Date yszhiyezhengtime,int jishuzhicheng1,int xingzhengzhicheng,int sheng,int shi,int gongzuodanwei,
								 String gongzuodanwei2,String yyjibie,String yyxingzhi,String suoshukeshi,String danweidizhi,String youbian,String danweidianhua,String shoujihao,String email,
								 int zhuanyefangxiang1,int zhuanyefangxiang2,int zhuanyefangxiang3,String biyeyuanxiao1,String biyeyuanxiao2,Date biyeshijian1,Date biyeshijian2,String zuigaoxuewei1,
								 String zuigaoxuewei2,String zuigaoxueli1,String zuigaoxueli2,String gerenjianli,String jizhiqingkuang,String community,int gongzuodanwei2s,
				int jishuzhicheng2,int jishuzhicheng3,int xingzhengzhicheng2,String danweidianhua2,String email2,String zyfx1,String zyfx2,String zyfx3) throws SQLException
	   {
		   DbAdapter db = new DbAdapter();
		   Date times = new Date();
		   int i = 0;
		   try
		   {
			   db.executeUpdate("INSERT INTO Doctor (xingming, xingbie, youxiaozhengjian, youxiaozhengjianhao, chushengnianyue, gerenzhaopianname," +
								" gerenzhaopianpath, yszigezheng, yszigezhengtime,yszhiyezheng, yszhiyezhengtime,jishuzhicheng1, xingzhengzhicheng, " +
								" sheng,shi,gongzuodanwei, gongzuodanwei2, yyjibie, yyxingzhi, suoshukeshi,danweidizhi,youbian,danweidianhua,shoujihao," +
								" email,zhuanyefangxiang1,zhuanyefangxiang2,zhuanyefangxiang3,biyeyuanxiao1,biyeyuanxiao2,biyeshijian1,biyeshijian2,zuigaoxuewei1," +
								" zuigaoxuewei2,zuigaoxueli1,zuigaoxueli2,gerenjianli,jizhiqingkuang,community,times,gongzuodanwei2s,jishuzhicheng2,jishuzhicheng3,xingzhengzhicheng2,danweidianhua2,email2,"+
								" zyfx1,zyfx2,zyfx3) " +
								"VALUES (" + db.cite(xingming) + "," + db.cite(xingbie) + "," + db.cite(youxiaozhengjian) + "," + db.cite(youxiaozhengjianhao) + "," + db.cite(chushengnianyue) + "," + db.cite(gerenzhaopianname) + "," + db.cite(gerenzhaopianpath) + "," +
								" " + db.cite(yszigezheng) + " ," + db.cite(yszigezhengtime) + "," + db.cite(yszhiyezheng) + "," + db.cite(yszhiyezhengtime) + "," + (jishuzhicheng1) + "," + xingzhengzhicheng + "," + sheng + "," + shi + "," +
								" " + (gongzuodanwei) + " ," + db.cite(gongzuodanwei2) + "," + db.cite(yyjibie) + "," + db.cite(yyxingzhi) + "," + db.cite(suoshukeshi) + "," + db.cite(danweidizhi) + "," + db.cite(youbian) + "," + db.cite(danweidianhua) + "," +
								" " + db.cite(shoujihao) + " ," + db.cite(email) + "," + zhuanyefangxiang1 + "," + zhuanyefangxiang2 + "," + zhuanyefangxiang3 + "," + db.cite(biyeyuanxiao1) + "," + db.cite(biyeyuanxiao2) + "," + db.cite(biyeshijian1) + "," +
								" " + db.cite(biyeshijian2) + " ," + db.cite(zuigaoxuewei1) + "," + db.cite(zuigaoxuewei2) + "," + db.cite(zuigaoxueli1) + "," + db.cite(zuigaoxueli2) + "," + db.cite(gerenjianli) + "," + db.cite(jizhiqingkuang) + "," + db.cite(community) + "," +
								" " + db.cite(times) + ", "+gongzuodanwei2s+","+jishuzhicheng2+","+jishuzhicheng3+","+xingzhengzhicheng2+","+db.cite(danweidianhua2)+","+db.cite(email2)+" ,"+db.cite(zyfx1)+","+db.cite(zyfx2)+","+db.cite(zyfx3)+" " +
								"  )");
				 i = db.getInt("SELECT MAX(doctorid) FROM Doctor");
		   } finally
		   {
			   db.close();
		   }
		   return i;
    }
    public void set(String xingming,String xingbie,String youxiaozhengjian,String youxiaozhengjianhao,Date chushengnianyue,String gerenzhaopianname,String gerenzhaopianpath,
                    String yszigezheng,Date yszigezhengtime,String yszhiyezheng,Date yszhiyezhengtime,int jishuzhicheng1,int xingzhengzhicheng,int sheng,int shi,int gongzuodanwei,
                    String gongzuodanwei2,String yyjibie,String yyxingzhi,String suoshukeshi,String danweidizhi,String youbian,String danweidianhua,String shoujihao,String email,
                    int zhuanyefangxiang1,int zhuanyefangxiang2,int zhuanyefangxiang3,String biyeyuanxiao1,String biyeyuanxiao2,Date biyeshijian1,Date biyeshijian2,String zuigaoxuewei1,
                    String zuigaoxuewei2,String zuigaoxueli1,String zuigaoxueli2,String gerenjianli,String jizhiqingkuang,int gongzuodanwei2s,int jishuzhicheng2,int jishuzhicheng3,int xingzhengzhicheng2,
			        String danweidianhua2,String email2,String zyfx1,String zyfx2,String zyfx3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Doctor SET xingming=" + db.cite(xingming) + ",xingbie=" + db.cite(xingbie) + ",youxiaozhengjian=" + db.cite(youxiaozhengjian) + ",youxiaozhengjianhao=" + db.cite(youxiaozhengjianhao) + "," +
                             " chushengnianyue=" + db.cite(chushengnianyue) + ",gerenzhaopianname=" + db.cite(gerenzhaopianname) + ",gerenzhaopianpath=" + db.cite(gerenzhaopianpath) + ",yszigezheng=" + db.cite(yszigezheng) + ",yszigezhengtime=" + db.cite(yszigezhengtime) + "," +
                             " yszhiyezheng=" + db.cite(yszhiyezheng) + ",yszhiyezhengtime=" + db.cite(yszhiyezhengtime) + ",jishuzhicheng1=" + (jishuzhicheng1) + ",xingzhengzhicheng=" + xingzhengzhicheng + ",sheng=" + sheng + "," +
                             " shi=" + shi + ",gongzuodanwei=" + (gongzuodanwei) + ",gongzuodanwei2=" + db.cite(gongzuodanwei2) + ",yyjibie=" + db.cite(yyjibie) + ",yyxingzhi=" + db.cite(yyxingzhi) + "," +
                             " suoshukeshi=" + db.cite(suoshukeshi) + ",danweidizhi=" + db.cite(danweidizhi) + ",youbian=" + db.cite(youbian) + ",danweidianhua=" + db.cite(danweidianhua) + ",shoujihao=" + db.cite(shoujihao) + "," +
                             " email=" + db.cite(email) + ",zhuanyefangxiang1=" + zhuanyefangxiang1 + ",zhuanyefangxiang2=" + zhuanyefangxiang2 + ",zhuanyefangxiang3=" + zhuanyefangxiang3 + ",biyeyuanxiao1=" + db.cite(biyeyuanxiao1) + "," +
                             " biyeyuanxiao2=" + db.cite(biyeyuanxiao2) + ",biyeshijian1=" + db.cite(biyeshijian1) + ",biyeshijian2=" + db.cite(biyeshijian2) + ",zuigaoxuewei1=" + db.cite(zuigaoxuewei1) + ",zuigaoxuewei2=" + db.cite(zuigaoxuewei2) + "," +
                             " zuigaoxueli1=" + db.cite(zuigaoxueli1) + ",zuigaoxueli2=" + db.cite(zuigaoxueli2) + " ,gerenjianli=" + db.cite(gerenjianli) + ",jizhiqingkuang=" + db.cite(jizhiqingkuang) + ",community=" + db.cite(community) + "  , " +
                             " gongzuodanwei2s="+gongzuodanwei2s+",jishuzhicheng2="+jishuzhicheng2+",jishuzhicheng3="+jishuzhicheng3+",xingzhengzhicheng2="+xingzhengzhicheng2+",danweidianhua2="+db.cite(danweidianhua2)+" ,"+
							" email2="+db.cite(email2)+",zyfx1="+db.cite(zyfx1)+",zyfx2="+db.cite(zyfx2)+",zyfx3="+db.cite(zyfx3)+" WHERE doctorid = " + doctorid);
        } finally
        {
            db.close();
        }
    }
    public static boolean isExist(String xingming,String youxiaozhengjianhao) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * from doctor  WHERE xingming=");
        sb.append(DbAdapter.cite(xingming));
        sb.append("AND youxiaozhengjianhao=").append(DbAdapter.cite(youxiaozhengjianhao));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

	public static boolean isExist(String xingming,String youxiaozhengjianhao,String sql) throws SQLException
	   {
		   boolean flag = false;
		   StringBuilder sb = new StringBuilder();
		   sb.append("SELECT * from doctor  WHERE xingming=");
		   sb.append(DbAdapter.cite(xingming));
		   sb.append("AND youxiaozhengjianhao=").append(DbAdapter.cite(youxiaozhengjianhao));
		   sb.append(sql);
		   DbAdapter db = new DbAdapter(1);
		   try
		   {
			   db.executeQuery(sb.toString());
			   flag = db.next();
		   } finally
		   {
			   db.close();
		   }
		   return flag;
    }
    public static boolean isExist(String id,int i) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * from doctor  WHERE ");
       if (i==0)
        sb.append(" xingming=").append(DbAdapter.cite(id));
       else
    	sb.append(" youxiaozhengjianhao=").append(DbAdapter.cite(id));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }
	public void setBirthdaylog(Date chushengnianyue)throws SQLException
	{
		DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Doctor SET birthdaylog = 1 WHERE chushengnianyue="+DbAdapter.cite(chushengnianyue));
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }

	}

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT doctorid FROM Doctor WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Doctor WHERE doctorid = " + doctorid);

        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(doctorid) FROM Doctor  WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }
	//统计医院
    public static int countHospital(String community,String sql) throws SQLException
    {
        int count = 0,count2=0;
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        try
        {
            db.executeQuery("select gongzuodanwei,gongzuodanwei2,gongzuodanwei2s from Doctor  WHERE community=" + db.cite(community) + sql);
            while(db.next())
            {
                if(db.getInt(3) == 1) //说明是填写的医院
                {
					db2.executeQuery("select count(gongzuodanwei2) from  Doctor where  gongzuodanwei2 ="+db.cite(db.getString(2)));
					if(db2.next())
					{
						count = count+1;
					}
                }else
				{
					db3.executeQuery("select count(gongzuodanwei) from  Doctor where  gongzuodanwei ="+db.getInt(1));
					if(db3.next())
					{
						count2 =count2+ 1;
					}
				}
            }

        } finally
        {
            db.close();
            db2.close();
            db3.close();
        }
        return count+count2;
    }
//显示医院
	public static String countHospitalString(String community,String sql) throws SQLException
   {
	   StringBuffer sp = new  StringBuffer();
	   DbAdapter db = new DbAdapter();
	    DbAdapter db2 = new DbAdapter();
	   int count = 0;
	   try
	   {
           db.executeQuery("select gongzuodanwei,gongzuodanwei2,gongzuodanwei2s from Doctor  WHERE community=" + db.cite(community) + sql);
           db2.executeQuery("select count(*) from Doctor  WHERE community=" + db.cite(community) + sql);
			if(db2.next())
			{
			   count= db2.getInt(1);
			}
			if(count>0)
			{
				  sp.append(" AND ( ");
			}


		   int i = 1;
		   while(db.next())
		   {

			   if(db.getInt(3) == 1) //说明是填写的医院
			   {
			       sp.append(" gongzuodanwei2 = ").append(db.cite(db.getString(2)) );
			   }else
			   {
				  // Hospital hobj = Hospital.find(db.getInt(1));
				   sp.append(" gongzuodanwei =").append(db.getInt(1));
			   }
			   if(count>i)
			   {
				   sp.append(" or ");
			   }
			   i++;
		   }

		   if(count>0)
		   {
		   sp.append(")");
		   }
	   } finally
	   {
		   db.close();
		   db2.close();

	   }
	   return sp.toString();
   }

	//获取城市统计
    public static String getArrsheng(String community,String member,int type,String sql,String param,int sheng,int shi) throws SQLException
    {
		//type :按省市 1,医院级别 2,技术职称 3,专业方向 4
        String nexturl ="/jsp/admin/orthonline/Statistics.jsp?community=" + community+param;
        DbAdapter db = new DbAdapter();
		DbAdapter db2 = new DbAdapter();
        StringBuffer sp = new StringBuffer();
        Doctoradmin daobj = Doctoradmin.find(Doctoradmin.isMemberDaid(community,member));
        StringBuffer sp1 = new StringBuffer();
        StringBuffer sp2 = new StringBuffer(); //医院级别
        StringBuffer sp3 = new StringBuffer(); //
        if(daobj.getSheng() > 0) //说明是省级
        {
			sp1.append(" AND sheng = ").append(daobj.getSheng());
        }
        if(daobj.getShi()>0)
		{
			sp1.append(" AND shi = ").append(daobj.getShi());
		}
        if(daobj.getYiyuan() > 0) //说明是选中的医院
        {
		   if(Doctor.isGongzudanwei(community,daobj.getYiyuan()))//如果医生表中是选中的
		   {
			   sp1.append(" AND gongzuodanwei=").append(daobj.getYiyuan());
		   }else// 填写的
		   {
			  Hospital hobj = Hospital.find(daobj.getYiyuan());
			   sp1.append(" AND gongzuodanwei2 = ").append(DbAdapter.cite(hobj.getHoname().trim()));
		   }
        }

        try
        {
            if(type == 1)
            { //按省
                if(sheng > 0)
                { //查找省份
                    if(shi > 0)
                    { //显示医院
                        Provinces pobj12 = Provinces.find(sheng);
                        Provinces pobj123 = Provinces.find(shi);
                        sp.append("<span id=xlclass ><a href=" + nexturl + "&sheng=" + sheng + ">" + pobj12.getProvincity() + "</a>&nbsp;<a href=" + nexturl + "&sheng=" + sheng + "&shi=" + shi + ">" + pobj123.getProvincity() + "</a></span>:" + Doctor.countHospital(community,sql) + "<span id=xlfd></span>");

                        db2.executeQuery("select  gongzuodanwei,gongzuodanwei2,count(*) as a from Doctor where community=" + db.cite(community) + sp1 + sql + Doctor.countHospitalString(community,sql) + " group by gongzuodanwei2,gongzuodanwei  order by a desc");
                       // System.out.println("select  gongzuodanwei,gongzuodanwei2,count(*) as a from Doctor where community=" + db.cite(community) + sp1 + sql + Doctor.countHospitalString(community,sql) + " group by gongzuodanwei2,gongzuodanwei  order by a desc");
                        while(db2.next())
                        {
                            if(db2.getInt(1) > 0 && db2.getString(2) != null)
                            {
                                Hospital hobj = Hospital.find(db2.getInt(1));
                                try
                                {
                                    sp.append("<span id=xiaosheng2><a href=/jsp/admin/orthonline/doctor.jsp?community=" + community + param + "&gongzuodanwei=" + java.net.URLEncoder.encode(hobj.getHoname(),"UTF-8") + ">" + hobj.getHoname() + "</a></span>:" + db2.getInt(3) + "<span id=xlfd></span>");
                              //  System.out.println(db2.getInt(1)+":"+hobj.getHoname());
								} catch(SQLException ex1)
                                {
                                } catch(UnsupportedEncodingException ex1)
                                {
                                }
                            } else
                            {
                                try
                                {
                                    sp.append("<span id=xiaosheng2><a href=/jsp/admin/orthonline/doctor.jsp?community=" + community + param + "&gongzuodanwei=" + java.net.URLEncoder.encode(db2.getString(2),"UTF-8") + ">" + db2.getString(2) + "</a></span>:" + db2.getInt(3) + "<span id=xlfd></span>");
                                } catch(SQLException ex2)
                                {
                                } catch(UnsupportedEncodingException ex2)
                                {
                                }
                            }
                        }

                    } else
                    { //显示市区
                        Provinces pobj2 = Provinces.find(sheng);
                        sp.append("<span id=xlclass><a href=" + nexturl + "&sheng=" + sheng + ">" + pobj2.getProvincity() + "</a></span>:" + Doctor.count(community,sql) + "<span id=xlfd></span>");
                        db.executeQuery("SELECT shi,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql + " group by shi order by s desc ");
                        while(db.next())
                        {
                            Provinces pobj = Provinces.find(db.getInt(1));
                            if(db.getInt(1) > 0)
                            {
                                sp.append("<span id=xiaosheng1><a href=" + nexturl + "&sheng=" + sheng + "&shi=" + db.getInt(1) + ">" + pobj.getProvincity() + "</a></span>:" + db.getInt(2) + "<span id=xlfd></span>");
                            }
                        }
                    }
                } else //默认显示所有省份
				{
					db.executeQuery("SELECT sheng,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql + " group by sheng order by s desc ");
				   while(db.next())
				   {
					   Provinces pobj = Provinces.find(db.getInt(1));
					   if(db.getInt(1) > 0)
					   {
						   sp.append("<span id=xiaosheng1><a href="+nexturl+"&sheng=" + db.getInt(1) + ">" + pobj.getProvincity() + "</a></span>:" + db.getInt(2) + "<span id=xlfd></span>");
					   }
				   }

				}
            }else if(type==2)//医院级别
			{
                db.executeQuery("SELECT yyjibie,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql +" group by yyjibie order by s desc ");
                while(db.next())
                {
					if(db.getInt(2)>0){
                        try
                        {
                            sp.append("<span id=xiaosheng><a href=" + nexturl + "&yyjibie=" + java.net.URLEncoder.encode(db.getString(1),"UTF-8") + ">" + db.getString(1) + "</a>:</span>" + db.getInt(2) + "<br>");
                        } catch(SQLException ex)
                        {
                        } catch(UnsupportedEncodingException ex)
                        {
                        }
                    }
                }

			}else if (type ==3)//技术职称1
			{
				db.executeQuery("SELECT jishuzhicheng1,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql+ " group by jishuzhicheng1 order by s desc ");
				//System.out.println("SELECT jishuzhicheng1,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql+sql2 + " group by jishuzhicheng1 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
                        sp.append("<span id=xiaosheng><a href="+nexturl+"&jishuzhicheng1="+db.getInt(1)+">" + Doctor.JISHU_ZHICHENG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
                    }
				}

			}
			else if (type ==4)//技术职称2
			{
				db.executeQuery("SELECT jishuzhicheng2,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 +sql+ " group by jishuzhicheng2 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
                        sp.append("<span id=xiaosheng><a href="+nexturl+"&jishuzhicheng2="+db.getInt(1)+">" + Doctor.JISHU_ZHICHENG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
                    }
				}

			}else if (type ==5)//技术职称3
			{
				db.executeQuery("SELECT jishuzhicheng3,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1+sql+ " group by jishuzhicheng3 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
                        sp.append("<span id=xiaosheng><a href="+nexturl+"&jishuzhicheng3="+db.getInt(1)+">" + Doctor.JISHU_ZHICHENG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
                    }
				}

			}else if (type ==6)// 专业1
			{
				db.executeQuery("SELECT zhuanyefangxiang1,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 +sql+ " group by zhuanyefangxiang1 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
						sp.append("<span id=xiaosheng><a href="+nexturl+"&zhuanyefangxiang1="+db.getInt(1)+">" + Doctor.ZHUANYE_FANGXIANG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
					}
				}

			}else if (type ==7)// 专业2
			{
				db.executeQuery("SELECT zhuanyefangxiang2,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 +sql+ " group by zhuanyefangxiang2 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
						sp.append("<span id=xiaosheng><a href="+nexturl+"&zhuanyefangxiang2="+db.getInt(1)+">" + Doctor.ZHUANYE_FANGXIANG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
					}
				}

			}
			else if (type ==8)// 专业3
			{
				db.executeQuery("SELECT zhuanyefangxiang3,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql+" group by zhuanyefangxiang3 order by s desc ");
				while(db.next())
				{
					if(db.getInt(1)>0&&db.getInt(2)>0){
						sp.append("<span id=xiaosheng><a href="+nexturl+"&zhuanyefangxiang3="+db.getInt(1)+">" + Doctor.ZHUANYE_FANGXIANG[db.getInt(1)] + "</a>:</span>" + db.getInt(2) + "<br>");
					}
				}
			}else if(type == 9)//医院性质
			{
                db.executeQuery("SELECT yyxingzhi,count(*) as s FROM Doctor  WHERE community=" + db.cite(community) + sp1 + sql + " group by yyxingzhi order by s desc ");
                while(db.next())
                {
                    if(db.getString(1)!=null&&db.getString(1).length()>0&&db.getInt(2) > 0)
                    {
                        try
                        {
                            sp.append("<span id=xiaosheng><a href=" + nexturl + "&yyxingzhi=" + java.net.URLEncoder.encode(db.getString(1),"UTF-8") + ">" + db.getString(1) + "</a>:</span>" + db.getInt(2) + "<br>");
                        } catch(SQLException ex)
                        {
                        } catch(UnsupportedEncodingException ex)
                        {
                        }
                    }
                }
			}





        } finally
        {
            db.close();
			db2.close();
        }
        return sp.toString();
    }

//判断是否有重复的有效证件号
    public static boolean isZJ(String community,String zj) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT doctorid FROM Doctor  WHERE community=" + db.cite(community) + " AND youxiaozhengjianhao =" + db.cite(zj));
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
	//去除重复
    public static int getZJ(String community,String zj) throws SQLException
    {
        int f = 0;
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("SELECT doctorid FROM Doctor  WHERE community=" + db.cite(community) + " AND youxiaozhengjianhao =" + db.cite(zj));
            if(db.next())
            {
                db2.executeUpdate("delete from Doctor where youxiaozhengjianhao="+db.cite(zj));
            }
        } finally
        {
            db.close();
			db2.close();
        }
        return f;
    }




	//判断个人登录时候 姓名和证件是否一致
    public static boolean isPar(String community,String xingming,String zjhm) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT doctorid FROM Doctor  WHERE community=" + db.cite(community) + " AND xingming =" + db.cite(xingming)+" AND youxiaozhengjianhao="+db.cite(zjhm));

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
	//通过姓名证件 获得ID
	public static int getPardaid(String community,String xingming,String zjhm) throws SQLException
   {
	   int f = 0;
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT doctorid FROM Doctor  WHERE community=" + db.cite(community) + " AND xingming =" + db.cite(xingming)+" AND youxiaozhengjianhao="+db.cite(zjhm));
		   if(db.next())
		   {
			   f = db.getInt(1);
		   }
	   } finally
	   {
		   db.close();
	   }
	   return f;

   }
//判断是否有工作单位
   public static boolean isGongzudanwei(String community,int gz)throws SQLException
   {
	   boolean f =false;
	   DbAdapter db = new DbAdapter();
	   try
	   {
		   db.executeQuery("SELECT doctorid FROM Doctor  WHERE community=" + db.cite(community) + " AND gongzuodanwei =" +gz);
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

	//获取时间的下拉框
	public static String getSelectTime(String field,Date value,int year,int ksyear)
	{
		StringBuffer sp = new StringBuffer();
		String v =null;
        if(value != null)
        {
            v = sdf.format(value);
        }
		//
        int y = 0,m = 0,d = 0;
        if( !"null".equals(v)&& v != null && v.length() > 0 && v.length()==10)
        {
            y = Integer.parseInt(v.substring(0,4));
            m = Integer.parseInt(v.substring(5,7));
            d = Integer.parseInt(v.substring(8,10));
        }
		sp.append("<select name=").append(field).append("Year").append(">");
		sp.append("<option value=''>--选择年--</option>");
		for(int i=ksyear;i<=year;i++)
		{
			sp.append("<option value=").append(i);
			if(y==i)
			{
				sp.append(" selected ");
			}
			sp.append(">").append(i).append("</option>");
		}
		sp.append("</select>");
		sp.append("<select name=").append(field).append("Month").append(">");
		sp.append("<option value=''>--选择月--</option>");
		for(int i=1;i<=12;i++)
		{
			sp.append("<option value=").append(i);
			if(m==i)
			{
				sp.append(" selected ");
			}
			sp.append(">").append(i).append("</option>");
		}
		sp.append("</select>");
		sp.append("<select name=").append(field).append("Day").append(">");
		sp.append("<option value=''>--选择日--</option>");
		for(int i=1;i<=31;i++)
		{
			sp.append("<option value=").append(i);
			if(d==i)
			{
				sp.append(" selected ");
			}
			sp.append(">").append(i).append("</option>");
		}
		sp.append("</select>");
		return sp.toString();
	}

	//修改医院选项
	public void setGzdanwei(int gongzuodanwei)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("update Doctor set gongzuodanwei ="+gongzuodanwei+" ,gongzuodanwei2='',gongzuodanwei2s=0 where doctorid = "+doctorid);
		}finally
		{
			db.close();
		}
	}
	//合并医院
	public static void setGZDW(int hoid ,int hoid2)throws SQLException
	{
        DbAdapter db = new DbAdapter();
        Hospital hobj = Hospital.find(hoid);
        //在删除以前 把要删除的添加到新的医院里面
		 if(hobj.getGrade()!=null && hobj.getGrade().length()>0)
		 {
			   Hospital hobj2 = Hospital.find(hoid2);

			   hobj2.set(hobj2.getHoname(),hobj2.getProvincial(),hobj2.getCity(),hobj2.getGrade(),hobj2.getHotype(),hobj2.getBaoding(),hobj2.getEquipment(),hobj2.getSpecialist(),hobj2.getBedseveral(),
					   hobj2.getOutpatient(),hobj2.getDean(),hobj2.getAddress(),hobj2.getZip(),hobj2.getTelephone(),hobj2.getEmail(),hobj2.getWeburl(),hobj2.getBusline(),hobj2.getIntroduce(),
					 hobj2.getPicaddress(),hobj2.getThumbnail(),hobj2.getQuantity());
		}
		try
		{

			db.executeUpdate("update Doctor set gongzuodanwei="+hoid2+" where gongzuodanwei = "+hoid);
		}finally
		{
			db.close();
		}
	}
	//计算医生数量

	public static int getQU(int hoid)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int in = 0;
		Hospital hobj = Hospital.find(hoid);
		//在删除以前 把要删除的添加到新的医院里面

		try
		{
			db.executeQuery("select count(doctorid) from Doctor where sheng = 3 and gongzuodanwei="+hoid);
			if(db.next())
			{
				in = db.getInt(1);
			}
		}finally
		{
			db.close();
		}
		return in;
	}


    public Date getBiyeshijian1()
    {
        return biyeshijian1;
    }

    public String getBiyeshijian1ToString()
    {
        if(biyeshijian1 == null)
            return "";
        return sdf.format(biyeshijian1);
    }


    public Date getBiyeshijian2()
    {
        return biyeshijian2;
    }

    public String getBiyeshijian2ToString()
    {
        if(biyeshijian2 == null)
            return "";
        return sdf.format(biyeshijian2);
    }
    public String getBiyeyuanxiao1()
    {
        return biyeyuanxiao1;
    }

    public String getBiyeyuanxiao2()
    {
        return biyeyuanxiao2;
    }

    public Date getChushengnianyue()
    {
        return chushengnianyue;
    }



	public String getChushengnianyueToString()
	{
		if(chushengnianyue == null)
			return "";
		return sdf.format(chushengnianyue);
	}

    public String getCommunity()
    {
        return community;
    }

    public String getDanweidianhua()
    {
        return danweidianhua;
    }
	public String getDanweidianhua2()
 {
	 return danweidianhua2;
 }


    public String getDanweidizhi()
    {
        return danweidizhi;
    }

    public String getEmail()
    {
        return email;
    }
	public String getEmail2()
	{
		return email2;
    }
    public boolean isExists()
    {
        return exists;
    }

    public String getGerenjianli()
    {
        return gerenjianli;
    }

    public String getGerenzhaopianname()
    {
        return gerenzhaopianname;
    }

    public String getGerenzhaopianpath()
    {
        return gerenzhaopianpath;
    }

    public int getGongzuodanwei()
    {
        return gongzuodanwei;
    }

    public String getGongzuodanwei2()
    {
        return gongzuodanwei2;
    }

    public int getJishuzhicheng1()
    {
        return jishuzhicheng1;
    }

    public int getJishuzhicheng2()
    {
        return jishuzhicheng2;
    }

    public int getJishuzhicheng3()
    {
        return jishuzhicheng3;
    }



    public String getJizhiqingkuang()
    {
        return jizhiqingkuang;
    }

    public int getSheng()
    {
        return sheng;
    }

    public int getShi()
    {
        return shi;
    }

    public String getShoujihao()
    {
        return shoujihao;
    }

    public String getSuoshukeshi()
    {
        return suoshukeshi;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getTimesToString()
    {
        if(times == null)
            return "";
        return sdf.format(times);
    }


    public String getXingbie()
    {
        return xingbie;
    }

    public String getXingming()
    {
        return xingming;
    }

    public int getXingzhengzhicheng()
    {
        return xingzhengzhicheng;
    }

	public int getXingzhengzhicheng2()
	{
		return xingzhengzhicheng2;
	}



    public String getYoubian()
    {
        return youbian;
    }

    public String getYouxiaozhengjian()
    {
        return youxiaozhengjian;
    }

    public String getYouxiaozhengjianhao()
    {
        return youxiaozhengjianhao;
    }

    public String getYszhiyezheng()
    {
        return yszhiyezheng;
    }

    public Date getYszhiyezhengtime()
    {
        return yszhiyezhengtime;
    }

    public String getYszhiyezhengtimeToString()
    {
        if(yszhiyezhengtime == null)
            return "";
        return sdf.format(yszhiyezhengtime);
    }


    public String getYszigezheng()
    {
        return yszigezheng;
    }

    public Date getYszigezhengtime()
    {
        return yszigezhengtime;
    }

    public String getYszigezhengtimeToString()
    {
        if(yszigezhengtime == null)
            return "";
        return sdf.format(yszigezhengtime);
    }
    public String getYyjibie()
    {
        return yyjibie;
    }

    public String getYyxingzhi()
    {
        return yyxingzhi;
    }

    public int getZhuanyefangxiang1()
    {
        return zhuanyefangxiang1;
    }

    public int getZhuanyefangxiang2()
    {
        return zhuanyefangxiang2;
    }

    public int getZhuanyefangxiang3()
    {
        return zhuanyefangxiang3;
    }

    public String getZyfx1()
    {
        return zyfx1;
    }

    public String getZyfx2()
    {
        return zyfx2;
    }

    public String getZyfx3()
    {
        return zyfx3;
    }


    public String getZuigaoxueli1()
    {
        return zuigaoxueli1;
    }

    public String getZuigaoxueli2()
    {
        return zuigaoxueli2;
    }

    public String getZuigaoxuewei1()
    {
        return zuigaoxuewei1;
    }

    public String getZuigaoxuewei2()
    {
        return zuigaoxuewei2;
    }
   public int getGongzuodanwei2s()
   {
	   return gongzuodanwei2s;
   }
	public int getDoctorid()
	{
		return doctorid;
	}
}
