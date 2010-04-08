$(document).ready(function(){
    // focus cursor in text box
    $(".guess").focus()
    $(".add input:first").focus()
    
    // quiz message
    $(".message").hide()
    if (messageDisplayed())
        $(".message").fadeIn(400)
    
    $(".errors").hide()
})

function messageDisplayed() {
    return !!($(".message").text() !== "")
}
