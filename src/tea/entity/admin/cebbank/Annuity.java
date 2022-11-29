package tea.entity.admin.cebbank;

import java.util.*;
import java.io.*;
import java.net.*;
import tea.entity.*;
import java.math.*;
import java.text.*;
import tea.resource.*;
import javax.servlet.http.*;
import javax.crypto.*;
import java.security.*;

public class Annuity extends Entity
{
    public static final DecimalFormat df = new DecimalFormat("#,##0.00");
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public static final String R = "<ANNUITY>"; // 年金会员所在的社区
    public static final String CHANNEL_NO = "0001";
    public static final String EC_0000 = "0000"; // 交易成功
    public static final String EC_0001 = "0001"; // 客户号、用户或密码有误
    public static final String EC_0002 = "0002"; // 错误尝试次数超过允许值
    public static final String EC_0003 = "0003"; // 密码修改失败
    public static final String EC_0004 = "0004"; // 查询数据过多,请调整查询范围
    public static final String EC_0005 = "0005"; // 身份证号码有重复，请用客户号登录
    public static final String EC_1001 = "1001"; // 交易码失败
    public static final String EC_1002 = "1002"; // 未知错误
    public static final String EC_1003 = "1003"; // 数据格式有误
    public static final String EC_NULL = null; // IO错误,连接超时
    private static final String url;
    private static final boolean debug;
    private static Resource r = new Resource("/tea/resource/Annuity");
    //
    private static SecretKey deskey;
    private static Cipher c1;
    static
    {
        Properties p = new Properties();
        try
        {
            InputStream is =Class.forName("tea.entity.admin.cebbank.Annuity").getResource("/tea/entity/admin/cebbank/cebbank.properties").openStream();
            p.load(is);
            is.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        url = p.getProperty("url");
        debug = "true".equals(p.getProperty("debug"));
        System.out.println(url + ":debug=" + debug);
        /////////加密////
        try
        {
            KeyGenerator keygen = KeyGenerator.getInstance("DES");
            deskey = keygen.generateKey();
            c1 = Cipher.getInstance("DES");
        } catch (GeneralSecurityException ex)
        {
            ex.printStackTrace();
        }
    }

    public static Map conn(Map m)
    {

        if (debug)
        {
            System.out.println("===请求=========" + m.get("trade_no") + "==" + m.get("code") + "==" + m.get("user") + "============");
            Iterator it = m.keySet().iterator();
            while (it.hasNext())
            {
                String name = (String) it.next();
                if (!"trade_no".equals(name) && !"code".equals(name) && !"user".equals(name))
                {
                    System.out.println(name + ":" + m.get(name));
                }
            }
        }
        m.put("channel_no", CHANNEL_NO); // 交易渠道号
        try
        {
            HttpURLConnection conn = (HttpURLConnection)new java.net.URL(url).openConnection();
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)");
            // jdk1.4没有些方法/////////////////
            // conn.setConnectTimeout(20000);
            // conn.setReadTimeout(30000);
            //写入 /////////////
            conn.setDoOutput(true);
            ObjectOutputStream oos = new ObjectOutputStream(conn.getOutputStream());
            oos.writeObject(m);
            oos.close();
            //读取 ////////////
            ObjectInputStream ois = new ObjectInputStream(conn.getInputStream());
            m = (Map) ois.readObject();
            ois.close();
			conn.disconnect();
        } catch (Exception ex)
        {
            ex.printStackTrace();
            m.put("error_code", null);
        }
        if (debug)
        {
            System.out.println("===返回=========" + m.get("trade_no") + "==" + m.get("code") + "==" + m.get("user") + "==" + m.get("error_code") + "============");
            Iterator it = m.keySet().iterator();
            while (it.hasNext())
            {
                String name = (String) it.next();
                if (!"trade_no".equals(name) && !"code".equals(name) && !"user".equals(name) && !"error_code".equals(name) && !"channel_no".equals(name))
                {
                    System.out.println(name + ":" + m.get(name));
                }
            }
        }
        return m;
    }

