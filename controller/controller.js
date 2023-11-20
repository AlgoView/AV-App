fadelenght = 150;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INTRODUCTION
	command.big('AlgoView');
	command.sub('AV-VISUALIZE');
	command.hid('V0.1 WEB');

// // PROCEDURE
window.onload = function() {
  index.construct.get()
    .then(function() {
      return index.construct.build();
    })
    .then(function() {
      return layers.get();
    })
    .then(function() {
      return layers.render();
    })
    .then(function() {
      
    })
    .catch(function(error) {
      console.error(error);
    });
};

 

