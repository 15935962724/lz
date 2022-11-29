/**
 * FancyUpload - Flash meets Ajax for powerful and elegant uploads.
 *
 * Updated to latest 3.0 API. Hopefully 100% compat!
 *
 * @version		3.0
 *
 * @license		MIT License
 *
 * @author		Harald Kirschner <http://digitarald.de>
 * @copyright	Authors
 */


var i_ok=0,i_count=0,i_size=0,i_rate=0;

var FancyUpload2 = new Class({

	Extends: Swiff.Uploader,

	options: {
		queued: 1,
		// compat
		limitSize: 0,
		limitFiles: 0,
		validateFile: $lambda(true)
	},

	initialize: function(status, list, options) {
		this.status = $(status);
		this.list = $(list);

		// compat
		options.fileClass = options.fileClass || FancyUpload2.File;
		options.fileSizeMax = options.limitSize || options.fileSizeMax;
		options.fileListMax = options.limitFiles || options.fileListMax;

		this.parent(options);

		this.addEvents({
			'load': this.render,
			'select': this.onSelect,
			'cancel': this.onCancel,
			'start': this.onStart,
			'queue': this.onQueue,
			'complete': this.onComplete
		});
	},

	render: function() {
		this.overallTitle = this.status.getElement('.overall-title');
		this.currentTitle = this.status.getElement('.current-title');
		this.currentText = this.status.getElement('.current-text');

		var progress = this.status.getElement('.overall-progress');
		this.overallProgress = new Fx.ProgressBar(progress, {
			text: new Element('span', {'class': 'progress-text'}).inject(progress, 'after')
		});
		progress = this.status.getElement('.current-progress')
		this.currentProgress = new Fx.ProgressBar(progress, {
			text: new Element('span', {'class': 'progress-text'}).inject(progress, 'after')
		});

		this.updateOverall();
	},

	onSelect: function() {
		this.status.removeClass('status-browsing');
	},

	onCancel: function() {
		this.status.removeClass('file-browsing');
	},

	onStart: function() {
		this.status.addClass('file-uploading');
		this.overallProgress.set(0);
	},

	onQueue: function() {
		this.updateOverall();
	},

	onComplete: function() {
		this.status.removeClass('file-uploading');
		if (this.size) {
			this.overallProgress.start(100);
		} else {
			this.overallProgress.set(0);
			this.currentProgress.set(0);
		}

	},

	updateOverall: function() {
		this.overallTitle.set('html', MooTools.lang.get('FancyUpload', 'progressOverall').substitute({
			total: Swiff.Uploader.formatUnit(this.size, 'b')
		}));
		if (!this.size) {
			this.currentTitle.set('html', MooTools.lang.get('FancyUpload', 'currentTitle'));
			this.currentText.set('html', '');
		}
	},

	/**
	 * compat
	 */
	upload: function() {
		this.start();
	},

	removeFile: function() {
		return this.remove();
	}

});

