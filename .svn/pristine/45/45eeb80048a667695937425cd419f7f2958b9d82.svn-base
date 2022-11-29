package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Materia
{
    protected static Cache c = new Cache(50);
    public int node; //900000+id
    public int id;
    public String name; //本名
    public String harvesting; //采收加工
    public String reference; //参考文献
    public String source; //出处
    public static final String[] MATERIA_TYPE =
            {"--","原植物","原动物","其它"};
    public int type; //分类
    public String characteristic; //粉末特征
    public String prescript; //附方
    public String note; //附注
    public String functions; //功能与主治
    public String composition; //化学成分
    public String recipes; //集解
    public String taboo; //禁忌
    public String latin; //拉丁名
    public String quarry; //来源
    public String identify; //理化鉴别
    public String processing; //炮制
    public String quality; //品质标志
    public String textual; //品种考证
    public String specification; //商品规格
    public String precaution; //使用注意
    public String shiming; //释名
    public String microscopic; //显微鉴别
    public String clinical; //现代临床研究
    public String flavour; //性味
    public String medicinal; //药材及产销
    public String identification; //药材鉴别
    public String pharmacology; //药理
    public String theory; //药论
    public String synonym; //异名
    public String feature; //饮片性状
    public String compatibility; //应用与配伍
    public String dosage; //用法用量
    public String morphology; //原生长形态
    public String method; //制法
    public String preparation; //制剂
    public String family1; //中文科名
    public String species1; //中文种名
    public String potency; //药性

    public Materia(int node)
    {
        this.node = node;
    }

    public static Materia find(int node) throws SQLException
    {
        Materia t = (Materia) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Materia(node) : (Materia) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,id,name,harvesting,reference,source,type,characteristic,prescript,note,functions,composition,recipes,taboo,latin,quarry,identify,processing,quality,textual,specification,precaution,shiming,microscopic,clinical,flavour,medicinal,identification,pharmacology,theory,synonym,feature,compatibility,dosage,morphology,method,preparation,family1,species1,potency FROM materia WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Materia t = new Materia(rs.getInt(i++));
                t.id = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.harvesting = rs.getString(i++);
                t.reference = rs.getString(i++);
                t.source = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.characteristic = rs.getString(i++);
                t.prescript = rs.getString(i++);
                t.note = rs.getString(i++);
                t.functions = rs.getString(i++);
                t.composition = rs.getString(i++);
                t.recipes = rs.getString(i++);
                t.taboo = rs.getString(i++);
                t.latin = rs.getString(i++);
                t.quarry = rs.getString(i++);
                t.identify = rs.getString(i++);
                t.processing = rs.getString(i++);
                t.quality = rs.getString(i++);
                t.textual = rs.getString(i++);
                t.specification = rs.getString(i++);
                t.precaution = rs.getString(i++);
                t.shiming = rs.getString(i++);
                t.microscopic = rs.getString(i++);
                t.clinical = rs.getString(i++);
                t.flavour = rs.getString(i++);
                t.medicinal = rs.getString(i++);
                t.identification = rs.getString(i++);
                t.pharmacology = rs.getString(i++);
                t.theory = rs.getString(i++);
                t.synonym = rs.getString(i++);
                t.feature = rs.getString(i++);
                t.compatibility = rs.getString(i++);
                t.dosage = rs.getString(i++);
                t.morphology = rs.getString(i++);
                t.method = rs.getString(i++);
                t.preparation = rs.getString(i++);
                t.family1 = rs.getString(i++);
                t.species1 = rs.getString(i++);
                t.potency = rs.getString(i++);
                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM materia WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO materia(node,id,name,harvesting,reference,source,type,characteristic,prescript,note,functions,composition,recipes,taboo,latin,quarry,identify,processing,quality,textual,specification,precaution,shiming,microscopic,clinical,flavour,medicinal,identification,pharmacology,theory,synonym,feature,compatibility,dosage,morphology,method,preparation,family1,species1,potency)VALUES(" + node + "," + id + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(harvesting) + "," + DbAdapter.cite(reference) + "," + DbAdapter.cite(source) + "," + type + "," + DbAdapter.cite(characteristic) + "," + DbAdapter.cite(prescript) + "," + DbAdapter.cite(note) + "," + DbAdapter.cite(functions) + "," + DbAdapter.cite(composition) + "," +
                                     DbAdapter.cite(recipes) + "," + DbAdapter.cite(taboo) + "," + DbAdapter.cite(latin) + "," + DbAdapter.cite(quarry) + "," + DbAdapter.cite(identify) + "," + DbAdapter.cite(processing) + "," + DbAdapter.cite(quality) + "," + DbAdapter.cite(textual
                                     ) + "," + DbAdapter.cite(specification) + "," + DbAdapter.cite(precaution) + "," + DbAdapter.cite(shiming) + "," + DbAdapter.cite(microscopic) + "," + DbAdapter.cite(clinical) + "," + DbAdapter.cite(flavour) + "," + DbAdapter.cite(medicinal) + "," + DbAdapter.cite(identification) + "," + DbAdapter.cite(pharmacology) + "," + DbAdapter.cite(theory) + "," + DbAdapter.cite(synonym) + "," + DbAdapter.cite(feature) + "," + DbAdapter.cite(compatibility) + "," + DbAdapter.cite(dosage) + "," + DbAdapter.cite(morphology) + "," + DbAdapter.cite(method) + "," + DbAdapter.cite(preparation) + "," + DbAdapter.cite(family1) + "," + DbAdapter.cite(species1) + "," + DbAdapter.cite(potency) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE materia SET node=" + node + ",id=" + id + ",name=" + DbAdapter.cite(name) + ",harvesting=" + DbAdapter.cite(harvesting) + ",reference=" + DbAdapter.cite(reference) + ",source=" + DbAdapter.cite(source) + ",type=" + type + ",characteristic=" + DbAdapter.cite(characteristic) + ",prescript=" + DbAdapter.cite(prescript) + ",note=" + DbAdapter.cite(note) + ",functions=" + DbAdapter.cite(functions) + ",composition=" + DbAdapter.cite(composition) + ",recipes=" + DbAdapter.cite(recipes) + ",taboo=" + DbAdapter.cite(taboo) + ",latin=" + DbAdapter.cite(latin) + ",quarry=" + DbAdapter.cite(quarry) + ",identify=" + DbAdapter.cite(identify) + ",processing=" + DbAdapter.cite(processing) + ",quality=" + DbAdapter.cite(quality) + ",textual=" +
                                 DbAdapter.cite(textual) + ",specification=" + DbAdapter.cite(specification) + ",precaution=" + DbAdapter.cite(precaution) + ",shiming=" + DbAdapter.cite(shiming) + ",microscopic=" + DbAdapter.cite(microscopic) + ",clinical=" + DbAdapter
                                 .cite(clinical) + ",flavour=" + DbAdapter.cite(flavour) + ",medicinal=" + DbAdapter.cite(medicinal) + ",identification=" + DbAdapter.cite(identification) + ",pharmacology=" + DbAdapter.cite(pharmacology) + ",theory=" + DbAdapter.cite(theory) + ",synonym=" + DbAdapter.cite(synonym) + ",feature=" + DbAdapter.cite(feature) + ",compatibility=" + DbAdapter.cite(compatibility) + ",dosage=" + DbAdapter.cite(dosage) + ",morphology=" + DbAdapter.cite(morphology) + ",method=" + DbAdapter.cite(method) + ",preparation=" + DbAdapter.cite(preparation) + ",family1=" + DbAdapter.cite(family1) + ",species1=" + DbAdapter.cite(species1) + ",potency=" + DbAdapter.cite(potency) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM materia WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE materia SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,106,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/materia/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("picture"))
            {
                String picture = n.getPicture(h.language);
                value = picture == null ? null : "<img src='" + picture + "' />";
            } else
            {
                Materia t = Materia.find(n._nNode);
                if(name.equals("type"))
                {
                    value = Materia.MATERIA_TYPE[t.type];
                } else
                    try
                    {
                        Object tmp = Class.forName("tea.entity.node.Materia").getField(name).get(t);
                        if(tmp != null)
                        {
                            if(tmp instanceof Date)
                                value = MT.f((Date) tmp);
                            else
                                value = tmp.toString();
                        }
                    } catch(Exception ex)
                    {
                    }
            }

            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            }
            sb.append(bi).append("<span id='MateriaID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

}