    // 企业查询计划
    public static String Annuity_0007(HttpSession session, String code, String dv) throws IOException
    {
        String html = (String) session.getAttribute("annuity.0007");
        if (html == null)
        {
            StringBuilder sb = new StringBuilder("<select class=biaodan name=plan_code ><option value=\"\" >-------------");
            Map m = new HashMap();
            m.put("trade_no", "0007");
            m.put("code", code);
            m.put("user", session.getAttribute("user"));
            m = (Map) Annuity.conn(m);
            String ec = (String) m.get("error_code");
            if (!Annuity.EC_0000.equals(ec))
            {
                return "<script>alert('" + r.getString(1, "Annuity.error_code." + ec) + "');</script>";
            }
            ArrayList al = (ArrayList) m.get("result");
            for (int i = 0; i < al.size(); i++)
            {
                Map v = (Map) al.get(i);
                String plan_code = (String) v.get("plan_code");
                String plan_name = (String) v.get("plan_name");
                sb.append("<option value=").append(plan_code).append(">").append(plan_name).append(" ( ").append(plan_code).append(" )");
            }
            sb.append("</select>");
            html = sb.toString();
            session.setAttribute("annuity.0007", html);
        }
        if (dv != null)
        {
            html = html + "<script>document.all('plan_code').value='" + dv + "';</script>";
        }
        return html;
    }

    // 集团企业组织结构
    public static String Annuity_0008(HttpSession session, String code, String user, String community, int language) throws IOException
    {
        String html = (String) session.getAttribute("annuity.0008");
        ArrayList cn = (ArrayList) session.getAttribute("annuity.corp_no"); //用于权限判断///
        if (html == null || cn == null)
        {
            String root = Annuity.des(code);
            StringBuilder js = new StringBuilder();
            js.append("<SCRIPT>var cn=document.getElementById('cn');");
            js.append("var url=location.href;");
            js.append("var tip='/").append(root).append("/");
            cn = new ArrayList();
            Map m = new HashMap();
            m.put("trade_no", "0008");
            m.put("code", code);
            m.put("user", user);
            m = (Map) Annuity.conn(m);
            String ec = (String) m.get("error_code");
            if (!Annuity.EC_0000.equals(ec))
            {
                return "<script>alert('" + r.getString(language, "Annuity.error_code." + ec) + "');</script>";
            }
            ArrayList al = (ArrayList) m.get("result");
            Hashtable ht = new Hashtable(); // key:父 content:子列表
            Hashtable ht2 = new Hashtable(); // key:id content:id对应的内容
            for (int i = 0; i < al.size(); i++)
            {
                Map v = (Map) al.get(i);
                String pk_parent = (String) v.get("parent_corp_no");
                if (pk_parent == null)
                {
                    pk_parent = "";
                }
                ArrayList al2 = (ArrayList) ht.get(pk_parent);
                if (al2 == null)
                {
                    al2 = new ArrayList();
                    ht.put(pk_parent, al2);
                }
                String corp_no = (String) v.get("corp_no");
                al2.add(corp_no);
                // //
                ht2.put(corp_no, v);

                String if_tip = (String) v.get("if_tip");
                if ("N".equals(if_tip))
                {
                    js.append(Annuity.des(corp_no)).append("/");
                }
                cn.add(corp_no); // 所管理的企业id放入会话/////
            }
            js.append("'; ");
            html = ("<SPAN ID=xial_cd><SELECT name=cn id=cn onchange='f_0008_submit(this)' ><option value=" + root + ">----------------------------------------") + (Annuity_0008_tree(ht, ht2, code, 0)) + ("</SELECT></SPAN>") + js.toString();
            session.setAttribute("annuity.0008", html);
            session.setAttribute("annuity.corp_no", cn);
        }
        String tn = Annuity.des("0009");
        String corp_no = (String) session.getAttribute("corp_no");
        if (corp_no != null)
        {
            html = html + "cn.value=\"" + Annuity.des(corp_no) + "\";";
        }
        html = html + "function f_0008_submit(obj)";
        html = html + "{";
        html = html + "  nu=url;";
        html = html + "  if(tip.indexOf('/'+obj.value+'/')!=-1)";
        html = html + "  {";
        //html = html + "    if(url.indexOf('" + tn + "')==-1)"; ///企业切到集团
        html = html + "      nu='/jsp/admin/cebbank/Annuity.jsp?community=" + community + "&tn=" + tn + "';";
        html = html + "  }else";
        html = html + "  {";
        html = html + "    if(url.indexOf('" + tn + "')!=-1)"; ///集团切到企业
        html = html + "      nu='/jsp/admin/cebbank/Annuity.jsp?community=" + community + "';";
        html = html + "  }";
        html = html + "  window.open('/servlet/EditAnnuity?tn={1}&cn='+obj.value+'&nexturl='+encodeURIComponent(nu),url!=nu?'_top':'_self');";
        html = html + "}";
        html = html + "</SCRIPT>";
        return html;
    }

