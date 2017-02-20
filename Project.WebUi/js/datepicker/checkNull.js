function checkNull()
{
      var txtKSBH = document.getElementById("txtKSBH");
        if (txtKSBH.value=="") {
            alert("科室编号不能为空");
            txtKSBH.focus();
            return false;
        }
        var txtKSMC = document.getElementById("txtKSMC");
        if (txtKSMC.value == "") {
            alert("科室名称不能为空");
            txtKSBH.focus();
            return false;
        }
        var txtKSSX = document.getElementById("txtKSSX");
        if (txtKSSX.value == "") {
            alert("科室顺序不能为空");
            txtKSSX.focus();
            return false;
        }
        return true;
}