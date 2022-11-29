package tea.entity.site;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.Cache;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.html.*;
import tea.resource.*;
import tea.ui.*;

public class DynamicType extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String INPUT_TYPE[] =
            {"text","file","img","select","radio","checkbox","textarea","wordedit","office","date","csign","code","sign","cachet","folder"}; //,"datesel"
    public static final String DEFAULTVALUE_TYPE[] =
            {"--------------","当前日期","当前会员","会员部门","会员角色","信息类别","信息内容","可维护","+数据","-数据","分类","会员电话","会员列表"};
    private Hashtable _htLayer;
    private int dynamic;
    private String type;
    private int dynamictype;
    private int sequence;
    private boolean hidden;
    private boolean need; //必填
    private boolean qrc; // 胸卡
    private int defaultvalue; // 0:无,1:当前日期,2:当前会员
    private int binding; //绑定///
    private int filecenter; //附件归档,文件中心的文件夹ID
    private boolean sync; //数据是否同步(只有file类型,才有此属性),true:上传文件时,会把旧的替换掉.
    private boolean multi; //是否多个,如上传文件:每个会员可以传多个.
    private String width; //宽
    private String height; //高
    //folder才有以下字段
    private int father;
    private int quantity;
    private int columns;
    private String columnafter;
    private boolean separate; //区分会员
    private boolean export; //导出
    private boolean exists;
    class Layer
    {
        Layer()
        {
        }

        private boolean layerExists;
        private String content;
        private String name;
        private String beforeitem;
        private String afteritem;
    }


    public DynamicType(int dynamictype) throws SQLException
    {
        this.dynamictype = dynamictype;
        _htLayer = new Hashtable();
        load();
    }

    public static DynamicType find(int dynamictype) throws SQLException
    {
        DynamicType obj = (DynamicType) _cache.get(new Integer(dynamictype));
        if(obj == null)
        {
            obj = new DynamicType(dynamictype);
            _cache.put(new Integer(dynamictype),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dynamic,type,sequence,hidden,need,qrc,defaultvalue,filecenter,binding,sync,multi,width,height,father,quantity,columns,columnafter,separate,export FROM DynamicType WHERE dynamictype=" + dynamictype);
            if(db.next())
            {
                dynamic = db.getInt(1);
                type = db.getString(2);
                sequence = db.getInt(3);
                hidden = db.getInt(4) != 0;
                need = db.getInt(5) != 0;
                qrc = db.getInt(6) != 0;
                defaultvalue = db.getInt(7);
                filecenter = db.getInt(8);
                binding = db.getInt(9);
                sync = db.getInt(10) != 0;
                multi = db.getInt(11) != 0;
                width = db.getString(12);
                height = db.getString(13);
                father = db.getInt(14);
                quantity = db.getInt(15);
                columns = db.getInt(16);
                columnafter = db.getString(17);
                separate = db.getInt(18) != 0;
                export = db.getInt(19) != 0;
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

    public static Enumeration findByDynamic(int dynamic,String sql,int pos,int size) throws SQLException
    {
        return find(" AND dynamic=" + dynamic + sql,pos,size);
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dynamictype FROM DynamicType WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByDynamic(int dynamic) throws SQLException
    {
        return findByDynamic(dynamic," AND father=0",0,Integer.MAX_VALUE);
    }

    public static Enumeration findByDynamic(int dynamic,String type) throws SQLException
    {
        return findByDynamic(dynamic," AND type=" + DbAdapter.cite(type),0,Integer.MAX_VALUE);
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,content,beforeitem,afteritem FROM DynamicTypeLayer WHERE dynamictype=" + dynamictype + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.content = db.getText(j,i,2);
                    layer.beforeitem = db.getText(j,i,3);
                    layer.afteritem = db.getText(j,i,4);
                    layer.layerExists = j == i;
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM DynamicTypeLayer WHERE dynamictype=" + dynamictype);
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

    public static int create(int dynamic,String type,int sequence,boolean hidden,boolean need,boolean qrc,int defaultvalue,int filecenter,int binding,boolean sync,boolean multi,String width,String height,int father,int quantity,int columns,String columnafter,boolean separate,boolean export,int language,String name,String content,String beforeitem,String afteritem) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO DynamicType (dynamic,type,sequence,hidden,need,qrc,defaultvalue,filecenter,binding,sync,multi,width,height,father,quantity,columns,columnafter,separate,export)VALUES(" + dynamic + "," + DbAdapter.cite(type) + "," + sequence + "," + DbAdapter.cite(hidden) + "," + DbAdapter.cite(need) + "," + db.cite(qrc) + "," + defaultvalue + "," + filecenter + "," + binding + "," + DbAdapter.cite(sync) + "," + DbAdapter.cite(multi) + "," + DbAdapter.cite(width) + "," +
                             DbAdapter.cite(height) + "," + father + "," + quantity + "," + columns + "," + DbAdapter.cite(columnafter) + "," + DbAdapter.cite(separate) + "," + DbAdapter.cite(export) + ")");
            id = db.getInt("SELECT MAX(dynamictype) FROM DynamicType");
            db.executeUpdate("INSERT INTO DynamicTypeLayer (dynamictype,language,name,content,beforeitem,afteritem)VALUES(" + id + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem) + ")");
        } finally
        {
            db.close();
        }
        return id;
    }

    public void setContent(int language,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE DynamicTypeLayer SET content=" + DbAdapter.cite(content) + " WHERE dynamictype=" + dynamictype + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void set(String type,int sequence,boolean hidden,boolean need,boolean qrc,int defaultvalue,int filecenter,int binding,boolean sync,boolean multi,String width,String height,int father,int quantity,int columns,String columnafter,boolean separate,boolean export,int language,String name,String content,String beforeitem,String afteritem) throws SQLException
    {
        StringBuffer sql = new StringBuffer();
        sql.append("UPDATE DynamicTypeLayer SET");
        sql.append(" name=").append(DbAdapter.cite(name));
        if(content != null)
        {
            sql.append(",content=").append(DbAdapter.cite(content));
        }
        sql.append(",beforeitem=").append(DbAdapter.cite(beforeitem));
        sql.append(",afteritem=").append(DbAdapter.cite(afteritem));
        sql.append(" WHERE dynamictype=").append(dynamictype).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE DynamicType SET type=" + DbAdapter.cite(type) + ",sequence=" + sequence + ",hidden=" + DbAdapter.cite(hidden) + ",need=" + DbAdapter.cite(need) + ",qrc=" + db.cite(qrc) + ",defaultvalue=" + defaultvalue + ",filecenter=" + filecenter + ",binding=" + binding + ",sync=" + DbAdapter.cite(sync) + ",multi=" + DbAdapter.cite(multi) + ",width=" + DbAdapter.cite(width) + ",height=" + DbAdapter.cite(height) + ",father=" + father + ",quantity=" + quantity + ",columns=" +
                             columns + ",columnafter=" + DbAdapter.cite(columnafter) + ",separate=" + DbAdapter.cite(separate) + ",export=" + DbAdapter.cite(export) + " WHERE dynamictype=" + dynamictype);
            int j = db.executeUpdate(sql.toString());
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO DynamicTypeLayer (dynamictype,language,name,content,beforeitem,afteritem)VALUES (" + dynamictype + "," + language + "," + DbAdapter.cite(name) + ","
                                 + DbAdapter.cite(content) + "," + DbAdapter.cite(beforeitem) + " ," + DbAdapter.cite(afteritem) + "  )");
            }
        } finally
        {
            db.close();
        }
        this.type = type;
        this.sequence = sequence;
        this.hidden = hidden;
        this.need = need;
        this.qrc = qrc;
        this.defaultvalue = defaultvalue;
        this.filecenter = filecenter;
        this.binding = binding;
        this.sync = sync;
        this.multi = multi;
        this.width = width;
        this.height = height;
        this.father = father;
        this.quantity = quantity;
        this.columns = columns;
        this.columnafter = columnafter;
        this.separate = separate;
        this.export = export;
        _htLayer.clear();
    }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM DynamicTypeLayer WHERE dynamictype=" + dynamictype + " AND language=" + language);
            db.executeQuery("SELECT dynamictype FROM DynamicTypeLayer WHERE dynamictype=" + dynamictype);
            if(!db.next())
            {
                db.executeUpdate("DELETE FROM DynamicType WHERE dynamictype=" + dynamictype);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(dynamictype));
    }

    public String getText(TeaSession teasession) throws SQLException
    {
        int _nLanguage = teasession._nLanguage;
        Resource r = new Resource("/tea/resource/Dynamic");
        /*
         * if (text == null || text.length() <= 0) { return ""; } else
         */

        StringBuffer h = new StringBuffer();
        String value = getDefaultvalueToString(teasession);
        if("file".equals(type) || "img".equals(type))
        {
            h.append("<input type='file' name='attribute" + dynamictype + "' title=\"" + dynamictype + ":" + getName(_nLanguage) + "\" />");
        } else if("select".equals(type))
        {
            h.append(select(teasession,value,""));
        } else if("radio".equals(type))
        {
            StringTokenizer tokenizer = new StringTokenizer(getContent(_nLanguage),"/");
            for(int index = 0;tokenizer.hasMoreTokens();index++)
            {
                String str = tokenizer.nextToken();
                Radio select = new Radio("dynamictype" + dynamictype,str,index == 0);
                String id = String.valueOf(dynamictype) + "_" + index;
                select.setId(id);
                h.append(select + "<label for=" + id + ">" + str.replaceAll("<","&lt;").replaceAll(">","&gt;") + "</label> ");
            }
        } else if("office".equals(type))
        {
            h.append("<input type=button name=dynamictype_button" + dynamictype).append(" value=\"" + getName(teasession._nLanguage) + "\" />");
        } else if("date".equals(type))
        {
            h.append("<input readonly name=dynamictype" + dynamictype + " title=\"" + dynamictype + ":" + getName(_nLanguage) + "\" /><a href=### onclick=showCalendar(\"document.all('dynamictype" + dynamictype + "')\")><img src=/tea/image/public/Calendar2.gif></a>");
        } else if("datesel".equals(type))
        {
            h.append(new tea.htmlx.TimeSelection("dynamictype" + dynamictype,null));
        } else if("csign".equals(type))
        {
            h.append("<input type=button name=dynamictype" + dynamictype).append(" value=会签>");
        } else if("checkbox".equals(type))
        {
            StringTokenizer tokenizer = new StringTokenizer(getContent(_nLanguage),"/");
            for(int index = 0;tokenizer.hasMoreTokens();index++)
            {
                String str = tokenizer.nextToken();
                CheckBox select = new CheckBox("dynamictype" + dynamictype,false,str);
                String id = String.valueOf(dynamictype) + "_" + index;
                select.setId(id);
                h.append(select + "<label for=" + id + ">" + str.replaceAll("<","&lt;").replaceAll(">","&gt;") + "</label> ");
            }
        } else if("sign".equals(type))
        {
            h.append("<input type='button' name=dynamictype_button" + dynamictype + " value='签字'>");
        } else if("cachet".equals(type))
        {
            h.append("<input type='button' name=dynamictype_button" + dynamictype + " value='盖章'>");
        } else if("textarea".equals(type))
        {
            h.append(new TextArea("dynamictype" + dynamictype,value,5,60).toString());
        } else if("wordedit".equals(type))
        {
            h
                    .append("<textarea name=dynamictype" + dynamictype + " style=display:none>" + value.replaceAll("</","&lt;/")
                            + "</textarea><script>document.write('<div id=word_body></div>'); et=new word('word_body', form1.dynamictype" + dynamictype
                            + "); form1.attachEvent('onsubmit', et.save);</script>");
        } else if("folder".equals(type))
        {
            StringBuffer sb = new StringBuffer();
            //块
            Enumeration e = DynamicType.findByDynamic(dynamic," AND father=" + dynamictype,0,Integer.MAX_VALUE);
            while(e.hasMoreElements())
            {
                int id = ((Integer) e.nextElement()).intValue();
                DynamicType obj = DynamicType.find(id);
                sb.append(obj.getBefore(teasession._nLanguage));
                sb.append(obj.getText(teasession));
                sb.append(obj.getAfter(teasession._nLanguage));
            }
            //列
            int qu = quantity;
            if(columns > 1)
            {
                String col = sb.toString();
                sb = new StringBuffer();
                for(int i = 0;i < columns;i++)
                {
                    sb.append(col);
                }
                qu /= columns;
                if(quantity % columns != 0)
                {
                    qu++;
                }
            }
            for(int i = 0;i < qu;i++)
            {
                if(i > 0)
                {
                    h.append(columnafter);
                }
                h.append(sb);
            }
            if(quantity < 2)
            {
                String ih = (columnafter + sb.toString()).replaceAll("\"","\\\\\"").replaceAll("\r\n","\\\\r\\\\n");
                h.append("<span id='folder" + dynamictype + "'></span>");
                h.append("<script>function f_folder" + dynamictype + "(){folder" + dynamictype + ".innerHTML+=\"" + ih + "\";}</script>");
                h.append("<a href='javascript:f_folder" + dynamictype + "()'><img src='/tea/image/editor/plus.gif'></a>");
            }
        } else
        {
            h.append("<input name='dynamictype" + dynamictype + "' value='" + value + "' title=\"" + dynamictype + ":" + getName(_nLanguage) + "\" />");
        }
        if(defaultvalue == 7)
        {
            h.append("<input type=button class=dt_button name=dynamictype_button" + dynamictype + " value=管理 onclick=window.open('/jsp/community/DynamicTypeContents.jsp?community="
                     + teasession._strCommunity + "&dynamictype=" + dynamictype + "','','width=500,height=500,scrollbars=1');>");
        }
        return h.toString();
    }

    public String getHtml(TeaSession teasession,int node) throws UnsupportedEncodingException,SQLException
    {
        StringBuffer h = new StringBuffer();
        DynamicValue av = DynamicValue.find(node,teasession._nLanguage,dynamictype);
        String v;
        if(av.isExists())
        {
            v = av.getValue();
        } else
        {
            v = getContent(teasession._nLanguage);
        }
        if(defaultvalue == 5 || defaultvalue == 6 || defaultvalue == 10) //如果是节点号
        {
            try
            {
                v = Node.find(Integer.parseInt(v)).getSubject(teasession._nLanguage);
            } catch(Exception ex)
            {}
        }
        if("radio".equals(type))
        {
            StringBuffer sb = new StringBuffer();
            StringTokenizer tokenizer = new StringTokenizer(getContent(teasession._nLanguage),"/");
            for(int index = 0;tokenizer.hasMoreTokens();index++)
            {
                String str = tokenizer.nextToken();
                boolean bool = str.equals(v); // || index == 0;
                tea.html.Radio select = new tea.html.Radio("dynamictype" + dynamictype,str,bool);
                select.setDisabled(!bool);
                String strid = String.valueOf(dynamictype) + "_" + index;
                select.setId(strid);
                sb.append(select).append("<label for=").append(strid).append(">").append(str).append("</label> ");
            }
            h.append(sb.toString());

        } else
        if("code".equals(type))
        {
            h.append("<SPAN id=code >" + v + "</SPAN>");
        } else if(v != null && v.length() > 0)
        {
            String name = v.substring(v.lastIndexOf("/") + 1);
            String ext = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
            if("file".equals(type) || "doc".equals(ext) || "xls".equals(ext) || "rar".equals(ext))
            {
                h.append("<a href=/jsp/include/DownFile.jsp?uri=" + URLEncoder.encode(v,"UTF-8") + "&name=" + URLEncoder.encode(name,"UTF-8") + " ><img src='/tea/image/netdisk/" + ext + ".gif' align='top' onerror=\"src='/tea/image/netdisk/defaut.gif';onerror=null;\">" + name + "</a>");
            } else if("img".equals(type))
            {
                h.append("<IMG SRC=" + v + ">");
            } else
            {
                h.append(v);
            }
        }
        return h.toString();
    }

    //status参数: 0:正常,1:禁止(当前项不可填时,不显示默认值),2:只读
    //status为什么不用JS搞定? status!=0时没有默认值,office打开文件不同.
    private int seq;
    public String getText(TeaSession teasession,int node,int status) throws SQLException
    {
        int lang = teasession._nLanguage;
        Resource r = new Resource("/tea/resource/Dynamic");
        String value = "";
        DynamicValue av = DynamicValue.find(node,lang,dynamictype);
        if(father == 0 && av.isExists()) //father == 0 防止显示别人的数据
        {
            value = av.getValue();
        } else if(status == 0)
        {
            value = getDefaultvalueToString(teasession);
        }
        if(father > 0)
        {
            Enumeration e;
            if(separate)
            {
                String member = null;
                e = DynamicType.findByDynamic(dynamic," AND father=" + father + " AND type='select' AND defaultvalue=12 AND hidden=1",0,1);
                if(e.hasMoreElements())
                {
                    int id12 = ((Integer) e.nextElement()).intValue();
                    e = DynamicValue.find(node,lang,id12).findMulti("",seq,1);
                    if(e.hasMoreElements())
                    {
                        member = ((DynamicValue.Multi) e.nextElement()).getValue();
                        e = av.findMulti(" AND member=" + DbAdapter.cite(member),0,1);
                    }
                }
                if(!teasession._rv._strV.equals(member)) //不是当前会员,不可编辑
                {
                    status = 2;
                }
            } else
            {
                e = av.findMulti("",seq,1);
            }
            if(e.hasMoreElements())
            {
                DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
                value = m.getValue();
            }
        }
        String dis = status != 0 ? " disabled='true' class='dis'" : "";
        StringBuffer h = new StringBuffer();
        h.append(this.getBefore(lang)); //+ "<b>" + dynamictype + "</b>"
        h.append("<span id='before").append(dynamictype).append("'></span>"); //上一步修改的字段,前面加↑.
        try
        {
            if("file".equals(type) || "img".equals(type))
            {
                if(multi)
                {
                    h.append("<input type='button' name='dynamictype_button" + dynamictype + "' style='position:absolute' value='添加文件'").append(dis).append(" />");
                    if(status == 0)
                    {
                        h.append("<input type='file' name='dynamictype" + dynamictype + "' style='position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)' onchange='f_add(this)'/>");
                        h.append("<input type='hidden' name='dynamictype_del" + dynamictype + "' value='/' /><br/>");
                        h.append("<script>");
                        h.append("if(!histfile)var histfile=new Array();");
                        h.append("function f_add(obj)");
                        h.append("{");
                        h.append("  var nn=obj.cloneNode(true);");
                        h.append("  obj.parentNode.insertBefore(nn,obj);");
                        h.append("  obj.style.display='none';");
                        h.append("  var p=obj.value;");
                        h.append("  var name=p.substring(p.lastIndexOf('\\\\')+1);");
                        //
                        h.append("  var tb=document.getElementById('tb" + dynamictype + "');");
                        h.append("  var tr = document.createElement('tr');");
                        h.append("  tr.id='tr'+histfile.length;");
                        h.append("  var td = document.createElement('td');");
                        h.append("  td.innerHTML=(histfile.length+1)+\"、<img src='/tea/image/netdisk/\"+name.substring(name.lastIndexOf('.')+1).toLowerCase()+\".gif' width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'; />\"+name;");
                        h.append("  tr.appendChild(td);");
                        h.append("  td = document.createElement('td');");
                        h.append("  td.innerHTML='<input type=\"button\" onclick=\"f_del('+histfile.length+')\" value=\"" + r.getString(lang,"CBDelete") + "\"/>';");
                        h.append("  tr.appendChild(td);");
                        h.append("  tb.appendChild(tr);");
                        h.append("  histfile.push(obj);");
                        h.append("}");
                        h.append("function f_del(id)");
                        h.append("{");
                        h.append("  if(confirm('" + r.getString(lang,"ConfirmDelete") + "'))");
                        h.append("  {");
                        h.append("    var tr=document.getElementById('tr'+id);");
                        h.append("    tr.style.display='none';");
                        h.append("    if(histfile[id])");
                        h.append("    {");
                        h.append("      histfile[id].disabled=true;");
                        h.append("    }else");
                        h.append("    {");
                        h.append("      document.getElementById('dynamictype_del" + dynamictype + "').value+=id.substring(1)+'/';");
                        h.append("    }");
                        h.append("  }");
                        h.append("}");
                        h.append("</script>");
                    }
                    h.append("<table class='filemulti'><tbody id='tb" + dynamictype + "'>");
                    Enumeration e = av.findMulti("",0,Integer.MAX_VALUE);
                    for(int i = 1;e.hasMoreElements();i++)
                    {
                        DynamicValue.Multi dvm = (DynamicValue.Multi) e.nextElement();
                        int id = dvm.getSeqID();
                        String member = dvm.getMember();
                        String path = dvm.getValue();
                        value = path.substring(path.lastIndexOf('/') + 1);
                        h.append("<tr id='trm" + id + "'><td>" + i + "、<a href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(path,"UTF-8") + "&amp;name=" + java.net.URLEncoder.encode(value,"UTF-8") + "'><img src='/tea/image/netdisk/" + value.substring(value.lastIndexOf('.') + 1).toLowerCase() + ".gif' width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'; />").append(value).append("</a></td>");
                        //h.append("<td>").append(member);
                        h.append("<td>&nbsp;");
                        if(member.equals(teasession._rv._strV))
                        {
                            h.append("<input type='button' onclick=\"f_del('m" + id + "')\" value='" + r.getString(lang,"CBDelete") + "'>");
                        }
                        h.append("</td></tr>\r\n");
                    }
                    h.append("</tbody></table>");
                } else
                {
                    h.append("<input type='file' name='dynamictype" + dynamictype + "'").append(dis).append(" />");
                    if(value != null && value.length() > 0)
                    {
                        String name = value.substring(value.lastIndexOf("/") + 1);
                        String ext = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
                        h.append("<a href='/jsp/include/DownFile.jsp?uri=" + URLEncoder.encode(value,"UTF-8") + "&name=" + URLEncoder.encode(name,"UTF-8") + "'><img src='/tea/image/netdisk/").append(ext).append(".gif' onerror=\"src='/tea/image/netdisk/defaut.gif';onerror=null;\">").append(name).append("</a><INPUT TYPE=checkbox onclick=\"document.all['dynamictype" + dynamictype + "'].disabled=this.checked;\" NAME=dynamictype_checkbox" + dynamictype + " />" + r.getString(lang,"Clear"));
                    }
                }
            } else if("select".equals(type))
            {
                h.append(select(teasession,value,dis));
            } else if("radio".equals(type))
            {
                StringTokenizer tokenizer = new StringTokenizer(getContent(lang),"/");
                for(int index = 0;tokenizer.hasMoreTokens();index++)
                {
                    String str = tokenizer.nextToken();
                    String id = String.valueOf(dynamictype) + "_" + index;
                    h.append("<input type='radio' name='dynamictype" + dynamictype + "' value=\"" + str + "\" id='" + id + "'");
                    if(str.equals(value) || index == 0)
                    {
                        h.append(" checked='true'");
                    }
                    h.append(dis).append(" /><label for=" + id + ">" + str + "</label> ");
                }
            } else if("checkbox".equals(type))
            {
                h.append("<input type='hidden' name='dynamictype" + dynamictype + "'");
                if(av.isExists())
                {
                    h.append(" value=\"" + value + "\"");
                }
                h.append(dis).append(" />");
                StringTokenizer tokenizer = new StringTokenizer(getContent(lang),"/");
                for(int index = 0;tokenizer.hasMoreTokens();index++)
                {
                    String str = tokenizer.nextToken();
                    String id = String.valueOf(dynamictype) + "_" + index;
                    h.append("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\"");
                    if(value != null && (value.indexOf("　" + str + "　") != -1 || value.startsWith(str + "　")))
                    {
                        h.append(" checked='true'");
                    }
                    h.append(dis).append(" />").append("<label for=" + id + ">" + str + "</label> ");
                }
            } else if("textarea".equals(type))
            {
                h.append("<textarea name='dynamictype" + dynamictype + "' cols='60' rows='5'").append(dis).append(">");
                if(value != null)
                {
                    h.append(value.replaceAll("</","&lt;/"));
                }
                h.append("</textarea>");
            } else if("wordedit".equals(type))
            {
                h.append("<textarea name=dynamictype" + dynamictype + " style=display:none").append(dis).append(">" + value.replaceAll("</","&lt;/") + "</textarea>");
                h.append("<iframe src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=dynamictype" + dynamictype + "&Toolbar=" + teasession._strCommunity + "' width='730' height='300' frameborder='no' scrolling='no'></iframe>");
            } else if("office".equals(type))
            {
                if(status != 1 && !av.isExists())
                {
                    Flowbusiness fb = Flowbusiness.find(node);
                    int prev = fb.getPrev();
                    if(binding > 0 && prev > 0) //获取上个事务的内容
                    {
                        DynamicValue dv = DynamicValue.find( -prev,teasession._nLanguage,binding);
                        if(dv.isExists())
                        {
                            value = dv.getValue();
                        }
                    }
                    Flow f = Flow.find(fb.getFlow()); //流程模板//
                    String tmp = f.getTemplate(teasession._nLanguage);
                    if(tmp != null && tmp.length() > 0)
                    {
                        value = tmp;
                    }
                    if(value == null || value.length() == 0) //社区模板///
                    {
                        CommunityOffice co = CommunityOffice.find(teasession._strCommunity);
                        value = co.getTemplate();
                    }
                }
                h.append("<input type='hidden' name='dynamictype" + dynamictype).append("' value=\"" + value + "\">");
                h.append("<input type='button' dtype='office' name='dynamictype_button" + dynamictype).append("' value=\"" + getName(teasession._nLanguage) + "\" onclick=\"window.showModalDialog('"); //open
                if(status == 0)
                {
                    h.append("/jsp/admin/flow/EditDynamicOffice.jsp?community=" + teasession._strCommunity + "&field=dynamictype" + dynamictype).append("&sync=").append(sync);
                } else
                {
                    h.append("/jsp/community/options_office/OfficeView.jsp?community=" + teasession._strCommunity + "&file=" + URLEncoder.encode(value,"UTF-8"));
                }
                h.append("',self,'dialogWidth:880px;dialogHeight:600px;resizable:1;help:0;');\"");
                if(status == 2)
                {
                    h.append(" style=\"background:none;border:1px solid #D3D3D3\"");
                }
                h.append(dis).append(" />");
            } else if("date".equals(type))
            {
                h.append("<input name='dynamictype" + dynamictype + "' type='text' onclick='showCalendar(this)' readonly='true' value=\"" + value + "\"").append(dis).append(" />");
//        if (status == 0)
//        {
//          h.append("<a href='###' onclick=showCalendar(\"document.all('dynamictype" + dynamictype + "')\")><img src='/tea/image/public/Calendar2.gif'></a>");
//        }
            } else if("csign".equals(type))
            {
                Flowbusiness fb = Flowbusiness.find(Math.abs(node));
                //Flowprocess fp = Flowprocess.find(fb.getFlow(), fb.getStep());
                Enumeration e = DynamicCsign.find(node,dynamictype);
                if(e.hasMoreElements()) //存在会签
                {
                    StringBuilder hattach = new StringBuilder();
                    hattach.append("<table cellspacing='0' cellpadding='0' id='tablecsignattach'><tr><td colspan='2' style='text-align:center;font-weight:bold;font-size:15.0pt;line-height:150%;font-family:宋体;border:0px;margin-bottom:20px;'>文件签发/会签单（附页）</td></tr>");
                    hattach.append("<tr><td colspan='2'><table cellspacing='0' cellpadding='0' id='tablebottom_01'><tr><td class='wenj_name'>文件题目</td><td class='wenj_td'>" + fb.name + "</td></tr></table></td></tr>");
                    hattach.append("<tr><td class='pings_xg'>评<br/>审<br/>修<br/>改<br/>意<br/>见<br/>栏</td><td class='pings_right'><table cellspacing='0' cellpadding='0' id='table_nei_01'>");
                    h.append("<table cellspacing='0' cellpadding='0' id='tablecsign'><tr><td class='csigntitle' colspan='5' align='center'>会签意见栏</td></tr>");
                    h.append("<tr><td>送签时间</td><td>会签部门/人员</td><td>会签意见</td><td>签名</td><td>签出日期</td></tr>");
                    //Enumeration e = Flowview.find(fb.getFlowbusiness(), fp.getFlowprocess()); //本步骤待办人员
                    for(int i = 0;e.hasMoreElements();i++)
                    {
                        String member = (String) e.nextElement();
                        DynamicCsign dc = DynamicCsign.find(node,dynamictype,member);
                        String csign = dc.getSign();
                        String disabled = (status != 0 || !member.equals(teasession._rv._strV)) ? " disabled='true' class='dis' " : " "; //不可填||不是当前会员
                        String endtime = dc.getEndTimeToString();
                        if(endtime.length() < 1 && member.equals(teasession._rv._strV)) //如果不存在&& 是当前会员,就给个默认值
                        {
                            endtime = DynamicCsign.sdf.format(new Date());
                        }
                        //
                        h.append("<input type='hidden' name='csign' value='" + i + "' " + disabled + ">");
                        h.append("<tr><td class='songqian_time'><input name='csignstarttime" + i + "' " + disabled + " value='" + dc.getStartTimeToString() + "' size='12' readonly='true'><a href=### onclick=showCalendar(\"document.all('csignstarttime" + i + "')\")><img src='/tea/image/public/Calendar2.gif'></a>");
                        h.append("<td class='huiqian_ren'>" + member + "同志");
                        h.append("<td class='huiqian_yij'>");
                        for(int j = 0;j < DynamicCsign.COMMENT_TYPE.length;j++)
                        {
                            h.append("<input type=radio name='csigncomment" + i + "' " + disabled + "  value='" + j + "' onclick='f_showarea(this)' id='csigncomment" + i + "_" + j + "'");
                            if(j == dc.getComment())
                            {
                                h.append("checked");
                            }
                            h.append("><label for='csigncomment" + i + "_" + j + "'>" + DynamicCsign.COMMENT_TYPE[j] + "</label><br>");
                        }
                        h.append("<td class='qian_m'>");
                        //签名
                        boolean flag_cs = csign != null && csign.length() > 0;
                        if(flag_cs)
                        {
                            h.append("<input type='hidden' name='csignsign" + i + "' value=\"" + csign + "\">");
                            h.append("<img src='" + csign + "' height='30' oncontextmenu='return false' >");
                        } else
                        {
                            h.append("<input type='hidden' name='csignsign" + i + "'>");
                            h.append("<img src='about:blank' id='imgcsign" + i + "' style='display:none' onload=style.display=''; height='30' oncontextmenu='return false' >");
                            ProfileBBS pb = ProfileBBS.find(teasession._strCommunity,member);
                            String isign = pb.getISign(teasession._nLanguage);
                            h.append("<input type='button' name=dynamictype_button" + dynamictype + "  " + disabled + "  value='签字' onclick=\"if(confirm('确认签字?')){ ");
                            if(isign == null || isign.length() == 0)
                            {
                                h.append("alert('您还没有上传你的签名.')");
                            } else
                            {
                                h.append("document.all('csignsign" + i + "').value='" + isign + "'; style.display='none'; document.all('imgcsign" + i + "').src=document.all('aimgcsign" + i + "').src='" + isign + "';");
                            }
                            h.append(" }\">");
                        }
                        //
                        h.append("<td class='qianchu_time'><input name='csignendtime" + i + "'  " + disabled + " value='" + endtime + "' onpropertychange=document.getElementById('aendtime" + i + "').innerHTML=value; size='12' readonly='true'><a href=### onclick=showCalendar(\"document.all('csignendtime" + i + "')\")><img src='/tea/image/public/Calendar2.gif'></a>");
                        //附页
                        String content = dc.getContent();
                        String unit = "--";
                        AdminUnit au = AdminUnit.find(AdminUsrRole.find(teasession._strCommunity,member).getUnit());
                        if(au.isExists())
                        {
                            unit = au.getName();
                        }
                        hattach.append("<tr id='tablearea" + i + "' style='display:" + (dc.getComment() != 2 ? "none" : "") + "'><td><table cellspacing='0' cellpadding='0' class='tablebottom_001'><tr><td colspan='4' class='tdtext'><textarea name='csigncontent" + i + "' rows='5' cols='60' " + disabled + " >" + (content != null ? content.replaceAll("<","&lt;") : "") + "</textarea></td></tr><tr><td class='huiq_bum'>会签部门：" + unit + "</td>");
                        hattach.append("<td class='huiq_rm'>会签人（签名/日期）：</td>");
                        hattach.append("<td class='huiq_qm'><img id='aimgcsign" + i + "' src='" + csign + "' style='display:" + (flag_cs ? "" : "none") + "' onload=style.display=''; height='30' oncontextmenu='return false' /></td>");
                        hattach.append("<td class='huiq_time' id='aendtime" + i + "'>" + endtime + "</td>");
                        hattach.append("</tr></table>");
                    }
                    h.append("</table>");
                    //附页
                    hattach.append("</table></td></tr></table>");
                    hattach.append("<script>");
                    hattach.append("function f_showarea(obj)");
                    hattach.append("{");
                    hattach.append("  document.all('tablearea'+obj.name.substring(12)).style.display=obj.value=='2'?'':'none';");
                    hattach.append("  f_showattach();");
                    hattach.append("}");
                    ////如果存在会签附页,则显示外框架
                    hattach.append("var tcsa=document.all('tablecsignattach');");
                    hattach.append("function f_showattach()");
                    hattach.append("{");
                    hattach.append("  var flag=false;");
                    hattach.append("  var arr=document.getElementsByTagName('INPUT');");
                    hattach.append("  for(var i=0;i<arr.length;i++)");
                    hattach.append("  {");
                    hattach.append("    if(arr[i].name.indexOf('csigncomment')==0&&arr[i].value=='2'&&arr[i].checked)");
                    hattach.append("    {");
                    hattach.append("      flag=true;");
                    hattach.append("      break;");
                    hattach.append("    }");
                    hattach.append("  }");
                    hattach.append("  tcsa.style.display=flag?'':'none';");
                    hattach.append("}");
                    hattach.append("f_showattach();");
                    hattach.append("</script>");
                    h.append(hattach);
                } else
                { //管理层设置候选人
                    String csunit = fb.getCSUnit();
                    String csmember = fb.getCSMember();
                    if(fb.isExists() && (csunit.length() > 2 || csmember.length() > 2))
                    {
                        String time = DynamicType.sdf.format(new Date());
                        h.append("<table cellspacing='0' cellpadding='0' id='tablecsign'><tr><td class='csigntitle' colspan='5' align='center'>会签意见栏</td></tr>");
                        h.append("<tr><td>送签时间</td><td>会签部门/人员</td><td>会签意见</td><td>签名</td><td>签出日期</td></tr>");
                        String cs[] = csunit.split("/");
                        for(int i = 1;i < cs.length;i++)
                        {
                            AdminUnit au = AdminUnit.find(Integer.parseInt(cs[i]));
                            h.append("<tr><td class='songqian_time'><input disabled style='background:#E1E1E1' value='" + time + "' size='12'><img src='/tea/image/public/Calendar2.gif'>");
                            h.append("<td class='huiqian_ren'>" + au.getName());
                            h.append("<td class='huiqian_yij'>");
                            for(int j = 0;j < DynamicCsign.COMMENT_TYPE.length;j++)
                            {
                                h.append("<input type=radio  disabled style='background:#E1E1E1'  >" + DynamicCsign.COMMENT_TYPE[j] + "<br>");
                            }
                            h.append("<td class='qian_m'><input type=button value='签字'  disabled style='background:#E1E1E1' >");
                            h.append("<td class='qianchu_time'><input  disabled style='background:#E1E1E1'  size='12'><img src='/tea/image/public/Calendar2.gif'>");
                        }
                        cs = csmember.split("/");
                        for(int i = 1;i < cs.length;i++)
                        {
                            String member = cs[i];
                            h.append("<tr><td class='songqian_time'><input disabled style='background:#E1E1E1' value='" + time + "' size='12'><img src='/tea/image/public/Calendar2.gif'>");
                            h.append("<td class='huiqian_ren'>" + member + "同志");
                            h.append("<td class='huiqian_yij'>");
                            for(int j = 0;j < DynamicCsign.COMMENT_TYPE.length;j++)
                            {
                                h.append("<input type=radio  disabled style='background:#E1E1E1'  >" + DynamicCsign.COMMENT_TYPE[j] + "<br>");
                            }
                            h.append("<td class='qian_m'><input type=button value='签字'  disabled style='background:#E1E1E1' >");
                            h.append("<td class='qianchu_time'><input  disabled style='background:#E1E1E1'  size='12'><img src='/tea/image/public/Calendar2.gif'>");
                        }
                        h.append("</table>");
                    }
                }
            } else if("code".equals(type)) // 光大合同编号
            {
                h.append("<input name='code" + dynamictype + "' type='text' readonly='true' value=\"" + value + "\"").append(dis).append(" />");
            } else if("sign".equals(type))
            {
                h.append("<input type='hidden' name='dynamictype" + dynamictype + "' value=\"" + value + "\">");
                h.append("<img id=img" + dynamictype + " src='" + value + "' style='display:none' onload=\"this.style.display='';\" oncontextmenu='return false'");
                if(!"".equals(width))
                {
                    h.append(" width='" + width + "'");
                }
                if(!"".equals(height))
                {
                    h.append(" height='" + height + "'");
                }
                h.append(">");
                if(!av.isExists() || "".equals(value))
                {
                    h.append("<input type='button' name=dynamictype_button" + dynamictype + " value='签字'");
                    if(status == 0)
                    {
                        ProfileBBS pb = ProfileBBS.find(teasession._strCommunity,teasession._rv._strV);
                        String isign = pb.getISign(teasession._nLanguage);
                        h.append(" onclick=\"if(confirm('确认签字?')){ ");
                        if(isign == null || isign.length() == 0)
                        {
                            h.append("alert('您还没有上传你的签名.')");
                        } else
                        {
                            h.append("var img=previousSibling; img.previousSibling.value='" + isign + "'; style.display='none'; img.src='" + isign + "'; img.style.display='';");
                        }
                        h.append(" }\"");
                    } else
                    {
                        h.append(dis);
                    }
                    h.append(" />");
                }
            } else if("cachet".equals(type))
            {
                h.append("<input type=hidden name=dynamictype" + dynamictype + " value=" + value + ">");
                h.append("<img id=img" + dynamictype + " src='" + value + "' style='display:none' onload=\"this.style.display='';\">");
                if(!av.isExists() || "".equals(value))
                {
                    h.append("<input type='button' name=dynamictype_button" + dynamictype + " value='盖章'");
                    if(status == 0)
                    {
                        h.append(" onclick=\"if(confirm('确认盖章?')){ ");
                        h.append("var v=window.showModalDialog('/jsp/admin/office/CachetList.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:500px;dialogHeight:400px;dialogTop:200px;dialogLeft:200px');");
                        h.append("document.all('dynamictype" + dynamictype + "').value=v[1]; style.display='none'; var img=document.all('img" + dynamictype + "'); img.src=v[1]; img.style.display='';");
                        h.append(" }\"");
                    } else
                    {
                        h.append(dis);
                    }
                    h.append(" />");
                }
            } else if("folder".equals(type))
            {
                //列
                int qu = quantity;
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT COUNT(*) FROM DynamicValueMulti WHERE dynamictype IN(SELECT dynamictype FROM DynamicType WHERE father=" + dynamictype + ") AND node=" + node + " GROUP BY dynamictype,node,language ORDER BY COUNT(*) DESC",0,1);
                    if(db.next())
                    {
                        qu = Math.max(qu,db.getInt(1));
                    }
                } finally
                {
                    db.close();
                }
                if(columns > 1)
                {
                    while(qu % columns != 0)
                    {
                        qu++;
                    }
                }
                ArrayList al = new ArrayList();
                StringBuffer sb = new StringBuffer();
                Enumeration e = DynamicType.findByDynamic(dynamic," AND father=" + dynamictype,0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    DynamicType obj = DynamicType.find(id);
                    if(obj.isHidden())
                    {
                        sb.append(obj.getText(teasession,0,0));
                        al.add(id);
                    }
                }
                for(int i = 0;i < qu;i++)
                {
                    if(i > 0 && i % columns == 0)
                    {
                        h.append(columnafter);
                    }
                    //块
                    for(int j = 0;j < al.size();j++)
                    {
                        int id = ((Integer) al.get(j)).intValue();
                        DynamicType obj = DynamicType.find(id);
                        obj.seq = i;
                        h.append(obj.getText(teasession,node,0));
                    }
                }
                if(status == 0 && quantity < 2)
                {
                    //列
                    if(columns > 1)
                    {
                        String col = sb.toString();
                        sb = new StringBuffer();
                        for(int i = 0;i < columns;i++)
                        {
                            sb.append(col);
                        }
                    }
                    String ih = (columnafter + sb.toString()).replaceAll("\"","\\\\\"").replaceAll("\r\n","\\\\r\\\\n");
                    h.append("<span id='folder" + dynamictype + "'></span>");
                    h.append("<script>function f_folder" + dynamictype + "(){folder" + dynamictype + ".innerHTML+=\"" + ih + "\";}</script>");
                    h.append("<input type='image' onclick=\"f_folder" + dynamictype + "();return false;\" src='/tea/image/editor/plus.gif' />");
                }
            } else
            {
                h.append("<input name='dynamictype" + dynamictype + "' type='text' onkeydown='if(event.keyCode==13){event.keyCode=9;}' value=\"" + value + "\"").append(dis).append(" />");
            }
            if(status == 0 && defaultvalue == 7)
            {
                h.append("<input type=button class=dt_button name=dynamictype_button" + dynamictype + " value='管理' onclick=window.open('/jsp/community/DynamicTypeContents.jsp?community="
                         + teasession._strCommunity + "&dynamictype=" + dynamictype + "','','width=500,height=500,scrollbars=1');>");
            }
            h.append(this.getAfter(lang));
        } catch(IOException ex)
        {
            ex.printStackTrace();
        }
        return h.toString();
    }

    public static int getMaxSequence(int dynamic) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT MAX(sequence) FROM DynamicType WHERE dynamic=" + dynamic);
        } finally
        {
            db.close();
        }
        return j;
    }

    public int getDynamic()
    {
        return dynamic;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getType()
    {
        return type;
    }

    public int getDynamictype()
    {
        return dynamictype;
    }

    public int getSequence()
    {
        return sequence;
    }

    public String getBefore(int language) throws SQLException
    {
        return getLayer(language).beforeitem;
    }

    public String getAfter(int language) throws SQLException
    {
        return getLayer(language).afteritem;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public boolean isNeed()
    {
        return need;
    }

    public boolean isQrc()
    {
        return qrc;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }

    public boolean isLayerExists(int language) throws SQLException
    {
        return getLayer(language).layerExists;
    }

    public int getDefaultvalue()
    {
        return defaultvalue;
    }

    public int getBinding()
    {
        return binding;
    }

    public int getFilecenter()
    {
        return filecenter;
    }

    public boolean isSync()
    {
        return sync;
    }

    public boolean isMulti()
    {
        return multi;
    }

    public String getWidth()
    {
        return width;
    }

    public String getHeight()
    {
        return height;
    }

    public int getQuantity()
    {
        return quantity;
    }

    public int getColumns()
    {
        return columns;
    }

    public int getFather()
    {
        return father;
    }

    public boolean isSeparate()
    {
        return separate;
    }

    public boolean isExport()
    {
        return export;
    }

    public String getColumnAfter()
    {
        return columnafter;
    }

    public String getDefaultvalueToString(TeaSession teasession) throws SQLException
    {
        String value = null;
        switch(defaultvalue)
        {
        case 1:
            value = MT.f(new Date()).replaceFirst("-","年").replaceFirst("-","月") + "日";
            break;
        case 2:
            if(teasession._rv != null)
            {
                String member = teasession._rv.toString();
                value = Profile.find(member).getName(teasession._nLanguage);
                if("sign".equals(type))
                {
                    String pic = ProfileBBS.find(teasession._strCommunity,member).getISign(teasession._nLanguage);
                    value = pic != null ? pic += "?" + member : value;
                }
            }
            break;
        case 3:
            AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
            int unit = aur.getUnit();
            AdminUnit au = AdminUnit.find(unit);
            if(au.isExists())
            {
                value = au.getName();
            } else
            {
                value = "无部门";
            }
            break;
        case 4:
            aur = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
            String role = aur.getRole();
            if(role.length() > 2)
            {
                int id = Integer.parseInt(role.split("/")[1]);
                AdminRole ar = AdminRole.find(id);
                value = ar.getName();
            } else
            {
                value = "无角色";
            }
            break;
        case 11:
            if(teasession._rv != null)
            {
                Profile p = Profile.find(teasession._rv.toString());
                value = p.getTelephone(teasession._nLanguage);
                break;
            }
        default:
            value = getContent(teasession._nLanguage);
        }
        return value;
    }

    private String select(TeaSession teasession,String value,String dis) throws SQLException
    {
        int lang = teasession._nLanguage;
        StringBuffer h = new StringBuffer();
        StringTokenizer st = new StringTokenizer(getContent(lang),"/");
        switch(defaultvalue)
        {
        case 5: //信息类别
        {
            int big = 0;
            StringBuffer js1 = new StringBuffer();
            StringBuffer js2 = new StringBuffer();
            h.append("<select name='dynamictype_checkbox").append(dynamictype).append("' onchange='f1_change" + dynamictype + "()'");
            if(st.countTokens() == 1) //一级下拉,只有一条,则隐藏
            {
                h.append(" style='display:none'");
            }
            h.append(dis).append(">");
            while(st.hasMoreElements())
            {
                int nodeid = Integer.parseInt(st.nextToken());
                Node node_obj = Node.find(nodeid);
                h.append("<option value=\"" + nodeid + "\">").append(node_obj.getSubject(lang));
                //
                js1.append("case ").append(nodeid).append(":");
                Enumeration e = Node.findAllSons(nodeid);
                while(e.hasMoreElements())
                {
                    int nodeid2 = ((Integer) e.nextElement()).intValue();
                    String str2 = Node.find(nodeid2).getSubject(lang);
                    if(String.valueOf(nodeid2).equals(value)) //根据二级下拉菜单,调出一级下接菜单的value来
                    {
                        big = nodeid;
                    }
                    js1.append("op[op.length]=new Option(\"").append(str2).append("\",\"").append(nodeid2).append("\");");
                    //
                    js2.append("case ").append(nodeid2).append(":");
                    Enumeration e2 = DynamicType.findByDynamic(dynamic," AND binding>0 AND defaultvalue=0 AND dynamictype!=" + dynamictype,0,200);
                    while(e2.hasMoreElements())
                    {
                        int dt = ((Integer) e2.nextElement()).intValue();
                        DynamicValue dv = DynamicValue.find(nodeid2,lang,DynamicType.find(dt).getBinding());
                        String ev = dv.getValue();
                        js2.append("var op=document.all('dynamictype" + dt + "');");
                        js2.append("op.value=\"").append(ev != null ? ev : "").append("\";");
                    }
                    js2.append("break;\r\n");
                }
                js1.append("break;\r\n");
            }
            h.append("</select>");
            h.append("<select name='dynamictype" + dynamictype).append("' onchange='f2_change" + dynamictype + "(parseInt(value))'><option value=''>-----------------</option></select>");
            h.append("<input type='hidden' name='binding' value='" + dynamictype + "' />");
            h.append("<script>");
            h.append("function f1_change" + dynamictype + "(v1,v2)");
            h.append("{");
            h.append("  var big=document.all('dynamictype_checkbox" + dynamictype + "');");
            h.append("  if(v1)big.value=v1; else v1=parseInt(big.value);");
            h.append("  var op=document.all('dynamictype" + dynamictype + "');");
            h.append("  while(op.length>1){ op[1]=null; }");
            h.append("  switch(v1)");
            h.append("  {");
            h.append(js1.toString());
            h.append("  }");
            h.append("  if(v2){ op.value=v2; if(op.selectedIndex==-1)op.selectedIndex=0; }");
            h.append("}");
            h.append("f1_change" + dynamictype + "(" + big + ",\"" + value + "\");");
            h.append("function f2_change" + dynamictype + "(v)");
            h.append("{");
//h.append("  var op=document.all('dynamictype" + dynamictype + "');");
//h.append("  v=parseInt(op.value);");
            h.append("  switch(v)");
            h.append("  {");
            h.append(js2.toString());
            h.append("  }");
            h.append("}");
            h.append("</script>");
//        StringBuffer sb = new StringBuffer();
//        sb.append("<select name=dynamictype" + dynamictype).append(">").append("</select>");
//        sb.append("<script>var op=document.all('dynamictype" + dynamictype + "').options; var op2=document.all('dynamictype_checkbox" + dynamictype + "').options; function f_change(v){ while(op.length>0)op[0]=null; switch(parseInt(v)){");
//        DropDown select = new DropDown("dynamictype_checkbox" + dynamictype, value);
//        select.setOnChange("f_change(this.value);");
//        while (st.hasMoreTokens())
//        {
//          int nodeid = Integer.parseInt(st.nextToken());
//          Node node_obj = Node.find(nodeid);
//          String subject = node_obj.getSubject(lang);
//          select.addOption(nodeid, subject);
//          //
//          sb.append("case ").append(nodeid).append(":");
//          java.util.Enumeration e = Node.findAllSons(nodeid);
//          while (e.hasMoreElements())
//          {
//            nodeid = ( (Integer) e.nextElement()).intValue();
//            node_obj = Node.find(nodeid);
//            sb.append("op[op.length]=new Option(\"").append(node_obj.getSubject(lang)).append("\",\"").append(nodeid).append("\");");
//          }
//          sb.append("break;\r\n");
//        }
//        sb.append("}} aa:{for(var i=0;i<op2.length;i++){ op2[i].selected=true; f_change(op2[i].value); for(var j=0;j<op.length;j++){ if(op[j].value==\"" + value + "\"){ op[j].selected=true; break aa; }} }  }  </script>");
//        h.append(select.toString() + sb.toString());
        }
        break;
        case 10: //分类
        {
            String last = null;
            String big = "";
            StringBuffer js1 = new StringBuffer();
            StringBuffer js2 = new StringBuffer();
            h.append("<select name='dynamictype_checkbox" + dynamictype).append("' onchange='f1_change" + dynamictype + "()'").append(dis).append(">");
            Enumeration e = DynamicValue.find(" AND dynamictype=" + binding + " AND value IS NOT NULL ORDER BY value"); //列出此动态类的所有节点
            while(e.hasMoreElements())
            {
                DynamicValue dv = (DynamicValue) e.nextElement();
                int en = dv.getNode();
                String ev = dv.getValue();
                if(!ev.equals(last)) //一级菜单:和上一个不相同
                {
                    h.append("<option value=\"" + ev + "\">").append(ev);
                    if(js1.length() > 0) //第一个没有"break;"
                    {
                        js1.append("break;\r\n");
                    }
                    js1.append("case \"").append(ev).append("\":");
                    last = ev;
                }
                Node n = Node.find(en);
                if(n.getTime() != null)
                {
                    if(String.valueOf(en).equals(value)) //根据二级下拉菜单,调出一级下接菜单的value来
                    {
                        big = ev;
                    }
                    js1.append("op[op.length]=new Option(\"" + n.getSubject(lang) + "\"," + en + ");");
                    if(js2.length() > 0)
                    {
                        js2.append("break;\r\n");
                    }
                    js2.append("case ").append(en).append(":");
                    Enumeration e2 = DynamicType.findByDynamic(dynamic," AND binding>0 AND defaultvalue=0 AND dynamictype!=" + dynamictype,0,200);
                    while(e2.hasMoreElements())
                    {
                        int dt = ((Integer) e2.nextElement()).intValue();
                        dv = DynamicValue.find(en,lang,DynamicType.find(dt).getBinding());
                        ev = dv.getValue();
                        js2.append("var op=document.all('dynamictype" + dt + "');");
                        js2.append("op.value=\"").append(ev != null ? ev : "").append("\";");
                    }
                }
            }
            h.append("</select>");
            h.append("<select name='dynamictype" + dynamictype).append("' onchange='f2_change" + dynamictype + "(parseInt(value))'").append(dis).append("><option value=''>-----------------</option></select>");
            h.append("<input type='hidden' name='binding' value='" + dynamictype + "' />");
            h.append("<script>");
            h.append("function f1_change" + dynamictype + "(v1,v2)");
            h.append("{");
            h.append("  var big=document.all('dynamictype_checkbox" + dynamictype + "');");
            h.append("  if(v1)big.value=v1; else v1=big.value;");
            h.append("  var op=document.all('dynamictype" + dynamictype + "');");
            h.append("  while(op.length>1){ op[1]=null; }");
            h.append("  switch(v1)");
            h.append("  {");
            h.append(js1.toString());
            h.append("  }");
            h.append("  if(v2) op.value=v2;");
            h.append("}");
            h.append("f1_change" + dynamictype + "(\"" + big + "\",\"" + value + "\");");
            h.append("function f2_change" + dynamictype + "(v)");
            h.append("{");
            //h.append("  var op=document.all('dynamictype" + dynamictype + "');");
            //h.append("  v=parseInt(op.value);");
            h.append("  switch(v)");
            h.append("  {");
            h.append(js2.toString());
            h.append("  }");
            h.append("}");
            h.append("</script>");
        }
        break;
        case 12:
        {
            h.append("<select name='dynamictype" + dynamictype + "'").append(dis).append("><option value=''>---------");
            Enumeration e = AdminUsrRole.findByCommunity(teasession._strCommunity,"");
            while(e.hasMoreElements())
            {
                String member = (String) e.nextElement();
                h.append("<option value='").append(member).append("'"); //optgroup
                if(member.equals(value))
                {
                    h.append(" selected='true'");
                }
                h.append(">").append(member);
            }
            h.append("</select>");
        }
        break;
        default:
        {
            h.append("<select name='dynamictype" + dynamictype + "'").append(dis).append(">");
            while(st.hasMoreTokens())
            {
                String str = st.nextToken();
                if("-".equals(str))
                {
                    h.append("<option value=\"\">---------");
                } else
                {
                    h.append("<option value=\"" + str + "\"");
                    if(str.equals(value))
                    {
                        h.append(" selected='true'");
                    }
                    h.append(">" + str);
                }
            }
            h.append("</select>");
        }
        }
        return h.toString();
    }
}
