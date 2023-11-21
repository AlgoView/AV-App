window.onload = function() {
  command.big('AlgoView');
  command.sub('AV-VISUALIZE');
  command.hid('V0.1 WEB');

  index.construct.get()
    .then(function() {
      return index.construct.build(); // this function adds scripts and styles to the page
    })
    .then(function() {
      return new Promise(function(resolve) {
        if (typeof layers !== 'undefined') {
          resolve(); // if layers is defined, continue immediately
        } else {
          setTimeout(resolve, 1000); // otherwise, wait for 1 second
        }
      });
    })
    .then(function() {
      return layers.get(); // this function tries to access an object that is not yet defined, but is loading because of the previous function
    })
    .then(function() {
      return layers.render();
    })
    .catch(function(error) {
      console.error(error);
    });
};

 

