package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import tea.entity.member.Profile;

/**
 * 设置短信提醒
 * */
public class ShopSMSSetting {
	protected static Cache c = new Cache(50);
 	public int id;
    public String tjdd; 		//提交订单
    public String qrfh; 		//确认发货
    public String ckwc; 		//出库完成
    public String syfp; 		//索要发票
    public String fpjc; 		//发票寄出
    public String thsq; 		//退货申请
    public String thwc;			//退货完成
    public String zhtx;			//资质到期提醒
    //2018-1-3 yt加（用于上海出库管理员取消订单后的短信通知）
    public String qxckdd;       //取消出库订单提醒
    public String ckfh;         //出库复核提醒
    public String ckcs;         //出库初审提醒
    public String ckjgtz;       //出库结果通知
    public String sczjbg;       //上传质检报告通知1
    public String dck;          //待出库通知
    //三期新加数据
    public String fpkj;         //发票开具提醒（财务）jsp页面后改为"通知财务开票"
    public String hkds;         //回款待审通知
    public String hkshwc;       //回款审核完成通知
    public String hkfpsh;       //汇款匹配发票审核
    public String fwfsh;        //服务费审核通知
    public String cwykp;        //财务已开票通知
    public int puid;            //厂商id
    
    public ShopSMSSetting(int id)
    {
        this.id = id;
    }

    public static ShopSMSSetting find(int id) throws SQLException
    {
        ShopSMSSetting t = (ShopSMSSetting) c.get(id);
        if (t == null)
        {
            ArrayList<ShopSMSSetting> al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopSMSSetting(id) : (ShopSMSSetting) al.get(0);
        }
        return t;
    }

    public static ArrayList<ShopSMSSetting> find(String sql, int pos, int size) throws SQLException
    {
        ArrayList<ShopSMSSetting> al = new ArrayList<ShopSMSSetting>();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,tjdd,qrfh,ckwc,syfp,fpjc,thsq,thwc,zhtx,qxckdd,ckfh,ckcs,ckjgtz,sczjbg,dck,fpkj,hkds,hkshwc,hkfpsh,fwfsh,cwykp,puid FROM ShopSMSSetting WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopSMSSetting t = new ShopSMSSetting(rs.getInt(i++));
                t.tjdd = rs.getString(i++);
                t.qrfh = rs.getString(i++);
                t.ckwc = rs.getString(i++);
                t.syfp = rs.getString(i++);
                t.fpjc = rs.getString(i++);
                t.thsq = rs.getString(i++);
                t.thwc = rs.getString(i++);
                t.zhtx = rs.getString(i++);
                t.qxckdd = rs.getString(i++);
                t.ckfh = rs.getString(i++);
                t.ckcs = rs.getString(i++);
                t.ckjgtz = rs.getString(i++);
                t.sczjbg = rs.getString(i++);
                t.dck = rs.getString(i++);
                t.fpkj = rs.getString(i++);
                t.hkds = rs.getString(i++);
                t.hkshwc = rs.getString(i++);
                t.hkfpsh = rs.getString(i++);
                t.fwfsh = rs.getString(i++);
                t.cwykp = rs.getString(i++);
                t.puid = rs.getInt(i++);
                c.put(t.id, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopSMSSetting WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO ShopSMSSetting(id,tjdd,qrfh,ckwc,syfp,fpjc,thsq,thwc,zhtx,qxckdd,ckfh,ckcs,ckjgtz,sczjbg,dck,fpkj,hkds,hkshwc,hkfpsh,fwfsh,cwykp,puid)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(tjdd) +","+ DbAdapter.cite(qrfh)+","+DbAdapter.cite(ckwc)+","+DbAdapter.cite(syfp)+","+DbAdapter.cite(fpjc)+","+DbAdapter.cite(thsq)+","+DbAdapter.cite(thwc)+","+DbAdapter.cite(zhtx)+ "," +DbAdapter.cite(qxckdd)+","+DbAdapter.cite(ckfh)+","+DbAdapter.cite(ckcs)+","+DbAdapter.cite(ckjgtz)+","+DbAdapter.cite(sczjbg)+","+DbAdapter.cite(dck)+","+DbAdapter.cite(fpkj)+","+DbAdapter.cite(hkds)+","+DbAdapter.cite(hkshwc)+","+DbAdapter.cite(hkfpsh)+","+DbAdapter.cite(fwfsh)+","+DbAdapter.cite(cwykp)+","+puid+")";
        else
            sql = "UPDATE ShopSMSSetting SET tjdd="+ DbAdapter.cite(tjdd) +",qrfh=" + DbAdapter.cite(qrfh) +",ckwc=" + DbAdapter.cite(ckwc) +",syfp=" + DbAdapter.cite(syfp) +",fpjc=" + DbAdapter.cite(fpjc) +",thsq=" + DbAdapter.cite(thsq) +",thwc=" + DbAdapter.cite(thwc)+",zhtx=" + DbAdapter.cite(zhtx)+",qxckdd = " +DbAdapter.cite(qxckdd)+",ckfh="+DbAdapter.cite(ckfh)+",ckcs="+DbAdapter.cite(ckcs)+",ckjgtz="+DbAdapter.cite(ckjgtz)+",sczjbg="+DbAdapter.cite(sczjbg)+",dck="+DbAdapter.cite(dck)+",fpkj="+DbAdapter.cite(fpkj)+",hkds="+DbAdapter.cite(hkds)+",hkshwc="+DbAdapter.cite(hkshwc)+",hkfpsh="+DbAdapter.cite(hkfpsh)+",fwfsh="+DbAdapter.cite(fwfsh)+",cwykp="+DbAdapter.cite(cwykp)+",puid="+puid+" WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void setT() throws SQLException
    {
        String sql;
        sql = "UPDATE ShopSMSSetting SET tjdd="+ DbAdapter.cite(tjdd) +",qrfh=" + DbAdapter.cite(qrfh) +",ckwc=" + DbAdapter.cite(ckwc) +",syfp=" + DbAdapter.cite(syfp) +",fpjc=" + DbAdapter.cite(fpjc) +",thsq=" + DbAdapter.cite(thsq) +",thwc=" + DbAdapter.cite(thwc)+",zhtx=" + DbAdapter.cite(zhtx)+",qxckdd = " +DbAdapter.cite(qxckdd)+",ckfh="+DbAdapter.cite(ckfh)+",ckcs="+DbAdapter.cite(ckcs)+",ckjgtz="+DbAdapter.cite(ckjgtz)+",sczjbg="+DbAdapter.cite(sczjbg)+",dck="+DbAdapter.cite(dck)+",fpkj="+DbAdapter.cite(fpkj)+",hkds="+DbAdapter.cite(hkds)+",hkshwc="+DbAdapter.cite(hkshwc)+",hkfpsh="+DbAdapter.cite(hkfpsh)+",fwfsh="+DbAdapter.cite(fwfsh)+",cwykp="+DbAdapter.cite(cwykp)+" WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE ShopSMSSetting SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    //获取不同阶段要发送短信通知的用户手机号
    public static List<String> getUserMobile(String members){
    	List<String> mobiles = new ArrayList<String>();
    	try {
			String[] memberArr = members.split("[|]");
			for(int i=0;i<memberArr.length;i++){
				if(!"".equals(memberArr[i])){
					Profile pro = Profile.find(Integer.parseInt(memberArr[i]));
					if(!"".equals(pro.mobile) && null != pro.mobile)
						mobiles.add(pro.mobile);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mobiles;
    }
}
