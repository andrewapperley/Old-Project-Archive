##Purpose
The purpose of this software is to give the developer(s) improved utility tools to work with and a modified event system. The utilities and event system have been tested on both iPhone and iPad. 

The utilities are designed to simplify the implementation of certain native iOS tools. The event system strays away from the traditional NSNotificationCenter and delegation and instead holds an alterable event system to let you add, remove, and modify events and / or handlers. 

##Support
Earliest tested and supported build and deployment target - iOS 5.0.
Latest tested and supported build and deployment target - iOS 7.0.

##ARC Compatibility
AFFramework is ARC-compatible thanks to Nick Lockwood's ARCHelper found here https://gist.github.com/1563325.
	
##Installation
Copy the AFFramework folder and contents to your project.
Add the current lines to your <AppName>-Prefix.pch file :
		
    #import "AFFEventCenter.h"
    #import "AFFCleanup.h"		//If using non-arc
    #import "AFFMiscMacros.h" 		
    #import "UIImage+UIView.h"		
    #import "UIView+AFFUIVew_pos_size.h"

##Utility Usage

###UIImage+UIView
This UIImage category adds methods to resize and image, return and image from a UIView, and return a an image from a UIView with cropping.

###UIView+AFFUIVew_pos_size
This UIView category adds properties to easily change the frame and scaling of a view.

###AFFCleanup
The clean up utility simplifies memory management. 
	
	destroy() 		 //releases your object and sets its to nil.
	destroyAndRemove() 	 //releases your object and removes it from it's superView.
	removeAllSubviews() 	 //removes all subviews from the view passed to it.

###AFFImage
This is a custom UIImageView for rendering an image. it also comes with a rotation function to easily work with rotating images on the screen.

###AFFImageCache (For non-ARC projects)
The image cache utility allows you to have a set number of images that are used frequently. it works by initing it and an NSMutableArray or NSMutable into memory, most likely in a global scope class and then when you need an image you call the addImage class function, set or array version depending on what you used. When that function is called it will search to see if the image exists, if it does it will give you the UIImage already in memory, if not it will create a new one and add it to the cache. This gives you control of the cache by managing how many objects can be in memory at once.

###AFFMiscMacros
A list of macros that cover a range of functions from short cuts for getting the screen size to getting a colour from RGB/HEX value.

###AFFPDFUtil
This is a utility to easily make PDF documents and save them into the Documents folder of your app.
	It lets you create a PDF from either:
- An array of UIImages with a split (how many images per page) and padding between each image, default 0 if you use function without padding
- A single UIImage object
- A single UIView object
	It also gives you access to deleting a single PDF document when passed a string (the file name) and any images that were used to create it if they were from the file system.

###AFFSelectorQueue
This is a basic selector queueing class for non-automated selector queues. The delegate class uses it's own selectors that are added or removed to the queue. Upon running the queue from the delegate class the next selector in line is run then removed. The 'runQueue' method must be included to the delegate class to manually run the next selector in queue.The queue array / dictionary itself is created / destroyed based on objects in the queue. It is the delegate class's responsibility to ensure selectors are being handled correctly; the queue simply calls the methods provided with or without arguments.

###AFFString
A simple class to easily trim strings by providing a source and a string to search for and trim to.

###AFFVector
 This gives you access to Vector2 and Vector3 objects. 
 It also lets you easily do basic calculations on/with them. Init a vector by making an AFFVector
 object call its class method of either vectorX:Y: or vectorX:Y:Z:.
 They are basic structs with floats so deallocing isn't necessary.

###AFFVideoPlayer
This is a ready to use full screen video player with all the controls/delegate methods mapped to functions that can be accessed externally. Load it with a NSURL object and it just works.

###AFFXMLParser
Init the XMLParser with a file path string to your xml file that is in the bundle. It will then create an exact representation of the xml file. Where single elements are saved as Dictionaries and multiple elements are saved as arrays of dictionaries. Use the 'parsedObjects' dictionary at the end of parsing, either by copying it out and deallocating the parser or using it directly.

##Event Usage
###About
AFFramework events are handled through a central system, much like NSNotificationCenter. Events do not use a 'name' convention; instead they use an object's hash in combination with a given event name. These events are not, however, are not globally accessible by listeners. You may, if needed, modify events through the global AFFEventSystemHandler class.

###Event Creation 
Events are created in a class's header file and synthesized in it's implementation using macros.

