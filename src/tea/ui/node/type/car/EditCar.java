package tea.ui.node.type.car;

import java.io.*;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import javax.servlet.ServletContext;
import java.math.BigDecimal;

public class EditCar extends TeaServlet
{
    public EditCar()
    {

    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            ServletContext application = getServletContext();
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            String subject = teasession.getParameter("_nName");
            String content = teasession.getParameter("content");
            byte bypic[] = teasession.getBytesParameter("picture");

            String carprice = teasession.getParameter("carprice");
            if(carprice != null && carprice.length() > 0)
            {
                carprice = teasession.getParameter("carprice");
            } else
            {
                carprice = "0";
            }
            BigDecimal price = new BigDecimal(carprice);
            Date date4 = new Date();
            try
            {
                date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
            } catch(Exception ex2)
            {
            }
            if(node.getType() == 1)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                String community = node.getCommunity();
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //39
                teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,date4,node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,"","",content,null,"",0,null,"","","","",null,null);
                node = Node.find(teasession._nNode);
            } else
            {
                node.set(teasession._nLanguage,subject,content);
                node.setTime(date4);
            }
            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/car/" + teasession._nNode + ".jpg"));
            File dir = fpic.getParentFile();
            String path = "/res/" + node.getCommunity() + "/car/" + teasession._nNode + ".jpg";

            if(!dir.exists())
            {
                dir.mkdirs();
            }
            if(teasession.getParameter("clearpicture") != null)
            {
                path = null;
                fpic.delete();
            } else if(bypic != null)
            {
                FileOutputStream fos = new FileOutputStream(fpic);
                fos.write(bypic);
                fos.close();
            }
            int carstatic = 0; //车况（新/旧）
            if(teasession.getParameter("carstatic") != null && teasession.getParameter("carstatic").length() > 0)
            {
                carstatic = Integer.parseInt(teasession.getParameter("carstatic"));
            }
            int carclass = 0; //汽车品牌（国内/进口）
            if(teasession.getParameter("carclass") != null && teasession.getParameter("carclass").length() > 0)
            {
                carclass = Integer.parseInt(teasession.getParameter("carclass"));
            }
            int carbrand = 0; //汽车品牌
            if(teasession.getParameter("carbrand") != null && teasession.getParameter("carbrand").length() > 0)
            {
                carbrand = Integer.parseInt(teasession.getParameter("carbrand"));
            }
            int cartype = 0; //车型
            if(teasession.getParameter("cartype") != null && teasession.getParameter("cartype").length() > 0)
            {
                cartype = Integer.parseInt(teasession.getParameter("cartype"));
            }
            String carmiles = teasession.getParameter("carmiles"); //首保里程
            String caroil = teasession.getParameter("caroil"); //油耗
            String caremission = teasession.getParameter("caremission"); //排放指标
            String carshape = teasession.getParameter("carshape"); //外型 尺寸(cm)
            String wheelbase = teasession.getParameter("wheelbase"); //轴距(cm)
            String maxoutput = teasession.getParameter("maxoutput"); //最大功率(KW)
            String outcapacity = teasession.getParameter("outcapacity"); //排量(毫升)
            String engine = teasession.getParameter("engine"); //发动机型式
            String acrotorque = teasession.getParameter("acrotorque"); //最大扭矩(N.m)
            String speedchanger = teasession.getParameter("speedchanger"); //变速器型式
            String drive = teasession.getParameter("drive"); //驱动形式
            String volume = teasession.getParameter("volume"); //后备箱体积(升)
            String production = teasession.getParameter("production"); //生产状态

            Car.set(node._nNode,path,carstatic,carclass,carbrand,cartype,price,carmiles,caroil,caremission,carshape,wheelbase,maxoutput,outcapacity,engine,acrotorque,speedchanger,drive,volume,production);
            String nexturl = teasession.getParameter("nexturl");
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
                return;
            } else
            {
                if(nexturl != null)
                {
                    response.sendRedirect(nexturl);
                    return;
                } else
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                    return;
                }
            }


        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        //  super.r.add("tea/ui/node/type/dish/EditDish");
    }
}
