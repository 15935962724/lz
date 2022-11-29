$(".head-dh-list .head-dh-y").click(function(){
    if($(this).next($('ul')).css('display')=='block'){
        $(this).next($('ul')).slideUp();
    }else{
        $(".head-dh-list ul").slideUp();
        $(this).next($('ul')).slideDown();
    }
})

$(".header-tit .head-list").click(function(){
    if($('.head-dh-list').css('display')=='none'){
        $(".head-dh-list").slideDown();
        $('.head-list').attr('src','img/icon13.png').addClass('head-close');
        $("body").css({
            'height':'100%',
            'overflow':'hidden'
        });
        $("html").css({
            'height':'100%',
            'overflow':'hidden'
        });
    }else{
        $(".head-dh-list").slideUp();
        $('.head-list').attr('src','img/icon2.png').removeClass('head-close');
        $("body").css({
            'height':'auto',
            'overflow':'auto'
        });
        $("html").css({
            'height':'auto',
            'overflow':'auto'
        });
    }
});