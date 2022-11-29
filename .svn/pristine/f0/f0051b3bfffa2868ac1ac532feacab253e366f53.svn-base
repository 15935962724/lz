package tea.entity.locoso;

import javax.imageio.*;
import java.util.regex.*;
import java.sql.*;
import java.net.*;
import java.io.*;
import tea.db.*;
import java.util.*;
import tea.entity.util.*;
import tea.entity.node.Node;

public class Locoso extends Thread
{
    public static final String CAT[][][] =
            {
            {
            {"030000000000", "旅游 餐饮 娱乐 休闲 购物"},
            {"030400000000", "浴场", "2199062"},
            {"030300000000", "休闲娱乐", "800500"},
            {"030100000000", "旅游、宾馆", "700100"},
            {"030200000000", "餐饮", "700200"},
            {"030500000000", "体育、休闲运动", "800400"},
            {"030600000000", "宠物、花鸟", "2199085"},
            {"030700000000", "文化艺术", "800300"},
            {"030800000000", "购物", "2199063"},
            {"030900000000", "体育、文娱用品", "301200"},
            {"030A00000000", "酒店、厨房设备用品", "100200"}
    },
            {
            {"0I0000000000", "机械设备、通用零部件"},
            {"0I0500000000", "锅炉", "2199064"},
            {"0I0100000000", "机床", "2199066"},
            {"0I0200000000", "机械机器设备", "302200"},
            {"0I0300000000", "通用机械设备", "302300"},
            {"0I0400000000", "专用机械设备", "302400"},
            {"0I0600000000", "泵业", "150200"},
            {"0I0700000000", "动力、节能设备", "2199067"},
            {"0I0800000000", "热力工程设备", "130100"},
            {"0I0900000000", "机电设备", "302600"},
            {"0I0A00000000", "通用零部件业", "2199068"},
            {"0I0B00000000", "非标设备及零部件", "2199069"}
    },
            {
            {"040000000000", "日常服务"},
            {"040100000000", "监督、投诉及热线电话", "2199074"},
            {"040200000000", "水、电、煤", "2199075"},
            {"040300000000", "日常服务", "170000"},
            {"040400000000", "美发美容、浴室", "2199076"},
            {"040500000000", "商务、清洗服务", "2199077"},
            {"040600000000", "家政家教、老年服务", "2199078"},
            {"040700000000", "闲置物品调剂回收", "2199079"}
    },
            {
            {"0E0000000000", "纺织 皮革 服装 鞋帽"},
            {"0E0100000000", "纺织印染", "300500"},
            {"0E0200000000", "皮革、毛皮、羽绒制品", "300700"},
            {"0E0300000000", "服装", "300600"},
            {"0E0400000000", "鞋帽", "300600"}
    },
            {
            {"050000000000", "家具 生活用品 食品"},
            {"050500000000", "照相、摄像器材", "302700"},
            {"050900000000", "净水及设备", "130300"},
            {"050100000000", "家具 木制品 居家饰品", "300900"},
            {"050200000000", "日用品、日用杂品", "302900"},
            {"050300000000", "日用化工", "302900"},
            {"050400000000", "日用电器", "302900"},
            {"050600000000", "自行车、缝纫机", "302600"},
            {"050700000000", "食品、烟、酒", "300200"},
            {"050800000000", "副食品、粮油", "300100"}
    },
            {
            {"0A0000000000", "通信 邮政 计算机 网络"},
            {"0A0100000000", "通信", "400100"},
            {"0A0200000000", "邮政", "400100"},
            {"0A0300000000", "通讯设备", "400200"},
            {"0A0400000000", "电子计算机", "400200"},
            {"0A0500000000", "互联网信息及技术服务", "400300"}
    },
            {
            {"070000000000", "医疗保健 社会福利"},
            {"070500000000", "福利", "110300"},
            {"070600000000", "殡葬业", "2199080"},
            {"070100000000", "医疗卫生事业", "110200"},
            {"070200000000", "医药", "110100"},
            {"070300000000", "保健品", "110100"},
            {"070400000000", "卫生、医疗及康复器材", "301500"}
    },
            {
            {"0H0000000000", "电子电器 仪器仪表"},
            {"0H0500000000", "电池、充电器", "302700"},
            {"0H0600000000", "广播、影视、音响设备及器材", "302600"},
            {"0H0700000000", "防静电、防雷、防爆及弱电工程及设备", "302900"},
            {"0H0A00000000", "衡量器", "302900"},
            {"0H0100000000", "电器设备", "302600"},
            {"0H0200000000", "电子设备、材料及器件", "302600"},
            {"0H0300000000", "电工器材", "302900"},
            {"0H0400000000", "照明器具", "302900"},
            {"0H0800000000", "自动化设备", "302900"},
            {"0H0900000000", "仪器仪表", "302900"}
    },
            {
            {"080000000000", "金融 保险 证券 投资"},
            {"080200000000", "保险", "200300"},
            {"080300000000", "证券期货", "200200"},
            {"080500000000", "开发区", "200400"},
            {"080100000000", "金融", "200100"},
            {"080400000000", "金融投资", "200100"},
            {"080600000000", "外事服务、国际劳务", "200400"},
            {"080700000000", "商(企)业驻在机构", "200400"}
    },
            {
            {"0B0000000000", "交通物流 运输设备"},
            {"0B0100000000", "城市公共交通", "120300"},
            {"0B0200000000", "交通运输", "120900"},
            {"0B0300000000", "物流业", "120700"},
            {"0B0400000000", "交通运输设备", "302500"},
            {"0B0500000000", "航天航空", "120500"}
    },
            {
            {"0C0000000000", "城建 房产 建材 装潢"},
            {"0C0100000000", "城市建设", "190300"},
            {"0C0200000000", "环境保护", "190200"},
            {"0C0300000000", "房地产业", "500000"},
            {"0C0400000000", "建筑、安装、装潢业", "600300"},
            {"0C0500000000", "建筑材料业", "600100"},
            {"0C0600000000", "木材", "300800"}
    },
            {
            {"0G0000000000", "石油化工 橡胶塑料"},
            {"0G0100000000", "石油、石油化工", "150200"},
            {"0G0200000000", "能源", "150100"},
            {"0G0700000000", "化肥农药", "301500"},
            {"0G0800000000", "火工产品", "301300"},
            {"0G0300000000", "橡胶、橡塑制品", "301700"},
            {"0G0400000000", "塑料(塑胶)及其制品", "301800"},
            {"0G0500000000", "化工原料及产品", "301600"},
            {"0G0600000000", "涂料、油墨、颜料、染料", "2199086"},
            {"0G0900000000", "林产化工", "150500"}
    },
            {
            {"060000000000", "钟表眼镜 工艺品 礼品"},
            {"060400000000", "古董、收藏品", "303000"},
            {"060500000000", "金银珠宝、饰品", "303000"},
            {"060600000000", "气球、贺卡、日历", "303000"},
            {"060100000000", "钟表、眼镜", "303000"},
            {"060200000000", "工艺品", "303000"},
            {"060300000000", "礼品", "303000"},
            {"060700000000", "旗篷、镜框", "303000"}
    },
            {
            {"0F0000000000", "造纸 纸品 印刷 包装"},
            {"0F0100000000", "造纸、纸张", "301000"},
            {"0F0200000000", "纸品", "301000"},
            {"0F0300000000", "印刷、制版、装订", "301100"},
            {"0F0400000000", "印刷用品及器材", "301100"},
            {"0F0500000000", "包装", "301100"}
    },
            {
            {"020000000000", "新闻 出版 科研 教育"},
            {"020100000000", "新闻出版", "800100"},
            {"020200000000", "广播影视", "800200"},
            {"020300000000", "音像制品、图书销售", "800300"},
            {"020400000000", "科研设计 气象地质 技术监测", "180100"},
            {"020500000000", "高新技术", "180200"},
            {"020600000000", "教育事业", "900000"}
    },
            {
            {"0K0000000000", "农林牧渔"},
            {"0K0100000000", "农业及服务", "140100"},
            {"0K0200000000", "林业及服务", "140200"},
            {"0K0300000000", "畜牧业及服务", "140300"},
            {"0K0400000000", "渔业及服务", "140400"},
            {"0K0500000000", "兽医兽药、饲料", "301500"},
            {"0K0600000000", "水利", "190100"}
    },
            {
            {"090000000000", "广告 会展 商务办公 咨询业"},
            {"090200000000", "会展", "2199081"},
            {"090300000000", "公关礼仪、企业形象设计", "2199082"},
            {"090900000000", "文教办公用品", "301200"},
            {"090100000000", "广告", "2199083"},
            {"090400000000", "商务服务", "160200"},
            {"090500000000", "咨询和调查", "2199084"},
            {"090600000000", "租赁", "160100"},
            {"090700000000", "广告会展材料及用品", "300900"},
            {"090800000000", "商务、办公设备", "160200"}
    },
            {
            {"0J0000000000", "冶金冶炼 金属及非金属制品"},
            {"0J0100000000", "国土资源管理、矿藏采选", "150600"},
            {"0J0200000000", "冶金冶炼业", "302200"},
            {"0J0300000000", "金属制成品", "302200"},
            {"0J0400000000", "表面处理、标(表)、招牌", "301100"},
            {"0J0500000000", "工具、模具磨料", "302400"},
            {"0J0600000000", "非金属矿物制品", "301900"}
    },
            {
            {"0D0000000000", "贸易 批发 市场"},
            {"0D0400000000", "市场", "100200"},
            {"0D0100000000", "贸易", "100200"},
            {"0D0200000000", "批发业", "100100"},
            {"0D0300000000", "物资供销", "2199063"}
    },
            {
            {"010000000000", "党政机关 社会团体"},
            {"010700000000", "使(领)馆、国际组织、代表处", "220000"},
            {"010100000000", "中国共产党", "210200"},
            {"010200000000", "人大常委会", "210200"},
            {"010300000000", "人民政府及其管理机构", "210200"},
            {"010400000000", "政协、民主党派", "210300"},
            {"010500000000", "社会和宗教团体", "210400"},
            {"010600000000", "基层群众自治组织", "210500"}
    }
    };
    public static final Pattern PP = Pattern.compile("共<font color=\"#FF0000\">([\\d]+)</font>页");
    public static final int ON = 4;
    public static int thread;
    String cat;
    int city;
    public Locoso(String cat, int city)
    {
        this.cat = cat;
        this.city = city;
    }

