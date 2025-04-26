<?php
// 
//  CL Scraper
//  
//  Created by Andrew Apperley on 2012-11-04.
//  Copyright 2012 Andrew Apperley. All rights reserved.
// 

if($_GET['location']){
//if($argv)//Uncomment to be used with an SH file where you enter the location as the arguement
//{
	//SET UP
	$location = $_GET['location'];
//	$location = $argv[1];
	$results_emails = array();
	$rss_array = array(
		'http://'.$location.'.en.craigslist.ca/bab/index.rss'//baby and kids
		);
	
	$results_emails = array_merge($results_emails, init($rss_array) );
//	send_Mail($results_emails); //uncomment to use the emails in the array

	var_dump("Successful, ".$results_emails[0]." emails scraped from craigslist");
}
	
	function init($rss)
	{
		$results_emails = array();

		for ($i=0; $i < count($rss); $i++) { 
			
			$results = curl_Call($rss[$i]);
			
			$temp_email_array = get_Emails(create_XML($results));
			

			$results_emails = array_merge($results_emails , $temp_email_array);
		}
		return $results_emails;
	}

	function get_Emails($xml_from_results)
	{

		$result_links = array();
		$results_emails = array();
		//loop through the links and scrape emails from them
		for ($i=0; $i < 50; $i++) {//this number is for how many emails you want, watch out the larger it is the more likely they will find out what you are doing and it will take longer
			//push each link into array
			array_push($result_links, $xml_from_results->item[$i]->link);
			$temp_emails = null;
		  	preg_match('/\mailto:([^\?]+)/',curl_Call($result_links[$i]),$temp_emails);
		  	
		  	array_push($results_emails, trim($temp_emails[0], 'mailto:') );
		}
		return $results_emails;
	}

	function create_XML($xml)
	{
		$xml = simplexml_load_string($xml);
		
		return $xml;
	}

	function curl_Call($link)
	{
		$ch = curl_init(); 
		curl_setopt($ch, CURLOPT_URL, $link); 
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
		$results = curl_exec($ch); 
		curl_close($ch);

		return $results;
	}

	function send_Mail($email_list)
	{
		$emails = '';
		for ($i=0; $i < count($email_list); $i++) {
			if($i != 0)
			{$emails .= ",".$email_list[$i];}
		else{$emails .= $email_list[$i];}
		}

		$headers  = 'MIME-Version: 1.0' . "\r\n";
		$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
		$headers .= 'To: SCRAMBLED EMAIL' . "\r\n";
		$headers .= 'From: SCRAMBLED EMAIL ' . "\r\n";
		$headers .= 'Bcc: {$emails}' . "\r\n";//list of emails

		$subject = "PUT WHATEVER YOU WANT TO SEND TO THEM";
		mail($to, $from, $subject, $headers);
	}
?>
