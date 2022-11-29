package tea.ui.criterion;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.admin.*;
import tea.entity.criterion.*;
import tea.entity.member.*;
import tea.ui.*;

public class EditItem extends TeaServlet
{

       // Initialize global variables
       public void init() throws ServletException
       {
       }

       // Process the HTTP Get request
       public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
       {
              request.setCharacterEncoding("UTF-8");
              try
              {
                     TeaSession teasession = new TeaSession(request);
                     if(teasession._rv == null)
                     {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                     }
                     String nexturl = teasession.getParameter("nexturl");
                     String referer = request.getHeader("referer");
                     if(referer == null) // 非法提交
                     {
                            System.out.println("标准-非法提交:" + nexturl);
                            response.sendRedirect(nexturl);
                            return;
                     }
                     ServletContext applicatin = this.getServletContext();
                     javax.servlet.http.HttpSession session = request.getSession(true);
                     String act = teasession.getParameter("act");
                     String community = teasession.getParameter("community");
                     int item = Integer.parseInt(teasession.getParameter("item"));
                     Item obj = Item.find(item);
                     if(("director").equals(act)) // 分配 标准所管理员,并把状态改为开题.
                     {
                            String director = teasession.getParameter("director");
                            obj.setDirector(director);
                            obj.setStates(3); // 把状态改为开题.
                     } else if(("open").equals(act)) // 开题阶段
                     {
                            // 开题报告
                            String openuri = null,openuriname = null;
                            byte by[] = teasession.getBytesParameter("openuri");
                            if(by != null)
                            {
                                   openuriname = teasession.getParameter("openuriName");
                                   openuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"openuri",obj.getOpenuri(),obj.getOpenname()); // 把历史文件保存
                            }
                            // 开题会议经要
                            String summaryuri = null,summaryname = null;
                            by = teasession.getBytesParameter("summaryuri");
                            if(by != null)
                            {
                                   summaryname = teasession.getParameter("summaryuriName");
                                   summaryuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"summaryuri",obj.getSummaryuri(),obj.getSummaryname()); // 把历史文件保存
                            }
                            obj.set(openuri,openuriname,summaryuri,summaryname);
                            sendMessage(obj,teasession);
                     } else if(("openauditing").equals(act)) // 开题阶段-审核
                     {
                            // 开题会议通知
                            String informuri = null,informname = null;
                            byte by[] = teasession.getBytesParameter("informuri");
                            if(by != null)
                            {
                                   informname = teasession.getParameter("informuriName");
                                   informuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"informuri",obj.getInformuri(),obj.getInformname()); // 把历史文件保存
                            }

