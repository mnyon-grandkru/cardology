<script>
    var is_safari = navigator.userAgent.indexOf("Safari") > -1;
    var is_chrome = navigator.userAgent.indexOf('Chrome') > -1;
    if ((is_chrome) && (is_safari)) {is_safari = false;}  
    if (is_safari) {
        if (!document.cookie.match(/^(.*;)?\s*fixed\s*=\s*[^;]+(.*)?$/)) {
            document.cookie = 'fixed=fixed; expires=Tue, 19 Jan 2038 03:14:07 UTC; path=/';
            window.location.replace("https://cardology-api.herokuapp.com/_safari_fix.html");
        }
    }
</script>