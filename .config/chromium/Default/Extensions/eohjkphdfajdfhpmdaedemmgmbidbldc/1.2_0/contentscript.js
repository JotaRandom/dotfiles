

//setTimeout($('.hoverer').remove(),1000);


var posX;


function getLargeImage(raw){


    raw = raw.replace("_normal", "");
    raw = raw.replace("_mini", "");
   

    return raw;

}


function isProfilePic(src){

    if(src.indexOf("profile_images") != -1){
        return true;
    }

    return false;

}





function showPhoto(attr){
    if(!isProfilePic(attr)){
        reutrn;
    }


    pos = posX;  //posX is Global

    //Show
    $('img').unbind();





    $("#"+pos).show();


    $("#"+pos).html('<img borser="0" style="position:fixed;top:50px;'+pos+':10px;z-index:998;border:solid 3px #000000"  src="'+chrome.extension.getURL('loading.gif')+'">');
    $("#"+pos).append('<img id="tpz" style="position:fixed;top:50px;'+pos+':10px;z-index:999;border:solid 3px #FFFFFF"  src="'+getLargeImage(attr)+'">');
    //alert();
    $("#"+pos).children().css('max-height', '550px');
    $("#"+pos).children().css('background', 'white');
    $("#"+pos).children().css('border', 'solid 3px #000000');
    
  



}

function hidePhoto(){
    $("#left").hide();
    $("#left").html("");
    $("#right").hide();
    $("#right").html("");

    $('img').unbind(); //release
}


$('body').prepend('<div style="background-color:white;z-index:9000;border:1px;position:fixed;left:10px;top:50px;" id="left"></div>');
$('body').prepend('<div style="background-color:white;z-index:9000;border:1px;position:fixed;right:10px;top:50px;" id="right"></div>');



$('body').mousemove(function(){
    $('img').hover(function(){
        showPhoto($(this).attr('src'));
    },
    
    function(){
        hidePhoto()
    })
}



);








jQuery(document).ready(function(){

    
    $(document).mousemove(function(e){


        if(e.pageX >=  window.innerWidth/2){
            ;
            posX='left';
            return'right';
        }else{
            posX='right';
            return'left';
        }

    });
})

