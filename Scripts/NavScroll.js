$(document).ready(function () {
    var imgh = $(".img-responsive").get(0).scrollHeight;
    var imgw = $(".img-responsive").get(0).scrollWidth;


    // Put  offset checking in a function
    function checkOffset() {
        if ($(window).width() > 750) {
        if ($(".navbar-fixed-top").offset().top > 10) {
            if (!$(".img-responsive").hasClass("collapse")) {

                $(".img-responsive").stop().animate({
                    width: imgw,
                    height: 0
                }, {
                    duration: "fast"
                });
                $(".img-responsive").addClass("collapse");
            }
        }
        else {
            $(".img-responsive").removeClass("collapse");
            $(".img-responsive").stop().animate({
                width: imgw,
                height: imgh
            }, {
                duration: "fast"
            });
            
        }
    }
    }

    // Run function when scrolling
    $(window).scroll(function () {
        checkOffset();
    });
});