FancyUpload2.File = new Class({

	Extends: Swiff.Uploader.File,

	render: function() {
		if (this.invalid) {
			if (this.validationError) {
				var msg = MooTools.lang.get('FancyUpload', 'validationErrors')[this.validationError] || this.validationError;
				this.validationErrorMessage = msg.substitute({
					name: this.name,
					size: Swiff.Uploader.formatUnit(this.size, 'b'),
					fileSizeMin: Swiff.Uploader.formatUnit(this.base.options.fileSizeMin || 0, 'b'),
					fileSizeMax: Swiff.Uploader.formatUnit(this.base.options.fileSizeMax || 0, 'b'),
					fileListMax: this.base.options.fileListMax || 0,
					fileListSizeMax: Swiff.Uploader.formatUnit(this.base.options.fileListSizeMax || 0, 'b')
				});
			}
			this.remove();
			return;
		}

		this.addEvents({
			'start': this.onStart,
			'progress': this.onProgress,
			'complete': this.onComplete,
			'error': this.onError,
			'remove': this.onRemove
		});

		this.info = new Element('span', {'class': 'file-info'});
		this.element = new Element('li', {'class': 'file'}).adopt(
			new Element('span', {'class': 'file-size', 'html': Swiff.Uploader.formatUnit(this.size, 'b')}),
			new Element('a', {
				'class': 'file-remove',
				href: '#',
				html: MooTools.lang.get('FancyUpload', 'remove'),
				title: MooTools.lang.get('FancyUpload', 'removeTitle'),
				events: {
					click: function() {
						this.remove();
						return false;
					}.bind(this)
				}
			}),
			new Element('span', {'class': 'file-name', 'html': MooTools.lang.get('FancyUpload', 'fileName').substitute(this)}),
			this.info
		).inject(this.base.list);
	},

	validate: function() {
		return (this.parent() && this.base.options.validateFile(this));
	},

	onStart: function()
	{
	   if(i_ok==0)
	   {
	     i_count=this.base.list.childNodes.length;
	     mt.show(null,0);
	   }
       $('dialog_header').innerHTML="正在上传："+this.name+"　"+i_ok+"/"+i_count;

		this.element.addClass('file-uploading');
		this.base.currentProgress.cancel().set(0);
		this.base.currentTitle.set('html', MooTools.lang.get('FancyUpload', 'currentFile').substitute(this));
	},

	onProgress: function()
	{
	  i_rate=this.progress.rate||i_rate;
	  var c='';//'上传速度：'+mt.f(i_rate/1024,2)+"K";//不知道为什么总是0
	  c+='　当前进度：'+this.progress.percentLoaded+'%';
	  c+='　已传大小：'+mt.f(i_size/1024,2)+"K";
	  mt.progress(this.base.percentLoaded,100,c);
	  i_size+=this.progress.bytesLoaded;

		this.base.overallProgress.start(this.base.percentLoaded);
		this.base.currentText.set('html', MooTools.lang.get('FancyUpload', 'currentProgress').substitute({
			rate: (this.progress.rate) ? Swiff.Uploader.formatUnit(this.progress.rate, 'bps') : '- B',
			bytesLoaded: Swiff.Uploader.formatUnit(this.progress.bytesLoaded, 'b'),
			timeRemaining: (this.progress.timeRemaining) ? Swiff.Uploader.formatUnit(this.progress.timeRemaining, 's') : '-'
		}));
		this.base.currentProgress.start(this.progress.percentLoaded);
	},

	onComplete: function()
	{
		this.element.removeClass('file-uploading');

		this.base.currentText.set('html', 'Upload completed');
		this.base.currentProgress.start(100);

		if (this.response.error) {
			var msg = MooTools.lang.get('FancyUpload', 'errors')[this.response.error] || '{error} #{code}';
			this.errorMessage = msg.substitute($extend({
				name: this.name,
				size: Swiff.Uploader.formatUnit(this.size, 'b')
			}, this.response));
			var args = [this, this.errorMessage, this.response];

			this.fireEvent('error', args).base.fireEvent('fileError', args);
		} else {
			this.base.fireEvent('fileSuccess', [this, this.response.text || '']);
		}


	   i_ok++;
	   if(i_ok<i_count)return;
	   mt.close();
	   mt.sequence(form2.albums);
	},

	onError: function() {
		this.element.addClass('file-failed');
		var error = MooTools.lang.get('FancyUpload', 'fileError').substitute(this);
		this.info.set('html', '<strong>' + error + ':</strong> ' + this.errorMessage);
	},

	onRemove: function() {
		this.element.getElements('a').setStyle('visibility', 'hidden');
		this.element.fade('out').retrieve('tween').chain(Element.destroy.bind(Element, this.element));
	}

});

