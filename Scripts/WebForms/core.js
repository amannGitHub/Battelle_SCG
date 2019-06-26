jQuery(document).ready(function() {
    jQuery("span.show").next().css('display', 'none').end().click(function () {
        jQuery(this).next().slideToggle('slow');
    });
});