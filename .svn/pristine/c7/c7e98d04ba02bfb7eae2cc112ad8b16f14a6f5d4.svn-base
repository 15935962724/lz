package tea.entity.member;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;


public class SMessage
{
    protected static Cache c = new Cache(50);
    public int smessage; //短信
    public int member; //发送者_用户ID
    public int server; //通道
    public static String[] FOLDER_TYPE =
            {"--","待发","发送","接收","删除"};
    public int folder; //类型
    public String tmember = "|"; //接收者
    public String tcontact = "|"; //接收者_联系人
    public String mobile = "|"; //接受者_手机号
    public String content; //内容
    public String state = "|"; //状态
    public int[] count = new int[2];
    public Date time; //时间

    public SMessage(int smessage)
    {
        this.smessage = smessage;
    }

    public static SMessage find(int smessage) throws SQLException
    {
        if(smessage < 0)
            return new SMessage(smessage);
        SMessage t = (SMessage) c.get(smessage);
        if(t == null)
        {
            ArrayList al = find(" AND smessage=" + smessage,0,1);
            t = al.size() < 1 ? new SMessage(smessage) : (SMessage) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT smessage,member,server,folder,tmember,tcontact,mobile,content,state,count0,count1,time FROM smessage WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SMessage t = new SMessage(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.server = rs.getInt(i++);
                t.folder = rs.getInt(i++);
                t.tmember = rs.getString(i++);
                t.tcontact = rs.getString(i++);
                t.mobile = rs.getString(i++);
                t.content = rs.getString(i++);
                t.state = rs.getString(i++);
                t.count[0] = rs.getInt(i++);
                t.count[1] = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.smessage,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM smessage WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(smessage < 1)
            {
                db.executeUpdate("INSERT INTO smessage(member,server,folder,tmember,tcontact,mobile,content,state,count0,count1,time)VALUES(" + member + "," + server + "," + folder + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(tcontact) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(state) + "," + count[0] + "," + count[1] + "," + DbAdapter.cite(time) + ")");
                db.executeQuery("SELECT MAX(smessage) FROM smessage WHERE member=" + member);
                smessage = db.next() ? db.getInt(1) : 0;
            } else
                db.executeUpdate("UPDATE smessage SET member=" + member + ",server=" + server + ",folder=" + folder + ",tmember=" + DbAdapter.cite(tmember) + ",tcontact=" + DbAdapter.cite(tcontact) + ",mobile=" + DbAdapter.cite(mobile) + ",content=" + DbAdapter.cite(content) + ",state=" + DbAdapter.cite(state) + ",count0=" + count[0] + ",count1=" + count[1] + ",time=" + DbAdapter.cite(time) + " WHERE smessage=" + smessage);
        } finally
        {
            db.close();
        }
        c.remove(smessage);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM smessage WHERE smessage=" + smessage);
        c.remove(smessage);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE smessage SET " + f + "=" + DbAdapter.cite(v) + " WHERE smessage=" + smessage);
        c.remove(smessage);
    }

    //
    public static int count() throws SQLException
    {
        Site s = Site.find(1);
        try
        {
            String str = (String) Http.open("http://chufa.lmobile.cn/submitdata/service.asmx/Sm_GetRemain?sname=" + s.smsuser + "&spwd=" + s.smspassword + "&scorpid=&sprdid=1012818",null);
            //System.out.println(str);
            XMLObject o = new XMLObject(str).getXMLObject("cremain");
            //o.getInt("State")
            return o.getInt("remain");
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return 0;
    }

    public static int send(String mobile,String content) throws SQLException
    {
        int state;
        Site s = Site.find(1);
        try
        {
            if("LIU".equals(System.getenv("COMPUTERNAME")))
            {
                System.out.println("测试机，跳过发送短信。mobile：" + mobile + "　content：" + content);
                Thread.sleep(1000);
                return 0;
            }
            String str = (String) Http.open("http://chufa.lmobile.cn/submitdata/service.asmx/g_Submit?sname=" + s.smsuser + "&spwd=" + s.smspassword + "&scorpid=&sprdid=1012808&sdst=" + mobile + "&smsg=" + Http.enc(content),null);
            System.out.println(str);
            XMLObject o = new XMLObject(str).getXMLObject("csubmitstate");
            state = o.getInt("state");
            if(state == 0)
            {
                int j = content.length() / 70;
                if(content.length() % 70 != 0)
                    j++;
                s.set("smscount",String.valueOf(s.smscount += j));
            }
        } catch(Throwable ex)
        {
            state = -1;
            ex.printStackTrace();
        }
        return state;
    }

    public String getToName(boolean a) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = tmember.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            Profile t = Profile.find(Integer.parseInt(arr[i]));
            sb.append(a ? "<a href='/jsp/sub/MemberView.jsp?member=" + arr[i] + "'>" + t.getName(1) + "</a>" : t.getName(1)).append("；");
        }
        if(arr.length < 1)
        {
            sb.append(mobile.substring(1).replace('|','；'));
        }
//        arr = tcontact.split("[|]");
//        for (int i = 1; i < arr.length; i++)
//        {
//            Contact t = Contact.find(Integer.parseInt(arr[i]));
//            sb.append(a ? "<a href='/admin/review/ContactView.jsp?contact=" + t.contact + "'>" + t.getName(1) + "</a>" : t.getName(1)).append("；");
//        }
        return sb.toString();
    }