// Avoiding MooTools.lang dependency
(function() {
	var phrases = {
		'progressOverall': 'Overall Progress ({total})',
		'currentTitle': 'File Progress',
		'currentFile': 'Uploading "{name}"',
		'currentProgress': 'Upload: {bytesLoaded} with {rate}, {timeRemaining} remaining.',
		'fileName': '{name}',
		'remove': 'Remove',
		'removeTitle': 'Click to remove this entry.',
		'fileError': 'Upload failed',
		'validationErrors': {
			'duplicate': 'File <em>{name}</em> is already added, duplicates are not allowed.',
			'sizeLimitMin': 'File <em>{name}</em> (<em>{size}</em>) is too small, the minimal file size is {fileSizeMin}.',
			'sizeLimitMax': 'File <em>{name}</em> (<em>{size}</em>) is too big, the maximal file size is <em>{fileSizeMax}</em>.',
			'fileListMax': 'File <em>{name}</em> could not be added, amount of <em>{fileListMax} files</em> exceeded.',
			'fileListSizeMax': 'File <em>{name}</em> (<em>{size}</em>) is too big, overall filesize of <em>{fileListSizeMax}</em> exceeded.'
		},
		'errors': {
			'httpStatus': 'Server returned HTTP-Status <code>#{code}</code>',
			'securityError': 'Security error occured ({text})',
			'ioError': 'Error caused a send or load operation to fail ({text})'
		}
	};

	if (MooTools.lang) {
		MooTools.lang.set('en-US', 'FancyUpload', phrases);
	} else {
		MooTools.lang = {
			get: function(from, key) {
				return phrases[key];
			}
		};
	}
})();















///////分隔线//////////////////////////////////////////////////////////////////////////////////////////



//图片左右移动
document.write("<style>#img span{ width:52px; height:52px; border:1px solid #CCCCCC;text-align:center;margin-right:5px}</style><div id='but' style='position:absolute;display:none;background:#CCE1FE;width:50px'><img src='/tea/image/l.gif' onclick='mt.move(-1)' /> <img src='/tea/image/r.gif' onclick='mt.move(1)' /> <img src='/tea/image/d.gif' onclick='mt.del()' /></div>");

var imgs,img=$('img'),but=$('but'),seq;
mt.add=function(s)
{
  var tr=document.createElement('SPAN');
  tr.innerHTML="<img src="+s+" />";
  img.appendChild(tr);
  mt.but();
}

mt.but=function()
{
  imgs=img.childNodes,pic='|';
  for(var i=0;i<imgs.length;i++)
  {
    eval("imgs[i].onmouseover=function(){seq="+i+";but.style.display='';but.style.left=mt.left(this)+'px';but.style.top=mt.top(this)+36+'px';}");
    //arr[i].onmouseout=function(){but.style.display='none';}
	var t=imgs[i].firstChild.src;
	pic+=t.substring(t.lastIndexOf('/')+1,t.lastIndexOf('_'))+"|";
  }
  form2.picture.value=pic;
  but.style.display='none';
}
mt.but();

mt.move=function(i)
{
  var t=imgs[seq],d=imgs[seq+i];
  if(!d)return;
  t.swapNode(d);
  mt.but();
}
mt.del=function()
{
  mt.show("确认要删除吗？",2);
  mt.ok=function()
  {
    imgs[seq].parentNode.removeChild(imgs[seq]);
	mt.but();
  }
}





mt.rec=function()
{
  mt.show("/jsp/yl/shop/ProductSel.jsp?product="+mt.value(form2.products,"|"),2,"选择商品",500,400);
}
mt.receive=function(id,n,h)
{
  $("t_recommend").innerHTML+=h;
}

//颜色
mt.color=function(t)
{
  $('color_tab').style.display=mt.value(form2.color)?'':'none';
  $('co'+t.value).style.display=t.checked?'':'none';
}
var cs=form2.color;
if(cs)for(var i=0;i<cs.length;i++)if(cs[i].checked)cs[i].onclick();


