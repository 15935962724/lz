package tea.entity.node;

import java.math.BigDecimal;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.member.*;
import tea.html.*;import tea.ui.*;
import java.util.*;
import tea.resource.*;
import java.sql.SQLException;

public class Resume
{
    private static Cache _cache = new Cache(100);
    private boolean exists;
    private int node;
    private int language;
    private String joinu;
    private String intr1;
    private String intr2;
    private String intr3;
    private String nowmaincareer; //现从事行业
    private String zxrgs;
    private String nowcareerlevel;
    private int experience;
    private boolean hasabroad;
    private BigDecimal salarysum;
    private String zwaers_yx;
    private int zqwgz;
    private String expectcareer; //期望从事职业
    private String expectcity;
    private BigDecimal expectsalarysum;
    private String zwaers_qwyx;
    private int joindatetype;
    private String selfvalue;
    private String selfaim;
    private String other;

    public static Resume find(int node,int language) throws SQLException
    {
        Resume obj = (Resume) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Resume(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public Resume(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    public void set(String joinu,String intr1,String intr2,String intr3,String nowmaincareer,String zxrgs,String nowcareerlevel,int experience,boolean hasabroad,BigDecimal salarysum,String zwaers_yx,int zqwgz,String expectcareer,String expectcity,BigDecimal expectsalarysum,String zwaers_qwyx,int joindatetype) throws SQLException
    {
        if(isExists())
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Resume SET joinu=" + DbAdapter.cite(joinu) + ",intr1=" + DbAdapter.cite(intr1) + ",intr2=" + DbAdapter.cite(intr2) + ",intr3=" + DbAdapter.cite(intr3) + ",nowmaincareer=" + DbAdapter.cite(nowmaincareer) + ",zxrgs=" + DbAdapter.cite(zxrgs) + ",nowcareerlevel=" + DbAdapter.cite(nowcareerlevel) + ",experience=" + (experience) + ",hasabroad=" + DbAdapter.cite(hasabroad) + ",salarysum=" + (salarysum) + ",zwaers_yx=" + DbAdapter.cite(zwaers_yx)
                                 + ",zqwgz=" + zqwgz + ",expectcareer=" + DbAdapter.cite(expectcareer) + ",expectcity=" + DbAdapter.cite(expectcity) + ",expectsalarysum=" + (expectsalarysum) + ",zwaers_qwyx=" + DbAdapter.cite(zwaers_qwyx) + ",joindatetype=" + (joindatetype) + " WHERE node=" + node + " AND language=" + language);
            } finally
            {
                db.close();
            }
            this.joinu = joinu;
            this.intr1 = intr1;
            this.intr2 = intr2;
            this.intr3 = intr3;
            this.nowmaincareer = nowmaincareer;
            this.zxrgs = zxrgs;
            this.nowcareerlevel = nowcareerlevel;
            this.experience = experience;
            this.hasabroad = hasabroad;
            this.salarysum = salarysum;
            this.zwaers_yx = zwaers_yx;
            this.zqwgz = zqwgz;
            this.expectcareer = expectcareer;
            this.expectcity = expectcity;
            this.expectsalarysum = expectsalarysum;
            this.zwaers_qwyx = zwaers_qwyx;
            this.joindatetype = joindatetype;
        } else
        {
            create(node,language,joinu,intr1,intr2,intr3,nowmaincareer,zxrgs,nowcareerlevel,experience,hasabroad,salarysum,zwaers_yx,zqwgz,expectcareer,expectcity,expectsalarysum,zwaers_qwyx,joindatetype);
        }
    }

