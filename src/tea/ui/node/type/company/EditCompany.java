package tea.ui.node.type.company;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;
import tea.entity.admin.AdminUsrRole;

public class EditCompany extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        try
        {
            Node node = Node.find(teasession._nNode);
            boolean newnode = teasession.getParameter("NewNode") != null;
            if(!newnode && !Organizer.isOrganizer(teasession._strCommunity,teasession._rv.toString()) && !node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode,teasession._rv._strV).isProvider(21) && AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString()).getCompany().indexOf("/" + teasession._nNode + "/") == -1)
            {
                response.sendError(403);
                return;
            }
            String nu = teasession.getParameter("nexturl");
            String act = teasession.getParameter("act");
            String subject = teasession.getParameter("Name").trim();
            String text = teasession.getParameter("Text");
            int sequence = 0;
            try
            {
                sequence = Integer.parseInt(teasession.getParameter("sequence"));
            } catch(NumberFormatException ex1)
            {
            }
            boolean hidden = false;
            if(newnode)
            {
                long options = node.getOptions();
                int options1 = node.getOptions1();
                hidden = (options1 & 2) != 0;
                int typealias = 0;
                String community = teasession._strCommunity;
                try
                {
                    typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                } catch(Exception exception1)
                {
                }
                // options &= 0xffdffbff;
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(teasession._nNode); //21
                teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),hidden,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",text,null,"",0,null,"","","","",null,null);
				node=Node.find(teasession._nNode);
            } else
            {
                node.setSequence(sequence);
                node.set(teasession._nLanguage,subject,text);
            }
            String s = teasession.getParameter("Contact");
            String s1 = teasession.getParameter("Email");
            String s2 = teasession.getParameter("Organization");
            String s3 = teasession.getParameter("Address");
            int city = 0;
            String tmp = teasession.getParameter("city1");
            if(tmp == null || tmp.length() < 1)
            {
                tmp = teasession.getParameter("city0");
            }
            if(tmp != null && tmp.length() > 0)
            {
                city = Integer.parseInt(tmp);
            }
            String s5 = teasession.getParameter("State");
            String s6 = teasession.getParameter("Zip");
            String s7 = teasession.getParameter("Country");
            String s8 = teasession.getParameter("Telephone");
            String s9 = teasession.getParameter("Fax");
            String s10 = teasession.getParameter("WebPage");
            String map = teasession.getParameter("map");
            String eyp = teasession.getParameter("eyp");
            Company obj = Company.find(teasession._nNode);
            obj.set(teasession._nLanguage,s,s1,s2,s3,city,s5,s6,s7,s8,s9,s10,map,eyp);

            String sex = teasession.getParameter("rdoGender");
            if(sex != null)
            {
                obj.setSex(!sex.equals("0"),teasession._nLanguage);
            }
            boolean clear = teasession.getParameter("Clear") != null;

            byte by[] = teasession.getBytesParameter("license");
            if(by != null)
            {
                obj.setLicense(write(node.getCommunity(),by,".gif"),teasession._nLanguage);
            } else if(by == null && clear)
            {
                obj.setLicense(null,teasession._nLanguage);
            }
            // logo
            clear = teasession.getParameter("logoClear") != null;
            by = teasession.getBytesParameter("logo");
            if(by != null)
            {
                obj.setLogo(write(node.getCommunity(),by,".gif"),teasession._nLanguage);
            } else if(by == null && clear)
            {
                obj.setLogo(null,teasession._nLanguage);
            }
            // Picture
            clear = teasession.getParameter("pictureClear") != null;
            by = teasession.getBytesParameter("picture");
            if(by != null)
            {
                obj.setPicture(write(node.getCommunity(),by,".gif"),teasession._nLanguage);
            } else if(by == null && clear)
            {
                obj.setPicture(null,teasession._nLanguage);
            }
            try
            {
                obj.setProperty(Integer.parseInt(teasession.getParameter("property")),teasession._nLanguage);
            } catch(NumberFormatException ex2)
            {
            }
            try
            {
                obj.setScale(Integer.parseInt(teasession.getParameter("scale")),teasession._nLanguage);
            } catch(NumberFormatException ex2)
            {
            }
            int calling = 0;
            try
            {
                calling = Integer.parseInt(teasession.getParameter("calling"));
            } catch(NumberFormatException ex3)
            {
            }
            obj.setCalling(calling,teasession._nLanguage);

            StringBuilder modal = new StringBuilder("/");
            for(int index = 0;index < Company.MODE_TYPE.length;index++)
            {
                if(teasession.getParameter("mode" + index) != null)
                {
                    modal.append(index + "/");
                }
            }
            obj.setMode(modal.toString(),teasession._nLanguage);

            try
            {
                obj.setEnrol(Integer.parseInt(teasession.getParameter("enrol")),teasession._nLanguage);
            } catch(NumberFormatException ex3)
            {
            }

            StringBuilder product = new StringBuilder();
            for(int index = 0;index < 20;index++)
            {
                String value = teasession.getParameter("product" + index);
                if(value != null && value.length() > 0)
                {
                    product.append(value + ";");
                }
            }
            obj.setProduct(product.toString(),teasession._nLanguage);

            obj.setEnroladd(teasession.getParameter("enroladd"),teasession._nLanguage);
            obj.setFareadd(teasession.getParameter("fareadd"),teasession._nLanguage);
            obj.setBirth(teasession.getParameter("birth"),teasession._nLanguage);
            obj.setBrand(teasession.getParameter("brand"),teasession._nLanguage);
            obj.setPrincipal(teasession.getParameter("principal"),teasession._nLanguage);
            obj.setTurnover(teasession.getParameter("turnover"),teasession._nLanguage);
            obj.setAgora(teasession.getParameter("p_z_Z_TradeRegion2"),teasession._nLanguage);
            obj.setClient(teasession.getParameter("client"),teasession._nLanguage);
            try
            {
                obj.setExport(Integer.parseInt(teasession.getParameter("export")),teasession._nLanguage);
            } catch(NumberFormatException ex3)
            {
            }
            try
            {
                obj.setImports(Integer.parseInt(teasession.getParameter("imports")),teasession._nLanguage);
            } catch(NumberFormatException ex3)
            {
            }
            obj.setAttestation(teasession.getParameter("p_z_Z_Certification2"),teasession._nLanguage);
            obj.setBank(teasession.getParameter("bank"),teasession._nLanguage);
            obj.setAccounts(teasession.getParameter("account"),teasession._nLanguage);
            obj.setBranch(teasession.getParameter("branch"),teasession._nLanguage);
            obj.setJob(teasession.getParameter("job"),teasession._nLanguage);
            obj.setOem("y".equals(teasession.getParameter("oem")),teasession._nLanguage);
            try
            {
                obj.setDeveloper(Integer.parseInt(teasession.getParameter("developer")),teasession._nLanguage);
            } catch(NumberFormatException ex3)
            {
            }
            obj.setTurnout(teasession.getParameter("p_z_Z_ProductionCapacity") + teasession.getParameter("p_z_Z_ProductionUnit"),teasession._nLanguage);
            obj.setAcreage(teasession.getParameter("acreage"),teasession._nLanguage);
            obj.setMass(teasession.getParameter("mass"),teasession._nLanguage);
            try
            {
                obj.setSuperior(Integer.parseInt(teasession.getParameter("superior")),teasession._nLanguage);
            } catch(NumberFormatException ex4)
            {
                obj.setSuperior(0,teasession._nLanguage);
            } catch(Exception ex4)
            {
            }
            delete(node);
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            {
                node.finished(teasession._nNode);
                if(nu == null)
                {
                    nu = "/servlet/Node?node=" + teasession._nNode;
                }
                if(newnode && hidden)
                {
                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("创建成功请等待管理员审核","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8"));
                } else
                {
                    response.sendRedirect(nu);
                }
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
