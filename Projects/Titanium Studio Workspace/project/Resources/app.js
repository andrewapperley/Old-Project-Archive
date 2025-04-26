// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

// create tab group
var tabGroup = Titanium.UI.createTabGroup();


//
// create base UI tab and root window
//
var win1 = Titanium.UI.createWindow({  
    title:'Philosappy',
    backgroundColor:'#222',
    barColor:'#000',
    backgroundImage:'p_home.jpg'
});
var tab1 = Titanium.UI.createTab({  
    icon:'h_nav.png',
    title:'Home',
    window:win1
});



//
// create controls tab and root window
//
var win2 = Titanium.UI.createWindow({  
    title:'Friedrich Nietzsche',
    backgroundColor:'#fff',
    barColor:'#000',
    backgroundImage:'page2.jpg'
});
var tab2 = Titanium.UI.createTab({  
    icon:'n_nav.png',
    title:'Nietzsche',
    window:win2
});



//
// creates tab3
//
var win3 = Titanium.UI.createWindow({  
    title:'Rene Descartes',
    backgroundColor:'#fff',
    barColor:'#000',
    backgroundImage:'page3.jpg'
});
var tab3 = Titanium.UI.createTab({  
    icon:'d_nav.png',
    title:'Descartes',
    window:win3
});



//
// creates tab4
//
var win4 = Titanium.UI.createWindow({  
    title:'Plato',
    backgroundColor:'#fff',
    barColor:'#000',
    backgroundImage:'page4.jpg'
});
var tab4 = Titanium.UI.createTab({  
    icon:'p_nav.png',
    title:'Plato',
    window:win4
});


//
// creates tab5
//
var win5 = Titanium.UI.createWindow({  
    title:'Socrates',
    backgroundColor:'#fff',
    barColor:'#000',
    backgroundImage:'page5.jpg'
});
var tab5 = Titanium.UI.createTab({  
    icon:'s_nav.png',
    title:'Socrates',
    window:win5
});

///////////////////////////////////////////
/// Nietzsche
//////////////

var nbutton1 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:110,
      backgroundImage: 'button.png', 
      
});
var nbutton2 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:135,
      backgroundImage: 'button.png', 
      
});
var nbutton3 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:160,
      backgroundImage: 'button.png', 
      
});
var nbutton4 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:185,
      backgroundImage: 'button.png', 
      
});
var nbutton5 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:210,
      backgroundImage: 'button.png', 
      
});

var nbuttons = [nbutton1, nbutton2, nbutton3, nbutton4, nbutton5]

var nText = Titanium.UI.createTextArea({
    
    value:"To live is to suffer, to survive is to find some meaning in the suffering...",
    height:90,
    width:250,
    font:{fontSize:17},
    enabled:false,
    top:233,
    
});

var nQuotes = ["Morality is the herd-instinct in the individual...", "That which does not kill us, makes us stronger...", "Faith : not wanting to know what is true...", "One should die proudly when it is no longer possible to live proudly...", "To live is to suffer, to survive is to find some meaning in the suffering..."]


   function nextnQuote (nbuttons, selectednQuote){
    for (var i=0; i < nbuttons.length; i++) {
                
    if (nbuttons[i] == selectednQuote) {
        nText.value=nQuotes[i]; 
        

    };
        

  };
}

nbutton1.addEventListener('click',function(e)
{
    
  
    
            nextnQuote (nbuttons, nbutton1);
   
   
});
nbutton2.addEventListener('click',function(e)
{
   
   nextnQuote (nbuttons, nbutton2);
});
nbutton3.addEventListener('click',function(e)
{
	
   
   nextnQuote (nbuttons, nbutton3);
});
nbutton4.addEventListener('click',function(e)
{
   
   nextnQuote (nbuttons, nbutton4);
});
nbutton5.addEventListener('click',function(e)
{
   
   nextnQuote (nbuttons, nbutton5);
});

/////////////////////////////////////////
/// descartes
///////

var dbutton1 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:110,
      backgroundImage: 'button.png', 
      
});
var dbutton2 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:135,
      backgroundImage: 'button.png', 
      
});
var dbutton3 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:160,
      backgroundImage: 'button.png', 
      
});
var dbutton4 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:185,
      backgroundImage: 'button.png', 
      
});
var dbutton5 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:210,
      backgroundImage: 'button.png', 
      
});

var dbuttons = [dbutton1, dbutton2, dbutton3, dbutton4, dbutton5]

var dText = Titanium.UI.createTextArea({
    
    value:"I think; therefore I am...",
    height:90,
    width:250,
    font:{fontSize:17},
    enabled:false,
    top:233,
    
});

var dQuotes = ["I am accustomed to sleep and in my dreams to imagine the same things that lunatics imagine when awake...", "Travelling is almost like talking with those of other centuries...", "An optimist may see a light where there is none, but why must the pessimist always run to blow it out?..", "Except our own thoughts, there is nothing absolutely in our power...", "I think; therefore I am..."]


   function nextdQuote (dbuttons, selecteddQuote){
    for (var i=0; i < dbuttons.length; i++) {
                
    if (dbuttons[i] == selecteddQuote) {
        dText.value=dQuotes[i]; 
        

    };
        

  };
}

