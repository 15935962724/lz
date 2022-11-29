package tea.ui.node.type.dish;


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

public class EditDish extends TeaServlet
{
    public EditDish()
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
            String _nPrimarydata = "";

            StringBuffer strp = new StringBuffer();
            strp.append(",");
            for(int i = 0;i < Dish.PRIMARYDATA.length;i++)
            {
                _nPrimarydata = teasession.getParameter("_nPrimarydata" + i);

                if(_nPrimarydata != null && _nPrimarydata.length() > 0)
                {
                    strp.append(_nPrimarydata).append(",");
                }
            }
            _nPrimarydata = strp.toString();

            String _nCuisines = teasession.getParameter("_nCuisines");
            String _nTaste = teasession.getParameter("_nTaste");
            String _ncountry = teasession.getParameter("_ncountry");
            String _nNutrient = teasession.getParameter("_nNutrient");
            String _nEfficacity = teasession.getParameter("_nEfficacity");
            String _nmethod = "";
            StringBuffer strp2 = new StringBuffer();
            strp2.append(",");
            for(int i = 0;i < Dish.METHOD.length;i++)
            {
                _nmethod = teasession.getParameter("_nmethod" + i);

                if(_nmethod != null && _nmethod.length() > 0)
                {
                    strp2.append(_nmethod).append(",");
                }
            }

            _nmethod = strp2.toString();

            String _mouthfeel = teasession.getParameter("_mouthfeel");
            String content = teasession.getParameter("content");

            byte bypic[] = teasession.getBytesParameter("picture");

            String dishprice = teasession.getParameter("dishprice");
            if(dishprice != null && dishprice.length() > 0)
            {
                dishprice = teasession.getParameter("dishprice");
            }
            else
            {
                dishprice = "0";
            }
            BigDecimal price = new BigDecimal(dishprice);
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

            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/dish/" + teasession._nNode + ".jpg"));
            File dir = fpic.getParentFile();
            String path = "/res/" + node.getCommunity() + "/dish/" + teasession._nNode + ".jpg";

            if(!dir.exists())
            {
                dir.mkdirs();
            }
            if(teasession.getParameter("clearpicture") != null)
            {
                path=null;
                fpic.delete();
            } else if(bypic != null)
            {
                FileOutputStream fos = new FileOutputStream(fpic);
                fos.write(bypic);
                fos.close();
            }

            Dish.set(teasession._nNode,_nPrimarydata,_nCuisines,_nTaste,_ncountry,_nNutrient,_nEfficacity,_nmethod,_mouthfeel,price,path);
            //  news.set(date,teasession._nLanguage,s,s1,s2);

            String nexturl = teasession.getParameter("nexturl");
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                if(nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
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
