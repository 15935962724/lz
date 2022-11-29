package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class Csvsms extends Entity
{
    private int id ;
    private String member;
    private String community;
    private String mobile;///手机*
    private String msg;///内容*
    private String reg;
    private String svcode;//*
    private String spnum;//*
    private String union_id;
    private String item_id;
    private String link_id;
    private String msg_id;//*
    private String cp_id;
    private String cp_pass;
    private String backurl;//*
    private Date times;//接受的时间
    private int type ;///0 会员没有成功接受。1 会员已经接受到了参数

    private boolean exists; // 是否存在
    /*
     mobile 必填 发送手机
     msg 必填, 当前定义为gb2312格式, 长度至少4个Byte 信息体 （即短信内容 ），限定长度70个字符 。
     #reg —零时定制成功 （2小时生存周期 ）
     svcode 必填 业务代码 （即二级代码, 由我方分配 ）
     spnum 必填 长号码
     union_id 可选 （仅当合作方有下家联盟是使用 ）联盟ID
     item_id 可选 （仅当从网站点播移动业务时使用 ）合作方自己编排流水号
     link_id 点播业务或定制时必填 。
     定制业务可选 。信息序列号 （由移动 、联通网关自动生成 ）

     msg_id 可选 （判断是否与上行msg_id匹配 ）1．信息体自定义编号
     2．msg_id = 0或 空 默认发送5条
     msg_id = 流水号 只能发送1条

    */
   /*
    dstmobile	必填	发送手机
    feemobile	可选	计费手机
    msg		必填,当前定义为gb2312格式,长度至少4个Byte	信息体（即短信内容），限定长度70个字符。
    svcode	必填	业务代码（即二级代码,由我方分配）
    spnum	必填	长号码
    cp_id	必填	合作方名称
    cp_pass	必填	合作方密码
    ip	可选，建议写上	内容提供商服务器的IP
    union_id	可选（仅当合作方有下家联盟是使用）	联盟ID
    item_id	可选（仅当从网站点播移动业务时使用）	合作方自己编排流水号
    link_id	点播业务或定制时必填。
    定制业务可选。	信息序列号（由移动、联通网关自动生成）

    msg_id	可选（判断是否与上行msg_id匹配）	1．	信息体自定义编号
    2．	msg_id=0或 空 默认发送5条
       msg_id=流水号  只能发送1条
    backurl	可选	跳转页面地址
    (发送成功后，跳转的cp合作方页面)
    */

    public Csvsms(int id)throws SQLException
    {
        this.id=id;

    }
    public Csvsms find(int id)throws SQLException
    {
         return new Csvsms(id);
    }
    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id, member, community, mobile, msg, reg, svcode, spnum, union_id, item_id, link_id, msg_id, cp_id, cp_pass, backurl,times from Csvsms where id="+id);
            if(db.next())
            {
                id = db.getInt(1);
                member = db.getString(2);
                community = db.getString(3);
                mobile = db.getString(4); ///手机*
                msg = db.getString(5); ///内容*
                reg = db.getString(6);
                svcode = db.getString(7); //*
                spnum = db.getString(8); //*
                union_id = db.getString(9);
                item_id = db.getString(10);
                link_id = db.getString(11);
                msg_id = db.getString(12); //*
                cp_id = db.getString(13);
                cp_pass = db.getString(14);
                backurl = db.getString(15); //*
                times =db.getDate(16);
                type =db.getInt(17);
                exists=true; // 是否存在
            }
            else
            {
                exists=false;
            }
        }
        finally
        {
            db.close();
        }
    }

    public static void create(String  member,String  community,String  mobile,String  msg,String  reg,String  svcode,String  spnum, String  union_id,String  item_id,String  link_id,String  msg_id,String  cp_id, String cp_pass,String  backurl,Date times)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvsms( member, community, mobile, msg, reg, svcode, spnum, union_id, item_id, link_id, msg_id, cp_id, cp_pass, backurl,times)values("+db.cite(member)+","+db.cite( community)+","+db.cite( mobile)+","+db.cite( msg)+","+db.cite( reg)+","+db.cite( svcode)+","+db.cite( spnum)+","+db.cite( union_id)+","+db.cite( item_id)+","+db.cite( link_id)+","+db.cite( msg_id)+","+db.cite( cp_id)+","+db.cite( cp_pass)+","+db.cite( backurl)+","+db.cite(times)+")");
        }
        finally
        {
            db.close();
        }
    }

    public String getBackurl()
    {
        return backurl;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCp_id()
    {
        return cp_id;
    }

    public String getCp_pass()
    {
        return cp_pass;
    }

    public int getId()
    {
        return id;
    }

    public String getItem_id()
    {
        return item_id;
    }

    public String getLink_id()
    {
        return link_id;
    }

    public String getMember()
    {
        return member;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getMsg()
    {
        return msg;
    }

    public String getMsg_id()
    {
        return msg_id;
    }

    public String getReg()
    {
        return reg;
    }

    public String getSpnum()
    {
        return spnum;
    }

    public String getSvcode()
    {
        return svcode;
    }

    public String getUnion_id()
    {
        return union_id;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getType()
    {
        return type;
    }


}
