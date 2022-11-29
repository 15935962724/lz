package tea.ui.leagueshop;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import java.math.*;
import jxl.write.*;
import tea.entity.ocean.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.resource.*;
import tea.entity.league.*;
import tea.entity.util.*;
import tea.entity.admin.*;
import tea.db.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;



public class EditLeagueShopExcel extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Annuity");
    }

    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String action = request.getParameter("action");
        int count = 0;
        if(teasession.getParameter("count") != null && teasession.getParameter("count").length() > 0)
        {
            count = Integer.parseInt(teasession.getParameter("count"));
        }

        System.out.println("38---------");
        response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode(files + ".xls","UTF-8"));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try
        {

            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(baos);
            jxl.write.WritableSheet ws = wwb.createSheet(files,0);
            int pos = 0;
            if(teasession.getParameter("pos") != null && teasession.getParameter("pos").length() > 0)
            {
                pos = Integer.parseInt(teasession.getParameter("pos"));
            }
            int i = 1;
            if("LeagueShopImprestList2".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setBorder(Border.ALL,BorderLineStyle.THIN,jxl.format.Colour.BLACK);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                WritableFont wf2 = new WritableFont(WritableFont.createFont("宋体"),15,WritableFont.BOLD,false);
                WritableCellFormat wff2 = new WritableCellFormat(wf2);
                wff2.setBorder(Border.ALL,BorderLineStyle.THIN,jxl.format.Colour.BLACK);
                wff2.setAlignment(jxl.format.Alignment.CENTRE);

//                WritableFont font = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.NO_BOLD,false);
////表格背景色在WritableCellFormat中设置
//                WritableCellFormat normalFormat = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.NO_BOLD,false));
//
//                //设置背景色
//                normalFormat.setBackground(jxl.format.Colour.RED);
////设置边框及边框颜色Border
//                normalFormat.setBorder(Border.ALL,BorderLineStyle.THICK,jxl.format.Colour.BLACK);
////                //将normalFormat传给label，那么label的背景色和边框就会改变为你设置的样式
////                Label label = new Label(0,20,"",normalFormat);
////                ws.addCell(label); //WritableSheet ws     将label加入excel sheet中





                int lsid = 0;
                if(teasession.getParameter("lsid") != null && teasession.getParameter("lsid").length() > 0)
                {
                    lsid = Integer.parseInt(teasession.getParameter("lsid"));
                }
                LeagueShop lsobj = LeagueShop.find(lsid);
                LeagueShopType objtype = LeagueShopType.find(lsobj.getLstype());
                LeagueShopServer objserver = LeagueShopServer.find(lsobj.getLsstype());
                Card card1 = Card.find(lsobj.getProvince());
                Card card2 = Card.find(lsobj.getCity());
                StringBuffer address = new StringBuffer("");
                int k = 1;

                if(card1.getAddress() != null)
                {
                    address.append(card1.getAddress());
                }
                if(card2.getAddress() != null)
                {
                    address.append(card2.getAddress());
                }
                if(lsobj.getRegion() != null)
                {
                    address.append(lsobj.getRegion().replaceAll(card1.getAddress(),"").replaceAll(card2.getAddress(),""));
                }
                if(lsobj.getPort() != null)
                {
                    address.append(lsobj.getPort());
                }
                if(lsobj.getNumber() != null)
                {
                    address.append(lsobj.getNumber().replaceAll(card1.getAddress(),"").replaceAll(card2.getAddress(),""));
                }
                String datek = "";
                if(teasession.getParameter("datek") != null && teasession.getParameter("datek").length() > 0)
                {
                    datek = teasession.getParameter("datek");
                }
                String datej = "";
                if(teasession.getParameter("datej") != null && teasession.getParameter("datej").length() > 0)
                {
                    datej = teasession.getParameter("datej");
                }

                int j = 0;
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //0
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //1
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //2
				ws.addCell(new jxl.write.Label(j++,0,"",wff)); //3.........实收
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //4-----
                ws.addCell(new jxl.write.Label(j++,0,"客户销售档案",wff2)); //5
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //6
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //7------
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //8
				ws.addCell(new jxl.write.Label(j++,0,"",wff)); //9---冻结
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //10
                ws.addCell(new jxl.write.Label(j++,0,"",wff)); //11
                ws.mergeCells(0,0,4,0);
                ws.mergeCells(5,0,8,0);
                ws.mergeCells(9,0,11,0);
                j = 0;
                ws.addCell(new jxl.write.Label(j++,1,"公司编码：",wff)); //0
                ws.addCell(new jxl.write.Label(j++,1,"",wff)); //1
                ws.addCell(new jxl.write.Label(j++,1,"",wff)); //2
                ws.addCell(new jxl.write.Label(j++,1,"加盟日期：",wff)); //3
				ws.addCell(new jxl.write.Label(j++,0,"",wff)); //4.........实收
                ws.addCell(new jxl.write.Label(j++,1,datek + "---" + datej,wff)); //5
                ws.addCell(new jxl.write.Label(j++,1,"",wff)); //6
                ws.addCell(new jxl.write.Label(j++,1,"折扣：",wff)); //7
                ws.addCell(new jxl.write.Label(j++,1,"",wff)); //8
				ws.addCell(new jxl.write.Label(j++,1,"",wff)); //9
                ws.addCell(new jxl.write.Label(j++,1,"TEL：",wff)); //10
                ws.addCell(new jxl.write.Label(j++,1,lsobj.getTel(),wff)); //11
                ws.mergeCells(0,1,1,1);
				ws.mergeCells(3,1,4,1);
                ws.mergeCells(5,1,6,1);
                j = 0;
                ws.addCell(new jxl.write.Label(j++,2,"客户名称：",wff)); //0
                ws.addCell(new jxl.write.Label(j++,2,"",wff)); //1
                ws.addCell(new jxl.write.Label(j++,2,lsobj.getLsbuyname(),wff)); //2
                ws.addCell(new jxl.write.Label(j++,2,"公司地址：",wff)); //3
				ws.addCell(new jxl.write.Label(j++,0,"",wff)); //4.........实收
                ws.addCell(new jxl.write.Label(j++,2,address.toString(),wff)); //5
                ws.addCell(new jxl.write.Label(j++,2,"",wff)); //6
                ws.addCell(new jxl.write.Label(j++,2,"级别：",wff)); //7
                ws.addCell(new jxl.write.Label(j++,2,objtype.getLstypename() + ":" + objserver.getLssname(),wff)); //8
				ws.addCell(new jxl.write.Label(j++,2,"",wff)); //9
                ws.addCell(new jxl.write.Label(j++,2,"导师：",wff)); //10
                ws.addCell(new jxl.write.Label(j++,2,"",wff)); //11
                ws.mergeCells(0,2,1,2);
                ws.mergeCells(5,2,6,2);
                j = 0;
                ws.addCell(new jxl.write.Label(j++,3,"序号",wff)); //0
                ws.addCell(new jxl.write.Label(j++,3,"日期",wff)); //1
                ws.addCell(new jxl.write.Label(j++,3,"摘要",wff)); //2
                ws.addCell(new jxl.write.Label(j++,3,"应付金额",wff)); //3
				ws.addCell(new jxl.write.Label(j++,3,"实收金额",wff)); //4.........实收
                ws.addCell(new jxl.write.Label(j++,3,"发出商品",wff)); //5
                ws.addCell(new jxl.write.Label(j++,3,"",wff)); //6
                ws.addCell(new jxl.write.Label(j++,3,"配送商品",wff)); //7
                ws.addCell(new jxl.write.Label(j++,3,"",wff)); //8
				ws.addCell(new jxl.write.Label(j++,3,"冻结金额",wff)); //9
                ws.addCell(new jxl.write.Label(j++,3,"未发出商品金额",wff)); //10
                ws.addCell(new jxl.write.Label(j++,3,"配送余额",wff)); //11
                j = 0;
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //0
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //1
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //2
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //3
				ws.addCell(new jxl.write.Label(j++,4,"",wff)); //4.........实收
                ws.addCell(new jxl.write.Label(j++,4,"支付运费",wff)); //5
                ws.addCell(new jxl.write.Label(j++,4,"发货金额",wff)); //6
                ws.addCell(new jxl.write.Label(j++,4,"配送金额",wff)); //7
                ws.addCell(new jxl.write.Label(j++,4,"应付配送",wff)); //8
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //9
				ws.addCell(new jxl.write.Label(j++,4,"",wff)); //10
                ws.addCell(new jxl.write.Label(j++,4,"",wff)); //11

                ws.mergeCells(5,3,6,3);//发出商品
                ws.mergeCells(7,3,8,3);//配送商品

                ws.mergeCells(0,3,0,4);
                ws.mergeCells(1,3,1,4);
                ws.mergeCells(2,3,2,4);
                ws.mergeCells(3,3,3,4);
				ws.mergeCells(4,3,4,4);
                ws.mergeCells(9,3,9,4);
				ws.mergeCells(10,3,10,4);
				ws.mergeCells(11,3,11,4);

                BigDecimal yingfu_za = new BigDecimal("0");
				BigDecimal yingfu_zs= new BigDecimal("0");

				BigDecimal shifu_za =new BigDecimal("0");
				BigDecimal shifu_zs =new BigDecimal("0");
                BigDecimal zhifu_z = new BigDecimal("0");
                BigDecimal fahuo_z = new BigDecimal("0");
                BigDecimal peisong_z = new BigDecimal("0");
                BigDecimal yingfupeisong_z = new BigDecimal("0");
                BigDecimal weifajine_z = new BigDecimal("0");
                BigDecimal peisongyu_z = new BigDecimal("0");
				BigDecimal dongjie_z = LeagueShopImprest.SumMoney(" and lsid="+lsid+" and  audittype=1  and lsistatic=2 and type=1 "+sql.toString());

                Enumeration euls = LeagueShopImprest.findByCommunity(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                if(!euls.hasMoreElements())
                {

                } while(euls.hasMoreElements())
                {
					String  xianshi="";
                    int liid = Integer.parseInt(String.valueOf(euls.nextElement()));
                    LeagueShopImprest lsiobj = LeagueShopImprest.find(liid);
                    //未发出商品金额
                    //配送余额
                    BigDecimal weifajinea = new BigDecimal("0");
					BigDecimal weifajines = new BigDecimal("0");
					BigDecimal weifajine = new BigDecimal("0");
                    BigDecimal peisongyu = new BigDecimal("0");
					/** 0应付金额，1进货单 and lsistatic=1 and type=1 and and audittype=1，2冻结金额，3配送金额  and lsistatic=3 and type=1 and audittype=1，4返还金额，5运费金额,6实付金额   ********/
					//实付金额
					BigDecimal shifu = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 6 && lsiobj.getAudittype()==1)
                    {

                        if(lsiobj.getType() == 0)
                        {
							xianshi="+";
                            shifu = lsiobj.getYfmoney();
                            shifu_za = shifu_za.add(shifu);
                        } else if(lsiobj.getType()==1)
                        {
							xianshi="-";
                            shifu = lsiobj.getYfmoney();
                            shifu_zs = shifu_zs.add(shifu);
                        }
                    }

                    //应付金额
                    BigDecimal yingfu = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 0 && lsiobj.getType() == 0 || lsiobj.getLsistatic() == 4)
                    {
						xianshi="+";
						yingfu = lsiobj.getYfmoney();
                        weifajinea = weifajinea.add(yingfu);
						weifajine= lsiobj.getYfmoney();
                        yingfu_za = yingfu_za.add(yingfu);
                    }
                    if(lsiobj.getLsistatic() == 0 && lsiobj.getType() == 1 || lsiobj.getLsistatic() == 4)
                    {
                        xianshi = "-";
                        yingfu = lsiobj.getYfmoney();
                        weifajines = weifajines.add(yingfu);
						weifajine= lsiobj.getYfmoney();
                        yingfu_zs = yingfu_zs.add(yingfu);
                    }

                    //支付运费
                    BigDecimal zhifu = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 5)
                    {
						xianshi="-";
                        zhifu = lsiobj.getYfmoney();
                        weifajines = weifajines.add(zhifu);
						weifajine=  lsiobj.getYfmoney();
                        zhifu_z = zhifu_z.add(zhifu);
                    }

                    //发货金额
                    BigDecimal fahuo = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 1 && lsiobj.getType() == 1)
                    {
                        fahuo = lsiobj.getYfmoney();
                        weifajines = weifajines.add(fahuo);
						weifajine=lsiobj.getYfmoney();
                        fahuo_z = fahuo_z.add(fahuo);
                    }
                    //配送金额
                    BigDecimal peisong = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 3 && lsiobj.getType() == 1)
                    {
						xianshi="-";
                        peisong = lsiobj.getYfmoney();
                        peisongyu = peisongyu.subtract(peisong);
                        peisong_z = peisong_z.add(peisong);
                    }

                    //应付配送
                    BigDecimal yingfupeisong = new BigDecimal("0");
                    if(lsiobj.getLsistatic() == 3 && lsiobj.getType() == 0)
                    {
						xianshi="+";
                        yingfupeisong = lsiobj.getYfmoney();
                        peisongyu = peisongyu.add(yingfupeisong);
                        yingfupeisong_z = yingfupeisong_z.add(yingfupeisong);
                    }
                    System.out.println(weifajinea);
                    System.out.println(weifajines);
					weifajine_z = weifajine_z.add(weifajinea).subtract(weifajines);
                    peisongyu_z = peisongyu_z.add(peisongyu);

                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(k),wff));//0
                    ws.addCell(new jxl.write.Label(j++,4 + i,lsiobj.getZzdatetoString(),wff));//1
                    ws.addCell(new jxl.write.Label(j++,4 + i,lsiobj.getSummary(),wff));//2
					ws.addCell(new jxl.write.Label(j++,4 + i,xianshi+String.valueOf(yingfu),wff));//3
                    ws.addCell(new jxl.write.Label(j++,4 + i,xianshi+String.valueOf(shifu),wff));//4
                    ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(zhifu),wff));//5
                    ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(fahuo),wff));//6
                    ws.addCell(new jxl.write.Label(j++,4 + i,xianshi+String.valueOf(peisong),wff));//7
                    ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(yingfupeisong),wff));//8
					ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(yingfupeisong),wff));//9
                    ws.addCell(new jxl.write.Label(j++,4 + i,xianshi+String.valueOf(weifajine),wff));//10
                    ws.addCell(new jxl.write.Label(j++,4 + i,String.valueOf(peisongyu),wff));//11

                    k++;
                    i++;
                }
                j = 0;
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
				ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,4 + i,"",wff));
                j = 0;
                ws.addCell(new jxl.write.Label(j++,5 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,"合计",wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(yingfu_za)+"/"+String.valueOf(yingfu_zs),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(shifu_za)+"/"+String.valueOf(shifu_zs),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(zhifu_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(fahuo_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(peisong_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(yingfupeisong_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(dongjie_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(weifajine_z),wff));
                ws.addCell(new jxl.write.Label(j++,5 + i,String.valueOf(peisongyu_z),wff));

            }

            if("LeagueShopDelete".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);
                int j = 0;
                ws.addCell(new jxl.write.Label(j++,0,"加盟店编号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称",wff));
                ws.addCell(new jxl.write.Label(j++,0,"营业执照",wff));
                ws.addCell(new jxl.write.Label(j++,0,"法人",wff));
                ws.addCell(new jxl.write.Label(j++,0,"所在区域",wff));
                ws.addCell(new jxl.write.Label(j++,0,"省",wff));
                ws.addCell(new jxl.write.Label(j++,0,"市",wff));
                ws.addCell(new jxl.write.Label(j++,0,"区",wff));
                ws.addCell(new jxl.write.Label(j++,0,"港",wff));
                ws.addCell(new jxl.write.Label(j++,0,"号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长姓名",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店类型",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店级别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店状态",wff));
                ws.addCell(new jxl.write.Label(j++,0,"预付款金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店管理员姓名",wff));

                java.util.Enumeration dome = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    LeagueShop obj = LeagueShop.find(lsid);

                    LeagueShopServer objserver = LeagueShopServer.find(obj.getLsstype());
                    LeagueShopType objtype = LeagueShopType.find(obj.getLstype());
                    Card card1 = Card.find(obj.getProvince());
                    Card card2 = Card.find(obj.getCity());
                    AdminUnit uu = AdminUnit.find(obj.getBumen());
                    StringBuffer guanliyuan = new StringBuffer();
                    Enumeration aa = AdminUsrRole.find(teasession._strCommunity,"   and unit=" + obj.getBumen(),0,Integer.MAX_VALUE);
                    for(int x = 0;aa.hasMoreElements();x++)
                    {
                        String member = String.valueOf(aa.nextElement());
                        if(Profile.isExisted(member))
                        {
                            Profile pobj = Profile.find(member);;
                            guanliyuan.append(pobj.getName(teasession._nLanguage)).append("/");
                        }

                    }
                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(obj.getId())));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbusiness()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLegalperson()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.CSAREA[obj.getCsarea()])); //
                    ws.addCell(new jxl.write.Label(j++,0 + i,card1.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,card2.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getRegion()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getPort()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getNumber()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getShopkeepername()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,objtype.getLstypename())); //唯美度
                    ws.addCell(new jxl.write.Label(j++,0 + i,objserver.getLssname())); //类
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAdddateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.LSSTATIC[obj.getLsstatic()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSummoney().toString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,guanliyuan.toString()));

                    i++;
                }
            }

            if("LeagueShopImprestList3".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);
                int j = 0;

                String time_k = teasession.getParameter("time_k");
                String time_j = teasession.getParameter("time_j");
				String sql2 =teasession.getParameter("sql2");
				String sql3 =teasession.getParameter("sql3");
				int k=1;
                //序号 加盟品牌 加盟店名称  省份 期初应付余额 本期应付金额 本期返还金额 本期销售商品金额 期末应付余额 冻结应付余额 本期配送金额 期末配送余额 地址 联络电话 加盟商姓名  联系人 加盟级别  加盟日期
                ws.addCell(new jxl.write.Label(j++,0,"序号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟品牌",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称",wff));
                ws.addCell(new jxl.write.Label(j++,0,"省份",wff));
                ws.addCell(new jxl.write.Label(j++,0,"期初应付余额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"本期应付金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"本期返还金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"本期销售商品金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"期末应付余额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"冻结应付余额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"本期配送金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"期末配送余额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"地址",wff));
                ws.addCell(new jxl.write.Label(j++,0,"联络电话",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商姓名",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟级别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟日期",wff));

                java.util.Enumeration dome = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {
                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    LeagueShop objlist = LeagueShop.find(lsid);
                    LeagueShopServer objserver = LeagueShopServer.find(objlist.getLsstype());
                    LeagueShopType objtype = LeagueShopType.find(objlist.getLstype());
                    Card card1 = Card.find(objlist.getProvince());
                    Card card2 = Card.find(objlist.getCity());
                    StringBuffer address = new StringBuffer("");
                    if(card1.getAddress() != null)
                    {
                        address.append(card1.getAddress());
                    }
                    if(card2.getAddress() != null)
                    {
                        address.append(card2.getAddress());
                    }
                    if(objlist.getRegion() != null && card2.getAddress()!= null &&card1.getAddress()!=null)
                    {
                        address.append(objlist.getRegion().replaceAll(card1.getAddress(),"").replaceAll(card2.getAddress(),""));
                    }
                    if(objlist.getPort() != null)
                    {
                        address.append(objlist.getPort());
                    }
                    if(objlist.getNumber() != null)
                    {
                        address.append(objlist.getNumber().replaceAll(card1.getAddress(),"").replaceAll(card2.getAddress(),""));
                    }
                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(k++)));
                    ws.addCell(new jxl.write.Label(j++,0+i,objtype.getLstypename()));
                    ws.addCell(new jxl.write.Label(j++,0+i,objlist.getLsname()));
                    ws.addCell(new jxl.write.Label(j++,0+i,card1.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.firstMoney(" and lsid=" + lsid + " and zzdate<" + DbAdapter.cite(time_k)))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.SumMoney(" and lsid=" + lsid + " and  audittype=1  and lsistatic=0 and type=0 " + sql2))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.SumMoney(" and lsid=" + lsid + " and  audittype=1  and lsistatic=4 and type=0 " + sql2.toString()))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.SumMoney(" and lsid=" + lsid + " and  audittype=1  and lsistatic=1 and type=1 " + sql2.toString()))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.firstMoney(" and lsid=" + lsid + " and zzdate<" + DbAdapter.cite(time_j)))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.SumMoney(" and lsid=" + lsid + " and  audittype=1  and lsistatic=2 and type=1 " + sql2.toString()))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.SumMoney(" and lsid=" + lsid + " and  audittype=1  and lsistatic=3 and type=1 " + sql2.toString()))));
                    ws.addCell(new jxl.write.Label(j++,0+i,String.valueOf(LeagueShopImprest.dispatchMoney(" and lsid=" + lsid + sql2.toString()))));
                    ws.addCell(new jxl.write.Label(j++,0+i,address.toString()));
                    ws.addCell(new jxl.write.Label(j++,0+i,objlist.getTel()));
                    ws.addCell(new jxl.write.Label(j++,0+i,objlist.getLsbuyname()));
                    ws.addCell(new jxl.write.Label(j++,0+i,objtype.getLstypename()+":"+objserver.getLssname()));
                    ws.addCell(new jxl.write.Label(j++,0+i,objlist.getAdddateToString()));
                    i++;
                }
                j = 0;
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"合计：",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.firstMoney( " and zzdate<" + DbAdapter.cite(time_k)+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.SumMoney(" and  audittype=1  and lsistatic=0 and type=0 " + sql2+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.SumMoney(" and  audittype=1  and lsistatic=4 and type=0 " + sql2.toString()+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.SumMoney(" and  audittype=1  and lsistatic=1 and type=1 " + sql2.toString()+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.firstMoney(" and zzdate<" + DbAdapter.cite(time_j)+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.SumMoney(" and  audittype=1  and lsistatic=2 and type=1 " + sql2.toString()+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.SumMoney(" and  audittype=1  and lsistatic=3 and type=1 " + sql2.toString()+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(LeagueShopImprest.dispatchMoney(sql2.toString()+sql3.toString())),wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));
                ws.addCell(new jxl.write.Label(j++,0 + i,"",wff));

            }

            if("LeagueShopStatic".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);
                int j = 0;
                ws.addCell(new jxl.write.Label(j++,0,"加盟店编号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称",wff));
                ws.addCell(new jxl.write.Label(j++,0,"所在区域",wff));
                ws.addCell(new jxl.write.Label(j++,0,"省",wff));
                ws.addCell(new jxl.write.Label(j++,0,"市",wff));
                ws.addCell(new jxl.write.Label(j++,0,"区",wff));
                ws.addCell(new jxl.write.Label(j++,0,"港",wff));
                ws.addCell(new jxl.write.Label(j++,0,"号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店类型",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店级别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店状态",wff));
                ws.addCell(new jxl.write.Label(j++,0,"预付款金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店管理员姓名",wff));

                java.util.Enumeration dome = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    LeagueShop obj = LeagueShop.find(lsid);

                    LeagueShopServer objserver = LeagueShopServer.find(obj.getLsstype());
                    LeagueShopType objtype = LeagueShopType.find(obj.getLstype());
                    Card card1 = Card.find(obj.getProvince());
                    Card card2 = Card.find(obj.getCity());
                    AdminUnit uu = AdminUnit.find(obj.getBumen());
                    StringBuffer guanliyuan = new StringBuffer();
                    Enumeration aa = AdminUsrRole.find(teasession._strCommunity,"   and unit=" + obj.getBumen(),0,Integer.MAX_VALUE);
                    for(int x = 0;aa.hasMoreElements();x++)
                    {
                        String member = String.valueOf(aa.nextElement());
                        if(Profile.isExisted(member))
                        {
                            Profile pobj = Profile.find(member);;
                            guanliyuan.append(pobj.getName(teasession._nLanguage)).append("/");
                        }
                    }
                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(obj.getId())));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.CSAREA[obj.getCsarea()])); //
                    ws.addCell(new jxl.write.Label(j++,0 + i,card1.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,card2.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getRegion()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getPort()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getNumber()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,objtype.getLstypename())); //唯美度
                    ws.addCell(new jxl.write.Label(j++,0 + i,objserver.getLssname())); //类型
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAdddateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.LSSTATIC[obj.getLsstatic()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSummoney().toString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,guanliyuan.toString()));

                    i++;
                }
            }

            if("LeagueShopSum".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                int j = 0;
                ws.addCell(new jxl.write.Label(j++,0,"加盟店编号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称",wff));
                ws.addCell(new jxl.write.Label(j++,0,"所在区域",wff));
                ws.addCell(new jxl.write.Label(j++,0,"省",wff));
                ws.addCell(new jxl.write.Label(j++,0,"市",wff));
                ws.addCell(new jxl.write.Label(j++,0,"区",wff));
                ws.addCell(new jxl.write.Label(j++,0,"港",wff));
                ws.addCell(new jxl.write.Label(j++,0,"号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店类型",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店级别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店状态",wff));

                java.util.Enumeration dome = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    LeagueShop obj = LeagueShop.find(lsid);

                    LeagueShopServer objserver = LeagueShopServer.find(obj.getLsstype());
                    LeagueShopType objtype = LeagueShopType.find(obj.getLstype());
                    Card card1 = Card.find(obj.getProvince());
                    Card card2 = Card.find(obj.getCity());
                    AdminUnit uu = AdminUnit.find(obj.getBumen());
                    StringBuffer guanliyuan = new StringBuffer();
                    Enumeration aa = AdminUsrRole.find(teasession._strCommunity,"   and unit=" + obj.getBumen(),0,Integer.MAX_VALUE);
                    for(int x = 0;aa.hasMoreElements();x++)
                    {
                        String member = String.valueOf(aa.nextElement());
                        if(Profile.isExisted(member))
                        {
                            Profile pobj = Profile.find(member);;
                            guanliyuan.append(pobj.getName(teasession._nLanguage)).append("/");
                        }

                    }
                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(obj.getId())));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.CSAREA[obj.getCsarea()])); //
                    ws.addCell(new jxl.write.Label(j++,0 + i,card1.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,card2.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getRegion()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getPort()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getNumber()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,objtype.getLstypename())); //唯美度
                    ws.addCell(new jxl.write.Label(j++,0 + i,objserver.getLssname())); //类型
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAdddateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.LSSTATIC[obj.getLsstatic()]));
                    i++;
                }
            }

            if("EditLeagueShopExcel".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                int j = 0;

                ws.addCell(new jxl.write.Label(j++,0,"加盟店编号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店名称",wff));
                ws.addCell(new jxl.write.Label(j++,0,"营业执照",wff));
                ws.addCell(new jxl.write.Label(j++,0,"卫生登记证书",wff));
                ws.addCell(new jxl.write.Label(j++,0,"法人",wff));
                ws.addCell(new jxl.write.Label(j++,0,"经营性质",wff));
                ws.addCell(new jxl.write.Label(j++,0,"所在区域",wff));
                ws.addCell(new jxl.write.Label(j++,0,"省",wff));
                ws.addCell(new jxl.write.Label(j++,0,"市",wff));
                ws.addCell(new jxl.write.Label(j++,0,"区",wff));
                ws.addCell(new jxl.write.Label(j++,0,"港",wff));
                ws.addCell(new jxl.write.Label(j++,0,"号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"营业电话号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商姓名",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商性别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商手机号",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商学历",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商之前所从事的职业",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟商之前所从事行业的职务",wff));
                ws.addCell(new jxl.write.Label(j++,0,"是否专职经营连锁店",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长姓名",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长性别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"手机电话",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长最高学历",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长加盟之前从事的职业",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长加盟之前从事行业的职务",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店类型",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店级别",wff));
                ws.addCell(new jxl.write.Label(j++,0,"添加时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"开业时间",wff));
                ws.addCell(new jxl.write.Label(j++,0,"美容床数",wff));
                ws.addCell(new jxl.write.Label(j++,0,"经营面积",wff));
                ws.addCell(new jxl.write.Label(j++,0,"SPA",wff));
                ws.addCell(new jxl.write.Label(j++,0,"店长",wff));
                ws.addCell(new jxl.write.Label(j++,0,"前台顾问",wff));
                ws.addCell(new jxl.write.Label(j++,0,"美容师",wff));
                ws.addCell(new jxl.write.Label(j++,0,"固定",wff));
                ws.addCell(new jxl.write.Label(j++,0,"流动顾客",wff));
                ws.addCell(new jxl.write.Label(j++,0,"连锁店是否有电脑",wff));
                ws.addCell(new jxl.write.Label(j++,0,"是否有网络连接",wff));
                ws.addCell(new jxl.write.Label(j++,0,"上网方式",wff));
                ws.addCell(new jxl.write.Label(j++,0,"会员系统",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店状态",wff));
                ws.addCell(new jxl.write.Label(j++,0,"预付款金额",wff));
                ws.addCell(new jxl.write.Label(j++,0,"加盟店管理员姓名",wff));

                java.util.Enumeration dome = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    LeagueShop obj = LeagueShop.find(lsid);

                    LeagueShopServer objserver = LeagueShopServer.find(obj.getLsstype());
                    LeagueShopType objtype = LeagueShopType.find(obj.getLstype());
                    Card card1 = Card.find(obj.getProvince());
                    Card card2 = Card.find(obj.getCity());
                    AdminUnit uu = AdminUnit.find(obj.getBumen());
                    StringBuffer guanliyuan = new StringBuffer();
                    Enumeration aa = AdminUsrRole.find(teasession._strCommunity,"   and unit=" + obj.getBumen(),0,Integer.MAX_VALUE);
                    for(int x = 0;aa.hasMoreElements();x++)
                    {
                        String member = String.valueOf(aa.nextElement());
                        if(Profile.isExisted(member))
                        {
                            Profile pobj = Profile.find(member);;
                            guanliyuan.append(pobj.getName(teasession._nLanguage)).append("/");
                        }

                    }
                    j = 0;
                    ws.addCell(new jxl.write.Label(j++,0 + i,String.valueOf(obj.getId())));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbusiness()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getHealth()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLegalperson()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getBuytype()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.CSAREA[obj.getCsarea()])); //
                    ws.addCell(new jxl.write.Label(j++,0 + i,card1.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,card2.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getRegion()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getPort()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getNumber()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getTel()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuyname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.SHOWSEX[obj.getLsbuysex()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuytel()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuyschool()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuyjob()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuypost()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuyjob())); //是否专职经营连锁店
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getShopkeepername()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getLsbuyjob())); ///店长性别
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSktel()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSkschool()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSkjob()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSkpost()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,objtype.getLstypename())); //唯美度
                    ws.addCell(new jxl.write.Label(j++,0 + i,objserver.getLssname())); //类型
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getRegdateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAdddateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getStartdateToString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getBednum()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getShoparea()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.YESNO[obj.getSpa()])); //SPA
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getShopkeeper()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAdviser()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getHairdresser()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getFixmember()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getMovemember()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.FALGS[obj.getComputernum()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.FALGS[obj.getNetwork()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.INTERNETTYPES[obj.getInternettype()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.FALGS[obj.getSystemtype()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,LeagueShop.LSSTATIC[obj.getLsstatic()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getSummoney().toString()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,guanliyuan.toString()));

                    i++;
                }
            }
            System.out.println("ok");
            wwb.write();
            wwb.close();

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        byte by[] = baos.toByteArray();
        response.setContentLength(by.length);
        OutputStream os = response.getOutputStream();
        os.write(by);
        os.close();
        System.out.println("ok2:" + by.length);

    }


    public EditLeagueShopExcel()
    {
    }
}
