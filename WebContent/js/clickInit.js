$(document).ready(function(){
$( "#listSubheadings" ).on("click","li.headingName", function(event) {    
   
	$("#mainContent").empty();
    
	var subheading=this.innerHTML.trim();
	           $.get('Controller',{subheading:subheading},function(responseJson) {
	            if(responseJson!=null){
	                  var fillDiv=$("#mainContent"); 
	                $.each(responseJson, function(key,value){ 
	                       var newH1=$("<h1></h1>");
	                       var newp=$("<p></p>");
	                       newH1.text(value['tutName']);
	                       newp.text(value['tutContent']);
	                       newH1.appendTo(fillDiv);
	                       newp.appendTo(fillDiv);
	                       
	                        
	                });
	                }
	            });
	  });      
	});
                                  
               

