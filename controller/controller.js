fadelenght = 150;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INTRODUCTION
	command.big('AlgoView');
	command.sub('AV-VISUALIZE');
	command.hid('V0.1 WEB');

// // PROCEDURE
index.construct.get()
  .then(function() {
    return index.construct.build();
  })
  .then(function() {
    console.log('@controller layers.get()');
    return layers.get();
  })
  .then(function() {
    console.log('@controller layers.set()');
    return layers.set();
  })
  .then(function() {
    console.log('@controller layers.render()');
    return layers.render('barheader');
  })
  .catch(function(error) {
    console.error(error);
  });

 