                            String areporturi = null,areportname = null;
                            by = teasession.getBytesParameter("reviewcomments");
                            if(by != null)
                            {
                                   areportname = teasession.getParameter("reviewcommentsName");
                                   areporturi = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"areporturi_3",obj.getAreporturi_3(),obj.getAreportname_3()); // 把历史文件保存
                            }

                            boolean openauditing = "true".equals(teasession.getParameter("openauditing"));
                            boolean summaryauditing = "true".equals(teasession.getParameter("summaryauditing"));
                            obj.set_3(informuri,informname,areporturi,areportname,openauditing,summaryauditing);

                            // 发送通知
                            String reviewcommentstext = teasession.getParameter("reviewcommentstext");
                            sendMessage2(obj,teasession,reviewcommentstext,areportname,areporturi,summaryauditing);

                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(openauditing && summaryauditing && obj.getInformuri() != null && obj.getInformuri().length() > 0) // && obj.getSummaryuri() != null && obj.getSummaryuri().length() > 0
                                   {
                                          obj.setStates(10);
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("idea").equals(act)) // 征求意见阶段
                     {
                            String ideauri = null,ideaname = null;
                            byte by[] = teasession.getBytesParameter("ideauri");
                            if(by != null)
                            {
                                   ideaname = teasession.getParameter("ideauriName");
                                   ideauri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"ideauri",obj.getIdeauri(),obj.getIdeaname()); // 把历史文件保存
                            }

                            String explainuri = null,explainname = null;
                            by = teasession.getBytesParameter("explainuri");
                            if(by != null)
                            {
                                   explainname = teasession.getParameter("explainuriName");
                                   explainuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"explainuri",obj.getExplainuri(),obj.getExplainname()); // 把历史文件保存
                            }

                            String backdropuri = null,backdropname = null;
                            by = teasession.getBytesParameter("backdropuri");
                            if(by != null)
                            {
                                   backdropname = teasession.getParameter("backdropuriName");
                                   backdropuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"backdropuri",obj.getBackdropuri(),obj.getBackdropname()); // 把历史文件保存
                            }

                            obj.set(ideauri,ideaname,explainuri,explainname,backdropuri,backdropname);
                            sendMessage(obj,teasession);
                     } else if(("ideaauditing").equals(act)) // 征求意见阶段-审核
                     {
                            boolean ideaauditing = new Boolean(teasession.getParameter("ideaauditing")).booleanValue();
                            boolean explainauditing = new Boolean(teasession.getParameter("explainauditing")).booleanValue();
                            boolean backdropauditing = new Boolean(teasession.getParameter("backdropauditing")).booleanValue();

                            String ideainformuri = null,ideainformname = null;
                            byte by[] = teasession.getBytesParameter("ideainformuri");
                            if(by != null)
                            {
                                   ideainformname = teasession.getParameter("ideainformuriName");
                                   ideainformuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"ideainformuri",obj.getIdeainformuri(),obj.getIdeainformname()); // 把历史文件保存
                            }

                            String ideainform2uri = null,ideainform2name = null;
                            by = teasession.getBytesParameter("ideainform2uri");
                            if(by != null)
                            {
                                   ideainform2name = teasession.getParameter("ideainform2uriName");
                                   ideainform2uri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"ideainform2uri",obj.getIdeainform2uri(),obj.getIdeainform2name()); // 把历史文件保存
                            }

                            String feedbackuri = null,feedbackuriname = null;
                            by = teasession.getBytesParameter("feedbackuri");
                            if(by != null)
                            {
                                   feedbackuriname = teasession.getParameter("feedbackuriName");
                                   feedbackuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"feedbackuri",obj.getFeedbackuri(),obj.getFeedbackname()); // 把历史文件保存
                            }
                            String areporturi = null,areportname = null;
                            by = teasession.getBytesParameter("reviewcomments");
                            if(by != null)
                            {
                                   areportname = teasession.getParameter("reviewcommentsName");
                                   areporturi = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"areporturi_4",obj.getAreporturi_4(),obj.getAreportname_4()); // 把历史文件保存
                            }
                            obj.set_4(ideaauditing,explainauditing,backdropauditing,ideainformuri,ideainformname,ideainform2uri,ideainform2name,feedbackuri,feedbackuriname,areporturi,areportname);

                            // 发送通知
                            String reviewcommentstext = teasession.getParameter("reviewcommentstext");
                            sendMessage2(obj,teasession,reviewcommentstext,areportname,areporturi,ideaauditing && explainauditing && backdropauditing);
                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(ideaauditing && explainauditing && backdropauditing && obj.getIdeainformuri() != null && obj.getIdeainformuri().length() > 0 && obj.getIdeainform2uri() != null && obj.getIdeainform2uri().length() > 0) // && obj.getFeedbackuri() != null && obj.getFeedbackuri().length() > 0)
                                   {
                                          obj.setStates(5);
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("formulating").equals(act)) // 送审阶段
                     {
                            String formulatinguri = null,formulatingname = null;
                            byte by[] = teasession.getBytesParameter("formulatinguri");
                            if(by != null)
                            {
                                   formulatingname = teasession.getParameter("formulatinguriName");
                                   formulatinguri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"formulatinguri",obj.getFormulatinguri(),obj.getFormulatingname()); // 把历史文件保存
                            }

                            String fexplainuri = null,fexplainname = null;
                            by = teasession.getBytesParameter("fexplainuri");
                            if(by != null)
                            {
                                   fexplainname = teasession.getParameter("fexplainuriName");
                                   fexplainuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"fexplainuri",obj.getFexplainuri(),obj.getFexplainname()); // 把历史文件保存
                            }

                            String fideauri = null,fideaname = null;
                            by = teasession.getBytesParameter("fideauri");
                            if(by != null)
                            {
                                   fideaname = teasession.getParameter("fideauriName");
                                   fideauri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"fideauri",obj.getFideauri(),obj.getFideaname()); // 把历史文件保存
                            }

                            String fbackdropuri = null,fbackdropname = null;
                            by = teasession.getBytesParameter("fbackdropuri");
                            if(by != null)
                            {
                                   fbackdropname = teasession.getParameter("fbackdropuriName");
                                   fbackdropuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"fbackdropuri",obj.getFbackdropuri(),obj.getFbackdropname()); // 把历史文件保存
                            }

                            String fsummaryuri = null,fsummaryname = null;
                            by = teasession.getBytesParameter("fsummaryuri");
                            if(by != null)
                            {
                                   fsummaryname = teasession.getParameter("fsummaryuriName");
                                   fsummaryuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"fsummaryuri",obj.getFsummaryuri(),obj.getFsummaryname()); // 把历史文件保存
                            }
                            obj.set(formulatinguri,formulatingname,fexplainuri,fexplainname,fideauri,fideaname,fbackdropuri,fbackdropname,fsummaryuri,fsummaryname);
                            sendMessage(obj,teasession);
                     } else if(("formulatingauditing").equals(act)) // 送审阶段-审核
                     {
                            boolean formulatingauditing = new Boolean(teasession.getParameter("formulatingauditing")).booleanValue();
                            boolean fexplainauditing = new Boolean(teasession.getParameter("fexplainauditing")).booleanValue();
                            boolean fideaauditing = new Boolean(teasession.getParameter("fideaauditing")).booleanValue();
                            boolean fbackdropauditing = new Boolean(teasession.getParameter("fbackdropauditing")).booleanValue();
                            boolean fsummaryauditing = new Boolean(teasession.getParameter("fsummaryauditing")).booleanValue();

                            String finformuri = null,finformname = null;
                            byte by[] = teasession.getBytesParameter("finformuri");
                            if(by != null)
                            {
                                   finformname = teasession.getParameter("finformuriName");
                                   finformuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"finformuri",obj.getFinformuri(),obj.getFinformname()); // 把历史文件保存
                            }

                            String finform2uri = null,finform2name = null;
                            by = teasession.getBytesParameter("finform2uri");
                            if(by != null)
                            {
                                   finform2name = teasession.getParameter("finform2uriName");
                                   finform2uri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"finform2uri",obj.getFinform2uri(),obj.getFinform2name()); // 把历史文件保存
                            }
                            String areporturi_5 = null,areportname_5 = null;
                            by = teasession.getBytesParameter("reviewcomments");
                            if(by != null)
                            {
                                   areportname_5 = teasession.getParameter("reviewcommentsName");
                                   areporturi_5 = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"areporturi_5",obj.getAreporturi_5(),obj.getAreportname_5()); // 把历史文件保存
                            }
                            obj.set_5(formulatingauditing,fexplainauditing,fideaauditing,fbackdropauditing,finformuri,finformname,finform2uri,finform2name,fsummaryauditing,areporturi_5,areportname_5);

                            // 发送通知
                            String reviewcommentstext = teasession.getParameter("reviewcommentstext");
                            sendMessage2(obj,teasession,reviewcommentstext,areportname_5,areporturi_5,formulatingauditing && fexplainauditing && fideaauditing && fbackdropauditing && fsummaryauditing);

                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(formulatingauditing && fexplainauditing && fideaauditing && fbackdropauditing && fsummaryauditing && obj.getFinformuri() != null && obj.getFinformuri().length() > 0)
                                   {
                                          obj.setStates(6);
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("level").equals(act)) // 报批阶段
                     {
                            String leveluri = null,levelname = null;
                            byte by[] = teasession.getBytesParameter("leveluri");
                            if(by != null)
                            {
                                   levelname = teasession.getParameter("leveluriName");
                                   leveluri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"leveluri",obj.getLeveluri(),obj.getLevelname()); // 把历史文件保存
                            }

                            String lexplainuri = null,lexplainname = null;
                            by = teasession.getBytesParameter("lexplainuri");
                            if(by != null)
                            {
                                   lexplainname = teasession.getParameter("lexplainuriName");
                                   lexplainuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lexplainuri",obj.getLexplainuri(),obj.getLexplainname()); // 把历史文件保存
                            }

                            String lbackdropuri = null,lbackdropname = null;
                            by = teasession.getBytesParameter("lbackdropuri");
                            if(by != null)
                            {
                                   lbackdropname = teasession.getParameter("lbackdropuriName");
                                   lbackdropuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lbackdropuri",obj.getLbackdropuri(),obj.getLbackdropname()); // 把历史文件保存
                            }

                            String lweaveuri = null,lweavename = null;
                            by = teasession.getBytesParameter("lweaveuri");
                            if(by != null)
                            {
                                   lweavename = teasession.getParameter("lweaveuriName");
                                   lweaveuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lweaveuri",obj.getLweaveuri(),obj.getLweavename()); // 把历史文件保存
                            }
                            obj.set_6(leveluri,levelname,lexplainuri,lexplainname,lbackdropuri,lbackdropname,lweaveuri,lweavename);
                            sendMessage(obj,teasession);
                     } else if(("levelauditing").equals(act)) // 报批阶段-审核
                     {
                            boolean levelauditing = new Boolean(teasession.getParameter("levelauditing")).booleanValue();
                            boolean lexplainauditing = new Boolean(teasession.getParameter("lexplainauditing")).booleanValue();
                            boolean lbackdropauditing = new Boolean(teasession.getParameter("lbackdropauditing")).booleanValue();
                            byte by[];
                            String lsinformuri = null,lsinformname = null;
                            by = teasession.getBytesParameter("lsinformuri");
                            if(by != null)
                            {
                                   lsinformname = teasession.getParameter("lsinformuriName");
                                   lsinformuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lsinformuri",obj.getLsinformuri(),obj.getLsinformname()); // 把历史文件保存
                            }

                            String lssummaryuri = null,lssummaryname = null;
                            by = teasession.getBytesParameter("lssummaryuri");
                            if(by != null)
                            {
                                   lssummaryname = teasession.getParameter("lssummaryuriName");
                                   lssummaryuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lssummaryuri",obj.getLssummaryuri(),obj.getLssummaryname()); // 把历史文件保存
                            }

                            String lginformuri = null,lginformname = null;
                            by = teasession.getBytesParameter("lginformuri");
                            if(by != null)
                            {
                                   lginformname = teasession.getParameter("lginformuriName");
                                   lginformuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lginformuri",obj.getLginformuri(),obj.getLginformname()); // 把历史文件保存
                            }

                            String lgsummaryuri = null,lgsummaryname = null;
                            by = teasession.getBytesParameter("lgsummaryuri");
                            if(by != null)
                            {
                                   lgsummaryname = teasession.getParameter("lgsummaryuriName");
                                   lgsummaryuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"lgsummaryuri",obj.getLgsummaryuri(),obj.getLgsummaryname()); // 把历史文件保存
                            }
                            String areporturi_6 = null,areportname_6 = null;
                            by = teasession.getBytesParameter("reviewcomments");
                            if(by != null)
                            {
                                   areportname_6 = teasession.getParameter("reviewcommentsName");
                                   areporturi_6 = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"areporturi_6",obj.getAreporturi_6(),obj.getAreportname_6()); // 把历史文件保存
                            }
                            obj.set_6(levelauditing,lexplainauditing,lbackdropauditing,lsinformuri,lsinformname,lssummaryuri,lssummaryname,lginformuri,lginformname,lgsummaryuri,lgsummaryname,areporturi_6,areportname_6);

                            // 发送通知
                            String reviewcommentstext = teasession.getParameter("reviewcommentstext");
                            sendMessage2(obj,teasession,reviewcommentstext,areportname_6,areporturi_6,levelauditing && lexplainauditing && lbackdropauditing);

                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(obj.getLssummaryuri() != null && obj.getLssummaryuri().length() > 0) // if (levelauditing && lbackdropauditing && obj.getLsinformuri() != null && obj.getLsinformuri().length() > 0 && obj.getLssummaryuri() != null && obj.getLssummaryuri().length() > 0) //&& obj.getLginformuri() != null && obj.getLginformuri().length() > 0 && obj.getLgsummaryuri() != null && obj.getLgsummaryuri().length() > 0 && obj.getLweaveuri() != null && obj.getLweaveuri().length() > 0
                                   {
                                          obj.setStates(7);
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("standard").equals(act)) // 标准阶段
                     {
                            String standarduri = null,standardname = null;
                            byte by[] = teasession.getBytesParameter("standarduri");
                            if(by != null)
                            {
                                   standardname = teasession.getParameter("standarduriName");
                                   standarduri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"standarduri",obj.getStandarduri(),obj.getStandardname()); // 把历史文件保存
                            }

                            String sweaveuri = null,sweavename = null;
                            by = teasession.getBytesParameter("sweaveuri");
                            if(by != null)
                            {
                                   sweavename = teasession.getParameter("sweaveuriName");
                                   sweaveuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"sweaveuri",obj.getSweaveuri(),obj.getSweavename()); // 把历史文件保存
                            }

                            String sbackdropuri = null,sbackdropname = null;
                            by = teasession.getBytesParameter("sbackdropuri");
                            if(by != null)
                            {
                                   sbackdropname = teasession.getParameter("sbackdropuriName");
                                   sbackdropuri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"sbackdropuri",obj.getSbackdropuri(),obj.getSbackdropname()); // 把历史文件保存
                            }
                            obj.setStandard(standarduri,standardname,sweaveuri,sweavename,sbackdropuri,sbackdropname);
                            sendMessage(obj,teasession);
                     } else if(("standardauditing").equals(act)) // 标准阶段
                     {
                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(obj.getStandarduri() != null && obj.getStandarduri().length() > 0 && obj.getSweaveuri() != null && obj.getSweaveuri().length() > 0) // && obj.getSbackdropuri() != null && obj.getSbackdropuri().length() > 0)
                                   {
                                          obj.setStates(8); // 8=完成
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("other").equals(act)) // 其它阶段
                     {
                            String otheruri = null,othername = null;
                            byte by[] = teasession.getBytesParameter("otheruri");
                            if(by != null)
                            {
                                   othername = teasession.getParameter("otheruriName");
                                   otheruri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"otheruri",obj.getOtheruri(),obj.getOthername()); // 把历史文件保存
                            }

                            String other2uri = null,other2name = null;
                            by = teasession.getBytesParameter("other2uri");
                            if(by != null)
                            {
                                   other2name = teasession.getParameter("other2uriName");
                                   other2uri = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"other2uri",obj.getOther2uri(),obj.getOther2name()); // 把历史文件保存
                            }
                            obj.setOther(otheruri,othername,other2uri,other2name);
                     } else if(("draft").equals(act)) // 起草阶段
                     {
                            String drafturi = null,draftname = null;
                            byte by[] = teasession.getBytesParameter("drafturi");
                            if(by != null)
                            {
                                   draftname = teasession.getParameter("drafturiName");
                                   drafturi = super.write(community,by,".gif");
                                   Itemfilehistory.create(item,"drafturi",obj.getDrafturi(),obj.getDraftname()); // 把历史文件保存
                            }
                            boolean draftnext = "true".equals(teasession.getParameter("draftnext"));
                            obj.setDraft(draftnext,drafturi,draftname);
                     } else if(("draftauditing").equals(act)) // 标准阶段
                     {
                            // 转下阶段
                            if(teasession.getParameter("next") != null)
                            {
                                   if(obj.isDraftnext()) // obj.getDrafturi() != null && obj.getDrafturi().length() > 0)
                                   {
                                          obj.setStates(4); // 4=征求意见
                                   } else
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("“该阶段工作未完成”,不转入下一阶段.","UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
                                          return;
                                   }
                            }
                     } else if(("egqb").equals(act)) // 对标准编制组的季报入库
                     {
                            int egqb = Integer.parseInt(teasession.getParameter("egqb"));
                            String question = teasession.getParameter("question");
                            String advice = teasession.getParameter("advice");
                            String result = teasession.getParameter("result");
                            String fileuri = null;
                            byte by[] = teasession.getBytesParameter("fileuri");
                            String filename = teasession.getParameter("fileuriName");
                            if(by != null)
                            {
                                   fileuri = super.write(community,by,".gif");
                            }
                            if(egqb == 0)
                            {
                                   Egqb.create(item,question,advice,result,fileuri,filename);
                            } else
                            {
                                   Egqb egqb_obj = Egqb.find(egqb);
                                   egqb_obj.set(item,question,advice,result,fileuri,filename);
                            }
                     } else if(("useredititem").equals(act)) // 人员管理
                     {
                            String principal = teasession.getParameter("principal");
                            String director = teasession.getParameter("director");
                            if(principal != null)
                            {
                                   obj.setPrincipal(principal);
                            }
                            if(director != null)
                            {
                                   obj.setDirector(director);
                            }
                     } else if(("useredititem2").equals(act)) // 人员变动管理
                     {
                            String items[] = request.getParameterValues("item");
                            if(items != null)
                            {
                                   for(int index = 0;index < items.length;index++)
                                   {
                                          String principal = teasession.getParameter("principal");
                                          String director = teasession.getParameter("director");
                                          Item i_obj = Item.find(Integer.parseInt(items[index]));
                                          if(principal != null)
                                          {
                                                 i_obj.setPrincipal(principal);
                                          }
                                          if(director != null)
                                          {
                                                 i_obj.setDirector(director);
                                          }
                                   }
                            }
                     } else if(("EditExpertres").equals(act)) // 专家资源
                     {
                            int expertres = Integer.parseInt(teasession.getParameter("expertres"));

                            if(teasession.getParameter("delete") != null)
                            {
                                   Expertres i_obj = Expertres.find(expertres);
                                   i_obj.delete();
                            } else
                            {
                                   String name = teasession.getParameter("name").replaceAll("\"","&quot;");
                                   String unit = teasession.getParameter("unit").replaceAll("\"","&quot;");
                                   int calling = Integer.parseInt(teasession.getParameter("calling"));
                                   String specialty = (teasession.getParameter("specialty")).replaceAll("\"","&quot;");
                                   String duty = teasession.getParameter("duty").replaceAll("\"","&quot;");
                                   String title = teasession.getParameter("title").replaceAll("\"","&quot;");
                                   String phone = teasession.getParameter("phone").replaceAll("\"","");
                                   String fax = teasession.getParameter("fax").replaceAll("\"","");
                                   String mobile = teasession.getParameter("mobile").replaceAll("\"","");
                                   String email = teasession.getParameter("email").replaceAll("\"","");
                                   String zip = teasession.getParameter("zip").replaceAll("\"","");
                                   String bookname = teasession.getParameter("bookname").replaceAll("\"","&quot;").replaceAll("\"","&quot;").replaceAll("<","&lt;");
                                   String bookconcern = teasession.getParameter("bookconcern").replaceAll("\"","&quot;");
                                   String article = teasession.getParameter("article").replaceAll("\"","&quot;");
                                   String magazine = teasession.getParameter("magazine").replaceAll("\"","&quot;");
                                   java.util.Date issuetime = tea.entity.Entity.sdf.parse(teasession.getParameter("issuetimeYear") + "-" + teasession.getParameter("issuetimeMonth") + "-" + teasession.getParameter("issuetimeDay"));
                                   java.util.Date appeartime = tea.entity.Entity.sdf.parse(teasession.getParameter("appeartimeYear") + "-" + teasession.getParameter("appeartimeMonth") + "-" + teasession.getParameter("appeartimeDay"));
                                   Date birthtime = null;
                                   try
                                   {
                                          birthtime = tea.entity.Entity.sdf.parse(teasession.getParameter("birthtime")); // tea.entity.Entity.sdf.parse(teasession.getParameter("birthtimeYear") + "-" + teasession.getParameter("birthtimeMonth") + "-" + teasession.getParameter("birthtimeDay"));
                                   } catch(ParseException ex1)
                                   {
                                          response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("出生日期,填写错误.<script>window.setInterval('window.history.back();',2000);</script>","UTF-8"));
                                          return;
                                   }
                                   String degree = teasession.getParameter("degree").replaceAll("\"","&quot;");
                                   String experience = teasession.getParameter("experience").replaceAll("\"","&quot;").replaceAll("<","&lt;");
                                   String address = teasession.getParameter("address").replaceAll("\"","&quot;");
                                   if(expertres == 0)
                                   {
                                          Expertres.create(name,unit,calling,specialty,duty,title,phone,fax,mobile,email,zip,bookname,bookconcern,issuetime,article,magazine,appeartime,birthtime,degree,experience,address);
                                   } else
                                   {
                                          Expertres i_obj = Expertres.find(expertres);
                                          i_obj.set(name,unit,calling,specialty,duty,title,phone,fax,mobile,email,zip,bookname,bookconcern,issuetime,article,magazine,appeartime,birthtime,degree,experience,address);
                                   }
                            }
                     } else if(("EditUnitres").equals(act)) // 编制单位资源
                     {
                            int unit = Integer.parseInt(teasession.getParameter("unit"));

                            if(teasession.getParameter("delete") != null)
                            {
                                   Unitres ur_obj = Unitres.find(unit);
                                   // i_obj.delete();
                            } else
                            {
                                   String address = teasession.getParameter("address");
                                   String calling = (teasession.getParameter("calling"));
                                   String specialty = (teasession.getParameter("specialty"));
                                   String product = teasession.getParameter("product");
                                   String linkmanname = teasession.getParameter("linkmanname");
                                   String job = teasession.getParameter("job");
                                   String phone = teasession.getParameter("phone");
                                   String fax = teasession.getParameter("fax");
                                   String mobile = teasession.getParameter("mobile");
                                   String email = teasession.getParameter("email");
                                   String zip = teasession.getParameter("zip");
                                   String url = teasession.getParameter("url");
                                   String have_a_project = teasession.getParameter("have_a_project");
                                   String bank = teasession.getParameter("bank");
                                   String account = teasession.getParameter("account");
                                   Unitres ur_obj = Unitres.find(unit);
                                   if(unit == 0 || !ur_obj.isExists())
                                   {
                                          Unitres.create(unit,address,calling,specialty,product,linkmanname,job,phone,fax,mobile,email,zip,url,have_a_project,bank,account);
                                   } else
                                   {
                                          ur_obj.set(address,calling,specialty,product,linkmanname,job,phone,fax,mobile,email,zip,url,have_a_project,bank,account);
                                   }
                            }
                     } else if(("EditReferenceres").equals(act)) // 参考文献
                     {
                            int referenceres = Integer.parseInt(teasession.getParameter("referenceres"));

                            if(teasession.getParameter("delete") != null)
                            {
                                   Referenceres rr_obj = Referenceres.find(referenceres);
                                   rr_obj.delete();
                            } else
                            {
                                   String name = teasession.getParameter("name");
                                   String calling = teasession.getParameter("calling");
                                   String specialty = teasession.getParameter("specialty");
                                   String publishing = teasession.getParameter("publishing");
                                   String author = teasession.getParameter("author");
                                   String derivation = teasession.getParameter("derivation");
                                   java.util.Date time = tea.entity.Entity.sdf.parse(teasession.getParameter("timeYear") + "-" + teasession.getParameter("timeMonth") + "-" + teasession.getParameter("timeDay"));

                                   if(referenceres == 0)
                                   {
                                          Referenceres.create(name,publishing,time,author,calling,specialty,derivation);
                                   } else
                                   {
                                          Referenceres rr_obj = Referenceres.find(referenceres);
                                          rr_obj.set(name,publishing,time,author,calling,specialty,derivation);
                                   }
                            }
                     } else if(("DownArchiveItems").equals(act)) // 打包下载-存档管理
                     {
                            java.io.File dir = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode()));
                            if(dir.exists())
                            {
                                   response.setContentType("application/x-msdownload");
                                   response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode("(" + obj.getCode() + ")" + obj.getName() + ".zip","UTF-8"));
                                   java.io.OutputStream os = response.getOutputStream();
                                   org.apache.tools.zip.ZipOutputStream zos = new org.apache.tools.zip.ZipOutputStream(os);
                                   try
                                   {
                                          compress(zos,dir,"");
                                   } catch(java.net.SocketException ex)
                                   {
                                          System.out.println("没有下载完,点取消了.");
                                   }
                                   zos.close();
                                   os.close();
                            }
                            return;
                     } else if(("EditArchiveItems").equals(act)) // 存档管理
                     {
                            java.io.File file,file2;
                            java.util.Enumeration enumer;
                            if(obj.getOpenuri() != null && obj.getOpenuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getOpenuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[3] + "/" + obj.getOpenname()));
                                   copy(file,file2);
                            }
                            if(obj.getSummaryuri() != null && obj.getSummaryuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getSummaryuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[3] + "/" + obj.getSummaryname()));
                                   copy(file,file2);
                            }
                            if(obj.getInformuri() != null && obj.getInformuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getInformuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[3] + "/" + obj.getInformname()));
                                   copy(file,file2);
                            }
                            if(obj.getIdeauri() != null && obj.getIdeauri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getIdeauri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getIdeaname()));
                                   copy(file,file2);
                            }
                            if(obj.getExplainuri() != null && obj.getExplainuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getExplainuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getExplainname()));
                                   copy(file,file2);
                            }
                            if(obj.getBackdropuri() != null && obj.getBackdropuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getBackdropuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getBackdropname()));
                                   copy(file,file2);
                            }
                            if(obj.getIdeainformuri() != null && obj.getIdeainformuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getIdeainformuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getIdeainformname()));
                                   copy(file,file2);
                            }
                            if(obj.getIdeainform2uri() != null && obj.getIdeainform2uri().length() > 0)
                            {
                                   // ideainform2name
                                   file = new java.io.File(applicatin.getRealPath(obj.getIdeainform2uri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getIdeainform2name()));
                                   copy(file,file2);
                            }

                            if(obj.getFeedbackuri() != null && obj.getFeedbackuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFeedbackuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getFeedbackname()));
                                   copy(file,file2);
                            }
                            if(obj.getFormulatinguri() != null && obj.getFormulatinguri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFormulatinguri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFormulatingname()));
                                   copy(file,file2);
                            }
                            if(obj.getFexplainuri() != null && obj.getFexplainuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFexplainuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFexplainname()));
                                   copy(file,file2);
                            }
                            if(obj.getFideauri() != null && obj.getFideauri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFideauri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFideaname()));
                                   copy(file,file2);
                            }
                            if(obj.getFbackdropuri() != null && obj.getFbackdropuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFbackdropuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFbackdropname()));
                                   copy(file,file2);
                            }
                            if(obj.getFinformuri() != null && obj.getFinformuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFinformuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFinformname()));
                                   copy(file,file2);
                            }
                            if(obj.getFsummaryuri() != null && obj.getFsummaryuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getFsummaryuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFsummaryname()));
                                   copy(file,file2);
                            }
                            if(obj.getLeveluri() != null && obj.getLeveluri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLeveluri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLevelname()));
                                   copy(file,file2);
                            }
                            if(obj.getLexplainuri() != null && obj.getLexplainuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLexplainuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLexplainname()));
                                   copy(file,file2);
                            }
                            if(obj.getLbackdropuri() != null && obj.getLbackdropuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLbackdropuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLbackdropname()));
                                   copy(file,file2);
                            }
                            if(obj.getLweaveuri() != null && obj.getLweaveuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLweaveuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLweavename()));
                                   copy(file,file2);
                            }
                            if(obj.getLsinformuri() != null && obj.getLsinformuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLsinformuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLsinformname()));
                                   copy(file,file2);
                            }
                            if(obj.getLssummaryuri() != null && obj.getLssummaryuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLssummaryuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLssummaryname()));
                                   copy(file,file2);
                            }
                            if(obj.getLginformuri() != null && obj.getLginformuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLginformuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLginformname()));
                                   copy(file,file2);
                            }
                            if(obj.getLgsummaryuri() != null && obj.getLgsummaryuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getLgsummaryuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getLgsummaryname()));
                                   copy(file,file2);
                            }
                            if(obj.getStandarduri() != null && obj.getStandarduri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getStandarduri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[7] + "/" + obj.getStandardname()));
                                   copy(file,file2);
                            }
                            if(obj.getSweaveuri() != null && obj.getSweaveuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getSweaveuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[7] + "/" + obj.getSweavename()));
                                   copy(file,file2);
                            }
                            if(obj.getSbackdropuri() != null && obj.getSbackdropuri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getSbackdropuri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[7] + "/" + obj.getSbackdropname()));
                                   copy(file,file2);
                            }
                            if(obj.getOtheruri() != null && obj.getOtheruri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getOtheruri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/其它阶段/" + obj.getOthername()));
                                   copy(file,file2);
                            }
                            if(obj.getOther2uri() != null && obj.getOther2uri().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getOther2uri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/其它阶段/" + obj.getOther2name()));
                                   copy(file,file2);
                            }
                            enumer = Itemfilehistory.find(item,"drafturi");
                            while(enumer.hasMoreElements())
                            {
                                   int itemfilehistory = ((Integer) enumer.nextElement()).intValue();
                                   Itemfilehistory history = Itemfilehistory.find(itemfilehistory);
                                   file = new java.io.File(applicatin.getRealPath(history.getUri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[10] + "/" + history.getName()));
                                   copy(file,file2);
                            }
                            if(obj.getDrafturi() != null && obj.getDrafturi().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getDrafturi()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[10] + "/" + obj.getDraftname()));
                                   copy(file,file2);
                            }

                            if(obj.getFinform2uri() != null && obj.getFinform2uri().length() > 0)
                            {
                                   // finform2name
                                   file = new java.io.File(applicatin.getRealPath(obj.getFinform2uri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getFinform2name()));
                                   copy(file,file2);
                            }
                            if(obj.getPlantask() != null && obj.getPlantask().length() > 0)
                            {
                                   // plantaskname
                                   file = new java.io.File(applicatin.getRealPath(obj.getPlantask()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[1] + "/" + obj.getPlantaskname()));
                                   copy(file,file2);
                            }
                            enumer = Itemfilehistory.find(item,"areporturi_3");
                            while(enumer.hasMoreElements())
                            {
                                   int itemfilehistory = ((Integer) enumer.nextElement()).intValue();
                                   Itemfilehistory history = Itemfilehistory.find(itemfilehistory);
                                   file = new java.io.File(applicatin.getRealPath(history.getUri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[3] + "/" + history.getName()));
                                   copy(file,file2);
                            }
                            if(obj.getAreporturi_3() != null && obj.getAreporturi_3().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getAreporturi_3()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[3] + "/" + obj.getAreportname_3()));
                                   copy(file,file2);
                            }

                            enumer = Itemfilehistory.find(item,"areporturi_4");
                            while(enumer.hasMoreElements())
                            {
                                   int itemfilehistory = ((Integer) enumer.nextElement()).intValue();
                                   Itemfilehistory history = Itemfilehistory.find(itemfilehistory);
                                   file = new java.io.File(applicatin.getRealPath(history.getUri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + history.getName()));
                                   copy(file,file2);
                            }
                            if(obj.getAreporturi_4() != null && obj.getAreporturi_4().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getAreporturi_4()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[4] + "/" + obj.getAreportname_4()));
                                   copy(file,file2);
                            }

                            enumer = Itemfilehistory.find(item,"areporturi_5");
                            while(enumer.hasMoreElements())
                            {
                                   int itemfilehistory = ((Integer) enumer.nextElement()).intValue();
                                   Itemfilehistory history = Itemfilehistory.find(itemfilehistory);
                                   file = new java.io.File(applicatin.getRealPath(history.getUri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + history.getName()));
                                   copy(file,file2);
                            }
                            if(obj.getAreporturi_5() != null && obj.getAreporturi_5().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getAreporturi_5()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[5] + "/" + obj.getAreportname_5()));
                                   copy(file,file2);
                            }

                            enumer = Itemfilehistory.find(item,"areporturi_6");
                            while(enumer.hasMoreElements())
                            {
                                   int itemfilehistory = ((Integer) enumer.nextElement()).intValue();
                                   Itemfilehistory history = Itemfilehistory.find(itemfilehistory);
                                   file = new java.io.File(applicatin.getRealPath(history.getUri()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + history.getName()));
                                   copy(file,file2);
                            }
                            if(obj.getAreporturi_6() != null && obj.getAreporturi_6().length() > 0)
                            {
                                   file = new java.io.File(applicatin.getRealPath(obj.getAreporturi_6()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/" + Item.STATES_TYPE[6] + "/" + obj.getAreportname_6()));
                                   copy(file,file2);
                            }
                            // 经费申请表
                            enumer = ItemBudget.find(community," AND i.item=" + item + " AND DATALENGTH(ib.outlayapp)>0",0,Integer.MAX_VALUE);
                            while(enumer.hasMoreElements())
                            {
                                   int ib_id = ((Integer) enumer.nextElement()).intValue();
                                   ItemBudget ib_obj = ItemBudget.find(ib_id);
                                   file = new java.io.File(applicatin.getRealPath(ib_obj.getOutlayapp()));
                                   file2 = new java.io.File(applicatin.getRealPath("/item/" + obj.getCode() + "/其它阶段/" + ib_obj.getOutlayappname()));
                                   copy(file,file2);
                            }
                     } else if(("InitEditItem").equals(act)) // 项目初始化
                     {
                            int states = Integer.parseInt(teasession.getParameter("states"));
                            String name = teasession.getParameter("name");
                            int planyear = Integer.parseInt(teasession.getParameter("planyear"));
                            String principal = teasession.getParameter("principal");
                            String content = teasession.getParameter("content");
                            byte by[] = teasession.getBytesParameter("plantask");
                            String plantask;
                            String plantaskname;
                            if(by != null)
                            {
                                   plantaskname = teasession.getParameter("plantaskName");
                                   plantask = write(community,by,".gif"); // write("/tea/image/type/" + community + "/", by, plantaskname.substring(plantaskname.lastIndexOf("."))); //super.
                                   Itemfilehistory.create(item,"plantask",obj.getPlantask(),obj.getPlantaskname()); // 把历史文件保存
                            } else
                            {
                                   plantask = obj.getPlantask();
                                   plantaskname = obj.getPlantaskname();
                            }
                            obj.setInit(name,states,content,planyear,principal,plantask,plantaskname);
                     } else if(("ItemClear").equals(act)) // 项目清空
                     {
                            if(teasession.getParameter("Item") != null)
                            {
                                   Item.clear(community);
                            }
                            if(teasession.getParameter("ItemBudget") != null)
                            {
                                   ItemBudget.clear(community);
                            }
                            if(teasession.getParameter("Itemoutlay") != null)
                            {
                                   Itemoutlay.clear(community);
                            }
                            if(teasession.getParameter("Outlay") != null)
                            {
                                   Outlay.clear(community);
                            }

                     } else if(("BudgetEditItem").equals(act)) // 项目经费预算
                     {
                            int budgetyear = 2006;
                            int itembudget = Integer.parseInt(teasession.getParameter("itembudget"));
                            boolean budgettype = "true".equals(teasession.getParameter("budgettype"));

                            String _strBudgetyear = teasession.getParameter("budgetyear");
                            if(_strBudgetyear != null)
                            {
                                   budgetyear = Integer.parseInt(_strBudgetyear);
                            }
                            byte by[] = teasession.getBytesParameter("outlayapp");
                            String outlayapp = null;
                            String outlayappname = null;
                            if(by != null)
                            {
                                   outlayappname = teasession.getParameter("outlayappName");
                                   outlayapp = write(community,by,".gif");
                            }
                            java.math.BigDecimal budgetoutlay = new java.math.BigDecimal(teasession.getParameter("budgetoutlay"));

                            if(itembudget == 0)
                            {
                                   if(!budgettype)
                                   {
                                          if(ItemBudget.find(item,budgetyear) != 0)
                                          {
                                                 response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("项目年度经费是,每年只能操作一次.","UTF-8")); // 如果编辑,单击<A href="+request.getContextPath()+"/jsp/criterion/BudgetEditItem.jsp?item="+item+"&community="+community+"&itembudget="+itembudget+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+" >这里</A>.
                                                 return;
                                          }
                                   }
                                   ItemBudget.create(item,budgettype,budgetyear,budgetoutlay,outlayapp,outlayappname);
                            } else
                            {
                                   ItemBudget lb_obj = ItemBudget.find(itembudget);
                                   if(by == null)
                                   {
                                          outlayapp = lb_obj.getOutlayapp();
                                          outlayappname = lb_obj.getOutlayappname();
                                   }
                                   lb_obj.set(item,budgettype,budgetyear,budgetoutlay,outlayapp,outlayappname);
                            }
                     } else if(("docdeleteitem").equals(act)) // 项目文档
                     {
                            String ids[] = request.getParameterValues("itemfilehistory");
                            if(ids != null)
                            {
                                   for(int i = 0;i < ids.length;i++)
                                   {
                                          Itemfilehistory history = Itemfilehistory.find(Integer.parseInt(ids[i]));
                                          history.delete();
                                   }
                            }
                            String doc_act = request.getParameter("doc_act");
                            if(doc_act != null)
                            {
                                   if("drafturi".equals(doc_act))
                                   { // 把最后一次的历史文档改为当前文档
                                          String name = "",uri = "";
                                          int ih_id = Itemfilehistory.findLast(item,doc_act);
                                          if(ih_id > 0)
                                          {
                                                 Itemfilehistory ih_obj = Itemfilehistory.find(ih_id);
                                                 name = ih_obj.getName();
                                                 uri = ih_obj.getUri();
                                                 ih_obj.delete();
                                          }
                                          obj.setDraft(obj.isDraftnext(),uri,name);
                                   }
                            }
                     }
                     response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8"));
              } catch(Exception e)
              {
                     e.printStackTrace();
              }
       }

       public static void compress(org.apache.tools.zip.ZipOutputStream zos,java.io.File file,String context) throws java.io.IOException
       {
              if(file.isFile())
              {
                     byte by[] = new byte[(int) file.length()];
                     java.io.FileInputStream is = new java.io.FileInputStream(file);
                     is.read(by);
                     is.close();

                     org.apache.tools.zip.ZipEntry ze = new org.apache.tools.zip.ZipEntry(context + file.getName());
                     zos.putNextEntry(ze);
                     zos.write(by);
                     zos.closeEntry();
              } else if(file.isDirectory())
              {
                     zos.putNextEntry(new org.apache.tools.zip.ZipEntry(context + file.getName() + "/"));
                     zos.closeEntry();
                     java.io.File files[] = file.listFiles();
                     if(files != null)
                     {
                            for(int index = 0;index < files.length;index++)
                            {
                                   compress(zos,files[index],context + file.getName() + "/");
                            }
                     }
              }
       }

       public void copy(File file,File file2) throws FileNotFoundException,IOException
       {
              if(file.isFile())
              {
                     if(file2.exists())
                     {
                            file2 = file2.createTempFile("(00",")" + file2.getName(),file2.getParentFile());
                     } else if(!file2.getParentFile().exists())
                     {
                            file2.getParentFile().mkdirs();
                     }
                     java.io.FileInputStream fis = new FileInputStream(file);
                     java.io.FileOutputStream fos = new java.io.FileOutputStream(file2);
                     int value = 0;
                     while((value = fis.read()) != -1)
                     {
                            fos.write(value);
                     }
                     fis.close();
                     fos.close();
              }
       }

       public String getEx(String name)
       {
              int index = name.lastIndexOf(".");
              if(index != -1)
              {
                     return name.substring(index);
              } else
              {
                     return ".doc";
              }
       }

       // 编辑组上传之后,
       public void sendMessage(Item obj,TeaSession teasession) throws SQLException
       {
              // 发消息通知
              String subject = obj.getName() + "的" + Item.STATES_TYPE[obj.getStates()] + "报告已上传.";
              String content = "";
              String to = obj.getPrincipal() + "," + obj.getDirector();
              int k = Message.create(teasession._strCommunity,teasession._rv._strV,to,teasession._nLanguage,subject,content);
              try
              {
                     tea.service.Robot.activateRoboty(obj.getCommunity(),k);
              } catch(Exception _ex)
              {
              }
       }

       // 管理员审核以后
       public void sendMessage2(Item obj,TeaSession teasession,String content,String filename,String filepath,boolean boo) throws SQLException
       {
              // 发消息通知
              String subject;
              if(boo)
              {
                     subject = obj.getName() + "的" + Item.STATES_TYPE[obj.getStates()] + "报告审核已通过.";
              } else
              {
                     subject = obj.getName() + "的" + Item.STATES_TYPE[obj.getStates()] + "需修改,请重新上报.";
              }
              StringBuilder to = new StringBuilder(obj.getPrincipal());
              java.util.Enumeration enumer = AdminUsrRole.findByUnit(obj.getEditgroup(),obj.getCommunity());
              while(enumer.hasMoreElements())
              {
                     String member = (String) enumer.nextElement();
                     to.append(member).append("/");
              }
              if(to.length() > 0)
              {
                     int k = Message.create(teasession._strCommunity,teasession._rv._strV,to.toString(),teasession._nLanguage,subject,content);
                     if(filepath != null)
                     {
                            Message m = Message.find(k);
                            m.createAttachment(1,filename,filepath);
                     }
                     try
                     {
                            tea.service.Robot.activateRoboty(obj.getCommunity(),k);
                     } catch(Exception _ex)
                     {
                     }
              }
       }

       // Clean up resources
       public void destroy()
       {
       }
}
