
$(document).ready(function(){
	//Make navbar class change on click to active
	var selector = '.nav li';

	$(selector).on('click', function(){
	    $(selector).removeClass('active');
	    $(this).addClass('active');
	});
	
$( "#selTopicname" ).change(function() {    
   	$("#selSubheading").empty();

	var topicName = $(this).find('option:selected').val();

	           $.get('Controller',{topicName:topicName},function(responseJson) {
	            if(responseJson!=null){
	                  var fillDiv=$("#selSubheading"); 
	                $.each(responseJson, function(key,value){

	                       var newp=$("<option></option>");
	                       newp.text(value['tutSubheading']);
	                       newp.appendTo(fillDiv);
	                       
	                        
	                });
	                }
	            });
	           $( "#selSubheading" ).click(function() {    
                   $("#contentEdit").empty();

	        		var subTopicName = $(this).find('option:selected').val();
	        		           $.get('Controller',{subTopicName:subTopicName},function(responseJson) {
	        		            if(responseJson!=null){
	        		                  var fillDiv=$("#contentEdit"); 
	        		                $.each(responseJson, function(key,value){

	        		                	fillDiv.text(value['tutContent']);
	        		                       newp.appendTo(fillDiv);
	        		                     
	        		                       
	        		                        
	        		                });
	        		                }
	        		            });
	        	  });
	           
	           
  });




$( "#delTopicName" ).change(function() {    
   	$("#delSubTopicName").empty();

	var topicName = $(this).find('option:selected').val();

	           $.get('Controller',{topicName:topicName},function(responseJson) {
	            if(responseJson!=null){
	                  var fillDiv=$("#delSubTopicName"); 
	                $.each(responseJson, function(key,value){

	                       var newp=$("<option></option>");
	                       newp.text(value['tutSubheading']);
	                       newp.appendTo(fillDiv);
	                       
	                        
	                });
	                }
	            });

  });



      
	});
                                  
               

