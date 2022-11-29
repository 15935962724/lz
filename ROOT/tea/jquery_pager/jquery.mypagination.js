$.fn.mypagination = function(totalProperty,opts){
	opts = $.extend({
		perPage:30, 
		callback:function(){
		}
	},opts||{});
		
	return this.each(function(){
		function numPages(){
			return Math.ceil(totalProperty/opts.perPage);
		} 
		
		function selectPage(page){
			return function(){
				currPage = page;
				if (page<0) currPage = 0;
				if (page>=numPages()) currPage = numPages()-1;
				render(); 
				$('img.page-wait',panel).attr('src','/tea/jquery_pager/images/wait.gif');
				opts.callback(currPage+1);
				$('img.page-wait',panel).attr('src','/tea/jquery_pager/images/nowait.gif');
			}
		}
		
		function render(){ 
			var html = '<table><tbody><tr>' 
				+'<td><a href="#"><img class="page-first"></a></td>'
				+'<td><a href="#"><img class="page-prev"></a></td>'
				+'<td><span>第<input type="text" class="page-num">页/共'+numPages()+'页</span></td>'
				+'<td><a href="#"><img class="page-next"></a></td>'
				+'<td><a href="#"><img class="page-last"></a></td>'
				+'<td><img src="/tea/jquery_pager/images/nowait.gif" class="page-wait"></td>'
				//+'<td><span style="padding-left:50px;">检索到'+totalProperty+'记录</span></td>'
				+'</tr></tbody></table>';
			var imgFirst = '/tea/jquery_pager/images/page-first-disabled.gif';
			var imgPrev = '/tea/jquery_pager/images/page-prev-disabled.gif';
			var imgNext = '/tea/jquery_pager/images/page-next-disabled.gif';
			var imgLast = '/tea/jquery_pager/images/page-last-disabled.gif';
			if (currPage > 0){
				imgFirst = '/tea/jquery_pager/images/page-first.gif';
				imgPrev = '/tea/jquery_pager/images/page-prev.gif';
			}
			if (currPage < numPages()-1){
				imgNext = '/tea/jquery_pager/images/page-next.gif';
				imgLast = '/tea/jquery_pager/images/page-last.gif';
			}
			panel.empty();
			panel.append(html);
			$('img.page-first',panel)
				.bind('click',selectPage(0))
				.attr('src',imgFirst);	
			$('img.page-prev',panel)
				.bind('click',selectPage(currPage-1))
				.attr('src',imgPrev);	
			$('img.page-next',panel)
				.bind('click',selectPage(currPage+1))
				.attr('src',imgNext);	
			$('img.page-last',panel)
				.bind('click',selectPage(numPages()-1))
				.attr('src',imgLast);
			$('input.page-num',panel)
				.val(currPage+1)
				.change(function(){
					selectPage($(this).val()-1)();
				});
		}
		
		var currPage = 0;
		var panel = $(this);
		render(); 
	});
}