    private static String Annuity_0008_tree(Hashtable ht, Hashtable ht2, String pk_parent, int step)
    {
        StringBuilder sb = new StringBuilder();
        ArrayList al = (ArrayList) ht.get(pk_parent);
        if (al != null)
        {
            for (int i = 0; i < al.size(); i++)
            {
                String corp_no = (String) al.get(i);
                Map v = (Map) ht2.get(corp_no);
                // String corp_no = (String) v.get("corp_no");
                String corp_name = (String) v.get("corp_name");
                String if_tip = (String) v.get("if_tip");
                sb.append("<option value=").append(Annuity.des(corp_no)).append(" >");
                for (int j = 1; j < step; j++)
                {
                    sb.append("　│　");
                }
                if (step > 0)
                {
                    // if (i == al.size() - 1)
                    // sb.append(" └─");
                    // else
                    sb.append("　├─");
                }
                sb.append(corp_name); //.append(" ( ").append(corp_no).append(" )");
                if ("N".equals(if_tip))
                {
                    sb.append(Annuity_0008_tree(ht, ht2, corp_no, step + 1));
                }
            }
        }
        return sb.toString();
    }

    // 集团汇总信息查询
    public static String Annuity_0009(HttpSession session, int language) throws IOException
    {
        String code = (String) session.getAttribute("code");
        String user = (String) session.getAttribute("user");
        String corp_no = (String) session.getAttribute("corp_no");
        StringBuilder sb = new StringBuilder();
        Map m = new HashMap();
        m.put("trade_no", "0009");
        m.put("code", code);
        m.put("user", user);
        Boolean if_tip = (Boolean) session.getAttribute("if_tip");
        if (if_tip != null && if_tip.booleanValue())
        {
            m.put("corp_no", corp_no);
        }
        m = (Map) Annuity.conn(m);
        String ec = (String) m.get("error_code");
        if (!Annuity.EC_0000.equals(ec))
        {
            return "<script>alert('" + r.getString(1, "Annuity.error_code." + ec) + "');</script>";
        }
        ////////
        if (corp_no == null)
        {
            corp_no = code;
        }
        int person_num = 0;
        BigDecimal assets = new BigDecimal("0.00");
        Object plan_num = null, fund_num = null, corp_name = null;
        ArrayList al = (ArrayList) m.get("result");
        //System.out.println("0009打印结果:" + al.toString());
        for (int i = 0; i < al.size(); i++)
        {
            Map v = (Map) al.get(i);

            Integer person_num_obj = (Integer) v.get("person_num");
            BigDecimal assets_obj = (BigDecimal) v.get("assets");
            if (corp_no.equals((String) v.get("corp_no"))) // 当前集团用户查看自已的
            {
                plan_num = v.get("plan_num");
                fund_num = v.get("fund_num");
                corp_name = v.get("corp_name");
            } else
            {
                person_num = person_num + person_num_obj.intValue(); // 人数
                assets = assets.add(assets_obj); // 资产总额
            }
        }
        sb.append(MessageFormat.format(r.getString(language, "1186563018015"), new Object[]
                                       {new Integer(al.size() - 1), new Integer(person_num), plan_num, fund_num, d(assets, "0.00")}));
        // sb.append("您旗下共有<b>").append(al.size() - 1).append("</b>家企业<b>").append(person_num).append("</b>人,");
        // sb.append("参加了<b>").append(plan_num).append("</b>个计划,");
        // sb.append("投资于<b>").append(fund_num).append("</b>个投资组合,");
        // sb.append("当前资产总额<b>").append(d(assets, "0.00")).append("</b>元.");
        sb.append("<script>document.getElementById('corp_name').innerHTML=\"").append(corp_name).append("\";</script>");
        return sb.toString();
    }

