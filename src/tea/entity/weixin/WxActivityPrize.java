package tea.entity.weixin;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Seq;
import util.Alias;

/** 
 * @author zcq
 * @version 创建时间：2015-5-26 下午03:50:52 
 * 微信活动奖项设置
 */
public class WxActivityPrize extends Entity
{
    private int id; //微活动设置的奖项
    private int activityId;//微活动id
    private int pgId;//积分礼品id
    private String name;//奖项名称
    private int num;//奖品数量
    private int winNum;//中奖数量
    private double probability; //中奖概率 0-100, 支持小数点
    private int sequence;//顺序
    private int winActivityMemId;//中奖者信息id
    private Date time;//创建时间
    

    public WxActivityPrize(int id)
    {
        this.id = id;
    }

    public static WxActivityPrize find(int id) throws SQLException
    {
        WxActivityPrize t = (WxActivityPrize) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new WxActivityPrize(id) : (WxActivityPrize) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,activityId,pgId,name,num,winNum,probability,sequence,time FROM WxActivityPrize WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxActivityPrize t = new WxActivityPrize(rs.getInt(i++));
                t.activityId = rs.getInt(i++);
                t.pgId = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.num = rs.getInt(i++);
                t.winNum = rs.getInt(i++);
                t.probability = rs.getDouble(i++);
                t.sequence = rs.getInt(i++);
                t.time = db.getDate(i++);
                _cache.put(t.id,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM WxActivityPrize WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
        {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.MONTH, -2);
            sql = "INSERT INTO WxActivityPrize(id,activityId,pgId,name,num,winNum,probability,sequence,time)VALUES(" + (id = Seq.get(c.getTime())) +","+activityId + ","+pgId
            	+ ","+DbAdapter.cite(name) + ","+num +","+winNum +","+probability +","+sequence +","+DbAdapter.cite(time)+ ")";
        } else
            sql = "UPDATE WxActivityPrize SET activityId="+activityId + ",pgId="+pgId + ",name="+DbAdapter.cite(name) + ",num="+num +",winNum="+winNum
            	+",probability="+probability +",sequence="+sequence +",time="+DbAdapter.cite(time)
            	+ " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"DELETE FROM WxActivityPrize WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE WxActivityPrize SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }
    
    
    public static WxActivityPrize awardPrizeByActivityId(int activityId,int member){
    	
    	WxActivityPrize awardPrize = new WxActivityPrize(0);
    	
    	//判断是否达到 每天最多出奖数量
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
    	String nowTime = df.format(new Date());

    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_MONTH, +1);
    	String afterDayTime = df.format(calendar.getTime());
    	
    	try {
			WxActivity t = WxActivity.find(activityId);
			boolean beyondFlag = true;//超出每天最多出奖数量
			if(t.getMaxNumOfDay()==0){
				beyondFlag = false;
			}else{
				int prizeNumOfDay = WxActivityMem.count(" AND activityId="+activityId+" AND status!=0 AND time>'"+nowTime+"' and time<'"+afterDayTime+"'");
				if(prizeNumOfDay<t.getMaxNumOfDay()){
					beyondFlag = false;
				}
			}
			
			if(!beyondFlag){
				
				Object[][] prizeArr = getObjArr(activityId);
				if(prizeArr!=null){
					double[] _pdf = new double[prizeArr.length];
					for(int i=0;i<prizeArr.length;i++){
						_pdf[i] = (Double)prizeArr[i][1];
					}
					Alias method = new Alias();
					Integer index = method.getLottery(_pdf);
					if(index!=null){
						WxActivityPrize resultPrize = WxActivityPrize.find((Integer)prizeArr[index][0]);
						//查询数据库的奖品是否已经被领完
    					if(resultPrize.getWinNum()<resultPrize.getNum()){
    						awardPrize = resultPrize;
    					}
    					//记录 抽奖者 信息（为什么要在这里记录中奖者信息，中奖后，立马修改中奖数量+1，防止填写中奖者电话时，有其他抽奖者再次抽到当前中奖奖项）
			    		WxActivityMem activityMem = new WxActivityMem(0);
			    		activityMem.setActivityId(activityId);
			    		activityMem.setActivityPrizeId(awardPrize.getId());
			    		activityMem.setMember(member);
			    		activityMem.setTime(new Date());
			    		activityMem.setStatus(awardPrize.getId()>0?1:0);//领奖状态-0：未中奖；1：未奖领；2：已领
		    			activityMem.set();
		    			if(awardPrize.getId()>0){//中奖了
		    				//中奖数量+1
		    				awardPrize.set("winNum",String.valueOf(awardPrize.getWinNum()+1));
							//存储中奖者信息id
							awardPrize.setWinActivityMemId(activityMem.getId());
		    			}
		    			
					}
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return awardPrize;
    }
    
    private static Object[][] getObjArr(int activityId){
    	Object[][] prizeArr = null;
    	List<WxActivityPrize> actyPrizeList = null;
    	try {
			actyPrizeList = WxActivityPrize.find(" AND activityId="+activityId+" AND winNum<num", 0, Integer.MAX_VALUE);//当前微活动和中奖数量小于奖品数量
			//设置没有奖品的类
	    	WxActivityPrize nullPrize = new WxActivityPrize(0);
	    	double sumPrizePro = 0;
	        for (WxActivityPrize g : actyPrizeList) {
	        	sumPrizePro += g.getProbability();
	        }
	        if(sumPrizePro<1.0){
	        	nullPrize.setProbability(1.0-sumPrizePro);
	        }
	    	actyPrizeList.add(nullPrize);
	    	
	    	prizeArr = new  Object[actyPrizeList.size()][2];
	    	for(int i=0;i<actyPrizeList.size();i++){
	    		WxActivityPrize actyPrize = actyPrizeList.get(i);
	    		prizeArr[i][0] = actyPrize.getId();
	    		prizeArr[i][1] = actyPrize.getProbability();
	    	}
	    	
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
    	
    	return prizeArr;
    }
    
    
    
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getActivityId() {
		return activityId;
	}
	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}
	public int getPgId() {
		return pgId;
	}
	public void setPgId(int pgId) {
		this.pgId = pgId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getWinNum() {
		return winNum;
	}
	public void setWinNum(int winNum) {
		this.winNum = winNum;
	}
	public double getProbability() {
		return probability;
	}
	public void setProbability(double probability) {
		this.probability = probability;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public int getWinActivityMemId() {
		return winActivityMemId;
	}
	public void setWinActivityMemId(int winActivityMemId) {
		this.winActivityMemId = winActivityMemId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}