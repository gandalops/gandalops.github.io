document.addEventListener("DOMContentLoaded", function () {
    var toc = document.querySelector('.js-toc');
    if (toc) {
        tocbot.init({
            tocSelector: '.js-toc',
            contentSelector: '.page__main',
            headingSelector: 'h2, h3',
            hasInnerContainers: false
        });
    }
});
