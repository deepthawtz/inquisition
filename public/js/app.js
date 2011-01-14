$(function(){
    // focus cursor in text box
    $(".guess").focus()
    $(".add input:first").focus()

    if (localStorageSupport()) {
        if (localStorage.hints == undefined) {
            localStorage.hints = "yes"
        }
        if (localStorage.hints == "no") {
            $(".hints-no").attr("checked", "checked")
            $(".hints-yes").attr("checked", "")
            $(".hints").hide()
        }
        if (localStorage.hints == "yes") {
            $(".hints-yes").attr("checked", "checked")
            $(".hints-no").attr("checked", "")
        }
    }
    else {
        $(".notice").html("This application's settings are stored using HTML5. Your browser is dusty, get something new.").css("padding", "8px")
    }

    $(".hints-yes").click(function() {
        $(".hints-no").attr("checked", "")
        localStorage.hints = "yes"
    })

    $(".hints-no").click(function() {
        $(".hints-yes").attr("checked", "")
        localStorage.hints = "no"
    })

    $(".onoff").click(function(){
        localStorage.hints = "no"
        $(".hints").hide()
    })


    // quiz message
    $(".message").hide()
    if (messageDisplayed())
        $(".message").fadeIn(400)

    $(".errors").hide()
    $(".add").submit(function(){
        if ($("input.english").val() == "" || $("input.spanish").val() == "") {
            $(".errors ul").append("<li>English and Spanish field both must be filled out")
            $(".errors").slideDown()
            return false
        }
        if ($(".point").val() > 10) {
            $(".errors ul").append("<li>Point value can be no greater than 10")
            $(".errors").slideDown()
            return false
        }
        return true
    })
})

function messageDisplayed() {
    return !!($(".message").text() !== "")
}

function localStorageSupport() {
    return !!window.localStorage
}
