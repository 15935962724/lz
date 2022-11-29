var lms={};


lms.org=function(a)
{
  var op=a.form.agent.options;
  while(op.length>1)op[1]=null;
  if(a.value=='')return;
  mt.send("/LmsOrgs.do?act=json&father="+a.value,function(d)
  {
    eval("d="+d.substring(d.indexOf('\n')+1));
    for(var i=0;i<d.length;i++)
    {
      op[i+1]=new Option(d[i].orgname,d[i].id);
    }
  });
};


lms.course=function(a,b)
{
  var op=b.options;
  while(op.length>0)op[0]=null;
  for(var i=0;i<COURSE.length;i++)
  {
    var t=COURSE[i];
	if(t.status!=1||t.lmscert!=a.value)continue;
	op[op.length]=new Option(t.name,t.id);
  }
};