    public void run()
    {
        System.out.println("开始:" + cat + "/" + city);
        try
        {
            int page = -1;
            for (int index = 1; index < page || page == -1; index++)
            {
                try
                {
                    String url = "http://www.locoso.com/" + index + "_" + city + "00/_" + cat + "/";
                    boolean exists = Category.find(url).isExists();
                    if (!exists || page == -1)
                    {
                        System.out.println("线程:" + this.getId() + ":" + url);
                        String str = open(url);
                        if (page == -1)
                        {
                            Matcher m = PP.matcher(str);
                            if (m.find())
                            {
                                page = Integer.parseInt(m.group(1));
                            }
                        }
                        if (!exists)
                        {
                            Category.create(url, null);
                            String cs[] = str.split(". </font><a href=\"");
                            for (int detail = 1; detail < cs.length; detail++)
                            {
                                url = "http://www.locoso.com" + cs[detail].substring(0, cs[detail].indexOf("\""));
                                String h = open(url);
                                h = h.replaceAll("(<font color=#000000>)|(</font>)", "");
                                int i = h.indexOf("公司名称");
                                i = h.indexOf("<td>", i) + 4;
                                int j = h.indexOf("<", i);
                                String name = h.substring(i, j).trim();
                                //System.out.println(name);
                                //
                                i = h.indexOf("地　址", j);
                                i = h.indexOf("<td>", i) + 4;
                                j = h.indexOf("<", i);
                                String address = h.substring(i, j).trim();
                                //
                                i = h.indexOf("邮　编", j);
                                i = h.indexOf("<td>", i) + 4;
                                j = h.indexOf("<", i);
                                String zip = h.substring(i, j).trim();
                                //
                                i = h.indexOf("电　话", j);
                                i = h.indexOf("src=\"/jsp/tel", i) + 5;
                                String tel = null;
                                if (i > 10)
                                {
                                    j = h.indexOf("\"", i);
                                    tel = h.substring(i, j).trim();
                                    try
                                    {
                                        File f = open2("http://www.locoso.com" + tel);
                                       // tel = com.ocr.Ocr.cmp2(ImageIO.read(f));
                                        f.delete();
                                    } catch (IOException ex)
                                    {
                                    }
                                }
                                //
                                i = h.indexOf("邮　箱", i);
                                j = h.indexOf("mailto:", i) + 7;
                                String email = null;
                                if (j > 10 && j < i + 100)
                                {
                                    int x = h.indexOf("\"", j);
                                    email = h.substring(j, x);
                                }
                                //
                                i = h.indexOf("网　址", i);
                                j = h.indexOf("<a href=\"http://", i) + 9;
                                String url2 = null;
                                if (j > 10 && j < i + 100)
                                {
                                    int x = h.indexOf("\"", j);
                                    url2 = h.substring(j, x);
                                }
                                //
                                i = h.indexOf("企业简介");
                                String intr = null;
                                if (i != -1)
                                {
                                    i = h.indexOf("cols=34>", i) + 8;
                                    j = h.indexOf("</textarea>", i);
                                    intr = h.substring(i, j);
                                }
                                //
                                i = h.indexOf(">经营范围：</");
                                String business = null;
                                if (i != -1)
                                {
                                    i = h.indexOf("cols=34>", i) + 8;
                                    j = h.indexOf("</textarea>", i);
                                    business = h.substring(i, j);
                                }
                                //
                                i = h.indexOf("企业动态");
                                if (i != -1)
                                {
                                    i = h.indexOf("cols=34>", i) + 8;
                                    j = h.indexOf("</textarea>", i);
                                    intr = h.substring(i, j);
                                }
                                //
                                i = h.indexOf("企业个性信息");
                                i = h.indexOf("<td>", i) + 4;
                                j = h.indexOf("<td>", i);
                                String info = h.substring(i, j);
                                //
                                i = h.indexOf("企业详细信息", j);
                                i = h.indexOf("<td>", i) + 4;
                                j = h.indexOf("</td>", i);
                                String content = h.substring(i, j);
                                content = content.replaceFirst("<a href=\"/DoLogin.do\">点击添加企业详细信息</a>", "");
                                //
                                String map = null;
                                i = h.indexOf("/map/maplet.jsp?x=", j) + 18;
                                if (i > 100)
                                {
                                    j = h.indexOf("&w", i);
                                    map = h.substring(i, j);
                                }
                                try
                                {
                                    Company.create(url, city, cat, name, address, zip, tel, email, url2, intr, business, info, content, map);
                                } catch (SQLException ex1)
                                {
                                }
                            }
                        }
                    }
                } catch (Exception ex)
                {
                    ex.printStackTrace();
                    Thread.sleep(1000 * 60 * 10);
                }
            }
            FileWriter fw = new FileWriter("e:/" + city + ".txt", true);
            fw.write(cat + ",");
            fw.close();
            thread--;
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public static File open2(String url) throws IOException
    {
        URL u = new URL(url);
        HttpURLConnection conn = (HttpURLConnection) u.openConnection();
        conn.setRequestProperty("accept", "*/*");
        conn.setRequestProperty("referer", url);
        conn.setRequestProperty("accept-language", "zh-cn");
        conn.setRequestProperty("ua-cpu", "x86");
        //conn.setRequestProperty("accept-encoding", "gzip, deflate");
        conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322)");
        conn.setRequestProperty("host", u.getHost());
        conn.setRequestProperty("connection", "Keep-Alive");
        File f = File.createTempFile("ocr", ".bmp");
        FileOutputStream fos = new FileOutputStream(f);
        InputStream is = conn.getInputStream();
        int v = 0;
        while ((v = is.read()) != -1)
        {
            fos.write(v);
        }
        is.close();
        fos.close();
        return f;
    }

    public static String open(String url) throws IOException
    {
        HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
        conn.setRequestProperty("host", "www.locoso.com");
        conn.setRequestProperty("user-agent", "Mozilla/5.0 (Windows; U; Windows NT 5.2; zh-CN; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1");
        conn.setRequestProperty("accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        conn.setRequestProperty("accept-language", "zh-cn,zh;q=0.5");
        //conn.setRequestProperty("accept-encoding", "gzip,deflate");
        conn.setRequestProperty("accept-charset", "gb2312,utf-8;q=0.7,*;q=0.7");
        conn.setRequestProperty("keep-alive", "300");
        conn.setRequestProperty("connection", "keep-alive");

        byte by[] = new byte[1024 * 8];
        StringBuilder sb = new StringBuilder();
        int i = 0;
        InputStream is = conn.getInputStream();
        while ((i = is.read(by)) != -1)
        {
            String str = new String(by, 0, i, "UTF-8");
            sb.append(str);
        }
        is.close();
        return sb.toString();
    }

    public static int t;
    public static void ocr() throws Exception
    {
        while (true)
        {
            Enumeration e = Company.find(" AND tel LIKE '/jsp/%'", 0, 500);
            if (!e.hasMoreElements())
            {
                return;
            } while (e.hasMoreElements())
            {
                final Company obj = (Company) e.nextElement();
                final String tel = obj.getTel();
                while (t > 15)
                {
                    Thread.sleep(1000L);
                }
                t++;
                new Thread()
                {
                    public void run()
                    {
                        try
                        {
                            File f = open2("http://www.locoso.com" + tel);
                            String v = "";//com.ocr.Ocr.cmp2(ImageIO.read(f));
                            System.out.println(obj.getName() + ":" + v);
                            obj.setTel(v);
                            f.delete();
                        } catch (Exception ex)
                        {
                            ex.printStackTrace();
                        }
                        t--;
                    }
                }.start();
            }
        }
    }

    public static final tea.entity.RV rv = new tea.entity.RV("webmaster");
    public static final java.util.Date time = new java.util.Date();
    public static void exp(Company obj) throws SQLException
    {
        String name = obj.getName();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM NodeLayer WHERE subject=" + DbAdapter.cite(name));
            if (db.next())
            {
                return;
            }
        } finally
        {
            db.close();
        }
        int city = obj.getCity();
        if (city > 9999)
        {
            city = Integer.parseInt(String.valueOf(city).substring(0, 4));
        }
        String str = obj.getCategory();
        for (int i = 0; i < CAT.length; i++)
        {
            for (int j = 1; j < CAT[i].length; j++)
            {
                if (str.equals(CAT[i][j][0]))
                {
                    str = CAT[i][j][2];
                    break;
                }
            }
        }
        int father = Integer.parseInt(str);
        System.out.println("分类:" + father + " 名称:" + name);
        int newid = 0;//Node.create(father, 0, "lib", rv, 21, false, 1308622912L, 0, 1, null, null, time, 0, 0, 0, 0, null, null, 1, name, name, obj.getIntr() + "<br/>" + obj.getInfo() + "<br/>" + obj.getContent(), null, null, 0, null, null, null, null, null, null, null);
        tea.entity.node.Company c = tea.entity.node.Company.find(newid);
        c.set(1, "", obj.getEmail(), "", obj.getAddress(), city, null, obj.getZip(), "", obj.getTel(), "", obj.getUrl(), obj.getMap(), "");
        c.setProduct(obj.getBusiness(), 1);
        obj.delete();
    }

    public static void main(String args[]) throws Exception
    {
        int a = Integer.parseInt(args[0]);
        switch (a)
        {
        case 0:
        {
            ArrayList al = Card.find(" AND card>999 AND card<10000 AND card NOT IN (1101,1201,3101,5001)", 0, Integer.MAX_VALUE);
            for(int x=0;x<al.size();x++)
            {
				Card c = (Card)al.get(x);
                String str = null;
                File f = new File("e:/" + c.getCard() + ".txt");
                if (f.exists())
                {
                    char ch[] = new char[(int) f.length()];
                    FileReader fr = new FileReader(f);
                    fr.read(ch);
                    fr.close();
                    str = new String(ch);
                }
                for (int i = 0; i < CAT.length; i++) //
                {
                    for (int j = 1; j < CAT[i].length; j++)
                    {
                        if (str == null || str.indexOf(CAT[i][j][0]) == -1)
                        {
                            while (thread > 20)
                            {
                                Thread.sleep(1000L);
                            }
                            thread++;
                            new Locoso(CAT[i][j][0], c.getCard()).start();
                            Thread.sleep(1000 * 60);
                        }
                    }
                }
            }
        }
        break;
        case 1:
            Enumeration e = Company.find("", 0, 100);
            while (e.hasMoreElements())
            {
                Company obj = (Company) e.nextElement();
                exp(obj);
                obj.delete();
            }
            break;
        case 2:
            ocr();
            break;
        }
    }
}
