<script>
net user /add /y "${tmp_user}" "${tmp_pwd}" 1>> test.log 2>&1
net localgroup administrators "${tmp_user}" /add 1>> test.log 2>&1
</script>
<persist>false</persist>