package tea.entity.admin;

import java.util.*;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;
import java.io.*;
import java.util.regex.*;
import java.sql.SQLException;

public class AdminFunction
{
    public static Cache _cache = new Cache(100);
    public static final String SORT_TYPE[] =
            {"--------------","通讯录","工作日志","我的关注"};
    public static final String MENU_TYPE[] =
            {"文件夹","功能菜单","节点菜单"};

    class AFLayer
    {
        private String name;
        private String url;
        private String content;
    }


    public int id;
    private Hashtable _htAFLayer;
    public int status;
    public int type;
    public String url;
    public String urlig;
    public String urlim;
    public String action; //功能
    public static String[] REMIND_TYPE =
            {"--","提醒","数量"};
    public int remind; //提醒
    public int sort;
    public int sequence;
    public int father;
    public boolean hidden;
    public String community;
    public String target;
    public String icon;
    public String tipoffilepath;
    public boolean exists;

    public AdminFunction(int id) throws SQLException
    {
        _htAFLayer = new Hashtable();
        this.id = id;
    }

    public static AdminFunction find(int id) throws SQLException
    {
        AdminFunction t = (AdminFunction) _cache.get(new Integer(id));
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new AdminFunction(id) : (AdminFunction) al.get(0);
        }
        return t;
    }

    public static Enumeration findUrlig(String community,String member,String ip) throws SQLException
    {
        String menu = AdminUsrRole.find(community,member).getAdminfunction(ip);
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            StringBuilder sql = new StringBuilder("SELECT id FROM AdminFunction WHERE community=");
            sql.append(DbAdapter.cite(community)).append(" AND hidden=1 AND ").append(db.length("urlig")).append(">0 AND ").append(DbAdapter.cite(menu)).append(" LIKE ").append(
                    db.concat("'%/'",db.cast("id","VARCHAR(10)"),"'/%'")).append(" ORDER BY sequence");
            db.executeQuery(sql.toString());
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findUrlim(String community,String member,String ip) throws SQLException
    {
        String menu = AdminUsrRole.find(community,member).getAdminfunction(ip);
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            StringBuilder sql = new StringBuilder("SELECT id FROM AdminFunction WHERE community=");
            sql.append(DbAdapter.cite(community));
            sql.append(" AND hidden=1 AND ");
            sql.append(db.length("urlim")).append(">0 AND ");
            sql.append(DbAdapter.cite(menu)).append(" LIKE ").append(db.concat("'%/'",db.cast("id","VARCHAR(10)"),"'/%'"));
            sql.append(" ORDER BY sequence");
            db.executeQuery(sql.toString());
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"DELETE FROM AdminFunction WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        _cache.remove(community);
    }

    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
            sql = "INSERT INTO AdminFunction(id,community,father,status,type,sort,sequence,hidden,target,icon,urlig,urlim,action,remind,tipoffilepath)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + " ," + father + " ," + status + "," + type + "," + sort + "," + sequence + " ," + DbAdapter.cite(hidden) + " ," + DbAdapter.cite(target) + "," + DbAdapter.cite(icon) + "," + DbAdapter.cite(urlig) + "," + DbAdapter.cite(urlim) + "," + DbAdapter.cite(action) + "," + remind + "," + DbAdapter.cite(tipoffilepath) + " )";
        else
            sql = "UPDATE AdminFunction SET type=" + type + ",url=" + DbAdapter.cite(url) + ",sort=" + sort + ",sequence=" + sequence + ",hidden=" + DbAdapter.cite(hidden) + ",target=" + DbAdapter.cite(target) + ",icon=" + DbAdapter.cite(icon) + ",urlig=" + DbAdapter.cite(urlig) + ",urlim=" + DbAdapter.cite(urlim) + ",action=" + DbAdapter.cite(action) + ",remind=" + remind + ",tipoffilepath=" + DbAdapter.cite(tipoffilepath) + "  WHERE id=" + id;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"UPDATE AdminFunction SET " + f + "=" + DbAdapter.cite(v) + "  WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }

    public void setLayer(int language,String name,String url,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            int j = db.executeUpdate(id,"UPDATE AdminFunctionLayer SET name=" + DbAdapter.cite(name) + ",url=" + DbAdapter.cite(url) + ",content=" + DbAdapter.cite(content) + " WHERE adminfunction=" + id + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate(id,"INSERT INTO AdminFunctionLayer(adminfunction,language,name,url,content)VALUES(" + id + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(content) + ")");
            }
        } finally
        {
            db.close();
        }
        _htAFLayer.clear();
    }

    public void set(String name,int type,String url,int sort,int sequence,int father,boolean hidden,String community,String target,String icon,String urlig,String urlim,String content,int language,String tipoffilepath) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeUpdate(id,"UPDATE AdminFunction SET type=" + type + ",url=" + DbAdapter.cite(url) + ",sort=" + sort + ",sequence=" + sequence + ",hidden=" + DbAdapter.cite(hidden) + ",target=" + DbAdapter.cite(target) + ",icon=" + DbAdapter.cite(icon) + ",urlig=" + DbAdapter.cite(urlig) + ",urlim=" + DbAdapter.cite(urlim) + ",action=" + DbAdapter.cite(action) + ",remind=" + remind + ",tipoffilepath=" + DbAdapter.cite(tipoffilepath) + "  WHERE id=" + id);
                int j = db.executeUpdate(id,"UPDATE AdminFunctionLayer SET name=" + DbAdapter.cite(name) + ",url=" + DbAdapter.cite(url) + ",content=" + DbAdapter.cite(content) + " WHERE adminfunction=" + id + " AND language=" + language);
                if(j < 1)
                {
                    db.executeUpdate(id,"INSERT INTO AdminFunctionLayer(adminfunction,language,name,url,content)VALUES(" + id + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(content) + ")");
                }
            } finally
            {
                db.close();
            }
            this.type = type;
            this.url = url;
            this.sort = sort;
            this.sequence = sequence;
            this.hidden = hidden;
            this.target = target;
            this.icon = icon;
            this.urlig = urlig;
            this.urlim = urlim;
            this.tipoffilepath = tipoffilepath;
            _htAFLayer.clear();
        } else
        {
            create(community,father,0,type,url,sort,sequence,hidden,target,icon,urlig,urlim,language,name,content,tipoffilepath);
        }
    }

    public static AdminFunction getRoot(String community,int status) throws SQLException
    {
        ArrayList al = find(" AND father=0 AND community=" + DbAdapter.cite(community),0,1);
        if(al.size() > 0)
        {
            return(AdminFunction) al.get(0);
        }
        int root = create(community,0,status,0,"",0,0,true,"m","","","",1,"后台管理",null,null);
        int frame = create(community,root,status,0,null,0,0,true,"m","","",null,1,"结构管理",null,null);
        int menu = create(community,frame,status,1,"/jsp/admin/popedom/AdminFunctions.jsp",0,0,true,"m","","",null,1,"菜单管理",null,null);
        int afrole = create(community,frame,status,1,"/jsp/admin/popedom/AdminRoles.jsp",0,0,true,"m","","",null,1,"角色管理",null,null);
        int afuser = create(community,frame,status,1,"/jsp/admin/popedom/AdminUsrRoles.jsp",0,0,true,"m","","",null,1,"用户管理",null,null);
        int afuser1 = create(community,frame,status,1,"/jsp/profile/Member1s.jsp",0,0,true,"m","","",null,1,"管理员列表",null,null);
        int afunit = create(community,frame,status,1,"/jsp/admin/popedom/AdminUnits.jsp",0,0,true,"m","","",null,1,"部门管理",null,null);
        int access = create(community,root,status,0,null,0,0,true,"m","","",null,1,"访问统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp",0,0,true,"m","","",null,1,"简要数据",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=hot",0,0,true,"m","","",null,1,"热门话题",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=hour",0,0,true,"m","","",null,1,"24小时统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=day",0,0,true,"m","","",null,1,"日统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=month",0,0,true,"m","","",null,1,"月统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=where",0,0,true,"m","","",null,1,"地区统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=referer",0,0,true,"m","","",null,1,"来源统计",null,null);
        create(community,access,status,1,"/jsp/count/index.jsp?act=last20",0,0,true,"m","","",null,1,"最后二十位访问",null,null);
        create(community,access,status,1,"/jsp/count/CountManage.jsp",0,0,true,"m","","",null,1,"访问统计管理",null,null);
        AdminFunction af = find(root);
        // af.create_glance();
        // af.create_dynamic();
        int logout = create(community,root,status,1,"/servlet/Logout",0,Integer.MAX_VALUE,true,"_top","","",null,1,"退出系统",null,null); //
        String menus = "|" + frame + ":|" + menu + ":|" + afrole + ":|" + afuser + ":|" + afuser1 + ":|" + afunit + ":|" + logout + ":|";
        // 创建角色
        int role = AdminRole.create(community,status,1,new Date(),null,"超级管理员");
        AdminRole obj_ar = AdminRole.find(role);
        obj_ar.setAdminfunction(menus,menus);
        // 把角色赋给会员
        int member = Profile.find("webmaster").getProfile();
        AdminUsrRole aur_obj = AdminUsrRole.find(community,member);
        if(aur_obj.isExists())
        {
            aur_obj.setRole(aur_obj.getRole() + role + "/");
        } else
        {
            AdminUsrRole.create(community,member,aur_obj.getRole() + role + "/","/",0,"/","/");
        }
        return af;
    }

    public static int getRootId(String community,int status) throws SQLException
    {
        return getRoot(community,status).id;
    }

    public static int create(String community,int father,int status,int type,String url,int sort,int sequence,boolean hidden,String target,String icon,String urlig,String urlim,int language,String name,String content,String tipoffilepath) throws SQLException
    {
        if(sequence == 0)
        {
            sequence = (int) (System.currentTimeMillis() / 1000 - 1230739200);
        }
        int id = 0;
        String sql = "INSERT INTO AdminFunction (id,community,father,status,type,sort,sequence,hidden,target,icon,urlig,urlim,tipoffilepath)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + father + "," + status + "," + type + "," + sort + "," + sequence + "," + DbAdapter.cite(hidden) + "," + DbAdapter.cite(target) + "," + DbAdapter.cite(icon) + "," + DbAdapter.cite(urlig) + "," + DbAdapter.cite(urlim) + "," + DbAdapter.cite(tipoffilepath) + " )";
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,sql);
            db.executeUpdate(id,"INSERT INTO AdminFunctionLayer (adminfunction, language, name,url,content)VALUES(" + id + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(content) + ")");
        } finally
        {
            db.close();
        }
        return id;
    }

    // 查询是否需要弹出提示
    public static String findtipoffilepath(int id) throws SQLException
    {
        String tip = "";
        boolean isexist = false;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("select tipoffilepath from adminfunction where id=" + id + "");
            while(db.next())
            {
                tip = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return tip;
    }

    public void clone(int aimId,String community,int status,boolean son) throws SQLException
    {
        int newid = 0;
        String sql = "INSERT INTO AdminFunction (id,community,father,status,type,sort,sequence,hidden,target,icon,urlig,urlim)VALUES(" + (newid = Seq.get()) + "," + DbAdapter.cite(community) + "," + aimId + "," + status + "," + getType() + "," + getSort() + "," + getSequence() + "," + DbAdapter.cite(isHidden()) + "," + DbAdapter.cite(getTarget()) + "," + DbAdapter.cite(getIcon()) + "," + DbAdapter.cite(getUrlig()) + "," + DbAdapter.cite(getUrlim()) + ")";
        DbAdapter db = new DbAdapter(1);
        DbAdapter db2 = new DbAdapter(1);
        try
        {
            db.executeUpdate(newid,sql);
            db.executeQuery("SELECT language FROM AdminFunctionLayer WHERE adminfunction=" + id);
            while(db.next())
            {
                int lan = db.getInt(1);
                db2.executeUpdate(newid,"INSERT INTO AdminFunctionLayer(adminfunction,language,name,url,content)VALUES(" + newid + "," + getLanguage(lan) + "," + db.cite(getName(lan)) + "," + db.cite(getUrl(lan)) + "," + db.cite(getContent(lan)) + ")");
            }
        } finally
        {
            db.close();
            db2.close();
        }
        Enumeration e1 = Help.findByCommunity(getCommunity()," AND id=" + id,0,Integer.MAX_VALUE);
        while(e1.hasMoreElements())
        {
            int hid = ((Integer) e1.nextElement()).intValue();
            Help obj = Help.find(hid);
            obj.clone(newid,community);
        }
        if(son)
        {
            Enumeration e2 = AdminFunction.findByFather(id);
            while(e2.hasMoreElements())
            {
                int _id = ((Integer) e2.nextElement()).intValue();
                AdminFunction obj = AdminFunction.find(_id);
                obj.clone(newid,community,status,true);
            }
        }
    }

    public static Enumeration findByFather(int father) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT id FROM AdminFunction WHERE father=" + father + " ORDER BY sequence");
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static ArrayList find(String sql,Http h) throws SQLException
    {
        //String sql = " AND father=" + father;
        if(h != null)
        {
            String ip = h.request.getRemoteAddr(),xff = h.request.getHeader("X-Forwarded-For");
            if(xff != null && (ip.startsWith("127.") || ip.startsWith("10.") || ip.startsWith("168.")))
                ip = xff;
            sql += " AND hidden=1 AND " + DbAdapter.cite(AdminUsrRole.find(h.community,h.member).getAdminfunction(ip)) + " LIKE " + DbAdapter.concat("'%|'",DbAdapter.cast("id","VARCHAR(10)"),"':%'");
        }
        return find(sql + " ORDER BY sequence,id",0,200);
    }

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND afl."))
            sb.append(" LEFT JOIN AdminFunctionLayer afl ON afl.adminfunction=af.id");
        //
        return sb.toString();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT af.id,af.community,af.father,af.status,af.type,af.url,af.sort,af.sequence,af.hidden,af.target,af.icon,af.urlig,af.urlim,af.action,af.remind,af.tipoffilepath FROM AdminFunction af" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                AdminFunction t = new AdminFunction(db.getInt(j++));
                t.community = db.getString(j++);
                t.father = db.getInt(j++);
                t.status = db.getInt(j++);
                t.type = db.getInt(j++);
                t.url = db.getString(j++);
                t.sort = db.getInt(j++);
                t.sequence = db.getInt(j++);
                t.hidden = "1".equals(db.getString(j++));
                t.target = db.getString(j++);
                t.icon = db.getString(j++);
                t.urlig = db.getString(j++);
                t.urlim = db.getString(j++);
                t.action = db.getString(j++);
                t.remind = db.getInt(j++);
                t.tipoffilepath = db.getString(j++);
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

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT id FROM AdminFunction WHERE");
        if(community != null)
        {
            sb.append(" community=" + DbAdapter.cite(community));
        } else
        {
            sb.append(" 1=1");
        }
        sb.append(sql).append(" ORDER BY sequence");
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM AdminFunction WHERE community=" + db.cite(community) + sql);
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public int getId()
    {
        return id;
    }

    public String getName(int language) throws SQLException
    {
        return getAFLayer(language).name;
    }

    private AFLayer getAFLayer(int i) throws SQLException
    {
        AFLayer layer = (AFLayer) _htAFLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new AFLayer();
            int j = getLanguage(i);
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT name,url,content FROM AdminFunctionLayer WHERE adminfunction=" + id + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.url = db.getVarchar(j,i,2);
                    layer.content = db.getVarchar(j,i,3);
                }
            } finally
            {
                db.close();
            }
            _htAFLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT language FROM AdminFunctionLayer WHERE adminfunction=" + id);
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
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public int getType()
    {
        return type;
    }

    public String getTipoffilepath()
    {
        return tipoffilepath;
    }

    public String getUrl(int language) throws SQLException
    {
        String lurl = getAFLayer(language).url;
        if(lurl == null || lurl.length() < 1)
        {
            lurl = url;
        }
        return lurl;
    }

    public String getContent(int language) throws SQLException
    {
        return getAFLayer(language).content;
    }

    public String getUrlig()
    {
        return urlig;
    }

    public String getUrlim()
    {
        return urlim;
    }

    public int getSort()
    {
        return sort;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getFather()
    {
        return father;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getTarget()
    {
        return target;
    }

    public String getIcon()
    {
        return icon;
    }

    public boolean isSon(int newfather) throws SQLException
    {
        if(newfather == id)
        {
            return true;
        }
        do
        {
            AdminFunction obj = AdminFunction.find(newfather);
            newfather = obj.getFather();
            if(!obj.isExists() || newfather == id)
            {
                return true;
            }
            if(newfather == 0)
            {
                return false;
            }
        } while(true);
    }

    public void move(String community,int father,int status) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(id,"UPDATE AdminFunction SET community=" + db.cite(community) + ",father=" + father + ",status=" + status + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        this.community = community;
        this.father = father;
        this.status = status;
    }

    public String getPath() throws SQLException
    {
        return(father < 1 ? "|" : AdminFunction.find(father).getPath()) + id + "|";
    }

    public String getTreeToHtml(Http h) throws SQLException
    {
        int step = getPath().split("[|]").length - 3;
        StringBuilder htm = new StringBuilder();
        tree(h,step,htm);
        return htm.toString();
    }

    private void tree(Http h,int step,StringBuilder htm) throws SQLException
    {
        boolean def = false;
        StringBuilder sb = new StringBuilder();
        for(int loop = 0;loop < step;loop++)
        {
            sb.append("　 ");
        }
        ArrayList al = AdminFunction.find(" AND father=" + id,h);
        for(int i = 0;i < al.size();i++)
        {
            AdminFunction obj = (AdminFunction) al.get(i);

            int type = obj.getType();
            if(h.status == 0)
            {
                htm.append("<span id=leftuptree" + step + ">").append(sb);
                if(type == 0 || type == 2)
                {
                    htm.append("<a href=### onclick=tree(this," + obj.type + ") id=m" + obj.id + "><img src=/tea/image/tree/tree_plus.gif align=absmiddle id=img" + obj.id + " />" + obj.getName(h.language) + "</a>");
                } else
                { // 功能菜单
                    htm.append("<img src=/tea/image/tree/tree_blank.gif align=absmiddle id=img" + obj.id + " />");
                    String url = "/jsp/admin/right.jsp?id=" + obj.id + "&node=" + h.node + "&";
                    htm.append("<a href=" + url + " target=" + obj.getTarget() + " onclick='tree(this," + obj.type + ")' id='m" + obj.id + "' >" + obj.getName(h.language));
                    if(obj.remind > 0)
                    {
                        int j = 0;
                        if(obj.type == 1 && obj.url.length() > 0)
                            j = obj.getRemind(h);
                        htm.append("<span class='remind" + obj.remind + "'").append(j > 0 ? "" : " style='display:none'").append(">(" + j + ")</span>");
                    }
                    htm.append("</a>");
                    if(def)
                    {
                        def = false;
                        htm.append("<script>window.open('" + url + "','" + obj.getTarget() + "');</script>");
                    }
                }
                htm.append("</span>");

                htm.append("<div id=divid" + obj.id + " style=display:none>");
                if(def)
                {
                    System.out.println(obj.id + "/" + obj.father);
                    obj.tree(h,step + 1,htm);
                    htm.append("<script>f_click(" + obj.id + "," + step + ");</script>");
                    def = false;
                }
                htm.append("</div>");
            } else if(h.status == 1) // 手机版
            {
                htm.append("<li id=leftuptree" + step + " >");
                if(type == 0)
                {
                    htm.append(obj.getName(h.language));
                } else
                {
                    // 功能菜单
                    htm.append("<a href=/jsp/admin/right.jsp?id=" + obj.id + "&node=" + h.node + "&community=" + h.community + "&info=" + Http.enc(obj.getName(h.language)) + " >" + obj.getName(h.language) + "</a>");
                }
                htm.append("</li>");

                htm.append("<ul id=divid" + obj.id + " >");
                obj.tree(h,step + 1,htm);
                htm.append("</ul>");
            }
        }
    }

    public int getRemind(Http h)
    {
        int j = 0;
        try
        {
            String str = h.read(url + (url.indexOf('?') == -1 ? '?' : '&') + "id=" + id + "&act=remind&acts=" + getAction(h));
            if(str.startsWith("﻿"))
                str = str.substring(1);
            if((str = str.trim()).length() < 1)
                return j;
            if(str.charAt(0) != '<' && str.charAt(0) != '无')
                j = Integer.parseInt(str);
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
        return j;
    }

    //操作项
    public String getAction(Http h) throws SQLException
    {
        String menus = AdminUsrRole.find(h.community,h.member).getAdminfunction(h.request.getRemoteAddr());
        int j = menus.indexOf("|" + id + ":");
        if(menus.indexOf("|" + id + "|") == -1 && j == -1)
            return null;

        StringBuilder acts = new StringBuilder();
        Matcher m = Pattern.compile("[|]" + id + ":([^|]+)").matcher(menus);
        while(m.find())
        {
            acts.append(m.group(1));
        }
        return acts.toString();
    }

    public void setAction(Http h) throws SQLException
    {
        String url = getUrl(h.language);
        try
        {
            if(url.startsWith("/servlet/Logout"))
                return;
            action = h.read(url + (url.indexOf('?') == -1 ? '?' : '&') + "act=action");
            if(action.startsWith("﻿"))
                action = action.substring(1);
            if((action = action.trim()).length() < 1 || action.length() > 50)
                action = null;
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    public int getStatus()
    {
        return status;
    }

    public static String getSysMenu(TeaSession teasession,String key) throws Exception
    {
        byte by[] = new byte[81920];
        InputStream fis = Class.forName("tea.entity.admin.AdminFunction").getResourceAsStream("/tea/menu.properties");
        int len = fis.read(by);
        fis.close();
        String h = new String(by,0,len,"utf-8");
        int of = h.indexOf("#" + key) + 1;
        if(of < 1)
        {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        int e = h.indexOf('#',of);
        h = h.substring(of,e == -1 ? h.length() : e).replaceAll("\r","").replaceAll("(\n\n)+","\n");
        String arr[] = h.split("\n");
        sb.append("<table cellspacing='0' cellpadding='0' width='100%' onMouseOver=\"this.parentNode.style.display='none';\">");
        for(int i = 1;i < arr.length;i++)
        {
            String ps[] = arr[i].split(",");
            if("-".equals(ps[0]))
            {
                sb.append("<tr style='background-color:#CCCCCC;line-height:1px'><td colspan='3'>&nbsp;");
            } else
            {
                sb.append("<tr style='line-height:20px;' onMouseOver='sys_menu_over(this)' onMouseOut='sys_menu_out(this)'");
                if(ps.length == 1)
                {
                    sb.append("><td>&nbsp;《");
                } else
                {
                    sb.append(" onclick=\"window.open('" + ps[1] + (ps[1].indexOf('?') == -1 ? '?' : '&') + "community=" + teasession._strCommunity + "&node=" + teasession._nNode + "','_self');\"><td>　&nbsp;");
                }
                sb.append("</td><td>").append(ps[0]);
            }
            sb.append("</td></tr>");
        }
        sb.append("</table>");
        return sb.toString();
    }


    // 菜单组创建/////////////////////////////////////////////////////////////////////////////////////////////////
    public static String GROUP_NAME[] =
            {"all","other","poll","glance","office","ig","favorite","dd","subscibe","msn","goods","order","copyright","search","clickhistory","netdisk","sms","job","bbs","dynamic","bargain","confab","criterion"
            ,"csv","score","flow","account","travel","community","schoolfinance","tools","blog","timade","filecenter","eon"};
    public int createGroup(String group) throws SQLException
    {
        int root = 0;
        if(group.equals("all"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"=============",null,null);
            AdminFunction af = AdminFunction.find(root);
            for(int i = 1;i < GROUP_NAME.length;i++)
            {
                af.createGroup(GROUP_NAME[i]);
            }
        } else
        if(group.equals("other"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"附件",null,null);
            create(community,root,0,1,"/jsp/type/EditNodeExtractor.jsp?node=1023",0,0,true,"m","","",null,1,"抽取文件内容,创建节点",null,null);
        } else if(group.equals("poll"))
        {
            // fm1073志愿者管理
            // /jsp/admin/fm1073/ProfilePostulants.jsp
            // 志愿者注册
            // /jsp/admin/fm1073/EditProfilePostulant.jsp
            root = create(community,0,id,0,null,0,0,true,"m","","",null,1,"投票类",null,null);
            create(community,root,0,1,"/jsp/type/poll/PollResults2.jsp",0,0,true,"m","","",null,1,"会员得分",null,null);
            create(community,root,0,1,"/jsp/type/poll/PollResults3.jsp",0,0,true,"m","","",null,1,"投票结果-1",null,null);
            create(community,root,0,1,"/jsp/type/poll/PollResults4.jsp",0,0,true,"m","","",null,1,"投票结果-2",null,null);
        } else if(group.equals("glance"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"我的世界",null,null);
            int phonebook = create(community,root,0,0,null,0,0,true,"m","","/jsp/admin/ig/IgAddressBook.jsp",null,1,"通讯录",null,null);
            create(community,phonebook,0,1,"/jsp/sms/psmanagement/GroupManage.jsp",0,0,true,"m","","",null,1,"组管理",null,null);
            create(community,phonebook,0,1,"/jsp/sms/psmanagement/PhoneBookManage.jsp",0,0,true,"m","","",null,1,"朋友列表",null,null);
            int memberinfo = create(community,root,0,0,null,0,0,true,"m","","",null,1,"会员档案",null,null);
            create(community,memberinfo,0,1,"/jsp/user/EditAddress.jsp",0,0,true,"m","","",null,1,"编辑地址",null,null);
            create(community,memberinfo,0,1,"/jsp/user/ChangePassword.jsp",0,0,true,"m","","",null,1,"更改密码",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/LoginHistory.jsp",0,0,true,"m","","",null,1,"登录历史",null,null);
            create(community,memberinfo,0,1,"/jsp/add/Reminders.jsp",0,0,true,"m","","",null,1,"备忘提醒",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/Associates.jsp",0,0,true,"m","","",null,1,"助手",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/BuyInstructions.jsp",0,0,true,"m","","",null,1,"购买指令",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/Shippings.jsp",0,0,true,"m","","",null,1,"发货",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/Coupons.jsp",0,0,true,"m","","",null,1,"优惠券",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/EditHome.jsp",0,0,true,"m","","",null,1,"我的留言",null,null);
            create(community,memberinfo,0,1,"/jsp/profile/CancelMembership.jsp",0,0,true,"m","","",null,1,"注销自已",null,null);
            int feedback = create(community,root,0,0,null,0,0,true,"m","","",null,1,"回馈",null,null);
            create(community,feedback,0,1,"/jsp/feedback/Feedbacks.jsp",0,0,true,"m","","",null,1,"回馈",null,null);
            int node = create(community,root,0,0,null,0,0,true,"m","","",null,1,"节点",null,null);
            create(community,node,0,1,"/jsp/node/TalkbackedNodes.jsp",0,0,true,"m","","",null,1,"被回应的节点",null,null);
            create(community,node,0,1,"/jsp/node/TalkbackingNodes.jsp",0,0,true,"m","","",null,1,"参加回应的节点",null,null);
            create(community,node,0,1,"/jsp/node/AdedNodes.jsp",0,0,true,"m","","",null,1,"发布广告的节点",null,null);
            create(community,node,0,1,"/jsp/node/AdingNodes.jsp",0,0,true,"m","","",null,1,"招广告的节点",null,null);
            create(community,node,0,1,"/jsp/node/ListedNodes.jsp",0,0,true,"m","","",null,1,"被列举的节点",null,null);
            create(community,node,0,1,"/jsp/node/ListingNodes.jsp",0,0,true,"m","","",null,1,"定义列举的节点",null,null);
            create(community,node,0,1,"/jsp/node/FavoriteNodes.jsp",0,0,true,"m","","",null,1,"收藏的节点",null,null);
            int offer = create(community,root,0,0,null,0,0,true,"m","","",null,1,"提供",null,null);
            create(community,offer,0,1,"/jsp/offer/ShoppingCarts.jsp",0,0,true,"m","","",null,1,"购物车",null,null);
            create(community,offer,0,1,"/jsp/offer/Bids.jsp",0,0,true,"m","","",null,1,"拍卖",null,null);
            create(community,offer,0,1,"/jsp/offer/Bargains.jsp",0,0,true,"m","","",null,1,"议价",null,null);
            int order = create(community,root,0,0,"/jsp/order/SaleOrders2.jsp?Type=1",0,0,true,"m","","",null,1,"销售单",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=0",0,0,true,"m","","",null,1,"新订单",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=1",0,0,true,"m","","",null,1,"取消订单",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=2",0,0,true,"m","","",null,1,"接收",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=3",0,0,true,"m","","",null,1,"确认",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=4",0,0,true,"m","","",null,1,"准备发货",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=5",0,0,true,"m","","",null,1,"已经发货",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=6",0,0,true,"m","","",null,1,"付款",null,null);
            create(community,order,0,1,"/jsp/order/SaleOrders3.jsp?Type=1&Status=7",0,0,true,"m","","",null,1,"完成",null,null);
            int order2 = create(community,root,0,0,"/jsp/order/PurchaseOrders.jsp?type=1",0,0,true,"m","","",null,1,"购买单",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=0",0,0,true,"m","","",null,1,"新订单",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=1",0,0,true,"m","","",null,1,"取消订单",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=2",0,0,true,"m","","",null,1,"接收",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=3",0,0,true,"m","","",null,1,"确认",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=4",0,0,true,"m","","",null,1,"准备发货",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=5",0,0,true,"m","","",null,1,"已经发货",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=6",0,0,true,"m","","",null,1,"付款",null,null);
            create(community,order2,0,1,"/jsp/order/PurchaseOrders.jsp?type=1&Status=7",0,0,true,"m","","",null,1,"完成",null,null);

            int c = create(community,root,0,0,"/jsp/community/Communities.jsp",0,0,true,"m","","",null,1,"社区",null,null);
            create(community,c,0,1,"/jsp/community/JoiningCommunities.jsp",0,0,true,"m","","",null,1,"正在加入的社区",null,null);
            create(community,c,0,1,"/jsp/community/JoinedCommunities.jsp",0,0,true,"m","","",null,1,"已经加入的社区",null,null);
            create(community,c,0,1,"/jsp/community/OrganizingCommunities.jsp",0,0,true,"m","","",null,1,"组织的社区",null,null);
            int message = create(community,root,0,0,"/jsp/message/MessageFolders.jsp",0,0,true,"m","","",null,1,"消息文件夹",null,null);
            create(community,message,0,1,"/jsp/message/Messages.jsp?folder=0",0,0,true,"m","","",null,1,"收信箱",null,null);
            create(community,message,0,1,"/jsp/message/Messages.jsp?folder=1",0,0,true,"m","","",null,1,"发信箱",null,null);
            create(community,message,0,1,"/jsp/message/Messages.jsp?folder=2",0,0,true,"m","","",null,1,"草稿箱",null,null);
            create(community,message,0,1,"/jsp/message/Messages.jsp?folder=3",0,0,true,"m","","",null,1,"废纸箱",null,null);
            create(community,message,0,1,"/jsp/message/ManageMessageFolders.jsp",0,0,true,"m","","",null,1,"管理信箱",null,null);
            create(community,message,0,1,"/jsp/message/EmailBoxs.jsp",0,0,true,"m","","",null,1,"电子邮箱",null,null);
            create(community,message,0,1,"/jsp/criterion/Callboards.jsp",0,0,true,"m","","",null,1,"公告信息",null,null);
            int request = create(community,root,0,0,"/jsp/community/Communities.jsp",0,0,true,"m","","",null,1,"请求",null,null);
            create(community,request,0,1,"/jsp/request/ProfileRequests.jsp",0,0,true,"m","","",null,1,"详细地址请求",null,null);
            create(community,request,0,1,"/jsp/request/JoinRequestCommunities.jsp",0,0,true,"m","","",null,1,"加入请求社区",null,null);
            create(community,request,0,1,"/jsp/request/AdRequestNodes.jsp",0,0,true,"m","","",null,1,"广告请求节点",null,null);
            create(community,request,0,1,"/jsp/request/AccessRequestNodes.jsp",0,0,true,"m","","",null,1,"访问请求节点",null,null);
            create(community,request,0,1,"/jsp/request/NodeRequestNodes.jsp",0,0,true,"m","","",null,1,"节点请求节点",null,null);
            int destine = create(community,root,0,0,"/jsp/type/hostel/Destine.jsp",0,0,true,"m","","",null,1,"预定单",null,null);
            create(community,destine,0,1,"/jsp/type/hostel/DestineOrders.jsp",0,0,true,"m","","",null,1,"预定单",null,null);
            create(community,destine,0,1,"/jsp/type/sorder/PurchaseSOrder.jsp",0,0,true,"m","","",null,1,"服务订单",null,null);
            create(community,destine,0,1,"/jsp/profile/Center.jsp",0,0,true,"m","","",null,1,"消费统计",null,null);
            int resume = create(community,root,0,0,"/jsp/community/Communities.jsp",0,0,true,"m","","",null,1,"简历",null,null);
            create(community,resume,0,1,"/jsp/type/resume/Resume.jsp",0,0,true,"m","","",null,1,"我的简历",null,null);
            create(community,resume,0,1,"/jsp/type/job/AppHistory.jsp",0,0,true,"m","","",null,1,"我的职位",null,null);
            int sms = create(community,root,0,0,null,0,0,true,"m","","",null,1,"短信系统",null,null);
            create(community,sms,0,1,"/jsp/sms/EditSMSMessage.jsp",0,0,true,"m","","",null,1,"发送短信",null,null);
            create(community,sms,0,1,"/jsp/sms/SMSMessageList.jsp",0,0,true,"m","","",null,1,"短信发送记录",null,null);
            create(community,sms,0,1,"/jsp/sms/SMSRMessageList.jsp",0,0,true,"m","","",null,1,"回复短信记录",null,null);
            create(community,sms,0,1,"/jsp/community/Subscribers.jsp?Community=" + community,0,0,true,"m","","",null,1,"用户管理",null,null);
            create(community,sms,0,1,"/jsp/sms/EditSMSProfile.jsp",0,0,true,"m","","",null,1,"自动回复",null,null);
            create(community,sms,0,1,"/jsp/sms/SMSMoneyList.jsp",0,0,true,"m","","",null,1,"充值计录",null,null);
            create(community,sms,0,1,"/jsp/sms/EditSMSEnterCode.jsp",0,0,true,"m","","",null,1,"设置企业号",null,null);
            create(community,sms,0,1,"/jsp/sms/AddSMSMoney.jsp",0,0,true,"m","","",null,1,"EDN-充值",null,null);
            create(community,sms,0,1,"/jsp/sms/SMSEnterprise.jsp",0,0,true,"m","","",null,1,"EDN-创建企业",null,null);
        } else if(group.equals("office"))
        {
            root = create(community,id,0,0,null,0,0,false,"m","","",null,1,"印章管理",null,null);
            create(community,root,0,1,"/jsp/admin/office/Cachets.jsp",0,0,true,"m","","",null,1,"印章管理",null,null);
            create(community,root,0,1,"/jsp/admin/office/Cachets.jsp?control=on",0,0,true,"m","","",null,1,"印章管理(控件)",null,null);
            create(community,root,0,1,"/jsp/admin/office/EditCachetUser.jsp",0,0,true,"m","","",null,1,"印章权限",null,null);
            create(community,root,0,1,"/jsp/admin/office/EditProfileISign.jsp",0,0,true,"m","","",null,1,"个人签名",null,null);
        } else if(group.equals("ig"))
        {
            root = create(community,id,0,0,null,0,0,false,"m","","",null,1,"动态桌面",null,null);
            create(community,root,0,1,"/jsp/admin/DynamicDesktop.jsp?default=true",0,0,true,"m","","",null,1,"默认桌面内容设置",null,null);
        } else if(group.equals("favorite"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"收藏的节点",null,null);
            create(community,root,0,1,"/jsp/node/FavoriteNodes.jsp?type=39",0,0,true,"m","","/jsp/admin/ig/IgFavoriteNodes.jsp?type=39",null,1,"收藏的新闻",null,null);
            create(community,root,0,1,"/jsp/node/FavoriteNodes.jsp?type=34",0,0,true,"m","","/jsp/admin/ig/IgFavoriteNodes.jsp?type=34",null,1,"收藏的商品",null,null);
            create(community,root,0,1,"/jsp/node/FavoriteNodes.jsp?type=21",0,0,true,"m","","/jsp/admin/ig/IgFavoriteNodes.jsp?type=21",null,1,"收藏的企业",null,null);
        } else if(group.equals("dd"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"数据字典",null,null);
            create(community,root,0,1,"/jsp/include/currentlynode.jsp",0,0,true,"m","","",null,1,"当前节点号",null,null);
            create(community,root,0,1,"/jsp/include/currentnodecreator.jsp",0,0,true,"m","","",null,1,"当前节点创建者",null,null);
            create(community,root,0,1,"/jsp/include/nodeclick.jsp",0,0,true,"m","","",null,1,"当前节点访问量",null,null);

        } else if(group.equals("subscibe"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"邮件订阅",null,null); // E-mail订阅
            create(community,root,0,1,"/jsp/subscibe/EditSubscibe.jsp",0,0,true,"m","","",null,1,"订阅页面",null,null); // 订阅页面
            create(community,root,0,1,"/jsp/subscibe/SubscibeFrame.jsp",0,0,true,"m","","",null,1,"发送订阅",null,null); // 发送订阅
            create(community,root,0,1,"/jsp/subscibe/Subscibes.jsp",0,0,true,"m","","",null,1,"订阅管理",null,null); // 订阅管理
        } else if(group.equals("msn"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"在线洽谈",null,null);
            create(community,root,0,1,"/jsp/msn/MsnLogin.jsp",0,0,true,"m","","",null,1,"MSN登陆",null,null);
            create(community,root,0,1,"/jsp/msn/Msntemp.jsp",0,0,true,"m","","",null,1,"编辑客服",null,null);
            create(community,root,0,1,"/jsp/msn/MsnMessages.jsp",0,0,true,"m","","",null,1,"历史记录",null,null);
        } else if(group.equals("goods"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"产品管理",null,null);
            create(community,root,0,1,"/jsp/type/brand/ManageBrand.jsp",0,0,true,"m","","",null,1,"品牌管理",null,null);
            create(community,root,0,1,"/jsp/type/goods/GoodsMemberList.jsp",0,0,true,"m","","",null,1,"产品管理",null,null);
            create(community,root,0,1,"/jsp/type/goods/Suppliers.jsp",0,0,true,"m","","",null,1,"供货商管理",null,null);
            create(community,root,0,1,"/jsp/type/goods/GoodsTypes.jsp",0,0,true,"m","","",null,1,"商品类别",null,null);
            create(community,root,0,1,"/jsp/community/Attributes.jsp",0,0,true,"m","","",null,1,"产品属性",null,null);
            create(community,root,0,1,"/jsp/admin/agent/AgentMembers.jsp",0,0,true,"m","","",null,1,"我的代理商",null,null);
            create(community,root,0,1,"/jsp/admin/agent/AgentManageMembers.jsp",0,0,true,"m","","",null,1,"代理商视图",null,null);
        } else if(group.equals("order"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"订单管理",null,null);
            create(community,root,0,1,"/jsp/order/SaleNewOrder.jsp",0,0,true,"m","","",null,1,"等待收货地址确认",null,null);
            create(community,root,0,1,"/jsp/order/SaleCancelOrder.jsp",0,0,true,"m","","",null,1,"取消的订单",null,null);
            create(community,root,0,1,"/jsp/order/SaleConfirmed.jsp",0,0,true,"m","","",null,1,"等待财务确认",null,null);

            create(community,root,0,1,"/jsp/order/SalePayment.jsp?ps=0",0,0,true,"m","","",null,1,"准备发货-平邮",null,null);
            create(community,root,0,1,"/jsp/order/SalePayment.jsp?ps=1",0,0,true,"m","","",null,1,"准备发货-快递",null,null);
            create(community,root,0,1,"/jsp/order/SalePayment.jsp?ps=2",0,0,true,"m","","",null,1,"准备发货-EMS",null,null);
            create(community,root,0,1,"/jsp/order/SaleUnshipped.jsp?ps=0",0,0,true,"m","","",null,1,"已经发货-平邮",null,null);
            create(community,root,0,1,"/jsp/order/SaleUnshipped.jsp?ps=1",0,0,true,"m","","",null,1,"已经发货-快递",null,null);
            create(community,root,0,1,"/jsp/order/SaleUnshipped.jsp?ps=2",0,0,true,"m","","",null,1,"已经发货-EMS",null,null);

            create(community,root,0,1,"/jsp/order/SaleRejected.jsp",0,0,true,"m","","",null,1,"被拒收的订单",null,null);
            create(community,root,0,1,"/jsp/order/SaleFinished.jsp",0,0,true,"m","","",null,1,"已完成的订单",null,null);
            create(community,root,0,1,"/jsp/order/SaleOrders.jsp",0,0,true,"m","","",null,1,"定单查阅",null,null);

            create(community,root,0,1,"/jsp/pay/StoredValues.jsp",0,0,true,"m","","",null,1,"储存卡管理",null,null);
            int myorder = create(community,id,0,0,null,0,0,true,"m","","",null,1,"我的订单",null,null);
            create(community,myorder,0,1,"/jsp/order/PurchaseOrders.jsp",0,0,true,"m","","",null,1,"我的订单列表",null,null);
            create(community,myorder,0,1,"/jsp/pay/StoredValueLists.jsp",0,0,true,"m","","",null,1,"我的消费记录-储存卡",null,null);

        } else if(group.equals("copyright"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"版权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crzzbas.jsp",0,0,true,"m","","",null,1,"作者信息备案管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbargains0.jsp",0,0,true,"m","","",null,1,"录音制品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbargains1.jsp",0,0,true,"m","","",null,1,"影视制品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbookins.jsp",0,0,true,"m","","",null,1,"计算机软件著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbulletins.jsp",0,0,true,"m","","",null,1,"各类作品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crnotices.jsp",0,0,true,"m","","",null,1,"稿酬管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crtransfers.jsp",0,0,true,"m","","",null,1,"软件著作权转移备案",null,null);
            create(community,root,0,1,"/jsp/copyright/Crcancels.jsp",0,0,true,"m","","",null,1,"软件著作权撤销管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crtransfercontracts.jsp",0,0,true,"m","","",null,1,"转让合同公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/Crcourtcloses.jsp",0,0,true,"m","","",null,1,"法院查封公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/Crupdates.jsp",0,0,true,"m","","",null,1,"变更补充公告",null,null);
            create(community,root,0,1,"/jsp/copyright/Crallows.jsp",0,0,true,"m","","",null,1,"许可合同公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/Crimpawns.jsp",0,0,true,"m","","",null,1,"质押公告信息",null,null);

            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"版权-公告",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbargain0Query.jsp",0,0,true,"m","","",null,1,"录音制品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/Crbargain1Query.jsp",0,0,true,"m","","",null,1,"影视制品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/CrbookinQuery.jsp",0,0,true,"m","","",null,1,"计算机软件著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/CrbulletinQuery.jsp",0,0,true,"m","","",null,1,"各类作品著作权管理",null,null);
            create(community,root,0,1,"/jsp/copyright/CrnoticeQuery.jsp",0,0,true,"m","","",null,1,"稿酬管理",null,null);
            create(community,root,0,1,"/jsp/copyright/CrtransferQuery.jsp",0,0,true,"m","","",null,1,"软件著作权转移备案",null,null);
            create(community,root,0,1,"/jsp/copyright/CrcancelQuery.jsp",0,0,true,"m","","",null,1,"软件著作权撤销管理",null,null);
            create(community,root,0,1,"/jsp/copyright/CrtransfercontractQuery.jsp",0,0,true,"m","","",null,1,"转让合同公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/CrcourtcloseQuery.jsp",0,0,true,"m","","",null,1,"法院查封公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/CrupdateQuery.jsp",0,0,true,"m","","",null,1,"变更补充公告",null,null);
            create(community,root,0,1,"/jsp/copyright/CrallowQuery.jsp",0,0,true,"m","","",null,1,"许可合同公告信息",null,null);
            create(community,root,0,1,"/jsp/copyright/CrimpawnQuery.jsp",0,0,true,"m","","",null,1,"质押公告信息",null,null);

        } else if(group.equals("search"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"搜索引擎",null,null);
            create(community,root,0,1,"/jsp/util/LuceneLists.jsp",0,0,true,"m","","",null,1,"栏目设置",null,null);
            // create(community, root,0, true, "/jsp/util/Search.jsp", 0, 0, true,
            // "m", "","", null,1,"搜索页面", null,null);
            create(community,root,0,1,"/jsp/count/index.jsp?act=searchhot",0,0,true,"m","","",null,1,"搜索统计",null,null);
        } else if(group.equals("clickhistory"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"浏览历史",null,null);
            create(community,root,0,1,"/jsp/util/clickhistory/ClickHistorys.jsp",0,0,true,"m","","",null,1,"浏览历史设置",null,null);
        } else if(group.equals("netdisk"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"网络硬盘",null,null);
            create(community,root,0,1,"/jsp/netdisk/NetDiskFrame.jsp",0,0,true,"m","","",null,1,"个人网络硬盘",null,null);
            create(community,root,0,1,"/jsp/netdisk/",0,0,true,"m","","",null,1,"网络硬盘(企业公用)",null,null);
            create(community,root,0,1,"/jsp/netdisk/SafetyFrame.jsp",0,0,true,"m","","",null,1,"网络硬盘用户管理",null,null);
            create(community,root,0,1,"/jsp/netdisk/NetDiskShareList.jsp",0,0,true,"m","","",null,1,"朋友共享的文件",null,null);
            create(community,root,0,1,"/jsp/netdisk/EditMms.jsp",0,0,true,"m","","",null,1,"流媒体文件管理",null,null);
            create(community,root,0,1,"/jsp/section/InsertPicture.jsp?bg=ON",0,0,true,"m","","",null,1,"文件管理(图像浏览)",null,null);
        } else if(group.equals("sms"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"短信系统",null,null);
            create(community,root,0,1,"/jsp/sms/EditSMSMessage.jsp",0,0,true,"m","","",null,1,"发送短信",null,null);
            create(community,root,0,1,"/jsp/sms/SMSMessageList.jsp",0,0,true,"m","","",null,1,"短信发送记录",null,null);
            create(community,root,0,1,"/jsp/sms/SMSRMessageList.jsp",0,0,true,"m","","",null,1,"回复短信记录",null,null);
            create(community,root,0,1,"/jsp/community/Subscribers.jsp?Community=" + community,0,0,true,"m","","",null,1,"用户管理",null,null);
            create(community,root,0,1,"/jsp/sms/EditSMSProfile.jsp",0,0,true,"m","","",null,1,"自动回复",null,null);
            create(community,root,0,1,"/jsp/sms/SMSMoneyList.jsp",0,0,true,"m","","",null,1,"充值计录",null,null);
            create(community,root,0,1,"/jsp/sms/EditSMSEnterCode.jsp",0,0,true,"m","","",null,1,"设置企业号",null,null);
            create(community,root,0,1,"/jsp/sms/SMSScode.jsp",0,0,true,"m","","",null,1,"EDN-特服号设置",null,null);
            create(community,root,0,1,"/jsp/sms/AddSMSMoney.jsp",0,0,true,"m","","",null,1,"EDN-充值",null,null);
            create(community,root,0,1,"/jsp/sms/SMSEnterprise.jsp",0,0,true,"m","","",null,1,"EDN-创建企业",null,null);
            create(community,root,0,1,"/jsp/sms/SMSSubcodes.jsp",0,0,true,"m","","",null,1,"EDN-子号管理",null,null);

        } else if(group.equals("job"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"招聘系统",null,null);
            int membercenter = create(community,root,0,0,null,0,0,true,"m","","",null,1,"会员中心",null,null);
            create(community,membercenter,0,1,"/jsp/type/resume/Resume.jsp",0,0,true,"m","","",null,1,"简历中心",null,null);
            create(community,membercenter,0,1,"/jsp/type/job/AppHistory.jsp",0,0,true,"m","","",null,1,"我的职位夹",null,null);
            int managecenter = create(community,root,0,0,null,0,0,true,"m","","",null,1,"管理中心",null,null);
            create(community,managecenter,0,1,"/jsp/type/company/yjobcompanymanage.jsp",0,0,true,"m","","",null,1,"机构设置",null,null);
            create(community,managecenter,0,1,"/jsp/community/yjobsubscribers.jsp",0,0,true,"m","","",null,1,"用户管理",null,null);
            create(community,managecenter,0,1,"/jsp/type/job/yjobjobmanage.jsp",0,0,true,"m","","",null,1,"职位管理",null,null);
            create(community,managecenter,0,1,"/jsp/type/resume/yjobapplymanage.jsp",0,0,true,"m","","",null,1,"应聘管理",null,null);
            create(community,managecenter,0,1,"/jsp/type/resume/yjobresumemanage.jsp",0,0,true,"m","","",null,1,"简历管理",null,null);
            create(community,root,0,1,"/jsp/type/job/JobEntReg.jsp",0,0,true,"m","","",null,1,"企业会员注册",null,null);
            create(community,root,0,1,"/jsp/type/job/ProfileJobs.jsp",0,0,true,"m","","",null,1,"企业会员审核",null,null);
        } else if(group.equals("bbs"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"论坛管理",null,null);
            int bbs2 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"管理",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/BBSBatDel.jsp",0,0,true,"m","","",null,1,"批量删除",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/BBSManage.jsp",0,0,true,"m","","",null,1,"贴子管理",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/BBSMonitor.jsp",0,0,true,"m","","",null,1,"贴子监督",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/EditBBSHost.jsp",0,0,true,"m","","",null,1,"版主管理",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/ForumManage.jsp",0,0,true,"m","","",null,1,"论坛管理",null,null);
            create(community,bbs2,0,1,"/jsp/type/bbs/InnerPhotoManage.jsp",0,0,true,"m","","",null,1,"照片管理",null,null);
            create(community,bbs2,0,1,"/jsp/section/InsertPicture.jsp?bg=ON",0,0,true,"m","","",null,1,"文件管理",null,null);
            create(community,bbs2,0,1,"/jsp/type/messageboard/MessageBoardManage.jsp",0,0,true,"m","","",null,1,"留言板管理",null,null);
            // create(community,0,"留言板", true,"/jsp/type/bbs/OrolaEditBBS.jsp", 0,
            // 0, bbs2, true, "m", "", 1,null); //
            create(community,root,0,1,"/jsp/type/bbs/EditProfileBBS.jsp",0,0,true,"m","","",null,1,"资料修改",null,null);
            create(community,root,0,1,"/jsp/type/bbs/MyBBS.jsp",0,0,true,"m","","",null,1,"我的帖子",null,null);
            create(community,root,0,1,"/jsp/type/bbs/MyBBSReply.jsp",0,0,true,"m","","",null,1,"我参与的讨论",null,null);
        } else if(group.equals("dynamic"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"动态类",null,null);
            create(community,root,0,1,"/jsp/community/Dynamics.jsp?sort=0",0,0,true,"m","","",null,1,"动态类管理",null,null);
            create(community,root,0,1,"/jsp/community/DynamicSearch.jsp?dynamic=1025",0,0,true,"m","","",null,1,"动态类搜索",null,null);
            create(community,root,0,1,"/jsp/community/EditDCommunity.jsp",0,0,true,"m","","",null,1,"节点设置",null,null);
            create(community,root,0,1,"/jsp/type/category/EditBankCategory.jsp",0,0,true,"m","","",null,1,"应用动态类",null,null);

        } else if(group.equals("bargain"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"合同管理",null,null);
            create(community,root,0,1,"/jsp/type/dynamicvalue/DynamicValues.jsp",0,0,true,"m","","",null,1,"查询历史记录",null,null);
            create(community,root,0,1,"/jsp/community/Dynamics.jsp?sort=1",0,0,true,"m","","",null,1,"添加模板类别",null,null);
            create(community,root,0,1,"/jsp/community/EditDCommunity.jsp",0,0,true,"m","","",null,1,"合同模板类别节点设置",null,null);
            create(community,root,0,1,"/jsp/type/category/EditBankCategory.jsp",0,0,true,"m","","",null,1,"合同模板类别",null,null);
            create(community,root,0,1,"/jsp/type/dynamicvalue/DynamicValuesMember.jsp",0,0,true,"m","","",null,1,"我的合同",null,null);

        } else if(group.equals("confab"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"会议系统",null,null);
            int dynamic_1 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"合同管理",null,null);
            int dynamic_2 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"会议管理",null,null);
            create(community,root,0,1,"/jsp/confab/ConfabLists.jsp",0,0,true,"m","","",null,1,"我的申请表",null,null);
            create(community,dynamic_1,0,1,"/jsp/community/Dynamics.jsp?sort=1",0,0,true,"m","","",null,1,"申请表格式生成",null,null);
            create(community,dynamic_1,0,1,"/jsp/community/EditDCommunity.jsp",0,0,true,"m","","",null,1,"申请表类别设置",null,null);
            create(community,dynamic_1,0,1,"/jsp/type/category/EditBankCategory.jsp",0,0,true,"m","","",null,1,"应用申请表",null,null);
            create(community,dynamic_2,0,1,"/jsp/confab/ConferenceDynamicvalues.jsp",0,0,true,"m","","",null,1,"申请表查询及审核",null,null);
            create(community,dynamic_2,0,1,"/jsp/confab/ConfabReceptions.jsp",0,0,true,"m","","",null,1,"接待安排",null,null);
            create(community,dynamic_2,0,1,"/jsp/confab/ConfabHostels.jsp",0,0,true,"m","","",null,1,"住宿安排",null,null);
        } else if(group.equals("criterion"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"环境标准项目管理",null,null);
            int id_1 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"标准项目管理",null,null);
            int id_1_1 = create(community,id_1,0,0,null,0,0,true,"m","","",null,1,"标准计划管理",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/CreateItems.jsp",0,0,true,"m","","",null,1,"标准立项",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/InitItems.jsp",0,0,true,"m","","",null,1,"标准项目初始化",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/FinishedItems.jsp",0,0,false,"m","","",null,1,"已发布标准的项目",null,null);
            int id_1_1_1 = create(community,id_1_1,0,0,null,0,0,true,"m","","",null,1,"编制单位管理",null,null);
            create(community,id_1_1_1,0,1,"/jsp/criterion/user.jsp",0,0,true,"m","","",null,1,"编制组用户管理",null,null);
            create(community,id_1_1_1,0,1,"/jsp/criterion/unitlist.jsp",0,0,true,"m","","",null,1,"编制单位管理",null,null);
            create(community,id_1_1_1,0,1,"/jsp/criterion/unitlist_2.jsp",0,0,true,"m","","",null,1,"编制组管理",null,null);
            create(community,id_1_1_1,0,1,"/jsp/criterion/ItemClear.jsp",0,0,false,"m","","",null,1,"数据库清空",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/EditgroupItems.jsp",0,0,true,"m","","",null,1,"下达编制组",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/DirectorItems.jsp",0,0,true,"m","","",null,1,"分配标准所管理员",null,null);
            create(community,id_1_1,0,1,"/jsp/criterion/StopItems.jsp",0,0,true,"m","","",null,1,"标准计划中止",null,null);
            int id_1_2 = create(community,id_1,0,0,null,0,0,true,"m","","",null,1,"执行情况查询",null,null);
            create(community,id_1_2,0,1,"/jsp/criterion/StateItems.jsp",0,0,false,"m","","",null,1,"项目状态修改",null,null);
            create(community,id_1_2,0,1,"/jsp/criterion/IssueItems.jsp",0,0,false,"m","","",null,1,"标准发布",null,null);
            create(community,id_1_2,0,1,"/jsp/criterion/Itemstates.jsp",0,0,true,"m","","",null,1,"项目明细",null,null);
            create(community,id_1_2,0,1,"/jsp/criterion/Items.jsp",0,0,true,"m","","",null,1,"项目清单",null,null);
            int id_1_3 = create(community,id_1,0,0,null,0,0,true,"m","","",null,1,"经费管理",null,null);
            int id_1_3_1 = create(community,id_1_3,0,0,null,0,0,true,"m","","",null,1,"项目经费管理",null,null);
            create(community,id_1_3_1,0,1,"/jsp/criterion/Itemoutlays.jsp",0,0,true,"m","","",null,1,"经费划拨及查询",null,null);
            create(community,id_1_3_1,0,1,"/jsp/criterion/Itemoutlays3.jsp",0,0,true,"m","","",null,1,"经费明细表",null,null);
            create(community,id_1_3_1,0,1,"/jsp/criterion/BudgetItems.jsp",0,0,true,"m","","",null,1,"经费预算",null,null);
            int id_1_3_2 = create(community,id_1_3,0,0,null,0,0,true,"m","","",null,1,"总经费管理",null,null);
            create(community,id_1_3_2,0,1,"/jsp/criterion/Outlays.jsp",0,0,true,"m","","",null,1,"新增经费类别",null,null);
            create(community,id_1_3_2,0,1,"/jsp/criterion/Outlays2.jsp",0,0,true,"m","","",null,1,"总经费余额",null,null);
            create(community,id_1_3_2,0,1,"/jsp/criterion/Itemoutlays2.jsp",0,0,true,"m","","",null,1,"总经费流水",null,null);
            int id_2 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"标准项目阶段管理",null,null);
            int id_2_1 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"开题阶段",null,null);
            create(community,id_2_1,0,1,"/jsp/criterion/OpenItems.jsp",0,0,true,"m","","",null,1,"上报开题报告",null,null);
            create(community,id_2_1,0,1,"/jsp/criterion/OpenItems.jsp?action=auditing",0,0,true,"m","","",null,1,"下达",null,null);
            int id_2_2 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"起草阶段",null,null);
            create(community,id_2_2,0,1,"/jsp/criterion/DraftItems.jsp",0,0,true,"m","","",null,1,"上报",null,null);
            create(community,id_2_2,0,1,"/jsp/criterion/DraftItems.jsp?action=auditing",0,0,true,"m","","",null,1,"下达",null,null);
            int id_2_3 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"征求意见阶段",null,null);
            create(community,id_2_3,0,1,"/jsp/criterion/IdeaItems.jsp",0,0,true,"m","","",null,1,"上报征求意见稿",null,null);
            create(community,id_2_3,0,1,"/jsp/criterion/IdeaItems.jsp?action=auditing",0,0,true,"m","","",null,1,"下达",null,null);
            int id_2_4 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"送审阶段",null,null);
            create(community,id_2_4,0,1,"/jsp/criterion/FormulatingItems.jsp",0,0,true,"m","","",null,1,"上传标准报批稿",null,null);
            create(community,id_2_4,0,1,"/jsp/criterion/FormulatingItems.jsp?action=auditing",0,0,true,"m","","",null,1,"下达",null,null);
            int id_2_5 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"报批阶段",null,null);
            create(community,id_2_5,0,1,"/jsp/criterion/LevelItems.jsp",0,0,true,"m","","",null,1,"上传报批搞",null,null);
            create(community,id_2_5,0,1,"/jsp/criterion/LevelItems.jsp?action=auditing",0,0,true,"m","","",null,1,"下达",null,null);
            int id_2_6 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"标准发布",null,null);
            create(community,id_2_6,0,1,"/jsp/criterion/StandardItems.jsp",0,0,true,"m","","",null,1,"上传标准发布稿",null,null);
            create(community,id_2_6,0,1,"/jsp/criterion/StandardItems.jsp?action=auditing",0,0,true,"m","","",null,1,"管理",null,null);
            int id_2_7 = create(community,id_2,0,0,null,0,0,true,"m","","",null,1,"其他阶段",null,null);
            create(community,id_2_7,0,1,"/jsp/criterion/OtherItems.jsp",0,0,true,"m","","",null,1,"其他文件上传",null,null);
            create(community,id_2_7,0,1,"/jsp/criterion/OtherItems.jsp?action=auditing",0,0,true,"m","","",null,1,"查看其他文件",null,null);
            create(community,id_2,0,1,"/jsp/criterion/DocItems.jsp",0,0,true,"m","","",null,1,"文档查询",null,null);
            create(community,id_2,0,1,"/jsp/criterion/Egqbs.jsp",0,0,true,"m","","",null,1,"季报入库",null,null);
            create(community,id_2,0,1,"/jsp/criterion/ArchiveItems.jsp",0,0,true,"m","","",null,1,"存档管理",null,null);
            int id_3 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"资源管理",null,null);
            create(community,id_3,0,1,"/jsp/criterion/Expertres.jsp",0,0,true,"m","","",null,1,"专家库",null,null);
            create(community,id_3,0,1,"/jsp/criterion/Unitres.jsp",0,0,true,"m","","",null,1,"标准编制备选单位",null,null);
            create(community,id_3,0,1,"/jsp/criterion/Referenceres.jsp",0,0,true,"m","","",null,1,"标准文献索引",null,null);
            int id_4 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"消息管理",null,null);
            create(community,id_4,0,1,"/jsp/criterion/Callboards.jsp",0,0,true,"m","","",null,1,"公告信息",null,null);
            int id_5 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"任务管理",null,null);
            create(community,id_5,0,1,"/jsp/criterion/UserItems.jsp",0,0,false,"m","","",null,1,"任务分配",null,null);
            create(community,id_5,0,1,"/jsp/criterion/UserItems2.jsp",0,0,true,"m","","",null,1,"人员变动管理",null,null);
            int id_6 = create(community,root,0,0,null,0,0,true,"m","","",null,1,"我的项目",null,null);
            create(community,id_6,0,1,"/jsp/criterion/Itembasics.jsp",0,0,true,"m","","",null,1,"基本信息",null,null);
            create(community,id_6,0,1,"/jsp/criterion/Itembasicoutlays.jsp",0,0,false,"m","","",null,1,"项目经费信息",null,null);
            create(community,id_6,0,1,"/jsp/criterion/Itempersonnels.jsp",0,0,true,"m","","",null,1,"人员信息",null,null);

        } else if(group.equals("csv"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"牧羊犬俱乐部",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvMembers.jsp",0,0,true,"m","","",null,1,"会员列表",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvcluboutlays.jsp",0,0,true,"m","","",null,1,"交费信息",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvcluboutlays.jsp?receipt=ON",0,0,true,"m","","",null,1,"财务审核是否到账",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvdogs.jsp",0,0,true,"m","","",null,1,"犬只录入",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvxfilms.jsp",0,0,true,"m","","",null,1,"X光片信息",null,null);
            create(community,root,0,1,"/jsp/csvclub/EditCsvxfilm_1.jsp",0,0,true,"m","","",null,1,"X光片检测录入",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvMembers_2.jsp",0,0,true,"m","","",null,1,"欠费会员列表",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvMembers_3.jsp",0,0,true,"m","","",null,1,"会员交费提醒",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvdogs.jsp?c=ON",0,0,true,"m","","",null,1,"会员犬只信息查看",null,null);
            create(community,root,0,1,"/jsp/csvclub/EditCsvcluboutlay_Member.jsp",0,0,true,"m","","",null,1,"我要交费",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvMembers_4.jsp",0,0,false,"m","","",null,1,"滚动会员信息",null,null);
            create(community,root,0,1,"/jsp/csvclub/Csvdogs_2.jsp?action=0",0,0,false,"m","","",null,1,"滚动犬只信息",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvMembersInfo.jsp",0,0,false,"m","","",null,1,"会员信息概况",null,null);
            create(community,root,0,1,"/jsp/csvclub/CsvDogsInfo.jsp",0,0,false,"m","","",null,1,"犬只信息概况",null,null);

        } else if(group.equals("score"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"差点系统",null,null);
            create(community,root,0,1,"/jsp/type/score/EditScore.jsp?nexturl=/servlet/Node%3FNode%3D17312",0,0,true,"m","","",null,1,"提交个人成绩",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreList.jsp",0,0,true,"m","","",null,1,"最近20次成绩",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreHistory.jsp",0,0,true,"m","","",null,1,"历史差点指数",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreManage.jsp",0,0,true,"m","","",null,1,"差点管理",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreQuery.jsp",0,0,true,"m","","",null,1,"查看会友成绩",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreInfo.jsp",0,0,true,"m","","",null,1,"个人资料",null,null);
            create(community,root,0,1,"/jsp/type/score/ScoreManages.jsp",0,0,true,"m","","",null,1,"管理会员",null,null);

        } else if(group.equals("flow"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"OA系统",null,null);
            int flow = create(community,root,0,0,null,0,0,true,"m","","",null,1,"流程系统",null,null);
            create(community,flow,0,1,"/jsp/admin/flow/Flows.jsp",0,0,true,"m","","",null,1,"管理流程",null,null);
            create(community,flow,0,1,"/jsp/admin/flow/Flowitems.jsp",0,0,true,"m","","",null,1,"工作管理",null,null);
            create(community,flow,0,1,"/jsp/admin/flow/Flowitems2.jsp",0,0,true,"m","","",null,1,"待办工作",null,null);
            create(community,flow,0,1,"/jsp/community/Dynamics.jsp?sort=2",0,0,true,"m","","",null,1,"表单管理",null,null);
            int workreport = create(community,root,0,0,null,0,0,true,"m","","/jsp/admin/ig/IgWorklogs.jsp",null,1,"工作报告",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Workprojects.jsp",0,0,true,"m","","",null,1,"客户信息管理",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worklinkmans.jsp",0,0,true,"m","","",null,1,"联系人信息管理",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worktypes.jsp",0,0,true,"m","","",null,1,"工作类型管理",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worklogs.jsp",0,0,true,"m","","",null,1,"我的工作日志",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worklogs_2.jsp",0,0,true,"m","","",null,1,"查看工作日志",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/WorklogAccessories.jsp",0,0,true,"m","","",null,1,"查看日志附件",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/ManualSendWorklog.jsp",0,0,true,"m","","",null,1,"发送工作日志",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worklogs_3.jsp",0,0,true,"m","","",null,1,"客户查看工作日志",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/EditWrTrade.jsp",0,0,true,"m","","",null,1,"销售记录管理",null,null);
            create(community,workreport,0,1,"/jsp/admin/workreport/Worktels.jsp",0,0,true,"m","","",null,1,"电话记录",null,null);
            int sales = create(community,root,0,0,null,0,0,true,"m","","/jsp/admin/ig/IgWorklogs.jsp",null,1,"客户关系",null,null);
            create(community,sales,0,1,"/jsp/admin/sales/latency.jsp",0,0,true,"m","","",null,1,"潜在客户",null,null);
            create(community,sales,0,1,"/jsp/admin/workreport/Workprojects.jsp",0,0,true,"m","","",null,1,"客户",null,null);
            create(community,sales,0,1,"/jsp/admin/sales/SalesLinkmans.jsp",0,0,true,"m","","",null,1,"联系人",null,null);
            create(community,sales,0,1,"/jsp/admin/sales/Saleschanceview.jsp",0,0,true,"m","","",null,1,"业务联系",null,null);
            create(community,sales,0,1,"/jsp/admin/sales/document.jsp",0,0,true,"m","","",null,1,"文档",null,null);
            create(community,sales,0,1,"/jsp/admin/sales/task.jsp",0,0,true,"m","","",null,1,"我的任务",null,null);
            int imp = create(community,sales,0,0,null,0,0,true,"m","","",null,1,"数据管理",null,null);
            create(community,imp,0,1,"/jsp/admin/sales/import1.jsp",0,0,true,"m","","",null,1,"潜在客户",null,null);
            create(community,imp,0,1,"/jsp/admin/workreport/ImportWorkproject1.jsp",0,0,true,"m","","",null,1,"客户",null,null);
            create(community,imp,0,1,"/jsp/admin/sales/affiliationimport1.jsp",0,0,true,"m","","",null,1,"联系人",null,null);

        } else if(group.equals("account"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"个人理财",null,null);
            create(community,root,0,1,"/jsp/type/account/EditAccount.jsp",0,0,true,"m","","",null,1,"添加帐户",null,null);
            create(community,root,0,1,"/jsp/type/account/EditBargaining.jsp",0,0,true,"m","","",null,1,"添加交易",null,null);
            create(community,root,0,1,"/jsp/type/account/BargainingSearch.jsp",0,0,true,"m","","",null,1,"交易搜索",null,null);
            create(community,root,0,1,"/jsp/type/account/EditNetPay.jsp",0,0,true,"m","","",null,1,"添加支付",null,null);
            create(community,root,0,1,"/jsp/type/account/NetPaySearch.jsp",0,0,true,"m","","",null,1,"支付搜索",null,null);
            create(community,root,0,1,"/jsp/type/account/EditTransfer.jsp",0,0,true,"m","","",null,1,"添加转帐",null,null);
            create(community,root,0,1,"/jsp/type/account/TransferSearch.jsp",0,0,true,"m","","",null,1,"转帐搜索",null,null);

        } else if(group.equals("travel"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"旅行社",null,null);
            create(community,root,0,1,"/jsp/type/hostel/Auditing.jsp",0,0,true,"m","","",null,1,"酒店预订管理",null,null);
            create(community,root,0,1,"/jsp/type/travel/TravelShoppingManages.jsp",0,0,true,"m","","",null,1,"线路预订管理",null,null);

        } else if(group.equals("community"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"社区管理",null,null);
            create(community,root,0,1,"/jsp/community/EditFrame.jsp",0,0,true,"m","","",null,1,"社区结构",null,null);
            create(community,root,0,1,"/jsp/community/EditCommunity.jsp",0,0,true,"m","","",null,1,"编辑社区",null,null);
            create(community,root,0,1,"/jsp/community/OrganizingCommunities.jsp",0,0,true,"m","","",null,1,"组织的社区",null,null);
            create(community,root,0,1,"/jsp/site/EditLicense.jsp",0,0,true,"m","","",null,1,"编辑执照",null,null);
            create(community,root,0,1,"/jsp/site/EditDNS.jsp",0,0,true,"m","","",null,1,"网站发布",null,null);
            create(community,root,0,1,"/jsp/community/EditCLicense.jsp",0,0,true,"m","","",null,1,"社区类别",null,null);
            create(community,root,0,1,"/jsp/template/Templates3.jsp",0,0,true,"m","","",null,1,"社区模板设置",null,null);
            create(community,root,0,1,"/jsp/admin/popedom/functionicon.jsp",0,0,true,"m","","",null,1,"菜单图标管理",null,null);
            create(community,root,0,1,"/jsp/site/TypeAliases.jsp",0,0,true,"m","","",null,1,"别名类别",null,null);
            create(community,root,0,1,"/jsp/community/Subscribers.jsp",0,0,true,"m","","",null,1,"会员管理",null,null);
            create(community,root,0,1,"/jsp/community/Organizers.jsp",0,0,true,"m","","",null,1,"组织者",null,null);
            create(community,root,0,1,"/jsp/community/Watermarks.jsp",0,0,true,"m","","",null,1,"水印管理",null,null);
            //
            create(community,root,0,1,"/jsp/community/options/SetEditor.jsp",0,0,true,"m","","",null,1,"编辑器",null,null);
            create(community,root,0,1,"/jsp/community/options/SetEon.jsp",0,0,true,"m","","",null,1,"EON电话",null,null);
            create(community,root,0,1,"/jsp/community/options/SetOpenID.jsp",0,0,true,"m","","",null,1,"OpenID",null,null);
            create(community,root,0,1,"/jsp/community/options/SetDDNS.jsp",0,0,true,"m","","",null,1,"DDNS",null,null);
            create(community,root,0,1,"/jsp/community/options/SetTender.jsp",0,0,true,"m","","",null,1,"招标类设置",null,null);
        } else if(group.equals("schoolfinance"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"学校财政",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SubsidyManage.jsp",0,0,true,"m","","",null,1,"津贴单位管理",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/EditSubsidyOutlay.jsp",0,0,true,"m","","",null,1,"津贴单位组别及总数",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SubsidyTotal.jsp",0,0,true,"m","","",null,1,"经费津贴项目总结",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SubsidyPayout.jsp",0,0,true,"m","","",null,1,"支出预算",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SFAccountManage.jsp",0,0,true,"m","","",null,1,"户口管理",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/EditSFAccountOutlay.jsp",0,0,true,"m","","",null,1,"学校流动现金",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/EditSubsidyForms.jsp",0,0,true,"m","","",null,1,"每月财政报告",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SubsidyMonthList.jsp",0,0,true,"m","","",null,1,"查看每月财政报告",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/SubsidyYearList.jsp",0,0,true,"m","","",null,1,"查看每年财政报告",null,null);
            create(community,root,0,1,"/jsp/admin/schoolfinance/EditSubsidyTime.jsp",0,0,true,"m","","",null,1,"设置提交时间",null,null);

        } else if(group.equals("tools"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"附助工具",null,null);
            create(community,root,0,1,"/jsp/util/Resources.jsp",0,0,true,"m","","",null,1,"资源文件管理",null,null);
            create(community,root,0,1,"/jsp/community/ReplaceData.jsp",0,0,true,"m","","",null,1,"内容替换",null,null);
            create(community,root,0,1,"/jsp/general/RevertData.jsp",0,0,true,"m","","",null,1,"数据还原",null,null);

        } else if(group.equals("blog"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"我的博客",null,null);
            create(community,root,0,1,"/jsp/user/MemberHomePage.jsp",0,0,true,"m","","",null,1,"浏览我的主页",null,null);
            create(community,root,0,1,"/jsp/general/WeblogSelectTemp.jsp",0,0,false,"m","","",null,1,"选择模板",null,null);
            create(community,root,0,1,"/jsp/node/TalkbackedNodes.jsp",0,0,true,"m","","",null,1,"评论列表",null,null);
            create(community,root,0,1,"/jsp/community/CommunitySetWeblog.jsp",0,0,true,"m","","",null,1,"模板定义",null,null);
            create(community,root,0,1,"/jsp/general/WeblogEditNode.jsp",0,0,true,"m","","",null,1,"栏目设置",null,null);
            create(community,root,0,1,"/jsp/section/WeblogSelectCssJs.jsp",0,0,true,"m","","",null,1,"样式选择",null,null);
            create(community,root,0,1,"/jsp/section/WeblogEditCssJs.jsp",0,0,true,"m","","",null,1,"样式修改",null,null);
            create(community,root,0,1,"/jsp/profile/EditCallboard.jsp",0,0,true,"m","","",null,1,"自定义公告",null,null);
            create(community,root,0,1,"/jsp/section/WeblogEditSection.jsp",0,0,true,"m","","",null,1,"自定义空白面板",null,null);
            create(community,root,0,1,"/jsp/general/WeblogContentManage.jsp",0,0,true,"m","","",null,1,"内容管理",null,null);
            create(community,root,0,1,"/jsp/type/weblog/EditWeblogInfo.jsp",0,0,true,"m","","",null,1,"基本信息设置",null,null);

        } else if(group.equals("timade"))
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"家政订单系统",null,null);
            create(community,root,0,1,"/jsp/admin/popedom/area.jsp",0,0,true,"m","","",null,1,"地区管理",null,null);
            int task = create(community,root,0,0,null,0,0,false,"m","","",null,1,"作业员管理",null,null);
            create(community,task,0,1,"/jsp/type/waiter/WaiterFrame.jsp",0,0,true,"m","","",null,1,"业务处",null,null);
            create(community,task,0,1,"/jsp/type/sorder/Reckoning.jsp",0,0,true,"m","","",null,1,"作业员工作统计",null,null);
            int client = create(community,root,0,0,null,0,0,true,"m","","",null,1,"客户管理",null,null);
            create(community,client,0,1,"/jsp/user/EjMember.jsp",0,0,true,"m","","",null,1,"客户管理",null,null);
            create(community,client,0,1,"/jsp/user/EjMemberCount.jsp",0,0,true,"m","","",null,1,"消费统计",null,null);
            create(community,client,0,1,"/jsp/profile/EditCode.jsp",0,0,true,"m","","",null,1,"生成充值卡",null,null);
            int operation = create(community,root,0,0,null,0,0,true,"m","","",null,1,"业务处管理",null,null);
            create(community,operation,0,1,"/jsp/admin/popedom/zone.jsp",0,0,true,"m","","",null,1,"业务处管理",null,null);
            create(community,operation,0,1,"/jsp/admin/popedom/conductor.jsp",0,0,true,"m","","",null,1,"用户管理",null,null);
            int orderform = create(community,root,0,0,null,0,0,true,"m","","",null,1,"订单管理",null,null);
            create(community,orderform,0,1,"/jsp/type/sorder/BgNewSOrder.jsp?NewNode=ON&Type=66&TypeAlias=0&node=29472",0,0,true,"m","","",null,1,"添加新订单",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/SaleSOrder2.jsp?Status=0&Type=0",0,0,true,"m","","",null,1,"接收新订单",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/SaleSOrder2.jsp?Status=4&Type=0",0,0,true,"m","","",null,1,"订单确认",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/PrintSOrder.jsp",0,0,true,"m","","",null,1,"订单打印",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/SaleSOrder2.jsp?Status=2&Type=0",0,0,true,"m","","",null,1,"订单完成",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/SaleSOrder2.jsp?Status=3&Type=0",0,0,true,"m","","",null,1,"已完成",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/SaleSOrder2.jsp?Status=1&Type=0",0,0,true,"m","","",null,1,"失效订单处理",null,null);
            create(community,operation,0,1,"/jsp/type/sorder/BgPurchaseSOrder.jsp",0,0,true,"m","","",null,1,"订单监督",null,null);
        } else if(group.equals("filecenter")) ////////文件中心
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"文件中心",null,null);
            create(community,root,0,1,"/jsp/netdisk/FileCenterSafetyFrame.jsp",0,0,true,"m","","",null,1,"文件权限管理",null,null);
            create(community,root,0,1,"/jsp/netdisk/FileCenters.jsp",0,0,true,"m","","",null,1,"文件中心管理",null,null);
            create(community,root,0,1,"/jsp/netdisk/EditFileCenterSet.jsp",0,0,true,"m","","",null,1,"最新文件设置",null,null);
        } else if(group.equals("eon")) ////////Eon
        {
            root = create(community,id,0,0,null,0,0,true,"m","","",null,1,"EON",null,null);
            int i = create(community,root,0,0,null,0,0,true,"m","","",null,1,"用户设置",null,null);
            create(community,i,0,1,"/jsp/eon/EonConsumes.jsp",0,0,true,"m","","",null,1,"用户缴费记录",null,null);
            create(community,i,0,1,"/jsp/eon/EditEonTeleset.jsp",0,0,true,"m","","",null,1,"联系信息设置",null,null);
            create(community,i,0,1,"/jsp/eon/EditEonTelesetMessage.jsp",0,0,true,"m","","",null,1,"留言管理",null,null);
            create(community,i,0,1,"/jsp/eon/EonInclude.jsp",0,0,true,"m","","",null,1,"获取代码",null,null);
            i = create(community,root,0,0,null,0,0,true,"m","","",null,1,"管理员设置",null,null);
            create(community,i,0,1,"/jsp/eon/EditEonNode.jsp",0,0,true,"m","","",null,1,"节点联系信息",null,null);
            create(community,i,0,1,"/jsp/eon/EonRecords.jsp",0,0,true,"m","","",null,1,"通话记录",null,null);
        }
        return root;
    }

}