    /*
     * public static String Annuity_0009(String code, String user, String corp_no, boolean if_tip, int language) throws IOException { if ("".equals(corp_no)) { corp_no = null; } StringBuilder sb = new StringBuilder(); Map m = new HashMap(); m.put("trade_no", "0009"); m.put("code", code); m.put("user", user); m.put("corp_no", corp_no); m = (Map) Annuity.conn(m); // String ec = (String) m.get("error_code"); // System.out.println(ec); if (corp_no == null) { corp_no = code; } int person_num = 0;
     * BigDecimal assets = BigDecimal.ZERO; Object plan_num = null, fund_num = null, corp_name = null; ArrayList al = (ArrayList) m.get("result"); System.out.println("0009打印结果:" + al.toString()); for (int i = 0; i < al.size(); i++) { Map v = (Map) al.get(i); System.out.println("\r\n============" + i + "==========="); Iterator it = v.keySet().iterator(); while (it.hasNext()) { String name = (String) it.next(); Object value = v.get(name); System.out.print(name + "=" + value + ", "); } Integer
     * person_num_obj = (Integer) v.get("person_num"); BigDecimal assets_obj = (BigDecimal) v.get("assets"); if (corp_no.equals((String) v.get("corp_no"))) { if (if_tip)// 当前集团用户查看自已的 { plan_num = v.get("plan_num"); fund_num = v.get("fund_num"); corp_name = v.get("corp_name"); } else { sb.append(MessageFormat.format(r.getString(language, "1186562576562"), new Object[] { person_num_obj, v.get("plan_num"), v.get("fund_num"), d(assets_obj, "0.00") })); // sb.append("您企业共有员工<b>").append(person_num_obj).append("</b>人,"); //
     * sb.append("参加了<b>").append(v.get("plan_num")).append("</b>个计划,"); // sb.append("投资于<b>").append(v.get("fund_num")).append("</b>个投资组合,"); // sb.append("当前资产总额<b>").append(d(assets_obj, "0.00")).append("</b>元."); sb.append("<script>document.getElementById('corp_name').innerHTML=\"").append(v.get("corp_name")).append("\";</script>"); break; } } else { person_num = person_num + person_num_obj.intValue();// 人数 assets = assets.add(assets_obj);// 资产总额 } } if (if_tip)// 当前集团用户查看自已的 {
     * sb.append(MessageFormat.format(r.getString(language, "1186563018015"), new Object[] { al.size() - 1, person_num, plan_num, fund_num, d(assets, "0.00") })); // sb.append("您旗下共有<b>").append(al.size() - 1).append("</b>家企业<b>").append(person_num).append("</b>人,"); // sb.append("参加了<b>").append(plan_num).append("</b>个计划,"); // sb.append("投资于<b>").append(fund_num).append("</b>个投资组合,"); // sb.append("当前资产总额<b>").append(d(assets, "0.00")).append("</b>元."); sb.append("<script>document.getElementById('corp_name').innerHTML=\"").append(corp_name).append("\";</script>"); }
     * return sb.toString(); }
     */

    // 企业汇总信息查询
    public static String Annuity_0010(HttpSession session, int language) throws IOException
    {
        String code = (String) session.getAttribute("code");
        String user = (String) session.getAttribute("user");
        String corp_no = (String) session.getAttribute("corp_no");
        StringBuilder sb = new StringBuilder();
        Map m = new HashMap();
        m.put("trade_no", "0010");
        m.put("code", code);
        m.put("user", user);
        Boolean if_tip = (Boolean) session.getAttribute("if_tip");
        if (if_tip != null && if_tip.booleanValue())
        {
            m.put("corp_no", corp_no);
        }
        m = (Map) Annuity.conn(m);
        String ec = (String) m.get("error_code");
        if (!Annuity.EC_0000.equals(ec))
        {
            return "<script>alert('" + r.getString(1, "Annuity.error_code." + ec) + "');</script>";
        }
        ////////
        if (corp_no == null)
        {
            corp_no = code;
        }
        ArrayList al = (ArrayList) m.get("result");
        for (int i = 0; i < al.size(); i++)
        {
            Map v = (Map) al.get(i);
            Integer person_num_obj = (Integer) v.get("person_num");
            BigDecimal assets_obj = (BigDecimal) v.get("assets");
            if (corp_no.equals((String) v.get("corp_no")))
            {
                sb.append(MessageFormat.format(r.getString(language, "1186562576562"), new Object[]
                                               {person_num_obj, v.get("plan_num"), v.get("fund_num"), d(assets_obj, "0.00")}));

                // sb.append("您企业共有员工<b>").append(person_num_obj).append("</b>人,");
                // sb.append("参加了<b>").append(v.get("plan_num")).append("</b>个计划,");
                // sb.append("投资于<b>").append(v.get("fund_num")).append("</b>个投资组合,");
                // sb.append("当前资产总额<b>").append(d(assets_obj, "0.00")).append("</b>元.");
                sb.append("<script>document.getElementById('corp_name').innerHTML=\"").append(v.get("corp_name")).append("\";</script>");
                break;
            }
        }
        return sb.toString();
    }