Header file : 

    AFFEventCreate( $eventLevel, $eventName )

@param	 : $eventLevel 
@type	 : Macro
@options : AFFEventClass  AFFEventInstance   

@param 	  : $eventName 
@type	  : NSString

Implementation file : 

    AFFEventSynthesize( $eventLevel, $eventName ) 
@param	 : $eventLevel 
@type	 : Macro
@options : AFFEventClass  AFFEventInstance   

@param 	  : $eventName 
@type	  : NSString

###Event Removal
A class in which an event is created is also responsible for destroying that event in it's deallocation. This can easily be done by using AFFRemoveAllEvents() in a class's dealloc method. This will remove any event objects for that class from the AFFEventSystemHandler. To remove a specific event use AFFRemoveEvent( $eventName ). This may be used outside of the event creator's class.

    AFFRemoveAllEvents()

    AFFRemoveEvent( $eventName )
@param 	: $eventName 
@type	 : NSString

###Sending an event
An event may be sent by the class for which the event was created and / or by classes outside of it. Any handlers listening for the event will be called and there will be an AFFEvent object sent for the listener's method. Events are sent to all listeners with or without data. 

    //Send events from class
    [[self $eventName] send];
    [[self $eventName] send:data];

    //Send events from an instance of a class
    [[instance $eventName] send];
    [[instance $eventName] send:data];
###Listening for an event
Events may be listened for much like how they are listened for using NSNotificationCenter. To add a handler simply add it to the event you want to listen for and add the selector and arguments, if any.

    [[class $eventName] addHandler:AFFHandler(@selector(SEL))];
    [[instance $eventName] addHandler:AFFHandler(@selector(SEL))];

With arguments:

    [[class $eventName] addHandler:AFFHandlerWithArgs(@selector(SEL:::::), arg1, arg2, arg3, arg4)];
    [[instance $eventName] addHandler:AFFHandlerWithArgs(@selector(SEL:::::), arg1, arg2, arg3, arg4)];

One time handlers are handlers that are only called once then destroyed from the event sender:

    [[class $eventName] addHandlerOneTime:AFFHandler(@selector(SEL))];
    [[instance $eventName] addHandlerOneTime:AFFHandler(@selector(SEL))];

One time handlers with arguments:

    [[class $eventName] addHandlerOneTime:AFFHandlerWithArgs(@selector(SEL:::::), arg1, arg2, arg3, arg4)];
    [[instance $eventName] addHandlerOneTime:AFFHandlerWithArgs(@selector(SEL:::::), arg1, arg2, arg3, arg4)];

###Retrieving data from the event to the handler
Retrieving data from an event is very similar to NSNotification usage. The selector for which an event is going to trigger can have multiple parameters. If the event being sent has no data and doesn't need any sender information, then the selector does not need to have an AFFEvent object parameters.

    - (void)eventHandler {}

An event where there is data being sent and / or you'd want to know more information about the event can have an AFFEvent object parameter.

    - (void)eventHandler:(AFFEvent *)event {}

A handler with one or more other parameters must include an AFFEvent object as it's first parameter.

    - (void)eventHandler:(AFFEvent *)event withArg1:(id)arg1 andArg2:(id)arg2 andArg3:(id)arg3 {} 

###Event object
The event object itself has three accessible properties:

    @property (nonatomic, readonly) id sender;
    @property (nonatomic, readonly) id data;
    @property (nonatomic, readonly) NSString *eventName;

The 'sender' property references the object that sent the event.
The 'data' property is the data being sent by the event.
The 'eventName' property is the name of the event that was sent.

###Example Usage
Here is an example of basic usage with using AFFEvents. An event is first created in the header file then synthesized through the implementation file. A handler as a selector is then added to the event. 'myAction' method will, when triggered, send the event with data. This data will be retrieved via the handler attached a the data will be logged out. 

    @interface MyClass : NSObject

    AFFEventCreate(AFFEventInstance, evtTest);

    @end

    @implementation MyClass

    AFFEventSynthesize(AFFEventInstance, evtTest);

    - (id)init
    {
        [[self evtTest] addHandler:AFFHandler(@selector(myEvent:))]; 
	[self myAction];
    }

    - (void)myAction
    {
     	[[self evtTest] send:[NSNumber numberWithInt:15]];
    }

    - (void)myEvent:(AFFEvent *)event
    {
    	int result = [[event data] intValue];
    	//result will be '15'
    }

    @end

