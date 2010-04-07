$(document).ready(function(){
    // focus cursor in text box
    $(".guess").focus()
    
    // quiz message
    $(".message").hide()
    if (messageDisplayed())
        $(".message").fadeIn(400)
    
    // localStorage points
    $(".points").text(!!localStorage.points ? "0" : localStorage.points)
    
    // $(".inquisition").submit(saveScore)
    
})

// function saveScore() {
    // localStorage.points_for_last_word = $(".points_for_word").val() || 0
    // localStorage.points = (localStorage.points_for_last_word
    //                         + localStorage.points)
    // $(".points").text(localStorage.points)
    // return true
// }

function messageDisplayed() {
    return !!($(".message").text() !== "")
}
