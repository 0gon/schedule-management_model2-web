function eduCheck(chk){
    if(chk==1){
        var tmp = $('#eduTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
        }
    }else if(chk==2){
         var tmp = $('#etcTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
        }
    }
}