dbutton1.addEventListener('click',function(e)
{
    
  
    
   nextdQuote (dbuttons, dbutton1);
   
   
});
dbutton2.addEventListener('click',function(e)
{
   
   nextdQuote (dbuttons, dbutton2);
});
dbutton3.addEventListener('click',function(e)
{
   
   nextdQuote (dbuttons, dbutton3);
});
dbutton4.addEventListener('click',function(e)
{
   
   nextdQuote (dbuttons, dbutton4);
});
dbutton5.addEventListener('click',function(e)
{
   
   nextdQuote (dbuttons, dbutton5);
});




/////////////////////////////////////////
/// Plato
///////

var pbutton1 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:110,
      backgroundImage: 'button.png', 
      
});
var pbutton2 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:135,
      backgroundImage: 'button.png', 
      
});
var pbutton3 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:160,
      backgroundImage: 'button.png', 
      
});
var pbutton4 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:185,
      backgroundImage: 'button.png', 
      
});
var pbutton5 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:210,
      backgroundImage: 'button.png', 
      
});

var pbuttons = [pbutton1, pbutton2, pbutton3, pbutton4, pbutton5]

var pText = Titanium.UI.createTextArea({
    
    value:"A good decision is based on knowledge and not on numbers...",
    height:90,
    width:250,
    font:{fontSize:17},
    enabled:false,
    top:233,
    
});

var pQuotes = ["One of the penalties for refusing to participate in politics is that you end up being governed by your inferiors...", "Music is the movement of sound to reach the soul for the education of its virtue...", "If a man neglects education, he walks lame to the end of his life...", "At the touch of love everyone becomes a poet...", "A good decision is based on knowledge and not on numbers..."]


   function nextpQuote (pbuttons, selectedpQuote){
    for (var i=0; i < pbuttons.length; i++) {
                
    if (pbuttons[i] == selectedpQuote) {
        pText.value=pQuotes[i]; 
        

    };
        

  };
}

pbutton1.addEventListener('click',function(e)
{
    
  
    
   nextpQuote (pbuttons, pbutton1);
   
   
});
pbutton2.addEventListener('click',function(e)
{
   
   nextpQuote (pbuttons, pbutton2);
});
pbutton3.addEventListener('click',function(e)
{
   
   nextpQuote (pbuttons, pbutton3);
});
pbutton4.addEventListener('click',function(e)
{
   
   nextpQuote (pbuttons, pbutton4);
});
pbutton5.addEventListener('click',function(e)
{
   
   nextpQuote (pbuttons, pbutton5);
});




/////////////////////////////////////////
/// Socrates
///////

var sbutton1 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:110,
      backgroundImage: 'button.png', 
      
});
var sbutton2 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:135,
      backgroundImage: 'button.png', 
      
});
var sbutton3 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:160,
      backgroundImage: 'button.png', 
      
});
var sbutton4 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:185,
      backgroundImage: 'button.png', 
      
});
var sbutton5 = Titanium.UI.createButton({
      width:22,
      height:22,
      bottom:7,
      right:210,
      backgroundImage: 'button.png', 
      
});

var sbuttons = [sbutton1, sbutton2, sbutton3, sbutton4, sbutton5]

var sText = Titanium.UI.createTextArea({
    
    value:"An honest man is always a child...",
    height:90,
    width:250,
    font:{fontSize:17},
    enabled:false,
    top:233,
    
});

var sQuotes = ["Beauty is the bait which with delight allures man to enlarge his kind...", "Worthless people live only to eat and drink; people of worth eat and drink only to live...", "Let him that would move the world first move himself...", "As for me, all I know is that I know nothing...", "An honest man is always a child..."]

   function nextsQuote (sbuttons, selectedsQuote){
    for (var i=0; i < sbuttons.length; i++) {
                
    if (sbuttons[i] == selectedsQuote) {
        sText.value=sQuotes[i]; 
        

    };
        

  };
}

sbutton1.addEventListener('click',function(e)
{
    
  
    
   nextsQuote (sbuttons, sbutton1);
   
   
});
sbutton2.addEventListener('click',function(e)
{
   nextsQuote (sbuttons, sbutton2);
});
sbutton3.addEventListener('click',function(e)
{
   
   nextsQuote (sbuttons, sbutton3);
});
sbutton4.addEventListener('click',function(e)
{
   
   nextsQuote (sbuttons, sbutton4);
});
sbutton5.addEventListener('click',function(e)
{
   
   nextsQuote (sbuttons, sbutton5);
});





win2.add(nText);
win2.add(nbuttons);
win3.add(dText);
win3.add(dbuttons);
win4.add(pText);
win4.add(pbuttons);
win5.add(sText);
win5.add(sbuttons);

//
//  add tabs
//
tabGroup.addTab(tab1);  
tabGroup.addTab(tab2);
tabGroup.addTab(tab3);  
tabGroup.addTab(tab4);  
tabGroup.addTab(tab5);  
  


// open tab group
tabGroup.open();