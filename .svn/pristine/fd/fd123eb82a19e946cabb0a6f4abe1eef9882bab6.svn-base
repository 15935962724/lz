package tea.entity.node;

import tea.db.DbAdapter;
import tea.entity.*;import tea.ui.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.sql.SQLException;

public class Friend extends Entity
{
    public static final String FRIEND_GENDER[] =
            {"Man","Woman"};
    public static final String FRIEND_RELATIONSHIP[] =
            {"LongTerm","ShortTerm","ActivityPartner","LongDistance","AlternativeLifestyles"};
    public static final String FRIEND_ETHNICITY[] =
            {"","Asian","AfricanAmercian","Caucasian","Latino","NativeAmercian","Other"};
    public static final String FRIEND_EDUCATION[] =
            {"","HighSchool","College","Graduate"};
    public static final String FRIEND_EMPLOYMENT[] =
            {"","PartTime","FullTime"};
    public static final String FRIEND_RELIGION[] =
            {"","Buddhist","Catholic","Christian","Jewish","Muslim","Agnostic","Other"};
    public static final String FRIEND_HOBBIES[] =
            {"ArtsCrafts","CommunityService","Dancing","Dining","Family","Movies","Music","OutdoorActivities","Photography","ReligionSpiritual","Sports","Theater","Travel"};
    public static final String FRIEND_BODYTYPE[] =
            {"Slim","Slender","Athletic","Healthy","Large"};
    public static final String FRIEND_SMOKE[] =
            {"No","Occasionally","Often"};
    public static final String FRIEND_DRINK[] =
            {"No","Occasionally","Often"};
    public static final String FRIEND_CHILDREN[] =
            {"","No","Yes"}; // PerferNotToSay
    private int _nNode;
    private int _nGender;
    private int _nPrefGender;
    private int _nRelationship;
    private int _nEthnicity;
    private int _nEducation;
    private int _nEmployment;
    private int _nReligion;
    private int _nHobbies;
    private int _nBodyType;
    private int _nAge;
    private int _nHeight;
    private int _nSmoke;
    private int _nDrink;
    private int _nChildren;
    private boolean _blLoaded;
    private static Cache _cache = new Cache(100);

