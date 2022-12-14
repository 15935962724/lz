package tea.ui.admin.orthonline;

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
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import tea.entity.admin.orthonline.CaseCollection;


public class EditCaseCollectionExcel extends TeaServlet
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
            if("CaseCollection".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("??????"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);
                int j = 0;
				ws.addCell(new jxl.write.Label(j++,0,"??????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????????????????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????????????????????????????",wff));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wff));

                java.util.Enumeration dome = CaseCollection.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int lsid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    CaseCollection obj = CaseCollection.find(lsid);
					String sex ="";
					if(obj.getSex()==0)
					{
						sex = "???";
					}else
					{
						sex ="???";
					}
                    j = 0;
					ws.addCell(new jxl.write.Label(j++,0+i,obj.getFirstname()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAddress()));
                    ws.addCell(new jxl.write.Label(j++,0+i,obj.getMobilephone()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getCasename()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,sex));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getAge()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getChief()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getGjttpain()));//????????????
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getDoingsxbw()));//??????????????????
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getGjttother()));//????????????
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getHeartpain()));//??????????????????
					ws.addCell(new jxl.write.Label(j++,0 + i,obj.getWeichangdao()));//
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getOtherpain()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getJointjixingbw()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getJointyatongbw()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getOtheryichang()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYingxiang()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYichang()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,CaseCollection.NUM[obj.getGjttnumfrist()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getChubuzhenduan()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getZzjingguo()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,CaseCollection.NUM[obj.getGjttnumlast()]));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getTaolun()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxfirstpath()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxlastpath()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxfirstpath2()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxlastpath2()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxfirstpath3()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxlastpath3()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxfirstpath4()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxlastpath4()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxfirstpath5()));
                    ws.addCell(new jxl.write.Label(j++,0 + i,obj.getYxlastpath5()));
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


    public EditCaseCollectionExcel()
    {
    }
}
