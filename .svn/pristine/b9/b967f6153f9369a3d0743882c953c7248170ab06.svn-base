package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class AdminUnit
{
    public static Cache _cache = new Cache(100);
    public int id;
    public int father;
    public int member;
    public String path;
    public String code;
    public String name;
    public String ename; //英文名称///////
    public String sname; //简称
    public int pid;
    public int type;
    public String tel;
    public String fax;
    public int seq; //含有树结构的顺序
    public int sequence; //顺序
    public String community;
    public int serial;
    public String creator;
    public String address;
    public String zip;
    public String content;
    public String picture;
    public String prefix; //前缀
    public boolean usepic; //是否使用图片
    // ////////////////////////////////标准/////////////////////////////////////////////////////////
    private String other; // 标准:帐号
    private String other2; // 标准:开户行
    private boolean other3; // 标准:是否编制组
    private String calling;
    private String specialty;
    private String product;
    private String linkmanname;
    private String mobile;
    public String email;
    private String url;
    private String have_a_project;
    private boolean ends; //是否末级
    private boolean hiddenorg; //是否显示在组织机构中
    public int adminunittype; //部门分类
    public int adminunitorg; //部门所属机构
    private boolean exists;

    private AdminUnit(int id,int father,String path,String name,String ename,int pid,int type,String tel,String fax,int sequence,String community,int serial,String creator,String address,String zip,String content,String picture,boolean usepic,String other,String other2,boolean other3,String calling,String specialty,String product,String linkmanname,String mobile,String email,String url,String have_a_project,boolean ends,boolean hiddenorg)
    {
        this.id = id;
        this.father = father;
        this.path = path;
        this.name = name;
        this.ename = ename;
        this.pid = pid;
        this.type = type;
        this.tel = tel;
        this.fax = fax;
        this.sequence = sequence;
        this.community = community;
        this.serial = serial;
        this.creator = creator;
        this.address = address;
        this.zip = zip;
        this.content = content;
        this.picture = picture;
        this.usepic = usepic;
        this.other = other;
        this.other2 = other2;
        this.other3 = other3;
        this.calling = calling;
        this.specialty = specialty;
        this.product = product;
        this.linkmanname = linkmanname;
        this.mobile = mobile;
        this.email = email;
        this.url = url;
        this.have_a_project = have_a_project;
        this.ends = ends;
        this.hiddenorg = hiddenorg;
        this.exists = true;
    }

    public AdminUnit(int id) throws SQLException
    {
        this.id = id;
    }

    public static AdminUnit find(int id) throws SQLException
    {
        AdminUnit t = (AdminUnit) _cache.get(new Integer(id));
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new AdminUnit(id) : (AdminUnit) al.get(0);
        }
        return t;
    }

    public static AdminUnit findByPid(int pid,String community) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM AdminUnit WHERE pid=" + pid + " AND community=" + DbAdapter.cite(community));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(id);
    }

    public int getId()
    {
        return id;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"DELETE FROM AdminUnit WHERE path LIKE " + db.cite(path + "%"));
            // 如果部门被删除,则将些部门下的会员改为无部门.
            db.executeQuery("SELECT community,member FROM AdminUsrRole WHERE unit=" + id + " OR unit NOT IN( SELECT unit FROM AdminUnit )");
            while(db.next())
            {
                AdminUsrRole aur = AdminUsrRole.find(db.getString(1),db.getString(2));
                aur.setUnit(0);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void set(int father,String name,String ename,int pid,int type,String linkmanname,String tel,String fax,String community,String creator,String address,String zip,String content,String picture,boolean usepic,String other,String other2,int adminunittype,int adminunitorg) throws SQLException
    {
        if(exists)
        {
            String path = "/" + id + "/";
            if(father > 0)
            {
                AdminUnit au = AdminUnit.find(father);
                path = au.getPath() + id + "/";
            }
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate(id,"UPDATE AdminUnit SET father=" + father + ",path=" + db.cite(path) + ",name=" + DbAdapter.cite(name) + ",ename=" + DbAdapter.cite(ename) + ",pid=" + (pid) + ",type=" + (type) + ",linkmanname=" + DbAdapter.cite(linkmanname) + ",tel=" + DbAdapter.cite(tel) + ",fax=" + DbAdapter.cite(fax) + ",address=" + DbAdapter.cite(address) + ",zip=" + DbAdapter.cite(zip) + ",content=" + DbAdapter.cite(content) + ",picture=" + DbAdapter.cite(picture) + ",usepic=" + DbAdapter.cite(usepic) + ",other=" + DbAdapter.cite(other) + ",other2=" + DbAdapter.cite(other2) + ",adminunittype=" + adminunittype + ",adminunitorg=" + adminunitorg + " WHERE id=" + id);
            } finally
            {
                db.close();
            }
            this.father = father;
            this.path = path;
            this.name = name;
            this.ename = ename;
            this.pid = pid;
            this.type = type;
            this.linkmanname = linkmanname;
            this.tel = tel;
            this.fax = fax;
            this.address = address;
            this.zip = zip;
            this.content = content;
            this.picture = picture;
            this.usepic = usepic;
            this.other = other;
            this.other2 = other2;
            this.adminunittype = adminunittype;
            this.adminunitorg = adminunitorg;
        } else
        {
            id = create(father,name,ename,pid,type,linkmanname,tel,fax,community,creator,address,zip,content,picture,usepic,other,other2,adminunittype,adminunitorg);
        }
    }

    public void set(String calling,String specialty,String product,String linkmanname,String mobile,String email,String url,String have_a_project) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE AdminUnit SET calling=" + DbAdapter.cite(calling) + ",specialty=" + DbAdapter.cite(specialty) + ",product=" + DbAdapter.cite(product) + ",linkmanname=" + DbAdapter.cite(linkmanname) + ",mobile=" + DbAdapter.cite(mobile) + ",email=" + DbAdapter.cite(email) + ",url=" + DbAdapter.cite(url) + ",have_a_project=" + DbAdapter.cite(have_a_project) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int create(int father,String name,String ename,int pid,int type,String linkmanname,String tel,String fax,String community,String creator,String address,String zip,String content,String picture,boolean usepic,String other,String other2,int adminunittype,int adminunitorg) throws SQLException
    {
        int sequence = (int) (System.currentTimeMillis() / 1000);
        String path = "/";
        if(father > 0)
        {
            AdminUnit au = AdminUnit.find(father);
            au.setEnds(false);
            path = au.getPath();
        }
        int id = 0;
        String sql = "INSERT INTO AdminUnit(id,father,path,name,ename,pid,type,linkmanname,tel,fax,sequence,community,creator,address,zip,content,picture,usepic,other,other2,ends,hiddenorg,adminunittype,adminunitorg,deleted)VALUES(" + (id = Seq.get()) + "," + father + "," + DbAdapter.cite(path + id + "/") + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(ename) + "," + pid + "," + type + "," + DbAdapter.cite(linkmanname) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(fax) + "," + sequence + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(creator) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(usepic) + "," + DbAdapter.cite(other) + "," + DbAdapter.cite(other2) + ",1,0," + adminunittype +
                "," + adminunitorg + ",0)";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,father,path,code,name,ename,sname,pid,type,tel,fax,seq,sequence,prefix,community,serial,creator,address,zip,content,picture,usepic,other,other2,other3,calling,specialty,product,linkmanname,mobile,email,url,have_a_project,adminunittype,adminunitorg FROM AdminUnit WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                AdminUnit t = new AdminUnit(db.getInt(j++));
                t.father = db.getInt(j++);
                t.path = db.getString(j++);
                t.code = db.getString(j++);
                t.name = db.getVarchar(1,1,j++);
                t.ename = db.getString(j++);
                t.sname = db.getString(j++);
                t.pid = db.getInt(j++);
                t.type = db.getInt(j++);
                t.tel = db.getString(j++);
                t.fax = db.getString(j++);
                t.seq = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.prefix = db.getString(j++);
                t.community = db.getString(j++);
                t.serial = db.getInt(j++);
                t.creator = db.getString(j++);
                t.address = db.getVarchar(1,1,j++);
                t.zip = db.getString(j++);
                t.content = db.getVarchar(1,1,j++);
                t.picture = db.getString(j++);
                t.usepic = db.getInt(j++) != 0;
                t.other = db.getVarchar(1,1,j++);
                t.other2 = db.getVarchar(1,1,j++);
                t.other3 = db.getInt(j++) != 0;
                t.calling = db.getString(j++);
                t.specialty = db.getString(j++);
                t.product = db.getString(j++);
                t.linkmanname = db.getString(j++);
                t.mobile = db.getString(j++);
                t.email = db.getString(j++);
                t.url = db.getString(j++);
                t.have_a_project = db.getString(j++);
                t.adminunittype = db.getInt(j++);
                t.adminunitorg = db.getInt(j++);
                t.exists = true;
                _cache.put(t.id,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        return findByCommunity(community,sql + " ORDER BY sequence",0,Integer.MAX_VALUE);
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id,father,path,name,ename,pid,type,tel,fax,sequence,community,serial,creator,address,zip,content,picture,usepic,other,other2,other3,calling,specialty,product,linkmanname,mobile,email,url,have_a_project,ends,hiddenorg FROM AdminUnit WHERE community=" + DbAdapter.cite(community) + " AND father>0" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                v.addElement(new AdminUnit(db.getInt(j++),db.getInt(j++),db.getString(j++),db.getVarchar(1,1,j++),db.getString(j++),db.getInt(j++),db.getInt(j++),db.getString(j++),db.getString(j++),db.getInt(j++),db.getString(j++),db.getInt(j++),db.getString(j++),db.getVarchar(1,1,j++),db.getString(j++),db.getVarchar(1,1,j++),db.getString(j++),db.getInt(j++) != 0,db.getVarchar(1,1,j++),db.getVarchar(1,1,j++),db.getInt(j++) != 0,db.getString(j++),db.getString(j++),db.getString(j++),db.getString(j++),db.getString(j++),db.getString(j++),db.getString(j++),db.getString(j++),db.getInt(j++) != 0,db.getInt(j++) != 0));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM AdminUnit WHERE community=" + DbAdapter.cite(community) + " AND father>0" + sql);
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

    public void setPid(int pid)
    {
        this.pid = pid;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    public void setTel(String tel)
    {
        this.tel = tel;
    }

    public void setFax(String fax)
    {
        this.fax = fax;
    }

    public void upHiddenOrg(boolean hiddenorg) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from AdminUnit where id in (select id from AdminUnit where id = " + id + " or father = " + id + ") or father in (select id from AdminUnit where id = " + id + " or father = " + id + ")");
            while(db.next())
            {
                AdminUnit au = AdminUnit.find(db.getInt(1));
                au.setUnitHidden(hiddenorg);
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE AdminUnit SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    public void setUnitHidden(boolean hiddenorg) throws SQLException
    {
        set("hiddenorg",hiddenorg ? "1" : "0");
        this.hiddenorg = hiddenorg;
    }


    private void setEnds(boolean ends) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE AdminUnit SET ends=" + db.cite(ends) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.ends = ends;
    }

    public void setSequence(int sequence) throws SQLException
    {
        //保侍path的同步/////
        String path = "/" + id + "/";
        if(father > 0)
        {
            AdminUnit au = AdminUnit.find(father);
            path = au.getPath() + id + "/";
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE AdminUnit SET sequence=" + sequence + ",path=" + db.cite(path) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
        this.path = path;
    }

    // 上一个
    public int getSequenceUp() throws SQLException
    {
        int up = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(sequence) FROM AdminUnit WHERE community=" + DbAdapter.cite(community) + " AND father=" + father + " AND sequence<" + sequence);
            if(db.next())
            {
                up = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return up;
    }

    // 下一个
    public int getSequenceDown() throws SQLException
    {
        int down = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MIN(sequence) FROM AdminUnit WHERE community=" + DbAdapter.cite(community) + " AND father=" + father + " AND sequence>" + sequence);
            if(db.next())
            {
                down = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return down;
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM AdminUnit WHERE 1=1" + sql);
            return db.next() ? db.getInt(1) : 0;
        } finally
        {
            db.close();
        }
    }

    public static int getRootId(String community) throws SQLException
    {
        Integer root = (Integer) _cache.get(community);
        if(root == null)
        {
            int j = 0;
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT id FROM AdminUnit WHERE community=" + DbAdapter.cite(community) + " AND father=0");
                if(db.next())
                {
                    j = db.getInt(1);
                }
            } finally
            {
                db.close();
            }
            if(j == 0)
            {
                j = create(0,"集团","com",0,0,"","","",community,"webmaster","","","","",false,"","",0,0);
            }
            root = new Integer(j);
            _cache.put(community,root);
        }
        return root.intValue();
    }

    public void setCommunity(String community)
    {
        this.community = community;
    }

    public void setSerial(int serial) throws SQLException
    {
        set("serial",String.valueOf(serial));
        this.serial = serial;
    }

    public void setOther3(boolean other3) throws SQLException
    {
        set("other3",other3 ? "1" : "0");
        this.other3 = other3;
    }

    public String getName()
    {
        return name;
    }

    public String getPrefix()
    {
        StringBuilder prefix = new StringBuilder();
        if(path != null)
        {
            String ps[] = path.split("/");
            for(int i = 3;i < ps.length;i++)
            {
                prefix.append("　");
            }
            if(ps.length > 3)
            {
                prefix.append("├");
            }
        }
        return prefix.toString();
    }

    public String getTreeToHtml(int language,int step) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        tree(community,language,step,h);
        return h.toString();
    }

    private void tree(String community,int language,int step,StringBuilder h) throws SQLException
    {
        StringBuilder s = new StringBuilder();
        for(int loop = 0;loop < step;loop++)
        {
            s.append("　");
        }
        if(father > 0)
        {
            Enumeration e = AdminUnitSeq.findByCommunity(community,id,true);
            while(e.hasMoreElements())
            {
                String member = (String) e.nextElement();
                Profile p = Profile.find(member);
                h.append(s);
                h.append("<IMG SRC=/tea/image/tree/tree_minus.gif align=absmiddle >");
                h.append("<A HREF=### onclick=f_click('" + member + "'); ID=a" + step + ">" + p.getName(language) + "</A>");
                h.append("<br>");
            }
//      for (int i = 0; i < 2; i++)
//      {
//        e = AdminUsrRole.find(community, " AND role!='/' AND ( unit=" + id + " OR classes LIKE '%/" + id + "/%' ) AND options NOT LIKE '%/1/%'", 0, Integer.MAX_VALUE);
//        while (e.hasMoreElements())
//        {
//          String member = (String) e.nextElement();
//          AdminUsrRole aur = AdminUsrRole.find(community, member);
//          if ( (i == 0 && aur.getUnit() != id) || (i == 1 && aur.getUnit() == id))
//          {
//            Profile p = Profile.find(member);
//            h.append(s);
//            h.append("<IMG SRC=/tea/image/tree/tree_minus.gif align=absmiddle >");
//            h.append("<A HREF=### onclick=f_click('" + member + "'); ID=a" + step + ">" + p.getName(language) + "</A>");
//            h.append("<br>");
//          }
//        }
//      }
        }
        Enumeration e = AdminUnit.findByCommunity(community," AND father=" + id);
        while(e.hasMoreElements())
        {
            AdminUnit obj = (AdminUnit) e.nextElement();
            int id = obj.getId();
            h.append(s);
            if(step > 0)
            {
                h.append("<img src='/tea/image/tree/tree_plus.gif' align=absmiddle ID=img" + id + " onclick=\"f_ex(" + id + "," + step + ");\" style=\"cursor:hand\">");
            } else
            {
                h.append("<img src=/tea/image/other/img-globe.gif>");
            }
            h.append("<a href=javascript:f_click(" + id + "," + step + "); ID=a" + step + ">" + obj.getName() + "</a>");
            h.append("<br>");

            h.append("<Div id=divid" + id + " style=display:none></Div>");
            if(step == 0 && AdminUnit.findByCommunity(community," AND father=" + id).hasMoreElements()) //当前是第一级,并且有下级部门
            {
                h.append("<script>f_ex(" + id + "," + step + ");</script>");
            }
        }
    }

    public static int Mid(String community,String sql,String m) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("Select " + m + "(id) from AdminUnit where community=" + db.cite(community) + " " + sql);
            if(db.next())
            {
                id = db.getInt(1);
            } else
            {
                id = 0;
            }

        } finally
        {
            db.close();
        }
        return id;
    }


    public int getPid()
    {
        return pid;
    }

    public int getType()
    {
        return type;
    }

    public String getTel()
    {
        return tel;
    }

    public String getFax()
    {
        return fax;
    }

    public int getSequence()
    {
        return sequence;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getSerial()
    {
        return serial;
    }

    public String getCreator()
    {
        return creator;
    }

    public String getAddress()
    {
        return address;
    }

    public String getZip()
    {
        return zip;
    }

    public String getOther()
    {
        return other;
    }

    public String getOther2()
    {
        return other2;
    }

    public boolean isOther3()
    {
        return other3;
    }

    public String getCalling()
    {
        return calling;
    }

    public String getSpecialty()
    {
        return specialty;
    }

    public String getProduct()
    {
        return product;
    }

    public String getLinkmanname()
    {
        return linkmanname;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getEmail()
    {
        return email;
    }

    public String getUrl()
    {
        return url;
    }

    public String getHave_a_project()
    {
        return have_a_project;
    }

    public int getFather()
    {
        return father;
    }

    public String getPath()
    {
        return path;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getContent()
    {
        return content;
    }

    public boolean isEnds()
    {
        return ends;
    }

    public boolean isHiddenorg()
    {
        return hiddenorg;
    }

    public String getEName()
    {
        return ename;
    }

    public static String options(String sql,int value) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        ArrayList al = AdminUnit.find(sql,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            AdminUnit r = (AdminUnit) al.get(i);
            htm.append("<option value=" + r.id);
            if(value == r.id)
                htm.append(" selected");
            htm.append(">" + r.name);
        }
        return htm.toString();
    }

    public static String options(int v,String classes) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = classes.split("/");
        for(int i = 1;i < arr.length;i++)
        {
            AdminUnit d = AdminUnit.find(Integer.parseInt(arr[i]));
            sb.append(d.options(v));
        }
        return sb.toString();
    }

    public String options(int v) throws SQLException
    {
        int len = path.split("/").length - 2;
        StringBuilder sb = new StringBuilder();
        Iterator it = AdminUnit.find(" AND path LIKE '" + path + "%' ORDER BY sequence",0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            AdminUnit t = (AdminUnit) it.next();
            sb.append("<option value=" + t.id + " data=").append(t.toString());
            if(v == t.id)
                sb.append(" selected");
            sb.append(">" + (t.prefix == null ? "" : t.prefix.substring(len * 2)) + t.name);
        }
        return sb.toString();
    }


    //递归图片,null:没有图片
    public String getPictureEx() throws SQLException
    {
        if(!usepic || "".equals(picture))
        {
            if(father > 0)
            {
                return AdminUnit.find(father).getPictureEx();
            }
            return null;
        }
        return picture;
    }

    public boolean isUsePic()
    {
        return usepic;
    }

    public static void ref(int father) throws SQLException
    {
        int[] arr = new int[50];
        Arrays.fill(arr,1);
        ref(father,arr);
    }

    static void ref(int father,int[] seq) throws SQLException
    {
        Iterator it = AdminUnit.find(" AND father=" + father + " ORDER BY sequence",0,1000).iterator();
        while(it.hasNext())
        {
            AdminUnit t = (AdminUnit) it.next();
            //
            StringBuilder sb = new StringBuilder();
            String[] ps = t.path.split("/");
            for(int i = 3;i < ps.length;i++)
                sb.append(seq[i] == 1 ? "│　" : "　　");
            if(ps.length > 2)
            {
                seq[ps.length] = it.hasNext() ? 1 : 0;
                sb.append(it.hasNext() ? "├─" : "└─");
            }
            if(!sb.toString().equals(t.prefix))
                t.set("prefix",t.prefix = sb.toString());
            //
            if(t.seq != seq[0])
                t.set("seq",String.valueOf(t.seq = seq[0]));
            seq[0] += 10;
            //if(t.child > 0)
            ref(t.id,seq);
        }
    }

    //0:DeptTree.jsp  1:多选  2:单选
    //ids:默认展开
    public String toTree(int type,String sql,String ids) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        Iterator it = AdminUnit.find(" AND father=" + id + " AND deleted=0" + sql + " ORDER BY sequence",0,1000).iterator();
        while(it.hasNext())
        {
            AdminUnit t = (AdminUnit) it.next();
            int sum = AdminUnit.count(" AND father=" + t.id + sql);
            boolean sub = sum > 0 && ids.contains("|" + t.id + "|");
            htm.append("<div id='" + t.id + "'><img src='/tea/image/tree/" + (sub || sum == 0 ? "minus" : "plus") + ".gif' onclick='mt.tree(this)' align=absmiddle>");
            if(type == 0)
                htm.append("&nbsp;<a href='###' onclick=mt.act(this,'user')>" + t.name + "</a>");
            else if(type == 1 || type == 2)
                htm.append("<input type='" + (type == 1 ? "checkbox" : "radio") + "' name='depts' value='" + t.id + "' id='d_" + t.id + "' /><label for='d_" + t.id + "'>" + t.name + "</label>");
            htm.append("</div><div class='tree' style='display:" + (sub ? "" : "none") + "'>");
            if(sub)
                htm.append(t.toTree(type,sql,ids));
            htm.append("</div>\r\n");
        }
        return htm.toString();
    }
}
