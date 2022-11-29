package tea.ui.node.type.weatherIndex;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


public class WeatherIndexs extends TeaServlet {

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
//		Http h=new Http(request);
		TeaSession teasession=new TeaSession(request);

		try{
		AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);
		if(am.getPurview()==0 || am.getPurview()==4)
		{
			response.sendRedirect("/servlet/StartLogin?community=" + teasession._strCommunity);
			return;
		}
//		teasession.getParameter(name)
		String act=teasession.getParameter("act"),url=teasession.getParameter("nexturl"),subject=teasession.getParameter("subject");
		if("edit".equals(act)){

            boolean isnew=false;
            Node node=Node.find(teasession._nNode);
            if(node.getType()==1){
            	int sequence=Node.getMaxSequence(teasession._nNode)+10;
            	long options=node.getOptions();
            	int options1=node.getOptions1();
            	String accessmembersnode=node.getAccessmembersnode();
            	String community=node.getCommunity();

            	int language=teasession._nLanguage;
            	Category c=Category.find(teasession._nNode);
            	teasession._nNode = Node.create(teasession._nNode,sequence,community,new RV(Profile.find(teasession._rv._strR).getMember()),c.getCategory(),(options1 & 2) != 0,options,options1,language,new Date(),null,new java.util.Date(),node.getStyle(),node.getRoot(),node.getKstyle(),node.getKroot(),null,teasession._nLanguage,subject,"","","",null,"",0,null,"","","","","",null);
            	Node n=Node.find(teasession._nNode);
            	node.set("accessmembersnode",String.valueOf(node.accessmembersnode=accessmembersnode));
            	isnew=true;

            	Category cate=Category.find(n.getFather());
            	 int perm = 4; //默认是审核通过

                 node.set("audits",String.valueOf(node.audits=perm));

                 if(perm == 4)
                 {
                     node.setHidden(false);
                 } else
                 {
                     node.setHidden(true);
                 }


            }else{
            	node.setUpdatetime(new Date());
            	node.setSubject(subject, teasession._nLanguage);
                 Logs.create(node.getCommunity(),teasession._rv,2,teasession._nNode,"");
            }
            WeatherIndex wi=WeatherIndex.find(teasession._nNode);
            for(int i=0;i<WeatherIndex.WI.length;i++){
            	String wii=WeatherIndex.WI[i];
            	String wis="null";
            	if(teasession.getParameter(wii)!=null){
            		wis=teasession.getParameter(wii);
            	}
            	if("null".equals(wis)){
            		String indexName="";
            		if(teasession.getParameter(wii+"_indexName")!=null){
            			indexName=teasession.getParameter(wii+"_indexName");
                	}
            		String content="";
            		if(teasession.getParameter(wii+"_content")!=null){
            			content=teasession.getParameter(wii+"_content");
                	}
            		int indx=WindexValue.getMaxIndex(wii, " and `index`>100");
            		if(indx==0){
            			indx=101;
            		}else{
            			if(wi.getValue(wii)!=null){
            				int wiid=Integer.parseInt(wi.getValue(wii));
            				WindexValue wv=WindexValue.find(wii, wiid);
            				if(wv.isExist()){
            					indx=wiid;
            				}else{
                    			indx=indx+1;
            				}
            			}else{
                			indx=indx+1;
            			}
            		}
            		WindexValue.set(wii, indx, indexName, "", "", content);
            		wis=indx+"";
            	}
            	wi.setValue(wii, wis);
            }
            wi.setNode(teasession._nNode);
            wi.set();
            delete(node);
            node.finished(teasession._nNode);
            if(url!=null&&url.trim().length()>0){
            	response.sendRedirect(url);
            	return;
            }else{
            	response.sendRedirect("/html/"+teasession._strCommunity+"/weatherindex/"+teasession._nNode+"-"+teasession._nLanguage+".htm");
            	return;
            }


			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
