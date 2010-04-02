$(document).ready(function(){
    $(".guess").focus()
    
    $(".message").hide()
    if ($(".message").text() !== "")
        $(".message").fadeIn(400)
})