//尺码
mt.psize=function(a)
{
  b=a.nextSibling;
  b.disabled=!a.checked;
  s=b.style;
  if(a.checked)
  {
    b.old=s.cssText;
    s.cssText='';
  }else
    s.cssText=b.old;
}
var ps=form2.psize;
if(ps)for(var i=0;i<ps.length;i++)if(ps[i].checked)ps[i].onclick();





// our uploader instance

var up = new FancyUpload2($('demo-status'), $('demo-list'), {

  //appendCookieData: true,
  instantStart: true,

	// we console.log infos, remove that in production!!
	verbose: true,

	// url is read from the form, so you just have to change one place
	url: $('form-demo').action,

	// path to the SWF file
	path: '/tea/fancyupload/Swiff.Uploader.swf',

	// remove that line to select all files, or edit it, add more items
	typeFilter: {
		'图片文件 (*.jpg, *.jpeg, *.gif, *.png)': '*.jpg; *.jpeg; *.gif; *.png'
	},

	// this is our browse button, *target* is overlayed with the Flash movie
	target: 'browse',

	// graceful degradation, onLoad is only called if all went well with Flash
	onLoad: function() {

		// We relay the interactions with the overlayed flash to the link
		this.target.addEvents({
			click: function() {
				return false;
			},
			mouseenter: function() {
				this.addClass('hover');
			},
			mouseleave: function() {
				this.removeClass('hover');
				this.blur();
			},
			mousedown: function() {
				this.focus();
			}
		});

		// Interactions for the 2 other buttons

		$('demo-clear').addEvent('click', function() {
			up.remove(); // remove all files
			return false;
		});

		$('demo-upload').addEvent('click', function() {
			up.start(); // start upload
			return false;
		});
	},

	// Edit the following lines, it is your custom event handling

	/**
	 * Is called when files were not added, "files" is an array of invalid File classes.
	 *
	 * This example creates a list of error elements directly in the file list, which
	 * hide on click.
	 */
	onSelectFail: function(files)
    {
		files.each(function(file)
        {
			new Element('li', {
				'class': 'validation-error',
				html: file.validationErrorMessage || file.validationError,
				title: MooTools.lang.get('FancyUpload', 'removeTitle'),
				events: {
					click: function() {
						this.destroy();
					}
				}
			}).inject(this.list, 'top');
		}, this);
	},

	/**
	 * This one was directly in FancyUpload2 before, the event makes it
	 * easier for you, to add your own response handling (you probably want
	 * to send something else than JSON or different items).
	 */
	onFileSuccess: function(file, response)
	{
	eval(response);
//		var json = new Hash(JSON.decode(response, true) || {});
//		if (json.get('status') == '1')
//        {
//			file.element.addClass('file-success');
//			file.info.set('html', '<strong>Image was uploaded:</strong> ' + json.get('width') + ' x ' + json.get('height') + 'px, <em>' + json.get('mime') + '</em>)');
//		} else
//        {
//			file.element.addClass('file-failed');
//			file.info.set('html', '<strong>An error occured:</strong> ' + (json.get('error') ? (json.get('error') + ' #' + json.get('code')) : response));
//		}
	},

	/**
	 * onFail is called when the Flash movie got bashed by some browser plugin
	 * like Adblock or Flashblock.
	 */
	onFail: function(error) {
		switch (error) {
			case 'hidden': // works after enabling the movie and clicking refresh
				alert('To enable the embedded uploader, unblock it in your browser and refresh (see Adblock).');
				break;
			case 'blocked': // This no *full* fail, it works after the user clicks the button
				alert('To enable the embedded uploader, enable the blocked Flash movie (see Flashblock).');
				break;
			case 'empty': // Oh oh, wrong path
				alert('A required file was not found, please be patient and we fix this.');
				break;
			case 'flash': // no flash 9+ :(
				alert('To enable the embedded uploader, install the latest Adobe Flash plugin.')
		}
	}

});
