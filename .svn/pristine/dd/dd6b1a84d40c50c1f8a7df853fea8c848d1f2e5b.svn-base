package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Materias extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>mt.show('对不起，您还没有登陆，请先登陆！',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            Node n = Node.find(h.node);
            if("del".equals(act)) //删除
            {
                n.delete(h.language);
            } else if("hidden".equals(act)) //发布
            {
                n.setHidden(!n.isHidden());
            } else if("edit".equals(act)) //编辑
            {
                String subject = h.get("name");
                String content = h.get("content");
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); //103
                    h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                }
                Materia t = Materia.find(h.node);
                t.name = h.get("name");
                t.harvesting = h.get("harvesting");
                t.reference = h.get("reference");
                t.source = h.get("source");
                t.type = h.getInt("type");
                t.characteristic = h.get("characteristic");
                t.prescript = h.get("prescript");
                t.note = h.get("note");
                t.functions = h.get("functions");
                t.composition = h.get("composition");
                t.recipes = h.get("recipes");
                t.taboo = h.get("taboo");
                t.latin = h.get("latin");
                t.quarry = h.get("quarry");
                t.identify = h.get("identify");
                t.processing = h.get("processing");
                t.quality = h.get("quality");
                t.textual = h.get("textual");
                t.specification = h.get("specification");
                t.precaution = h.get("precaution");
                t.shiming = h.get("shiming");
                t.microscopic = h.get("microscopic");
                t.clinical = h.get("clinical");
                t.flavour = h.get("flavour");
                t.medicinal = h.get("medicinal");
                t.identification = h.get("identification");
                t.pharmacology = h.get("pharmacology");
                t.theory = h.get("theory");
                t.synonym = h.get("synonym");
                t.feature = h.get("feature");
                t.compatibility = h.get("compatibility");
                t.dosage = h.get("dosage");
                t.morphology = h.get("morphology");
                t.method = h.get("method");
                t.preparation = h.get("preparation");
                t.family1 = h.get("family1");
                t.species1 = h.get("species1");
                t.potency = h.get("potency");
                t.set();
                if(nexturl.length() < 1)
                    nexturl = "/html/materia/" + h.node + "-" + h.language + ".htm";
            }
            TeaServlet.delete(n);

            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
