document.addEventListener("turbo:load", () => {
    document.querySelectorAll("a, form").forEach(element => {
        element.setAttribute("data-turbo-prefetch", "false");
    });
});