    // 个人查询计划
    public static String Annuity_1007(HttpSession session, String dv) throws IOException
    {
        String html = (String) session.getAttribute("annuity.1007");
        if (html == null)
        {
            StringBuilder sb = new StringBuilder("<select class=biaodan name=plan_code ><option value=\"\" >-------------");
            Map m = new HashMap();
            m.put("trade_no", "1007");
            m.put("code", session.getAttribute("code"));
            m.put("pk_corporation", session.getAttribute("pk_corporation"));
            m = (Map) Annuity.conn(m);
            String ec = (String) m.get("error_code");
            if (!Annuity.EC_0000.equals(ec))
            {
                return "<script>alert('" + r.getString(1, "Annuity.error_code." + ec) + "');</script>";
            }
            ////////
            ArrayList al = (ArrayList) m.get("result");
            for (int i = 0; i < al.size(); i++)
            {
                Map v = (Map) al.get(i);
                String plan_code = (String) v.get("plan_code");
                String plan_name = (String) v.get("plan_name");
                sb.append("<option value=").append(plan_code).append(">").append(plan_name).append(" ( ").append(plan_code).append(" )");
            }
            sb.append("</select>");
            html = sb.toString();
            session.setAttribute("annuity.1007", html);
        }
        if (dv != null)
        {
            html = html + "<SCRIPT>document.all('plan_code').value='" + dv + "';</SCRIPT>";
        }
        return html;
    }

    // 汇总信息查询
    public static String Annuity_1008(HttpSession session, int language) throws IOException
    {
        String html = (String) session.getAttribute("annuity.1008");
        if (html == null)
        {
            StringBuilder sb = new StringBuilder();
            Map m = new HashMap();
            m.put("trade_no", "1008");
            m.put("code", session.getAttribute("code"));
            m.put("pk_corporation", session.getAttribute("pk_corporation"));
            m = (Map) Annuity.conn(m);
            String ec = (String) m.get("error_code");
            if (!Annuity.EC_0000.equals(ec))
            {
                return "<script>alert('" + r.getString(language, "Annuity.error_code." + ec) + "');</script>";
            }
            ArrayList al = (ArrayList) m.get("result");
            if (al != null && al.size() > 0)
            {
                Map v = (Map) al.get(0);

                sb.append(MessageFormat.format(r.getString(language, "1186563097453"), new Object[]
                                               {v.get("corp_num"), d(v.get("plan_num"), "0"), d(v.get("fund_num"), "0"), d(v.get("assets"), "0.00")}));
                // sb.append("您共参加了<b>").append(v.get("corp_num")).append("</b>家企业的");
                // sb.append("<b>").append(d(v.get("plan_num"), "0")).append("</b>个年金计划,");
                // sb.append("共投资于<b>").append(d(v.get("fund_num"), "0")).append("</b>个投资组合,");
                // sb.append("现有总资产<b>").append(d(v.get("assets"), "0.00")).append("</b>元.");
            }
            html = sb.toString();
            session.setAttribute("annuity.1008", html);
        }
        return html;
    }

