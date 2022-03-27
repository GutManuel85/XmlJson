function hideShow(id) {
    hide();
    if (document.getElementById(id).style.display === "none") {
        document.getElementById(id).style.display = "block";
    }
}

function hide() {
    divs = document.getElementsByClassName('formularDiv');

    for (div of divs) {
        div.style.display = 'none';
    }
}