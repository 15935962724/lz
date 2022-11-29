<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Map<Integer,Float> map=ReplyMoney.find1(" and status =1 and statusmember in(0,1) group by hid ");

for (Map.Entry<Integer, Float> entry : map.entrySet()) {  
	  
    int hid=entry.getKey();
    float replyprice=entry.getValue();
    //根据当前医院查询应收账款
    ShopHospital hospital=ShopHospital.find(hid);
    double oldnoreply=hospital.getOldnoreply();//应收账款
    Date timespot2=hospital.getTimespot2();//医院的日期节点
    if(oldnoreply>0&&timespot2!=null){
    	//应收账款减去回款
    	double cha=oldnoreply-replyprice;
    	if(cha>0){
    		hospital.setOldnoreply(cha);
    		hospital.set();
    		//增加医院应收账款的改变记录
			SetDataRecord srecord=new SetDataRecord(0);
			srecord.setIsback(4);//减少应收账款
			srecord.setNoreply(cha);//应收账款
			srecord.setMember(h.member);
			srecord.setCreatedate(new Date());
			srecord.setStatus(1);//回款改变
			srecord.setReplymoney((double)replyprice);
			srecord.setHospitalid(hospital.getId());
			srecord.setNoinvoice(-1);
			srecord.setIsinvoice(-1);
			srecord.set();
    		
    	}else if(cha<0){
			double remainmoney=replyprice-oldnoreply;//回款减去应收账款
			//改变医院的应收账款
			hospital.setOldnoreply(0.0);
			hospital.set();
			//增加医院应收账款的改变记录
			SetDataRecord srecord=new SetDataRecord(0);
			srecord.setIsback(4);//减少应收账款
			srecord.setNoreply(0.0);//应收账款
			srecord.setMember(h.member);//创建人
			srecord.setCreatedate(new Date());
			srecord.setStatus(1);//回款改变
			srecord.setReplymoney((double)replyprice);//回款金额
			srecord.setRemainmoney(remainmoney);
			srecord.setHospitalid(hospital.getId());//医院id
			srecord.setNoinvoice(-1);
			srecord.setIsinvoice(-1);
			srecord.set();
			//减去应收账款的回款
			RemainReplyMoney remain=new RemainReplyMoney(0);
			remain.setHid(hospital.getId());
			remain.setAmount((float)remainmoney);
			remain.setType(0);
			remain.setStatusmember(0);
			remain.setTime(new Date());
			remain.setMember(h.member);
			String code="";
			List<ReplyMoney> lstreply=ReplyMoney.find(" and hid = "+hospital.getId(), 0, 1);
			if(lstreply.size()>0){
				ReplyMoney rm=lstreply.get(0);
				code=rm.getCode();
			}
			remain.setCode(code);
			//根据医院id获取服务商
			List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hospital.getId()+"|%"), 0, 1);//一个医院只有一个服务商
    		if(lstpro.size()>0){
        		Profile profile=lstpro.get(0);
        		remain.setProfile(profile.profile);
    		}
    		remain.set();
			
		}else if(cha==0){
			double remainmoney=0;//回款减去应收账款
			//改变医院的应收账款
			hospital.setOldnoreply(0.0);
			hospital.set();
			//增加医院应收账款的改变记录
			SetDataRecord srecord=new SetDataRecord(0);
			srecord.setIsback(4);//减少应收账款
			srecord.setNoreply(0.0);//应收账款
			srecord.setMember(h.member);//创建人
			srecord.setCreatedate(new Date());
			srecord.setStatus(1);//回款改变
			srecord.setReplymoney((double)replyprice);//回款金额
			srecord.setRemainmoney(0.0);
			srecord.setHospitalid(hospital.getId());//医院id
			srecord.setNoinvoice(-1);
			srecord.setIsinvoice(-1);
			srecord.set();
		}
    }else if(oldnoreply==0){
		//应收账款为0
		//直接把回款的记录写入remainreplymoney中
		RemainReplyMoney remain=new RemainReplyMoney(0);
		remain.setHid(hospital.getId());
		remain.setAmount(replyprice);
		remain.setType(0);
		remain.setStatusmember(0);
		remain.setTime(new Date());
		remain.setMember(h.member);
		remain.setReplyTime(new Date());
		String code="";
		List<ReplyMoney> lstreply=ReplyMoney.find(" and hid = "+hospital.getId(), 0, 1);
		if(lstreply.size()>0){
			ReplyMoney rm=lstreply.get(0);
			code=rm.getCode();
		}
		remain.setCode(code);
		//根据医院id获取服务商
		List<Profile> lstpro=Profile.find1(" and hospitals like "+Database.cite("%|"+hospital.getId()+"|%"), 0, 1);//一个医院只有一个服务商
		if(lstpro.size()>0){
    		Profile profile=lstpro.get(0);
    		remain.setProfile(profile.profile);
		}
		remain.set();
	}
  
}  




%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>

<style type="text/css">
.newTable tr:hover{background:#fff !important;}
</style>
</head>
<body>

</body>
</html>