    //企业列表信息查询
    public static String Annuity_1013(HttpSession session, String community, int language) throws IOException
    {
        String h = (String) session.getAttribute("annuity.1013");
        if (h == null)
        {
            Map m = new HashMap();
            m.put("trade_no", "1013");
            m.put("code", session.getAttribute("code"));
            m = (Map) Annuity.conn(m);
            String ec = (String) m.get("error_code");
            if (!Annuity.EC_0000.equals(ec))
            {
                return "<SCRIPT>alert('" + r.getString(language, "Annuity.error_code." + ec) + "');</SCRIPT>";
            }
            ArrayList al = (ArrayList) m.get("result");
            StringBuilder sb = new StringBuilder();
            sb.append("<SPAN ID=xial_cd><SELECT NAME=pkc onchange='f_1013_submit(this)'");
            if (al.size() == 1)
            {
                sb.append(" STYLE=display:none");
            }
            sb.append("><option value=").append(Annuity.des("")).append(">----------------------------------------");
            for (int i = 0; i < al.size(); i++)
            {
                Map v = (Map) al.get(i);
                String pk_c = Annuity.des((String) v.get("pk_corporation"));
                String name = (String) v.get("name");
                sb.append("<OPTION VALUE=").append(pk_c).append(">").append(name);
            }
            sb.append("</SELECT></SPAN>");
            h = sb.toString();
            session.setAttribute("annuity.1013", h);
        }
        h = h + "<SCRIPT>";
        String tn = Annuity.des("1013");
        String pk_corporation = (String) session.getAttribute("pk_corporation");
        if (pk_corporation != null)
        {
            h = h + "document.all('pkc').value='" + Annuity.des(pk_corporation) + "';";
        }
        h = h + "var url=location.href;";
        h = h + "function f_1013_submit(obj)";
        h = h + "{";
        h = h + "  var nu=url;";
        h = h + "  if(obj.selectedIndex==0)";
        h = h + "  {";
        h = h + "    nu='/jsp/admin/cebbank/Annuity.jsp?community=" + community + "&tn=" + tn + "';";
        h = h + "  }else";
        h = h + "  {";
        h = h + "    if(url.indexOf('" + tn + "')!=-1)"; ///企业列表 切到 信息页
        h = h + "      nu='/jsp/admin/cebbank/Annuity.jsp?community=" + community + "';";
        h = h + "  }";
        h = h + "  window.open('/servlet/EditAnnuity?tn={1}&pkc='+obj.value+'&nexturl='+encodeURIComponent(nu),url!=nu?'_top':'_self');";
        h = h + "}";
        h = h + "</SCRIPT>";
        return h;
    }

    // 业务类型
    public static String Annuity_GT(String dv) throws IOException
    {
        StringBuilder sb = new StringBuilder("<select class=biaodan name=trade_type ><option value=\"\" >-----------");
        String gt[][] =
                {
                {"T00001", "缴费"},
                {"T00003", "收益"},
                {"T00004", "归属"},
                {"T00006", "支付"},
                {"T00008", "转入"},
                {"T00009", "转出"},
                {"T00011", "调增"},
                {"T00012", "调减"},
                {"T00014", "课税"}
        };
        for (int i = 0; i < gt.length; i++)
        {
            sb.append("<option value=").append(gt[i][0]);
            if (gt[i][0].equals(dv))
            {
                sb.append(" SELECTED ");
            }
            sb.append(">").append(gt[i][1]);
        }
        sb.append("</select>");
        return sb.toString();
    }

    public static String d(Object obj)
    {
        return d(obj, "");
    }

    public static String d(Object obj, String dv)
    {
        if (obj == null)
        {
            return dv;
        }
        String str = obj.toString();
        if (obj instanceof BigDecimal)
        {
            BigDecimal bd = (BigDecimal) obj;
            if (bd.scale() < 3)
            {
                str = df.format(obj);
            }
        }
        return str;
    }

