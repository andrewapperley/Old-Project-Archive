/**
* Created By Andrew Apperley
* 2012
*/
exports.info = function(str) {
    Titanium.API.info(new Date()+': '+str);
};

exports.debug = function(str) {
    Titanium.API.debug(new Date()+': '+str);
};