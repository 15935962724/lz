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


var fs=new Array();//缩略图
var place,line=9,imgs;//移动

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

	updateOverall: function()
        {
		this.overallTitle.set('html', MooTools.lang.get('FancyUpload', 'progressOverall').substitute({
			total: Swiff.Uploader.formatUnit(this.size, 'b')
		}));

		if (!this.size)
                {
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

	removeFile: function()
        {
        alert('del');
		return this.remove();
	}

});

FancyUpload2.File = new Class({

	Extends: Swiff.Uploader.File,

	render: function() {
		if (this.invalid)
                {
			if (this.validationError)
                        {
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
        //
        this.item=document.createElement("DIV");
        this.item.id="hash"+Math.random();
		this.item.setAttribute("name","item");
        this.item.onmouseover=function(){this.style.border="1px solid #51BD2F";};
        this.item.onmouseout=function(){this.style.border="1px solid #CCCCCC";};
        this.item.style.cssText="width:50px; height:50px; border:1px solid #CCCCCC;margin-left:5px;float:left;";
        this.item.title="名称:"+this.name+"\r\n大小:"+(this.size/1024).toFixed(1)+" K";
        this.item.innerHTML+="<img style='float:right' onclick='fs[parentNode.id].remove()' src='/tea/image/public/del2.gif'><div><div>0%</div><div style='border:1px solid #CCCCCC; padding:1px;'><div style='background:#00f;width:0%;height:2px;font-size:0px;'></div></div></div>";
        $('list').appendChild(this.item);
        fs[this.item.id]=this;
		//移动

	   this.item.onmousedown=function(event)
	   {
		 event=event||window.event;
		 var e=event.srcElement||event.target;
		 if(event.button>1||e.tagName!="DIV")return;
		 this.x=event.offsetX||event.layerX+e.offsetLeft+2;
		 this.y=event.offsetY||event.layerY+e.offsetTop+2;
		 this.down=true;
		 this.setCapture();
		 //
		 imgs=$('list').getElementsByTagName("DIV");
		 for(var j=0;j<imgs.length;j++)
		 {
		   imgs[j].locx=(mt.left(imgs[j])+imgs[j].offsetWidth/2);
		 }
		 //创建占位符
		 place=document.createElement("SPAN");
		 place.innerHTML="&nbsp;"
		 place.style.cssText=this.style.cssText+";border:1px solid #FF0000;background:none;display:block";
		 this.parentNode.insertBefore(place,this);
		 //
		 this.style.position="absolute";
		 this.onmousemove();
	   }
	   this.item.onmousemove=function(event)
	   {
		 event=event||window.event;
		 if(!this.down)return;
		 var x=event.clientX+document.body.scrollLeft;
		 if(x<0)x=0;
		 var y=event.clientY+document.body.scrollTop;
		 if(y<0)y=0;
		 this.style.left=x-this.x;
		 this.style.top=y-this.y;
		 //210第二行的高度
		 var loc=y>210?line:0;
		 while(imgs[loc]&&imgs[loc].locx<x)loc++;
		 if(y>210)
		 {  if(loc<=line)loc=line+1;
		 }else if(loc>line)loc=line;
		 if(place.loc==loc)return;
		 place.loc=loc;
		 this.parentNode.insertBefore(place,imgs[loc]||null);
	   }
	   this.item.onmouseup=function(event)
	   {
		 if(!this.down)return;
		 this.releaseCapture();
		 this.down=false;
		 this.style.position="";
		 this.parentNode.replaceChild(this,place);
		 this.onmouseout();
	   }
	},

	validate: function() {
		return (this.parent() && this.base.options.validateFile(this));
	},

	onStart: function()
        {
		this.element.addClass('file-uploading');
		this.base.currentProgress.cancel().set(0);
		this.base.currentTitle.set('html', MooTools.lang.get('FancyUpload', 'currentFile').substitute(this));

	},

	onProgress: function()
        {
//		this.base.overallProgress.start(this.base.percentLoaded);
//		this.base.currentText.set('html', MooTools.lang.get('FancyUpload', 'currentProgress').substitute({
//			rate: (this.progress.rate) ? Swiff.Uploader.formatUnit(this.progress.rate, 'bps') : '- B',
//			bytesLoaded: Swiff.Uploader.formatUnit(this.progress.bytesLoaded, 'b'),
//			timeRemaining: (this.progress.timeRemaining) ? Swiff.Uploader.formatUnit(this.progress.timeRemaining, 's') : '-'
//		}));
//		this.base.currentProgress.start(this.progress.percentLoaded);
                //
                var tmp=this.item.childNodes[1].childNodes;
                tmp[0].innerHTML=tmp[1].firstChild.style.width=this.progress.percentLoaded+"%";
                //$('vvvv').value=this.base.percentLoaded+":"+this.progress.percentLoaded;
	},

	onComplete: function()
    {
                this.item.url=this.response.text;
                this.item.style.background="#ffffff url(/jsp/include/FCKeditor/editor/upload.jsp?act=scale&url="+encodeURIComponent(this.item.url)+") no-repeat 50% 50%";
                this.item.removeChild(this.item.childNodes[1]);
	},

	onError: function() {
		this.element.addClass('file-failed');
		var error = MooTools.lang.get('FancyUpload', 'fileError').substitute(this);
		this.info.set('html', '<strong>' + error + ':</strong> ' + this.errorMessage);
	},

	onRemove: function()
    {
	   mt.send("/jsp/include/FCKeditor/editor/upload.jsp?act=del&url="+encodeURIComponent(this.item.url));
       this.item.parentNode.removeChild(this.item);
	}

});

// Avoiding MooTools.lang dependency
(function() {
	var phrases = {
		'progressOverall': '总进程 ({total})',
		'currentTitle': '当前进程',
		'currentFile': '正在上传 "{name}"',
		'currentProgress': 'Upload: {bytesLoaded} with {rate}, {timeRemaining} remaining.',
		'fileName': '{name}',
		'remove': '删除',
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
