package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.util.Date;
import java.sql.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.util.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.poi.ss.util.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.*;
import net.mietian.convert.*;

public class LmsExports extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,$$=parent.$$;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String str = "/res/" + h.community + "/tmp/" + act + "_" + Math.random() + ".xlsx";
            if("photo".equals(act))
            {
                ArrayList al = new ArrayList();
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT pl.photopath FROM Profile p INNER JOIN ProfileLayer pl ON pl.profile=p.profile WHERE pl.photopath IS NOT NULL" + h.key);
                    while(db.next())
                    {
                        File f = new File(Http.REAL_PATH + db.getString(1));
                        if(f.isFile())
                            al.add(f);
                    }
                } finally
                {
                    db.close();
                }
                File[] fs = new File[al.size()];
                al.toArray(fs);
                Zip z = new Zip(new File(application.getRealPath(str)));
                z.zip(fs,out);
            } else
            {
                Workbook wb = new SXSSFWorkbook(1000);
                CellStyle HE = wb.createCellStyle(); //1
                HE.setAlignment(CellStyle.ALIGN_CENTER);
                CellStyle TH = wb.createCellStyle(); //2
                TH.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                TH.setBorderBottom(CellStyle.BORDER_THIN);
                TH.setBorderRight(CellStyle.BORDER_THIN);
                TH.setBorderLeft(CellStyle.BORDER_THIN);
                TH.setBorderTop(CellStyle.BORDER_THIN);
                Font font = wb.createFont();
                font.setBoldweight((short) 700);
                TH.setFont(font);
                CellStyle TD = wb.createCellStyle(); //3
                TD.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                TD.setBorderBottom(CellStyle.BORDER_THIN);
                TD.setBorderRight(CellStyle.BORDER_THIN);
                TD.setBorderLeft(CellStyle.BORDER_THIN);
                TD.setBorderTop(CellStyle.BORDER_THIN);
                TD.setDataFormat((short) 22);
                getClass().getMethod(act,Class.forName("tea.entity.Http"),Class.forName("org.apache.poi.ss.usermodel.Workbook")).invoke(this,h,wb);

                //response.setHeader("Cache-Control","private");
                //response.setHeader("Content-Disposition","attachment; filename=\"" + new String(request.getQueryString().getBytes("GBK"),"ISO-8859-1") + "\"");
                File f = new File(application.getRealPath(str));
                f.getParentFile().mkdirs();
                FileOutputStream fos = new FileOutputStream(f);
                wb.write(fos);
                fos.close();
            }
            out.print("<script>location.replace('/Utils.do?act=down&url=" + str + "&name=" + Http.enc(h.get("name")) + "');mt.close();</script>");
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            out.print("<textarea id='ta'>" + ex.getCause().toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
        } finally
        {
            out.close();
        }
    }

    public void lmsorg(Http h,Workbook wb) throws SQLException
    {
        CellStyle TH = wb.getCellStyleAt((short) 2),TD = wb.getCellStyleAt((short) 3);
        Sheet ws = wb.createSheet();
        ws.setDefaultRowHeight((short) 500); //默认:300
        ws.setDefaultColumnWidth(16); //默认:8,无效
        //ws.setDefaultColumnStyle(1,td); //只对空白数据有效
        Row wr = ws.createRow(0);
        String[] title =
                {"机构名称","机构编号","状态"};
        for(int j = 0;j < title.length;j++)
        {
            Cell wd = wr.createCell(j);
            wd.setCellValue(title[j]);
            wd.setCellStyle(TH);
        }

        ws.createFreezePane(1,1);
        ArrayList al = LmsOrg.find(h.key,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsOrg t = (LmsOrg) al.get(i);
            wr = ws.createRow(i + 1);
            String[] value =
                    {t.orgname,t.orgno,LmsOrg.STATE_TYPE[t.state]};
            for(int j = 0;j < value.length;j++)
            {
                Cell wd = wr.createCell(j);
                if(value[j] != null)
                    wd.setCellValue(value[j]);
                wd.setCellStyle(TD);
            }
        }
        width(ws,0,title.length);
    }

    public void member(Http h,Workbook wb) throws Exception
    {
        PrintWriter out = h.response.getWriter();
        CellStyle TH = wb.getCellStyleAt((short) 2),TD = wb.getCellStyleAt((short) 3);
        Sheet ws = wb.createSheet();
        ws.setDefaultRowHeight((short) 500);
        ws.setDefaultColumnWidth(16);
        Row wr = ws.createRow(0);
        String[] title =
                {"姓名","学号","密码","性别","出生日期","民族","政治面貌","籍贯","证件类型","证件号码","户籍","报名所在省","报名所在市","职业","单位性质","证书级别","证书方向","学历"
                ,"是否在读","现阶段所在班级","毕业院校","毕业专业","毕业时间","工作单位","移动电话","通讯地址","固定电话","邮编","电子邮箱"
                ,"报名日期","入学日期　","学员状态","电子照片","省助学发展机构","学习服务中心名称","学习服务中心编号"};
        for(int j = 0;j < title.length;j++)
        {
            Cell wd = wr.createCell(j);
            wd.setCellValue(title[j]);
            wd.setCellStyle(TH);
        }
        ws.createFreezePane(2,1);
        ArrayList al = Profile.find1(h.key,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            Profile p = (Profile) al.get(i);
            LmsOrg lo = LmsOrg.find(p.getAgent());
            //
            int province = p.getProvince(h.language);
            int city = province < 10 ? 0 : Integer.parseInt(String.valueOf(province).substring(0,2));
            boolean flag = (city == 11 || city == 12 || city == 31 || city == 50); //直辖市，忽略二级
            String photo = p.getPhotopath(h.language);
            String[] VALUE =
                    {p.getName(h.language) //姓名
                    ,p.getMember() //学号
                    ,p.getPassword() //密码
                    ,p.sex ? "男" : "女" //性别
                    ,MT.f(p.birth) //出生日期
                    ,p.zzracky //民族
                    ,Lms.POLITY_TYPE[p.polity] //政治面貌
                    ,Card.find(p.jcity).address //籍贯
                    ,Lms.CARD_TYPE[p.cardtype] //证件类型
                    ,p.card //证件号码
                    ,p.zznyhk ? "农业" : "非农业" //户籍
                    ,city < 1 ? "" : Card.find(city).address //报名所在省
                    ,province < 1000 ? "" : Card.find(flag ? province : Integer.parseInt(String.valueOf(province).substring(0,4))).address //报名所在市
                    ,Lms.JOB_TYPE[p.job] //职业
                    ,Lms.ORG_NATURE[p.orgnature] //单位性质
                    ,"二级（独立本科）" //证书级别
                    ,LmsCert.f(p.leveltype) //证书方向
                    ,p.getDegree(h.language) //学历
                    ,Lms.YES_NO[p.rclass] //是否在读
                    ,p.getSection(h.language) //现阶段所在班级
                    ,p.getSchool(h.language) //毕业院校
                    ,p.getFunctions(h.language) //毕业专业
                    ,MT.f(p.gtime) //毕业时间
                    ,p.getOrganization(h.language) //工作单位
                    ,p.mobile //移动电话
                    ,p.getAddress(h.language) //通讯地址
                    ,p.getTelephone(h.language) //固定电话
                    ,p.getZip(h.language) //邮编
                    ,p.email //电子邮箱
                    ,MT.f(p.getTime()) //报名日期
                    ,MT.f(p.getVerifgtime()) //入学日期
                    ,Lms.MEMBER_TYPE[p.getType()] //学员状态
                    ,photo == null ? null : photo //电子照片
                    ,LmsOrg.find(lo.father).orgname //省助学发展机构
                    ,lo.orgname //学习服务中心名称
                    ,lo.orgno //学习服务中心编号
            };
            wr = ws.createRow(i + 1);
            for(int j = 0;j < VALUE.length;j++)
            {
                Cell wd = wr.createCell(j);
                if(VALUE[j] != null)
                    wd.setCellValue(VALUE[j]);
                wd.setCellStyle(TD);
            }
            if(i % 200 == 0)
            {
                out.print("<script>mt.progress(" + i + "," + al.size() + ");</script>");
                out.flush();
            }
        }
        width(ws,0,title.length);
    }

    //学员报考
    public void membercourse(Http h,Workbook wb) throws Exception
    {
        PrintWriter out = h.response.getWriter();
        CellStyle TH = wb.getCellStyleAt((short) 2),TD = wb.getCellStyleAt((short) 3);
        TH.setAlignment(CellStyle.ALIGN_CENTER);
        CellStyle TH2 = wb.createCellStyle();
        TH2.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        TH2.setBorderBottom(CellStyle.BORDER_THIN);
        TH2.setBorderRight(CellStyle.BORDER_THIN);
        TH2.setBorderLeft(CellStyle.BORDER_THIN);
        TH2.setBorderTop(CellStyle.BORDER_THIN);
        Font font = wb.createFont();
        font.setFontHeight((short) (10 * 20));
        font.setBoldweight((short) 700);
        TH2.setFont(font);
        TH2.setWrapText(true);

        SXSSFSheet ws = (SXSSFSheet) wb.createSheet();
        ws.setDefaultRowHeight((short) 500);
        ws.setDefaultColumnWidth(16);
        Row wr = ws.createRow(0),wr1 = ws.createRow(1);
        //
        LmsPlan lp = LmsPlan.find(h.getInt("lmsplan"));
        String[] title =
                {"学号","姓名","证件号","省助学发展机构","学习服务中心","报考时间","入学日期　"};
        ws.addMergedRegion(new CellRangeAddress(0,0,0,title.length - 1));
        Cell wd = wr.createCell(0);
        wd.setCellValue(lp.name + "考试计划");
        wd.setCellStyle(TH);
        for(int j = 0;j < title.length;j++)
        {
            //ws.addMergedRegion(new CellRangeAddress(0,1,j,j));
            wd = wr1.createCell(j);
            wd.setCellValue(title[j]);
            wd.setCellStyle(TH);
        }
        //
        ArrayList lpcs = LmsPlanCourse.find(" AND lmsplan=" + lp.lmsplan + " ORDER BY starttime",0,200);
        String[] CATE =
                {"实践环节报考科目","机考报考科目"};
        for(int j = 0;j < lpcs.size();j++)
        {
            LmsPlanCourse lpc = (LmsPlanCourse) lpcs.get(j);
            LmsCourse lc = LmsCourse.find(lpc.lmscourse);
            for(int x = 0;x < CATE.length;x++)
            {
                int y = title.length + j + lpcs.size() * x;
                if(j == 0)
                {
                    ws.addMergedRegion(new CellRangeAddress(0,0,y,y + lpcs.size() - 1));
                    wd = wr.createCell(y);
                    wd.setCellValue(CATE[x]);
                    wd.setCellStyle(TH);
                }
                wd = wr1.createCell(y);
                ws.setColumnWidth(y,2400); //75px,10号字5个的宽度
                wd.setCellValue(lc.name);
                wd.setCellStyle(TH2);
            }
        }
        //
        ws.createFreezePane(2,2);
        ArrayList al = LmsMemberCourse.find(h.key,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsMemberCourse t = (LmsMemberCourse) al.get(i);
            Profile p = Profile.find(t.member);
            LmsOrg lo = LmsOrg.find(p.getAgent());
            wr = ws.createRow(i + 2);
            String[] value =
                    {p.getMember(),p.getName(h.language),p.getCard(),LmsOrg.find(lo.father).orgname,lo.orgname,MT.f(p.time,1),MT.f(p.getVerifgtime(),1)};
            for(int j = 0;j < value.length;j++)
            {
                wd = wr.createCell(j);
                wd.setCellValue(value[j]);
                wd.setCellStyle(TD);
            }
            LmsMemberCourse lmc = LmsMemberCourse.find(t.member,t.lmsplan);
            for(int j = 0;j < lpcs.size();j++)
            {
                LmsPlanCourse lpc = (LmsPlanCourse) lpcs.get(j);
                for(int x = 0;x < CATE.length;x++)
                {
                    int y = title.length + j + lpcs.size() * x;
                    wd = wr.createCell(y);
                    if((x == 0 ? lmc.lmscourse0 : lmc.lmscourse1).contains("|" + lpc.lmscourse + "|"))
                        wd.setCellValue("报考");
                    wd.setCellStyle(TD);
                }
            }
            if(i % 200 == 0)
            {
                out.print("<script>mt.progress(" + i + "," + al.size() + ");</script>");
                out.flush();
            }
        }
        width(ws,0,title.length);
    }

    //学员报考 上报给考试中心的数据格式
    public void membercity(Http h,Workbook wb) throws Exception
    {
        PrintWriter out = h.response.getWriter();
        SXSSFSheet ws = (SXSSFSheet) wb.createSheet();
        ws.setDefaultRowHeight((short) 500);
        ws.setDefaultColumnWidth(16);
        //
        Row wr = ws.createRow(0);
        Cell wd = wr.createCell(0);
        wd.setCellValue("身份证号码");
        wd = wr.createCell(1);
        wd.setCellValue("课程代码");
        //
        ws.createFreezePane(0,1);
        ArrayList al = LmsMemberCourse.find(h.key,0,Integer.MAX_VALUE);
        for(int i = 0,x = 1;i < al.size();i++)
        {
            LmsMemberCourse t = (LmsMemberCourse) al.get(i);
            Profile p = Profile.find(t.member);

            String[] arr = t.lmscourse1.split("[|]");
            for(int j = 1;j < arr.length;j++)
            {
                LmsCourse lc = LmsCourse.find(Integer.parseInt(arr[j]));
                wr = ws.createRow(x++);

                wd = wr.createCell(0);
                wd.setCellValue(p.getCard());

                wd = wr.createCell(1);
                wd.setCellValue(lc.code);
            }
            if(i % 200 == 0)
            {
                out.print("<script>mt.progress(" + i + "," + al.size() + ");</script>");
                out.flush();
            }
        }
        width(ws,0,2);

        ws = (SXSSFSheet) wb.createSheet();
        ws.setDefaultRowHeight((short) 500);
        ws.setDefaultColumnWidth(16);
        //
        String[] CODE =
                {"SXH","XXZXBH","XXZXMC","XM","XH","ZKZH","XB","CSRQ","ZJLX","ZJHM","MZ","ZZMM","JG","BMSF","BMCS","HJ","ZY","DWXZ","ZSJB","ZSFX","XL","BYSJ","SFZD","JDBJ","YDDH","DZYX","TXDZ","YB","BKCS"}
                ,NAME =
                        {"顺序号","学习中心编号","学习中心名称","姓名","学号","准考证号","性别","出生日期","证件类型","证件号码","民族","政治面貌","籍贯","报名地区（省）","报名地区（城市）","户籍","职业","单位性质","证书级别","证书方向","学历","毕业时间","是否在读","就读班级","移动电话","电子邮箱","通讯地址","邮编","报考城市"};
        Row wr0 = ws.createRow(0),wr1 = ws.createRow(1);
        for(int i = 0;i < CODE.length;i++)
        {
            wr0.createCell(i).setCellValue(CODE[i]);
            wr1.createCell(i).setCellValue(NAME[i]);
        }
        //
        ws.createFreezePane(4,2);
        al = LmsMemberCourse.find(h.key,0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            LmsMemberCourse t = (LmsMemberCourse) al.get(i);
            Profile p = Profile.find(t.member);
            LmsOrg lo = LmsOrg.find(p.getAgent());
            int province = p.getProvince(h.language);
            int city = province < 10 ? 0 : Integer.parseInt(String.valueOf(province).substring(0,2));
            boolean flag = (city == 11 || city == 12 || city == 31 || city == 50); //直辖市，忽略二级
            String[] VALUE =
                    {String.valueOf(i + 1) //顺序号
                    ,lo.orgno //学习中心编号
                    ,lo.orgname //学习中心名称
                    ,p.getName(h.language) //姓名
                    ,p.getMember() //学号
                    ,p.getCardnumber() //准考证号
                    ,p.isSex() ? "男" : "女" //性别
                    ,MT.f(p.getBirth()) //出生日期
                    ,Lms.CARD_TYPE[p.getCardType()] //证件类型
                    ,p.getCard() //证件号码
                    ,p.getZzracky() //民族
                    ,Lms.POLITY_TYPE[p.getPolity()] //政治面貌
                    ,Card.find(p.getJcity()).address //籍贯
                    ,city < 1 ? "" : Card.find(city).address //报名地区（省）
                    ,province < 1000 ? "" : Card.find(flag ? province : Integer.parseInt(String.valueOf(province).substring(0,4))).address //报名地区（城市）
                    ,p.zznyhk ? "农业" : "非农业" //户籍
                    ,Lms.JOB_TYPE[p.getJob()] //职业
                    ,Lms.ORG_NATURE[p.orgnature] //单位性质
                    ,"二级（独立本科）" //证书级别
                    ,LmsCert.f(p.leveltype) //证书方向
                    ,p.getDegree(h.language) //学历
                    ,MT.f(p.gtime) //毕业时间
                    ,Lms.YES_NO[p.rclass] //是否在读
                    ,p.getSection(h.language) //就读班级
                    ,p.mobile //移动电话
                    ,p.email //电子邮箱
                    ,p.getAddress(h.language) //通讯地址
                    ,p.getZip(h.language) //邮编
                    ,province < 1000 ? "" : Card.find(flag ? province : Integer.parseInt(String.valueOf(province).substring(0,4))).address
            };
            wr = ws.createRow(i + 2);
            for(int j = 0;j < VALUE.length;j++)
            {
                wr.createCell(j).setCellValue(VALUE[j]);
            }
            if(i % 200 == 0)
            {
                out.print("<script>mt.progress(" + i + "," + al.size() + ");</script>");
                out.flush();
            }
        }
        width(ws,0,NAME.length);
    }

    //自适应列宽
    static void width(Sheet ws,int i,int j)
    {
        for(int x = i;x < j;x++)
        {
            int max = 0;
            for(int y = 0;y <= ws.getLastRowNum();y++)
            {
                Row row = ws.getRow(y);
                if(row == null) //数据量过大时，前面的几百行取不到数据
                    continue;
                Cell cell = row.getCell(x);
                if(cell == null)
                    continue;
                String val = cell.toString();
                if(val == null)
                    continue;
                try
                {
                    max = Math.max(max,val.getBytes("GBK").length);
                } catch(UnsupportedEncodingException ex)
                {}
            }
            ws.setColumnWidth(x,max * 256 + 384);
            //System.out.println(x + ":" + (char) (x + 'A') + ":" + ws.getColumnWidth(x));
        }

//        for(int i = 0;i < j;i++)
//        {
//            ws.autoSizeColumn(i,true);
//            int w = (int) (ws.getColumnWidth(i) * 512 / 286 + (j < 6 ? 1200 : 156));
//            System.out.println(i + "、" + w + "=" + ws.getColumnWidth(i));
//            ws.setColumnWidth(i,Math.min(w,10000));
//            //12号汉字：WPS:512 POI:469
//        }
        //12号:  512/256
    }

    /*12号字/宋体
       608/640
       864/896

       864/896   中文WPS/Office
     1376/1408

     544  286 IP172
     830

     715  495 本机
     1210
     */
    //mysql-connector-java-5.1.5-bin.jar 不支持别名
    public void sql(Http h,Workbook wb) throws Exception
    {
        long cur = System.currentTimeMillis();
        PrintWriter out = h.response.getWriter();
        CellStyle TH = wb.getCellStyleAt((short) 2),TD = wb.getCellStyleAt((short) 3);
        Sheet ws = wb.createSheet();
        ws.setDefaultRowHeight((short) 500);
        ws.createFreezePane(1,1);
        DbAdapter db = new DbAdapter();
        try
        {
            //System.out.println(h.key);
            ResultSet rs = db.executeQuery(h.key,0,Integer.MAX_VALUE);
            ResultSetMetaData md = rs.getMetaData();
            //标题
            Row wr = ws.createRow(0);
            for(int j = 0;j < md.getColumnCount();j++)
            {
                Cell wd = wr.createCell(j);
                wd.setCellValue(md.getColumnName(j + 1));
                //ws.setColumnWidth(j,8192); //默认:4096
                wd.setCellStyle(TH);
            }
            //数据
            for(int i = 1;rs.next();i++)
            {
                wr = ws.createRow(i);
                for(int j = 0;j < md.getColumnCount();j++)
                {
                    Cell wd = wr.createCell(j);
                    //System.out.println(md.getColumnType(j + 1) + ":" + md.getColumnTypeName(j + 1));
                    int type = md.getColumnType(j + 1);
                    if(md.getColumnType(j + 1) == 93) //datetime
                    {
                        Date time = db.getDate(j + 1);
                        //autoSizeColumn: 1.是null的话报错  2.Date计算的Size不正确
                        //if(time != null)
                        wd.setCellValue(MT.f(time,1));
                        //wd.setCellValue(time);
                    } else if(type == 300 || type == 700) //7:float,3:DECIMAL
                    {
                        wd.setCellValue(db.getFloat(j + 1));
                    } else
                    {
                        wd.setCellValue(rs.getString(j + 1));
                    }
                    wd.setCellStyle(TD);
                }
                if(i % 200 == 0)
                {
                    out.print("<script>mt.show('导出：" + i + "条！<br/>耗时：" + MT.ss((int) (System.currentTimeMillis() - cur) / 1000) + "',0);</script>");
                    out.flush();
                }
            }
            rs.close();
            width(ws,0,md.getColumnCount());
        } finally
        {
            db.close();
        }
    }
}