    public void set(String selfvalue,String selfaim,String other) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        if(this.exists)
        {
            try
            {
                db.executeUpdate("UPDATE Resume SET selfvalue=" + DbAdapter.cite(selfvalue) + ",selfaim=" + DbAdapter.cite(selfaim) + ",other=" + DbAdapter.cite(other) + " WHERE node=" + node + " AND language=" + language);
            } finally
            {
                db.close();
            }
        } else
        {
            create(node,language,selfvalue);
        }
        this.selfvalue = selfvalue;
        this.selfaim = selfaim;
        this.other = other;
    }

    public static void create(int node,int language,String selfvalue) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Resume(node,language,selfvalue)VALUES(" + node + "," + language + "," + DbAdapter.cite(selfvalue) + " )");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }


    public static void create(int node,int language,String joinu,String intr1,String intr2,String intr3,String nowmaincareer,String zxrgs,String nowcareerlevel,int experience,boolean hasabroad,BigDecimal salarysum,String zwaers_yx,int zqwgz,String expectcareer,String expectcity,BigDecimal expectsalarysum,String zwaers_qwyx,int joindatetype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Resume(node,language,joinu,intr1,intr2,intr3,nowmaincareer,zxrgs,nowcareerlevel,experience,hasabroad,salarysum,zwaers_yx,zqwgz,expectcareer,expectcity,expectsalarysum,zwaers_qwyx,joindatetype)VALUES(" + node + "," + language + "," + DbAdapter.cite(joinu) + "," + DbAdapter.cite(intr1) + "," + DbAdapter.cite(intr2) + "," + DbAdapter.cite(intr3) + "," + DbAdapter.cite(nowmaincareer) + "," + DbAdapter.cite(zxrgs) + ","
                             + DbAdapter.cite(nowcareerlevel) + "," + (experience) + "," + DbAdapter.cite(hasabroad) + "," + (salarysum) + "," + DbAdapter.cite(zwaers_yx) + "," + (zqwgz) + "," + DbAdapter.cite(expectcareer) + "," + DbAdapter.cite(expectcity) + "," + (expectsalarysum) + "," + DbAdapter.cite(zwaers_qwyx) + "," + (joindatetype) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void delete()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Resume WHERE node=" + node + " AND language=" + language);

        } catch(SQLException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // int j = db.getInt("ResumeGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            db.executeQuery("SELECT joinu,intr1,intr2,intr3,nowmaincareer,zxrgs,nowcareerlevel,experience,hasabroad,salarysum,zwaers_yx,zqwgz,expectcareer,expectcity,expectsalarysum,zwaers_qwyx,joindatetype,selfvalue,selfaim,other FROM Resume WHERE node=" + node + "  AND language=" + j);
            if(db.next())
            {
                joinu = db.getVarchar(j,language,1);
                intr1 = db.getVarchar(j,language,2);
                intr2 = db.getVarchar(j,language,3);
                intr3 = db.getVarchar(j,language,4);
                nowmaincareer = db.getString(5);
                zxrgs = db.getVarchar(j,language,6);
                nowcareerlevel = db.getString(7);
                experience = db.getInt(8);
                hasabroad = db.getInt(9) != 0;
                salarysum = db.getBigDecimal(10,2);
                zwaers_yx = db.getString(11);
                zqwgz = db.getInt(12);
                expectcareer = db.getVarchar(j,language,13);
                expectcity = db.getVarchar(j,language,14);
                expectsalarysum = db.getBigDecimal(15,2);
                zwaers_qwyx = db.getString(16);
                joindatetype = db.getInt(17);
                selfvalue = db.getVarchar(j,language,18);
                selfaim = db.getVarchar(j,language,19);
                other = db.getVarchar(j,language,20);
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

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM Resume WHERE node=" + node);
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

    public static Enumeration getNode(String member,int language) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT r.node FROM Resume r,Node n WHERE r.node=n.node AND n.vcreator=" + DbAdapter.cite(member) + " AND r.language=" + language);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        Span span = null;
        StringBuilder content_sb = new StringBuilder();

        Resume job = Resume.find(node._nNode,h.language);
        if(job.isExists())
        {
            Profile profile = Profile.find(node.getCreator()._strR);
            ListingDetail detail = ListingDetail.find(listing,52,h.language);;
            Iterator listingDetailEnumeration = detail.keys();
            while(listingDetailEnumeration.hasNext())
            {
                String itemname = (String) listingDetailEnumeration.next(),value = null;
                int istype = detail.getIstype(itemname);
                if(istype == 0)
                {
                    continue;
                }
                if(itemname.equals("name"))
                {
                    value = (profile.getFirstName(h.language) + profile.getLastName(h.language));
                } else if(itemname.equals("Sex"))
                {
                    if(profile.isSex())
                    {
                        value = ("男");
                    } else
                    {
                        value = ("女");
                    }
                } else if(itemname.equals("Birth"))
                {
                    if(profile.getBirth() != null)
                    {
                        value = (new java.text.SimpleDateFormat("yyyy/MM").format(profile.getBirth()));
                    }
                } else if(itemname.equals("State"))
                {
                    value = (profile.getState(h.language));
                } else /*
                 * if (itemname.equals("Degree")) { value=(DegreeSelection.getDegree(profile.getDegree(language))); } else if (itemname.equals("NowTrade")) { value=(job.getNowTrade()); } else if (itemname.equals("Experience")) { value=(job.getExperience()); } else if (itemname.equals("ExpectCity")) { value=(job.getExpectCity()); } else
                 */
                if(itemname.equals("EmailAddress"))
                {
                    value = (profile.getEmail());
                } else if(itemname.equals("Checkbox"))
                {
                    value = ("<input type=checkbox name=" + node._nNode + "/ >");
                } else if(itemname.equals("MajorCategory"))
                {
                    StringBuilder sb = new StringBuilder();
                    Enumeration enumeration = Educate.find(node._nNode,h.language);
                    while(enumeration.hasMoreElements())
                    {
                        Educate educate = Educate.find(((Integer) enumeration.nextElement()).intValue());
                        sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                    }
                    value = (sb.toString());
                } else if(itemname.equals("Mobile"))
                {
                    value = (profile.getMobile());
                } else if(itemname.equals("Photo"))
                {
                    value = ("<img src=\"/servlet/PhotoPicture?member=" + node.getCreator()._strV + "\" />");
                } else if(itemname.equals("Address"))
                {
                    value = (profile.getAddress(h.language));
                } else if(itemname.equals("NowTrade"))
                {
                    // value=(job.getNowTrade());
                } else if(itemname.equals("NowMainCareer"))
                {
                    value = (job.getNowmaincareer());
                    for(int i=0;i<Common.ZCSZY.length;i++){
                		if(job.getNowmaincareer().equals(Common.ZCSZY[i][0])){
                			value=Common.ZCSZY[i][1];
                		}
                	}
                	if(value==null||value.length()==0){
                		value="空";
                	}
                } else if(itemname.equals("NowCareerLevel"))
                {
                	for(int i=0;i<Common.ZZWJB.length;i++){
                		if(job.getNowcareerlevel().equals(Common.ZZWJB[i][0])){
                			value=Common.ZZWJB[i][1];
                		}
                	}
                	if(value==null||value.length()==0){
                		value="空";
                	}
                } else if(itemname.equals("Experience"))
                {
                    value = String.valueOf(job.getExperience());
                } else if (itemname.equals("Degree")){

                	value=tea.htmlx.DegreeSelection.getDegree(profile.getDegree(h.language));
                } else if (itemname.equals("HasAbroad")){
                	value=job.isHasabroad()?"有":"无";
                } else if (itemname.equals("ExpectWorkKind")){
                	int t=job.getZqwgz();
                	switch(t){
                		case 1:
                			value="全职";
                			break;
                		case 2:
                			value="兼职";
                			break;
                		case 31:
                			value="临时";
                			break;
                		case 4:
                			value="实习";
                			break;
                	}
                } else if (itemname.equals("ExpectTrade")){
//                	for(int i=0;i<Common.ZCSZY.length;i++){
//                		if(job.getNowmaincareer().equals(Common.ZCSZY[i][0])){
//                			value=Common.ZCSZY[i][1];
//                		}
//                	}
//                	if(value==null||value.length()==0){
//                		value="空";
//                	}
                } else if (itemname.equals("ExpectCareer")){
                	value=(job.getExpectcareer());
                	String vs[]=value.split("/");
                	StringBuffer sb=new StringBuffer();
                	for(int i=0;i<vs.length;i++){
                		if(vs[i]!=null&&vs[i].length()>0){
                			Occupation oc=Occupation.find(h.community, vs[i]);
                			if(oc.getSubject()!=null&&oc.getSubject().length()>0)
                				sb.append(oc.getSubject()+"/");
                		}
                	}
                	value=sb.toString();
//                	java.util.Enumeration bigOcc=Occupation.findByFather(Occupation.getRootId(h.community));
//
//                    for(int index=0;bigOcc.hasMoreElements();index++)
//                    {
//                      int occupation=((Integer)bigOcc.nextElement()).intValue();
//                      Occupation occ_obj=Occupation.find(occupation);
//                      out.print("<option value="+occ_obj.getCode()+" >"+occ_obj.getSubject()+"</option>");
//
//                      java.util.Enumeration smallOcc=Occupation.findByFather(occupation);
//                      for(int smallindex=0;smallOcc.hasMoreElements();smallindex++)
//                      {
//                        occupation=((Integer)smallOcc.nextElement()).intValue();
//                        occ_obj=Occupation.find(occupation);
//                        out.print("<option value="+occ_obj.getCode()+">-- "+occ_obj.getSubject()+"</option>");
//                      }
//                    }
                } else if (itemname.equals("ExpectSalarySum")){
                	if(job.getExpectsalarysum()==null){
                		value="面议";
                	}else{
                		value=job.getExpectsalarysum().toString();
                	}
                } else if (itemname.equals("SelfValue")){
                	if(job.getSelfvalue()!=null){
                		value=job.getSelfvalue();
                	}else {
                		value="";
                	}
                } else if (itemname.equals("SelfAim")){
                	value=(job.getSelfaim());
                }
                /*
                 * else if (itemname.equals("HasAbroad")) { value=(job.isHasAbroad() ? "有" : "无"); } else if (itemname.equals("SalarySum")) { value=(job.getSalarySum()); } else if (itemname.equals("ExpectWorkKind")) { value=(job.getExpectWorkKind()); } else if (itemname.equals("ExpectTrade")) { value=(job.getExpectTrade()); } else if (itemname.equals("ExpectCareer")) {
                 * value=(job.getExpectCareer()); } else if (itemname.equals("ExpectSalarySum")) { value=(job.getExpectSalarySum()); } else if (itemname.equals("JoinDateType")) { value=(job.getJoinDateType()); } else if (itemname.equals("SelfValue")) { value=(job.getSelfValue()); } else if (itemname.equals("SelfAim")) { value=(job.getSelfAim()); }
                 */
                if(detail.getAnchor(itemname) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/resume/" + node._nNode + "-" + h.language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("ResumeID" + itemname);
                content_sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
            }
        }
        return content_sb.toString();
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getJoinu()
    {
        return joinu;
    }

    public String getIntr1()
    {
        return intr1;
    }

    public String getIntr2()
    {
        return intr2;
    }

    public String getIntr3()
    {
        return intr3;
    }

    public String getNowmaincareer()
    {
        return nowmaincareer;
    }

    public String getNowmaincareerToHtml()
    {
        StringBuilder sb = new StringBuilder();
        String str[] = nowmaincareer.split("/");
        for(int i = 1;i < str.length;i++)
        {
            for(int index = 0;index <= tea.resource.Common.ZCSZY.length;index++)
            {
//                if (index == Common.ZCSZY.length)
//                {
//                    sb.append(str[i]).append(", ");
//                } else
                if(Common.ZCSZY[index][0].equals(str[i]))
                {
                    sb.append(Common.ZCSZY[index][1]).append("　");
                    break;
                }
            }
        }
        return sb.toString();
    }

    public String getZxrgs()
    {
        return zxrgs;
    }

    public String getNowcareerlevel()
    {
        return nowcareerlevel;
    }

    public boolean isHasabroad()
    {
        return hasabroad;
    }

    public BigDecimal getSalarysum()
    {
        return salarysum;
    }

    public String getZwaers_yx()
    {
        return zwaers_yx;
    }

    public int getZqwgz()
    {
        return zqwgz;
    }

    public String getExpectcareer()
    {
        return expectcareer;
    }

    public String getExpectcareerToHtml() throws SQLException
    {
        String community = Node.find(node).getCommunity();
        StringBuilder sb = new StringBuilder();
        String ecs[] = expectcareer.split("/");
        for(int i = 1;i < ecs.length;i++)
        {
            Occupation o = Occupation.find(community,ecs[i]);
            if(o.isExists())
            {
                sb.append(o.getSubject()).append("　");
            }
        }
        return sb.toString();
    }

    public String getExpectcity()
    {
        return expectcity;
    }

    public String getExpectcityToHtml() throws SQLException
    {
        String community = Node.find(node).getCommunity();
        StringBuilder sb = new StringBuilder();
        String arr[] = expectcity.split("/");
        for(int i = 1;i < arr.length;i++)
        {
            Jobcity jc = Jobcity.find(community,arr[i]);
            if(jc.isExists())
            {
                sb.append(jc.getSubject()).append("　");
            }
        }
        return sb.toString();
    }

    public BigDecimal getExpectsalarysum()
    {
        return expectsalarysum;
    }

    public String getZwaers_qwyx()
    {
        return zwaers_qwyx;
    }

    public int getJoindatetype()
    {
        return joindatetype;
    }

    public int getExperience()
    {
        return experience;
    }

    public String getSelfvalue()
    {
        return selfvalue;
    }

    public String getSelfaim()
    {
        return selfaim;
    }

    public String getOther()
    {
        return other;
    }
}
