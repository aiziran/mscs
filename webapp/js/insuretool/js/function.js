// JavaScript Document
<!--

function initArray(){for(i=0;i<initArray.arguments.length;i++)
this[i]=initArray.arguments[i];}var isnMonths=new initArray("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");var isnDays=new initArray("星期日","星期一","星期二","星期三","星期四","星期五","星期六","星期日");today=new Date();hrs=today.getHours();min=today.getMinutes();sec=today.getSeconds();clckh=""+((hrs>12)?hrs-12:hrs);
clckm=((min<10)?"0":"")+min;clcks=((sec<10)?"0":"")+sec;clck=(hrs>=12)?"PM":"AM";var stnr="";var ns="0123456789";var a="";
function FlashObject(path, width, height)
{
	var m_movie = path;
	var m_width = width;
	var m_height = height;

	this.wmode = "";
	this.id = "";
	this.quality = "high"
	this.menu = "false"
	
	this.Render = function()
	{
		var html;
		
		html = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='" + m_width + "' height='" + m_height + "'";
		if (this.id != "")
			html += " id='" + this.id + "'";
		html += ">";
		html += "<param name='movie' value='" + m_movie + "'>";
		html += "<param name='menu' value='" + this.menu + "'>";
		html += "<param name='quality' value='" + this.quality + "'>";
		if (this.wmode != "")
			html += "<param name='wmode' value='" + this.wmode + "'>";
		html += "<embed src='" + this.movie + "' quality='" + this.quality + "' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='830' height='240'></embed>";
		html += "</object>";
		document.write(html);
	}
}

		function objCall(strpath,strwid,strhei){
		var fla = new FlashObject(strpath, strwid, strhei); 
		// fla.wmode = "transparent";
		fla.Render(); 
		}

// -->
