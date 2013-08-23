</div>

<div class="rSidebar">

<h3>Название окна</h3>
Еще содержимое

</div>

</div>
</div>

<div class="footer">
<div class="left">Copyright Ibragim Corp.</div>
<div class="right">Design & coding by Messier82</div>
</div>

</div>

</body>
</html>
<script>
$('.ajaxBusy').hide(); 
$.ajaxSetup({
    beforeSend:function(){
        // show gif here, eg:
        $('.ajaxBusy').fadeIn(400,'swing',false); 
    },
    complete:function(){
        // hide gif here, eg:
        $('.ajaxBusy').fadeOut(400,'swing',false); 
    }
});
</script>