    public static String get(int state)
    {
        HashMap<Integer,String> hm = new HashMap();
        hm.put(0,"成功");
        // 101: 提交参数不可为空，或参数格式错误
        //2001: 计费失败
        //1023: 无效计费条数,过滤[1:1587224766]
        hm.put(6002,"信息内容超长");
        hm.put(6003,"提交参数不可为空，或参数类型错误");
        hm.put(6004,"提交速度限制");
        hm.put(6005,"提交池限制");
        hm.put(6006,"接收号码异常,或号码总数超过10000");
        hm.put(100028,"帐号余额不足");
        hm.put(100030,"记录入库失败");
        hm.put(100031,"用户帐号无效");
        hm.put(100033,"用户计费失败");
        hm.put(100045,"用户没有购买该类产品");
        hm.put(100050,"IP地址不符合");
        hm.put(100051,"企业号错误");
        hm.put(200053,"数据库操作异常");
        hm.put(201005,"接收号码被过滤");
        hm.put(201054,"产品编号错误");
        hm.put(201056,"短信内容超长");
        hm.put( -1,"接口提交异常");
        return hm.get(state);
    }

    //0:成功　1:失败
    public int[] send(Writer out) throws SQLException,IOException
    {
        Site s = Site.find(1);
        if(s.smsserver < 1)
            return null;

        StringBuilder mob = new StringBuilder(mobile),sta = new StringBuilder("|");
        String[] arr = tmember.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            String mobile = Profile.find(Integer.parseInt(arr[i])).getMobile();
            mob.append(mobile).append("|");
        }
        mobile = mob.toString();
        arr = mobile.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            if(out != null)
            {
                out.write("<script>mt.progress(" + i + "," + arr.length + ",'正在发送（" + i + "/" + (arr.length - 1) + "）：" + arr[i] + "');</script>");
                out.flush();
            }
            int state = send(arr[i],content);
            count[state == 0 ? 0 : 1]++;
            sta.append(state).append("|");
        }
        server = s.smsserver;
        folder = 2;
        state = sta.toString();
        set();
        return count;
    }

    //0:成功　1:失败
    public static int[] send(int member,String tmember,String mobile,String content,Writer out) throws SQLException,IOException
    {
        Site s = Site.find(1);
        if(s.smsserver < 1)
            return null;
        if(out == null && !s.smsremind) //短信提醒
            return null;

        SMessage t = new SMessage(0);
        t.member = member;
        t.folder = out == null ? 1 : 2;
        t.tmember = tmember;
        t.mobile = mobile;
        t.content = content;
        t.time = new Date();
        t.set();

        return t.folder == 1 ? null : t.send(out);
    }

    public static boolean send(int member,int tmember,String content) throws SQLException,IOException
    {
        int[] arr = send(member,"|" + tmember + "|","|",content,null);
        return arr != null && arr[0] == 1;
    }
}