    public static String des(String str)
    {
        try
        {
            if (str.startsWith("{") && str.endsWith("}"))
            {
                if (str.length() < 8)
                {
                    return str;
                } else
                if ("{A386A0A97313365F}".equals(str))
                {
                    return "8001";
                } else if ("{FB19458DB9E320FB}".equals(str))
                {
                    return "8002";
                }
                String s[] = str.split("\\|");
                byte by[] = new byte[s.length - 2];
                for (int i = 0; i < by.length; i++)
                {
                    by[i] = Byte.parseByte(s[i + 1]);
                }
                c1.init(Cipher.DECRYPT_MODE, deskey);
                by = c1.doFinal(by);
                str = new String(by);
            } else
            {
                if ("8001".equals(str))
                {
                    return "{A386A0A97313365F}";
                } else if ("8002".equals(str))
                {
                    return "{FB19458DB9E320FB}";
                }
                c1.init(Cipher.ENCRYPT_MODE, deskey);
                byte by[] = c1.doFinal(str.getBytes());
                str = "|";
                for (int i = 0; i < by.length; i++)
                {
//                    String tmp = (Integer.toHexString(by[i] & 0XFF));
//                    if (tmp.length() == 1)
//                    {
//                        tmp = "0" + tmp;
//                    }
                    str = str + by[i] + "|";
                }
                str = "{" + str + "}";
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        return str;
    }

//    // 编码-解码////////
//    public static final String d[] =
//            {"0001", "0002", "0003", "0004", "0005", "0006", "0009", "0011", "0012", "0013", "1001", "1002", "1003", "1004", "1005", "1006", "1008", "1009", "1010", "1011", "1013", "4001", "4003", "5001", "5003", "5005", "8003", "8004"};
//    public static final String e[] =
//            {"060151F4-3ECB-489C-B555-F743E0592F9A", "53E3CF0A-E1BE-4EF1-9D0D-BD700DB61422", "C7ED325F-9518-42C4-8057-97095D75A021", "3CD510A4-68F1-4B94-9013-0C6C400EE4B9", "8683D7C6-10D5-41A5-BB1F-F1E0DE5F2B11", "0BC10151-34C8-4F33-8C32-F40C631060C0", "3E6854D4-776B-46BE-8B1F-358A5972F1C0", "25B8FA46-4F4D-4BC8-A3F8-3959A89D2EE5", "C9EC4AF4-B1AC-41E4-9853-3FE9703F3E89", "772950D8-0B15-453D-93F2-C384E239DAA7", //////////0
//            "74DD3158-3FF3-4225-8553-8BCF5244E56F", "A5255057-1FAA-4B1F-A707-0F0DEDA2ED39", "36C2772C-37A3-4F6E-B5D6-A11A3E4B8F67", "B38049E5-4DEA-4099-BBF4-C178FA8426D4", "608A9DF2-904F-439D-8D32-5FE4A6B6B6F4", "D55062C1-EE14-45F9-8F1F-B6E33C2DDEBA", "04238A3B-299F-4273-AEAD-7531E484A989", "880589B8-9C4E-46C9-9D96-62AA4091D87F", "1097CB08-2A17-4EA4-A239-0DB247C7A2DB", "D46B3BBB-BAE2-4153-A87F-17D1CA2CDC23", "8FF75E61-CA3C-4998-AE1D-295AC68C5A3D", /////////1
//            "75E121CD-51E7-47DD-AB39-153B7FEE786E", "C2E70D4C-FE4D-4E20-8622-56E39F3A24CB", //////4
//            "BC2C7094-1B23-444F-B9E2-8C28C8D44DBD", "DCD8343C-0EF3-47DC-A712-045C266A8A29", "77AA041D-863B-410F-BA6F-2C9AEA057BA9", //////////5
//            "76F39064-94A9-49E4-9AFE-94B6E0891CA7", "1A842186-0797-47F5-AFF7-45040516DE1A", //////////////////8
//            "E3F33C43-A056-4FDE-9D12-84B303DBEDBF", "5EE916E3-E937-4425-9B40-6E79BBCA2F5B", "06C6C075-29DE-416F-855F-E323BAF2F51D", "39469189-C93F-4EC2-9495-DC4CCD4908F7", "735A1DFF-E237-414E-A8E5-14366A4E87C0", "FBFE8990-827F-4AA2-BC7B-CA00E7B7C2B4", "C03A57A6-5D6B-42C0-8CFA-048E6EB18638", "C14972F1-C2E4-4E65-B007-49E8B48A051C", "80E77F89-F0C5-4F04-A13B-8F29D567833E", "394AC951-6662-49B6-B689-67A4841EF350"};
//
//    public static String encode(String str)
//    {
//        for (int i = 0; i < d.length && i < e.length; i++)
//        {
//            if (d[i].equals(str))
//            {
//                str = e[i];
//                break;
//            }
//        }
//        return str;
//    }
//
//    public static String decode(String str)
//    {
//        for (int i = 0; i < d.length && i < e.length; i++)
//        {
//            if (e[i].equals(str))
//            {
//                str = d[i];
//                break;
//            }
//        }
//        return str;
//    }
}
//网关: 10.1.18.254
//00000003/csqy2/1
//1199360701/289214