    public static String getDetail(Node obj,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        int node = obj._nNode;
        Friend f = Friend.find(node);
        ListingDetail detail = ListingDetail.find(listing,31,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("subject"))
            {
                value = (obj.getSubject(h.language));
            } else if(itemname.equals("gender"))
            {
                value = (r.getString(h.language,Friend.FRIEND_GENDER[f.getGender()]));
            } else if(itemname.equals("prefgender"))
            {
                value = (r.getString(h.language,Friend.FRIEND_GENDER[f.getPrefGender()]));
            } else if(itemname.equals("relationship"))
            {
                StringBuilder sb_hobbies = new StringBuilder();
                for(int i3 = 0;i3 < Friend.FRIEND_RELATIONSHIP.length;i3++)
                {
                    if((f.getRelationship() & 1 << i3) != 0)
                    {
                        sb_hobbies.append(r.getString(h.language,Friend.FRIEND_RELATIONSHIP[i3]) + " ");
                    }
                }
                value = (sb_hobbies.toString());
            } else if(itemname.equals("ethnicity"))
            {
                value = (r.getString(h.language,Friend.FRIEND_ETHNICITY[f.getEthnicity()]));
            } else if(itemname.equals("education"))
            {
                value = (r.getString(h.language,Friend.FRIEND_EDUCATION[f.getEducation()]));
            } else if(itemname.equals("employment"))
            {
                value = (r.getString(h.language,Friend.FRIEND_EMPLOYMENT[f.getEmployment()]));
            } else if(itemname.equals("religion"))
            {
                value = (r.getString(h.language,Friend.FRIEND_RELIGION[f.getReligion()]));
            } else if(itemname.equals("hobbies"))
            {
                StringBuilder sb_hobbies = new StringBuilder();
                for(int i3 = 0;i3 < Friend.FRIEND_HOBBIES.length;i3++)
                {
                    if((f.getHobbies() & 1 << i3) != 0)
                    {
                        sb_hobbies.append(r.getString(h.language,Friend.FRIEND_HOBBIES[i3]) + " ");
                    }
                }
                value = (sb_hobbies.toString());
            } else if(itemname.equals("bodytype"))
            {
                value = (r.getString(h.language,Friend.FRIEND_BODYTYPE[f.getBodyType()]));
            } else if(itemname.equals("age"))
            {
                value = String.valueOf(f.getAge());
            } else if(itemname.equals("height"))
            {
                value = String.valueOf(f.getHeight());
            } else if(itemname.equals("smoke"))
            {
                value = (r.getString(h.language,Friend.FRIEND_SMOKE[f.getSmoke()]));
            } else if(itemname.equals("drink"))
            {
                value = (r.getString(h.language,Friend.FRIEND_DRINK[f.getDrink()]));
            } else if(itemname.equals("children"))
            {
                value = (r.getString(h.language,Friend.FRIEND_CHILDREN[f.getChildren()]));
            }

            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/friend/" + node + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("FriendID" + itemname);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public int getHobbies() throws SQLException
    {
        load();
        return _nHobbies;
    }

    public int getReligion() throws SQLException
    {
        load();
        return _nReligion;
    }

    public void set(int i,int j,int k,int l,int i1,int j1,int k1,int l1,int i2,int j2,int k2,int l2,int i3,int j3) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("FriendEdit" + _nNode + ", " + i + ", " + j + ", " + k + ", "
            // + l + ", " + i1 + ", " + j1 + ", " + k1 + ", " +
            // l1 + ", " + i2 + ", " + j2 + ", " + k2 + ", " +
            // l2 + ", " + i3 + ", " + j3);
            dbadapter.executeQuery("SELECT node FROM Friend WHERE node=" + _nNode);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE Friend SET gender=" + i + ",prefgender=" + j + ",relationship=" + k + ",ethnicity=" + l + ",education=" + i1 + ",employment=" + j1 + ",religion=" + k1 + ",hobbies=" + l1 + ",bodytype=" + i2 + ",age=" + j2 + ",height=" + k2 + ",smoke=" + l2 + ",drink=" + i3 + ",children=" + j3 + "	WHERE node=" + _nNode);
            } else
            {
                dbadapter.executeUpdate("INSERT Friend(node, gender, prefgender, relationship, ethnicity, education, employment, religion, hobbies, bodytype, age, height, smoke, drink, children) VALUES (" + _nNode + ", " + i + ", " + j + ", " + k + ", " + l + ", " + i1 + ", " + j1 + ", " + k1 + ", " + l1 + ", " + i2 + ", " + j2 + ", " + k2 + ", " + l2 + ", " + i3 + ", " + j3 + ") ");
            }
        } catch(Exception _ex)
        {
        } finally
        {
            dbadapter.close();
        }
        _nGender = i;
        _nPrefGender = j;
        _nRelationship = k;
        _nEthnicity = l;
        _nEducation = i1;
        _nEmployment = j1;
        _nReligion = k1;
        _nHobbies = l1;
        _nBodyType = i2;
        _nAge = j2;
        _nHeight = k2;
        _nSmoke = l2;
        _nDrink = i3;
        _nChildren = j3;
    }

    public int getSmoke() throws SQLException
    {
        load();
        return _nSmoke;
    }

    private Friend(int i)
    {
        _nNode = i;
        _blLoaded = false;
    }

    public int getDrink() throws SQLException
    {
        load();
        return _nDrink;
    }

    public int getEducation() throws SQLException
    {
        load();
        return _nEducation;
    }

    public int getRelationship() throws SQLException
    {
        load();
        return _nRelationship;
    }

    public int getAge() throws SQLException
    {
        load();
        return _nAge;
    }

    public int getChildren() throws SQLException
    {
        load();
        return _nChildren;
    }

    private void load() throws SQLException
    {
        if(!_blLoaded)
        {
            DbAdapter dbadapter = new DbAdapter();
            try
            {
                dbadapter.executeQuery("SELECT gender, prefgender, relationship, ethnicity, education,  employment, religion, hobbies, bodytype, age, height, smoke, drink, children  FROM Friend  WHERE node=" + _nNode);
                if(dbadapter.next())
                {
                    _nGender = dbadapter.getInt(1);
                    _nPrefGender = dbadapter.getInt(2);
                    _nRelationship = dbadapter.getInt(3);
                    _nEthnicity = dbadapter.getInt(4);
                    _nEducation = dbadapter.getInt(5);
                    _nEmployment = dbadapter.getInt(6);
                    _nReligion = dbadapter.getInt(7);
                    _nHobbies = dbadapter.getInt(8);
                    _nBodyType = dbadapter.getInt(9);
                    _nAge = dbadapter.getInt(10);
                    _nHeight = dbadapter.getInt(11);
                    _nSmoke = dbadapter.getInt(12);
                    _nDrink = dbadapter.getInt(13);
                    _nChildren = dbadapter.getInt(14);
                }
            } catch(Exception _ex)
            {
            } finally
            {
                dbadapter.close();
            }
            _blLoaded = true;
        }
    }

    public int getPrefGender() throws SQLException
    {
        load();
        return _nPrefGender;
    }

    public int getHeight() throws SQLException
    {
        load();
        return _nHeight;
    }

    public int getGender() throws SQLException
    {
        load();
        return _nGender;
    }

    public int getEthnicity() throws SQLException
    {
        load();
        return _nEthnicity;
    }

    public static Friend find(int i)
    {
        Friend friend = (Friend) _cache.get(new Integer(i));
        if(friend == null)
        {
            friend = new Friend(i);
            _cache.put(new Integer(i),friend);
        }
        return friend;
    }

    public int getEmployment() throws SQLException
    {
        load();
        return _nEmployment;
    }

    public int getBodyType() throws SQLException
    {
        load();
        return _nBodyType;
    }

}
