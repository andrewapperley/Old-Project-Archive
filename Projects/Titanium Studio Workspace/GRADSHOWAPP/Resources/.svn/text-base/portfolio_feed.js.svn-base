	/*declare the student parts ie. name, link ect*/
	 var student_first;
	 var student_last;
	 var student_link;
	 var student_profile_image;
	 var student_bio;
	 var student_piece_description;
	 var student_type_title;
	 var student_portfolio_image;
	 var student_id;
	 
	 /*arrays for the student info*/
	 var firstArray = [];
	 var lastArray = [];
	 var linkArray = [];
	 var profileArray = [];
	 var bioArray = [];
	 var descriptionArray = [];
	 var titleArray = [];
	 var portfolioArray = [];
	 var idArray = [];
	 var tileArray = [];
	 var FirstLetterArray = []; 
	 var LastLetterArray = [];
	 
	 /*run json through loop to retrieve response from php file that gets the info from the database*/
	studentsReq.onload = function(){
		
			var json = JSON.parse(this.responseText);
			var json = json.students;
		    var pos;
		    
		   //first name loop
		   for( pos=0; pos < json.length; pos++){	
				student = json[pos];
		 		student_first = student.student_first;
				firstArray.push(student_first);
				FirstLetterArray.push(student_first.slice(0,1));
		    };
		    
		    //last name loop
			for( pos=0; pos < json.length; pos++){
				student = json[pos];			
			    student_last = student.student_last;
				lastArray.push(student_last);
				LastLetterArray.push(tempLastLetter = student_last.slice(0,1));
		    };
		  
	      	//create the left scroll view for the main view
			var profileLeftScrollView = Ti.UI.createScrollView({
				width:124,
				height:580,
				top:150,
				left:0,
				contentWidth:124,
				contentHeight:'auto',
				showVerticalScrollIndicator: true
			});
	
				//name labels loop for the left scroll view
			    for(var i = 0; i<firstArray.length; i++)
			    {
			    	var studentLabel = Ti.UI.createLabel({
						text: firstArray[i] + ' ' + LastLetterArray[i] + '.',
						textAlign:'center',
						width:'100%',
						height:40,
						font:{fontSize:16},
						top: 40 * i,
						color:'#666',
						id:i
				});
			
				//the each name to the view
				profileLeftScrollView.add(studentLabel);
				
				//event listener for viewing a students profile
				studentLabel.addEventListener('click', function(e)
				{
					var rowID = e.source.id;
		
					tempFirstLetter = FirstLetterArray[rowID];
					tempLastLetter = LastLetterArray[rowID];
					tempFirst = firstArray[rowID];
					tempLast = lastArray[rowID];
					tempDescription = descriptionArray[rowID];
					tempBio = bioArray[rowID];
					tempProfileImage = profileArray[rowID];
					tempLink = linkArray[rowID];
					tempPortfolioImage = portfolioArray[rowID];
					tempID = idArray[rowID];
					tempTitle = titleArray[rowID];
					
					win.animate(slideLeft);
					profileView.animate(slideRight);
					getProfileData();
				});
			}
			
			leftBar.add(profileLeftScrollView);
		
		     //link loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_link = student.student_link;
				linkArray.push(student_link);
		    };
		    
		     //profile loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_profile_image = "http://www.humberinteractive.com/2012/piece_images/"+student.profile_image;
				profileArray.push(student_profile_image);
				tileArray.push(student_profile_image);
		    };
		    
		    //bio loop
			for( pos=0; pos < json.length; pos++){
				student = json[pos];
			    student_bio = student.student_bio;
				bioArray.push(student_bio);
		    };
		    
		    //description loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_piece_description = student.piece_description;
				descriptionArray.push(student_piece_description);
		    };
		    
		    //student_type_title loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_type_title = student.type_title;
				titleArray.push(student_type_title);
		    };
		    
		    //student_portfolio_image loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_portfolio_image = "http://www.humberinteractive.com/2012/piece_images/"+student.portfolio_image;
				portfolioArray.push(student_portfolio_image);
		    };
		    
		    //student_id loop
			for( pos=0; pos < json.length; pos++){	
				student = json[pos];
			    student_id = student.id;
				idArray.push(student_id);
		    };	
		    
		    
	/*
	 * start the horizontal loops for the students
	 */
	
	// loop that places row 1 of portfolio images
	for (var i=0; i < 11; i++) {
	
		// create each button and sets the proper background image from the row1ImageArray
	    var row1PortfolioPiece = Ti.UI.createImageView({  	
	        height:192,
	        width:192,
	        left: i*192,
			image:tileArray[i],
			id:i
	    });
	    
	    //click handler for the tile icons
		row1PortfolioPiece.addEventListener('click', function(e){
	
			var row1tileID = e.source.id;	
		
			//profile page temp variables
			tempFirstLetter = FirstLetterArray[row1tileID];
			tempLastLetter = LastLetterArray[row1tileID];
			tempFirst = firstArray[row1tileID];
			tempLast = lastArray[row1tileID];
			tempDescription = descriptionArray[row1tileID];
			tempBio = bioArray[row1tileID];
			tempProfileImage = profileArray[row1tileID];
			tempLink = linkArray[row1tileID];
			tempPortfolioImage = portfolioArray[row1tileID];
			tempID = idArray[row1tileID];
			tempTitle = titleArray[row1tileID];
			
			win.animate(slideLeft);
			profileView.animate(slideRight);
			getProfileData();
		});
	    
		// adds the image to scrollview
		scrollRow1.add(row1PortfolioPiece);
	};
	
		    
	// loop that places row 2 of portfolio images
	for (var i=12; i < 23; i++) {
		
		//make a new offset variable
		var h = i - 12;
		
		// create each button and sets the proper background image from the tileArray
	    var row2PortfolioPiece = Ti.UI.createImageView({  	
	        height:192,
	        width:192,
	        left: h*192,
			image:tileArray[i],
			id:i
	    });
	    
	    //click handler for the tile icons
		row2PortfolioPiece.addEventListener('click', function(e){
		
		var row2tileID = e.source.id;
	
		//profile page temp variables
		tempFirstLetter = FirstLetterArray[row2tileID];
		tempLastLetter = LastLetterArray[row2tileID];
		tempFirst = firstArray[row2tileID];
		tempLast = lastArray[row2tileID];
		tempDescription = descriptionArray[row2tileID];
		tempBio = bioArray[row2tileID];
		tempProfileImage = profileArray[row2tileID];
		tempLink = linkArray[row2tileID];
		tempPortfolioImage = portfolioArray[row2tileID];
		tempID = idArray[row2tileID];
		tempTitle = titleArray[row2tileID];
		
		win.animate(slideLeft);
		profileView.animate(slideRight);
		getProfileData();
		});
		
		// adds the image to scrollview
		scrollRow2.add(row2PortfolioPiece);
	};    
	
	
	// loop that places row 3 of portfolio images
	for (var i=24; i < 35; i++) {
	
		//make a new offset variable
		var h = i - 24;
		
		// create each button and sets the proper background image from the tileArray
	    var row3PortfolioPiece = Ti.UI.createImageView({  	
	        height:192,
	        width:192,
	        left: h*192,
			image:tileArray[i],
			id:i
	    });
	    
	    //click handler for the tile icons
		row3PortfolioPiece.addEventListener('click', function(e){
		
		var row3tileID = e.source.id;
	
		//profile page temp variables
		tempFirstLetter = FirstLetterArray[row3tileID];
		tempLastLetter = LastLetterArray[row3tileID];
		tempFirst = firstArray[row3tileID];
		tempLast = lastArray[row3tileID];
		tempDescription = descriptionArray[row3tileID];
		tempBio = bioArray[row3tileID];
		tempProfileImage = profileArray[row3tileID];
		tempLink = linkArray[row3tileID];
		tempPortfolioImage = portfolioArray[row3tileID];
		tempID = idArray[row3tileID];
		tempTitle = titleArray[row3tileID];
		
		win.animate(slideLeft);
		profileView.animate(slideRight);
		getProfileData();
		});
	    
		// adds the image to scrollview
		scrollRow3.add(row3PortfolioPiece);
	};    
		     
	// loop that places row 3 of portfolio images
	for (var i=36; i < 48; i++) {
		
		//make a new offset variable
		var h = i - 36;
		
		// create each button and sets the proper background image from the tileArray
	    var row4PortfolioPiece = Ti.UI.createImageView({  	
	        height:192,
	        width:192,
	        left: h*192,
			image:tileArray[i],
			id:i
	    });
	    
	    //click handler for the tile icons
		row4PortfolioPiece.addEventListener('click', function(e){
		
		var row4tileID = e.source.id;
		
		//profile page temp variables
		tempFirstLetter = FirstLetterArray[row4tileID];
		tempLastLetter = LastLetterArray[row4tileID];
		tempFirst = firstArray[row4tileID];
		tempLast = lastArray[row4tileID];
		tempDescription = descriptionArray[row4tileID];
		tempBio = bioArray[row4tileID];
		tempProfileImage = profileArray[row4tileID];
		tempLink = linkArray[row4tileID];
		tempPortfolioImage = portfolioArray[row4tileID];
		tempID = idArray[row4tileID];
		tempTitle = titleArray[row4tileID];
		
		win.animate(slideLeft);
		profileView.animate(slideRight);
		getProfileData();
		});
	
		// adds the image to scrollview
		scrollRow4.add(row4PortfolioPiece);
	};  
	scrollRow1.animate(initAnimation);
scrollRow2.animate(initAnimation);
scrollRow3.animate(initAnimation);
scrollRow4.animate(initAnimation); 
};
	
